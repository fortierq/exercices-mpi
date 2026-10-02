#import "/lib/exercices.typ": feuille
#import "/exercices/langages/determinisation-automate-quatre-etats.typ": ex as determinisation
#import "/exercices/langages/cloture-miroir-prefixes-suffixes-facteurs.typ": ex as cloture
#import "/exercices/langages/reconnaissable-ou-non.typ": ex as reconnaissable
#import "/exercices/langages/algorithmes-vacuite-finitude-equivalence.typ": ex as algorithmes
#import "/exercices/langages/longueur-discriminante-automates.typ": ex as longueur
#import "/exercices/langages/ensembles-distinguants-automates.typ": ex as distinguant
#import "/exercices/langages/automates-palindromes.typ": ex as palindromes

// Source : cours-src/langage/automate/td/td_automate.tex.
// L'exercice ENS déjà converti conserve sa numérotation officielle (0 à 6).
#show: feuille.with(
  titre: "Automates",
  niveau: "MPI",
  auteur: "Q. Fortier",
  exercices: (determinisation, cloture, reconnaissable, algorithmes, longueur, distinguant, palindromes),
  corrige: sys.inputs.at("corrige", default: "false") == "true",
)
