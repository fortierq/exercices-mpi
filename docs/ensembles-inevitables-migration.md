# Conversion : ensembles inévitables

Sources locales :

- `exos-src/exos/language/ensembles_inevitables/ensembles_inevitables.tex` ;
- `exos-src/exos/language/ensembles_inevitables/ensembles_inevitables_cor.tex` ;
- `exos-src/exos/language/ensembles_inevitables/ensembles_inevitables.yml`.

Les douze questions, numérotées de 0 à 11, et leur corrigé ont été convertis.
L’attribution « ENS Ulm, oral MP, 2019 » est reprise du YAML, sans vérification
indépendante. Son titre « Preuve de programmes en logique de Hoare » et son
étiquette `proof`, manifestement sans rapport, ont été remplacés. La difficulté
4/5 est une estimation ajoutée lors de cette conversion.

Modifications éditoriales et mathématiques :

- Les définitions de facteur et d’évitement précèdent les questions ; celle
  d’inévitabilité est placée entre les questions 1 et 2. Un facteur est défini
  formellement : `s` est facteur de `w` si `w = usv` pour deux mots `u, v`.
  Le mot vide est explicitement
  facteur de tout mot ; ce cas est traité dans les algorithmes et les preuves.
- Q1 : le pseudocode, fourni seulement sous forme d’image dans le corrigé LaTeX,
  est réécrit en texte éditable. Les bornes d’indices, le court-circuit, l’ensemble
  vide et les motifs plus longs que le texte sont précisés. Aucune sous-chaîne
  n’est copiée, ce qui justifie l’espace auxiliaire constant.
- Q3 : « suffisamment long » devient une preuve explicite pour la longueur 7 ;
  `aabbaa` montre que la borne est optimale.
- Q4 : le lemme est formulé avec `k ≥ 1` et un alphabet non vide, les seuls cas
  utiles à Q5. La borne suffisante `r^k + k` et les indices sont explicites.
  Le cas `k = 0` de l’original correspond à deux occurrences du mot vide et ne
  nécessite pas le principe des tiroirs.
- Q5 : le test porte sur les mots de longueur **exactement** `N = r^k + k`.
  L’original conclut sur les longueurs `> n` puis propose d’énumérer les mots
  de longueur `≤ n`, ce qui ne constitue pas le test annoncé. La borne de temps
  omettait surtout le nombre de mots énumérés : elle devient `O(r^N N L)`, avec
  `L = somme des longueurs des motifs`. Pour un alphabet fixé d’au moins deux
  lettres, elle est doublement exponentielle en `k`. La preuve par graphe règle
  aussi le cas des occurrences qui se chevauchent. Le coût du test des sommets
  est distingué de celui du parcours de graphe.
- Q6 : l’étoile ajoutée dans la réponse originale rend l’exemple trivial en y
  incluant le mot vide. L’exemple utilise désormais directement l’union des
  quatre mots de Q3 ; la question demande un langage sans mot vide.
- Q7–Q8 : l’énumération d’un langage fini est explicitée. Avant complémentation,
  l’automate doit être **déterministe et complet**. Le test de cycle porte sur
  les états accessibles et coaccessibles d’un automate sans transitions epsilon.
- Q9 : l’original définit « inévitable pour e » par l’existence d’une **infinité**
  de mots de `L(e)` qui évitent `S`, à l’inverse de la convention des questions
  précédentes. La version adaptée retient une intersection **finie** pour
  « inévitable relativement à e » et demande également de décider la propriété
  opposée. La solution explique les deux résultats possibles. Il s’agit d’un
  changement explicite de définition, pas d’une transcription littérale.
- Q10–Q11 : le cas où aucun mot n’évite l’ensemble est traité séparément via
  le mot vide. La longueur maximale se calcule par plus long chemin dans un
  graphe acyclique ; il n’est pas nécessaire d’énumérer d’abord tous les mots
  acceptés. Le sous-ensemble fini produit n’est pas annoncé comme minimal.

Aucune dépendance aux macros LaTeX `base`/`draw` ni à l’image externe du
pseudocode n’est conservée. Les originaux sont laissés intacts.
