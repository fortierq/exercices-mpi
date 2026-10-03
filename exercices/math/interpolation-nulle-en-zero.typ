#import "/lib/exercices.typ": exercice, question

#let ex = exercice(
  meta: (
    titre: "Interpolation avec valeur imposée en zéro",
    chapitres: (), algorithmes: (), structures: (), langages: (),
    difficulte: 3, niveaux: ("MP",), concours: none,
    matiere: "mathématiques",
  ),
  contenu: (
    [Soient $x_1, dots, x_n$ des réels non nuls deux à deux distincts.
    On considère la matrice $M=(x_i^j)_(1 <= i,j <= n)$.],
    question(
      [Calculer $det(M)$ et montrer que $M$ est inversible.],
      solution: [On extrait $x_i$ de la ligne $i$. Il reste la matrice de Vandermonde
      $(x_i^(j-1))_(1 <= i,j <= n)$, d'où
      $det(M)=(∏_(i=1)^n x_i) ∏_(1 <= i < j <= n) (x_j-x_i)$.
      Tous les facteurs sont non nuls.],
    ),
    question(
      [Pour des réels $y_1, dots, y_n$, déterminer l'unique polynôme $P$ de degré au plus $n$ tel que $P(0)=0$ et $P(x_i)=y_i$ pour tout $i$.],
      solution: [Un tel polynôme s'écrit $P(X)=X Q(X)$ avec $deg(Q) <= n-1$.
      Il suffit d'interpoler les valeurs $Q(x_i)=y_i/x_i$ :
      $P(X)=X sum_(i=1)^n frac(y_i, x_i) ∏_(j=1, j != i)^n frac(X-x_j, x_i-x_j)$.
      La formule vérifie les valeurs imposées. L'unicité résulte aussi de l'inversibilité de $M$.],
    ),
  ),
)
