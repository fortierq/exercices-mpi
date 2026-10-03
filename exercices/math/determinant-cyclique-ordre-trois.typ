#import "/lib/exercices.typ": exercice, question

#let ex = exercice(
  meta: (
    titre: "Déterminant cyclique d'ordre trois",
    chapitres: (), algorithmes: (), structures: (), langages: (),
    difficulte: 1, niveaux: ("MP",), concours: none,
    matiere: "mathématiques",
  ),
  contenu: (
    [Pour $t in RR$, on pose $A_t = mat(1, t, 0; 0, 1, t; t, 0, 1)$.],
    question(
      [Calculer $det(A_t)$, puis déterminer les valeurs de $t$ pour lesquelles $A_t$ est inversible.],
      solution: [Le développement selon la première ligne donne
      $det(A_t) = 1 + t^3$.
      Sur $RR$, cette quantité s'annule exactement pour $t = -1$.
      Ainsi $A_t$ est inversible si et seulement si $t != -1$.],
    ),
  ),
)
