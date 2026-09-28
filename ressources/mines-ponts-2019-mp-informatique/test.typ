#import "/lib/exercices.typ": aplatir, nombre-questions, est-partie, feuille
#import "/concours/19/mines-ponts-2019-mp-informatique.typ": ex
#import "/concours/22/centrale-2022-mp-informatique.typ": ex as centrale

#assert(nombre-questions(ex.contenu) == 37)
#assert(aplatir(ex.contenu).filter(b => type(b) == dictionary).all(q => q.solution != none))
#assert(ex.contenu.filter(est-partie).map(p => nombre-questions(p.contenu)) == (5, 3, 9, 11, 9))
#assert(ex.meta.concours == (nom: "Mines-Ponts", annee: 2019, filiere: "MP"))
#assert(ex.rapport != none and centrale.rapport != none)

// Vérification du rendu conditionnel, sans ouvrir les PDF produits.
#let corrige = sys.inputs.at("corrige", default: "false") == "true"
#show: feuille.with(exercices: (ex, centrale), corrige: corrige)
#context {
  let rapports = query(heading).filter(h => h.body == [Rapport du jury])
  assert(rapports.len() == if corrige { 2 } else { 0 })
}
