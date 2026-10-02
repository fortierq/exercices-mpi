# Créer et utiliser la banque

## Démarrage

Partir des modèles [exercice](../templates/exercice.typ), [feuille](../templates/feuille.typ) ou [sujet de concours](../templates/sujet-concours.typ).
Avant de créer un exercice, vérifier qu'il n'existe pas déjà dans `exercices/`.

- `exercices/<chapitre>/<identifiant>.typ` exporte un objet `ex` ; le nom du fichier sans extension est son identifiant, unique dans la banque.
- Une feuille importe les objets `ex` sous des alias distincts et les assemble dans `exercices: (alias1, alias2,)`. L'ordre du tableau est l'ordre d'affichage ; `()` crée une feuille vide.
- Un sujet reste dans un seul fichier `concours/<année sur deux chiffres>/<identifiant>.typ` et exporte aussi `ex`.
- Réutiliser une partie en exportant une variable puis en l'important, sans copier le sujet ni rechercher une partie par numéro.
- Introductions et définitions vont dans `contenu`. Reprendre explicitement les rappels de `contexte` dans un exercice autonome.

Dans VS Code, créer une feuille vide, la sélectionner dans **Feuilles**, puis ajouter les exercices depuis la recherche ou par glisser-déposer. Les changements de composition sont enregistrés automatiquement.

## Aide de l'API

[Tinymist](https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist) est recommandé, mais facultatif : survoler les fonctions importées pour consulter leurs commentaires et signatures. Le code et les modèles fonctionnent sans Tinymist.

Les commentaires `///` de [lib/exercices.typ](../lib/exercices.typ) documentent les fonctions publiques, leurs paramètres et le comportement des corrigés. [lib/meta.typ](../lib/meta.typ) contient les valeurs autorisées, sans copie dans ce guide.

