open OUnit2
open P2b.Basics
open P2b.Data
open P2b.Funs
open P2b.Higher

(* NOTE: if you add tests here, make sure you add them to the suite below. *)

let test_sanity ctxt = 
  assert_equal 1 1

let test_sanity2 ctxt = 
  assert_equal 2 2

let suite =
  "student" >::: [
    "sanity1" >:: test_sanity; (* Note the semicolon separating each line *)
    "sanity2" >:: test_sanity2
  ]

let _ = run_test_tt_main suite
