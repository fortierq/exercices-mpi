# Consignes pour les assistants

## Structure et conversion

- Lire l’API actuelle dans `lib/exercices.typ`, les modèles et le Makefile avant
  toute modification. Préserver les modifications de l’utilisateur.
- Un fichier `exercices/<chapitre>/<identifiant>/exercice.typ` exporte un objet
  `ex`. Une feuille `feuilles/<nom>.typ` assemble ces objets dans l’ordre voulu.
- `contenu` alterne librement `[texte]` et `question([énoncé], solution: [...])`.
  Autoriser du texte avant, entre et après les questions. Pas de champ `introduction`.
- Lire les sources LaTeX et leurs inclusions, y compris les corrigés conditionnels.
  Préserver l’ordre, les notations et les raisonnements. Ne convertir que les
  exercices actifs. Ne pas modifier les fichiers LaTeX d’origine.
- Corriger uniquement les erreurs importantes : hypothèse indispensable,
  énoncé faux, preuve invalide, code incorrect, solution mal associée.
  Documenter ces corrections dans `docs/` ou dans une note de migration.
  Ne pas ajouter silencieusement de questions ou de solutions.
- Vérifier en particulier le mot vide, les domaines et la finitude. Un facteur
  est un bloc contigu : v est facteur de w s’il existe x et y tels que w = xvy.
  Le distinguer d’un sous-mot obtenu par suppression de lettres.

## Métadonnées

- Renseigner les champs requis par `exercice` ; identifiant unique, difficulté
  de 1 à 5 (estimation), concours seulement lorsque l’attribution est connue.
  Ne pas inventer d’année. Ne pas ajouter `version` ni `provenance`.
- Utiliser exclusivement les chapitres, structures et algorithmes mentionnés dans le
  [programme MP2I–MPI](https://prepas.org/index.php?document=73).
  Respecter `lib/programme.typ` et `docs/programme.md` ; toute extension exige
  une référence de section et de page. Ne pas inventer d’étiquette pour une tâche.
- Pour les chapitres, utiliser `langages-reguliers`, jamais `expressions-regulieres`.
  Classer aussi les exercices de combinatoire des mots dans `langages-reguliers`
  et l’induction structurelle dans `recursivite-et-induction`.
- Ne retenir que les méthodes et structures effectivement utilisées ; `()` est
  valide. Mettre les notions de langages dans `chapitres`.

## Présentation

- Réutiliser la mise en page commune inspirée de `texmf/tex/latex`.
- Aucun sous-titre. Le titre figure uniquement sur la première page.
- Le corrigé ajoute exactement « : corrigé » au titre, par exemple
  « Langages réguliers : corrigé » ; ne pas ajouter le suffixe dans les sources.
- Titres des exercices en gras ; corps, numéros des questions et solutions sans gras.
- Chaque solution commence par « Solution. » souligné.
- Conserver les textes intermédiaires à leur place et la pagination en pied de page.

## Compilation et vérification

- Lancer `nix develop path:. -c make check` ; compiler énoncés, corrigés et modèles.
  Le catalogue valide les métadonnées et l’unicité des identifiants.
- Inspecter les PDF après un changement de présentation : première page et pages
  suivantes, formules, code, débordements et titres isolés. Pour une correction de
  code, vérifier des cas limites pertinents, pas seulement la compilation Typst.
- `make watch EXO=<chemin>` et `make watch-feuille FEUILLE=<nom>` compilent puis
  ouvrent le PDF dans VS Code. Sur macOS utiliser `open -a "Visual Studio Code"`,
  sans script Python ; `OPEN=0` désactive l’ouverture, `OPEN_PDF` la personnalise.
- Vérifier les surveillances existantes avant d’en lancer une ; ne pas arrêter
  un processus de l’utilisateur. Ne pas modifier le catalogue généré à la main.
- Communiquer les fichiers concernés, les corrections et les vérifications réelles.

## Commits

- Pour chaque nouvel exercice, créer un commit dédié après les vérifications,
  sans demander de confirmation supplémentaire. Inclure l’exercice, sa note
  éventuelle et les modifications directement nécessaires à son intégration.
- Ne pas inclure les modifications de l’utilisateur sans rapport avec l’exercice.
- Indiquer dans la réponse finale le commit créé et les vérifications effectuées.
