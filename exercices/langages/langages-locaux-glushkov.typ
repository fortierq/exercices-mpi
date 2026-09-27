#import "/lib/exercices.typ": exercice, question

#let ex = exercice(
  meta: (
    titre: "Langage local, linéaire et automate de Glushkov",
    chapitres: ("langages-reguliers", "automates-finis"),
    algorithmes: ("berry-sethi",),
    structures: (),
    langages: (),
    difficulte: 3,
    niveaux: ("MPI",),
    concours: none,
  ),
  contenu: (
    question([Construire l'automate de Glushkov reconnaissant $(a b | b)^* b$.]),
    question([
      Montrer que si $L_1$ et $L_2$ sont locaux alors $L_1 ∩ L_2$ est local
      (même si les alphabets ne sont pas disjoints, contrairement à l'union
      et à la concaténation vues en cours).
    ]),
    question([
      Montrer qu'il existe un nombre fini de langages locaux sur un alphabet fixé.
    ], solution: [
      Tout langage local est de la forme
      $ (P Σ^* ∩ Σ^* S) ∖ Σ^* N Σ^* $
      où $P ⊆ Σ$, $S ⊆ Σ$, $N ⊆ Σ × Σ$, en rajoutant éventuellement $ε$.
      Si $n = abs(Σ)$, il y a au plus $2^n$ choix pour $P$, $2^n$ pour $S$
      et $2^(n^2)$ pour $N$, car $abs(Σ × Σ) = n^2$.
      Il y a donc au plus $2^n × 2^n × 2^(n^2)$ valeurs différentes pour
      l'ensemble $(P Σ^* ∩ Σ^* S) ∖ Σ^* N Σ^*$, et au plus
      $2^(n^2 + 2n + 1)$ langages locaux en tenant compte du choix d'ajouter $ε$.
    ]),
    question([
      Soient $cal(L)_"reg"$, $cal(L)_"loc"$, $cal(L)_"lin"$ les ensembles
      des langages réguliers, locaux et linéaires (c'est-à-dire décrits par une
      expression régulière linéaire). Quelles sont les inclusions entre ces
      trois ensembles ? Ces inclusions sont-elles strictes ?
    ]),
  ),
)
