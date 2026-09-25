#import "/lib/exercices.typ": exercice, question

#let ex = exercice(
  meta: (
    titre: "Titre de l'exercice",
    chapitres: ("graphes",), // doivent apparaître dans lib/programme.typ
    algorithmes: ("parcours-en-profondeur",), // doivent apparaître dans lib/programme.typ
    structures: ("graphe-oriente",), // doivent apparaître dans lib/programme.typ
    langages: (), // C, OCaml, SQL et/ou Python
    difficulte: 2,
    niveaux: ("MPI",),
    duree: 20, // Minutes ; none si non estimée.
    concours: none, // Ou (nom: "ENS Ulm", annee: 2019, filiere: "MP").
    // Les champs supplémentaires (auteur, mots-clés…) sont libres.
  ),
  contenu: (
    [On considère un graphe orienté fini $G = (S, A)$.],
    question(
      [Proposer un algorithme qui détecte un cycle dans $G$.],
      solution: [Effectuer un parcours en profondeur avec trois couleurs.
        Une arête vers un sommet gris révèle un cycle. La complexité est
        $O(abs(S) + abs(A))$ avec des listes d'adjacence.],
    ),
    [On suppose désormais que le graphe est représenté par des listes d'adjacence.],
    question(
      [Quel est l'espace auxiliaire utilisé par cet algorithme ?],
      solution: [Les couleurs et la pile du parcours occupent $O(abs(S))$ cases.],
    ),
    [Préciser toujours si le stockage du graphe est compté dans l'espace annoncé.],
  ),
)
