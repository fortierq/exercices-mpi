#import "/lib/exercices.typ": feuille
#import "/exercices/langages/automates-palindromes.typ": ex as palindromes
#import "/exercices/langages/automates-pile-pompage.typ": ex as pile
#import "/exercices/langages/automates-monoides.typ": ex as monoides
#import "/exercices/langages/automates-ordres-partiels.typ": ex as ordres
#import "/exercices/langages/cloture-commutative-langage.typ": ex as commutative
#import "/exercices/langages/langages-continuables-primitifs.typ": ex as primitifs
#import "/exercices/langages/evaluation-acceleree-automates.typ": ex as evaluation
#import "/exercices/langages/reparation-langage.typ": ex as reparation
#import "/exercices/langages/morphismes-automates.typ": ex as morphismes

#show: feuille.with(
  titre: "Automates : oraux ENS et morphismes",
  niveau: "MPI / MP",
  exercices: (palindromes, pile, monoides, ordres, commutative,
    primitifs, evaluation, reparation, morphismes),
  corrige: sys.inputs.at("corrige", default: "false") == "true",
)
