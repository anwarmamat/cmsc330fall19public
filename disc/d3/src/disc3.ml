(* 
   For practice, write the types of the following expressions/functions.
   You may have to fix some compilation errors to be able to submit. 
   Feel free to make any changes. 
*)
let x = 5 + 6

let y = if 6 > 7 then "hi" else false

let f z = if z then false else true

let g a b = (a +. b > 6.0)

(*
  name: fact
  type: int -> int
  desc: Returns the factorial of n.
  e.g.: fact 5 -> 120
*)
let rec fact n = 
  failwith "unimplemented"

(*
  name: unary
  type: int -> string
  desc: Returns an unary representation of n. Assume that n is not negative.
  e.g.: unary 0 -> ""
        unary 1 -> "1"
        unary 2 -> "11"
        unary 7 -> "1111111"
*)
let rec unary n =
  failwith "unimplemented"

(*
  name: sum_digits
  type: int -> int
  desc: Returns the sum of the digits of n.
  e.g.: sum_digits 120 -> 3
*)
let rec sum_digits n =
  failwith "unimplemented"

(*
 * sum lst : float list -> float
 * Returns the sum of the elements of the list
 *)
let rec sum lst = 
  failwith "unimplemented"

(*
 * add_to_list lst n : int list -> int -> int list
 * Returns lst with n added to every element
 *)
let rec add_to_list lst n = 
  failwith "unimplemented"

(*
 * remove_all_greater lst n : int list -> int -> int list
 * Returns lst without ALL elements greater than n 
 *)
let rec remove_all_greater lst n =   
  failwith "unimplemented"

(* 
 * For practice, write the types of the following expressions/functions.
 * You may have to fix some compilation errors to be able to submit. 
 * Feel free to make any changes. 
 *)

let f x y = x::[y];;

let g p q = match p, q with
  [], [] -> 1
| _, _ -> 2
;;