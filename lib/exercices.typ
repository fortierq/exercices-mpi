#import "meta.typ": chapitres-programme, algorithmes-programme, structures-programme, concours-possibles, filieres-possibles

// Aucun paquet externe : les exercices sont des données Typst ordinaires.
#let question(enonce, solution: none, commentaire: none) = {
  assert(commentaire == none or type(commentaire) == content,
    message: "commentaire doit être un contenu Typst ou none")
  (type: "question", enonce: enonce, solution: solution, commentaire: commentaire)
}

#let texte-duree(duree) = {
  let (heures, minutes) = duree
  if heures == 0 { str(minutes) + " min" }
  else if minutes == 0 { str(heures) + " h" }
  else { str(heures) + " h " + str(minutes) + " min" }
}

#let texte-concours(concours) = (
  concours.at("nom", default: none),
  concours.at("annee", default: none),
  concours.at("filiere", default: none),
  if "oral" in concours { if concours.oral { "oral" } else { "écrit" } } else { none },
).filter(valeur => valeur != none).map(valeur => str(valeur)).join(" · ")

// Titres communs aux exercices et aux parties des sujets.
#let titre-exercice(titre, prefixe, duree: none, niveau: 1) = {
  block(above: 16pt, below: 16pt, breakable: false)[
    #heading(level: niveau)[
      #grid(columns: (1fr, auto), column-gutter: 1em, align: (left, right),
        [#prefixe -- #titre],
        [#if duree != none {
          text(size: 10pt, fill: luma(35%).transparentize(30%))[
            #texte-duree(duree)
          ]
        }],
      )
    ]
  ]
}

// Le contexte contient les rappels à ajouter dans un exercice autonome.
#let partie(numero, titre, contenu: (), contexte: (), meta: (:), commentaire: none) = {
  assert(type(numero) == str and numero != "", message: "Numéro de partie vide")
  assert(type(titre) == str and titre != "", message: "Titre de partie vide")
  assert(type(contenu) == array and type(contexte) == array)
  assert(contexte.all(bloc => type(bloc) == content), message: "Le contexte contient uniquement du texte Typst")
  assert(commentaire == none or type(commentaire) == content)
  (commentaire: commentaire, type: "partie", numero: numero, titre: titre, contenu: contenu, contexte: contexte, meta: meta)
}

#let est-partie(bloc) = type(bloc) == dictionary and bloc.at("type", default: none) == "partie"

#let aplatir(contenu, niveau: 1, textes: true, commentaires: false) = {
  let resultat = ()
  for bloc in contenu {
    if est-partie(bloc) {
      resultat.push(titre-exercice(bloc.titre, bloc.numero, niveau: niveau))
      if commentaires and bloc.commentaire != none {
        resultat.push(text(style: "italic", bloc.commentaire))
      }
      resultat += aplatir(bloc.contenu, niveau: niveau + 1, textes: textes, commentaires: commentaires)
    } else if textes or type(bloc) != content {
      resultat.push(bloc)
    }
  }
  resultat
}

#let nombre-questions(contenu) = aplatir(contenu).filter(bloc => type(bloc) == dictionary).len()

#let exercice(meta: (:), contenu: (), debut: 1, remarques: none, corrections: none) = {
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
  if duree != none {
    assert(type(duree) == array and duree.len() == 2,
      message: "duree doit être un couple (heures, minutes) ou none")
    let (heures, minutes) = duree
    assert(type(heures) == int and type(minutes) == int,
      message: "heures et minutes doivent être des entiers")
    assert(heures >= 0 and minutes >= 0 and minutes < 60 and heures + minutes > 0,
      message: "duree doit être positive, avec 0 ≤ minutes < 60")
  }
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
  let verifier(blocs) = {
    assert(type(blocs) == array, message: "contenu doit être un tableau de textes, questions et parties")
    for bloc in blocs {
      if est-partie(bloc) {
        verifier(bloc.contenu)
      } else if type(bloc) != content {
        assert(type(bloc) == dictionary, message: "Utiliser [texte libre], question(…) ou partie(…) dans contenu")
        assert(bloc.at("type", default: none) == "question", message: "Bloc inconnu dans contenu")
        assert("enonce" in bloc and "solution" in bloc, message: "Construire les questions avec question(…)")
      }
    }
  }
  verifier(contenu)
  assert(corrections == none or type(corrections) == content, message: "corrections doit être un contenu Typst ou none")
  assert(remarques == none or type(remarques) == content, message: "remarques doit être un contenu Typst ou none")
  assert(nombre-questions(contenu) > 0, message: "Un exercice doit contenir au moins une question")
  (
    meta: (niveaux: (), duree: none, ..meta, concours: concours-normalise),
    contenu: contenu,
    debut: debut,
    remarques: remarques,
    corrections: corrections,
  )
}

