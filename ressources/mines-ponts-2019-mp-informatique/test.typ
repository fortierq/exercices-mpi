#import "/lib/exercices.typ": aplatir, nombre-questions, est-partie, feuille, exercice, question, partie, texte-duree
#import "/concours/19/mines-ponts-2019-mp-informatique.typ": ex
#import "/concours/22/centrale-2022-mp-informatique.typ": ex as centrale

#assert(nombre-questions(ex.contenu) == 37)
#assert(aplatir(ex.contenu).filter(b => type(b) == dictionary).all(q => q.solution != none))
#assert(ex.contenu.filter(est-partie).map(p => nombre-questions(p.contenu)) == (5, 3, 9, 11, 9))
#assert(ex.meta.concours == (nom: "Mines-Ponts", annee: 2019, filiere: "MP"))
#assert(ex.remarques != none and centrale.remarques != none)
#assert(ex.meta.duree == (3, 0) and centrale.meta.duree == (3, 0))
#assert(texte-duree((3, 0)) == "3 h")
#assert(texte-duree((1, 30)) == "1 h 30 min")
#assert(texte-duree((0, 20)) == "20 min")
#assert(texte-duree((0, 1)) == "1 min")
#assert(texte-duree((2, 5)) == "2 h 5 min")

#let questions = aplatir(ex.contenu).filter(b => type(b) == dictionary)
#assert(questions.at(6).commentaire != none and questions.at(7).commentaire != none)
#assert(questions.at(12).commentaire != none and questions.at(21).commentaire == none)
#let questions-centrale = aplatir(centrale.contenu).filter(b => type(b) == dictionary)
#assert(questions-centrale.at(8).commentaire == [Distinguer une famille de langages de leur union.])
#assert(aplatir(ex.contenu, textes: false).filter(b => type(b) == dictionary) == questions)

// Témoins de rendu : ordre des commentaires, masquage récursif et conservation des figures de solution.
#let temoin(nom) = [#metadata(nom) <presentation-test>]
#let exemple = exercice(
  meta: ex.meta,
  corrections: [
    - #temoin("erratum") #context assert(text.style == "normal") Question 1.
  ],
  remarques: [
    - #temoin("general") #context assert(text.style == "italic") Remarque générale.
  ],
  contenu: (
    [#temoin("preambule") Préliminaire.],
    partie("I", "Partie témoin",
      commentaire: [#temoin("partie") #context assert(text.style == "italic") Commentaire de partie.],
      contenu: (
      [#temoin("definition") Définition.],
      partie("I.A", "Sous-partie témoin",
        commentaire: [#temoin("sous-partie") #context assert(text.style == "italic") Commentaire de sous-partie.],
        contenu: (
        [#temoin("notation") Notation.],
        question([#temoin("question") Question témoin.],
          commentaire: [#temoin("commentaire") #context assert(text.style == "italic") Commentaire du jury.],
          solution: [#temoin("solution") Solution. #figure(rect(width: 1cm, height: 1cm))]),
      )),
    )),
  ),
)
#let corrige = sys.inputs.at("corrige", default: "false") == "true"
#show: feuille.with(exercices: (exemple,), corrige: corrige)
#context {
  let ordre = query(<presentation-test>).map(m => m.value)
  assert(ordre == if corrige {
    ("erratum", "general", "partie", "sous-partie", "question", "commentaire", "solution")
  } else {
    ("preambule", "definition", "notation", "question")
  }, message: repr(ordre))
  assert(query(heading).map(h => h.body).contains([Rapport du jury]) == false)
  assert(query(figure).len() == if corrige { 1 } else { 0 })
}
