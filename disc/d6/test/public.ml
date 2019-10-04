open OUnit2
open Disc

let test_full_names ctxt =
  assert_equal [] (full_names []);
  assert_equal ["Anwar Mamat"; "Michael William Hicks"] (full_names [{ first = "Anwar"; middle = None; last = "Mamat" }; { first = "Michael"; middle = Some "William"; last = "Hicks" }])
;;

let suite =
  "public" >::: [
    "full_names" >:: test_full_names;
  ]

let _ = run_test_tt_main suite
