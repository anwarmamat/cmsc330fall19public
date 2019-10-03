(* NFA Type *)

type ('q, 's) transition = 'q * 's option * 'q
type ('q, 's) nfa = {
  qs : 'q list;
  ss : 's list;
  ts : ('q, 's) transition list;
  q0 : 'q;
  fs : 'q list;
}

(* Utility *)

(* Split a string up into a list of characters. *)
let explode (s : string) : char list =
  let rec exp i l =
    if i < 0 then l else exp (i - 1) (s.[i] :: l) in
  exp (String.length s - 1) []

(* Part 1: NFAs *)

(* Returns the move set of qs on s. *)
let move (m : ('q, 's) nfa) (qs : 'q list) (s : 's option) : 'q list =
  failwith "not implemented"

(* Returns the epsilon closure of qs. *)
let rec e_closure (m : ('q, 's) nfa) (qs : 'q list) : 'q list =
  failwith "not implemented"

(* Returns whether the NFA m accepts string s. *)
let accept (m : ('q, char) nfa) (s : string) : bool =
  failwith "not implemented"

(* Part 2: Subset Construction *)

(* Converts an NFA to a DFA via the subset construction. *)
let rec dfa_of_nfa (m : ('q, 's) nfa) : ('q list, 's) nfa =
  failwith "not implemented"
