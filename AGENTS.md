# Consignes pour les assistants

## Consignes générales

- Rester concis, précis et simple si possible. Refactoriser les abstractions devenues inutiles.

## Structure, ajout et conversion

- Avant d'ajouter un exercice, vérifier qu’il n’existe pas déjà dans `exercices/`. Comparer pour voir s'il s'agit du même exercice, auquel cas il ne faut pas le dupliquer.
- Utiliser les modèles Typst dans `modeles/` pour créer/modifier un [exercice](modeles/exercice.typ) ou une feuille. S'inspirer des exercices existants dans `exercices/` si besoin. S'inspirer aussi si besoin des exercices similaires dans `exercices/`.
- Lire l’API actuelle dans `lib/exercices.typ` avant toute modification.
- Un fichier `exercices/<chapitre>/<identifiant>.typ` exporte un objet `ex`. Son identifiant est le nom du fichier sans l'extension `.typ` ; il doit être unique dans toute la banque et ne figure pas dans `meta`. Une feuille `feuilles/<nom>.typ` assemble ces objets dans l’ordre voulu.
- Sujets et exercices utilisent `exercice` et `modeles/fiche.typ`. Garder chaque sujet dans un seul fichier ; exporter les parties réutilisées dans des variables et les importer dans les exercices, sans duplication ni recherche par numéro.
- Placer introductions et définitions dans `contenu` ; ajouter explicitement les rappels nécessaires dans l’exercice autonome.

## Contenu

### Conversion de sources LaTeX

- Les consignes de conversion sont maintenues dans ce dépôt ; aucun skill externe n'est nécessaire.
- Résoudre les `\input` et `\include`, y compris les anciens chemins `/workspaces/…`, à partir des dépôts voisins. Lire aussi les corrigés séparés ou sous `\if\cor1`, et ignorer les exercices commentés. Ne pas modifier les originaux LaTeX.
- Conserver l'ordre, les questions, les sous-questions, les textes intermédiaires, les notations et les arguments de la source, sous réserve des corrections importantes et des conventions ci-dessous. Associer les solutions aux questions par leur contenu plutôt que par leur seul numéro.
- Ne pas ajouter silencieusement de questions ou de solutions absentes de la source. Laisser `solution: none` si le corrigé manque. Signaler les difficultés estimées et les adaptations de contenu ou de présentation dans la réponse et la pull request.
- Vérifier en particulier le mot vide, l'ensemble vide, les domaines, les hypothèses de finitude et les indices des récurrences. Après conversion, contrôler le nombre et l'ordre des questions ainsi que la séparation entre énoncés et solutions.

### Périmètre et corrections

- Les sujets et corrections doivent utiliser les outils du programme : [résume du programme](docs/programme.md). Les sujets peuvent introduire de nouvelles notions.
- Utiliser les chapitres de /Users/qfortier/repo/cours-src (fichiers de la forme poly_*.tex) pour une référence de cours.
- Corriger uniquement les erreurs importantes : hypothèse indispensable, énoncé faux, preuve invalide, code incorrect, faute d'orthographe manifeste. Avertir l’utilisateur pour toute modification de présentation ou de contenu.
- Pour déterminiser, dessiner l'automate plutôt que donner la table de transition. 

## Syntaxe

- Préférer la syntaxe Typst native pour le contenu fixe (`== Titre`, listes…) ; réserver les appels de fonctions aux éléments calculés ou réutilisables.
- Délimiter les extraits de code Typst, inline ou en bloc, par des accents graves avec le langage adéquat, par exemple ```ocaml arbre_a_mot``` ; ne pas les entourer d'apostrophes.
- Noter un graphe `G = (S, A)`, où `S` est l’ensemble des sommets et `A`
  l’ensemble des arcs (ou des arêtes pour un graphe non orienté). Utiliser ces notations de façon cohérente dans les énoncés, corrigés et modèles.
