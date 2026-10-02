#import "/lib/exercices.typ": feuille
#import "/exercices/langages/lemme-arden.typ": ex as arden
#import "/exercices/langages/palindromes-et-rationalite.typ": ex as palindromes
#import "/exercices/langages/ensembles-inevitables.typ": ex as inevitables
#import "/exercices/langages/mots-de-dyck.typ": ex as dyck

#show: feuille.with(
  titre: "Colle : langages et automates",
  niveau: "MPI",
  auteur: "Q. Fortier",
  concours: none,
  exercices: (arden, palindromes, inevitables),
  corrige: sys.inputs.at("corrige", default: "false") == "true",
)
