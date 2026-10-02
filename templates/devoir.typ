#import "/lib/exercices.typ": fiche
#import "/templates/exercice.typ": ex

#show: fiche.with(
  type: "devoir",
  titre: "Devoir",
  niveau: "MPI",
  auteur: none,
  exercices: (ex,),
  corrige: sys.inputs.at("corrige", default: "false") == "true",
  nouvelle-page: false,
)
