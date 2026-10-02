#import "/lib/exercices.typ": exercice, question, partie, feuille
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
#show: feuille.with(exercices: ())
