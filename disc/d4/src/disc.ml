(* Chipotle record*)
type chipotle_order = { item : string; cost : float }

(* Given a list of Chipotle orders as a tuple (a,b), where a is the item name of type string and b is the item cost of type float,
 find the most expensive cost. Return 0.0 for empty list. *)
let find_expensive (orders : (string * float) list) : float =
  failwith "unimplemented"

(* Map and fold are defined here for you. You may use them. *)
let rec map f l = 
  match l with
  | [] -> []
  | h :: t -> (f h) :: (map f t)

let rec foldl f acc l = 
  match l with
  | [] -> acc
  | h :: t -> foldl f (f acc h) t

let rec foldr f l acc =
	match l with
	| [] -> acc
	| h::t -> f h (foldr f t acc)

(* Returns the sum of the ints in the lists in l. *)
(* HINT: Break this into a sub-problem. How can you sum up an int list? 
If you were to sum up each int list in the int list list given, what would you get?
What can you do with it? *)
let sum_list_list (l : int list list) : int =
  failwith "unimplemented"

(* Write your own map function using the provided fold function *)
let my_map (f : 'a -> 'b) (l : 'a list) : 'b list =
  failwith "unimplemented"
