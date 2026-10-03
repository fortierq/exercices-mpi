#!/usr/bin/env python3
"""Compiler des copies privées en réutilisant les imports absolus de la banque."""

import argparse
import json
from contextlib import contextmanager
from pathlib import Path
import subprocess
from tempfile import TemporaryDirectory

ROOT = Path(__file__).resolve().parents[1]


@contextmanager
def source_copie(fichier):
    """Monter banque et copie par liens ; les fichiers privés restent hors de la banque."""
    fichier = Path(fichier).resolve(strict=True)
    if fichier.is_relative_to(ROOT):
        yield ROOT, fichier
        return
    temporaire = fichier.parent / 'tmp'
    temporaire.mkdir(exist_ok=True)
    with TemporaryDirectory(prefix='typst-', dir=temporaire) as dossier:
        racine = Path(dossier)
        for source in ROOT.iterdir():
            if not source.name.startswith('.') and source.name not in ('build', 'node_modules', 'copies', 'tmp'):
                (racine / source.name).symlink_to(source, target_is_directory=source.is_dir())
        # Tous les fichiers voisins (JSON, figures...) gardent leurs chemins relatifs.
        (racine / '_copie').symlink_to(fichier.parent, target_is_directory=True)
        # Typst exige une entrée physique dans sa racine, mais autorise les imports liés.
        entree = racine / 'entree.typ'
        entree.write_text('#include ' + json.dumps('/_copie/' + fichier.name) + '\n', encoding='utf-8')
        yield racine, entree


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--typst', default='typst')
    parser.add_argument('copies', nargs='+', type=Path)
    args = parser.parse_args()
    for fichier in args.copies:
        fichier = fichier.resolve(strict=True)
        sortie = fichier.parent / 'build' / fichier.stem
        sortie.mkdir(parents=True, exist_ok=True)
        with source_copie(fichier) as (racine, source):
            for variante in ('enonce', 'corrige'):
                subprocess.run([args.typst, 'compile', '--root', str(racine), '--ignore-system-fonts',
                                '--input', f'corrige={str(variante == "corrige").lower()}',
                                str(source), str(sortie / f'{variante}.pdf')], check=True)
        print(f'PDF générés : {sortie}')


if __name__ == '__main__':
    main()
