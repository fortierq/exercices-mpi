# Consignes pour les assistants

## Consignes générales

- Rester concis, précis et simple si possible.

## Structure et conversion

- Utiliser les modèles Typst dans `modeles/` pour créer un [exercice](modeles/exercice.typ) ou une feuille. S'inspirer des exercices existants dans `exercices/` si besoin.
- Lire l’API actuelle dans `lib/exercices.typ` avant toute modification. Préserver les modifications de l’utilisateur.
- Un fichier `exercices/<chapitre>/<identifiant>.typ` exporte un objet `ex`. Une feuille `feuilles/<nom>.typ` assemble ces objets dans l’ordre voulu.
- Corriger uniquement les erreurs importantes : hypothèse indispensable,
  énoncé faux, preuve invalide, code incorrect, faute d'orthographe manifeste. Avertir l’utilisateur pour toute modification de présentation ou de contenu.

## Notations et programmation

- Utiliser ' au lieu de `.
- Noter un graphe `G = (S, A)`, où `S` est l’ensemble des sommets et `A`
  l’ensemble des arcs (ou des arêtes pour un graphe non orienté). Utiliser ces notations de façon cohérente dans les énoncés, corrigés et modèles.
- Pour la programmation en MP2I ou MPI, utiliser exclusivement C, OCaml ou Python, dans les questions comme dans les solutions. Le pseudocode reste possible lorsqu’une question demande seulement de décrire un algorithme.

## Métadonnées

- Utiliser exclusivement les chapitres, structures et algorithmes mentionnés dans le [programme MP2I–MPI](https://prepas.org/index.php?document=73).
  Consulter d’abord le [référentiel concis pour les IA](docs/programme.md), qui distingue notions exigibles, outils après rappel et exclusions.
  Respecter `lib/programme.typ` et `docs/programme.md` ; toute extension exige une référence de section et de page. Ne pas inventer d’étiquette pour une tâche.
- Renseigner le champ obligatoire `langages` avec les langages de       programmation effectivement utilisés dans l’énoncé ou le corrigé : `("C",)`, `("OCaml",)`, `("SQL",)`, `("Python",)` ou plusieurs de ces valeurs. Utiliser `()` pour un exercice sans langage de programmation, par exemple en présence de pseudocode seulement.

## Présentation

- Titres des exercices en gras ; corps, numéros des questions et solutions sans gras.

## Compilation et vérification

- Lancer `nix develop path:. -c make check` ; compiler énoncés, corrigés et modèles.
  Le catalogue valide les métadonnées et l’unicité des identifiants.
- Ne pas inspecter les PDF générés.
- Communiquer les fichiers concernés, les corrections et les vérifications réelles.

## Commits

- Pour chaque nouvel exercice, créer une pull request dédiée après les vérifications,
  sans demander de confirmation supplémentaire. Inclure l’exercice, sa note
  éventuelle et les modifications directement nécessaires à son intégration.
- Ne pas inclure les modifications de l’utilisateur sans rapport avec l’exercice.
- Indiquer dans la réponse finale la pull request créée et les vérifications effectuées.
