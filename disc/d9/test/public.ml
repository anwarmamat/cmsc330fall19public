open OUnit2
open Disc.Lexer
open Disc.Parser
open Disc.Interpreter

let test_lex_empty ctxt =
  assert_equal [Tok_EOF] (lexer " ")

let test_lex_one ctxt =
  assert_equal [Tok_Int 1; Tok_EOF] (lexer "1")

let test_lex_one_plus_two ctxt =
  assert_equal [Tok_Int 1; Tok_Plus; Tok_Int 2; Tok_EOF] (lexer "1+   2")

let test_lex_one_times_two ctxt =
  assert_equal [Tok_Int 1; Tok_Mult; Tok_Int 2; Tok_EOF] (lexer "1 * 2")

let test_long_lexer_1 ctxt =
  assert_equal [Tok_Int 1; Tok_Mult; Tok_Int 2; Tok_Plus; Tok_Int 3; Tok_EOF] (lexer "1*2+3")

let test_long_lexer_2 ctxt =
  assert_equal [Tok_Int 1; Tok_Plus; Tok_Int 2; Tok_Mult; Tok_Int 3; Tok_EOF] (lexer "1+  2 *3")

let test_long_lexer_3 ctxt =
  assert_equal [Tok_Int 1; Tok_Mult; Tok_LParen; Tok_Int 2; Tok_Plus; Tok_Int 3; Tok_RParen; Tok_EOF] (lexer "1 * (2 + 3)")

let test_long_lexer_4 ctxt =
  assert_equal [Tok_LParen; Tok_Int 1; Tok_Plus; Tok_Int 2; Tok_RParen; Tok_Mult; Tok_Int 3; Tok_EOF] (lexer "(1 + 2) * 3")

let test_parse_one ctxt =
  assert_equal (Int 1) (parser [Tok_Int 1; Tok_EOF])

let test_parse_one_plus_two ctxt =
  assert_equal (Plus (Int 1, Int 2)) (parser [Tok_Int 1; Tok_Plus; Tok_Int 2; Tok_EOF])

let test_parse_one_times_two ctxt =
  assert_equal (Mult (Int 1, Int 2)) (parser [Tok_Int 1; Tok_Mult; Tok_Int 2; Tok_EOF])

let test_long_parser_1 ctxt =
  assert_equal (Plus (Mult (Int 1, Int 2), Int 3)) (parser [Tok_Int 1; Tok_Mult; Tok_Int 2; Tok_Plus; Tok_Int 3; Tok_EOF])

let test_long_parser_2 ctxt =
  assert_equal (Plus (Int 1, Mult (Int 2, Int 3))) (parser [Tok_Int 1; Tok_Plus; Tok_Int 2; Tok_Mult; Tok_Int 3; Tok_EOF])

let test_long_parser_3 ctxt =
  assert_equal (Mult (Int 1, Plus (Int 2, Int 3))) (parser [Tok_Int 1; Tok_Mult; Tok_LParen; Tok_Int 2; Tok_Plus; Tok_Int 3; Tok_RParen; Tok_EOF])

let test_long_parser_4 ctxt =
  assert_equal (Mult (Plus (Int 1, Int 2), Int 3)) (parser [Tok_LParen; Tok_Int 1; Tok_Plus; Tok_Int 2; Tok_RParen; Tok_Mult; Tok_Int 3; Tok_EOF])

let test_right_associative ctxt =
  assert_equal (Plus (Int 1, Plus (Int 2, Int 3))) (parser [Tok_Int 1; Tok_Plus; Tok_Int 2; Tok_Plus; Tok_Int 3; Tok_EOF])

let test_parentheses ctxt =
  assert_equal (Plus (Plus (Int 1, Int 2), Int 3)) (parser [Tok_LParen; Tok_Int 1; Tok_Plus; Tok_Int 2; Tok_RParen; Tok_Plus; Tok_Int 3; Tok_EOF])

let test_one_interpreter ctxt =
  assert_equal 1 (eval (Int 1))

let test_one_plus_two_interpreter ctxt =
  assert_equal 3 (eval (Plus (Int 1, Int 2)))

let test_long_interpreter_1 ctxt =
  assert_equal 6 (eval (Plus (Int 1, Plus (Int 2, Int 3))))

let test_long_interpreter_2 ctxt =
  assert_equal 6 (eval (Plus (Plus (Int 1, Int 2), Int 3)))

let test_long_interpreter_3 ctxt =
  assert_equal 6 (eval (Mult (Mult (Int 1, Int 2), Int 3)))

let test_long_interpreter_4 ctxt =
  assert_equal 12 (eval (Plus (Mult (Plus (Int 1, Int 2), Int 3), Int 3)))

let test_long_interpreter_5 ctxt =
  assert_equal 21 (eval (Mult (Plus (Mult (Int 3, Int 2), Int 1), Int 3)))

let suite =
  "public" >::: [
    "lex_empty" >:: test_lex_empty;
    "lex_one" >:: test_lex_one;
    "lex_one_plus_two" >:: test_lex_one_plus_two;
    "lex_one_times_two" >:: test_lex_one_times_two;
    "long_lexer_1" >:: test_long_lexer_1;
    "long_lexer_2" >:: test_long_lexer_2;
    "long_lexer_3" >:: test_long_lexer_3;
    "long_lexer_4" >:: test_long_lexer_4;
    "parse_one" >:: test_parse_one;
    "parse_one_plus_two" >:: test_parse_one_plus_two;
    "parse_one_times_two" >:: test_parse_one_times_two;
    "long_parser_1" >:: test_long_parser_1;
    "long_parser_2" >:: test_long_parser_2;
    "long_parser_3" >:: test_long_parser_3;
    "long_parser_4" >:: test_long_parser_4;
    "right_associative" >::  test_right_associative;
    "parentheses" >:: test_parentheses;
    "one_interpreter" >:: test_one_interpreter;
    "one_plus_two_interpreter" >:: test_one_plus_two_interpreter;
    "long_interpreter_1" >:: test_long_interpreter_1;
    "long_interpreter_2" >:: test_long_interpreter_2;
    "long_interpreter_3" >:: test_long_interpreter_3;
    "long_interpreter_4" >:: test_long_interpreter_4;
    "long_interpreter_5" >:: test_long_interpreter_5
  ]

let _ = run_test_tt_main suite
