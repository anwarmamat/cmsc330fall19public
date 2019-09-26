let rec map f l =
  match l with
  | [] -> []
  | h :: t -> (f h) :: (map f t)
;;

let rec foldl f acc l =
  match l with
  | [] -> acc
  | h :: t -> foldl f (f acc h) t
;;

let rec foldr f l acc =
	match l with
	| [] -> acc
	| h::t -> f h (foldr f t acc)
;;

(* Reverses the order of the elements in xs *)
let rev_list (xs: 'a list) : 'a list =
  []

(* Returns the sum of squares of every integer in xs. *)
let sq_sum (xs : int list) : int =
  0

(* Appends ys to the end of xs (without using @ or List.append). *)
let append (xs : 'a list) (ys : 'a list) : 'a list =
  []

(* Returns all elements that satisfy the predicate p (without using List.filter). *)
let filter (p : 'a -> bool) (xs : 'a list) : 'a list =
  []
