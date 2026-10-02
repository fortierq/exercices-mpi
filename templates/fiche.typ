// Aperçu autonome d'un exercice exportant ex, quel que soit son emplacement.
#import "/lib/exercices.typ": fiche
#let chemin = sys.inputs.at("exercice",  default: "/templates/exercice.typ")
#import chemin: ex
#show: fiche.with(
  type: "exercice",
  titre: ex.meta.titre,
  niveau: ex.meta.niveaux.join(" / "),
  auteur: ex.meta.at("auteur", default: none),
  concours: ex.meta.concours,
  exercices: (ex,),
  corrige: sys.inputs.at("corrige", default: "false") == "true",
)
