# Exercices MPI en Typst

Une banque d’exercices indépendante des feuilles : chaque exercice décrit ses
métadonnées et une suite de textes libres et de questions avec leurs solutions. Les feuilles
importent ces objets dans l’ordre souhaité. Les sujets de concours réunissent
des parties dont on peut extraire les exercices. Les figures utilisent CeTZ et
finite, avec des versions fixées. Aucune base de données ni dépendance Python à installer.

## Démarrer

Avec Nix et les flakes activés :

```sh
nix develop path:.
make                 # Énoncés, corrigés, feuilles et catalogue dans build/
make check           # Vérifie aussi que les modèles compilent
```

Ou, sans ouvrir de shell :

```sh
nix develop path:. -c make check
```

`path:.` inclut les nouveaux fichiers même s’ils ne sont pas encore suivis par
Git. Une fois les fichiers ajoutés à Git, `nix develop` fonctionne aussi.
`flake.lock` verrouille les versions, dont **Typst 0.15.1**. Le shell fournit
Typst, GNU Make, Python 3 et OCaml, sur macOS et Linux (Intel et ARM).
Pour mettre à jour volontairement : `nix flake update --flake path:.`, puis `make check`.

Sans Nix, installer ces quatre outils (Typst 0.15.1 ou ultérieur), puis utiliser
les mêmes commandes Make. Avec direnv et nix-direnv, le fichier `.envrc` est
également fourni ; son activation par `direnv allow` est facultative.

## Organisation

```text
lib/exercices.typ                           API et mise en page partagées
templates/exercice.typ               Exercice minimal à copier
templates/fiche.typ                           Point d’entrée pour un exercice isolé
templates/feuille.typ                         Feuille minimale à copier
templates/sujet-concours.typ                  Sujet minimal à copier
concours/22/centrale-2022-mp-informatique.typ   Sujet complet, 50 questions corrigées
ressources/centrale-2022-mp-informatique/    Code OCaml et tests du sujet
exercices/langage/ensembles-inevitables.typ  Métadonnées, énoncé et corrigé convertis
docs/ensembles-inevitables-migration.md      Provenance et corrections de la source
feuilles/langages.typ                       Exemple de feuille réutilisant l’exercice
scripts/catalogue.py                        Export et filtrage des métadonnées
build/                                     Sorties générées, ignorées par Git
```

Les chemins dans `#import "/lib/…"` sont relatifs à la **racine Typst**,
fixée par `--root .`, et non à la racine du système. Lancer les commandes depuis
ce dépôt ; configurer également la racine du projet dans l’éditeur Typst.

## Écrire un exercice

```sh
mkdir -p exercices/graphes
cp templates/exercice.typ exercices/graphes/detection-cycle.typ
```

Modifier son titre, ses métadonnées et ses questions. Utiliser des noms de dossiers et
fichiers sans espaces, de préférence en minuscules avec des tirets. L'identifiant
exporté est le nom du fichier sans l'extension `.typ` et doit être unique dans toute la
banque. Chaque fichier `exercices/<chapitre>/<identifiant>.typ` exporte `ex`.
Les fichiers Typst de ces dossiers sont tous des exercices ; placer les éventuels
modules auxiliaires hors de `exercices/`.

