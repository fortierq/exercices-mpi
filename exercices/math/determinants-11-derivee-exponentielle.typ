#import "/lib/exercices.typ": exercice, question

// Source : Déterminants, exercice 11 (mp.cpgedupuydelome.fr, 2017).
#let ex = exercice(
  meta: (
    titre: "Déterminant de la dérivation sur un espace de fonctions",
    chapitres: (), algorithmes: (), structures: (), langages: (),
    difficulte: 1, niveaux: ("MP",), concours: none,
    matiere: "mathématiques",
  ),
  contenu: (
    [Soit $n in NN$ et $V=\{x arrow e^x P(x) | P in RR_n[X]\}$.],
    question(
      [Montrer que $V$ est un sous-espace vectoriel de l'espace des fonctions de $RR$ dans $RR$ et déterminer sa dimension.],
      solution: [L'application $P mapsto (x mapsto e^x P(x))$ est linéaire et injective, car $e^x$ ne s'annule jamais. Son image est $V$.
      Ainsi, $V$ est un sous-espace de dimension $dim RR_n[X]=n+1$.
      Une base est $(x mapsto e^x x^k)_(0 <= k <= n)$.],
    ),
    question(
      [Montrer que $D:f mapsto f'$ est un endomorphisme de $V$ et calculer son déterminant.],
      solution: [Pour $f_P(x)=e^x P(x)$, on a $f_P'(x)=e^x(P(x)+P'(x))$ ; le polynôme $P+P'$ appartient à $RR_n[X]$.
      La dérivation est linéaire, donc $D$ est un endomorphisme de $V$.
      Dans la base précédente, $D(f_k)=f_k+k f_(k-1)$ pour $k>=1$, et $D(f_0)=f_0$.
      Sa matrice est triangulaire, avec des $1$ sur la diagonale ; donc $det D=1$.],
    ),
  ),
)
