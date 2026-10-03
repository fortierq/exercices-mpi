# Créer et utiliser la banque

## Démarrage

Partir des modèles [exercice](../templates/exercice.typ), [TD](../templates/feuille.typ), [devoir](../templates/devoir.typ) ou [sujet de concours](../templates/sujet-concours.typ).
Avant de créer un exercice, vérifier qu'il n'existe pas déjà dans la banque.

- Les dossiers sont libres, y compris la racine : le type est déclaré dans le code, pas déduit du chemin. Les dossiers actuels peuvent être conservés ou réorganisés. Les répertoires techniques `lib`, `templates`, `ressources`, `docs`, `scripts`, `build`, `node_modules` et les dossiers cachés ne sont pas des entrées du catalogue.
- Un exercice exporte `ex` ; le nom du fichier sans extension est son identifiant, unique dans la banque.
- Tous les documents utilisent `#show: feuille.with(type: "td", ...)`. Types fournis : `"td"`, `"devoir"`, `"concours"`. Un TD ou devoir importe les objets `ex` sous des alias distincts dans `exercices: (alias1, alias2,)`. L'ordre du tableau est l'ordre d'affichage ; `()` crée un document vide.
- Un sujet complet conserve son contenu dans un seul fichier, exporte `ex` et utilise le même appel `feuille.with(type: "concours", exercices: (ex,), ...)`.
- Réutiliser une partie en exportant une variable puis en l'important, sans copier le sujet ni rechercher une partie par numéro.
- Introductions et définitions vont dans `contenu`. Reprendre explicitement les rappels de `contexte` dans un exercice autonome.

Dans VS Code, **Feuilles** rassemble tous les types, avec une recherche commune, un filtre de type et des dossiers repliables (ou une liste à plat). **Créer une feuille** propose le type et le modèle ; le clic droit sur un dossier choisit seulement l'emplacement, jamais le type.

Créer un TD ou devoir vide, le sélectionner dans **Feuilles**, puis ajouter les exercices depuis la recherche ou par glisser-déposer. Les changements de composition sont enregistrés automatiquement. Les listes calculées et exercices définis localement restent éditables dans le code ; le panneau affiche leurs questions.

Un devoir est simplement un document avec un barème, sans paramètre `evaluation`. Les points sont placés dans chaque `question`, donc suivent les questions lors des réorganisations. Le suivi individuel reste dans des copies séparées, liées au sujet (voir ci-dessous).

Pour ajouter un type, copier un modèle dans `templates/`, remplacer son champ littéral `type` (par exemple `type: "colle"`) et adapter son contenu. L'extension découvre automatiquement le modèle pour la création et le nouveau type pour les filtres. Aucun changement du Makefile ni de l'extension n'est nécessaire. Garder `feuille.with` et un `titre` littéral (ou `ex.meta.titre` pour un sujet monolithique) ; les champs calculés ne sont pas évalués par la recherche.

Sans champ `type`, `feuille.with(...)` produit un TD. Les noms de fichiers utilisent lettres, chiffres, tirets et traits de soulignement ; les chemins sont relatifs à la banque.

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

- Partir de `templates/sujet-concours.typ`, dans le dossier souhaité. Garder les questions, définitions et figures dans un seul sujet ; commencer les questions à 1 et adapter les renvois si la source commence à 0.
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

### Barème

Placer les points dans chaque question :

```typst
question([Justifier la complexité.], points: 1.5, solution: [ ... ])
```

`points: none` (valeur par défaut) omet les points de la question. Les points figurent uniquement dans la marge droite du corrigé. Ils sont conservés quand on déplace ou retire un exercice, sans tableau à réaligner.

Les anciens tableaux `bareme` d'exercice ou de document restent lus en priorité pour compatibilité. Les convertir en `points` dans les questions avant de réorganiser automatiquement un document portant un tel tableau ; l'extension bloque cette opération pour éviter un décalage silencieux.

Échelle pédagogique : évidence 0.25, facile 0.5, moyen 1, assez difficile 2,
difficile 3, très difficile 4. Tenir aussi compte de la longueur de la preuve ou du code ;
1.5, 2.5 et 3.5 permettent d'affiner. Le total reste brut, sans normalisation.
Un barème pédagogique de concours n'est pas un barème officiel.

## Copies corrigées et notes de classe

Partir de [templates/copie.typ](../templates/copie.typ). La feuille d'origine exporte
`sujet = (titre: ..., exercices: (...), bareme: none)` et utilise cette même composition
dans `feuille.with`. Une copie importe `sujet` : les énoncés et les points ne sont pas recopiés.
Les copies nominatives, notes, scans et sorties sont conservés hors de cette banque,
dans le dossier privé de la classe. Seuls les modèles, outils et tests fictifs restent ici.

