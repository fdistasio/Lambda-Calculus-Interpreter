(* Syntax *)
type exp =
  | Var of string
  | Lam of string * exp
  | App of exp * exp
;;