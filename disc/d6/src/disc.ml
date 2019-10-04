(* You can use these functions for the following problems. *)

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

(*
  name: full_names
  type: name_record list -> string list
  desc: Returns string representations of the name_records in l.

  full_names [
    { first = "Anwar"; middle = None; last = "Mamat" };
    { first = "Michael"; middle = Some "William"; last = "Hicks" }
  ]
  -> ["Anwar Mamat"; "Michael William Hicks"]
*)

type name_record = { first: string; middle: string option; last: string };;

let full_names l =
  failwith "unimplemented"
;;