```typst
#import "/lib/exercices.typ": exercice, question

#let ex = exercice(
  meta: (
    titre: "Détecter un cycle",
    chapitres: ("graphes",),
templates/exercice.typ              Exercice minimal à copier
templates/fiche.typ                           Point d’entrée pour un exercice isolé
templates/feuille.typ                         Feuille minimale à copier
templates/sujet-concours.typ                  Sujet minimal à copier
    niveaux: ("MPI",),
    concours: none,
  ),
  contenu: (
    [On considère un graphe orienté $G$.],
    question(
      [Proposer un algorithme de détection de cycle.],
      solution: [Effectuer un parcours en profondeur avec trois couleurs.],
    ),
    [On suppose désormais que $G$ est représenté par des listes d’adjacence.],
    question([Justifier sa complexité.]),
  ),
)
cp templates/exercice.typ exercices/graphes/detection-cycle.typ

Une virgule finale est nécessaire pour les tableaux d’un seul élément, comme
`("graphes",)` ou `(ex,)`. Les questions commencent à 1 ; `debut: 0` conserve
une numérotation commençant à 0. La numérotation est locale à chaque exercice.
Une solution omise reste invisible sur l’énoncé et devient « Corrigé à compléter »
Copier `templates/feuille.typ` vers `feuilles/ma-feuille.typ`, puis importer les

`contenu` est une suite ordonnée : `[texte libre]` peut apparaître avant, entre
ou après les appels à `question(...)`. Seules les questions sont numérotées ;
Copier `templates/sujet-concours.typ` dans `concours/19/mon-sujet.typ`. Le fichier

Les notes de conversion se placent dans `docs/`. Si un exercice nécessite des
images ou des modules Typst auxiliaires, les placer dans
`ressources/<identifiant>/`, créé uniquement si nécessaire. Utiliser des chemins
relatifs au fichier qui les importe, ou des chemins depuis la racine Typst.
et le template de compilation (`templates/fiche.typ`) sont les mêmes.
tableaux, etc.

### Métadonnées

  --input exercice=/concours/19/mon-sujet.typ templates/fiche.typ build/mon-sujet.pdf
| --- | --- | --- |
| `id` | chaîne, obligatoire | Stable et unique, indépendante du chemin |
| `titre` | chaîne, obligatoire | Titre lisible |
| `chapitres` | tableau de chaînes, obligatoire | Ex. `"automates-finis"`, `"graphes"` |
  --input details=false templates/fiche.typ build/enonce-sans-details.pdf
| `structures` | tableau de chaînes, obligatoire | `()` si aucune |
| `langages` | tableau, obligatoire | Langages utilisés : `("C",)`, `("OCaml",)`, `("Python",)` ; `()` sans programmation |
| `difficulte` | entier de 1 à 5, obligatoire | Estimation pédagogique |
| `niveaux` | tableau de chaînes | `()`, `("MPI",)`, `("MP", "MPI")`… |
| `duree` | couple `(heures, minutes)` ou `none` | Durée positive, entiers avec `0 ≤ minutes < 60` ; affichage « 3 h », « 1 h 30 min », « 20 min » |
| `concours` | dictionnaire ou `none` | `nom`, `annee`, `filiere` (par défaut : `"MPI"`) ; valeurs dans `lib/meta.typ` |

Échelle proposée : 1 = application directe ; 2 = exercice standard ;
3 = plusieurs idées à combiner ; 4 = exercice difficile ; 5 = très difficile.
La difficulté 4 de l’exercice converti est une estimation éditoriale.

Noter les graphes $G = (S, A)$ : $S$ désigne les sommets et $A$ les arcs
(ou les arêtes pour un graphe non orienté), dans les énoncés et les corrigés.

Le champ `langages` recense les langages de programmation effectivement utilisés
dans l’énoncé ou le corrigé. Pour les niveaux `MP2I` ou `MPI`, le constructeur
accepte uniquement `"C"`, `"OCaml"` et `"Python"` (casse exacte). Cette restriction
est une convention de la banque. Un exercice purement théorique ou formulé en
pseudocode utilise `langages: ()`. Les langages formels restent dans `chapitres`.

Réutiliser les mêmes étiquettes en minuscules avec des tirets pour faciliter la
recherche. Les chapitres, algorithmes et structures doivent appartenir au vocabulaire validé de
`lib/programme.typ`, issu du [programme MP2I–MPI](https://prepas.org/index.php?document=73).
Voir [les règles de classement](docs/programme.md) pour ajouter une étiquette.
Les champs supplémentaires sont autorisés : `source`, `auteur`, `references`, etc.
Leurs valeurs doivent être sérialisables en JSON (pas de contenu Typst ni de
fonctions). Les métadonnées sont définies **une seule fois**, dans l’exercice ;
le catalogue n’est jamais à modifier à la main.

## Composer une feuille

Copier `templates/feuille.typ` vers `feuilles/ma-feuille.typ`, puis importer les
exercices sous des alias :

```typst
#import "/lib/exercices.typ": feuille
#import "/exercices/langage/ensembles-inevitables.typ": ex as mots
#import "/exercices/graphes/detection-cycle.typ": ex as cycles

#show: feuille.with(
  titre: "TD — Langages et graphes",
  niveau: "MPI",
  exercices: (mots, cycles),
  corrige: sys.inputs.at("corrige", default: "false") == "true",
  details: false,
  nouvelle-page: true,
)

Justifier les algorithmes et analyser leur complexité.
```

`details` contrôle l’affichage de la difficulté, de la durée et du concours.
Les étiquettes de chapitres, algorithmes et structures restent dans le catalogue. `nouvelle-page` impose un saut de page entre exercices. Le corrigé
reprend chaque question suivie de sa solution. Le corps après `#show` sert aux
consignes de la feuille. Les règles communes sont dans `lib/exercices.typ`.

