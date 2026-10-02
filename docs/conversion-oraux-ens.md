# Conversion des oraux ENS sur les automates

## Organisation et sources

Les huit sujets ENS ont chacun un fichier dans `concours/<année>/` et un import
sans duplication dans `exercices/langages/`. L'exercice sur les morphismes reste
dans la banque, sans attribution non attestée. Tous exportent `ex` et utilisent
`templates/fiche.typ`. Les contextes sont conservés dans les corrigés des oraux.
La feuille [Automates : oraux ENS et morphismes](../feuilles/automates-ens-morphismes.typ)
les rassemble dans l'ordre demandé.

La banque a été comparée aux sources : les exercices existants sur les palindromes,
les mots qui commutent, les résiduels et la clôture par sur-mots ne sont pas ces sujets.
Le fichier `morphisme.tex` reprend plusieurs idées du sujet Mines-Ponts 2019, déjà
converti, mais constitue un exercice différent (trois figures, douze questions,
aucun programme demandé). Ses figures et son ordre sont conservés.

Aucun de ces fichiers LaTeX ne contient de `\input` ou de `\include` à résoudre.
Les corrigés séparés et les solutions sous `\if\cor1` ont été lus. La question
commentée de `morphisme.tex` n'a pas été reprise. Les originaux n'ont pas été modifiés.

Référence de cours consultée :
`/Users/qfortier/repo/cours-src/langage/automate/resume/poly_automate.tex`.
Les constructions utilisent le programme recensé dans [programme.md](programme.md).
Les monoïdes et automates à pile sont définis dans les sujets ; aucune connaissance
préalable de leur théorie n'est exigée.

