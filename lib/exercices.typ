#import "meta.typ": chapitres-programme, algorithmes-programme, structures-programme, concours-possibles, filieres-possibles

// Aucun paquet externe : les exercices sont des données Typst ordinaires.
#let question(enonce, solution: none) = (type: "question", enonce: enonce, solution: solution)
#let texte-concours(concours) = (
  concours.at("nom", default: none),
  concours.at("annee", default: none),
  concours.at("filiere", default: none),
  if "oral" in concours { if concours.oral { "oral" } else { "écrit" } } else { none },
).filter(valeur => valeur != none).map(valeur => str(valeur)).join(" · ")

#let exercice(meta: (:), contenu: (), debut: 1) = {
  let champs = ("titre", "chapitres", "algorithmes", "structures", "langages", "difficulte")
  for champ in champs {
    assert(champ in meta, message: "Métadonnée manquante : " + champ)
  }
  assert(not ("id" in meta), message: "id est déduit du nom du fichier .typ")
  assert(type(meta.titre) == str and meta.titre != "", message: "titre doit être une chaîne non vide")
  for champ in ("chapitres", "algorithmes", "structures", "langages") {
    assert(type(meta.at(champ)) == array, message: champ + " doit être un tableau")
    for valeur in meta.at(champ) {
      assert(type(valeur) == str, message: champ + " doit contenir des chaînes")
    }
  }
  for (champ, valeurs) in (("chapitres", chapitres-programme), ("algorithmes", algorithmes-programme), ("structures", structures-programme)) {
    for valeur in meta.at(champ) {
      assert(valeur in valeurs, message: champ + " : étiquette absente du programme : " + valeur)
    }
  }
  assert(type(meta.difficulte) == int and meta.difficulte >= 1 and meta.difficulte <= 5,
    message: "difficulte doit être un entier de 1 à 5")
  let niveaux = meta.at("niveaux", default: ())
  assert(type(niveaux) == array, message: "niveaux doit être un tableau")
  for niveau in niveaux {
    assert(type(niveau) == str, message: "niveaux doit contenir des chaînes")
  }
  // Convention de la banque pour la programmation en MP2I–MPI.
  if "MP2I" in niveaux or "MPI" in niveaux {
    for langage in meta.langages {
      assert(langage in ("C", "OCaml", "Python"),
        message: "langages : en MP2I–MPI, utiliser C, OCaml ou Python : " + langage)
    }
  }
  let duree = meta.at("duree", default: none)
  assert(duree == none or (type(duree) == int and duree > 0),
    message: "duree doit être un entier strictement positif ou none")
  assert(not ("reference" in meta), message: "Utiliser concours au lieu de reference")
  let concours = meta.at("concours", default: none)
  let concours-normalise = if concours != none {
    assert(type(concours) == dictionary, message: "concours doit être un dictionnaire ou none")
    if "nom" in concours {
      assert(type(concours.nom) == str and concours.nom in concours-possibles,
        message: "nom doit être un concours connu")
    }
    if "annee" in concours {
      assert(type(concours.annee) == int and concours.annee > 0,
        message: "L'année du concours doit être un entier strictement positif")
    }
    if "filiere" in concours {
      assert(type(concours.filiere) == str and concours.filiere in filieres-possibles,
        message: "filiere doit être une filière connue")
    }
    if "oral" in concours {
      assert(type(concours.oral) == bool, message: "oral doit être un booléen")
    }
    concours
  } else {
    none
  }
  assert(type(debut) == int and debut >= 0, message: "debut doit être un entier positif ou nul")
  assert(type(contenu) == array, message: "contenu doit être un tableau de textes et de questions")
  let nombre-questions = 0
  for bloc in contenu {
    if type(bloc) != content {
      assert(type(bloc) == dictionary, message: "Utiliser [texte libre] ou question(…) dans contenu")
      assert(bloc.at("type", default: none) == "question", message: "Bloc inconnu dans contenu")
      assert("enonce" in bloc and "solution" in bloc, message: "Construire les questions avec question(…)")
      nombre-questions += 1
    }
  }
  assert(nombre-questions > 0, message: "Un exercice doit contenir au moins une question")
  (
    meta: (niveaux: (), duree: none, ..meta, concours: concours-normalise),
    contenu: contenu,
    debut: debut,
  )
}

