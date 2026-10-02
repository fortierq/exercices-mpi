// Point d'entrée générique ; le contenu reste dans exercices/.
#import "/lib/exercices.typ": feuille
#let chemin = sys.inputs.at("exercice",  default: "/templates/exercice.typ")
#import chemin: ex
#show: feuille.with(
  titre: ex.meta.titre,
  niveau: ex.meta.niveaux.join(" / "),
  auteur: ex.meta.at("auteur", default: none),
  concours: ex.meta.concours,
  exercices: (ex,),
  corrige: sys.inputs.at("corrige", default: "false") == "true",
)
