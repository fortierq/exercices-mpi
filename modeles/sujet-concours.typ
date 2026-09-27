#import "/lib/exercices.typ": exercice, question, partie

#let ex = exercice(
  meta: (
    titre: "Titre du sujet de concours",
    chapitres: ("langages-reguliers", "automates-finis"),
    algorithmes: (), structures: (), langages: (),
    difficulte: 2, niveaux: ("MPI",), duree: 240,
    concours: none, // Renseigner le concours, l'année et la filière attestés.
  ),
  contenu: (
    [Les réponses doivent être justifiées.
      On fixe un alphabet $Σ$.],
    partie("I", "Langages", contenu: (
      partie("I.A", "Langages finis", contexte: ([On fixe un alphabet $Σ$.],), contenu: (
        question([Montrer qu'un langage fini sur $Σ$ est régulier.],
          solution: [Un mot est décrit par la concaténation de ses lettres
            (par $ε$ pour le mot vide).
            Une union finie de telles expressions
            décrit tout langage fini ; $∅$ décrit le langage vide.]),
      )),
      partie("I.B", "Miroir", contexte: ([On fixe un alphabet $Σ$.],), contenu: (
        question([Le miroir d'un langage fini est-il régulier ?],
          solution: [Il est fini, donc régulier.]),
      )),
    )),
  ),
)
