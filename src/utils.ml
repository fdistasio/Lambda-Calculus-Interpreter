open Types 

(* Free Variables of e *)
let rec fvs e =
  match e with
    | Var x -> [x]
    | Lam (x, e) -> List.filter (fun y -> x <> y) (fvs e)
    | App (e1,e2) -> (fvs e1) @ (fvs e2)
;;

(* Fresh variable *)
let newvar =
  let x = ref 0 in
  fun () -> 
    let c = !x in
    incr x;
    "v"^(string_of_int c)
;;

(* Substitution: subst e y m means "substitute occurrences of variable y with m in the expression e" *)
let rec subst e y m =
  match e with
    | Var x -> 
        if y = x then m (* replace x with m *)
        else e (* variables don't match: leave x unchanged *)
    | App (e1, e2) -> App (subst e1 y m, subst e2 y m)
    | Lam (x, e) ->
        if y = x then Lam(x, e) (* don't substitute under the variable binder *)
        else if not (List.mem x (fvs m)) then Lam (x, subst e y m) (* no need to alpha convert *)
        else (* need to alpha convert *)
          let z = newvar() in (* assumed to be "fresh" *)
          let e' = subst e x (Var z) in (* replace x with z in e *)
          Lam (z, subst e' y m) (* substitute for y in the adjusted term, e' *)
;;

(* Print lambda-expression *)
let rec string_of_exp e =
  match e with
  | Var x -> x
  | Lam (x, e) -> "(lambda " ^ x ^ ". " ^ string_of_exp e ^ ")"
  | App (e1, e2) -> "(" ^ string_of_exp e1 ^ " " ^ string_of_exp e2 ^ ")"
;;