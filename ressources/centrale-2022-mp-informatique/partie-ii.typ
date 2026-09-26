#import "/lib/exercices.typ": question
#import "/lib/sujets.typ": partie
#import "commun.typ": code, arbre-e4, graphe-matrice

#let partie-ii = partie("II", "Expression régulière associée à un automate", contenu: (
  [On introduit un algorithme dû à Conway, calculant une expression régulière
    associée au langage d'un automate à l'aide de matrices d'expressions régulières.],
  partie("II.A", "Simplification d'expressions régulières équivalentes", contenu: (
    [On se donne le type OCaml des expressions régulières : #code("exprat")],
    partie("II.A.1", "Parcours d'une expression", contenu: (
      question([Écrire ```ocaml lettre : exprat -> int``` qui renvoie le nombre
        de lettres présentes dans une expression régulière. Par exemple, pour
        $E=(a^* b) | a b b a(a | ε)^* | ∅$, la fonction doit renvoyer $7$.],
        solution: [#code("Q30")
          La preuve suit l'induction structurelle : seuls les nœuds
          ```ocaml Lettre``` contribuent, chacun pour une unité.
        ]),
      question([Écrire ```ocaml est_vide : exprat -> bool``` qui teste si le
        langage représenté est vide.], solution: [#code("Q31")
          Une union est vide si ses deux termes le sont ; une concaténation
          est vide si au moins un terme l'est. Une étoile contient toujours
          $ε$. Ces règles donnent la correction par induction structurelle.
        ]),
    )),
    partie("II.A.2", "Règles de simplification", contenu: (
      [On travaille sur la syntaxe des expressions et on utilise les équivalences
        $ ∅ | E ≡ E | ∅ ≡ E, quad E dot ε ≡ ε dot E ≡ E, $
        $ E dot ∅ ≡ ∅ dot E ≡ ∅, quad ∅^* ≡ ε, quad ε^* ≡ ε,
          quad (E^*)^* ≡ E^*. $
        La notation $E ≡ E'$ signifie $cal(L)(E)=cal(L)(E')$.
        La fonction suivante simplifie à la racine une union : #code("su")
        On suppose aussi codée ```ocaml sc : exprat -> exprat```, qui simplifie
        à la racine une concaténation en utilisant les règles données.],
      question([Écrire ```ocaml se : exprat -> exprat``` qui simplifie à la
        racine une expression de type ```ocaml Etoile``` selon ces règles.],
        solution: [#code("Q32")]),
      [Considérons $E_n=a | (b dot (b dot (… (b dot ∅)…)))$, où $n$ lettres $b$
        concaténées se succèdent.
        #arbre-e4()
        #align(center)[Figure 2 — Arbre syntaxique de $E_4$.]
      ],
      question([Combien d'applications des règles sont nécessaires pour
        obtenir l'expression $a$ à partir de $E_n$ ?], solution: [
        Il faut $n+1$ applications : les $n$ concaténations avec $∅$ sont
        supprimées de l'intérieur vers l'extérieur, puis $a | ∅$ devient $a$.
        Aucune concaténation extérieure n'est simplifiable avant que sa
        sous-expression droite ne soit devenue $∅$.
      ]),
      question([Écrire ```ocaml simplifie : exprat -> exprat``` qui simplifie
        une expression selon ces règles.], solution: [
        #code("Q34")
        On simplifie les fils avant la racine. Par induction, les fils sont
        irréductibles ; la règle appliquée à la racine renvoie alors soit
        un fils déjà simplifié, soit un constructeur auquel plus aucune
        règle ne s'applique. Un parcours suffit. Il est linéaire dans le
        nombre de nœuds de l'arbre syntaxique fourni.
      ]),
    )),
  )),
  partie("II.B", "Matrices d'expressions régulières", contenu: (
    [On considère des matrices d'expressions régulières : #code("mat")
      La matrice nulle de taille $n$ a tous ses coefficients égaux à $∅$.
      La matrice identité a $ε$ sur sa diagonale et $∅$ ailleurs.
      Pour $A,B$ de taille $n × m$, on définit $[A | B]_(i,j)=A_(i,j) | B_(i,j)$,
      où le signe $|$ désigne l'union, pour $0 ≤ i<n$ et $0 ≤ j<m$.
      Pour $A$ de taille $n × p$ et $B$ de taille $p × q$, le produit de taille
      $n × q$ est défini comme le produit usuel, en remplaçant la somme par
      l'union et le produit par la concaténation.

      Les dimensions de cette sous-partie sont strictement positives.
      Pour les complexités, on compte la construction d'un nœud d'expression
      en temps constant, avec partage des sous-expressions immuables.
      On ne développe ni n'imprime les expressions pendant les calculs.
    ],
    partie("II.B.1", "Somme et produit", contenu: (
      question([Écrire ```ocaml somme : mat -> mat -> mat``` qui effectue la
        somme de matrices de même taille $n × p$. Quelle est sa complexité ?],
        solution: [#code("Q35")
          Chaque coefficient crée une union en temps constant : coût $Θ(n p)$.
        ]),
      question([Écrire ```ocaml produit : mat -> mat -> mat``` qui effectue
        le produit de deux matrices de tailles compatibles $n × p$ et $p × q$.
        On ne vérifiera pas cette compatibilité. Quelle est sa complexité ?],
        solution: [#code("Q36")
          Après $k$ itérations de la boucle intérieure, le coefficient
          calculé représente l'union des $k$ premiers produits.
          Il y a $n p q$ itérations, chacune en temps constant, donc un coût
          $Θ(n p q)$, initialisation comprise.
        ]),
    )),
    [On cherche à définir l'étoile de Kleene d'une matrice carrée.],
    partie("II.B.2", "Étoile d'une matrice de taille deux", contenu: (
      [Soit $M=mat(a,b;c,d)$, où $a,b,c,d$ sont quatre lettres.
        On associe à $M$ le graphe étiqueté $G=(S,A)$ de la figure 3,
        avec $S={0,1}$.
        #graphe-matrice()
        #align(center)[Figure 3 — Graphe associé à $M$.]
        On note $L_(i,j)$ le langage de l'automate
        $cal(A)_(i,j)=({0,1},{i},{j},T)$, où
        $T={(i,M_(i,j),j) | (i,j) ∈ {0,1}^2}$.
      ],
      question([Donner une expression régulière sur ${a,b,c,d}$ pour chacun
        des langages $L_(i,j)$.], solution: [
        $ L_(0,0)=(a | b d^* c)^*, quad L_(1,1)=(d | c a^* b)^*, $
        $ L_(0,1)=a^* b(d | c a^* b)^*, quad
          L_(1,0)=d^* c(a | b d^* c)^*. $
        Un chemin de $0$ à $0$ est une succession de boucles $a$ ou
        d'excursions $b d^* c$ ; l'argument est symétrique pour $1$.
        Pour aller de $0$ à $1$, on lit $a^* b$ jusqu'à la première arrivée
        en $1$, puis un chemin de $1$ à $1$. Même raisonnement pour $1$ vers $0$.
      ]),
    )),
    partie("II.B.3", "Étoile d'une matrice de taille quelconque", contenu: (
      [On définit récursivement l'étoile de $M$ : si $M=(e)$ est de taille
        $1$, alors $M^*=(e^*)$. Sinon, on découpe en blocs
        $ M=mat(A,B;C,D), quad M^*=mat(A',B';C',D'), $
        où $A,D$ sont carrées de tailles au moins $1$, et
        $ A'=(A | B D^* C)^*, quad B'=A^* B(D | C A^* B)^*, $
        $ C'=D^* C(A | B D^* C)^*, quad D'=(D | C A^* B)^*. $
        Les fonctions suivantes sont supposées codées :
        - ```ocaml decouper : mat -> int -> int -> mat * mat * mat * mat``` :
          ```ocaml decouper m n1 n2``` renvoie les blocs $A,B,C,D$ d'une matrice
          carrée $M$ de taille $n_1+n_2$, avec $A$ carrée de taille $n_1$ et
          $D$ carrée de taille $n_2$ ;
        - ```ocaml recoller : mat -> mat -> mat -> mat -> mat``` : reconstruit
          $M=mat(A,B;C,D)$ à partir de quatre blocs de tailles compatibles.

        Pour une matrice de taille $n ≥ 2$, considérons d'abord
        $ M=mat(a,B;C,D), $
        où $a$ est une expression régulière (un bloc de taille $1$) et $D$
        est carrée de taille $n-1$. On a alors
        $ A'=(a | B D^* C)^*, quad B'=a^* B(D | C a^* B)^*, $
        $ C'=D^* C(a | B D^* C)^*, quad D'=(D | C a^* B)^*. $
      ],
      question([Évaluer les complexités des sommes et produits. En déduire
        que le coût $C(n)$ du calcul de l'étoile vérifie
        $C(n)=2C(n-1)+O(n^2)$. En déduire la complexité de cet algorithme.],
        solution: [
          Posons $m=n-1$. On calcule et conserve $D^*$ et $a^*$.
          $D^* C$ coûte $Θ(m^2)$, puis $B(D^* C)$ coûte $Θ(m)$.
          $a^* B$ coûte $Θ(m)$ et $C(a^* B)$ coûte $Θ(m^2)$ ; l'addition
          à $D$ coûte $Θ(m^2)$. On calcule ensuite $(D | C a^* B)^*$ une seule fois.
          Le produit donnant $B'$ coûte $Θ(m^2)$ ; celui donnant $C'$ coûte
          $Θ(m)$. Les opérations scalaires coûtent $O(1)$ ; découpage et
          recollement coûtent $O(n^2)$.
          Les deux appels sur des matrices de taille $n-1$ donnent la récurrence.
          En la déroulant,
          $ C(n)/2^n ≤ C(1)/2 + K sum_(j=2)^n j^2/2^j. $
          La somme est bornée : le rapport des termes successifs est inférieur
          à une constante strictement inférieure à $1$ à partir d'un certain
          rang. Ainsi $C(n)=O(2^n)$, et même $Θ(2^n)$ puisque l'arbre d'appels
          contient $2^(n-1)$ feuilles.
        ]),
      [Supposons maintenant que $n ≥ 2$ est une puissance de $2$.
        On découpe $M=mat(A,B;C,D)$ avec $A,D$ de taille $n/2$.],
      question([Évaluer les complexités des sommes et produits. En déduire
        $C(n)=4C(n/2)+O(n^3)$, puis la complexité de l'algorithme.], solution: [
        On conserve les quatre étoiles $A^*$, $D^*$, $A'$ et $D'$ pour les
        réutiliser. Il y a un nombre constant de produits de matrices de
        taille $n/2$, coûtant chacun $Θ(n^3)$, et de sommes coûtant $Θ(n^2)$.
        Le découpage et le recollement coûtent $Θ(n^2)$.
        Au niveau $k$ de l'arbre de récursion, le coût hors appels est
        $O(4^k(n/2^k)^3)=O(n^3/2^k)$.
        La somme géométrique sur tous les niveaux est $O(n^3)$ ; les
        $4^(log_2 n)=n^2$ feuilles ne changent pas cette borne.
        Le coût du premier niveau fournit aussi une minoration : $C(n)=Θ(n^3)$.
      ]),
      question([Comment gérer une taille $n$ quelconque ? Quelle complexité
        peut-on obtenir pour $M^*$ ?], solution: [
        On peut compléter $M$ par des lignes et colonnes d'expressions vides
        jusqu'à la puissance de deux $p$ suivante, avec $n ≤ p<2n$.
        Aucun chemin ne passe par les nouveaux sommets, sauf les chemins
        vides sur eux-mêmes. Le bloc supérieur gauche de l'étoile est donc
        $M^*$, calculé en $O(p^3)=O(n^3)$.

        On peut aussi découper directement en tailles $floor(n/2)$ et
        $ceil(n/2)$, comme dans le code suivant. Au niveau $k$, il y a au
        plus $4^k$ appels sur des tailles au plus $ceil(n/2^k)$, d'où le
        même majorant géométrique $O(n^3/2^k)$ avant le dernier niveau.
        Les $O(n^2)$ feuilles donnent encore un coût $O(n^3)$.
      ]),
      question([Écrire ```ocaml etoile : mat -> mat``` qui renvoie l'étoile
        d'une matrice avec l'algorithme récursif le plus adéquat.], solution: [
        #code("Q41")
        Chaque sous-matrice carrée passée récursivement est strictement
        plus petite. Les formules de l'énoncé donnent la correction par
        récurrence sur $n$. Les quatre résultats récursifs sont calculés
        une seule fois chacun, comme requis pour le coût cubique.
      ]),
    )),
  )),
  partie("II.C", "Algorithme de Conway", contenu: (
    [Soit $A=(Q,I,F,T)$ avec $Q=⟦0,n-1⟧$. Sa matrice de transition est
      la matrice d'expressions régulières $M_A$ dont le coefficient $[M_A]_(i,j)$
      est l'union, notée $|$, des lettres $c ∈ Σ$ telles que $(i,c,j) ∈ T$.
      L'union vide vaut $∅$. On admet que
      $cal(L)([M_A^*]_(i,j))=L_(i,j)$, langage des chemins défini à la question 9.],
    question([Montrer que $L_A=cal(L)([X M_A^* Y]_(0,0))$, où $X$ est
      une matrice ligne $(x_0,…,x_(n-1))$ et $Y$ une matrice colonne de
      coefficients $y_0,…,y_(n-1)$, avec $x_i,y_j ∈ {∅,ε}$.
      Préciser les coefficients en fonction de l'automate.], solution: [
      On choisit $x_i=ε$ si $i ∈ I$, et $∅$ sinon ; $y_j=ε$ si $j ∈ F$,
      et $∅$ sinon. Le produit représente exactement
      $ union_(i ∈ I) union_(j ∈ F) cal(L)([M_A^*]_(i,j))
        =union_(i ∈ I) union_(j ∈ F) L_(i,j)=L_A. $
    ]),
    question([Écrire ```ocaml langage : automate -> exprat``` renvoyant une
      expression régulière du langage de l'automate. Quelle est sa complexité ?],
      solution: [
        #code("Q43")
        Le calcul final sélectionne directement les coefficients d'indices
        initial-final, ce qui donne le même langage que $X M_A^* Y$.
        La construction de $M_A$ coûte $O(n^2+abs(T))$, l'étoile $O(n^3)$
        et l'union finale $O(abs(I) abs(F))$. Le coût total est donc
        $O(1+n^3+abs(T))$, soit $O(n^3)$ pour $n ≥ 1$ sur un alphabet fixé.

        Les sous-expressions sont partagées : un constructeur OCaml conserve
        des références à ses arguments, sans recopier leurs arbres.
        Cette borne concerne la représentation partagée produite. Le
        développement, l'affichage ou la simplification naïve de l'arbre
        entièrement déplié peut coûter beaucoup plus, et n'est pas effectué ici.
      ]),
  )),
))
