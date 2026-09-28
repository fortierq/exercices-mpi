# Exercices MPI en Typst

Banque d’exercices et de feuilles réutilisables. Un exercice contient son énoncé,
son corrigé et ses métadonnées ; une feuille choisit les exercices et leur ordre.

## Démarrer

Avec Nix et les flakes activés :

```sh
nix develop path:. -c make check
```

Cette commande compile les énoncés, corrigés, feuilles et modèles, puis valide le
catalogue. `path:.` tient compte des nouveaux fichiers non suivis par Git. Pour
travailler dans un shell, lancer `nix develop path:.`, puis `make` ou `make check`.
Le fichier `flake.lock` fixe notamment Typst 0.15.1. Sans Nix, installer Typst
(version 0.15.1 ou ultérieure), GNU Make et Python 3, puis lancer `make check`.

## Organisation

| Chemin | Rôle |
| --- | --- |
| `exercices/<chapitre>/<identifiant>.typ` | Un exercice exportant `ex` |
| `feuilles/<nom>.typ` | Une feuille assemblant des exercices |
| `templates/exercice.typ` | Modèle d’exercice à copier |
| `templates/feuille.typ` | Modèle de feuille à copier |
| `templates/fiche.typ` | Point d’entrée pour compiler un exercice seul |
| `lib/exercices.typ` | API et mise en page communes |
| `lib/meta.typ` | Étiquettes et valeurs de concours admises |
| `docs/programme.md` | Règles de classement selon le programme |
| `build/` | Documents et catalogue générés, ignorés par Git |

Les imports commençant par `/`, comme `#import "/lib/exercices.typ"`, utilisent la
racine Typst définie par `--root .`. Lancer les commandes depuis ce dépôt.

## Écrire un exercice

```sh
mkdir -p exercices/graphes
cp templates/exercice.typ exercices/graphes/detection-cycle.typ
```

Adapter le titre, les métadonnées, l’énoncé et le corrigé dans le fichier copié.
Chaque fichier exporte `ex`. Son identifiant est le nom du fichier sans `.typ` :
il doit être unique dans toute la banque et ne se renseigne pas dans `meta`.
Les exercices existants montrent d’autres usages de `question(...)` et du texte
libre dans `contenu`.

Les champs obligatoires sont `titre`, `chapitres`, `algorithmes`, `structures`,
`langages` et `difficulte` (de 1 à 5). `niveaux`, `duree` et `concours` sont
facultatifs. `langages: ()` convient à un exercice sans programmation ; pour
les niveaux MP2I et MPI, les valeurs admises sont `"C"`, `"OCaml"` et `"Python"`.
Les étiquettes autorisées et les concours figurent dans `lib/meta.typ` ;
`docs/programme.md` explique leur choix. L’API et les contrôles sont dans
`lib/exercices.typ`.

La numérotation des questions commence à 1, ou à 0 avec `debut: 0`. Une solution
omise apparaît comme « Corrigé à compléter » dans la version corrigée. Du texte
libre peut figurer avant, entre ou après les questions.

## Composer une feuille

Copier `templates/feuille.typ` dans `feuilles/`, puis remplacer ses imports par
les exercices voulus. Par exemple :

```typst
#import "/lib/exercices.typ": feuille
#import "/exercices/langages/ensembles-inevitables.typ": ex as mots

#show: feuille.with(
  titre: "TD — Langages",
  niveau: "MPI",
  exercices: (mots,),
  corrige: sys.inputs.at("corrige", default: "false") == "true",
  details: false,
)
```

`details` affiche ou masque la difficulté, la durée et le concours sur le
document ; les métadonnées restent disponibles dans le catalogue. Le corps
après `#show` sert aux consignes de la feuille.

## Compiler et prévisualiser

```sh
make                                      # Exercices, feuilles et catalogue
make check                                # Inclut la compilation des modèles
make build/exercices/langages/ensembles-inevitables/enonce.pdf
make build/feuilles/langages-corrige.pdf
make w E=langages/ensembles-inevitables C=true
make wf F=langages C=true
```

Les cibles `w` et `wf` recompilent à chaque modification et ouvrent l’aperçu
dans VS Code. Passer `O=0` pour désactiver l’ouverture. Les exercices et feuilles
sont découverts automatiquement ; aucun ajout au Makefile n’est nécessaire.

Pour une compilation directe, par exemple sans détails dans l’énoncé :

```sh
typst compile --root . --ignore-system-fonts \
  --input exercice=/exercices/langages/ensembles-inevitables.typ \
  --input details=false templates/fiche.typ build/enonce-sans-details.pdf
```

## Trouver des exercices

```sh
make catalogue
python3 scripts/catalogue.py --langage OCaml
python3 scripts/catalogue.py --chapitre automates-finis --difficulte-max 4
python3 scripts/catalogue.py --concours 'ENS Ulm' --sortie build/selection.json
```

Les filtres utilisent des valeurs exactes et se combinent par « et ». Le champ
`fichier` indique quoi importer dans une feuille. Le catalogue valide les
métadonnées et refuse les identifiants dupliqués.

Les consignes de modification destinées aux assistants figurent dans
[AGENTS.md](AGENTS.md).
