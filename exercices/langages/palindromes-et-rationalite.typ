#import "/lib/exercices.typ": exercice, question

#let ex = exercice(
  meta: (
    titre: "Extrait Centrale 2022 : Palindromes et rationalité",
    chapitres: ("langages-reguliers", "automates-finis"),
    algorithmes: (),
    structures: (),
    langages: ("OCaml",),
    difficulte: 3,
    niveaux: ("MPI", "MP"),
    concours: none,
    reference: "Centrale 2022, extrait (épreuve non précisée dans la source)",
  ),
  contenu: (
    [Soit $w ∈ Σ^*$. On note $tilde(w)$ le mot obtenu à partir de $w$ en
      inversant l'ordre des lettres et on dit que le mot $w$ est un palindrome
      si $tilde(w)=w$.],
    question([Écrire une fonction 'palindrome' de signature 'string → bool'
      qui teste, en temps linéaire, si un mot est un palindrome.]),
    [Pour un alphabet $Σ$, on note $"Pal"(Σ)$ l'ensemble des palindromes de $Σ^*$.],
    question([Montrer que si $Σ$ est un alphabet à une lettre, alors $"Pal"(Σ)$ est régulier.]),
    question([
      Montrer que si $Σ$ contient au moins deux lettres, alors $"Pal"(Σ)$ n'est pas régulier.
      On pourra utiliser un automate et un mot de $"Pal"(Σ) ∩ a^* b a^*$.
    ]),
    [Soit $L ⊆ Σ^*$ un langage reconnu par l'automate $A=(Q,I,F,T)$.
      Pour $(q,q') ∈ Q^2$, on note $L_(q,q')$ le langage de tous les mots $w$
      qui étiquettent un chemin dans $A$ partant de $q$ et arrivant en $q'$.],
    question([Montrer que $L_(q,q')$ est reconnaissable et exprimer le langage
      $L_A$ en fonction de langages $L_(q,q')$.]),
    question([Montrer que $"Pal"(Σ) ∩ (Σ^2)^* = {u tilde(u) | u ∈ Σ^*}$.]),
    [Soit $L$ un langage régulier reconnu par un automate $A=(Q,I,F,T)$.
      On définit les langages
      $D(L)={w tilde(w) | w ∈ L}$ et $R(L)={w ∈ Σ^* | w tilde(w) ∈ L}$.],
    question([Décrire simplement les langages $D(a^* b)$ et $R(a^* b^* a^*)$.]),
    question([Les langages $D(L)$ et $R(L)$ sont-ils reconnaissables ?
      On pourra faire intervenir les langages $L_(q,q')$, définis ci-dessus.]),
  ),
)
