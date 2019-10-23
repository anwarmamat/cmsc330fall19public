open SmallCTypes
open Utils
open TokenTypes

(* Parsing helpers *)

let tok_list = ref []

(* Returns next token in the list. *)
let lookahead () : token =
  match !tok_list with
  | [] -> raise (Failure "no tokens")
  | h :: t -> h

(* Matches the top token in the list. *)
let consume (a : token) : unit =
  match !tok_list with
  | h :: t when a = h -> tok_list := t
  | _ -> raise (Failure "bad match")

(* Parsing *)

let rec parse_expr () =
  failwith "unimplemented"

let rec parse_stmt () =
  failwith "unimplemented"

let parse_main toks =
  failwith "unimplemented"
