// Point d'entrée commun aux sujets et à leurs corrigés.
#import "/lib/sujets.typ": epreuve
#let chemin = sys.inputs.at("sujet", default: "/modeles/sujet-concours.typ")
#import chemin: sujet
#show: epreuve.with(sujet, corrige: sys.inputs.at("corrige", default: "false") == "true")
