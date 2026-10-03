#import "/lib/exercices.typ": exercice, question, partie
#import "/lib/copies.typ": bilan-copie
#let ex = exercice(meta: (titre: "Copie", chapitres: (), algorithmes: (), structures: (), langages: (), difficulte: 1),
  contenu: (question([A], points: 1), partie("I", "Partie", contenu: (question([B], points: 2),))),
)
#let evaluations = ("1.1": (reussite: 50, commentaire: "Partiel"), "1.2": (reussite: 0, commentaire: "Absent"))
#let sujet = (exercices: (ex,))
#let bilan = bilan-copie(sujet, evaluations)
#assert(bilan.questions.map(q => q.cle) == ("1.1", "1.2"))
#assert(bilan.complet and bilan.total == 0.5 and bilan.maximum == 3)
#let incomplet = bilan-copie(sujet, (..evaluations, "1.2": (reussite: none, commentaire: "")))
#assert(not incomplet.complet and incomplet.total == none)
#let priorite = bilan-copie((exercices: ((..ex, bareme: (2, 3)),), bareme: (4, 4)), evaluations)
#assert(priorite.total == 2 and priorite.maximum == 8)
#let sans-points = bilan-copie((exercices: (ex,), bareme: (none, 2)), evaluations)
#assert(not sans-points.complet and sans-points.maximum == none)
#let deux = bilan-copie((exercices: (ex, ex)), (..evaluations, "2.1": evaluations.at("1.1"), "2.2": evaluations.at("1.2")))
#assert(deux.questions.map(q => q.cle) == ("1.1", "1.2", "2.1", "2.2"))
#assert(deux.total == 1)
