"""Vérifier le rapprochement des élèves et la distinction entre zéro et absence."""
from copy import deepcopy
from pathlib import Path
import sys
import unittest
from tempfile import TemporaryDirectory

sys.path.insert(0, str(Path(__file__).resolve().parents[2] / 'scripts'))
from notes import tableau, moyennes
from copies import source_copie, ROOT


class NotesTest(unittest.TestCase):
    def test_source_privee_et_nettoyage(self):
        with TemporaryDirectory() as dossier:
            fichier = Path(dossier) / 'eleve.typ'
            fichier.write_text('Test fictif', encoding='utf-8')
            with source_copie(fichier) as (racine, source):
                self.assertEqual(source.read_text(), '#include "/_copie/eleve.typ"\n')
                self.assertEqual((racine / '_copie/eleve.typ').read_text(), 'Test fictif')
                self.assertEqual((racine / 'lib').resolve(), ROOT / 'lib')
                self.assertFalse(racine.is_relative_to(ROOT))
            self.assertFalse(racine.exists())
        with source_copie(ROOT / 'templates/copie.typ') as (racine, source):
            self.assertEqual(racine, ROOT)
            self.assertEqual(source, ROOT / 'templates/copie.typ')

    def setUp(self):
        self.eleve = dict(classe='MPI', nom='Exemple', prenom='Alice')
        self.autre = dict(classe='MPI', nom='Autre', prenom='Bob')
        self.copie = dict(**self.eleve, feuille='sujet.typ', complet=True,
                          total=0, maximum=2, appreciation='À reprendre', source='',
                          questions=[dict(cle='1.1', points=2, reussite=0, obtenus=0, commentaire='Absent')])

    def test_zero_et_absence(self):
        _, lignes = tableau([self.autre, self.eleve], [self.copie])
        self.assertNotIn('note_brute', lignes[0])
        self.assertEqual(lignes[1]['note_brute'], 0)
        self.assertEqual(lignes[1]['1.1_commentaire'], 'Absent')

    def test_incomplet(self):
        self.copie.update(complet=False, total=None)
        _, lignes = tableau([self.eleve], [self.copie])
        self.assertEqual(lignes[0]['statut'], 'incomplète')
        self.assertIsNone(lignes[0]['note_brute'])

    def test_moyennes_zero_et_absence(self):
        autre = deepcopy(self.copie)
        autre.update(self.autre)
        autre['questions'][0]['reussite'] = 100
        stats = moyennes([self.eleve, self.autre], [self.copie, autre])
        self.assertEqual(stats['questions']['1.1'], {'moyenne': 50, 'effectif': 2})
        autre['questions'][0]['reussite'] = None
        stats = moyennes([self.eleve, self.autre], [self.copie, autre])
        self.assertEqual(stats['questions']['1.1'], {'moyenne': 0, 'effectif': 1})
        self.assertEqual(stats['effectif-classe'], 2)
        self.copie['questions'][0]['reussite'] = None
        stats = moyennes([self.eleve, self.autre], [self.copie, autre])
        self.assertEqual(stats['questions']['1.1'], {'moyenne': None, 'effectif': 0})

    def test_doublons_et_inconnus(self):
        for eleves, copies in [([self.eleve] * 2, [self.copie]),
                               ([self.eleve], [self.copie] * 2),
                               ([self.autre], [self.copie])]:
            with self.assertRaises(ValueError):
                tableau(eleves, copies)

    def test_sujet_et_bareme(self):
        autre = deepcopy(self.copie)
        autre.update(self.autre)
        autre['questions'][0]['points'] = 3
        with self.assertRaises(ValueError):
            tableau([self.eleve, self.autre], [self.copie, autre])
        autre = dict(self.copie, **dict(feuille='autre.typ'))
        with self.assertRaises(ValueError):
            tableau([self.eleve], [self.copie, autre])


if __name__ == '__main__':
    unittest.main()
