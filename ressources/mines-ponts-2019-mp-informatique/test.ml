#use "corrige.ml";;

let verifie message condition = if not condition then failwith message
let a1 = (2, [|(1,1); (0,0)|], [|false;true|])
let a3 = (3, [|(1,2); (1,2); (2,1)|], [|false;false;true|])
let a4 = (4, [|(1,2); (0,3); (3,0); (2,1)|], [|false;false;true;true|])
(* Ordre P,O,Q,R,S,T de la figure 6 ; P est initial. *)
let a6 = (6, [|(0,2); (0,5); (3,1); (2,4); (5,4); (3,0)|],
             [|true;true;false;false;false;false|])

(* Oracle indépendant : comparer les langages depuis deux états par
   parcours du produit vers l'avant, jusqu'à un désaccord de finalité. *)
let equivalents (_, d, f) p (_, d', f') q =
  let vus = Hashtbl.create 16 in
  let rec visiter = function
    | [] -> true
    | (p,q) :: suite when Hashtbl.mem vus (p,q) -> visiter suite
    | (p,q) :: suite ->
        Hashtbl.add vus (p,q) ();
        let pa,pb = d.(p) and qa,qb = d'.(q) in
        f.(p) = f'.(q) && visiter ((pa,qa) :: (pb,qb) :: suite)
  in visiter [p,q]

let est_morphisme (n,d,f) (m,d',f') phi =
  let image = Array.make m false in
  let ok = ref (Array.length phi = n && phi.(0) = 0) in
  for p = 0 to n - 1 do
    let q = phi.(p) in
    if q < 0 || q >= m then ok := false
    else begin
      image.(q) <- true;
      let pa,pb = d.(p) and qa,qb = d'.(q) in
      if f.(p) <> f'.(q) || phi.(pa) <> qa || phi.(pb) <> qb then ok := false
    end
  done;
  !ok && Array.for_all (fun x -> x) image

let verifie_reduction aut taille =
  let ((n,_,_) as minimal) = reduit aut in
  verifie "nombre minimal d'états" (n = taille);
  verifie "conservation exacte du langage" (equivalents aut 0 minimal 0);
  verifie "accessibilité" (List.length (etats_accessibles minimal) = n);
  for p = 0 to n - 1 do
    for q = p + 1 to n - 1 do
      verifie "états distincts distinguables" (not (equivalents minimal p minimal q))
    done
  done

let () =
  (* 1. Numérotation : absence, répétition, liste vide. *)
  verifie "numero" (numero 5 [3;2;0;3] = [|2;-1;1;3;-1|] && numero 0 [] = [||]);
  (* 2. Ordre DFS : ici il diffère de l'ordre en largeur. *)
  verifie "ordre DFS" (etats_accessibles a6 = [0;2;3;4;5;1]);
  (* 3. Suppression et renumérotation d'un état inaccessible. *)
  let trou = (4, [|(2,2);(1,1);(3,0);(3,2)|], [|false;true;false;true|]) in
  let attendu = (3, [|(1,1);(2,0);(2,1)|], [|false;false;true|]) in
  verifie "partie accessible" (partie_accessible trou = attendu);
  (* 4. Existence, incompatibilité de transitions et de l'état initial. *)
  let ok,phi = existe_morphisme a3 a2 in
  verifie "morphisme" (ok && est_morphisme a3 a2 phi);
  let non1,_ = existe_morphisme a1 a2 in
  let non2,_ = existe_morphisme (1,[|(0,0)|],[|true|]) (1,[|(0,0)|],[|false|]) in
  verifie "absence de morphisme" (not non1 && not non2);
  (* 5. Produit : cinq états accessibles et langage commun conservé. *)
  let prod = produit a3 a4 in
  verifie "produit" (List.length (etats_accessibles prod) = 5 && equivalents prod 0 a2 0);
  (* 6. Renommage, y compris les tableaux vides et le zéro. *)
  verifie "renomme" (renomme [|4;4;5;0;4;5|] = [|0;0;1;2;0;1|] && renomme [||] = [||]);
  (* 7. Fermeture transitive alternant les deux morphismes, question 30. *)
  verifie "relation" (relation [|0;1;1;2;2|] [|0;0;1;2;3|] = [|0;0;0;1;1|]);
  (* 8. Régression du sens erroné de la question 36 : diagonale toujours fausse. *)
  let contre_exemple = (2,[|(1,1);(1,1)|],[|false;true|]) in
  verifie "sens des prédécesseurs"
    (table_de_predecesseurs contre_exemple = [|[|false;true|];[|true;false|]|]);
  let d = table_de_predecesseurs a6 in
  for p = 0 to 5 do
    for q = 0 to 5 do
      verifie "table exacte" (d.(p).(q) = not (equivalents a6 p a6 q))
    done
  done;
  (* 9. Automate minimal à trois états de la figure 6. *)
  verifie_reduction a6 3;
  (* 10. Entrée non accessible, langage vide et langage universel. *)
  verifie_reduction trou 3;
  verifie_reduction (3,[|(1,2);(2,0);(0,1)|],[|false;false;false|]) 1;
  verifie_reduction (3,[|(1,2);(2,0);(0,1)|],[|true;true;true|]) 1;
  print_endline "Mines-Ponts 2019 : 10 groupes de tests réussis."
