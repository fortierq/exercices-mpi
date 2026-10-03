#import "exercices.typ": aplatir, afficher-exercice, verifier-bareme

// Les numéros désignent les questions dans chaque exercice, parties comprises.
#let questions-copie(sujet) = {
  let resultat = ()
  let global = 0
  for (e, ex) in sujet.exercices.enumerate(start: 1) {
    let questions = aplatir(ex.contenu).filter(q => type(q) == dictionary)
    for (n, q) in questions.enumerate(start: 1) {
      let points = if sujet.at("bareme", default: none) != none {
        sujet.bareme.at(global)
      } else if ex.bareme != none { ex.bareme.at(n - 1) } else { q.points }
      resultat.push((cle: str(e) + "." + str(n), points: points))
      global += 1
    }
  }
  verifier-bareme(sujet.at("bareme", default: none), global)
  resultat
}

// Une réussite absente reste « à corriger » ; zéro signifie une évaluation faite.
#let bilan-copie(sujet, evaluations) = {
  let questions = questions-copie(sujet)
  assert(evaluations.keys().sorted() == questions.map(q => q.cle).sorted(),
    message: "La copie doit comporter exactement une évaluation par question du sujet")
  let lignes = questions.map(q => {
    let ev = evaluations.at(q.cle)
    assert(ev.reussite == none or (type(ev.reussite) in (int, float) and 0 <= ev.reussite and ev.reussite <= 100),
      message: "La réussite doit être entre 0 et 100, ou none")
    assert(type(ev.commentaire) == str and (ev.reussite == none or ev.commentaire.trim() != ""),
      message: "Toute réponse évaluée doit avoir un commentaire")
    (..q, ..ev, obtenus: if ev.reussite == none or q.points == none { none } else { q.points * ev.reussite / 100 })
  })
  let complet = lignes.all(q => q.obtenus != none)
  (questions: lignes, complet: complet,
    total: if complet { lignes.map(q => q.obtenus).sum() } else { none },
    maximum: if lignes.all(q => q.points != none) { lignes.map(q => q.points).sum() } else { none })
}

#let decimal(n) = str(calc.round(n, digits: 4)).replace(".", ",")

/// Affiche une correction individuelle liée à la composition d'une feuille.
/// - sujet (dictionary): Export de la feuille : titre, exercices et éventuel bareme.
/// - donnees (dictionary): Identité, feuille, appréciation et évaluations par clé exercice.question.
/// - corrige (bool): Affiche les commentaires personnels ; false conserve l'énoncé.
#let copie(sujet, donnees, corrige: true) = {
  let bilan = bilan-copie(sujet, donnees.evaluations)
  [#metadata((..donnees, ..bilan, evaluations: none)) <copie-notes>]
  if corrige {
    block[
      #text(weight: "bold")[#donnees.prenom #donnees.nom — #donnees.classe]

      #sujet.titre

      #if bilan.complet {
        [Note brute : #decimal(bilan.total) / #decimal(bilan.maximum).]
      } else {
        [Correction incomplète ou barème absent : total non calculé.]
      }

      #donnees.appreciation

      #if donnees.at("source", default: "") != "" { link(donnees.source)[Copie originale] }
    ]
  }
  let global = 0
  for (e, ex) in sujet.exercices.enumerate(start: 1) {
    let contenu = ()
    for bloc in aplatir(ex.contenu, textes: not (corrige and ex.sujet-ecrit)) {
      if type(bloc) == content { contenu.push(bloc) } else {
        let ev = bilan.questions.at(global)
        global += 1
        contenu.push((..bloc, commentaire: none, solution: [
          #if ev.reussite == none {
            [À corriger.]
          } else {
            [Réussite : #decimal(ev.reussite) %.
              #if ev.obtenus != none [Points obtenus : #decimal(ev.obtenus) / #decimal(ev.points).]]
          }

          #if ev.at("repere", default: "") != "" [Copie : #ev.repere.]
          #if ev.at("reponse", default: "") != "" [

            Réponse relevée : #ev.reponse
          ]

          #ev.commentaire
        ]))
      }
    }
    let adapte = (..ex, contenu: contenu, sujet-ecrit: false, remarques: none, corrections: none)
    afficher-exercice(adapte, numero: e, corrige: corrige,
      bareme: bilan.questions.filter(q => q.cle.starts-with(str(e) + ".")).map(q => q.points))
  }
}
