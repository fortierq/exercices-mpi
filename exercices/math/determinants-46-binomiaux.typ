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
    [Pour $n>=1$, on pose $A_n=(binom(i,j-1))_(1<=i,j<=n)$, avec $binom(i,k)=0$ si $k>i$, et $D_n=det A_n$.],
    question(
      [Calculer $D_n$.],
      solution: [Pour $i$ allant de $n$ à $2$, remplaçons $L_i$ par $L_i-L_(i-1)$.
      La formule de Pascal donne $binom(i,j-1)-binom(i-1,j-1)=binom(i-1,j-2)$.
      La première colonne devient $(1,0,dots,0)^T$ ; le bloc obtenu en supprimant la première ligne et la première colonne est précisément $A_(n-1)$.
      Ainsi $D_n=D_(n-1)$. Comme $D_1=1$, on a $D_n=1$ pour tout $n>=1$.],
    ),
  ),
)
