#import "/lib/exercices.typ": exercice, question

// Source : Déterminants, exercice 31 (mp.cpgedupuydelome.fr, 2017).
#let ex = exercice(
  meta: (
    titre: "Déterminant des sommes partielles",
    chapitres: (), algorithmes: (), structures: (), langages: (),
    difficulte: 1, niveaux: ("MP",), concours: none,
    matiere: "mathématiques",
  ),
  contenu: (
    [Soit $n>=1$ et, pour $1<=k<=n$, $S_k=sum_(i=1)^k i$.],
    question(
      [Calculer $det (S_(min(i,j)))_(1<=i,j<=n)$.],
      solution: [Pour $i$ allant de $n$ à $2$, remplaçons la ligne $L_i$ par $L_i-L_(i-1)$.
      La ligne obtenue a ses $i-1$ premiers coefficients nuls, puis seulement des coefficients égaux à $S_i-S_(i-1)=i$.
      La matrice est triangulaire supérieure de diagonale $1,2,dots,n$ ; son déterminant vaut $n!$.],
    ),
  ),
)
