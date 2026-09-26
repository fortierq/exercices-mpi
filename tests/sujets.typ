#import "/lib/exercices.typ": question
#import "/lib/sujets.typ": partie, sujet-concours, extraire-partie, aplatir, nombre-questions
#import "/sujets/centrale-2022-mp-informatique.typ": sujet
#import "/exercices/langages/palindromes-et-rationalite.typ": ex

#assert(nombre-questions(sujet.contenu) == 50)
#assert(aplatir(sujet.contenu).filter(b => type(b) == dictionary).all(q => q.solution != none))
#assert(nombre-questions(extraire-partie(sujet, "I").contenu) == 29)
#assert(nombre-questions(extraire-partie(sujet, "II").contenu) == 14)
#assert(nombre-questions(extraire-partie(sujet, "III").contenu) == 7)
#assert(extraire-partie(sujet, "I.B", numerotation-originale: true).debut == 6)
#assert(extraire-partie(sujet, "II", numerotation-originale: true).debut == 30)
#assert(extraire-partie(sujet, "II.B.3", numerotation-originale: true).debut == 38)
#assert(extraire-partie(sujet, "III", numerotation-originale: true).debut == 44)
#assert(nombre-questions(ex.contenu) == 7)
#assert(ex.debut == 1)
#assert(ex.contenu == extraire-partie(sujet, "I.B").contenu)
#assert(ex.meta.titre == "Palindromes et régularité")
#assert(ex.meta.concours == sujet.meta.concours)
#assert(ex.meta.langages == ("OCaml",))
#assert(ex.meta.algorithmes == () and ex.meta.structures == ())
#assert(ex.meta.difficulte == 3 and ex.meta.duree == none)

// Les textes intercalés ne comptent pas comme questions ; les rappels des
// parties parentes s'ajoutent dans l'ordre, sans embarquer le sujet entier.
#let q = question([Question commune.], solution: [Solution commune.])
#let exemple = sujet-concours(meta: sujet.meta, contenu: (
  [Introduction globale.], q,
  partie("A", "Parent", contexte: ([Rappel parent.],), contenu: (
    [Texte non numéroté.], q,
    partie("A.1", "Enfant", contexte: ([Rappel enfant.],),
      meta: (difficulte: 2,), contenu: ([Définition.], q, [Conclusion.],)),
  )),
))
#let extrait = extraire-partie(exemple, "A.1", numerotation-originale: true,
  meta: (titre: "Titre choisi", duree: 15))
#assert(extrait.debut == 3)
#assert(extrait.contenu == ([Rappel parent.], [Rappel enfant.], [Définition.], q, [Conclusion.]))
#assert(extrait.meta.titre == "Titre choisi" and extrait.meta.duree == 15)
#assert(extrait.meta.difficulte == 2)

Vérification des sujets et de l'extraction réussie.
