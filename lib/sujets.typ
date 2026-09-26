#import "exercices.typ": exercice, afficher-exercice, feuille, texte-concours

// Les identifiants de parties sont stables ("I", "I.B", "II.A.1"…).
// Le contexte sert uniquement aux extraits : définitions et prérequis à rappeler.
#let partie(id, titre, contenu: (), contexte: (), meta: (:)) = {
  assert(type(id) == str and id != "", message: "Identifiant de partie vide")
  assert(type(titre) == str and titre != "", message: "Titre de partie vide")
  assert(type(contenu) == array and type(contexte) == array)
  assert(contexte.all(bloc => type(bloc) == content), message: "Le contexte contient uniquement du texte Typst")
  (type: "partie", id: id, titre: titre, contenu: contenu, contexte: contexte, meta: meta)
}

#let est-partie(bloc) = type(bloc) == dictionary and bloc.at("type", default: none) == "partie"

#let aplatir(contenu, niveau: 1) = {
  let resultat = ()
  for bloc in contenu {
    if est-partie(bloc) {
      resultat.push(heading(level: niveau)[#bloc.id – #bloc.titre])
      resultat += aplatir(bloc.contenu, niveau: niveau + 1)
    } else {
      resultat.push(bloc)
    }
  }
  resultat
}

#let nombre-questions(contenu) = aplatir(contenu).filter(bloc => type(bloc) == dictionary).len()

#let sujet-concours(meta: (:), preambule: [], contenu: ()) = {
  let identifiants(blocs) = {
    let ids = ()
    for bloc in blocs {
      if est-partie(bloc) { ids += (bloc.id,) + identifiants(bloc.contenu) }
    }
    ids
  }
  let ids = identifiants(contenu)
  assert(ids.len() == ids.dedup().len(), message: "Identifiant de partie dupliqué")
  assert(type(preambule) == content)
  // Réutiliser la validation des exercices, y compris celle des métadonnées.
  let valide = exercice(meta: meta, contenu: aplatir(contenu))
  (meta: valide.meta, preambule: preambule, contenu: contenu)
}

#let extraire-partie(sujet, id, meta: (:), numerotation-originale: false) = {
  let chercher(blocs, debut, contexte, metadonnees) = {
    let numero = debut
    for bloc in blocs {
      if est-partie(bloc) {
        let rappels = contexte + bloc.contexte
        let infos = (: ..metadonnees, ..bloc.meta)
        if bloc.id == id {
          return (partie: bloc, debut: numero, contexte: rappels, meta: infos)
        }
        let trouve = chercher(bloc.contenu, numero, rappels, infos)
        if trouve != none { return trouve }
        numero += nombre-questions(bloc.contenu)
      } else if type(bloc) == dictionary {
        numero += 1
      }
    }
    none
  }
  let trouve = chercher(sujet.contenu, 1, (), sujet.meta)
  assert(trouve != none, message: "Partie introuvable : " + id)
  exercice(
    // La durée totale du concours ne décrit pas la durée de l'extrait.
    meta: (..trouve.meta, titre: trouve.partie.titre, duree: none, ..meta,
      concours: sujet.meta.concours),
    contenu: trouve.contexte + aplatir(trouve.partie.contenu),
    debut: if numerotation-originale { trouve.debut } else { 1 },
  )
}

#let epreuve(sujet, corrige: false, body) = {
  show: feuille.with(titre: sujet.meta.titre, corrige: corrige)
  show strong: it => it.body
  show heading: set text(weight: "bold")
  show heading.where(level: 2): set text(size: 12pt)
  show heading.where(level: 3): set text(size: 11pt)
  [#metadata(sujet.meta) <sujet-meta>]
  align(center)[
    #if sujet.meta.concours != none { texte-concours(sujet.meta.concours) }
    #if sujet.meta.duree != none [#h(1em) Durée : #sujet.meta.duree min]
  ]
  body
  sujet.preambule
  afficher-exercice(
    exercice(meta: sujet.meta, contenu: aplatir(sujet.contenu)),
    corrige: corrige, details: false, afficher-titre: false,
    numerotation: "Q 1.",
  )
}