La présentation s’inspire des classes `exam.cls` et `exercise.cls` et du fichier
`code.sty` du dépôt `texmf` : police New Computer Modern, en-tête à trois parties
avec filet horizontal, textes libres sans encadrement et solutions accompagnées d’un trait latéral,
code sur fond blanc entre deux filets. `niveau` et `auteur` (facultatifs) règlent
les côtés gauche et droit de l’en-tête ; le titre occupe le centre. L’en-tête est
affiché uniquement sur la première page. Il n’y a pas de sous-titre ; le corrigé
ajoute « : corrigé » au titre. Les titres des exercices sont en gras ; le corps et les numéros des questions
restent sans gras. Les solutions sont présentées sans icône ni libellé « Solution ». Les fichiers LaTeX ne sont pas nécessaires à la compilation.

## Sujets de concours et extraits

Copier `templates/sujet-concours.typ` dans `concours/19/mon-sujet.typ`. Le fichier
exporte `ex`, construit avec `exercice`, comme tout exercice de la banque.
Son `contenu` mêle des textes, des `question` et des `partie`.
Les dossiers `concours/` et `exercices/` servent au classement ; le type de données
et le modèle de compilation (`templates/fiche.typ`) sont les mêmes.
Les définitions et consignes initiales sont de simples blocs de texte au début
de `contenu`, comme dans un exercice. Tout le sujet (parties, corrections et
figures) tient dans un seul fichier Typst. Les parties peuvent contenir des
sous-parties : `partie("I.B", "Palindromes", contenu: (…))` indique simplement
le numéro et le titre affichés. La variable exportée permet la réutilisation,
indépendamment de cette numérotation.
La mise en page utilise directement `feuille` et `afficher-exercice` de
`lib/exercices.typ`, y compris les titres, les métadonnées et les solutions.
La numérotation des questions est continue dans le sujet, sous la forme « 1. », comme dans les exercices.

Le paramètre facultatif `corrections` de `exercice` contient une simple liste des
parties/questions corrigées. Le corrigé affiche « Correction par rapport à l’énoncé
initial : » puis cette liste, sans détailler les erreurs. Les explications restent
dans la documentation ou les commentaires du fichier.

Le paramètre `remarques` contient ensuite les commentaires généraux du jury,
sous forme de liste en italique, sans titre ni source affichée.
Les sources et les pages restent dans les commentaires du fichier ou la documentation.

Les paramètres `commentaire` de `partie` et de `question` permettent de placer une
observation du jury immédiatement après le titre de la partie ou après la question,
avant la solution. Tous les commentaires du jury sont en italique et apparaissent
uniquement dans le corrigé. Privilégier les citations exactes et courtes ; une
reformulation ou une synthèse est possible pour rester concis et utile.

Les blocs libres de `contenu` (préliminaires, définitions, notations et contexte)
sont masqués dans le corrigé. Les titres de parties, questions, commentaires et
solutions restent affichés. Les figures des questions et solutions sont conservées.

Les sujets sont rangés par année sur deux chiffres dans `concours/` ;
`make concours` recherche aussi les sous-dossiers.

```sh
make concours
make build/concours/22/centrale-2022-mp-informatique/corrige.pdf
typst compile --root . --ignore-system-fonts \
  --input exercice=/concours/19/mon-sujet.typ templates/fiche.typ build/mon-sujet.pdf
```

Pour partager une partie, la définir dans une variable exportée du sujet,
puis placer cette variable dans son `contenu`. C’est le cas de `palindromes`
dans Centrale : le sujet et l’exercice utilisent exactement le même objet.
L’exercice autonome ajoute les rappels nécessaires et ses métadonnées :

```typst
#import "/lib/exercices.typ": exercice
#import "/concours/22/centrale-2022-mp-informatique.typ": palindromes

#let ex = exercice(
  meta: (..palindromes.meta, titre: palindromes.titre, niveaux: ("MPI", "MP")),
  contenu: palindromes.contexte + palindromes.contenu,
)
```

Aucune recherche par numéro ni copie des questions ou solutions n’est nécessaire.
Le fichier `exercices/langages/palindromes-et-rationalite.typ` conserve son nom
pour les imports existants et réutilise ainsi les sept questions de I.B.

L’exercice autonome commence à 1 par défaut ; `exercice(debut: 6, …)` permet
un autre départ. Les questions suivent la convention de la banque (`1.`, `2.`, etc.) ;
adapter les renvois du PDF lors de la conversion.

Le champ `contexte` d’une partie contient les rappels utiles hors du sujet.
L’exercice les ajoute explicitement à son `contenu`, comme dans l’exemple ci-dessus.
Il précise ses métadonnées, dont sa durée éventuelle, et conserve l’attribution au concours.

Les figures du sujet Centrale 2022 et de son corrigé sont définies dans le
fichier du sujet et générées en Typst. Les
fragments OCaml affichés proviennent de `ressources/centrale-2022-mp-informatique/corrige.ml`,
testé par `test.ml` dans le même dossier ; `test.typ` vérifie le sujet et la partie partagée.
Ces tests sont lancés par `make check`. Une correction du code se répercute dans le
document. Les notions de Brzozowski, Conway et Antimirov sont introduites dans
le sujet ; leurs solutions utilisent les outils du programme.

