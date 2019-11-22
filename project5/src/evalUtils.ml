open SmallCTypes
open Parser
open Lexer

let fmt = Printf.sprintf;;

let map_join s fn lst = List.map fn lst |> String.concat s

(* Buffers for testing prints *)
let (print_buffer : Buffer.t) = Buffer.create 100

(* helper function that combines a list of stmts into a sequence of statements. *)
let make_seq  = List.fold_left (fun a s -> Seq(a, s)) NoOp

let list_to_str lst = "[" ^ String.concat "; " lst ^ "]"

let flush_print_buffer () : unit = Buffer.clear print_buffer;;
let assert_buffer_equal (s : string) : unit =
  let c = Buffer.contents print_buffer in
  if not (s = c) then failwith ("Printed: '" ^ c ^ "' Expected:'" ^ s ^ "'");;

(* This is the print you must use for the project *)
let print_output_string (s : string) : unit =
  Buffer.add_string print_buffer s;
  Pervasives.print_string s

let print_output_int (i : int) : unit =
  print_output_string (string_of_int i)

let print_output_bool (b : bool) : unit =
  print_output_string (string_of_bool b)

let print_output_newline () : unit =
  print_output_string "\n"

let print_ln (s: string): unit = print_output_string s; print_newline ()

(* Parse tools *)
let parse_from_string (input : string) : stmt =
  (* Parse the tokens *)
  input |> tokenize |> parse_top_level

let parse_expr_from_string es =
  parse_expr_wrapper (tokenize es)

let parse_stmt_from_string s =
  parse_stmt_wrapper (tokenize s)

let read_from_file (input_filename : string) : string =
  let read_lines name : string list =
    let ic = open_in name in
    let try_read () =
      try Some (input_line ic) with End_of_file -> None in
    let rec loop acc = match try_read () with
      | Some s -> loop (s :: acc)
      | None -> close_in ic; List.rev acc in
    loop []
  in
  (* Read the file into lines *)
  let prog_lines = read_lines input_filename in
  (* Compress to a single string *)
  List.fold_left (fun a e -> a ^ e) "" prog_lines

(* Open file, read, lex, parse *)
let parse_from_file (input_filename : string) : stmt =
  (* Pass string off *)
  parse_from_string (read_from_file input_filename)

(* Unparser *)

let unparse_data_type (t : data_type) : string = match t with
  | Int_Type -> "Int_Type"
  | Bool_Type -> "Bool_Type"

let rec unparse_expr (e : expr) : string =
  let unparse_two (s : string) (e1 : expr) (e2 : expr) =
    fmt "%s(%s, %s)" s (unparse_expr e1) (unparse_expr e2)
  in

  match e with
  | ID(s) -> "ID \"" ^ s ^ "\""
  | Int(n) -> "Int " ^ string_of_int n
  | Bool(b) -> "Bool " ^ string_of_bool b

  | Add(e1, e2) -> unparse_two "Plus" e1 e2
  | Sub(e1, e2) -> unparse_two "Sub" e1 e2
  | Mult(e1, e2) -> unparse_two "Mult" e1 e2
  | Div(e1, e2) -> unparse_two "Div" e1 e2
  | Pow(e1, e2) -> unparse_two "Pow" e1 e2

  | Equal(e1, e2) -> unparse_two "Equal" e1 e2
  | NotEqual(e1, e2) -> unparse_two "NotEqual" e1 e2

  | Greater(e1, e2) -> unparse_two "Greater" e1 e2
  | Less(e1, e2) -> unparse_two "Less" e1 e2
  | GreaterEqual(e1, e2) -> unparse_two "GreaterEqual" e1 e2
  | LessEqual(e1, e2) -> unparse_two "LessEqual" e1 e2

  | Or(e1, e2) -> unparse_two "Or" e1 e2
  | And(e1, e2) -> unparse_two "And" e1 e2
  | Not(e) -> "Not(" ^ unparse_expr e ^ ")"
  | FunctionCall(n, args) ->
    fmt "FunctionCall(\"%s\", %s)" n  (list_to_str (List.map unparse_expr args))

let rec unparse_stmt (s : stmt) : string = match s with
  | NoOp -> "NoOp"
  | Seq(s1, s2) -> fmt "Seq(%s, %s)" (unparse_stmt s1) (unparse_stmt s2)
  | Declare(t, id) -> fmt "Declare(%s, \"%s\")" (unparse_data_type t) id
  | Assign(id, e) -> fmt "Assign(\"%s\", %s)" id ( unparse_expr e)
  | If(guard, if_body, else_body) ->
    fmt "If(%s, %s, %s)" (unparse_expr guard) (unparse_stmt if_body) (unparse_stmt else_body)
  | While(guard, body) -> fmt "While(%s, %s)" (unparse_expr guard) (unparse_stmt body)
  | Print(e) -> "Print(" ^ unparse_expr e ^ ")"
  | For(str, e1, e2, s) -> fmt "For(\"%s\", %s, %s, %s)" str (unparse_expr e1) (unparse_expr e2) (unparse_stmt s)
  | Return e -> "Return(" ^ unparse_expr e ^ ")"
  | FunctionDecl(name, typ, params, body) ->
    fmt "\nFunctionDecl(\"%s\", %s, %s,\n\t\t%s)" name (unparse_data_type typ) (unparse_func_params params)  (unparse_stmt body)

and unparse_func_params p =
  let params = List.map (fun (s,t) -> "(\"" ^ s ^"\", "^ unparse_data_type t ^ ")") p in
  "["^ String.concat "; " params ^ "]"

let func_to_string (n, (t, p, _)) =
  fmt "%s(%s)->%s" n (unparse_func_params p) (unparse_data_type t)

(* Removes shadowed bindings from an execution environment *)
let prune_env (env : environment) : environment =
  let binds = List.sort_uniq compare (List.map (fun (id, _) -> id) env) in
  List.map (fun e -> (e, List.assoc e env)) binds

let rec val_to_string ?(indent = 0) = function
  | Int_Val(i) -> string_of_int i
  | Bool_Val(b) -> string_of_bool b
  | Thunk_Val(env, expr, typ) -> let i = indent + 2 in
    let spaces = String.make i ' ' in
    fmt "Thunk(\n    %s,\n    %s%s, %s)"  (env_to_string ~indent:i env) spaces (unparse_expr expr) (unparse_data_type typ)

and env_to_string ?(indent = 0) (env: environment): string =
  map_join "\n" (fun (n, v) -> fmt "%s- %s => %s" (String.make (indent) ' ') n (val_to_string ~indent v)) (prune_env env)

(* Eval report print function *)
let print_eval_env_report (env : environment) (funcs) : unit =

  print_string "*** BEGIN POST-EXECUTION ENVIRONMENT REPORT ***\n";
  let funcs_str = String.concat "\n" (List.map func_to_string funcs) in
  print_string ("\nFunctions:\n" ^ funcs_str);
  print_string "\n\nVariables:\n";
  print_string ((env_to_string env) ^ "\n");
  print_string "***  END POST-EXECUTION ENVIRONMENT REPORT  ***\n"
