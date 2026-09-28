#import "/lib/exercices.typ": feuille
#import "/exercices/langages/langages-locaux-glushkov.typ": ex as locaux
#import "/exercices/langages/ccp-sujet0-langages-automates.typ": ex as ccp
#import "/exercices/langages/stabilite-langages-reguliers.typ": ex as stabilite
#import "/exercices/langages/kleene-programmation-dynamique.typ": ex as dynamique
#import "/exercices/langages/residuels-minimisation.typ": ex as residuels

#show: feuille.with(
  titre: "Théorème de Kleene",
  niveau: "MPI",
  exercices: (locaux, ccp, stabilite, dynamique, residuels),
  corrige: sys.inputs.at("corrige", default: "false") == "true",
  details: sys.inputs.at("details", default: "false") == "true",
)
