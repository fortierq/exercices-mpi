#import "/lib/exercices.typ": exercice, question

// Source : Déterminants, exercice 10 (mp.cpgedupuydelome.fr, 2017).
#let ex = exercice(
  meta: (
    titre: "Endomorphisme de carré moins l'identité",
    chapitres: (), algorithmes: (), structures: (), langages: (),
    difficulte: 1, niveaux: ("MP",), concours: none,
    matiere: "mathématiques",
  ),
  contenu: (
    question(
      [Soit $E$ un espace vectoriel réel de dimension finie et $f in cal(L)(E)$ tel que $f^2=-"Id"_E$. Montrer que $dim E$ est pair.],
      solution: [En posant $n=dim E$ et en prenant les déterminants, on obtient
      $det(f)^2=det(-"Id"_E)=(-1)^n$.
      Le membre de gauche est positif ou nul. Si $n$ était impair, le membre de droite vaudrait $-1$, ce qui est impossible.],
    ),
  ),
)
