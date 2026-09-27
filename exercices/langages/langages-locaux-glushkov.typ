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
        // Passer sous l’état central et sa boucle pour dégager l’étiquette.
        transition("0", "4", label: $b$, curve: -5)
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
      Posons $L = L_1 ∩ L_2$ et travaillons sur l'alphabet $Σ$ obtenu,
      si nécessaire, en réunissant les deux alphabets.
      Puisque tout mot de $L$ appartient à $L_1$ et à $L_2$, on a
      $ P(L) ⊆ P(L_1) ∩ P(L_2), quad S(L) ⊆ S(L_1) ∩ S(L_2), $
      $ F(L) ⊆ F(L_1) ∩ F(L_2). $
      En effet, une première lettre, une dernière lettre ou un facteur de
      longueur deux d'un mot de $L$ apparaît aussi dans un mot de chacun
      des langages $L_1$ et $L_2$.

      Soit $u = u_1 … u_n$ un mot non vide, avec $n ≥ 1$.
      Si $u ∈ L$, alors, par définition de ces ensembles,
      $u_1 ∈ P(L)$, $u_n ∈ S(L)$ et
      $u_k u_(k+1) ∈ F(L)$ pour tout $k ∈ {1, …, n-1}$.

      Réciproquement, supposons que $u_1 ∈ P(L)$, $u_n ∈ S(L)$ et
      que tous les facteurs $u_k u_(k+1)$ de longueur deux de $u$
      appartiennent à $F(L)$.
      Les inclusions précédentes donnent, pour chaque $i ∈ {1,2}$,
      $ u_1 ∈ P(L_i), quad u_n ∈ S(L_i), quad
        ∀ k ∈ {1, …, n-1}, u_k u_(k+1) ∈ F(L_i). $
      Comme $L_i$ est local, ces conditions entraînent $u ∈ L_i$.
      Ainsi $u ∈ L_1$ et $u ∈ L_2$, donc $u ∈ L$.

      On a donc établi la caractérisation locale de $L$ pour tout mot
      non vide. Lorsque $n = 1$, la condition sur les facteurs de longueur
      deux est vide. Enfin, $ε ∈ L$ si et seulement si $ε ∈ L_1$ et
      $ε ∈ L_2$ ; le statut du mot vide n'intervient pas dans cette
      caractérisation. Le langage $L_1 ∩ L_2$ est donc local.
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