La référence PDF se génère avec `nix develop path:. -c make docs` dans `build/docs/api.pdf`. Tidy 0.4.3 est utilisé uniquement pour cette documentation, en mode `old-syntax: true` pour partager les annotations avec Tinymist. Un accès réseau peut être nécessaire au premier téléchargement du paquet. Sources : [format Tinymist](https://myriad-dreamin.github.io/tinymist/feature/docs.html), [Tidy](https://typst.app/universe/package/tidy).

## Métadonnées

Le contrat détaillé est dans le commentaire de `exercice`. Renseigner les champs obligatoires même lorsqu'un tableau est vide. Les attributs supplémentaires restent libres.

- Choisir chapitres, structures et algorithmes dans `lib/meta.typ`, après consultation du [résumé du programme](programme.md).
- Déclarer les langages effectivement utilisés dans l'énoncé ou le corrigé. SQL est autorisé pour tous les niveaux, y compris MP2I et MPI. Utiliser `()` pour du pseudocode seul.
- Utiliser `concours`, jamais `reference`. N'inventer ni année ni attribution ; choisir les noms et filières autorisés. Renseigner explicitement `filiere: "MPI"` lorsque c'est la filière visée : l'API n'en ajoute pas par défaut.
- `duree` vaut `none` ou un couple positif `(heures, minutes)`, avec des entiers et `0 ≤ minutes < 60`.

## Sujets de concours et rapports du jury

- Ranger les sujets dans `concours/<année sur deux chiffres>/` et partir de `templates/sujet-concours.typ`. Garder les questions, définitions et figures dans un seul sujet ; commencer les questions à 1 et adapter les renvois si la source commence à 0.
- Comparer le corrigé au sujet original, notamment les figures et les hypothèses. Corriger directement les erreurs importantes de l'énoncé, signaler les parties/questions corrigées dans la liste initiale du corrigé et expliquer brièvement le problème et/ou le changement pour chacune. Ne pas conserver deux versions contradictoires du code.
- Renseigner `corrections` de `exercice` avec une simple liste des parties/questions corrigées, chacune accompagnée d'une brève explication du problème ou du changement. Pour les sujets attribués à un concours uniquement, le corrigé commence par « Modifications par rapport à l'énoncé initial : » puis cette liste. Placer ensuite les commentaires généraux du jury dans `remarques`, sous forme de liste, sans titre, source ni référence affichés.
- Associer les observations relatives à une partie ou sous-partie au paramètre `commentaire` de `partie` ; les afficher dans le corrigé immédiatement après son titre. Tous les commentaires du jury (généraux, de partie et de question) sont en italique.
- Associer chaque observation pertinente du jury à la question concernée via `commentaire` de `question`. Elle apparaît uniquement dans le corrigé, en italique, immédiatement après l'énoncé de la question et avant sa solution.
- Chercher d'abord le rapport dans les sources voisines, puis sur le site officiel du concours. Vérifier concours, année, filière et épreuve ; conserver la source, les pages et les questions concernées dans les commentaires du fichier Typst ou dans la documentation, sans les afficher dans le corrigé. Si le rapport est introuvable, le signaler sans inventer d'extrait.
- Privilégier les citations exactes et courtes, entre guillemets. Reformuler ou synthétiser si cela permet de rester concis et de transmettre les informations utiles ; le préciser dans les sources. Distinguer les remarques du jury des corrections éditoriales. Respecter les limites de citation des sources. Replacer les remarques sur le programme dans leur contexte historique.
- Stocker le code des corrigés dans `ressources/<identifiant>/` et l'afficher depuis ces mêmes fichiers pour tester exactement le code publié.


## Contenu et rédaction

- Respecter le [programme](programme.md) ; de nouvelles notions peuvent être introduites dans le sujet.
- Corriger les erreurs importantes : hypothèse indispensable, énoncé faux, preuve invalide, code incorrect ou faute d'orthographe manifeste.
- Pour déterminiser, dessiner l'automate plutôt que donner seulement une table.
- Justifier les complexités, sauf mention contraire ou évidence ; poser les récurrences et séparer visuellement les implications et inclusions.
- Essayer d'obtenir un nombre pair de pages sans altérer le contenu.

## Code Typst

- Dans les fichiers `.typ`, revenir à la ligne lorsque cela facilite la lecture ou marque une articulation logique du paragraphe, sans limite explicite de caractères. Préserver les retours structurels (paragraphes, listes, titres, code et formules).
- Préférer la syntaxe Typst native pour le contenu fixe (`== Titre`, listes…) ; réserver les appels de fonctions aux éléments calculés ou réutilisables.
- Délimiter les extraits de code Typst, inline ou en bloc, par des accents graves avec le langage adéquat, par exemple ```ocaml arbre_a_mot``` ; ne pas les entourer d'apostrophes.
- Utiliser exclusivement l'apostrophe ASCII `'`, y compris dans les textes français.
- Être concis.
- Commenter brièvement les éventuelles parties importantes et non évidentes du code. En particulier, commenter l'intérêt d'une nouvelle fonction/variable introduite si cela aide à la compréhension :
```ocaml
let f x = (* f x renvoie ... *)
  ...
```
- Tester le code proposé en corrigé, mais sans utiliser trop de tests. Une dizaine suffit.

## Syntaxe

- Noter un graphe `G = (S, A)`, où `S` est l'ensemble des sommets et `A` l'ensemble des arcs (ou des arêtes pour un graphe non orienté). Utiliser ces notations de façon cohérente dans les énoncés, corrigés et modèles.
- Pour la programmation en MP2I ou MPI, utiliser C, OCaml, Python ou SQL, dans les questions comme dans les solutions. Le pseudocode reste possible lorsqu'une question demande seulement de décrire un algorithme.
- Utiliser les caractères Unicode pour les symboles mathématiques, par exemple `Σ` pour l'alphabet, `ε` pour le mot vide, `∪` pour l'union, `∩` pour l'intersection, `*` pour l'étoile de Kleene, `→` pour la flèche d'une fonction (sauf en programmation), `∀` et `∃` pour les quantificateurs.
- Utiliser régulier au lieu de rationnel pour un langage ou expression régulière. Utiliser hors-contexte au lieu de langage algébrique. Utiliser | au lieu de + sur les expressions régulières.
- Utiliser si possible uniquement les fonctions autorisées par le programme dans docs/programme.md. En particulier, éviter List.fold.
- Utiliser la syntaxe OCaml au lieu de Caml light utilisé par les anciens sujets de concours. Exemple : array au lieu de vect.


## Présentation

- Dans chaque exercice ou sujet, la numérotation des questions commence à 1 ; ce départ ne se paramètre pas.
- Titres des exercices en gras ; corps, numéros des questions et solutions sans gras. Titres au format « I - Titre », questions au format « 1. », sans préfixe Q.
- Dans le corrigé d'un exercice, conserver tout l'énoncé, y compris les blocs libres de `contenu` (préliminaires, définitions, notations et textes de contexte). Uniquement pour un sujet de concours écrit, utiliser `sujet-ecrit: true` dans `exercice` pour masquer ces blocs dans le corrigé. Conserver les titres des parties, les questions, leurs commentaires et leurs solutions. Les figures incluses dans les questions et solutions restent affichées. Les exercices oraux et les extraits autonomes conservent leur contexte, même s'ils portent une attribution de concours.

## Figures

- Générer les figures (automates, arbres, graphes, schémas…) depuis des sources Typst avec [CeTZ](https://typst.app/universe/package/cetz/), [finite](https://typst.app/universe/package/finite/) pour les automates, ou un autre paquet adapté.
- Conserver le code des figures dans le même fichier si possible.
- Pour les automates, utiliser l'échelle et le style communs de `lib/automates.typ` : rayon ordinaire de 4,8 mm, agrandi pour les couples, ensembles et labels longs. Placer les boucles, arcs de retour et étiquettes vers l'extérieur lorsqu'il y a le choix, et éviter les croisements.
- Fixer les versions des paquets dans les imports. Préserver les informations de la figure source : étiquettes, transitions, états initiaux et finaux, structure des arbres.


## Compilation et tests

```sh
nix develop path:. -c make check
nix develop path:. -c make c exercices/langages/residuels-minimisation.typ
nix develop path:. -c make docs
```

`make check` compile les énoncés, corrigés et modèles, valide le catalogue et lance les tests. Les sorties sont dans `build/`. `make w <chemin> C=true O=0` surveille un corrigé sans ouvrir de lecteur ; utiliser `C=false` pour l'énoncé.

Conserver code et tests dans `ressources/<identifiant>/`, afficher ce même code dans le corrigé, et brancher les tests sur `make check`. Une dizaine de tests ciblés suffit. La référence Tidy et les tests de l'API font aussi partie des vérifications.
