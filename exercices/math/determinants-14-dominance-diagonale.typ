#import "/lib/exercices.typ": exercice, question

// Source : Déterminants, exercice 14 (mp.cpgedupuydelome.fr, 2017).
#let ex = exercice(
  meta: (
    titre: "Dominance diagonale stricte",
    chapitres: (), algorithmes: (), structures: (), langages: (),
    difficulte: 3, niveaux: ("MP",), concours: none,
    matiere: "mathématiques",
  ),
  contenu: (
    [Soit $A=(a_(i,j)) in M_n(RR)$, où $n>=1$, telle que
    $forall i in \{1,dots,n\}, abs(a_(i,i)) > sum_(j=1, j != i)^n abs(a_(i,j))$.],
    question(
      [Montrer que $A$ est inversible.],
      solution: [Supposons $A X=0$ et choisissons $i$ tel que $abs(x_i)=max_j abs(x_j)$.
      Si $X != 0$, alors $abs(x_i)>0$, tandis que la ligne $i$ de $A X=0$ donne
      $abs(a_(i,i)) abs(x_i) <= sum_(j != i) abs(a_(i,j)) abs(x_j) <= abs(x_i) sum_(j != i) abs(a_(i,j))$.
      Après division par $abs(x_i)$, cela contredit l'hypothèse. Le noyau de $A$ est nul ; $A$ est donc inversible.],
    ),
    question(
      [On suppose en outre $a_(i,i)>0$ pour tout $i$. Montrer que $det A>0$.],
      solution: [Pour $t>=0$, les coefficients diagonaux de $A+t I_n$ sont $a_(i,i)+t>0$ et la dominance diagonale stricte est conservée.
      D'après la question précédente, $det(A+t I_n) != 0$ pour tout $t>=0$.
      Ce déterminant est un polynôme réel en $t$, de coefficient dominant $1$ ; il est donc positif pour $t$ assez grand.
      Par continuité, son signe est constant sur $[0,+infinity[$, d'où $det A>0$.],
    ),
  ),
)