- Pour la programmation en MP2I ou MPI, utiliser exclusivement C, OCaml ou Python, dans les questions comme dans les solutions. Le pseudocode reste possible lorsqu’une question demande seulement de décrire un algorithme.
- Utiliser les caractères Unicode pour les symboles mathématiques, par exemple `Σ` pour l’alphabet, `ε` pour le mot vide, `∪` pour l’union, `∩` pour l’intersection, `*` pour l’étoile de Kleene, `→` pour la flèche d’une fonction (sauf en programmation), `∀` et `∃` pour les quantificateurs. 
- Utiliser régulier au lieu de rationnel pour un langage ou expression régulière. Utiliser hors-contexte au lieu de langage algébrique. Utiliser | au lieu de + sur les expressions régulières.
- Utiliser si possible uniquement les fonctions autorisées par le programme dans docs/programme.md. En particulier, éviter List.fold.
- Tester le code proposé en corrigé, mais sans utiliser trop de tests. Une dizaine suffit.
- Utiliser la syntaxe OCaml au lieu de Caml light utilisé par les anciens sujets de concours. Exemple : array au lieu de vect.

## Métadonnées

- Utiliser exclusivement les chapitres, structures et algorithmes mentionnés dans le [programme MP2I–MPI](https://prepas.org/index.php?document=73).
  Consulter d’abord le [résume du programme](docs/programme.md), qui distingue notions exigibles, outils après rappel et exclusions.
  Respecter `lib/meta.typ` pour les métadonnées.
- Renseigner le champ obligatoire `langages` avec les langages de       programmation effectivement utilisés dans l’énoncé ou le corrigé : `("C",)`, `("OCaml",)`, `("SQL",)`, `("Python",)` ou plusieurs de ces valeurs. Utiliser `()` pour un exercice sans langage de programmation, par exemple en présence de pseudocode seulement.
- Utiliser uniquement `concours` pour une attribution : `none` ou `(nom: "…", annee: …, filiere: "…")`. La filière est `"MPI"` par défaut. Choisir le concours et la filière dans `lib/concours.typ` ; ne pas utiliser de champ `reference` ni inventer une année.

## Présentation

- Titres des exercices en gras ; corps, numéros des questions et solutions sans gras. Titres au format « I - Titre », questions au format « 1. », sans préfixe Q.

## Figures

- Générer les figures (automates, arbres, graphes, schémas…) depuis des sources Typst avec [CeTZ](https://typst.app/universe/package/cetz/), [finite](https://typst.app/universe/package/finite/) pour les automates, ou un autre paquet adapté.
- Conserver le code des figures dans le même fichier si possible.
- Fixer les versions des paquets dans les imports. Préserver les informations de la figure source : étiquettes, transitions, états initiaux et finaux, structure des arbres.

## Compilation et vérification

- Ranger les tests propres à un sujet ou exercice dans `ressources/<identifiant>/`, auprès du code testé (`test.ml`, `test.typ`…), et les lancer avec `make check`.
- Lancer `nix develop path:. -c make check` ; compiler énoncés, corrigés et modèles.
  Le catalogue valide les métadonnées et l’unicité des identifiants déduits des noms de fichiers.
- Ne pas inspecter les PDF générés.
- Communiquer les fichiers concernés, les corrections et les vérifications réelles.
- Fournir systématiquement des liens cliquables vers les PDF générés (énoncé et corrigé) dans la réponse finale, pour permettre leur vérification par l’utilisateur.

## Commits

- Pour chaque nouvelle modification majeure (ajout d'un nouvel exercice...), créer une pull request dédiée après les vérifications sans demander de confirmation supplémentaire. Inclure l’exercice et des commentaires pertinents éventuels. Ne pas créer de pull request pour des modifications mineures.
- Ne pas créer d'autre fichier de commentaires, si non demandé par l’utilisateur.
- Ne pas inclure les modifications de l’utilisateur sans rapport avec l’exercice.
- Indiquer dans la réponse finale la pull request créée et les vérifications effectuées.
