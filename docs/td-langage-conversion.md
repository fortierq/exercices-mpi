# Conversion du TD « Langages réguliers »

Source : `cours-src/langage/langage/td/td_langage.tex`, ainsi que ses inclusions
`exos-src/exos/language/hamming/hamming.tex` et
`exos-src/exos/language/cloture_sur_mot/cloture_sur_mot{,_cor}.tex`.
Les sources LaTeX restent inchangées. Les exercices commentés ne sont pas convertis.

La feuille `feuilles/td-langage.typ` reprend les six exercices dans l'ordre :

1. `exercices/langage/mots-qui-commutent.typ`
2. `exercices/langage/mots-de-fibonacci.typ`
3. `exercices/langage/regles-expressions-regulieres.typ`
4. `exercices/langage/exemples-langages-reguliers.typ`
5. `exercices/langage/distance-de-hamming.typ`
6. `exercices/langage/cloture-sur-mots.typ`

Les solutions sont reprises dans les fichiers des exercices. Les conditions de
commutation forment une sous-liste dans une seule question. Les métadonnées de
difficulté sont des estimations ; aucune date de concours n'est inventée.
L'attribution « oral ENS info » est conservée dans le dernier titre et sa référence.

## Corrections importantes

- **Commutation** : les trois conditions ne sont pas équivalentes lorsque l'un
  seulement des deux mots est vide (prendre `u = ε`, `v = a`). L'hypothèse
  « non vides » est ajoutée, et le cas initial de la récurrence adapté.
  « Les deux conditions » devient « les trois conditions ».
- **Fibonacci** : `g₂` est utilisé par le corrigé alors que la définition commence
  à 3 ; elle commence désormais à 2. La récurrence et ses arguments sont conservés.
- **Hamming** : la distance est définie sur `Σⁿ` pour chaque longueur `n`, pas
  sur tout `Σ*`. La contrainte d'égalité des longueurs est explicite dans le voisinage.
  L'alphabet est fini, et binaire pour les questions qui utilisent `0` et `1`.
  Le nombre de voisins d'un mot est `1 + |u| (|Σ| − 1)`, et non simplement `|u|`.
  L'identité de l'étoile devient `H(L*) = {ε} ∪ L* H(L) L*` : sans `{ε}`, elle
  échoue pour `L = ∅`. Le programme OCaml est corrigé de la même manière ; son type
  est `int regexp -> int regexp`, puisque les lettres sont les entiers 0 et 1.
- **Sur-mots** : l'alphabet est explicitement fini et non vide, hypothèses utilisées
  par les preuves. Le corrigé de la question d'effectivité commentée dans l'énoncé
  est omis ; les réponses sur les sous-mots et sur Higman retrouvent les questions
  7 et 8. Les références internes erronées et les variables incohérentes de la
  transitivité sont corrigées. Dans la preuve de Higman, les indices de la
  sous-suite sont explicitement `i₀ < i₁ < …`, ce qui répare les identifications
  fausses entre indices de la suite et indices de la sous-suite.

## Clarifications nécessaires à la transcription

Le mot « immédiatement » précise « précédé d'un b » conformément à l'expression
régulière du corrigé. Le développement décimal choisi exclut les queues infinies
de 9 ; les décimaux se prolongent par des zéros. Les appartenances et inclusions
portent explicitement sur les langages dénotés par les expressions régulières.
Les expressions, l'ordre des questions et les méthodes de preuve sont conservés.

## Utilisation

```sh
nix develop path:.
make watch-feuille FEUILLE=td-langage
make watch-feuille FEUILLE=td-langage CORRIGE=true
```

Le PDF de prévisualisation est `build/feuilles/td-langage-apercu.pdf`.
Utiliser `OPEN=0` pour surveiller sans ouvrir VS Code. Pour surveiller simultanément
les deux variantes, utiliser des sorties distinctes en appelant Typst directement :
les deux commandes ci-dessus partagent la même sortie de prévisualisation.
