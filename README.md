# Exercices MPI en Typst

Banque d'exercices MPI en Typst.

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

Un fichier `exercices/<chapitre>/<identifiant>.typ` exporte un objet `ex`. Son identifiant, déduit du nom de fichier, est unique dans la banque. Une feuille importe ces objets sous des alias et les assemble. Les sujets de concours utilisent la même API et exportent eux aussi `ex`.

Les métadonnées et les conventions de contenu sont décrites dans [AGENTS.md](AGENTS.md). Le vocabulaire autorisé est résumé dans [docs/programme.md](docs/programme.md).

## Extension VS Code

Installer le dernier VSIX de `/Users/qfortier/repo/vscode-exercices-mpi/releases/` dans VS Code, avec **Extensions: Install from VSIX...**, puis ouvrir ce dépôt. L'extension **Exercices Typst** fournit les vues de la banque, la composition des feuilles et les aperçus d'énoncé et de corrigé. Tinymist améliore l'aperçu Typst mais reste facultatif.

## Codespaces

Sur GitHub, choisir **Code** puis **Create codespace on main**. Le Codespace utilise [`.devcontainer/devcontainer.json`](.devcontainer/devcontainer.json) : il installe Nix, Tinymist et l'extension **Exercices Typst**. Après la création, ouvrir le terminal intégré et lancer la vérification ci-dessous.

## Compiler

Depuis la racine du dépôt :

```sh
nix develop path:. -c make check
```

Cette commande compile les énoncés, corrigés, feuilles, sujets et modèles, valide les métadonnées et l'unicité des identifiants, puis lance les tests associés. Les résultats sont placés dans `build/`.

Pour travailler sans Nix, installer Typst, GNU Make, Python 3 et OCaml, puis lancer `make check`.

## Ajouter du contenu

Partir des modèles de `templates/`, conserver les ressources et tests dans `ressources/<identifiant>/`, puis lancer `make check`. Les feuilles sont découvertes automatiquement ; le Makefile n'a pas à être modifié.