Les évaluations sont dans un JSON voisin : identité, chemin de la feuille, lien de la copie,
appréciation et dictionnaire `evaluations`. Chaque clé `"1.13"` désigne la question 13
du premier exercice, y compris les questions dans des parties imbriquées.
Une évaluation contient `repondue` (booléen), `reussite` (nombre entre 0 et 100,
ou `null` pour « à corriger »), et `commentaire` (balisage Typst : `$...$` pour les
mathématiques, accents graves pour le code). Les anciens champs `reponse` et `repere`
peuvent rester dans les données, mais ne sont pas affichés.
Les sous-questions peuvent être distinguées dans le commentaire de la question qui les contient.
Une réponse absente reçoit `repondue: false`, `reussite: 0` et un commentaire vide.
Ne pas déduire l'absence d'une note nulle : une réponse fausse peut recevoir 0 %.
À 100 %, laisser le commentaire vide si aucune remarque utile n'est nécessaire.
Une suggestion de solution plus simple peut néanmoins être conservée.
Toutes les questions doivent être présentes ; une correction incomplète ou un barème absent
laisse le total vide. Les barèmes de feuille, d'exercice puis de question sont lus dans cet ordre.

Le PDF corrigé affiche uniquement les questions traitées, avec leurs numéros d'origine,
et les titres des parties contenant au moins une réponse. Chaque question est suivie
uniquement de son commentaire utile, sans relevé de réponse ni points dans le corps.
Dans la marge gauche, la moyenne de classe est placée au niveau de la question,
et la réussite individuelle est centrée verticalement sur le commentaire.
Sans commentaire, seul le pourcentage individuel apparaît sous la question, dans la marge.
La version énoncé conserve le sujet entier.
Les solutions de référence restent disponibles dans le corrigé de la feuille d'origine.
Les points obtenus valent `points × reussite / 100` ; le total reste brut, sans conversion sur 20.
Après modification de l'ordre ou du contenu du sujet, relire l'association des évaluations :
les clés sont des numéros, pas des identifiants stables.

Depuis la banque, compiler une copie privée avec
`nix develop path:. -c python3 scripts/copies.py /chemin/prive/copies/eleve.typ`.
Les PDF sont écrits dans `build/eleve/` à côté de la copie.
Une racine Typst temporaire, créée sous `copies/tmp/` puis supprimée, relie la banque
et les sources privées sans les recopier. Les imports `/lib/...`, `/concours/...`, etc.
et la lecture du JSON voisin restent inchangés.
Exporter les notes avant de compiler les copies pour actualiser les moyennes :

```sh
nix develop path:. -c python3 scripts/notes.py \
  --classe /chemin/prive/liste-classe.csv \
  --sortie /chemin/prive/copies/notes.csv /chemin/prive/copies/*.typ
```

La liste source est un CSV sans en-tête `classe;nom;prenom;...`.
Seuls ces trois premiers champs sont repris. Le CSV produit, en UTF-8 avec BOM et séparateur `;`,
contient une ligne par élève, la note brute, le barème, les pourcentages, points et commentaires
par question. Les élèves sans correction ont des notes vides, jamais zéro.
Il s'agit d'un export calculé : modifier les évaluations, puis relancer la commande pour l'actualiser.
Les identités inconnues, doublons et mélanges de sujets ou de barèmes interrompent l'export.
L'export produit aussi `notes.moyennes.json`, lu par le compilateur des copies.
La moyenne de chaque question inclut les zéros et exclut les évaluations manquantes.
Les élèves dont la copie n'est pas corrigée ne sont pas comptés comme ayant zéro.
Le document précise le nombre de copies évaluées et l'effectif de la liste.
Sans ce fichier, un tiret remplace les moyennes ; `scripts/copies.py --moyennes chemin.json`
permet de choisir un autre fichier. Dans le Makefile privé, faire dépendre `pdf` de `notes`.

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

`make check` compile les énoncés, corrigés et modèles, valide le catalogue et lance les tests. Pour `dossier/nom.typ`, les sorties sont `build/dossier/nom/enonce.pdf` et `corrige.pdf` ; cela fonctionne aussi à la racine. `make w <chemin> C=true O=0` surveille un corrigé sans ouvrir de lecteur ; utiliser `C=false` pour l'énoncé.

Conserver code et tests dans `ressources/<identifiant>/`, afficher ce même code dans le corrigé, et brancher les tests sur `make check`. Une dizaine de tests ciblés suffit. La référence Tidy et les tests de l'API font aussi partie des vérifications.

Les tests Typst de régression de l'API restent dans `ressources/api/test.typ`. Ne pas ajouter de `test.typ` aux sujets de concours ; conserver les tests OCaml ou Python qui vérifient le code publié dans leurs corrigés.
