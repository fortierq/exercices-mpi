#import "/lib/exercices.typ": exercice, question

// Source : Déterminants, exercice 46 (mp.cpgedupuydelome.fr, 2017).
#let ex = exercice(
  meta: (
    titre: "Déterminant de coefficients binomiaux",
    chapitres: (), algorithmes: (), structures: (), langages: (),
    difficulte: 2, niveaux: ("MP",), concours: none,
    matiere: "mathématiques",
  ),
  contenu: (
    [Pour $n>=1$, en convenant que $binom(i,k)=0$ si $k>i$, on pose
    $D_n=mat(delim: "|",
      binom(1,0), binom(1,1), 0, dots.h, 0;
      binom(2,0), binom(2,1), binom(2,2), dots.h, 0;
      dots.v, dots.v, dots.v, dots.down, dots.v;
      binom(n,0), binom(n,1), binom(n,2), dots.h, binom(n,n-1))$.],
    question(
      [Calculer $D_n$.],
      solution: [Pour $i$ allant de $n$ à $2$, remplaçons $L_i$ par $L_i-L_(i-1)$.
      La formule de Pascal donne $binom(i,j-1)-binom(i-1,j-1)=binom(i-1,j-2)$.
      La première colonne devient $(1,0,dots,0)^T$ ; le bloc obtenu en supprimant la première ligne et la première colonne est précisément $A_(n-1)$.
      Ainsi $D_n=D_(n-1)$. Comme $D_1=1$, on a $D_n=1$ pour tout $n>=1$.],
    ),
  ),
)
