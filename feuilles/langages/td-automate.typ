#import "/lib/exercices.typ": feuille, exercice, question
#import "@preview/finite:0.5.1" as finite
#import "@preview/cetz:0.4.2" as cetz
#import "/exercices/langages/cloture-miroir-prefixes-suffixes-facteurs.typ": ex as cloture
#import "/exercices/langages/reconnaissable-ou-non.typ": ex as reconnaissable
#import "/exercices/langages/algorithmes-vacuite-finitude-equivalence.typ": ex as algorithmes
#import "/exercices/langages/longueur-discriminante-automates.typ": ex as longueur
#import "/exercices/langages/ensembles-distinguants-automates.typ": ex as distinguant
#import "/exercices/langages/automates-palindromes.typ": ex as palindromes

// Source : cours-src/langage/automate/td/td_automate.tex.
// Figures : /Users/qfortier/tikz/automata/a4/a4.tex et a4_det/a4_det.tex.
#let determinisation = exercice(
  meta: (
    titre: "Algorithme de déterminisation",
    chapitres: ("automates-finis", "langages-reguliers"),
    algorithmes: ("determinisation",),
    structures: (),
    langages: (),
    difficulte: 2,
    niveaux: ("MPI",),
    concours: none,
  ),
  contenu: (

    question([
      Déterminiser l'automate suivant en utilisant l'algorithme du cours :
      #align(center, cetz.canvas(length: 0.8cm, {
        import finite.draw: state, transition
        cetz.draw.set-style(state: (radius: 0.85), transition: (label: (angle: 0deg)))
        state((0,0), "1", label: $1$, initial: (label: none))
        state((3,0), "2", label: $2$, final: true)
        state((0,-2.5), "3", label: $3$)
        state((3,-2.5), "4", label: $4$)
        transition("1", "2", label: $a$, curve: 0)
        transition("1", "3", label: $a$, curve: 0)
        transition("2", "4", label: $a$, curve: 0)
        transition("3", "4", label: $b$, curve: 0)
        transition("4", "1", label: $b$, curve: 0)
        transition("4", "4", label: $b$)
      }))
    ], solution: [
      L'état initial est ${1}$ ; les états finaux sont les ensembles contenant $2$.
      Pour chaque ensemble $X$, la transition sur $c$ mène à $⋃_(q∈X)δ(q,c)$.
      Les seuls ensembles accessibles sont ${1}$, ${2,3}$, ${4}$, ${1,4}$ et $∅$ :
      #align(center, cetz.canvas(length: 0.8cm, {
        import finite.draw: state, transition
        cetz.draw.set-style(state: (radius: 0.85), transition: (label: (angle: 0deg)))
        state((0,0), "1", label: ${1}$, initial: (label: none))
        state((3,0), "23", label: ${2,3}$, final: true)
        state((6,0), "4", label: ${4}$)
        state((9,0), "14", label: ${1,4}$)
        state((3,-3), "vide", label: $∅$)
        transition("1", "23", label: $a$, curve: 0)
        transition("1", "vide", label: $b$, curve: 0)
        transition("23", "4", label: $a,b$, curve: 0)
        transition("4", "vide", label: $a$, curve: 0)
        transition("4", "14", label: $b$, curve: 0)
        transition("14", "23", label: $a$, curve: -1.5)
        transition("14", "14", label: $b$)
        transition("vide", "vide", label: $a,b$)
      }))
    ]),
  ),
)

#show: feuille.with(
  titre: "Automates",
  niveau: "MPI",
  auteur: "Q. Fortier",
  exercices: (determinisation, cloture, reconnaissable, algorithmes, longueur, distinguant, palindromes),
  corrige: sys.inputs.at("corrige", default: "false") == "true",
)
