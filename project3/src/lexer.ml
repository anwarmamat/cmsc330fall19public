module L = List
module S = String
module R = Str
module C = Char

(* Token type *)

type t =
  | Tok_Char of char
  | Tok_Eps
  | Tok_Union
  | Tok_Star
  | Tok_LParen
  | Tok_RParen
  | Tok_EOF

(* Regular expression and token table. *)
let re = [
  ("E"     , fun _ -> [Tok_Eps]);
  ("[a-z]" , fun x -> [Tok_Char x.[0]]);
  ("|"     , fun _ -> [Tok_Union]);
  ("*"     , fun _ -> [Tok_Star]);
  ("("     , fun _ -> [Tok_LParen]);
  (")"     , fun _ -> [Tok_RParen]);
  (" "     , fun _ -> [])
]

(* Given source code returns a token list. *)
let rec lex (s : string) : t list =
  lex' s 0

(* Helper for lexer takes in a position offset. *)
and lex' (s : string) (pos : int) : t list =
  let matcher (r, _) = R.string_match (R.regexp r) s pos in
  if pos >= S.length s then [Tok_EOF]
  else
    match L.find_opt matcher re with
    | None -> raise (Failure ("lex: " ^ s))
    | Some (_, f) ->
       let s' = R.matched_string s in
       (f s') @ (lex' s (pos + (S.length s')))

(* Returns a string representation of a token list. *)
let rec string_of_tokens (ts : t list) : string =
  S.concat "" (L.map string_of_token ts)

(* Returns string representationof a single token. *)
and string_of_token (t : t) : string =
  match t with
  | Tok_Char c -> C.escaped c
  | Tok_Eps -> "E"
  | Tok_Union -> "|"
  | Tok_Star -> "*"
  | Tok_LParen -> "("
  | Tok_RParen -> ")"
  | Tok_EOF -> ""
