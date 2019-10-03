open Lexer
open Regex

(* Utility *)

let toks = ref []

(* Returns next token in the list. *)
let lh () : Lexer.t =
  match !toks with
  | [] -> raise (Failure "parse: no tokens")
  | x :: _ -> x

(* Matches the top token in the list. *)
let consume (a : Lexer.t) : unit =
  match !toks with
  | x :: xt when a = x -> toks := xt
  | _ -> raise (Failure "parse: bad match")

(* Parser *)

(* Parses a token list. *)
let rec parse (ts : Lexer.t list) : Regex.t =
  toks := ts;
  let e = parse_U () in
  if !toks <> [Tok_EOF] then
    raise (Failure "parse: did not reach EOF")
  else e

(* Parse the U (union) rule. *)
and parse_U () : Regex.t =
  let x = parse_A () in
  match lh () with
  | Tok_Union as t -> consume t; Union (x, parse_U ())
  | _ -> x

(* Parse the A (concatenation) rule. *)
and parse_A () : Regex.t =
  let x = parse_K () in
  match lh () with
  | Tok_Char _
  | Tok_Eps
  | Tok_LParen -> Concat (x, parse_A ())
  | _ -> x

(* Parse the K (Kleene star) rule. *)
and parse_K () : Regex.t =
  let x = parse_P () in
  match lh () with
  | Tok_Star as t -> consume t; Star x
  | _ -> x

(* Parse the P (primitive) rule. *)
and parse_P () : Regex.t =
  let t = lh () in
  match t with
  | Tok_Char c -> consume t; Char c
  | Tok_Eps -> consume t; Empty
  | Tok_LParen ->
     consume t;
     let e = parse_U () in
     consume Tok_RParen;
     e
  | _ -> raise (Failure "parse: cannot parse primitive")

(* Conversion Functions *)

(* Converts a string to a regular expression. *)
let regex_of_string (s : string) : Regex.t =
  s |> lex |> parse

(* Converts a string to an NFA. *)
let nfa_of_string (s : string) : ('q, 's) Nfa.nfa =
  s |> regex_of_string |> nfa_of_regex