// Présentation inspirée de texmf/tex/latex/{exam.cls,exercise.cls,code.sty}.
#let afficher-exercice(ex, numero: none, corrige: false, details: true, afficher-titre: true) = {
  show strong: it => it.body
  show heading: set text(weight: "bold")
  [#metadata(ex.meta) <exercice-meta>]
  if afficher-titre {
    let prefixe = if numero == none { "I" } else { numbering("I", numero) }
    let titre = if ex.meta.concours == none { ex.meta.titre } else { texte-concours(ex.meta.concours) }
    titre-exercice(titre, prefixe, duree: ex.meta.duree)
  }
  if corrige and ex.corrections != none {
    block(width: 100%, above: 12pt, below: 12pt)[
      Modifications par rapport à l'énoncé initial :
      #ex.corrections
    ]
  }
  if corrige and ex.remarques != none {
    block(width: 100%, above: 12pt, below: 12pt, text(style: "italic", ex.remarques))
  }
  let i = ex.debut
  // Les textes de contexte restent dans l'énoncé ; les titres des parties sont conservés.
  for q in aplatir(ex.contenu, textes: not corrige, commentaires: corrige) {
    if type(q) == content {
      block(width: 100%, above: 12pt, below: 12pt, q)
      continue
    }
    // Chaque énoncé est un paragraphe distinct ; les longues questions restent sécables.
    block(width: 100%, above: 12pt, below: 5pt,
      enum(start: i, numbering: "1.",
        indent: 0pt, body-indent: 0.5em, q.enonce),
    )
    if corrige {
      if q.commentaire != none {
        block(width: 100%, above: 5pt, below: 5pt, text(style: "italic", q.commentaire))
      }
      block(
        width: 100%, stroke: (left: 0.4pt + luma(60%)),
        inset: (left: 10pt, y: 3pt), above: 8pt, below: 10pt,
        if q.solution == none { emph[Corrigé à compléter.] } else { q.solution },
      )
    }
    i += 1
  }
}

#let feuille(
  titre: "Feuille d'exercices",
  niveau: none,
  exercices: (),
  corrige: false,
  details: true,
  nouvelle-page: false,
  body,
) = {
  let titre-affiche = titre + if corrige { " : corrigé" } else { "" }
  let durees = exercices.map(ex => ex.meta.duree).filter(duree => duree != none)
  let duree = if durees.len() == exercices.len() {
    let minutes = durees.map(duree => 60 * duree.first() + duree.last()).sum()
    (calc.floor(minutes / 60), calc.rem(minutes, 60))
  } else {
    none
  }
  set document(title: titre-affiche)
  set text(font: "New Computer Modern", size: 11pt, lang: "fr")
  set par(justify: true, leading: 0.55em, spacing: 0.8em)
  set page(
    paper: "a4", margin: (x: 14mm, top: 25mm, bottom: 18mm),
    header-ascent: 9mm,
    header: context if counter(page).get().first() == 1 [
      #set text(size: 10pt)
      #grid(
        columns: (24mm, 1fr, 24mm), align: (left, center, right),
        if niveau != none { niveau } else { [] },
        text(size: 12pt, weight: "bold", titre-affiche),
        if duree != none { texte-duree(duree) } else { [] },
      )
      #v(4pt)
      #line(length: 100%, stroke: 0.4pt)
    ],
    footer: context align(center, text(size: 9pt, counter(page).display("1 / 1", both: true))),
  )
  set heading(numbering: none)
  show heading.where(level: 1): set text(size: 15pt)
  show heading.where(level: 2): set text(size: 12pt)
  show heading.where(level: 3): set text(size: 11pt)
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
