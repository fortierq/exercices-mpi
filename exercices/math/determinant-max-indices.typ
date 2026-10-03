#import "/lib/exercices.typ": exercice, question

// Source : Déterminants, exercice 29 (mp.cpgedupuydelome.fr, 2017).
#let ex = exercice(
  meta: (
    titre: "Déterminant des coefficients d'indice maximal",
    chapitres: (), algorithmes: (), structures: (), langages: (),
    difficulte: 2, niveaux: ("MP",), concours: none,
    matiere: "mathématiques",
  ),
  contenu: (
    [Soient $a_1, dots, a_n in CC$.],
    question(
      [Calculer $det (a_(max(i,j)))_(1 <= i,j <= n)$.],
      solution: [En remplaçant successivement, de gauche à droite, la colonne $C_i$ par $C_i-C_(i+1)$ pour $1 <= i < n$, on obtient une matrice triangulaire supérieure de diagonale
      $a_1-a_2, a_2-a_3, dots, a_(n-1)-a_n, a_n$.
      Le déterminant vaut donc
      $a_n ∏_(i=1)^(n-1) (a_i-a_(i+1))$.],
    ),
    question(
      [En déduire $det (max(i,j))_(1 <= i,j <= n)$ et $det (min(i,j))_(1 <= i,j <= n)$.],
      solution: [Avec $a_i=i$, la première formule donne $(-1)^(n-1)n$.
      Avec $a_i=n+1-i$, elle donne $1$ pour la matrice de coefficients $n+1-max(i,j)$.
      En renversant simultanément l'ordre des lignes et celui des colonnes, cette matrice devient $(min(i,j))$ ; son déterminant reste $1$.],
    ),
  ),
)
