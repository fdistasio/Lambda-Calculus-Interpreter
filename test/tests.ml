open Types
open Utils
open Interpreter

(* TESTS *)
let m1 =  (App (Var "x", Var "y"));; (* x y *)
let m2 = (App (Lam ("z",Var "z"), Var "w"));; (* (lambda z . z) w *)
let m3 = (App (Lam ("z",Var "x"), Var "w"));; (* (lambda z . x) w *)
let m4 = (App (App (Lam ("z",Var "z"), Lam ("x", Var "x")), Var "w")) (* (lambda z . z) (lambda x . x) w *)
let m5 = (App (Lam ("a", App (Var "a", Var "b")), Var "c"));; (* (lambda a . (a b)) c *)
let m6 = (App (Lam ("x", Lam ("y", App (Var "x", Var "y"))), Var "z"));; (* (lambda x . (lambda y . (x y))) z *)
let m7 = (App (Lam ("x", Lam ("y", Var "x")), Var "a"));; (* (lambda x . (lambda y . x)) a *)
let m8 = (App (Lam ("x", Lam ("y", App (Var "x", Var "y"))), Lam ("z", Var "z")));; (* (lambda x . (lambda y . (x y))) (lambda z . z) *)
let m9 = (App (Lam ("f", App (Var "f", Var "x")), Lam ("y", Var "y")));; (* (lambda f . (f x)) (lambda y . y) *)
let m10 = (App (Lam ("x", App (Var "x", Var "y")), Lam ("z", Var "z")));; (* (lambda x . (x y)) (lambda z . z) *)
let m11 = (App (Lam ("x", Var "y"), App (Lam ("y", App(Var "y", App(Var "y", Var "y"))), Lam ("x", App(Var "x", App(Var "x", Var "x"))))));; (* (lambda x. y) ((lambda y. yyy) (lambda x. xxx)) *)
let m12 = (App(Lam ("z", App (App (Lam ("x", Lam ("y", App (Var "x", Var "y"))), Var "z"), Var "z")), Lam("z", App (Var "z", Var "z"))));; (* (lambda z. ((lambda x. lambda y. xy)z)z)(lambda z.zz)*)
let omega = (App (Lam ("x", App (Var "x", Var "x")), Lam ("x", App (Var "x", Var "x"))));; (* (lambda x . (x x)) (lambda x . (x x)) *)

Printf.printf "m1 reduced: %s\n" (string_of_exp (reduce m1));;
Printf.printf "m2 reduced: %s\n" (string_of_exp (reduce m2));;
Printf.printf "m3 reduced: %s\n" (string_of_exp (reduce m3));;
Printf.printf "m4 reduced: %s\n" (string_of_exp (reduce m4));;
Printf.printf "m5 reduced: %s\n" (string_of_exp (reduce m5));;
Printf.printf "m6 reduced: %s\n" (string_of_exp (reduce m6));;
Printf.printf "m7 reduced: %s\n" (string_of_exp (reduce m7));;
Printf.printf "m8 reduced: %s\n" (string_of_exp (reduce m8));;
Printf.printf "m9 reduced: %s\n" (string_of_exp (reduce m9));;
Printf.printf "m10 reduced: %s\n" (string_of_exp (reduce m10));;
Printf.printf "m11 reduced: %s\n" (string_of_exp (reduce m11));;
Printf.printf "m11 reduced (cbn): %s\n" (string_of_exp (cbn m11));;
Printf.printf "m11 reduced (cbv): %s\n" (string_of_exp (cbv m11));;
Printf.printf "m12 reduced: %s\n" (string_of_exp (reduce m12));;
Printf.printf "m12 reduced (cbv): %s\n" (string_of_exp (cbv m12));;
Printf.printf "m12 reduced (cbn): %s\n" (string_of_exp (cbn m12));;
Printf.printf "omega reduced: %s\n" (string_of_exp (reduce omega));;

