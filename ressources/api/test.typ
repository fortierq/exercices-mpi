#import "/lib/exercices.typ": exercice, question, partie, feuille, afficher-exercice
#import "/lib/meta.typ": langages-possibles

// SQL doit être accepté pour tous les niveaux, ainsi que sans niveau.
#for niveaux in ((), ("MP2I",), ("MPI",), ("MP",), ("PC",), ("PSI",), ("PT",)) {
  let ex = exercice(
    meta: (titre: "Test SQL", chapitres: ("bases-de-donnees",),
      algorithmes: (), structures: (), langages: ("SQL",), difficulte: 1, niveaux: niveaux),
    contenu: (question([Énoncé], solution: [Solution]),),
  )
  assert(ex.meta.langages == ("SQL",))
  assert(ex.meta.duree == none and ex.meta.concours == none)
}
#assert("SQL" in langages-possibles)
#let p = partie("I", "Test", contenu: (question([Une question]),), contexte: ([Un rappel],))
#assert(p.contexte.len() == 1)
// Le départ est fixé à 1 ; les modifications ne paraissent que pour un concours.
#let meta = (titre: "Présentation", chapitres: (), algorithmes: (), structures: (),
  langages: (), difficulte: 1)
#let contenu = (question([Première question], solution: [Solution]),
  question([Deuxième question], solution: [Solution]))
#let ordinaire = exercice(meta: meta, contenu: contenu,
  corrections: [#metadata("modification") <correction-test> Correction.])
#let sujet = exercice(meta: (..meta, concours: (nom: "ENS", oral: true)),
  contenu: contenu, corrections: ordinaire.corrections)
#let unique = exercice(meta: meta, contenu: (question([Question unique], solution: [Solution]),))
#assert("debut" not in ordinaire and "debut" not in sujet)
#show: feuille.with(exercices: (), corrige: true)
#afficher-exercice(ordinaire, corrige: true)
#afficher-exercice(sujet, corrige: true)
#afficher-exercice(unique, corrige: true)
#context {
  assert(query(enum).map(q => q.start) == (1, 2, 1, 2))
  assert(query(<correction-test>).len() == 1)
}

// L'extraction conserve exactement le code entre les marqueurs et sa présentation.
#import "/lib/code.typ": code-region
#let extrait = code-region("avant\n(* BEGIN test *)\nlet x = 1\n(* END test *)\naprès", "test")
#assert(extrait.text == "let x = 1" and extrait.lang == "ocaml" and extrait.block)