## Compiler et travailler en continu

```sh
make exercices                         # Tous les exercices, avec et sans corrigé
make feuilles                          # Toutes les feuilles, avec et sans corrigé
make build/exercices/langage/ensembles-inevitables/enonce.pdf
make build/feuilles/langages-corrige.pdf
make watch E=langage/ensembles-inevitables
make watch E=langage/ensembles-inevitables C=true
make watch-feuille FEUILLE=langages C=true
make clean
```

Les modes `watch` ouvrent le PDF dans la fenêtre VS Code existante et recompilent à chaque modification et produisent un PDF
`apercu.pdf` / `langages-apercu.pdf` distinct des sorties de publication.
Sur macOS, cette ouverture utilise `open -a "Visual Studio Code"`, sans script
intermédiaire. Sur Linux, elle utilise `code --reuse-window`. Un visualiseur PDF
dans VS Code est nécessaire (par exemple `vscode-pdf` ou LaTeX Workshop).
La commande peut être remplacée avec `O_PDF='code --reuse-window'`.
Passer `O=0` pour désactiver l’ouverture.
Les exercices et feuilles sont découverts automatiquement : aucun ajout au
Makefile n’est nécessaire. Les feuilles sont placées directement dans `feuilles/`.
Éviter les noms de feuilles finissant par `-corrige`, suffixe réservé aux sorties.

La compilation Make est volontairement conservatrice : un changement dans les
sources ou les ressources peut reconstruire plusieurs documents. `typst watch`
offre un retour plus rapide pour le travail quotidien. Les polices utilisées sont
celles embarquées dans Typst ; `--ignore-system-fonts` évite de dépendre des polices
installées sur la machine.

Compilation directe, par exemple pour masquer les métadonnées sur l’énoncé :

```sh
typst compile --root . --ignore-system-fonts \
  --input exercice=/exercices/langage/ensembles-inevitables.typ \
  --input details=false templates/fiche.typ build/enonce-sans-details.pdf
```

## Trouver des exercices

```sh
make catalogue                         # build/catalogue.json
python3 scripts/catalogue.py --langage OCaml
python3 scripts/catalogue.py --chapitre automates-finis
python3 scripts/catalogue.py --algorithme parcours-en-profondeur --difficulte-max 4
python3 scripts/catalogue.py --structure graphe-oriente --niveau MPI
python3 scripts/catalogue.py --concours 'ENS Ulm' --sortie build/selection.json
```

Les filtres se combinent par « et » et utilisent des valeurs exactes. Le champ
`fichier` de chaque résultat indique quoi importer dans une feuille. Le script
interroge Typst, valide toute la banque et refuse les identifiants dupliqués,
même lorsqu’un filtre ne retiendrait qu’une partie des exercices. Une sélection
JSON n’est pas automatiquement une feuille : l’ordre et les consignes se règlent
dans le petit fichier Typst de la feuille.

## Vérifier

`make check` compile les énoncés, les corrigés, les feuilles, les sujets et les
modèles avec et sans solutions ; il exporte également le catalogue, ce qui
valide les métadonnées et l’unicité des identifiants. Il vérifie le partage
des parties et exécute les tests du corrigé OCaml (déterminisation, minimalité,
palindromes, simplification et Conway). `nix flake check path:.` exécute les
mêmes vérifications dans une dérivation Nix sur la plateforme courante.
Ces vérifications ne remplacent pas une relecture mathématique.

La conversion initiale, ses choix et les erreurs corrigées sont documentés dans
[les notes de migration](docs/ensembles-inevitables-migration.md).
Les fichiers LaTeX d’origine du dépôt `exos-src` restent inchangés.

Références officielles : [syntaxe Typst](https://typst.app/docs/reference/syntax/),
[paramètres de compilation](https://typst.app/docs/reference/foundations/sys/),
[métadonnées](https://typst.app/docs/reference/model/metadata/).

## TD Langages réguliers

La feuille `feuilles/td-langage.typ` assemble les six exercices convertis depuis
`cours-src/langage/langage/td/td_langage.tex`, corrigés inclus. Voir les
[notes de conversion](docs/td-langage-conversion.md) pour les seules corrections
substantielles apportées. Prévisualisation :

```sh
make watch-feuille FEUILLE=td-langage
```

Le skill personnel `$convertir-td-latex-typst` est installé dans
`~/.codex/skills/convertir-td-latex-typst/` pour reproduire ce workflow.

Les instructions destinées aux assistants sont versionnables avec le dépôt :
[AGENTS.md](AGENTS.md).
