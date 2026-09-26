#import "/lib/exercices.typ": extraire-partie
#import "/sujets/centrale-2022-mp-informatique.typ": ex as sujet

// Une seule source pour I.B (Q6–Q12), ses définitions et ses solutions.
// L'identifiant du fichier reste inchangé pour les feuilles existantes.
#let ex = extraire-partie(sujet, "I.B", meta: (niveaux: ("MPI", "MP"),))
