# Consignes pour les assistants

Lire et appliquer le [guide utilisateur](docs/utilisation.md) : il fait autorité pour la structure, les métadonnées, la rédaction, les concours et les vérifications. Ne pas recopier ces règles ici.

## Travail avec l'utilisateur

- Poser les questions nécessaires ; ne pas choisir silencieusement en cas d'ambiguïté.
- Expliquer brièvement les choix importants, rester concis et refactoriser les abstractions inutiles.
- Lire l'API actuelle dans `lib/exercices.typ` avant toute modification ; utiliser les modèles et comparer les exercices existants pour éviter les doublons.
- Avertir l'utilisateur des changements de présentation ou de contenu.
- Pour les références de cours, utiliser les fichiers `poly_*.tex` de `/Users/qfortier/repo/cours-src`.

## Conversion de sources LaTeX

- Les consignes de conversion sont maintenues dans ce dépôt ; aucun skill externe n'est nécessaire.
- Résoudre les `\input` et `\include`, y compris les anciens chemins `/workspaces/…`, à partir des dépôts voisins. Lire aussi les corrigés séparés ou sous `\if\cor1`, et ignorer les exercices commentés. Ne pas modifier les originaux LaTeX.
- Conserver l'ordre, les questions, les sous-questions, les textes intermédiaires, les notations et les arguments de la source, sous réserve des corrections importantes et des conventions ci-dessous. Associer les solutions aux questions par leur contenu plutôt que par leur seul numéro.
- Ajouter un corrigé si le corrigé manque. 
- Il est possible de reformuler les formulations maladroites ou qui peuvent être reformulées de façon plus concise.


## Vérification et livraison

- Lancer `nix develop path:. -c make check` ; annoncer les vérifications réellement effectuées.
- Ne pas inspecter les PDF générés.
- Communiquer les fichiers modifiés et les corrections, avec des liens cliquables vers les PDF d'énoncé et de corrigé générés.
- Pour chaque modification, faire un commit directement sur la branche principale.
