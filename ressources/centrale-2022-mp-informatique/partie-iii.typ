#import "/lib/exercices.typ": question
#import "/lib/sujets.typ": partie
#import "commun.typ": antimirov

#let partie-iii = partie("III", "Automate des dérivées d'Antimirov", contenu: (
  [On propose une méthode construisant, à partir d'une expression régulière,
    un automate non déterministe ayant peu d'états. Pour deux ensembles
    d'expressions $S,S'$, on pose
    $ S dot S'={E dot E' | (E,E') ∈ S × S'}. $
    En particulier, $∅ dot S=∅$ et ${ε} dot S=S$. On utilise les conventions
    syntaxiques d'associativité de la concaténation et de neutralité de $ε$.
    Soient $E$ une expression régulière sur $Σ$ et $a ∈ Σ$. La dérivée
    partielle $∂_a(E)$ est l'ensemble d'expressions défini inductivement par
    $ ∂_a(∅)=∅, quad ∂_a(ε)=∅, quad
      ∂_a(b)=cases({ε} & "si" a=b, ∅ & "sinon"), $
    $ ∂_a(E+F)=∂_a(E) ∪ ∂_a(F), quad ∂_a(E^*)=∂_a(E) dot {E^*}, $
    $ ∂_a(E F)=cases(
        ∂_a(E) dot {F} & "si" ε ∉ cal(L)(E),
        ∂_a(E) dot {F} ∪ ∂_a(F) & "sinon".
      ) $
    La dérivée partielle prend donc une expression en argument et renvoie
    un ensemble d'expressions.

    Par exemple, pour $E=a^*(a+b)$, puisque $ε ∈ cal(L)(a^*)$,
    $ ∂_a(E)=∂_a(a^*) dot {a+b} ∪ ∂_a(a+b)
        ={a^*(a+b),ε}, $
    $ ∂_b(E)=∂_b(a^*) dot {a+b} ∪ ∂_b(a+b)={ε}. $
  ],
  question([Pour $E=(a b+b)^* b a$, calculer $∂_a(E)$ et $∂_b(E)$.],
    solution: [
      Posons $H=(a b+b)^*$, donc $E=H b a$.
      On a $∂_a(a b+b)={b}$ et $∂_b(a b+b)={ε}$.
      Par conséquent $∂_a(H)={b H}$ et $∂_b(H)={H}$.
      Comme $ε ∈ cal(L)(H)$, on obtient
      $ ∂_a(E)={b H b a}={b E}, quad
        ∂_b(E)={H b a,a}={E,a}. $
    ]),
  [On étend les dérivées aux mots et aux ensembles d'expressions : pour
    $a ∈ Σ$, $w ∈ Σ^*$ et un ensemble d'expressions $S$,
    $ ∂_ε(E)={E}, quad ∂_(w a)(E)=∂_a(∂_w(E)), quad
      ∂_w(S)=union_(E ∈ S) ∂_w(E). $
    L'automate d'Antimirov de $E$ est $A=(Q,I,F,T)$, défini par
    $ Q={E_1 | ∃w ∈ Σ^*, E_1 ∈ ∂_w(E)}, quad I={E}, $
    $ F={E_1 ∈ Q | ε ∈ cal(L)(E_1)}, $
    $ T={(E_1,c,E_2) ∈ Q × Σ × Q | E_2 ∈ ∂_c(E_1)}. $
    Pour tout mot $w$ et tout langage $L ⊆ Σ^*$, on rappelle
    $w^(-1)L={u ∈ Σ^* | w u ∈ L}$.
  ],
  question([Dessiner l'automate obtenu à partir de $E=(a b+b)^* b a$.
    Indiquer précisément son ensemble d'états $Q$.], solution: [
    On a $Q={E,b E,a,ε}$, $I={E}$ et $F={ε}$.
    En plus des dérivées de $E$, on a $∂_a(b E)=∅$, $∂_b(b E)={E}$,
    $∂_a(a)={ε}$, $∂_b(a)=∅$ et les deux dérivées de $ε$ sont vides.
    Les quatre états sont accessibles et cet ensemble est stable par dérivation.
    #antimirov()
    L'état final est représenté par un double cercle.
  ]),
  question([Montrer que pour tous mots $u,v$ et tout langage $L$,
    $v^(-1)(u^(-1)L)=(u v)^(-1)L$.], solution: [
    Pour tout $z$, on a successivement
    $ z ∈ v^(-1)(u^(-1)L) ⇔ v z ∈ u^(-1)L ⇔ u v z ∈ L
      ⇔ z ∈ (u v)^(-1)L. $
  ]),
  [Pour un ensemble d'expressions $S$, on note $cal(L)(S)$ la réunion de
    leurs langages. On admet que pour toute expression $E$ et toute lettre $x$,
    $ cal(L)(∂_x(E))=x^(-1)cal(L)(E). $
  ],
  question([Pour tout ensemble $S$ d'expressions sur $Σ$ et tout $w ∈ Σ^*$,
    montrer $cal(L)(∂_w(S))=w^(-1)cal(L)(S)$.], solution: [
    Pour une lettre $x$, l'union des identités admises donne
    $ cal(L)(∂_x(S))=union_(E ∈ S) x^(-1)cal(L)(E)
      =x^(-1)cal(L)(S). $
    La dernière égalité vient de ce que $x z$ appartient à une union si et
    seulement s'il appartient à l'un de ses termes.
    Raisonnons maintenant par récurrence sur la longueur de $w$, pour tout $S$.
    Le cas $ε$ est immédiat car $∂_ε(S)=S$.
    Pour $w=u x$, l'identité pour une lettre, l'hypothèse de récurrence et Q46 donnent
    $ cal(L)(∂_(u x)(S))=cal(L)(∂_x(∂_u(S)))
      =x^(-1)(u^(-1)cal(L)(S))=(u x)^(-1)cal(L)(S). $
  ]),
  question([Montrer que pour tout $w ∈ Σ^*$, $∂_w(E)$ est l'ensemble des
    états accessibles depuis $E$ en lisant $w$.], solution: [
    Pour $ε$, le seul état atteint est $E$ et $∂_ε(E)={E}$.
    Si la propriété est vraie pour $u$, les états atteints après $u a$
    sont les successeurs par $a$ des états de $∂_u(E)$, soit
    $ union_(H ∈ ∂_u(E)) ∂_a(H)=∂_a(∂_u(E))=∂_(u a)(E). $
    La récurrence conclut.
  ]),
  question([En déduire que l'automate d'Antimirov reconnaît le langage de $E$.],
    solution: [
      Un mot $w$ est accepté si et seulement si un état $H ∈ ∂_w(E)$ est final,
      c'est-à-dire si $ε ∈ cal(L)(∂_w(E))$. Par Q47, cela équivaut à
      $ε ∈ w^(-1)cal(L)(E)$, donc à $w ∈ cal(L)(E)$.
      La finitude de l'automate sera établie à la question suivante.
    ]),
  [Pour $w ∈ Σ^* ∖ {ε}$ et toutes expressions $E,F$, on vérifie les relations
    $ ∂_w(E+F)=∂_w(E) ∪ ∂_w(F) quad "(III.1)", $
    $ ∂_w(E F) ⊆ ∂_w(E) dot {F} ∪ union_(v ∈ S^+(w)) ∂_v(F)
      quad "(III.2)", $
    $ ∂_w(E^*) ⊆ union_(v ∈ S^+(w)) ∂_v(E) dot {E^*}
      quad "(III.3)", $
    où $S^+(w)$ est l'ensemble des suffixes non vides de $w$. On pose
    $ Q(E)=union_(w ∈ Σ^* ∖ {ε}) ∂_w(E). $
  ],
  question([Montrer que $abs(Q(E))$ est majoré par le nombre de lettres
    présentes dans l'écriture syntaxique de $E$, noté $norm(E)$.
    Qu'en déduit-on sur l'automate d'Antimirov ?], solution: [
    Raisonnons par induction structurelle.
    - Pour $E=∅$ ou $E=ε$, $Q(E)=∅$ et $norm(E)=0$.
    - Pour une lettre $a$, $Q(a)={ε}$ et $norm(a)=1$.
    - D'après (III.1), $Q(E+F)=Q(E) ∪ Q(F)$, donc
      $abs(Q(E+F)) ≤ abs(Q(E))+abs(Q(F)) ≤ norm(E)+norm(F)=norm(E+F)$.
    - D'après (III.2), $Q(E F) ⊆ Q(E) dot {F} ∪ Q(F)$.
      L'image de $Q(E)$ par $H ↦ H F$ contient au plus $abs(Q(E))$ éléments.
      Ainsi $abs(Q(E F)) ≤ norm(E)+norm(F)=norm(E F)$.
    - D'après (III.3), $Q(E^*) ⊆ Q(E) dot {E^*}$, donc
      $abs(Q(E^*)) ≤ abs(Q(E)) ≤ norm(E)=norm(E^*)$.

    L'ensemble des états de l'automate est ${E} ∪ Q(E)$, car il faut
    également compter la dérivée par le mot vide. Il contient donc au plus
    $norm(E)+1$ états. L'automate est fini, accessible et reconnaît
    $cal(L)(E)$ ; il n'est pas nécessairement déterministe.
  ]),
))
