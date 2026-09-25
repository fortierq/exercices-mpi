// Point d'entrée générique ; le contenu reste dans exercices/.
#import "/lib/exercices.typ": feuille
#let chemin = sys.inputs.at("exercice", default: "/modeles/exercice.typ")
#import chemin: ex
#show: feuille.with(
  titre: ex.meta.titre,
  niveau: ex.meta.niveaux.join(" / "),
  exercices: (ex,),
  corrige: sys.inputs.at("corrige", default: "false") == "true",
  details: sys.inputs.at("details", default: "true") == "true",
)
