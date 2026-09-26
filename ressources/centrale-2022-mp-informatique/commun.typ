#import "@preview/cetz:0.4.2" as cetz
#import "@preview/finite:0.5.1" as finite

// Le code affiché est exactement celui compilé et testé.
#let source = read("corrige.ml")
#let code(nom) = {
  let debut = "(* BEGIN " + nom + " *)\n"
  let fin = "(* END " + nom + " *)"
  assert(source.split(debut).len() == 2, message: "Région OCaml introuvable : " + nom)
  raw(source.split(debut).at(1).split(fin).first().trim(), lang: "ocaml", block: true)
}

#let automate-a1(miroir: false) = align(center, cetz.canvas({
  import finite.draw: state, transition
  cetz.draw.set-style(transition: (label: (angle: 0deg)))
  state((0, 0), "s0", label: $0$,
    initial: if miroir { false } else { (label: none) }, final: miroir)
  state((2.5, 0), "s1", label: $1$)
  state((5, 0), "s2", label: $2$,
    initial: if miroir { (anchor: right, label: none) } else { false }, final: not miroir)
  if miroir {
    transition("s1", "s0", label: $a$, curve: 0)
    transition("s2", "s1", label: $b$, curve: 0)
  } else {
    transition("s0", "s1", label: $a$, curve: 0)
    transition("s1", "s2", label: $b$, curve: 0)
  }
  transition("s0", "s0", label: $a,b$, anchor: top)
  transition("s2", "s2", label: $a$, anchor: top)
}))

#let arbre-e4() = align(center, cetz.canvas({
  cetz.draw.set-style(content: (padding: 0.08))
  cetz.tree.tree(
    ($|$, $a$, ($dot$, $b$, ($dot$, $b$, ($dot$, $b$, ($dot$, $b$, $∅$))))),
    grow: 0.7, spread: 0.5,
  )
}))

#let graphe-matrice() = align(center, cetz.canvas({
  import finite.draw: state, transition
  cetz.draw.set-style(transition: (label: (angle: 0deg)))
  state((0, 0), "s0", label: $0$)
  state((3, 0), "s1", label: $1$)
  transition("s0", "s0", label: $a$, anchor: top)
  transition("s1", "s1", label: $d$, anchor: top)
  transition("s0", "s1", label: $b$, curve: 0.4)
  transition("s1", "s0", label: $c$, curve: 0.4)
}))

#let antimirov() = align(center, cetz.canvas({
  import finite.draw: state, transition
  cetz.draw.set-style(transition: (label: (angle: 0deg)))
  state((0, 0), "E", label: $E$, initial: (label: none))
  state((3, 0), "bE", label: $b E$)
  state((0, -2.5), "a", label: $a$)
  state((3, -2.5), "epsilon", label: $ε$, final: true)
  transition("E", "E", label: $b$, anchor: top)
  transition("E", "bE", label: $a$, curve: 0.25)
  transition("bE", "E", label: $b$, curve: 0.25)
  transition("E", "a", label: $b$, curve: 0)
  transition("a", "epsilon", label: $a$, curve: 0)
}))

// Les données de transitions restent explicites pour vérifier les déterminisations.
#let dessiner-determinise(etats, transitions) = align(center, cetz.canvas({
  import finite.draw: state, transition
  cetz.draw.set-style(transition: (label: (angle: 0deg)))
  for (position, nom, etiquette, initial, final) in etats {
    state(position, nom, label: etiquette,
      initial: if initial { (label: none) } else { false }, final: final)
  }
  for (depart, arrivee, etiquette, style) in transitions {
    transition(depart, arrivee, label: etiquette, ..style)
  }
}))

#let automate-a3() = dessiner-determinise(
  (
    ((0, 0), "e0", $e_0$, true, false),
    ((2.8, 0), "e1", $e_1$, false, false),
    ((4.2, -2.8), "e2", $e_2$, false, false),
    ((5.6, 0), "e3", $e_3$, false, true),
    ((8.4, 0), "e4", $e_4$, false, true),
  ),
  (
    ("e0", "e1", $a$, (curve: 0)),
    ("e0", "e2", $b$, (curve: 0)),
    ("e1", "e2", $a$, (curve: 0)),
    ("e1", "e3", $b$, (curve: 0)),
    ("e2", "e2", $a,b$, (anchor: bottom)),
    ("e3", "e2", $a$, (curve: 0)),
    ("e3", "e4", $b$, (curve: 0.25)),
    ("e4", "e3", $a$, (curve: 0.25)),
    ("e4", "e4", $b$, (anchor: top)),
  ),
)

#let automate-a4() = dessiner-determinise(
  (
    ((0, 0), "q0", $q_0$, true, false),
    ((0, 2.8), "q1", $q_1$, false, false),
    ((3, 0), "q2", $q_2$, false, false),
    ((6, 2.8), "q3", $q_3$, false, false),
    ((6, 0), "q4", $q_4$, false, true),
  ),
  (
    ("q0", "q1", $a$, (curve: 0.25)),
    ("q0", "q2", $b$, (curve: 0)),
    ("q1", "q3", $a$, (curve: 0)),
    ("q1", "q0", $b$, (curve: 0.25)),
    ("q2", "q4", $a$, (curve: 0)),
    ("q2", "q2", $b$, (anchor: top)),
    ("q3", "q3", $a,b$, (anchor: right)),
    ("q4", "q3", $a$, (curve: 0)),
    ("q4", "q0", $b$, (curve: 0.6)),
  ),
)
