#import "/lib/exercices.typ": exercice, question

// Source : Déterminants, exercice 22 (mp.cpgedupuydelome.fr, 2017).
#let ex = exercice(
  meta: (
    titre: "Somme des autres colonnes",
    chapitres: (), algorithmes: (), structures: (), langages: (),
    difficulte: 2, niveaux: ("MP",), concours: none,
    matiere: "mathématiques",
  ),
  contenu: (
    [Soit $A in M_n(RR)$, avec $n >= 2$, de colonnes $A_1, dots, A_n$.
    La matrice $B$ a pour colonnes $B_1, dots, B_n$ définies par
    $B_j=sum_(i=1, i != j)^n A_i$.],
    question(
      [Exprimer $det(B)$ en fonction de $det(A)$.],
      solution: [On a $sum_(j=1)^n B_j=(n-1)sum_(i=1)^n A_i$.
      Remplaçons $B_1$ par la somme des colonnes de $B$.
      La première colonne devient $(n-1)sum_(i=1)^n A_i$.
      Pour $j >= 2$, retranchons ensuite $B_1/(n-1)$ à la colonne $j$ ; elle devient $-A_j$.
      En développant la première colonne par multilinéarité, seul le terme en $A_1$ subsiste.
      Donc $det(B)=(-1)^(n-1)(n-1)det(A)$.],
    ),
  ),
)
