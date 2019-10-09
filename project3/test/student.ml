open P4.Nfa
open P4.Regexp
open TestUtils
open OUnit2


let test_placeholder ctxt =
  assert_equal true true

let suite =
  "student"
  >::: [ "nfa_new_states" >:: test_placeholder ]

let _ = run_test_tt_main suite
