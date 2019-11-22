open OUnit2
open P5.EvalUtils
open P5.Eval
open P5.SmallCTypes
open P5.Utils
open P5.Lexer
open P5.Parser

(* Assertion wrappers for convenience and readability *)
let assert_true b = assert_equal true b
let assert_false b = assert_equal false b
let assert_succeed () = assert_true true

(* Constants pertaining to error case tests *)
let stmt_env : environment = [("x", Int_Val(1)); ("p", Bool_Val(false))]
let expr_env : environment = stmt_env @ [("y", Int_Val(6)); ("q", Bool_Val(true))]

let equiv_environments (xs : environment) (ys : environment) : bool =
  (prune_env xs) = (prune_env ys)

let assert_stmt_success
    ?output:(output="")
    (env : environment)
    (finEnv : environment)
    (es : stmt) : unit =

  flush_print_buffer ();
  assert_true (equiv_environments (eval_stmt env es) finEnv);
  assert_buffer_equal output

let create_system_test
    ?output:(output="")
    (env : environment)
    (finEnv : environment)
    (es : stmt) : (test_ctxt -> unit) =
  (fun _ -> assert_stmt_success env finEnv es  ~output:output; reset_funcs ())

let type_handler f =
  try
    let _ = f () in assert_failure "Expected TypeError, none received" with
  | TypeError(_) -> assert_succeed ()
  | ex -> assert_failure ("Got " ^ (Printexc.to_string ex) ^ ", expected TypeError")

let declaration_handler f =
  try
    let _ = f () in assert_failure "Expected DeclareError, none received" with
  | DeclareError(_) -> assert_succeed ()
  | ex -> assert_failure ("Got " ^ (Printexc.to_string ex) ^ ", expected DeclareError")

let div_by_zero_handler f =
  try
    let _ = f () in assert_failure "Expected DivByZeroError, none received" with
  | DivByZeroError -> assert_succeed ()
  | ex -> assert_failure ("Got " ^ (Printexc.to_string ex) ^ ", expected DivByZeroError")

type expected_exception = TypeExpect | DeclareExpect | DivByZeroExpect

let assert_eval_fail env e expect eval_fun =
  let expect_function = begin match expect with
    | TypeExpect -> type_handler
    | DeclareExpect -> declaration_handler
    | DivByZeroExpect -> div_by_zero_handler
  end in
  expect_function (fun () -> eval_fun env e)

let assert_expr_fail ?expect:(expect=TypeExpect) env es =
  assert_eval_fail env es expect eval_expr

let assert_stmt_fail ?expect:(expect=TypeExpect) env smt =
  assert_eval_fail env smt expect eval_stmt

(* Test utilities from P4a *)
(* let input_handler f =
   try
    let _ = f () in assert_failure "Expected InvalidInputException, none received" with
   | InvalidInputException(_) -> assert_succeed ()
   | ex -> assert_failure ("Got " ^ (Printexc.to_string ex) ^ ", expected InvalidInputException") *)

let assert_ast_equal
    (es : string)
    (output : stmt) : unit =
  let toks = tokenize_from_file es in
  let ast = parse_top_level toks in
  assert_equal ast output

let create_system_test_parse
    (es : string list)
    (output : stmt) : (test_ctxt -> unit) =
  (fun ctx -> assert_ast_equal (in_testdata_dir ctx es) output)

let create_system_test_eval
  ?output:(output="")
  (es : string list)
  (finEnv : environment) : (test_ctxt -> unit) =
(fun ctx -> reset_funcs (); assert_stmt_success [] finEnv (parse_from_file (in_testdata_dir ctx es)) ~output:output)


