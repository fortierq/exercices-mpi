#import "/lib/exercices.typ": exercice
#import "/sujets/centrale-2022-mp-informatique.typ": palindromes

// La partie est partagée avec le sujet ; seuls ses rappels sont ajoutés ici.
#let ex = exercice(
  meta: (..palindromes.meta, titre: palindromes.titre, niveaux: ("MPI", "MP")),
  contenu: palindromes.contexte + palindromes.contenu,
)
