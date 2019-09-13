open OUnit2
open Disc3

let string_of_list f xs =
  "[" ^ (String.concat "; " (List.map f xs)) ^ "]"
let string_of_int_list = string_of_list string_of_int

let test_fact ctxt =
  assert_equal 1 (fact 1) ~msg:"fact (1)" ~printer:string_of_int;
  assert_equal 120 (fact 5) ~msg:"fact (2)" ~printer:string_of_int;
  assert_equal 720 (fact 6) ~msg:"fact (3)" ~printer:string_of_int

let test_unary ctxt =
  assert_equal "" (unary 0) ~msg:"unary (1)" ~printer:(fun x -> x);
  assert_equal "1" (unary 1) ~msg:"unary (2)" ~printer:(fun x -> x);
  assert_equal "1111111" (unary 7) ~msg:"unary (3)" ~printer:(fun x -> x)

let test_sum_digits ctxt =
  assert_equal 0 (sum_digits 0) ~msg:"sum_digits (1)" ~printer:string_of_int;
  assert_equal 3 (sum_digits 120) ~msg:"sum_digits (2)" ~printer:string_of_int;
  assert_equal 12 (sum_digits 129) ~msg:"sum_digits (3)" ~printer:string_of_int;
  assert_equal 15 (sum_digits 12345) ~msg:"sum_digits (4)" ~printer:string_of_int

let test_sum ctxt =
  assert_equal true (cmp_float 0.0 (sum [])) ~msg:"sum (1)" ~printer:string_of_bool;
  assert_equal true (cmp_float 1.0 (sum [1.0])) ~msg:"sum (2)" ~printer:string_of_bool;
  assert_equal true (cmp_float 10.0 (sum [1.0; 2.0; 3.0; 4.0])) ~msg:"sum (3)" ~printer:string_of_bool;
  assert_equal true (cmp_float 19.8 (sum [9.8; 5.55; 4.45])) ~msg:"sum (4)" ~printer:string_of_bool

let test_add_to_list ctxt =
  assert_equal [] (add_to_list [] 10) ~msg:"add_to_list (1)" ~printer:string_of_int_list;
  assert_equal [2] (add_to_list [-1] 3) ~msg:"add_to_list (2)" ~printer:string_of_int_list;
  assert_equal [5; 7] (add_to_list [1; 3] 4) ~msg:"add_to_list (3)" ~printer:string_of_int_list;
  assert_equal [10; 20; 30; 40] (add_to_list [0; 10; 20; 30] 10) ~msg:"add_to_list (4)" ~printer:string_of_int_list

let test_remove_all_greater ctxt =
  assert_equal [] (remove_all_greater [] 1) ~msg:"remove_all_greater (1)" ~printer:string_of_int_list;
  assert_equal [] (remove_all_greater [1; 2; 3] 0) ~msg:"remove_all_greater (2)" ~printer:string_of_int_list;
  assert_equal [2] (remove_all_greater [2] 3) ~msg:"remove_all_greater (3)" ~printer:string_of_int_list;
  assert_equal [2; 1] (remove_all_greater [2; 4; 6; 1; 8] 3) ~msg:"remove_all_greater (4)" ~printer:string_of_int_list;
  assert_equal [2; 3; 1; 4; 5] (remove_all_greater [2; 3; 6; 9; 10; 1; 11; 4; 7; 5; 8; 12] 5) ~msg:"remove_all_greater (5)" ~printer:string_of_int_list

let suite =
  "disc3" >::: [
    "fact" >:: test_fact;
    "unary" >:: test_unary;
    "sum_digits" >:: test_sum_digits;
    "sum" >:: test_sum;
    "add_to_list" >:: test_add_to_list;
    "remove_all_greater" >:: test_remove_all_greater
  ]

let _ = run_test_tt_main suite
