#import "/lib/exercices.typ": exercice, question
#import "@preview/finite:0.5.1" as finite
#import "@preview/cetz:0.4.2" as cetz

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
    question([Construire l'automate de Glushkov reconnaissant $(a b | b)^* b$.], solution: [
      On linéarise l'expression en $(a_1 b_2 | b_3)^* b_4$.
      Les premières lettres possibles sont $P = {a_1,b_3,b_4}$, la seule
      dernière lettre est $b_4$, et les facteurs de longueur deux sont
      $ {a_1 b_2, b_2 a_1, b_2 b_3, b_2 b_4, b_3 a_1, b_3 b_3, b_3 b_4}. $
      On crée un état initial $0$ et un état par position. Une transition
      issue de $0$ mène à chaque position de $P$ ; chaque facteur $x_i y_j$
      donne une transition de $i$ à $j$, étiquetée par $y$ après délinéarisation.
      L'état $4$ est le seul état final, car le mot vide n'est pas reconnu.
      #align(center, cetz.canvas({
        import finite.draw: state, transition
        cetz.draw.set-style(transition: (label: (angle: 0deg)))
        state((0, 0), "0", label: $0$, initial: (label: none))
        state((3, 2), "1", label: $1$)
        state((6, 2), "2", label: $2$)
        state((4.5, -1), "3", label: $3$)
        state((9, 0), "4", label: $4$, final: true)
        transition("0", "1", label: $a$, curve: 0)
        transition("0", "3", label: $b$, curve: 0)
        transition("0", "4", label: $b$, curve: -1.8)
        transition("1", "2", label: $b$, curve: 0.4)
        transition("2", "1", label: $a$, curve: 0.4)
        transition("2", "3", label: $b$, curve: 0)
        transition("2", "4", label: $b$, curve: 0)
        transition("3", "1", label: $a$, curve: 0)
        transition("3", "3", label: $b$, anchor: bottom)
        transition("3", "4", label: $b$, curve: 0)
      }))
    ]),
    question([
      Montrer que si $L_1$ et $L_2$ sont locaux alors $L_1 ∩ L_2$ est local
      (même si les alphabets ne sont pas disjoints, contrairement à l'union
      et à la concaténation vues en cours).
    ], solution: [
      Sur l'alphabet commun $Σ$ (au besoin l'union des deux alphabets), écrivons
      $L_i ∖ {ε} = (P_i Σ^* ∩ Σ^* S_i) ∖ Σ^* N_i Σ^*$ pour $i ∈ {1,2}$.
      Un mot non vide appartient aux deux langages exactement lorsque sa
      première lettre est dans $P_1 ∩ P_2$, sa dernière dans $S_1 ∩ S_2$
      et aucun de ses facteurs de longueur deux n'est dans $N_1 ∪ N_2$.
      Ainsi
      $ (L_1 ∩ L_2) ∖ {ε}
          = ((P_1 ∩ P_2) Σ^* ∩ Σ^* (S_1 ∩ S_2)) ∖ Σ^* (N_1 ∪ N_2) Σ^*. $
      C'est une description locale. On ajoute $ε$ si et seulement s'il
      appartient à la fois à $L_1$ et à $L_2$.
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
    ], solution: [
      D'après le cours, tout langage décrit par une expression régulière
      linéaire est local. Tout langage local est reconnaissable, donc régulier
      par le théorème de Kleene. Ainsi
      $ cal(L)_"lin" ⊆ cal(L)_"loc" ⊆ cal(L)_"reg". $
      Les deux inclusions sont strictes dès que l'alphabet contient une lettre $a$.

      Le langage $L = {a^n | n ≥ 1}$ est local : les premières et dernières
      lettres sont $a$, le seul facteur autorisé de longueur deux est $a a$,
      et $ε$ est exclu. Il n'est pas linéaire. En effet, dans une expression
      linéaire produisant $a a$, l'unique occurrence de $a$ doit être répétée
      par une étoile. Considérons l'étoile la plus extérieure contenant cette
      occurrence. Dans cette production, tout ce qui lui est extérieur produit le mot vide, puisqu'il ne contient aucune autre occurrence
      de $a$. En prenant zéro répétition, on produirait donc aussi $ε$,
      ce qui est impossible pour $L$.

      Le langage dénoté par $(a a)^*$ est régulier mais pas local : puisque
      $a a$ appartient au langage, ses ensembles de premières et dernières
      lettres contiennent $a$. La condition locale accepterait alors aussi
      le mot $a$ (qui n'a aucun facteur de longueur deux), alors que sa
      longueur est impaire.
      Sur l'alphabet vide, les trois familles coïncident avec ${∅, {ε}}$.
    ]),
  ),
)
