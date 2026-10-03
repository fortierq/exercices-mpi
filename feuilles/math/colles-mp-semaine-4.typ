#import "/lib/exercices.typ": feuille, afficher-exercice, bloc-solution
#import "/exercices/math/determinant-cyclique-ordre-trois.typ": ex as cyclique
#import "/exercices/math/determinant-perturbation-rang-un.typ": ex as rang-un
#import "/exercices/math/vandermonde-trois-points.typ": ex as vandermonde
#import "/exercices/math/interpolation-nulle-en-zero.typ": ex as interpolation
#import "/exercices/math/determinant-blocs-elementaire.typ": ex as blocs
#import "/exercices/math/determinant-schur-blocs.typ": ex as schur

// Programme « semaine 4 », reçu dans le mail Gmail 1a10223c3e6d40ec du 3 octobre 2026.
#let corrige = sys.inputs.at("corrige", default: "false") == "true"

#show: feuille.with(
  type: "colle",
  titre: "Colles MP - semaine 4",
  niveau: "MP",
  exercices: (cyclique, rang-un, vandermonde, interpolation, blocs, schur),
  corrige: corrige,
  afficher-exercices: false,
  en-tete: false,
  pied-de-page: false,
  marge: (x: 10mm, top: 12mm, bottom: 12mm),
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
  (cours: cours.at(0), facile: cyclique, difficile: rang-un),
  (cours: cours.at(1), facile: vandermonde, difficile: interpolation),
  (cours: cours.at(2), facile: blocs, difficile: schur),
)

#let composer-sujet(numero, sujet, avec-solutions: false) = {
  heading(level: 2)[Sujet #numero]
  heading(level: 3)[Question de cours]
  sujet.cours.nom
  if avec-solutions { bloc-solution(sujet.cours.preuve) }
  heading(level: 3)[Exercice 1]
  afficher-exercice(sujet.facile, corrige: avec-solutions, afficher-titre: false)
  heading(level: 3)[Exercice 2]
  afficher-exercice(sujet.difficile, corrige: avec-solutions, afficher-titre: false)
}

#set text(size: 10pt)
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
