#import "/lib/exercices.typ": exercice, question

#let ex = exercice(
  meta: (
    titre: "Transvections par blocs et complément de Schur",
    chapitres: (), algorithmes: (), structures: (), langages: (),
    difficulte: 3, niveaux: ("MP",), concours: none,
    matiere: "mathématiques",
  ),
  contenu: (
    [Soient $A in M_p(RR)$ inversible, $D in M_q(RR)$,
    $B in M_(p,q)(RR)$ et $C in M_(q,p)(RR)$.],
    question(
      [En effectuant une transvection par blocs, calculer
      $det mat(A, B; C, D)$ à l'aide de $A$ et de $D-C A^(-1)B$.],
      solution: [On multiplie à gauche par la matrice triangulaire par blocs
      $T=mat(I_p, 0; -C A^(-1), I_q)$, de déterminant $1$.
      Alors $T mat(A,B;C,D)=mat(A,B;0,D-C A^(-1)B)$.
      La propriété triangulaire par blocs fournit
      $det mat(A,B;C,D)=det(A)det(D-C A^(-1)B)$.],
    ),
    question(
      [Pour $U,V in M_n(RR)$, en déduire
      $det mat(I_n,U;V,I_n)=det(I_n-V U)=det(I_n-U V)$.],
      solution: [La première égalité suit de la question précédente avec $A=I_n$.
      En échangeant les deux blocs de lignes et les deux blocs de colonnes, on obtient
      $mat(I_n,V;U,I_n)$ sans changer le déterminant : chaque échange a le signe $(-1)^(n^2)$.
      La même formule donne alors $det(I_n-U V)$.],
    ),
  ),
)