// Présentation inspirée de texmf/tex/latex/{exam.cls,exercise.cls,code.sty}.
#let afficher-exercice(ex, numero: none, corrige: false, details: true, afficher-titre: true) = {
  show strong: it => it.body
  show heading: set text(weight: "bold")
  [#metadata(ex.meta) <exercice-meta>]
  if afficher-titre {
    let prefixe = if numero == none { "I" } else { numbering("I", numero) }
    block(above: 12pt, below: 12pt, breakable: false)[
      #heading(level: 1)[
        #grid(columns: (auto, 1fr, auto), column-gutter: 1em, align: horizon,
          [#prefixe],
          [#ex.meta.titre],
          [#if ex.meta.concours != none {
            let c = ex.meta.concours
            text(size: 8pt, fill: luma(35%).transparentize(30%))[
              #texte-concours(c)
            ]
          }],
        )
      ]
    ]
  }
  if details {
    block(above: 0pt, below: 9pt, text(size: 9pt, fill: luma(35%))[
      #if ex.meta.concours != none {
        let c = ex.meta.concours
        [#texte-concours(c) #h(1em)]
      }
      Chapitres : #ex.meta.chapitres.join(", ") |
      Difficulté : #ex.meta.difficulte/5 |
      #if ex.meta.duree != none [ Durée indicative : #ex.meta.duree min]
    ])
  }
  let i = ex.debut
  for q in ex.contenu {
    if type(q) == content {
      block(width: 100%, above: 9pt, below: 9pt, q)
      continue
    }
    // Chaque énoncé est un paragraphe distinct ; les longues questions restent sécables.
    block(width: 100%, above: 8pt, below: 0pt,
      enum(start: i, numbering: "1.",
        indent: 0pt, body-indent: 0.5em, q.enonce),
    )
    if corrige {
      block(
        width: 100%, stroke: (left: 0.4pt + luma(60%)),
        inset: (left: 10pt, y: 3pt), above: 5pt, below: 9pt,
      )[
        #underline[Solution] 

        #if q.solution == none { emph[Corrigé à compléter.] } else { q.solution }
      ]
    }
    i += 1
  }
}

#let feuille(
  titre: "Feuille d'exercices",
  niveau: none,
  auteur: none,
  exercices: (),
  corrige: false,
  details: true,
  nouvelle-page: false,
  body,
) = {
  let titre-affiche = titre + if corrige { " : corrigé" } else { "" }
  set document(title: titre-affiche)
  set text(font: "New Computer Modern", size: 11pt, lang: "fr")
  set par(justify: true, leading: 0.55em, spacing: 0.65em)
  set page(
    paper: "a4", margin: (x: 14mm, top: 25mm, bottom: 18mm),
    header-ascent: 9mm,
    header: context if counter(page).get().first() == 1 [
      #set text(size: 10pt)
      #grid(
        columns: (24mm, 1fr, 24mm), align: (left, center, right),
        if niveau != none { niveau } else { [] },
        text(size: 12pt, weight: "bold", titre-affiche),
        if auteur != none { auteur } else { [] },
      )
      #v(4pt)
      #line(length: 100%, stroke: 0.4pt)
    ],
    footer: context align(center, text(size: 9pt, counter(page).display("1 / 1", both: true))),
  )
  set heading(numbering: none)
  show heading.where(level: 1): set text(size: 15pt)
  // Comme l'environnement code : fond blanc et deux filets horizontaux.
  show raw.where(block: true): it => block(
    width: 100%, inset: (x: 8pt, y: 7pt),
    stroke: (top: 0.4pt, bottom: 0.4pt),
    text(size: 9pt, it),
  )
  body
  for (i, ex) in exercices.enumerate(start: 1) {
    if nouvelle-page and i > 1 { pagebreak() }
    afficher-exercice(ex, numero: if exercices.len() > 1 { i } else { none }, corrige: corrige, details: details, afficher-titre: exercices.len() > 1 or titre != ex.meta.titre)
  }
}
