#import "exercices.typ": aplatir, afficher-exercice, verifier-bareme, est-partie, titre-exercice, texte-concours, bloc-solution

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
    let repondue = ev.at("repondue", default: true)
    assert(type(repondue) == bool, message: "repondue doit être un booléen")
    assert(repondue or ev.reussite in (none, 0), message: "Une question non répondue ne peut rapporter de points")
    assert(type(ev.commentaire) == str and (not repondue or ev.reussite in (none, 100) or ev.commentaire.trim() != ""),
      message: "Une réponse partiellement correcte doit avoir un commentaire")
    let commentaire = if repondue and ev.reussite == 100 and ev.commentaire.trim() == "" { "Correct." } else { ev.commentaire }
    (..ev, ..q, commentaire: commentaire, repondue: repondue,
      obtenus: if ev.reussite == none or q.points == none { none } else { q.points * ev.reussite / 100 })
  })
  let complet = lignes.all(q => q.obtenus != none)
  (questions: lignes, complet: complet,
    total: if complet { lignes.map(q => q.obtenus).sum() } else { none },
    maximum: if lignes.all(q => q.points != none) { lignes.map(q => q.points).sum() } else { none })
}

#let decimal(n) = str(calc.round(n, digits: 4)).replace(".", ",")

// Filtrer récursivement sans changer les numéros des questions conservées.
#let blocs-copie(contenu, evaluations, debut: 1) = {
  let blocs = ()
  let numero = debut
  for bloc in contenu {
    if est-partie(bloc) {
      let suite = blocs-copie(bloc.contenu, evaluations, debut: numero)
      numero = suite.suivant
      if suite.blocs.len() > 0 { blocs.push((..bloc, contenu: suite.blocs)) }
    } else if type(bloc) == dictionary {
      let ev = evaluations.at(numero - 1)
      if ev.repondue { blocs.push((..bloc, numero: numero, evaluation: ev)) }
      numero += 1
    }
  }
  (blocs: blocs, suivant: numero)
}

// L'égalité reste neutre, notamment avec une seule copie et un écart-type nul.
#let couleur-reussite(valeur, moyenne, sigma) = {
  if valeur == none or moyenne == none or calc.abs(valeur - moyenne) < 0.000000001 { return luma(40%) }
  let fonce = sigma != none and sigma > 0 and calc.abs(valeur - moyenne) >= sigma
  if valeur > moyenne {
    if fonce { rgb("#125226") } else { rgb("#26823d") }
  } else {
    if fonce { rgb("#861e1e") } else { rgb("#ce4141") }
  }
}

// La colonne est décalée dans la marge ; la grille centre la note sur le commentaire.
#let marge-copie(valeur, corps, centrage: top, separable: true, couleur: luma(40%)) = {
  move(dx: -12mm, block(width: 100% + 12mm, breakable: separable,
    grid(columns: (10mm, 1fr), column-gutter: 2mm, align: (right + centrage, left),
      text(size: 9pt, fill: couleur, if valeur == none { [—] } else { [#decimal(calc.round(valeur, digits: 1)) %] }),
      corps,
    ),
  ))
}

#let afficher-blocs-copie(blocs, moyennes, niveau: 1) = {
  for bloc in blocs {
    if est-partie(bloc) {
      titre-exercice(bloc.titre, bloc.numero, niveau: niveau)
      afficher-blocs-copie(bloc.contenu, moyennes, niveau: niveau + 1)
    } else {
      let ev = bloc.evaluation
      let stats = moyennes.at(ev.cle, default: (moyenne: none))
      let moyenne = stats.moyenne
      let couleur = couleur-reussite(ev.reussite, moyenne, stats.at("sigma", default: none))
      block(width: 100%, above: 12pt, below: 5pt, sticky: true, {
        [#metadata((cle: ev.cle, numero: bloc.numero)) <copie-question>]
        marge-copie(moyenne, enum(start: bloc.numero, numbering: "1.", indent: 0pt, body-indent: 0.5em, bloc.enonce))
      })
      block(width: 100%, above: 8pt, below: 10pt, {
        [#metadata(ev.cle) <copie-commentaire>]
        let commentaire = if ev.commentaire.trim() == "" { emph[À corriger.] } else { eval(ev.commentaire, mode: "markup") }
        marge-copie(ev.reussite, bloc-solution(commentaire, above: 0pt, below: 0pt),
          centrage: horizon, separable: false, couleur: couleur)
      })
    }
  }
}

/// Affiche seulement les questions traitées, suivies des commentaires personnels utiles.
/// Les commentaires sont du balisage Typst ($...$, `...`) écrit par le correcteur.
/// Les moyennes de classe sont transmises par l'entrée système `moyennes` (JSON).
#let copie(sujet, donnees, corrige: true) = {
  let bilan = bilan-copie(sujet, donnees.evaluations)
  [#metadata((..donnees, ..bilan, evaluations: none)) <copie-notes>]
  let statistiques = json(bytes(sys.inputs.at("moyennes", default: "{}")))
  if statistiques != (:) {
    assert(statistiques.feuille == donnees.feuille, message: "Les moyennes concernent un autre sujet")
  }
  let moyennes = statistiques.at("questions", default: (:))
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

      #text(size: 9pt)[Marge gauche : moyenne de classe devant la question,
        réussite individuelle devant le commentaire.
        Vert au-dessus de la moyenne, rouge en dessous ; foncé dès un écart-type.
        #if statistiques == (:) { [Moyennes indisponibles.] } else {
          [Moyennes sur les copies corrigées : #statistiques.effectif copie(s),
            #statistiques.effectif-classe élèves dans la liste.
            Une question sans évaluation est exclue de sa moyenne.]
        }]

      #if donnees.at("source", default: "") != "" { link(donnees.source)[Copie originale] }
    ]
  }
  for (e, ex) in sujet.exercices.enumerate(start: 1) {
    if not corrige {
      afficher-exercice(ex, numero: e, corrige: false)
    } else {
      let evaluations = bilan.questions.filter(q => q.cle.starts-with(str(e) + "."))
      let blocs = blocs-copie(ex.contenu, evaluations).blocs
      if blocs.len() > 0 {
        let titre = if ex.meta.concours == none { ex.meta.titre } else { texte-concours(ex.meta.concours) }
        titre-exercice(titre, numbering("I", e), duree: ex.meta.duree)
        afficher-blocs-copie(blocs, moyennes)
      }
    }
  }
}
