open OUnit2
open D5.Disc

let test_rev_list ctxt =
  assert_equal [1; 2] @@ rev_list [2; 1];
  assert_equal [] @@ rev_list [];
  assert_equal [3; 2; 1; 5; 6] @@ rev_list [6; 5; 1; 2; 3];
  assert_equal [3; 2; 1] @@ rev_list [1; 2; 3]

let test_sq_sum ctxt =
  assert_equal 0 @@ sq_sum [];
  assert_equal 1 @@ sq_sum [1];
  assert_equal 5 @@ sq_sum [1;2];
  assert_equal 14 @@ sq_sum [1;2;3]

let test_append ctxt =
  let xs = ["a"; "b"; "c"; "d"] in
  assert_equal xs @@ append [] xs;
  assert_equal xs @@ append ["a"] ["b"; "c"; "d"];
  assert_equal xs @@ append ["a"; "b"] ["c"; "d"];
  assert_equal xs @@ append ["a"; "b"; "c"] ["d"];
  assert_equal xs @@ append xs [];
  assert_equal [] @@ append [] [];
  assert_equal [1; 2] @@ append [1; 2] [];
  assert_equal [1; 2] @@ append [] [1; 2];
  assert_equal [1; 2] @@ append [1] [2];
  assert_equal [1; 2; 3; 4] @@ append [1; 2] [3; 4]

let test_filter ctxt =
  let t = fun x -> true in
  let f = fun x -> false in
  let even = fun x -> (x mod 2) = 0 in

  let xs = [1; 2; 3; 4] in
  assert_equal [] @@ filter t [];
  assert_equal xs @@ filter t xs;
  assert_equal [] @@ filter f xs;
  assert_equal [2; 4] @@ filter even xs

let suite =
  "public" >::: [
    "rev_list" >:: test_rev_list;
    "sq_sum"   >:: test_sq_sum;
    "append"   >:: test_append;
    "filter"   >:: test_filter
  ]

let _ = run_test_tt_main suite
