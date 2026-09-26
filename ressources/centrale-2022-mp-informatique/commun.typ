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
    initial: if miroir { false } else { (label: none) })
  state((2.5, 0), "s1", label: $1$)
  state((5, 0), "s2", label: $2$,
    initial: if miroir { (anchor: right, label: none) } else { false })
  if miroir {
    transition("s1", "s0", label: $a$, curve: 0)
    transition("s2", "s1", label: $b$, curve: 0)
    cetz.draw.line("s0.west", (-1.1, 0), mark: (end: "straight"))
  } else {
    transition("s0", "s1", label: $a$, curve: 0)
    transition("s1", "s2", label: $b$, curve: 0)
    cetz.draw.line("s2.east", (6.1, 0), mark: (end: "straight"))
  }
  transition("s0", "s0", label: $a,b$, anchor: top)
  transition("s2", "s2", label: $a$, anchor: top)
}))

#let arbre-e4() = align(center, cetz.canvas({
  cetz.draw.set-style(content: (padding: 0.08))
  cetz.tree.tree(
    ($+$, $a$, ($dot$, $b$, ($dot$, $b$, ($dot$, $b$, ($dot$, $b$, $∅$))))),
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
