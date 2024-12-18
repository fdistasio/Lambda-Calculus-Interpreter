open Types
open Utils

(* Beta reduction *)
let reduce e =
  let limit = 1000 in (* iterations limit *)
  let rec reduce_rec e iteration =
    if iteration > limit then failwith "Infinite reduction" else
    match e with
      | App (Lam (x, e1), e2) -> reduce_rec (subst e1 x e2) (iteration + 1) (* direct beta rule *)
      | App (e1, e2) ->
          let e1' = reduce_rec e1 (iteration + 1) in (* try to reduce a term in the lhs *)
          if e1' <> e1 then reduce_rec (App(e1', e2)) (iteration + 1)
          else App (e1, reduce_rec e2 (iteration + 1)) (* didn't work; try rhs *)
      | Lam (x, e) -> Lam (x, reduce_rec e (iteration + 1)) (* reduce under the lambda *)
      | _ -> e (* no opportunity to reduce *)
  in reduce_rec e 0
;;

(* Call by value *)
let cbv e =
  let limit = 1000 in (* iterations limit *)
  let rec reduce_rec e iteration =
      if iteration > limit then failwith "Infinite reduction" else
      match e with
        | App (Lam (x,e1), e2) -> 
            let e2' = reduce_rec e2 (iteration + 1) in (* reduce e1 first *)
            reduce_rec (subst e1 x e2') (iteration + 1) (* then substitution *)
        | App (e1, e2) ->
            let e1' = reduce_rec e1 (iteration + 1) in (* try to reduce a term in the lhs *)
            if e1' <> e1 then reduce_rec (App(e1', e2)) (iteration + 1)
            else App (e1, reduce_rec e2 (iteration + 1)) (* didn't work; try rhs *)
        | Lam (x, e) -> Lam (x, e) (* don't reduce body *)
        | _ -> e (* no opportunity to reduce *)
  in reduce_rec e 0
;;

(* Call by name *)
let cbn e =
  let limit = 1000 in (* iterations limit *)
  let rec reduce_rec e iteration =
    if iteration > limit then failwith "Infinite reduction" else
    match e with
      | App (Lam (x,e1), e2) -> reduce_rec (subst e1 x e2) (iteration + 1) (* direct rule *)
      | App (e1, e2) ->
          let e1' = reduce_rec e1 (iteration + 1) in (* try to reduce a term in the lhs *)
          reduce_rec (App(e1', e2)) (iteration + 1)
      | Lam (x, e) -> Lam (x, reduce_rec e (iteration + 1)) (* don't reduce body *)
      | _ -> e (* no opportunity to reduce *)
  in reduce_rec e 0
;;