#import "/lib/exercices.typ": exercice, question

#let ex = exercice(
  meta: (
    titre: "Vandermonde et interpolation en trois points",
    chapitres: (), algorithmes: (), structures: (), langages: (),
    difficulte: 1, niveaux: ("MP",), concours: none,
    matiere: "mathématiques",
  ),
  contenu: (
    [Soient $a, b, c$ trois réels distincts et
    $V = mat(1, a, a^2; 1, b, b^2; 1, c, c^2)$.],
    question(
      [Calculer $det(V)$ et justifier que $V$ est inversible.],
      solution: [La formule de Vandermonde donne
      $det(V)=(b-a)(c-a)(c-b) != 0$ puisque $a,b,c$ sont distincts.],
    ),
    question(
      [Pour $alpha, beta, gamma in RR$, donner l'unique polynôme $P$ de degré au plus deux tel que $P(a)=alpha$, $P(b)=beta$ et $P(c)=gamma$.],
      solution: [L'application d'évaluation dans la base $(1,X,X^2)$ a pour matrice $V$ ; elle est donc bijective.
      L'unique polynôme est
      $P(X)=alpha frac((X-b)(X-c), (a-b)(a-c)) + beta frac((X-a)(X-c), (b-a)(b-c)) + gamma frac((X-a)(X-b), (c-a)(c-b))$.],
    ),
  ),
)
