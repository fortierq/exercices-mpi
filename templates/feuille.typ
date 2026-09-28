#import "/lib/exercices.typ": feuille
#import "/templates/exercice.typ": ex

#show: feuille.with(
  titre: "Travaux dirigés",
  niveau: "MPI",
  exercices: (ex,), // Importer d'autres exercices sous des alias et les ajouter ici.
  corrige: sys.inputs.at("corrige", default: "false") == "true",
  details: true,
  nouvelle-page: false,
)

Justifier la correction et la complexité des algorithmes proposés.