Les années et la numérotation ont été confrontées aux
[annales officielles ENS](https://diplome.di.ens.fr/informatique-ens/annales.html).
Les questions supplémentaires conservées proviennent des sources locales et des
versions complètes des sujets. Toutes les questions commencent à 1 dans la banque ;
les renvois des sources commençant à 0 sont décalés d'une unité.
Les sous-questions restent groupées.

| Sujet | Source locale sous `exos-src/exos/automata/` | Identification officielle | Questions |
| --- | --- | --- | --- |
| Automates et palindromes | `automate_palindrome/*.tex`, `concours/ens/automates_palindromes{,_cor}.pdf` | 2018, A4, rapport p. 8 | 1–7 |
| Automates à pile | `automate_pile/automate_pile.tex` et `.yml` | 2017, A8, rapport p. 11 ; version complète p. 36–40 | 1–7 |
| Automates et monoïdes | `automates_monoïdes/*.{tex,yml}` | 2022, C1, rapport p. 13–14 ; version complète p. 25–28 | 1–7 |
| Automates et ordres partiels | `automates_ordres_partiels/*.{tex,yml}` | 2022, C2, rapport p. 15–16 ; version complète p. 29–32 | 1–5 |
| Clôture commutative | `cloture_commutative_langage/cloture_commutative_langage.pdf` (corrigé inclus), `.yml` | 2017, A6, rapport p. 9 ; version complète p. 26–30 | 1–8 |
| Langages continuables et mots primitifs | `concours/ens/continuable_primitif{,_cor}.pdf` | 2018, A7, rapport p. 11 | 1–7, dont 7 a–c |
| Évaluation accélérée | `evaluation_acceleree/*.{tex,yml}` | 2018, A1, rapport p. 5 | 1–8 |
| Réparation de mots | `reparation_langage/*.tex` | 2018, A5, rapport p. 9 | 1–10 |
| Morphismes | `morphisme/morphisme.tex` | Aucune attribution ajoutée | 1–12 |

Les versions complètes sont accessibles pour
[2017](https://diplome.di.ens.fr/informatique-ens/annales/2017_InfoU-exercices.pdf),
[2018](https://diplome.di.ens.fr/informatique-ens/annales/2018_InfoU-exercices.pdf) et
[2022](https://diplome.di.ens.fr/informatique-ens/annales/2022_InfoU-exercices.pdf).
Le corrigé complet 2017 fournit notamment la solution absente du dossier local des piles.
Les rapports confirment une épreuve d'une heure, sans préparation, pour ces sessions.

## Remarques du jury

Les rapports ont d'abord été cherchés dans les sources voisines, puis obtenus sur
le site officiel. Les commentaires intégrés sont courts et pertinents pour les
questions concernées. Ils sont distincts des corrections éditoriales.

| Rapport | Pages | Emploi |
| --- | --- | --- |
| [ENS Ulm MP 2017](https://diplome.di.ens.fr/informatique-ens/annales/2017_InfoU-rapport.pdf) | 3 | Remarque générale sur le dialogue avec le jury, reformulée ; citation exacte sur le non-déterminisme en question 1 des piles. |
| [ENS Ulm MP 2018](https://diplome.di.ens.fr/informatique-ens/annales/2018_InfoU-rapport.pdf) | 3 | Remarque générale reformulée ; synthèse des recommandations sur les parcours en question 5 des palindromes et sur la programmation dynamique en question 8 des réparations. |
| [ENS Ulm MP 2022](https://diplome.di.ens.fr/informatique-ens/annales/2022_InfoU-rapport.pdf) | 2 | Remarque générale reformulée ; synthèse sur la construction du produit en question 2 des ordres partiels. |

Aucun commentaire de jury n'a été attribué à l'exercice sur les morphismes.
Les remarques sur les anciens programmes n'ont pas été transposées en exigences actuelles.

## Corrections importantes

Les listes au début de chaque corrigé donnent les questions concernées.

- **Palindromes** : numérotation à partir de 1 ; preuve de l'unicité des chemins
  acceptants dans le produit, qui peut rester non déterministe ; coût binaire du comptage.
- **Piles** : ensembles de transitions finis pour définir leur taille maximale ;
  preuve du pompage corrigée. Le sommet de départ d'une montagne peut être remplacé
  par la première transition. Le choix de deux montagnes est donc renforcé en
  imposant aussi un même sommet de sortie. Les hauteurs sont choisies par minima
  successifs à rebours, car une montée peut sauter certaines hauteurs.
- **Monoïdes** : définition des morphismes, sens du produit des transformations,
  types des relations, dépendance en la taille de l'alphabet et borne
  `sqrt(log_2 n)` pour le nombre d'états.
- **Ordres partiels** : automates incomplets autorisés pour les langages finis ;
  indices distincts et ordonnés dans Higman ; conclusion sur le complémentaire complétée.
- **Clôture commutative** : exemple de la question 2, échange incorrect de `a` et `b`
  dans la preuve de la question 4, composantes fortement connexes, stabilisation
  bidimensionnelle explicitée.
- **Langages continuables** : longueur du bloc et exposant distingués ; parcours
  depuis l'initial et parcours inverse depuis les finaux ; cas de l'automate à un état.
- **Évaluation accélérée** : décomposition dyadique corrigée par le parcours de
  l'arbre ; mises à jour comptées en fonction du nombre d'états ; arbres bicolores
  proposés pour le rééquilibrage, sans exiger leur mise en œuvre détaillée.
- **Réparation** : `uv` doit appartenir à `L` après suppression ; récurrences,
  orientation des transitions, distances, complexités et témoins corrigés.
- **Morphismes** : accessibilité de `A` ajoutée après la question 3 pour valider
  l'algorithme de parcours et la construction des morphismes vers le quotient ;
  réciproque, preuves et complexités complétées.

Les notations et les arguments des sources sont conservés, avec les conventions
locales : « régulier », symboles Unicode, apostrophe ASCII, et graphes `G = (S, A)`
lorsqu'une notation de graphe est nécessaire. Les figures sont produites avec
CeTZ 0.4.2 et finite 0.5.1, directement dans les sujets concernés.
Les algorithmes demandés restent décrits en français ou en pseudocode.

La bibliothèque commune utilise désormais le libellé imposé
« Modifications par rapport à l'énoncé initial : » uniquement pour les sujets attribués
à un concours, et affiche les remarques générales
en italique sous forme de liste, sans titre supplémentaire.

## Vérification et documents

Commande : `nix develop path:. -c make check`.
Elle compile énoncés, corrigés, feuilles et modèles, valide les métadonnées et
l'unicité des identifiants, et exécute les tests existants.
Dix cas supplémentaires comparent les récurrences des réparations à une recherche
exhaustive des suppressions et à un plus court chemin indépendant sur les couples
(position dans le mot, état). Ils couvrent les mots vides, les langages vides,
les automates non déterministes, les boucles et les deux variantes d'édition.
Ces tests sont dans `ressources/ens-2018-mp-reparation-langage/test.py`.

Le recueil compte 6 pages d'énoncés et 18 pages de corrigés, d'après le compteur
de pages de Typst. Conformément aux consignes, les PDF générés ne sont pas inspectés.

- Recueil : [énoncés](../build/feuilles/automates-ens-morphismes.pdf), [corrigés](../build/feuilles/automates-ens-morphismes-corrige.pdf).

| Exercice autonome | Énoncé | Corrigé |
| --- | --- | --- |
| [Automates et palindromes](../exercices/langages/automates-palindromes.typ) | [PDF](../build/exercices/langages/automates-palindromes/enonce.pdf) | [PDF](../build/exercices/langages/automates-palindromes/corrige.pdf) |
| [Automates à pile](../exercices/langages/automates-pile-pompage.typ) | [PDF](../build/exercices/langages/automates-pile-pompage/enonce.pdf) | [PDF](../build/exercices/langages/automates-pile-pompage/corrige.pdf) |
| [Monoïdes](../exercices/langages/automates-monoides.typ) | [PDF](../build/exercices/langages/automates-monoides/enonce.pdf) | [PDF](../build/exercices/langages/automates-monoides/corrige.pdf) |
| [Ordres partiels](../exercices/langages/automates-ordres-partiels.typ) | [PDF](../build/exercices/langages/automates-ordres-partiels/enonce.pdf) | [PDF](../build/exercices/langages/automates-ordres-partiels/corrige.pdf) |
| [Clôture commutative](../exercices/langages/cloture-commutative-langage.typ) | [PDF](../build/exercices/langages/cloture-commutative-langage/enonce.pdf) | [PDF](../build/exercices/langages/cloture-commutative-langage/corrige.pdf) |
| [Langages continuables et primitifs](../exercices/langages/langages-continuables-primitifs.typ) | [PDF](../build/exercices/langages/langages-continuables-primitifs/enonce.pdf) | [PDF](../build/exercices/langages/langages-continuables-primitifs/corrige.pdf) |
| [Évaluation accélérée](../exercices/langages/evaluation-acceleree-automates.typ) | [PDF](../build/exercices/langages/evaluation-acceleree-automates/enonce.pdf) | [PDF](../build/exercices/langages/evaluation-acceleree-automates/corrige.pdf) |
| [Réparation](../exercices/langages/reparation-langage.typ) | [PDF](../build/exercices/langages/reparation-langage/enonce.pdf) | [PDF](../build/exercices/langages/reparation-langage/corrige.pdf) |
| [Morphismes](../exercices/langages/morphismes-automates.typ) | [PDF](../build/exercices/langages/morphismes-automates/enonce.pdf) | [PDF](../build/exercices/langages/morphismes-automates/corrige.pdf) |
