#import "/lib/exercices.typ": exercice, question

// Source : Déterminants, exercice 53 (mp.cpgedupuydelome.fr, 2017).
#let ex = exercice(
  meta: (
    titre: "Déterminant tridiagonal à diagonale double",
    chapitres: (), algorithmes: (), structures: (), langages: (),
    difficulte: 3, niveaux: ("MP",), concours: none,
    matiere: "mathématiques",
  ),
  contenu: (
    [Soit $a in RR$ non nul. Pour $n>=1$, on pose
    $D_n=mat(delim: "|",
      2a, a, 0, dots.h, 0;
      a, 2a, a, dots.down, dots.v;
      0, a, dots.down, dots.down, 0;
      dots.v, dots.down, dots.down, 2a, a;
      0, dots.h, 0, a, 2a)$.],
    question(
      [Calculer $D_n$.],
      solution: [On pose $D_0=1$ ; alors $D_1=2a$.
      Un développement suivant la dernière ligne, puis la dernière colonne du mineur utile, donne $D_n=2a D_(n-1)-a^2 D_(n-2)$ pour $n>=2$.
      Comme $a!=0$, posons $u_n=D_n/a^n$. Alors $u_n=2u_(n-1)-u_(n-2)$, avec $u_0=1$ et $u_1=2$.
      Les différences successives de $(u_n)$ valent donc toutes $1$, d'où $D_n=(n+1)a^n$.],
    ),
  ),
)
