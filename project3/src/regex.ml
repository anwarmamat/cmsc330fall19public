(* Regular Expression Type *)

type t =
  | Empty
  | Char of char
  | Union of t * t
  | Concat of t * t
  | Star of t

(* Utility *)

(* Makes a fresh state number. *)
let fresh =
  let x = ref (-1) in
  fun () -> x := !x + 1; !x

(* Part 3: Regexp *)

(* Converts a regular expression to an NFA with Thompson's construction. *)
let rec nfa_of_regex (r : t) : ('q, 's) Nfa.nfa =
  failwith "not implemented"

(* Converts a regular expression to a string. *)
let rec string_of_regex (r : t) : string =
  paren (match r with
   | Empty -> "E"
   | Char c -> String.make 1 c
   | Union (u, v) -> (string_of_regex u) ^ "|" ^ (string_of_regex v)
   | Concat (u, v) -> (string_of_regex u) ^ (string_of_regex v)
   | Star r -> (string_of_regex r) ^ "*")

and paren s = "(" ^ s ^ ")"
