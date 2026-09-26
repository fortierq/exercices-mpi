#import "/lib/exercices.typ": question
#import "/lib/sujets.typ": partie
#import "commun.typ": code, automate-a1

#let partie-i = partie("I", "Mots et automates", contenu: (
  partie("I.A", "Miroir d'un mot et automate transposé", contenu: (
    [Pour tout mot $w=a_0 a_1 … a_(n-1)$ de longueur $n ∈ NN^*$, son miroir est
      $tilde(w)=a_(n-1) … a_1 a_0$. Le mot vide $ε$ est son propre miroir.
      Pour tout langage $L ⊆ Σ^*$, on pose $tilde(L)={tilde(w) | w ∈ L}$.],
    question([Décrire le langage $L_1$ de l'automate $cal(A)_1$ de la figure 1
      et décrire son langage miroir $tilde(L)_1$.], solution: [
      Les chemins acceptants bouclent d'abord sur $0$, lisent $a b$ pour
      atteindre $2$, puis lisent uniquement des $a$. Ainsi
      $ L_1=(a+b)^* a b a^*, quad tilde(L)_1=a^* b a (a+b)^*. $
    ]),
    question([Dessiner un automate $tilde(cal(A))_1$ reconnaissant $tilde(L)_1$.],
      solution: [On inverse toutes les transitions et on échange états initiaux et finaux.
        #automate-a1(miroir: true)
      ]),
    [Soit $A=(Q,I,F,T)$ un automate non déterministe et $L=L_A$ son langage.],
    question([Donner, en justifiant, la construction de l'automate miroir
      $tilde(A)=(Q,I',F',T')$ reconnaissant $tilde(L)$.], solution: [
      On prend $I'=F$, $F'=I$ et $T'={(q',c,q) | (q,c,q') ∈ T}$.
      Un chemin de $i ∈ I$ à $f ∈ F$ étiqueté $w$ devient un chemin de $f$ à
      $i$ étiqueté $tilde(w)$, et réciproquement. Cela inclut $ε$ : il est
      accepté dans les deux automates exactement lorsque $I ∩ F ≠ ∅$.
    ]),
    question([Écrire une fonction ```ocaml transpose``` de signature
      ```ocaml automate -> automate``` qui renvoie un automate reconnaissant
      le miroir du langage de l'automate d'entrée.], solution: [#code("Q4")]),
    question([Quelle est la complexité de cette fonction ?], solution: [
      Chaque transition est parcourue une fois. Le coût est $O(1+abs(T))$
      en temps et en espace supplémentaire ; les listes d'états sont partagées.
    ]),
  )),
  partie("I.B", "Palindromes et régularité",
    contexte: ([Sur un alphabet fini $Σ$, on note $tilde(w)$ le miroir du mot
      $w$, obtenu en inversant l'ordre de ses lettres ; $tilde(ε)=ε$.],),
    meta: (
      chapitres: ("langages-reguliers", "automates-finis"),
      algorithmes: (), structures: (), langages: ("OCaml",), difficulte: 3,
    ),
    contenu: (
      [Soit $w ∈ Σ^*$. Le mot $w$ est un palindrome si $tilde(w)=w$.],
      question([Écrire une fonction ```ocaml palindrome``` de signature
        ```ocaml string -> bool``` qui teste, en temps linéaire, si un mot est
        un palindrome.], solution: [
        #code("Q6")
        On compare les lettres symétriques jusqu'au milieu du mot.
        L'appel d'indice $i$ vérifie les paires restantes ; $floor(n/2)-i$ décroît
        tant qu'un appel récursif est effectué. Le mot vide est accepté.
        Au plus $floor(n/2)$ comparaisons donnent un coût $O(n+1)$, linéaire
        dans le pire cas. L'appel récursif est terminal, donc l'espace
        auxiliaire est constant.
      ]),
      [On rappelle que pour $0 ≤ i < $```ocaml String.length s```, le $i$-ième
        caractère de la chaîne ```ocaml s``` est obtenu par ```ocaml s.[i]```.
        Pour un alphabet $Σ$, on note $"Pal"(Σ)$ l'ensemble des palindromes de $Σ^*$.],
      question([Montrer que si $Σ$ est un alphabet à une lettre, alors
        $"Pal"(Σ)$ est régulier.], solution: [
        Si $Σ={a}$, tout mot est de la forme $a^n$ et est un palindrome.
        Ainsi $"Pal"(Σ)=a^*$.
      ]),
      question([Montrer que si $Σ$ contient au moins deux lettres, alors
        $"Pal"(Σ)$ n'est pas régulier. On pourra utiliser un automate et un
        mot de $"Pal"(Σ) ∩ a^* b a^*$.], solution: [
        Choisissons deux lettres distinctes $a,b ∈ Σ$. Si $"Pal"(Σ)$ était
        régulier, son intersection $K$ avec $a^* b a^*$ le serait aussi.
        Or $K={a^n b a^n | n ∈ NN}$. Supposons qu'un automate déterministe
        à $p$ états reconnaisse $K$. Sur le chemin étiqueté $a^p b a^p$,
        deux des $p+1$ états atteints après $ε,a,…,a^p$ sont égaux.
        Il existe donc $0 ≤ i < j ≤ p$ tels que l'on puisse répéter le
        segment de $j-i$ lettres $a$. L'automate accepte alors
        $a^(p+j-i) b a^p$, qui n'appartient pas à $K$ : contradiction.
      ]),
      [Soit $L ⊆ Σ^*$ un langage reconnu par $A=(Q,I,F,T)$. Pour
        $(q,q') ∈ Q^2$, on note $L_(q,q')$ le langage des mots étiquetant
        un chemin de $q$ à $q'$ dans $A$.],
      question([Montrer que $L_(q,q')$ est reconnaissable et exprimer
        $L_A$ en fonction des langages $L_(q,q')$.], solution: [
        L'automate $(Q,{q},{q'},T)$ reconnaît $L_(q,q')$.
        Un chemin est acceptant s'il part d'un état initial et arrive à un
        état final, d'où
        $ L_A=union_(i ∈ I) union_(f ∈ F) L_(i,f). $
      ]),
      question([Montrer que $"Pal"(Σ) ∩ (Σ^2)^*={u tilde(u) | u ∈ Σ^*}$.],
        solution: [
          Le langage $(Σ^2)^*$ contient exactement les mots de longueur paire.
          Tout $u tilde(u)$ est un palindrome de longueur $2 abs(u)$.
          Réciproquement, si un palindrome a longueur $2n$, sa seconde moitié
          est le miroir de sa première moitié $u$. Il vaut donc $u tilde(u)$.
          L'égalité reste vraie pour $u=ε$.
        ]),
      [Soit $L$ un langage régulier reconnu par $A=(Q,I,F,T)$. On définit
        $D(L)={w tilde(w) | w ∈ L}$ et $R(L)={w ∈ Σ^* | w tilde(w) ∈ L}$.],
      question([Décrire simplement $D(a^* b)$ et $R(a^* b^* a^*)$.], solution: [
        On a
        $ D(a^* b)={a^n b b a^n | n ∈ NN}, quad R(a^* b^* a^*)=a^* b^*. $
        Pour la seconde égalité, si $w tilde(w) ∈ a^* b^* a^*$,
        son préfixe $w$ appartient à ce même langage et n'utilise que $a,b$.
        Un tel mot $w$ comportant un $b$ puis un $a$ fait apparaître
        un facteur $b a^+ b$ dans $w tilde(w)$, impossible dans
        $a^* b^* a^*$. Ainsi $w ∈ a^* b^*$ ; réciproquement
        $w=a^i b^j$ donne $w tilde(w)=a^i b^(2j) a^i$.
      ]),
      question([Les langages $D(L)$ et $R(L)$ sont-ils reconnaissables ?
        On pourra faire intervenir les langages $L_(q,q')$ définis ci-dessus.],
        solution: [
          $D(L)$ ne l'est pas toujours : pour $L=a^* b$, le langage
          ${a^n b b a^n | n ∈ NN}$ ne peut être reconnu par un automate fini.
          Le même argument de répétition d'une boucle dans le premier bloc
          de $a$ que pour les palindromes donne une contradiction.

          En revanche, $R(L)$ est toujours reconnaissable. Un chemin
          acceptant étiqueté $w tilde(w)$ passe, après $w$, par un état
          $q ∈ Q$. On a donc
          $ R(L)=union_(i ∈ I) union_(q ∈ Q) union_(f ∈ F)
            (L_(i,q) ∩ tilde(L_(q,f))). $
          Chaque langage de chemins est reconnaissable. Le miroir est
          reconnaissable en inversant les transitions et en échangeant
          états initiaux et finaux. Les stabilités par intersection et
          union finies concluent.
        ]),
    ),
  ),
  partie("I.C", "Déterminisation", contenu: (
    [Pour tout automate non déterministe $A=(Q,I,F,T)$, on définit le
      déterminisé accessible $A_"det"=(Y,{I},F',δ)$, où $Y ⊆ cal(P)(Q)$ est
      l'ensemble des états accessibles depuis l'état initial $I$ dans
      l'automate des parties. Il reconnaît le même langage que $A$.],
    question([Écrire un automate $cal(A)_2$ non déterministe à quatre états
      reconnaissant $L_2=(b+a b)^* b a$, avec un unique état initial et un
      unique état final.], solution: [
      #code("Q13")
      Depuis $0$, on peut lire les blocs $b$ ou $a b$ pour revenir à $0$.
      On termine par le chemin $0$ vers $2$ vers $3$, étiqueté $b a$.
    ]),
    question([Déterminiser l'automate miroir $tilde(cal(A))_2$ pour obtenir
      $cal(A)_3=(tilde(cal(A))_2)_"det"$. Renommer ses états $e_0,e_1,…$.],
      solution: [
        La table suivante donne tous les états accessibles et toutes les transitions.
        $e_0$ est initial ; $e_3,e_4$ sont finaux.
        #align(center, table(columns: 4, inset: 5pt,
          [État], [Partie de $Q_2$], [$a$], [$b$],
          [$e_0$], [${3}$], [$e_1$], [$e_2$],
          [$e_1$], [${2}$], [$e_2$], [$e_3$],
          [$e_2$], [$∅$], [$e_2$], [$e_2$],
          [$e_3$], [${0}$], [$e_2$], [$e_4$],
          [$e_4$], [${0,1}$], [$e_3$], [$e_4$],
        ))
      ]),
    question([Déterminiser l'automate miroir $tilde(cal(A))_3$ pour obtenir
      $cal(A)_4=(tilde(cal(A))_3)_"det"$. Renommer ses états $q_0,q_1,…$.],
      solution: [
        L'état initial est $q_0$ ; le seul état final est $q_4$.
        #align(center, table(columns: 4, inset: 5pt,
          [État], [Partie de $Q_3$], [$a$], [$b$],
          [$q_0$], [${e_3,e_4}$], [$q_1$], [$q_2$],
          [$q_1$], [${e_4}$], [$q_3$], [$q_0$],
          [$q_2$], [${e_1,e_3,e_4}$], [$q_4$], [$q_2$],
          [$q_3$], [$∅$], [$q_3$], [$q_3$],
          [$q_4$], [${e_0,e_4}$], [$q_3$], [$q_0$],
        ))
      ]),
    question([Quel doit être le langage reconnu par $cal(A)_4$ ?], solution: [
      Chaque déterminisation préserve le langage, et les deux transpositions
      prennent deux fois le miroir. Le langage est donc $L_2=(b+a b)^* b a$.
    ]),
    [On souhaite implémenter cette construction. Une représentation naïve des
      parties de $Q$ utilise des listes d'états. Lors des réunions, la
      concaténation de listes crée des doublons qu'il faut supprimer.],
    question([Écrire ```ocaml supprimer : 'a list -> 'a list``` qui supprime
      toutes les occurrences multiples des éléments d'une liste.], solution: [
      #code("Q17")
      On conserve la dernière occurrence de chaque élément. L'induction sur
      la liste montre que le résultat a les mêmes éléments et aucun doublon.
      Comme avec ```ocaml List.mem```, l'égalité doit être définie pour les
      éléments considérés ; ici ce sont des entiers.
    ]),
    question([Donner la complexité en fonction de la taille de la liste.],
      solution: [
        Pour une liste de longueur $m$, les recherches parcourent au plus
        $(m-1)+…+1=m(m-1)/2$ éléments. Le coût est $O(m^2)$ et cette borne
        est atteinte quand les éléments sont distincts, en comptant une
        comparaison en temps constant.
      ]),
    [On code désormais les ensembles d'états par des entiers. Pour
      $Q=⟦0,n-1⟧$, avec $n ≤ 20$, toute partie est représentée par un entier
      entre $0$ et $2^n-1$. On pose $"numero"(X)=sum_(i ∈ X) 2^i$.
      Le tableau ```ocaml pow``` contient $2^k$ pour $0 ≤ k ≤ 20$.
      #code("pow")
      Soient $q ∈ ⟦0,n-1⟧$ et $k="numero"(X) ∈ ⟦0,2^n-1⟧$.],
    question([Écrire ```ocaml est_dans : int -> int -> bool``` qui teste,
      à l'aide d'opérations arithmétiques, si $q ∈ X$ en $O(1)$ opérations.],
      solution: [#code("Q19") Le quotient par $2^q$, modulo $2$, est le bit d'indice $q$.]),
    [Soit $ℓ$ une liste d'états pouvant contenir des doublons, représentant $X$.],
    question([Écrire ```ocaml numero : int list -> int``` qui calcule le numéro
      de $X$. Par exemple, ```ocaml [1; 5; 2; 5; 2; 5; 2; 2; 1; 2; 1]```
      représente ${1,2,5}$, de numéro $38=2^1+2^2+2^5$.], solution: [
      #code("Q20")
      On ajoute $2^q$ seulement si le bit correspondant n'est pas déjà présent.
      Le coût est linéaire dans la longueur de la liste.
    ]),
    [Soit $ℓ$ une liste d'états et $X$ un ensemble représenté par $k$.],
    question([Écrire ```ocaml intersecte : int list -> int -> bool``` qui
      vérifie si un élément de $ℓ$ appartient à $X$.], solution: [#code("Q21")]),
    [On suppose désormais $Σ={a,b}$. Pour $X ⊆ Q$ et $c ∈ Σ$, la transition
      du déterminisé est
      $ δ(X,c)=union_(q ∈ X) {q' ∈ Q | (q,c,q') ∈ T}. $
      En parcourant $T$, on calcule simultanément $δ(X,a)$ et $δ(X,b)$.],
    question([Écrire ```ocaml etat_suivant : int -> (int * char * int) list -> int * int```
      qui, à partir de $k="numero"(X)$ et de $T$, renvoie
      $(k_a,k_b)=("numero"(δ(X,a)),"numero"(δ(X,b)))$.], solution: [
      #code("Q22")
      Chaque transition issue de $X$ ajoute son arrivée à l'accumulateur de
      sa lettre. Les doublons ne changent pas le résultat. Coût : $O(1+abs(T))$.
    ]),
    [Pour obtenir un ensemble d'états $Y=⟦0,N-1⟧$, on renumérote les parties
      accessibles avec une liste de couples $(k,v)$ : $k$ code une partie,
      $v$ est son nouveau numéro. Par exemple, $(6,2)$ renumérote la partie
      ${1,2}$, de code $6$, en l'état $2$.],
    question([Écrire ```ocaml cherche : int -> (int * int) list -> int``` qui
      renvoie le nouveau numéro associé à $k$, ou $-1$ si $k$ est absent.],
      solution: [#code("Q23")]),
    question([Écrire ```ocaml determinise : automate -> automate``` qui calcule
      le déterminisé accessible. Expliquer brièvement la démarche.], solution: [
      #code("Q24")
      La liste ```ocaml attente``` est une pile des parties découvertes et
      non encore traitées. Chaque partie reçoit son nom lors de sa découverte
      et n'est empilée qu'une fois. Le traitement ajoute ses deux transitions
      et marque l'état final exactement si la partie rencontre les états finaux.
      La partie vide est conservée lorsqu'elle est accessible : elle fournit
      le puits du déterminisé complet. À la fin, tous les états accessibles
      ont été traités, puisqu'il n'existe que $2^n$ parties possibles.
    ]),
    question([Quelle est la complexité de ```ocaml determinise``` en fonction
      du nombre $n$ d'états de $A$ et du nombre $N$ d'états de $A_"det"$ ?],
      solution: [
        Chaque partie traitée parcourt $T$, la liste des états finaux et
        effectue trois recherches dans une liste de longueur au plus $N$.
        Le coût est $O(n+N(abs(T)+n+N))$. Sur deux lettres, sans transitions
        répétées, $abs(T) ≤ 2n^2$, donc $O(N n^2+N^2+n)$.
        L'espace supplémentaire est $O(N)$, en dehors de l'automate d'entrée.
        Comme $N ≤ 2^n$, le temps peut être exponentiel en $n$.
      ]),
  )),
  partie("I.D", "Algorithme de Brzozowski", contenu: (
    [L'algorithme de Brzozowski donne un automate déterministe complet ayant
      un nombre minimal d'états parmi les automates déterministes complets
      reconnaissant le même langage.
      On se donne $A=(Q,I,{f},T)$ reconnaissant $L$, dont le miroir $tilde(A)$
      est déterministe et accessible. On note
      $A_"det"=(Y,{I},F',δ)$ son déterminisé accessible.
      Pour $u ∈ Σ^*$, on pose $u^(-1)L={w ∈ Σ^* | u w ∈ L}$.],
    question([Soient $q ∈ Q$ et $u ∈ Σ^*$. Montrer que si $q ∈ δ^*(I,u)$,
      alors il existe $w ∈ Σ^*$ tel que $u w ∈ L$.], solution: [
      L'accessibilité de $tilde(A)$ fournit un chemin de $f$ à $q$.
      En le renversant, on obtient dans $A$ un chemin de $q$ à $f$,
      étiqueté par un mot $w$. Comme $q ∈ δ^*(I,u)$, un chemin étiqueté
      $u$ joint un état initial à $q$ ; leur concaténation accepte $u w$.
    ]),
    question([Montrer la propriété $(*)$ : si $u^(-1)L=v^(-1)L$, alors
      $δ^*(I,u)=δ^*(I,v)$.], solution: [
      Prenons $q ∈ δ^*(I,u)$ et un chemin de $q$ à $f$ étiqueté $w$.
      Alors $u w ∈ L$, donc $v w ∈ L$. Un chemin acceptant pour $v w$
      passe, après $v$, par un état $q' ∈ δ^*(I,v)$, puis lit $w$ jusqu'à $f$.
      Dans $tilde(A)$, les deux chemins de $f$ étiquetés $tilde(w)$
      aboutissent à $q$ et $q'$. Le déterminisme impose $q=q'$.
      Cela prouve une inclusion ; l'autre s'obtient en échangeant $u,v$.
    ]),
    question([Pour un automate quelconque $A$ reconnaissant $L$, on pose
      $B=(tilde(A))_"det"$. En déduire que $(tilde(B))_"det"$ reconnaît $L$
      et vérifie $(*)$.], solution: [
      $B$ est déterministe, complet et accessible, et reconnaît $tilde(L)$.
      L'automate $tilde(B)$ a un unique état final et son miroir $B$ est
      déterministe accessible : le résultat précédent s'applique.
      Son déterminisé $C$ reconnaît $L$ et vérifie $(*)$.

      Il est minimal parmi les déterministes complets : si deux mots
      conduisent au même état d'un autre déterministe complet reconnaissant
      $L$, ils ont les mêmes continuations acceptantes, donc le même
      quotient $u^(-1)L$. Par $(*)$, ils conduisent aussi au même état de $C$.
      Choisir un mot d'accès à chaque état de $C$ donne ainsi des états
      distincts dans l'autre automate. Celui-ci a au moins autant d'états.
    ]),
    question([Écrire ```ocaml minimal : automate -> automate``` appliquant
      cette construction. On fera abstraction de la taille des automates
      générés, possiblement problématique.], solution: [
      #code("Q29")
      Cette composition suppose, comme demandé, que les représentations
      intermédiaires sont disponibles. Le code avec ```ocaml pow``` ne
      fonctionne effectivement que si chaque appel à ```ocaml determinise```
      reçoit au plus $20$ états. Cette limite peut être dépassée dès la
      première déterminisation ; il faudrait alors changer la représentation
      des ensembles pour appliquer la construction sans cette restriction.
    ]),
  )),
))
