#import "/lib/exercices.typ": feuille, afficher-exercice, bloc-solution
#import "/exercices/math/determinant-max-indices.typ": ex as max-indices
#import "/exercices/math/rang-comatrice.typ": ex as comatrice
#import "/exercices/math/determinant-perturbation-rang-un.typ": ex as rang-un
#import "/exercices/math/vandermonde-sommes-cycliques.typ": ex as sommes-cycliques
#import "/exercices/math/interpolation-puissances-trois-quatre.typ": ex as puissances
#import "/exercices/math/interpolation-nulle-en-zero.typ": ex as interpolation
#import "/exercices/math/somme-autres-colonnes.typ": ex as autres-colonnes
#import "/exercices/math/blocs-symetriques-inverse.typ": ex as blocs-symetriques
#import "/exercices/math/determinant-schur-blocs.typ": ex as schur

// Programme « semaine 4 », reçu dans le mail Gmail 1a10223c3e6d40ec du 3 octobre 2026.
#let corrige = sys.inputs.at("corrige", default: "false") == "true"

#show: feuille.with(
  type: "colle",
  titre: "Colles MP - semaine 4",
  niveau: "MP",
  exercices: (
    max-indices, rang-un, comatrice,
    sommes-cycliques, puissances, interpolation,
    autres-colonnes, blocs-symetriques, schur,
  ),
  corrige: corrige,
  afficher-exercices: false,
)

#let cours = (
  (
    nom: [Identité de la comatrice.],
    preuve: [Pour $A in M_n(RR)$, on note $"adj"(A)="Com"(A)^T$.
    L'entrée $(i,j)$ de $A "adj"(A)$ vaut
    $sum_(k=1)^n a_(i,k) "Com"(A)_(j,k)$.
    Si $i=j$, le développement suivant la ligne $i$ donne $det(A)$.
    Si $i != j$, cette somme est le déterminant de la matrice obtenue en remplaçant la ligne $j$ par la ligne $i$ ; il est nul.
    Ainsi $A "adj"(A)=det(A)I_n$.
    Le même raisonnement avec les colonnes donne $"adj"(A)A=det(A)I_n$.],
  ),
  (
    nom: [Déterminant de Vandermonde et lien avec l'interpolation de Lagrange.],
    preuve: [Pour $x_1, dots, x_n in RR$,
    $det (x_i^(j-1))_(1 <= i,j <= n) = ∏_(1 <= i < j <= n)(x_j-x_i)$.
    Le déterminant est un polynôme alterné en les $x_i$ ; il est divisible par chaque $x_j-x_i$.
    Son degré total est $n(n-1)/2$, celui du produit, et le coefficient de $x_2 x_3^2 dots x_n^(n-1)$ vaut $1$ des deux côtés.
    Si les $x_i$ sont distincts, le déterminant est non nul : l'application qui associe à un polynôme de degré inférieur à $n$ ses valeurs en ces points est bijective.
    Son inverse est donné par les polynômes de Lagrange
    $L_i(X)=∏_(j=1, j != i)^n frac(X-x_j, x_i-x_j)$.],
  ),
  (
    nom: [Déterminant d'une matrice triangulaire par blocs.],
    preuve: [Si $A$ et $D$ sont carrées, alors
    $det mat(A,B;0,D)=det(A)det(D)$.
    Dans la formule de Leibniz, un terme non nul doit envoyer les lignes du bloc inférieur vers les colonnes du bloc inférieur, puisque le bloc inférieur gauche est nul.
    La permutation se décompose alors en une permutation des indices de $A$ et une des indices de $D$ ; la somme des termes se factorise en $det(A)det(D)$.
    Le même résultat vaut pour une matrice triangulaire inférieure par blocs.],
  ),
)

#let sujets = (
  (cours: cours.at(0), exercices: (max-indices, rang-un, comatrice)),
  (cours: cours.at(1), exercices: (sommes-cycliques, puissances, interpolation)),
  (cours: cours.at(2), exercices: (autres-colonnes, blocs-symetriques, schur)),
)

#let composer-sujet(numero, sujet, avec-solutions: false) = {
  heading(level: 2)[Sujet #numero]
  heading(level: 3)[Question de cours]
  sujet.cours.nom
  if avec-solutions { bloc-solution(sujet.cours.preuve) }
  for (j, ex) in sujet.exercices.enumerate(start: 1) {
    afficher-exercice(ex, numero: j, corrige: avec-solutions)
  }
}

#heading(level: 1)[Programme de colle]
#heading(level: 2)[IV - Déterminants (rappels)]
- Définitions du déterminant d'une famille de vecteurs dans une base, d'une matrice et d'un endomorphisme.
- Formule du déterminant à l'aide des permutations.
- Caractérisations des bases, de la bijectivité et de l'inversibilité par le déterminant.
- Propriétés (lorsque les inverses existent) : $det(A B)=det(A)det(B)$, $det(A^(-1))=1/det(A)$,
  $det(P^(-1) A P)=det(A)$, $det(lambda A)=lambda^n det(A)$ et $det(A^T)=det(A)$.
- Déterminant d'une matrice triangulaire ; calcul par opérations sur les lignes ou les colonnes et développement suivant une ligne ou une colonne.
- Comatrice et relation $A "Com"(A)^T="Com"(A)^T A=det(A)I_n$.
- Déterminants triangulaires par blocs et transvections par blocs.
- Déterminant de Vandermonde et lien avec l'interpolation de Lagrange.

Questions de cours prévues : identité de la comatrice ; expression du déterminant de Vandermonde et lien avec l'interpolation de Lagrange ; déterminant triangulaire par blocs.

#pagebreak()
#heading(level: 1)[Énoncés]
#for (i, sujet) in sujets.enumerate(start: 1) {
  if i > 1 { pagebreak() }
  composer-sujet(i, sujet)
}

#if corrige {
  pagebreak()
  heading(level: 1)[Corrections]
  for (i, sujet) in sujets.enumerate(start: 1) {
    if i > 1 { pagebreak() }
    composer-sujet(i, sujet, avec-solutions: true)
  }
}
