# Union-Find avec union en temps constant

Source : [échange partagé « Proposer une structure Union Find »](https://chatgpt.com/share/6aa7e009-3684-83eb-bfb1-b4e953c5cc86?ogimg=plain).

L’exercice `exercices/structures-de-donnees/union-find-union-constante.typ`
reprend les deux demandes de l’échange : union en temps constant avec recherche
en O(n²), puis avec recherche en O(n) dans le pire cas. Le corrigé reprend la
matrice d’adjacence, puis la reconstruction progressive d’une forêt couvrante.
Aucune attribution à un concours ni année n’est connue.

Précisions apportées lors de l’adaptation :

- L’ensemble est fixé, avec n ≥ 1 ; les unions acceptent des éléments quelconques,
  y compris deux éléments déjà réunis. Les boucles et les arêtes multiples sont
  autorisées et comptées dans la taille des buffers.
- Les coûts d’initialisation et l’espace sont explicitement demandés dans les deux
  questions et justifiés par le corrigé. Aucun exercice de programmation n’est ajouté.
- Le parcours de `find` utilise un espace de travail distinct de celui du parcours
  suspendu, afin que des recherches intercalées ne perturbent pas la reconstruction.
- Le changement de bloc ne peut cacher une allocation, une libération ou une
  remise à zéro linéaire. Le corrigé détaille trois paires de buffers préalloués,
  leur rotation et leur nettoyage progressif, ainsi que deux espaces de travail
  alternés pour la reconstruction. Ce nettoyage est inclus dans le quota constant.
  Cela remplace les numéros de génération suggérés dans l’échange, qui demanderaient
  de traiter leur débordement pour une suite arbitrairement longue d’opérations.

Ces précisions rendent explicites les conditions de la borne dans le pire cas ;
elles ne changent ni les deux objectifs ni le raisonnement principal de la source.
