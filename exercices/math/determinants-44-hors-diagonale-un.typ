#import "/lib/exercices.typ": exercice, question

// Source : Déterminants, exercice 44 (mp.cpgedupuydelome.fr, 2017).
#let ex = exercice(
  meta: (
    titre: "Zéros sur la diagonale, uns ailleurs",
    chapitres: (), algorithmes: (), structures: (), langages: (),
    difficulte: 2, niveaux: ("MP",), concours: none,
    matiere: "mathématiques",
  ),
  contenu: (
    [Pour $n>=1$, on pose
    $D_n=mat(delim: "|",
      0, 1, dots.h, 1;
      1, 0, dots.h, 1;
      dots.v, dots.v, dots.down, dots.v;
      1, 1, dots.h, 0)$.],
    question(
      [Calculer $D_n$ en établissant une relation de récurrence.],
      solution: [Pour $n>=3$, les opérations $C_1 arrow C_1-C_n$, puis $L_1 arrow L_1-L_n$ transforment la première ligne en $(-2,0,dots,0,1)$ et la première colonne en sa transposée.
      Le développement suivant la première ligne donne $-2D_(n-1)$, puis un second développement dans le terme restant donne $-D_(n-2)$.
      Donc $D_n=-2D_(n-1)-D_(n-2)$. Comme $D_1=0$ et $D_2=-1$, une récurrence donne $D_n=(-1)^(n-1)(n-1)$.],
    ),
  ),
)
