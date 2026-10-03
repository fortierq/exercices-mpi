#import "/lib/exercices.typ": exercice, question, partie
#import "/lib/copies.typ": bilan-copie, blocs-copie, afficher-blocs-copie, couleur-reussite
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

// Les parties vides disparaissent, les numéros et les réponses fausses restent.
#let filtre = exercice(meta: ex.meta, contenu: (
  partie("I", "Partie traitée", contenu: (
    question([Réponse juste], points: 1),
    partie("I.A", "Sous-partie vide", contenu: (question([Absente], points: 1),)),
    partie("I.B", "Sous-partie traitée", contenu: (question([Réponse fausse], points: 1),)),
  )),
  partie("II", "Partie vide", contenu: (question([Absente aussi], points: 1),)),
))
#let notes = bilan-copie((exercices: (filtre,)), (
  "1.1": (repondue: true, reussite: 100, commentaire: ""),
  "1.2": (repondue: false, reussite: 0, commentaire: ""),
  "1.3": (repondue: true, reussite: 0, commentaire: "Utiliser $x^2$ et `let x = 1`."),
  "1.4": (repondue: false, reussite: 0, commentaire: ""),
))
#let selection = blocs-copie(filtre.contenu, notes.questions)
#assert(selection.suivant == 5 and selection.blocs.len() == 1)
#assert(selection.blocs.first().contenu.map(b => b.at("numero")) == (1, "I.B"))
#assert(notes.total == 1 and notes.maximum == 4)
#afficher-blocs-copie(selection.blocs, ("1.1": (moyenne: 75), "1.3": (moyenne: 25)))
#context {
  assert(query(<copie-question>).map(m => m.value.numero) == (1, 3))
  assert(query(<copie-commentaire>).map(m => m.value) == ("1.1", "1.3",))
  assert(query(enum).map(q => q.start) == (1, 3))
  assert(query(heading).len() == 2)
  assert(query(math.equation).len() == 1)
  assert(query(raw).map(r => r.text) == ("let x = 1",))
}

// Seuils inclusifs à moyenne ± sigma, égalité neutre même si sigma = 0.
#assert(couleur-reussite(60, 50, 20) == rgb("#26823d"))
#assert(couleur-reussite(70, 50, 20) == rgb("#125226"))
#assert(couleur-reussite(40, 50, 20) == rgb("#ce4141"))
#assert(couleur-reussite(30, 50, 20) == rgb("#861e1e"))
#assert(couleur-reussite(50, 50, 0) == luma(40%))
#assert(couleur-reussite(50, none, none) == luma(40%))
#assert(notes.questions.first().commentaire == "Correct.")
#assert(notes.questions.at(1).commentaire == "")
#assert(incomplet.questions.at(1).commentaire == "")
