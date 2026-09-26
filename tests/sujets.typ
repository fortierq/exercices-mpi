#import "/lib/exercices.typ": aplatir, nombre-questions, est-partie
#import "/sujets/centrale-2022-mp-informatique.typ": ex as sujet, palindromes
#import "/exercices/langages/palindromes-et-rationalite.typ": ex

#assert(nombre-questions(sujet.contenu) == 50)
#assert(aplatir(sujet.contenu).filter(b => type(b) == dictionary).all(q => q.solution != none))
#assert(nombre-questions(ex.contenu) == 7)
#assert(ex.debut == 1)
#assert(ex.meta.titre == "Palindromes et régularité")
#assert(ex.meta.concours == sujet.meta.concours)
#assert(ex.meta.langages == ("OCaml",))
#assert(ex.meta.algorithmes == () and ex.meta.structures == ())
#assert(ex.meta.difficulte == 3 and ex.meta.duree == none)

// L’exercice autonome réutilise directement l’objet exporté par le sujet.
#assert(sujet.contenu.filter(b => type(b) == dictionary).first().contenu.at(1) == palindromes)
#assert(ex.contenu == palindromes.contexte + palindromes.contenu)
#assert(ex.meta.concours == palindromes.meta.concours)

#let parties = sujet.contenu.filter(est-partie)
#assert(parties.map(p => nombre-questions(p.contenu)) == (29, 14, 7))
// L’insertion de la partie partagée conserve l’ordre des questions 6 à 12.
#let questions = aplatir(sujet.contenu).filter(b => type(b) == dictionary)
#assert(questions.slice(5, 12) == palindromes.contenu.filter(b => type(b) == dictionary))

Vérification du sujet et de la partie partagée réussie.
