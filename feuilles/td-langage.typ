#import "/lib/exercices.typ": feuille
#import "/exercices/langage/mots-qui-commutent.typ": ex as commutation
#import "/exercices/langage/mots-de-fibonacci.typ": ex as fibonacci
#import "/exercices/langage/regles-expressions-regulieres.typ": ex as regles
#import "/exercices/langage/exemples-langages-reguliers.typ": ex as exemples
#import "/exercices/langage/distance-de-hamming.typ": ex as hamming
#import "/exercices/langage/cloture-sur-mots.typ": ex as sur-mots

#show: feuille.with(
  titre: "Langages réguliers",
  niveau: "MPI",
  auteur: "Q. Fortier",
  exercices: (commutation, fibonacci, regles, exemples, hamming, sur-mots),
  corrige: sys.inputs.at("corrige", default: "false") == "true",
  details: sys.inputs.at("details", default: "false") == "true",
)
