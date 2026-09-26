#import "/lib/sujets.typ": sujet-concours
#import "/ressources/centrale-2022-mp-informatique/commun.typ": code, automate-a1
#import "/ressources/centrale-2022-mp-informatique/partie-i.typ": partie-i
#import "/ressources/centrale-2022-mp-informatique/partie-ii.typ": partie-ii
#import "/ressources/centrale-2022-mp-informatique/partie-iii.typ": partie-iii

// Source : épreuve Centrale-Supélec 2022, MP, option informatique, 9 pages.
// Le PDF fourni porte la mention CC BY-NC-SA.
#let sujet = sujet-concours(
  meta: (
    titre: "Option informatique",
    chapitres: ("langages-reguliers", "automates-finis", "recursivite-et-induction", "algorithmique"),
    algorithmes: ("determinisation", "diviser-pour-regner"),
    structures: ("liste", "tableau", "arbre"),
    langages: ("OCaml",), difficulte: 4,
    niveaux: ("MP", "MPI"), duree: 240,
    concours: (nom: "Centrale", annee: 2022, filiere: "MP"),
  ),
  preambule: [

    Ce sujet aborde différents problèmes autour des automates et des expressions
    régulières. On explore dans une première partie des propriétés sur le miroir
    d'un langage, sur les palindromes et sur les automates correspondants.
    On implémente ensuite l'algorithme de déterminisation d'un automate, afin de
    construire de manière effective l'automate de Brzozowski qui a la propriété
    d'être minimal. Dans une deuxième partie, on travaille sur la syntaxe des
    expressions régulières, puis sur une construction de l'expression régulière
    associée à un automate donné, par un algorithme diviser pour régner, dû à
    Conway, en exploitant une représentation matricielle d'un automate et la
    construction de l'étoile d'une matrice d'expressions régulières. Enfin, dans
    une troisième partie, on introduit les dérivées d'Antimirov, qui permettent
    d'obtenir un automate fini non déterministe avec peu d'états qui reconnaît
    le langage spécifié par une expression régulière. Les trois parties sont
    indépendantes, de difficulté progressive.

    #heading(level: 2)[Langages et mots]
    On appelle alphabet tout ensemble fini de lettres. On note généralement
    l'alphabet $Σ$. On note $Σ^*$ l'ensemble de tous les mots formés sur $Σ$.
    La longueur (ou la taille) d'un mot $w ∈ Σ^*$ est son nombre de lettres et
    se note $abs(w)$. Le mot vide, noté $ε$, est le seul mot de longueur nulle.
    Si $abs(w)=n$, on note $w=a_0 a_1 … a_(n-1)$, où les $a_i$ sont des lettres
    de $Σ$. Un langage sur l'alphabet $Σ$ est un ensemble $L ⊆ Σ^*$.
    L'étoile de Kleene d'un langage $L$, notée $L^*$, est le plus petit langage
    qui inclut $L$, qui contient $ε$ et qui est stable par concaténation.
    La concaténation de deux langages $L$ et $L'$ est notée $L dot L'$, souvent
    abrégée en $L L'$ lorsqu'il n'y a pas d'ambiguïté.

    #heading(level: 2)[Automates finis]
    Un automate fini non déterministe sur $Σ$ est un quadruplet $A=(Q,I,F,T)$,
    où $Q$ est un ensemble fini d'états, $I ⊆ Q$ l'ensemble des états initiaux,
    $F ⊆ Q$ l'ensemble des états finaux et $T ⊆ Q × Σ × Q$ l'ensemble des
    transitions. Si $(q,a,q') ∈ T$, on note cette transition $q limits(→)^a q'$.
    Dans la figure 1, une flèche entrante désigne un état initial et un double
    cercle un état final.

    Un mot $w=a_0 … a_(n-1)$ est reconnu par $A$ s'il existe une succession
    de transitions
    $ q_0 limits(→)^(a_0) q_1 limits(→)^(a_1) … q_(n-1) limits(→)^(a_(n-1)) q_n,
      quad q_0 ∈ I, quad q_n ∈ F. $
    On dit que $w$ étiquette un chemin de $q_0$ à $q_n$. Le langage de
    l'automate, noté $L_A$, est l'ensemble des mots reconnus par $A$.
    Un langage est reconnaissable s'il est le langage d'un automate fini.

    Un automate déterministe est un quadruplet $A=(Q,{q_0},F,δ)$ avec un
    unique état initial et une fonction de transition $δ$ définie sur une
    partie de $Q × Σ$, à valeurs dans $Q$. Pour chaque $(q,a)$, il existe au
    plus une transition $(q,a,q')$ ; si elle existe, $q'=δ(q,a)$.
    L'automate est complet si $δ$ est définie sur $Q × Σ$. On définit alors
    sa fonction de transition étendue par
    $ δ^*(q,ε)=q, quad δ^*(q,w a)=δ(δ^*(q,w),a)
      quad (q ∈ Q, w ∈ Σ^*, a ∈ Σ). $

    Les automates sont représentés par le type OCaml suivant ; l'ensemble
    d'états est toujours l'intervalle d'entiers $⟦0,n-1⟧$ :
    #code("automate")
    #automate-a1()
    #align(center)[Figure 1 — L'automate $cal(A)_1$.]
    Par exemple, l'automate de la figure 1 est codé par :
    #code("a1")
    On accède au nombre d'états par ```ocaml a1.nb```, aux états initiaux par
    ```ocaml a1.init```, aux états finaux par ```ocaml a1.final``` et aux
    transitions par ```ocaml a1.trans```.

    #heading(level: 2)[Expressions régulières]
    Sur un alphabet $Σ$, $∅$, $ε$ et toute lettre $a ∈ Σ$ sont des expressions
    régulières. Si $E,F$ sont des expressions régulières, alors $(E | F)$,
    $(E dot F)$ et $E^*$ en sont aussi. L'application $cal(L)$ associe à
    une expression le langage qu'elle représente :
    $ cal(L)(∅)=∅, quad cal(L)(ε)={ε}, quad cal(L)(a)={a}, $
    $ cal(L)(E | F)=cal(L)(E) ∪ cal(L)(F), quad
      cal(L)(E dot F)=cal(L)(E) cal(L)(F), quad
      cal(L)(E^*)=cal(L)(E)^*. $

    #heading(level: 2)[Programmation]
    Le seul langage de programmation autorisé est OCaml. Toutes les fonctions
    des modules ```ocaml Array``` et ```ocaml List```, ainsi que les fonctions
    de la bibliothèque standard (comme ```ocaml max``` et ```ocaml incr```)
    et les opérateurs comme ```ocaml /``` ou ```ocaml mod``` peuvent être utilisés.
    Les objets mathématiques notés $A,m,i,n,ℓ$ sont représentés en OCaml par
    ```ocaml a```, ```ocaml m```, ```ocaml i```, ```ocaml n```, ```ocaml l```.
    Les complexités demandées sont temporelles dans le pire des cas et sont
    exprimées sous la forme $O(f(n,m))$, où $f$ est une fonction usuelle simple
    des tailles des objets en entrée.
  ],
  contenu: (partie-i, partie-ii, partie-iii),
)
