#import "/lib/exercices.typ": exercice, question
#import "@preview/finite:0.5.1" as finite
#import "@preview/cetz:0.4.2" as cetz

#let ex = exercice(
  meta: (
    titre: "Sujet 0 CCP",
    chapitres: ("langages-reguliers", "automates-finis"),
    algorithmes: ("determinisation",),
    structures: (),
    langages: (),
    difficulte: 2,
    niveaux: ("MPI",),
    concours: (nom: "CCP", annee: 2022, filiere: "MPI", oral: true),
  ),
  contenu: (
    question([Rappeler la définition d'un langage régulier.]),
    question([
      Les langages suivants sont-ils réguliers ? Justifier.
      #grid(columns: 2, column-gutter: 1em, align: top,
        [#enum(numbering: "(a)",
          [$L_1 = {a^n b a^m | n,m ∈ NN}$],
          [$L_2 = {a^n b a^m | n,m ∈ NN, n ≤ m}$],
        )],
        [#enum(start: 3, numbering: "(a)",
          [$L_3 = {a^n b a^m | n,m ∈ NN, n > m}$],
          [$L_4 = {a^n b a^m | n,m ∈ NN, n+m ≡ 0 thin (mod 2)}$],
        )],
      )
    ]),
    question([
      On considère l'automate non déterministe suivant :
      #align(center, cetz.canvas({
        import finite.draw: state, transition
        cetz.draw.set-style(transition: (label: (angle: 0deg)))
        state((0, 0), "s0", label: $0$, initial: (label: none))
        state((3, 0), "s1", label: $1$, final: true)
        state((0, -3), "s2", label: $2$, initial: (label: none))
        state((3, -3), "s3", label: $3$, final: true)
        transition("s0", "s1", label: $a$, curve: 0)
        transition("s0", "s2", label: $ε$, curve: 0)
        transition("s2", "s1", label: $a$, curve: 0.35)
        transition("s2", "s3", label: $b$, curve: 0)
        transition("s1", "s3", label: $b$, curve: 0.6)
        transition("s3", "s1", label: $a$, curve: 0.6)
        transition("s3", "s0", label: $ε$, curve: 0.35)
      }))
      #enum(numbering: "(a)",
        [Déterminiser cet automate.],
        [Construire une expression régulière dénotant le langage reconnu par cet automate.],
        [Décrire simplement avec des mots le langage reconnu par cet automate.],
      )
    ]),
  ),
)
