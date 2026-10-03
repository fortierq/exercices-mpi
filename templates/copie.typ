#import "/lib/exercices.typ": feuille
#import "/lib/copies.typ": copie, questions-copie
// Remplacer cet import par celui de la feuille à corriger (export sujet).
#import "/concours/19/mines-ponts-2019-mp-informatique.typ": sujet

#let donnees = (
  feuille: "concours/19/mines-ponts-2019-mp-informatique.typ",
  nom: "Nom", prenom: "Prénom", classe: "MPI", source: "",
  appreciation: "Appréciation à compléter.",
  // Pour une vraie copie, saisir les évaluations dans un JSON du dossier privé.
  evaluations: questions-copie(sujet).map(q => (q.cle, (
    repondue: false, reussite: none, commentaire: "",
  ))).to-dict(),
)
#let corrige = sys.inputs.at("corrige", default: "false") == "true"
#show: feuille.with(type: "copie", titre: "Copie individuelle", exercices: (), corrige: corrige)
#copie(sujet, donnees, corrige: corrige)
