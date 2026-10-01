# Exercices MPI en Typst

Banque d'exercices Typst indépendante des feuilles qui les composent. Les
exercices, feuilles et sujets de concours produisent des énoncés et corrigés.

## Organisation

```text
lib/             API Typst partagée et validation des métadonnées
templates/       Modèles d'exercice, feuille, fiche et sujet de concours
exercices/       Exercices réutilisables, classés par chapitre
feuilles/        Feuilles qui importent les exercices dans l'ordre voulu
concours/        Sujets complets, classés par année
ressources/      Code, tests et ressources associés aux exercices
docs/            Notes de conversion et résumé du programme
scripts/         Génération et filtrage du catalogue
build/           PDF et catalogue générés (ignorés par Git)
```

Un fichier `exercices/<chapitre>/<identifiant>.typ` exporte un objet `ex`.
Son identifiant, déduit du nom de fichier, est unique dans la banque. Une
feuille importe ces objets sous des alias et les assemble. Les sujets de
concours utilisent la même API et exportent eux aussi `ex`.

Les métadonnées et les conventions de contenu sont décrites dans
[AGENTS.md](AGENTS.md). Le vocabulaire autorisé est résumé dans
[docs/programme.md](docs/programme.md).

## Compiler

Depuis la racine du dépôt :

```sh
nix develop path:. -c make check
```

Cette commande compile les énoncés, corrigés, feuilles, sujets et modèles,
valide les métadonnées et l'unicité des identifiants, puis lance les tests
associés. Les résultats sont placés dans `build/`.

Pour travailler sans Nix, installer Typst, GNU Make, Python 3 et OCaml, puis
lancer `make check`.

## Ajouter du contenu

Partir des modèles de `templates/`, conserver les ressources et tests dans
`ressources/<identifiant>/`, puis lancer `make check`. Les feuilles sont
découvertes automatiquement ; le Makefile n'a pas à être modifié.
