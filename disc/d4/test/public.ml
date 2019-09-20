open OUnit2
open TestUtils
open Disc

let test_find_expensive ctxt =
  assert_equal true (cmp_float 0.0 (find_expensive [])) ~msg:"find_expensive (1)";
  assert_equal true (cmp_float 50.0 (find_expensive [("sofritas", 50.0); ("chicken", 50.0); ("guac", 20.0)])) ~msg:"find_expensive (2)";
  assert_equal true (cmp_float 7.15 (find_expensive [("sofritas", 6.84); ("chicken", 7.15); ("guac", 2.15)])) ~msg:"find_expensive (3)"

let test_sum_list_list ctxt =
  assert_equal 0 (sum_list_list []) ~msg:"sum_list_list (1)" ~printer:string_of_int;
  assert_equal 6 (sum_list_list [[]; [1]; [2; 3]]) ~msg:"sum_list_list (2)" ~printer:string_of_int;
  assert_equal 4 (sum_list_list [[-1; 1]; [-2; 3]; [-5; 8]]) ~msg:"sum_list_list (3)" ~printer:string_of_int

let test_my_map ctxt =
  assert_equal [] (my_map (fun x -> x + 1) []) ~msg:"my_map (1)" ~printer:string_of_int_list;
  assert_equal [2;3;4] (my_map (fun x -> x + 1) [1;2;3]) ~msg:"my_map (2)" ~printer:string_of_int_list;
  assert_equal ["Tide Pods"] (my_map (fun x -> x ^ " Pods") ["Tide"]) ~msg:"my_map (3)" ~printer:string_of_string_list

let suite =
  "public" >::: [
    "find_expensive" >:: test_find_expensive;
    "sum_list_list" >:: test_sum_list_list;
    "my_map" >:: test_my_map
  ]

let _ = run_test_tt_main suite
