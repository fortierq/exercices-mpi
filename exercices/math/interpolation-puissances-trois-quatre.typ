#import "/lib/exercices.typ": exercice, question

// Source : Déterminants, exercice 66 (mp.cpgedupuydelome.fr, 2017).
#let ex = exercice(
  meta: (
    titre: "Interpolation des puissances trois et quatre",
    chapitres: (), algorithmes: (), structures: (), langages: (),
    difficulte: 3, niveaux: ("MP",), concours: none,
    matiere: "mathématiques",
  ),
  contenu: (
    [Soient $a,b,c in CC$ deux à deux distincts.],
    question(
      [Résoudre le système
      $cases(x+a y+a^2 z=a^3, x+b y+b^2 z=b^3, x+c y+c^2 z=c^3)$
      en introduisant $P(X)=X^3-(x+y X+z X^2)$.],
      solution: [Le polynôme $P$ est unitaire de degré $3$ et s'annule en $a,b,c$.
      Donc $P(X)=(X-a)(X-b)(X-c)$.
      Par identification,
      $x=a b c$, $y=-(a b+a c+b c)$ et $z=a+b+c$.],
    ),
    question(
      [Résoudre de même
      $cases(x+a y+a^2 z=a^4, x+b y+b^2 z=b^4, x+c y+c^2 z=c^4)$.],
      solution: [Posons $s_1=a+b+c$, $s_2=a b+a c+b c$ et $s_3=a b c$.
      Le polynôme $P(X)=X^4-(x+y X+z X^2)$ s'annule en $a,b,c$ et son coefficient de $X^3$ est nul.
      Il vaut donc
      $P(X)=(X-a)(X-b)(X-c)(X+s_1)$.
      L'identification des coefficients donne
      $x=s_1 s_3$, $y=s_3-s_1 s_2$ et $z=s_1^2-s_2$.],
    ),
  ),
)
