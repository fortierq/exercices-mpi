#import "/lib/exercices.typ": exercice, question

#let ex = exercice(
  meta: (
    titre: "Déterminant d'une perturbation de rang un",
    chapitres: (), algorithmes: (), structures: (), langages: (),
    difficulte: 3, niveaux: ("MP",), concours: none,
    matiere: "mathématiques",
  ),
  contenu: (
    [Soient $A in M_n(RR)$ et $u, v in RR^n$, vus comme des vecteurs colonnes.
    On note $"adj"(A) = "Com"(A)^T$.],
    question(
      [Montrer que $det(A + u v^T) = det(A) + v^T "adj"(A) u$, sans supposer $A$ inversible.],
      solution: [Écrivons $A_j$ pour la $j$-ième colonne de $A$.
      La $j$-ième colonne de $A+u v^T$ est $A_j+v_j u$.
      Par multilinéarité, les termes contenant au moins deux colonnes proportionnelles à $u$ s'annulent. Donc
      $det(A+u v^T) = det(A) + sum_(j=1)^n v_j det(A_1, dots, A_(j-1), u, A_(j+1), dots, A_n)$.
      En développant le déterminant du $j$-ième terme suivant sa $j$-ième colonne, on obtient
      $det(A_1, dots, u, dots, A_n) = sum_(i=1)^n u_i "Com"(A)_(i,j) = ("adj"(A)u)_j$.
      La formule annoncée suit, même lorsque $A$ est singulière.],
    ),
    question(
      [Si $A$ est inversible, en déduire $det(A+u v^T) = det(A)(1+v^T A^(-1)u)$.],
      solution: [L'identité de la comatrice donne $"adj"(A)=det(A)A^(-1)$.
      On remplace dans la formule précédente.],
    ),
  ),
)
