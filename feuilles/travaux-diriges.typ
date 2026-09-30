#import "/lib/exercices.typ": feuille
#import "/exercices/langages/distance-de-hamming.typ": ex as ex1
#import "/exercices/langages/automates-pile-pompage.typ": ex as ex2
#import "/exercices/langages/automates-ordres-partiels.typ": ex as ex3

#show: feuille.with(
  titre: "Travaux dirigés",
  niveau: "MPI",
  auteur: none,
  exercices: (ex1, ex2, ex3,),
  corrige: sys.inputs.at("corrige", default: "false") == "true",
  details: true,
  nouvelle-page: false,
)

Justifier la correction et la complexité des algorithmes proposés.
