#import "/lib/exercices.typ": exercice, question

// Source : Déterminants, exercice 43 (mp.cpgedupuydelome.fr, 2017).
#let ex = exercice(
  meta: (
    titre: "Déterminant antisymétrique à coefficients constants",
    chapitres: (), algorithmes: (), structures: (), langages: (),
    difficulte: 2, niveaux: ("MP",), concours: none,
    matiere: "mathématiques",
  ),
  contenu: (
    [Pour $n>=1$, on pose
    $D_n=mat(delim: "|",
      0, 1, dots.h, 1;
      -1, 0, dots.h, 1;
      dots.v, dots.v, dots.down, dots.v;
      -1, -1, dots.h, 0)$.],
    question(
      [Calculer $D_n$ en établissant une relation de récurrence.],
      solution: [Pour $n>=3$, effectuons $C_1 arrow C_1+C_n$, puis $L_1 arrow L_1+L_n$.
      La première ligne de la matrice obtenue n'a qu'un coefficient non nul, $1$ en dernière position ; la première colonne n'a plus qu'un coefficient non nul, $-1$ en dernière position.
      Deux développements successifs, suivant cette ligne puis cette colonne, donnent $D_n=D_(n-2)$.
      Comme $D_1=0$ et $D_2=1$, on trouve $D_n=(1+(-1)^n)/2$.],
    ),
  ),
)
