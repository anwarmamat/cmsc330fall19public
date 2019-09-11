open OUnit2
open Basics

let test_rev_tup ctxt =
  assert_equal (1, 2, 3) (rev_tup (3, 2, 1)) ~msg:"rev_tup (1)";
  assert_equal (3, 2, 1) (rev_tup (1, 2, 3)) ~msg:"rev_tup (2)";
  assert_equal (3, 1, 1) (rev_tup (1, 1, 3)) ~msg:"rev_tup (3)";
  assert_equal (1, 1, 1) (rev_tup (1, 1, 1)) ~msg:"rev_tup (4)"

let test_max_tup ctxt =
  assert_equal 3 (max_tup (1, 2, 3)) ~msg:"max_tup (1)";
  assert_equal 3 (max_tup (3, 2, 1)) ~msg:"max_tup (2)"

let test_abs ctxt =
  assert_equal 1 (abs 1) ~msg:"abs (1)";
  assert_equal 1 (abs (-1)) ~msg:"abs (2)";
  assert_equal 13 (abs 13) ~msg:"abs (3)";
  assert_equal 13 (abs (-13)) ~msg:"abs (4)"

let test_area ctxt =
  assert_equal 1 (area (1, 1) (2, 2)) ~msg:"area (1)";
  assert_equal 2 (area (1, 1) (2, 3)) ~msg:"area (2)";
  assert_equal 2 (area (1, 1) (3, 2)) ~msg:"area (3)";
  assert_equal 4 (area (1, 1) (3, 3)) ~msg:"area (4)"

let test_volume ctxt =
  assert_equal 1 (volume (1, 1, 1) (2, 2, 2)) ~msg:"volume (1)";
  assert_equal 4 (volume (1, 1, 1) (2, 3, 3)) ~msg:"volume (2)";
  assert_equal 4 (volume (1, 1, 1) (3, 2, 3)) ~msg:"volume (3)";
  assert_equal 4 (volume (1, 1, 1) (3, 3, 2)) ~msg:"volume (4)";
  assert_equal 8 (volume (1, 1, 1) (3, 3, 3)) ~msg:"volume (5)"

let test_equiv_frac ctxt =
  assert_equal true (equiv_frac (1, 2) (2, 4)) ~msg:"equiv_frac (1)";
  assert_equal true (equiv_frac (2, 4) (1, 2)) ~msg:"equiv_frac (2)";
  assert_equal true (equiv_frac (1, 2) (1, 2)) ~msg:"equiv_frac (3)";
  assert_equal true (equiv_frac (3, 6) (2, 4)) ~msg:"equiv_frac (4)";
  assert_equal false (equiv_frac (1, 3) (2, 5)) ~msg:"equiv_frac (5)";
  assert_equal false (equiv_frac (10, 30) (4, 6)) ~msg:"equiv_frac (6)";
  assert_equal false (equiv_frac (999999999, 1000000000) (999999998, 1000000000)) ~msg:"equiv_frac(7)"

let test_factorial ctxt =
  assert_equal 1 (factorial 1) ~msg:"factorial (1)";
  assert_equal 2 (factorial 2) ~msg:"factorial (2)";
  assert_equal 6 (factorial 3) ~msg:"factorial (3)";
  assert_equal 120 (factorial 5) ~msg:"factorial (4)"

let test_pow ctxt =
  assert_equal 2 (pow 2 1) ~msg:"pow (1)";
  assert_equal 4 (pow 2 2) ~msg:"pow (2)";
  assert_equal 3 (pow 3 1) ~msg:"pow (3)";
  assert_equal 27 (pow 3 3) ~msg:"pow (4)";
  assert_equal 625 (pow 5 4) ~msg:"pow (5)";
  assert_equal (-27) (pow (-3) 3) ~msg:"pow (6)"

let test_tail ctxt =
  assert_equal 5 (tail 125 1) ~msg:"tail (1)";
  assert_equal 25 (tail 125 2) ~msg:"tail (2)";
  assert_equal 125 (tail 125125 3) ~msg:"tail (3)"

let test_log ctxt =
  assert_equal 1 (log 4 4) ~msg:"log (1)";
  assert_equal 2 (log 4 16) ~msg:"log (2)";
  assert_equal 3 (log 4 64) ~msg:"log (3)"

let test_len ctxt =
  assert_equal 1 (len 4) ~msg:"len (1)";
  assert_equal 3 (len 330) ~msg:"len (2)";
  assert_equal 4 (len 1000) ~msg:"len (3) ";
  assert_equal 6 (len 100000) ~msg:"len (4)"

let test_contains ctxt =
  assert_equal false (contains 4 5) ~msg:"contains (1)";
  assert_equal true (contains 30 330) ~msg:"contains (2)";
  assert_equal false (contains 200 10020) ~msg:"contains (3)";
  assert_equal true (contains 10001 100010) ~msg:"contains (4)";
  assert_equal false (contains 100010 10001) ~msg:"contains (5)"

let test_var ctxt =
  let t = push_scope (empty_table ()) in
  let t = add_var "x" 3 t in
  let t = add_var "y" 4 t in
  let t = add_var "asdf" 14 t in
  assert_equal 3 (lookup "x" t) ~msg:"test_var (1)";
  assert_equal 4 (lookup "y" t) ~msg:"test_var (2)";
  assert_equal 14 (lookup "asdf" t) ~msg:"test_var (3)";
  assert_raises (Failure ("Variable not found!")) (fun () -> lookup "z" t) ~msg:"test_var (2)"

let test_scopes ctxt =
  let a = push_scope (empty_table ()) in
  let a = add_var "a" 10 a in
  let a = add_var "b" 40 a in
  let b = push_scope a in
  let b = add_var "a" 20 b in
  let b = add_var "c" 30 b in
  let c = pop_scope b in
  assert_equal 10 (lookup "a" c) ~msg:"test_scopes (1)";
  assert_equal 40 (lookup "b" c) ~msg:"test_scopes (2)";
  assert_equal 20 (lookup "a" b) ~msg:"test_scopes (3)";
  assert_equal 30 (lookup "c" b) ~msg:"test_scopes (4)";
  assert_raises (Failure ("Variable not found!")) (fun () -> lookup "c" c) ~msg:"test_scopes (5)"

let suite =
  "public" >::: [
    "rev_tup" >:: test_rev_tup;
    "max_tup" >:: test_max_tup;
    "abs" >:: test_abs;
    "area" >:: test_area;
    "volume" >:: test_volume;
    "equiv_frac" >:: test_equiv_frac;
    "factorial" >:: test_factorial;
    "pow" >:: test_pow;
    "tail" >:: test_tail;
    "log" >:: test_log;
    "len" >:: test_len;
    "contains" >:: test_contains;
    "var" >:: test_var;
    "scopes" >:: test_scopes
  ]

let _ = run_test_tt_main suite
