# Consignes pour les assistants

## Consignes générales

- Rester concis, précis et simple si possible.

## Structure, ajout et conversion

- Avant d'ajouter un exercice, vérifier qu’il n’existe pas déjà dans `exercices/`. Comparer pour voir s'il s'agit du même exercice, auquel cas il ne faut pas le dupliquer.
- Utiliser les modèles Typst dans `modeles/` pour créer/modifier un [exercice](modeles/exercice.typ) ou une feuille. S'inspirer des exercices existants dans `exercices/` si besoin. S'inspirer aussi si besoin des exercices similaires dans `exercices/`.
- Lire l’API actuelle dans `lib/exercices.typ` avant toute modification.
- Ajouter ou compléter la correction.
- Un fichier `exercices/<chapitre>/<identifiant>.typ` exporte un objet `ex`. Son identifiant est le nom du fichier sans l'extension `.typ` ; il doit être unique dans toute la banque et ne figure pas dans `meta`. Une feuille `feuilles/<nom>.typ` assemble ces objets dans l’ordre voulu.
- Corriger uniquement les erreurs importantes : hypothèse indispensable,
  énoncé faux, preuve invalide, code incorrect, faute d'orthographe manifeste. Avertir l’utili/Users/qfortier/repo/cours-src/langage/colle/colle1.texsateur pour toute modification de présentation ou de contenu.

## Notations et programmation

- Délimiter les extraits de code Typst, inline ou en bloc, par des accents graves avec le langage adéquat, par exemple ```ocaml arbre_a_mot``` ; ne pas les entourer d'apostrophes.
- Noter un graphe `G = (S, A)`, où `S` est l’ensemble des sommets et `A`
  l’ensemble des arcs (ou des arêtes pour un graphe non orienté). Utiliser ces notations de façon cohérente dans les énoncés, corrigés et modèles.
- Pour la programmation en MP2I ou MPI, utiliser exclusivement C, OCaml ou Python, dans les questions comme dans les solutions. Le pseudocode reste possible lorsqu’une question demande seulement de décrire un algorithme.
- Utiliser les caractères Unicode pour les symboles mathématiques, par exemple `Σ` pour l’alphabet, `ε` pour le mot vide, `∪` pour l’union, `∩` pour l’intersection, `*` pour l’étoile de Kleene, `→` pour la flèche d’une fonction (sauf en programmation), `∀` et `∃` pour les quantificateurs. 
- Utiliser régulier au lieu de rationnel pour un langage ou expression régulière. Utiliser hors-contexte au lieu de langage algébrique.

## Métadonnées

- Utiliser exclusivement les chapitres, structures et algorithmes mentionnés dans le [programme MP2I–MPI](https://prepas.org/index.php?document=73).
  Consulter d’abord le [référentiel concis pour les IA](docs/programme.md), qui distingue notions exigibles, outils après rappel et exclusions.
  Respecter `lib/programme.typ` et `docs/programme.md` ; toute extension exige une référence de section et de page. Ne pas inventer d’étiquette pour une tâche.
- Renseigner le champ obligatoire `langages` avec les langages de       programmation effectivement utilisés dans l’énoncé ou le corrigé : `("C",)`, `("OCaml",)`, `("SQL",)`, `("Python",)` ou plusieurs de ces valeurs. Utiliser `()` pour un exercice sans langage de programmation, par exemple en présence de pseudocode seulement.
- Utiliser uniquement `concours` pour une attribution : `none` ou `(nom: "…", annee: …, filiere: "…")`. La filière est `"MPI"` par défaut. Choisir le concours et la filière dans `lib/concours.typ` ; ne pas utiliser de champ `reference` ni inventer une année.

## Présentation

- Titres des exercices en gras ; corps, numéros des questions et solutions sans gras.

## Figures

- Générer les figures (automates, arbres, graphes, schémas…) depuis des sources Typst avec [CeTZ](https://typst.app/universe/package/cetz/), [finite](https://typst.app/universe/package/finite/) pour les automates, ou un autre paquet adapté.
- Conserver le code des figures dans le dépôt et les générer lors de la compilation ; ne pas recopier une image matricielle ni écrire un SVG à la main lorsqu'une figure peut être reconstruite avec ces outils.
- Fixer les versions des paquets dans les imports. Préserver les informations de la figure source : étiquettes, transitions, états initiaux et finaux, structure des arbres.

## Compilation et vérification

- Lancer `nix develop path:. -c make check` ; compiler énoncés, corrigés et modèles.
  Le catalogue valide les métadonnées et l’unicité des identifiants déduits des noms de fichiers.
- Ne pas inspecter les PDF générés.
- Communiquer les fichiers concernés, les corrections et les vérifications réelles.

## Commits

- Pour chaque nouvelle modification majeure (ajout d'un nouvel exercice...), créer une pull request dédiée après les vérifications sans demander de confirmation supplémentaire. Inclure l’exercice et des commentaires pertinents éventuels. Ne pas créer de pull request pour des modifications mineures.
- Ne pas créer d'autre fichier de commentaires, si non demandé par l’utilisateur.
- Ne pas inclure les modifications de l’utilisateur sans rapport avec l’exercice.
- Indiquer dans la réponse finale la pull request créée et les vérifications effectuées.
