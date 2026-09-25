#import "@preview/finite:0.5.1" as finite
// Même version de CeTZ que celle utilisée par finite 0.5.1.
#import "@preview/cetz:0.4.2" as cetz

#let arden-1() = cetz.canvas({
  import finite.draw: state, transition
  cetz.draw.set-style(transition: (label: (angle: 0deg)))
  state((0, 0), "q0", label: $q_0$, initial: (label: none), final: true)
  state((3, 0), "q1", label: $q_1$)
  state((6, 0), "q2", label: $q_2$, final: true)
  transition("q0", "q1", label: $a$, curve: 0)
  transition("q1", "q1", label: $b$)
  transition("q1", "q2", label: $a$, curve: 0)
  transition("q2", "q2", label: $a,b$)
})

#let arden-2() = cetz.canvas({
  import finite.draw: state, transition
  cetz.draw.set-style(transition: (label: (angle: 0deg)))
  state((0, 0), "q0", label: $q_0$, initial: (label: none))
  state((3, 0), "q1", label: $q_1$, final: true)
  state((0, -2.5), "q2", label: $q_2$, initial: (label: none))
  transition("q0", "q0", label: $a$)
  transition("q0", "q1", label: $a$, curve: 0.6)
  transition("q1", "q1", label: $a$)
  transition("q1", "q0", label: $b$, curve: 0.6)
  transition("q2", "q1", label: $b$, curve: -0.4)
})

#let automate-ccp() = cetz.canvas({
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
})

#let arbre-dyck() = cetz.canvas({
  import cetz.draw: line, circle
  // Arbre N(N(F, N(F, F)), F), associé au mot aababb.
  let sommets = ((0, 0), (-1.4, -1.2), (1.4, -1.2),
    (-2.2, -2.4), (-0.6, -2.4), (-1.2, -3.6), (0, -3.6))
  for (parent, enfant) in ((0, 1), (0, 2), (1, 3), (1, 4), (4, 5), (4, 6)) {
    line(sommets.at(parent), sommets.at(enfant))
  }
  for sommet in sommets {
    circle(sommet, radius: 0.08, fill: white)
  }
})
