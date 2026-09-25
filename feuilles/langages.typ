#import "/lib/exercices.typ": feuille
#import "/exercices/langage/ensembles-inevitables.typ": ex as ensembles-inevitables

#show: feuille.with(
  titre: ensembles-inevitables.meta.titre,
  niveau: "MPI",
  auteur: "Q. Fortier",
  exercices: (ensembles-inevitables,),
  corrige: sys.inputs.at("corrige", default: "false") == "true",
  details: sys.inputs.at("details", default: "true") == "true",
)
