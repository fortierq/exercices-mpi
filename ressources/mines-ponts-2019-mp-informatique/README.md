# Mines-Ponts 2019 — Informatique MP

## Sources

- Énoncé : `/Users/qfortier/repo/cours-src/langage/ds/cmp19/cmp19.pdf`, 37 questions, durée de 3 heures.
- Corrigé : `/Users/qfortier/repo/cours-src/langage/ds/cmp19/cmp19_cor.tex` (aucun `input` ou `include`).
- Rapport : `/Users/qfortier/repo/cours-src/langage/ds/cmp19/rapport.pdf`, § 4.2, pages 66–68.
- Références de cours : `cours-src/langage/automate/resume/poly_automate.tex` et `cours-src/langage/kleene/resume/poly_kleene.tex`.

Le sujet complet est conservé dans `concours/19/mines-ponts-2019-mp-informatique.typ`.
L’exercice existant sur les résiduels et la minimisation aborde une autre construction ; il ne duplique pas ce sujet sur les morphismes.
Les sources originales ne sont pas modifiées.

## Corrections et adaptations

- **Question 36 :** inverser le sens du chemin recherché, de `(p,q)` vers une paire de caractères finaux différents. Le sujet original demandait les paires atteignables *depuis* une telle paire, ce qui ne calcule pas la distinguabilité nécessaire à la question 37. Le contre-exemple à deux états et le parcours des listes de prédécesseurs du corrigé source sont conservés. La seule fonction publiée porte le nom demandé `table_de_predecesseurs` ; la variante erronée est supprimée. La question 37 utilise cette fonction corrigée. L’erreur est signalée dans la liste initiale du corrigé.
- **Question 27 :** préciser « positifs ou nuls », conformément à l’exemple, et limiter l’exigence sur le premier élément au cas non vide. Le code du corrigé source traite déjà le tableau vide. Conserver le coût `O(n+M+1)`, où `M` est le maximum, plutôt qu’un coût linéaire en la seule longueur.
- **Question 7 :** remplacer `List.rev`, absent des listes de fonctions du résumé du programme, par une fonction locale de renversement ; le parcours, son ordre et sa complexité sont inchangés. Rappeler `List.iter` et `Array.make_matrix` dans les préliminaires.
- Appliquer les conventions de la banque : OCaml, « régulier », titres de parties romains, figures CeTZ/finite. Omettre la page de garde administrative du concours. Conserver les définitions, les 37 questions dans leur ordre, les arguments du corrigé et toutes les transitions des figures.
- Afficher les commentaires du jury en italique après les questions concernées. Placer les remarques générales et les erreurs de l’énoncé initial au début du corrigé, en liste simple, sans source affichée. Les synthèses sont documentées dans les sources ; le diagnostic sur la question 36 provient de la vérification de l’énoncé et du corrigé, pas du rapport du jury. Les blocs de contexte sont masqués dans le corrigé.

## Vérifications

`make check` compile l’énoncé, le corrigé et les modèles, valide les métadonnées, puis exécute :

- `test.ml` : dix groupes de tests, dont un oracle indépendant d’équivalence par parcours du produit, la régression sur le sens des arcs et la minimalité du résultat ;
- `test.typ` : 37 solutions, répartition des cinq parties, durée au format heures/minutes et commentaires associés aux questions ; témoins de rendu pour vérifier les remarques initiales, le masquage du contexte, l’ordre et l’italique des commentaires ainsi que la conservation des figures des solutions.

Le code OCaml affiché est lu directement dans `corrige.ml`, qui est aussi chargé par les tests.
Les PDF générés ne sont pas inspectés.
