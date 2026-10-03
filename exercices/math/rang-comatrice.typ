#import "/lib/exercices.typ": exercice, question

// Source : Déterminants, exercice 67 (mp.cpgedupuydelome.fr, 2017).
#let ex = exercice(
  meta: (
    titre: "Rang et déterminant de la comatrice",
    chapitres: (), algorithmes: (), structures: (), langages: (),
    difficulte: 4, niveaux: ("MP",), concours: none,
    matiere: "mathématiques",
  ),
  contenu: (
    [Soient $n >= 2$ et $A in M_n(K)$. On note $"Com"(A)$ sa comatrice.],
    question(
      [Établir que $"rg"(A)=n$ implique $"rg"("Com"(A))=n$,
      que $"rg"(A)=n-1$ implique $"rg"("Com"(A))=1$,
      et que $"rg"(A) <= n-2$ implique $"rg"("Com"(A))=0$.],
      solution: [Si $A$ est inversible, $"Com"(A)^T=det(A)A^(-1)$ l'est également.
      Si $"rg"(A) <= n-2$, tous les mineurs d'ordre $n-1$ sont nuls : la comatrice est nulle.
      Si $"rg"(A)=n-1$, l'identité $A "Com"(A)^T=0$ montre que l'image de $"Com"(A)^T$ est incluse dans le noyau de $A$, de dimension $1$.
      Un mineur d'ordre $n-1$ est non nul, donc la comatrice est non nulle et son rang vaut $1$.],
    ),
    question(
      [Montrer que $det("Com"(A))=det(A)^(n-1)$.],
      solution: [Si $A$ est inversible, on prend le déterminant de
      $A "Com"(A)^T=det(A)I_n$ et on simplifie par $det(A)$.
      Si $A$ est singulière, la première question donne $"rg"("Com"(A)) <= 1 < n$ ; les deux membres sont nuls.],
    ),
    question(
      [En déduire $"Com"("Com"(A))$.],
      solution: [On obtient
      $"Com"("Com"(A))=det(A)^(n-2) A$.
      Pour $A$ inversible, appliquer deux fois l'identité de la comatrice donne cette formule.
      Si $A$ est singulière et $n >= 3$, la première question assure que la comatrice de $"Com"(A)$ est nulle, comme le membre de droite.
      Pour $n=2$, le calcul direct de la comatrice d'une matrice $2 times 2$ montre que $"Com"("Com"(A))=A$.],
    ),
  ),
)
