#import "/lib/exercices.typ": exercice, question

// Source : Déterminants, exercice 33 (mp.cpgedupuydelome.fr, 2017).
#let ex = exercice(
  meta: (
    titre: "Vandermonde et sommes cycliques",
    chapitres: (), algorithmes: (), structures: (), langages: (),
    difficulte: 2, niveaux: ("MP",), concours: none,
    matiere: "mathématiques",
  ),
  contenu: (
    [Soient $a,b,c in K$.],
    question(
      [Calculer $det mat(a,b,c; a^2,b^2,c^2; a^3,b^3,c^3)$.],
      solution: [On extrait $a$, $b$, $c$ des trois colonnes.
      Le déterminant restant est un Vandermonde :
      $det mat(a,b,c; a^2,b^2,c^2; a^3,b^3,c^3)
      = a b c (b-a)(c-a)(c-b)$.],
    ),
    question(
      [En déduire
      $det mat(a+b,b+c,c+a; a^2+b^2,b^2+c^2,c^2+a^2; a^3+b^3,b^3+c^3,c^3+a^3)$.],
      solution: [Si $C_a,C_b,C_c$ sont les colonnes de la matrice précédente,
      les nouvelles colonnes sont $C_a+C_b$, $C_b+C_c$, $C_c+C_a$.
      La matrice de ce changement de colonnes a pour déterminant $2$.
      Le résultat vaut donc $2 a b c (b-a)(c-a)(c-b)$.],
    ),
  ),
)
