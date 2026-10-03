#import "/lib/exercices.typ": exercice, question

// Source : Déterminants, exercice 77 (mp.cpgedupuydelome.fr, 2017).
#let ex = exercice(
  meta: (
    titre: "Inversibilité d'une matrice à blocs répétés",
    chapitres: (), algorithmes: (), structures: (), langages: (),
    difficulte: 3, niveaux: ("MP",), concours: none,
    matiere: "mathématiques",
  ),
  contenu: (
    [Soit $B in M_n(RR)$ et
    $A=mat(I_n,B; B,I_n) in M_(2n)(RR)$.],
    question(
      [À quelle condition $A$ est-elle inversible ?],
      solution: [Les opérations $L_(n+i) <- L_(n+i)-sum_(j=1)^n b_(i,j)L_j$, pour $1 <= i <= n$,
      rendent la matrice triangulaire par blocs, de diagonale $I_n$ et $I_n-B^2$.
      Donc $det(A)=det(I_n-B^2)=det(I_n-B)det(I_n+B)$.
      Ainsi $A$ est inversible si et seulement si $I_n-B^2$ l'est, ou encore si $I_n-B$ et $I_n+B$ le sont.],
    ),
    question(
      [Donner son inverse lorsqu'elle est inversible.],
      solution: [Posons $T=(I_n-B^2)^(-1)$. Comme $B$ commute avec $I_n-B^2$, il commute avec $T$.
      Un produit direct montre que
      $A^(-1)=mat(T,-B T; -B T,T)$.],
    ),
  ),
)
