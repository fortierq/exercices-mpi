#import "/lib/exercices.typ": exercice, question
#import "/ressources/colle1-langages-automates/figures.typ": automate-ccp

#let ex = exercice(
  meta: (
    titre: "Sujet 0 CCP",
    chapitres: ("langages-reguliers", "automates-finis"),
    algorithmes: ("determinisation",),
    structures: (),
    langages: (),
    difficulte: 3,
    niveaux: ("MPI",),
    concours: none,
  ),
  contenu: (
    question([Rappeler la définition d'un langage régulier.]),
    question([
      Les langages suivants sont-ils réguliers ? Justifier.
      #enum(numbering: "(a)",
        [$L_1 = {a^n b a^m | n,m ∈ NN}$],
        [$L_2 = {a^n b a^m | n,m ∈ NN, n ≤ m}$],
        [$L_3 = {a^n b a^m | n,m ∈ NN, n > m}$],
        [$L_4 = {a^n b a^m | n,m ∈ NN, n+m ≡ 0 (mod 2)}$],
      )
    ]),
    question([
      On considère l'automate non déterministe suivant :
      #align(center, automate-ccp())
      #enum(numbering: "(a)",
        [Déterminiser cet automate.],
        [Construire une expression régulière dénotant le langage reconnu par cet automate.],
        [Décrire simplement avec des mots le langage reconnu par cet automate.],
      )
    ]),
  ),
)
