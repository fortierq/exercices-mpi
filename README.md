# Exercices MPI en Typst

Banque d'exercices MPI en Typst.

## Organisation

```text
lib/             API Typst partagée et validation des métadonnées
templates/       Modèles d'exercice, TD, devoir et concours
exercices/       Classement actuel des exercices (facultatif)
feuilles/        Classement actuel des TD (facultatif)
concours/        Classement actuel des sujets complets (facultatif)
ressources/      Code, tests et ressources associés aux exercices
docs/            Notes de conversion et résumé du programme
scripts/         Génération et filtrage du catalogue
build/           PDF et catalogue générés (ignorés par Git)
```

Les dossiers sont libres. Un exercice exporte `ex` ; son nom de fichier est son identifiant, unique dans la banque. Tous les documents utilisent `feuille.with(type: "td", ...)`, avec le type `td`, `devoir`, `concours` ou un type personnalisé. Les points se placent dans chaque `question(..., points: ...)`.

Voir le [guide utilisateur](docs/utilisation.md) pour créer exercices, documents et types personnalisés. L'API est documentée dans le code pour Tinymist ; `make docs` génère la référence Tidy dans `build/docs/api.pdf`. [AGENTS.md](AGENTS.md) ne contient que les consignes propres aux assistants.

## Extension VS Code

Installer le dernier VSIX de `/Users/qfortier/repo/vscode-exercices-mpi/releases/` dans VS Code, avec **Extensions: Install from VSIX...**, puis ouvrir ce dépôt. L'extension **Exercices Typst** fournit les vues de la banque, la composition des feuilles et les aperçus d'énoncé et de corrigé. Tinymist est recommandé pour l'aide au survol et l'aperçu, mais reste facultatif.

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

Partir des modèles de `templates/`, conserver les ressources et tests dans `ressources/<identifiant>/`, puis lancer `make check`. Exercices et documents sont découverts par leur contenu, quel que soit leur dossier ; le Makefile n'a pas à être modifié.
