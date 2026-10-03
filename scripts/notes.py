#!/usr/bin/env python3
"""Exporter les notes des copies Typst dans un CSV de classe (séparateur ;)."""

import argparse
import csv
import json
from pathlib import Path
import subprocess
from statistics import pstdev
from copies import source_copie


def identite(eleve):
    return tuple(eleve[k].strip().casefold() for k in ('classe', 'nom', 'prenom'))


def tableau(eleves, copies):
    """Rapprocher par identité, jamais par position ; les notes manquantes restent vides."""
    if not copies:
        raise ValueError('Indiquer au moins une copie pour définir les colonnes du sujet.')
    reference = copies[0]
    questions = [(q['cle'], q['points']) for q in reference['questions']]
    index = {}
    for copie in copies:
        if copie['feuille'] != reference['feuille'] or questions != [(q['cle'], q['points']) for q in copie['questions']]:
            raise ValueError('Les copies doivent correspondre au même sujet et au même barème.')
        cle = identite(copie)
        if cle in index:
            raise ValueError('Deux copies pour la même identité.')
        index[cle] = copie
    identites = [identite(e) for e in eleves]
    if len(set(identites)) != len(identites):
        raise ValueError('Identité dupliquée dans la liste de classe.')
    if set(index) - set(identites):
        raise ValueError('Une copie ne correspond à aucun élève de la liste.')
    entete = ['classe', 'nom', 'prenom', 'feuille', 'statut', 'note_brute', 'bareme_total']
    for cle, _ in questions:
        entete += [f'{cle}_reussite_pct', f'{cle}_points', f'{cle}_commentaire']
    entete += ['appreciation', 'copie_source']
    lignes = []
    for eleve in eleves:
        copie = index.get(identite(eleve))
        ligne = {**eleve, 'feuille': reference['feuille'], 'statut': 'non corrigée'}
        if copie:
            ligne.update(statut='corrigée' if copie['complet'] else 'incomplète',
                         note_brute=copie['total'], bareme_total=copie['maximum'],
                         appreciation=copie['appreciation'], copie_source=copie['source'])
            for q in copie['questions']:
                ligne.update({f"{q['cle']}_reussite_pct": q['reussite'],
                              f"{q['cle']}_points": q['obtenus'],
                              f"{q['cle']}_commentaire": q['commentaire']})
        lignes.append(ligne)
    return entete, lignes


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--classe', type=Path, required=True,
                        help='CSV sans en-tête : classe;nom;prenom;... (les coordonnées sont ignorées)')
    parser.add_argument('--sortie', type=Path, required=True)
    parser.add_argument('--typst', default='typst')
    parser.add_argument('copies', nargs='+', type=Path)
    args = parser.parse_args()
    with args.classe.open(encoding='utf-8-sig', newline='') as source:
        eleves = [dict(zip(('classe', 'nom', 'prenom'), ligne[:3]))
                  for ligne in csv.reader(source, delimiter=';') if ligne]
    copies = []
    for fichier in args.copies:
        with source_copie(fichier) as (racine, source):
            result = subprocess.run(
                [args.typst, 'query', '--root', str(racine), '--ignore-system-fonts',
                 '--input', 'corrige=true', str(source), '<copie-notes>', '--field', 'value', '--one'],
                check=True, capture_output=True, text=True)
        copies.append(json.loads(result.stdout))
    entete, lignes = tableau(eleves, copies)
    args.sortie.parent.mkdir(parents=True, exist_ok=True)
    temporaire = args.sortie.with_suffix('.csv.tmp')
    with temporaire.open('w', encoding='utf-8-sig', newline='') as sortie:
        writer = csv.DictWriter(sortie, fieldnames=entete, delimiter=';', lineterminator='\n')
        writer.writeheader()
        for ligne in lignes:
            # Virgule décimale pour les tableurs en français ; aucune formule CSV.
            writer.writerow({k: str(round(v, 6)).replace('.', ',') if isinstance(v, float) else v
                             for k, v in ligne.items()})
    temporaire.replace(args.sortie)
    statistiques = moyennes(eleves, copies)
    sortie_moyennes = args.sortie.with_suffix('.moyennes.json')
    temporaire = sortie_moyennes.with_suffix('.json.tmp')
    temporaire.write_text(json.dumps(statistiques, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    temporaire.replace(sortie_moyennes)
    print(f'{len(lignes)} élèves, {len(copies)} copie(s) exportée(s) : {args.sortie}')


def moyennes(eleves, copies):
    """Moyenne par question : zéros inclus, évaluations absentes exclues."""
    tableau(eleves, copies)  # Même contrôle des identités, du sujet et du barème que le CSV.
    questions = {}
    for i, question in enumerate(copies[0]['questions']):
        valeurs = [c['questions'][i]['reussite'] for c in copies
                   if c['questions'][i]['reussite'] is not None]
        questions[question['cle']] = {
            'moyenne': sum(valeurs) / len(valeurs) if valeurs else None,
            'sigma': pstdev(valeurs) if valeurs else None,
            'effectif': len(valeurs),
        }
    return {'feuille': copies[0]['feuille'], 'effectif-classe': len(eleves),
            'effectif': sum(any(q['reussite'] is not None for q in c['questions']) for c in copies),
            'questions': questions}


if __name__ == '__main__':
    main()
