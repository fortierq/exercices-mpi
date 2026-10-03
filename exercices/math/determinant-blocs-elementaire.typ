#import "/lib/exercices.typ": exercice, question

#let ex = exercice(
  meta: (
    titre: "Déterminant triangulaire par blocs",
    chapitres: (), algorithmes: (), structures: (), langages: (),
    difficulte: 1, niveaux: ("MP",), concours: none,
    matiere: "mathématiques",
  ),
  contenu: (
    [On considère $M = mat(A, B; 0, D)$, où $A = mat(1, 2; 3, 5)$,
    $D=mat(2, 1; 1, 1)$ et $B$ est une matrice réelle quelconque de taille $2 times 2$.],
    question(
      [Calculer $det(M)$ et dire si $M$ est inversible, indépendamment du choix de $B$.],
      solution: [La propriété triangulaire par blocs donne
      $det(M)=det(A)det(D)=(5-6)(2-1)=-1$.
      Ainsi $M$ est inversible pour tout $B$.],
    ),
  ),
)
