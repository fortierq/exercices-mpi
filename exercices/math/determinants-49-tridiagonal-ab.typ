#import "/lib/exercices.typ": exercice, question

// Source : Déterminants, exercice 49 (mp.cpgedupuydelome.fr, 2017).
#let ex = exercice(
  meta: (
    titre: "Déterminant tridiagonal à deux paramètres",
    chapitres: (), algorithmes: (), structures: (), langages: (),
    difficulte: 3, niveaux: ("MP",), concours: none,
    matiere: "mathématiques",
  ),
  contenu: (
    [Soient $a,b in RR$. Pour $n>=1$, on note $D_n$ le déterminant de la matrice tridiagonale d'ordre $n$ dont la diagonale vaut $a+b$, la surdiagonale $b$ et la sous-diagonale $a$.],
    question(
      [Calculer $D_n$.],
      solution: [Avec la convention $D_0=1$, on a $D_1=a+b$. Le développement suivant la dernière ligne, puis la dernière colonne du mineur utile, donne pour $n>=2$
      $D_n=(a+b)D_(n-1)-a b D_(n-2)$.
      Si $a!=b$, les deux suites $(a^n)$ et $(b^n)$ satisfont cette récurrence ; les conditions initiales donnent
      $D_n=(a^(n+1)-b^(n+1))/(a-b)$.
      Si $a=b$, la racine caractéristique est double, et les mêmes conditions donnent $D_n=(n+1)a^n$ pour $n>=1$ ; cette formule vaut aussi pour $a=b=0$.],
    ),
  ),
)
