#import "/lib/exercices.typ": feuille
#import "/exercices/langages/lemme-arden.typ": ex as arden
#import "/exercices/langages/ccp-sujet0-langages-automates.typ": ex as ccp
#import "/exercices/langages/palindromes-et-rationalite.typ": ex as palindromes
#import "/exercices/langages/ensembles-inevitables.typ": ex as inevitables
#import "/exercices/langages/racine-langage.typ": ex as racine
#import "/exercices/langages/mots-de-dyck.typ": ex as dyck

#show: feuille.with(
  titre: "Colle 1 : langages et automates",
  niveau: "MPI",
  auteur: "Q. Fortier",
  exercices: (arden, ccp, palindromes, inevitables),
  corrige: sys.inputs.at("corrige", default: "false") == "true",
  details: sys.inputs.at("details", default: "false") == "true",
)
