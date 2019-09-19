open OUnit2
open P2b.Basics
open P2b.Data
open P2b.Funs
open P2b.Higher

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

let test_high_order_1 ctxt =
    (*testing length, split_on and flat_pair*)
  let x = [5.0;6.0;7.0] in
  let y = ["a";"a";"b";"a"] in
  let z = [1;2;3;4;18;6;7;8;9] in
  let b = [] in

  assert_equal (3,4,9) @@ (length x, length y, length z);
  assert_equal ([1;2;3;4], [6;7;8;9]) @@ (split_on 18 z);
  assert_equal ([1;2;3;4], ["a"; "b"; "c"; "d"]) @@
    (flat_pair[(1,2); (3,4)], flat_pair [("a", "b"); ("c", "d") ]);
  assert_equal (0, []) @@ (length b, flat_pair [];);
  assert_equal ([], []) @@ (split_on 1 [])

let test_high_order_2 ctxt =
  (*testing comp and flat_pair*)

  let x = [5;6;7;3] in
  let y = [5;6;7] in
  let z = [7;5] in

  let a = [3;5;8;10;9] in
  let b = [3] in
  let c = [] in

  let fs1 = [((+) 2) ; (( * ) 7)] in
  let fs2 = [pred] in

  let fun_a = map (fun x -> fun e -> x + e) a  in
  let fun_am = map (fun x -> fun y -> x - y ) a in
  let fun_x = map (fun x -> fun y -> x * y) x in

  assert_equal (9, 0) @@ ( comp fs1 1, comp fs2 1 );
  assert_equal [7;8;9;5;35;42;49;21] @@ ap fs1 x;
  assert_equal [7;8;9;35;42;49] @@ ap fs1 y;
  assert_equal [9;7;49;35] @@ ap fs1 z;
  assert_equal [5;7;10;12;11;21;35;56;70;63] @@ ap fs1 a;
  assert_equal [5;21] @@ ap fs1 b;
  assert_equal [] @@ ap fs1 c;

  assert_equal (map pred x) @@ ap fs2 x;
  assert_equal (map pred y) @@ ap fs2 y;
  assert_equal (map pred z) @@ ap fs2 z;
  assert_equal (map pred a) @@ ap fs2 a;
  assert_equal (map pred b) @@ ap fs2 b;
  assert_equal (map pred c) @@ ap fs2 c;

  assert_equal 36 @@ comp fun_a 1;
  assert_equal 5 @@ comp fun_am 0;
  assert_equal (630) @@ comp fun_x 1;
  assert_equal "!?hi there world" @@ comp [(^) "!"; (^) "?"; (^) "hi"; ] " there world"

let test_int_tree ctxt =
  let t0 = empty_int_tree in
  let t1 = (int_insert 3 (int_insert 11 t0)) in
  let t2 = (int_insert 13 t1) in
  let t3 = (int_insert 17 (int_insert 3 (int_insert 1 t2))) in
  let t4 = int_insert_all [11; 3; 13; 1; 3; 17] empty_int_tree in

  assert_equal 0 @@ (int_depth t0);
  assert_equal 2 @@ (int_depth t1);
  assert_equal 2 @@ (int_depth t2);
  assert_equal 3 @@ (int_depth t3);

  assert_equal (true, true, true, true, true) @@ (
      (int_mem  1 t4, int_mem 3 t4, int_mem 11 t4, int_mem 13 t4, int_mem 17 t4)
  )
  (*TODO: int_mirror test cases*)

let test_int_common_1 ctxt =
  let p0 = empty_int_tree in
  let p1 = (int_insert 2 (int_insert 5 p0)) in
  let p3 = (int_insert 10 (int_insert 3 (int_insert 11 p1))) in
  let p4 = (int_insert 15 p3) in
  let p5 = (int_insert 1 p4) in

  assert_equal 5 @@ int_common p5 1 11;
  assert_equal 5 @@ int_common p5 1 10;
  assert_equal 5 @@ int_common p5 2 10;
  assert_equal 2 @@ int_common p5 2 3;
  assert_equal 11 @@ int_common p5 10 11;
  assert_equal 11 @@ int_common p5 11 11

let test_int_common_2 ctxt =
  let q0 = empty_int_tree in
  let q1 = (int_insert 3 (int_insert 8 q0)) in
  let q2 = (int_insert 2 (int_insert 6 q1)) in
  let q3 = (int_insert 12 q2) in
  let q4 = (int_insert 16 (int_insert 9 q3)) in

  assert_equal 3 @@ int_common q4 2 6;
  assert_equal 12 @@ int_common q4 9 16;
  assert_equal 8 @@ int_common q4 2 9;
  assert_equal 8 @@ int_common q4 3 8;
  assert_equal 8 @@ int_common q4 6 8;
  assert_equal 8 @@ int_common q4 12 8;
  assert_equal 8 @@ int_common q4 8 16


let test_ptree_1 ctxt =
  let r0 = empty_ptree Pervasives.compare in
  let r1 = (pinsert 2 (pinsert 1 r0)) in
  let r2 = (pinsert 3 r1) in
  let r3 = (pinsert 5 (pinsert 3 (pinsert 11 r2))) in
  let a = [5;6;8;3;11;7;2;6;5;1]  in
  let x = [5;6;8;3;0] in
  let z = [7;5;6;5;1] in
  let r4a = pinsert_all x r1 in
  let r4b = pinsert_all z r1 in

  let strlen_comp x y = Pervasives.compare (String.length x) (String.length y) in
  let k0 = empty_ptree strlen_comp in
  let k1 = (pinsert "hello" (pinsert "bob" k0)) in
  let k2 = (pinsert "sidney" k1) in
  let k3 = (pinsert "yosemite" (pinsert "ali" (pinsert "alice" k2))) in
  let b = ["hello"; "bob"; "sidney"; "kevin"; "james"; "ali"; "alice"; "xxxxxxxx"] in

  assert_equal [false;false;false;false;false;false;false;false;false;false] @@ map (fun y -> pmem y r0) a;
  assert_equal [false;false;false;false;false;false;true;false;false;true] @@ map (fun y -> pmem y r1) a;
  assert_equal [false;false;false;true;false;false;true;false;false;true] @@ map (fun y -> pmem y r2) a;
  assert_equal [true;false;false;true;true;false;true;false;true;true] @@ map (fun y -> pmem y r3) a;

  assert_equal [false;false;false;false;false;false;false;false] @@ map (fun y -> pmem y k0) b;
  assert_equal [true;true;false;true;true;true;true;false] @@ map (fun y -> pmem y k1) b;
  assert_equal [true;true;true;true;true;true;true;false] @@ map (fun y -> pmem y k2) b;
  assert_equal [true;true;true;true;true;true;true;true] @@ map (fun y -> pmem y k3) b;

  assert_equal [true;true;true;true;true] @@ map (fun y -> pmem y r4a) x;
  assert_equal [true;true;false;false;false] @@ map (fun y -> pmem y r4b) x;
  assert_equal [false;true;true;true;true] @@ map (fun y -> pmem y r4a) z;
  assert_equal [true;true;true;true;true] @@ map (fun y -> pmem y r4b) z

let test_ptree_2 ctxt =
  let q0 = empty_ptree Pervasives.compare in
  let q1 = pinsert 1 (pinsert 2 (pinsert 0 q0)) in
  let q2 = pinsert 5 (pinsert 11 (pinsert (-1) q1)) in
  let q3 = pinsert (-7) (pinsert (-3) (pinsert 9 q2)) in
  let f = (fun x -> x + 10) in
  let g = (fun y -> y * (-1)) in

  assert_equal [] @@ p_as_list q0;
  assert_equal [0;1;2] @@ p_as_list q1;
  assert_equal [-1;0;1;2;5;11] @@ p_as_list q2;
  assert_equal [-7;-3;-1;0;1;2;5;9;11] @@ p_as_list q3;

  assert_equal [] @@ p_as_list (pmap f q0);
  assert_equal [10;11;12] @@ p_as_list (pmap f q1);
  assert_equal [9;10;11;12;15;21] @@ p_as_list (pmap f q2);
  assert_equal [3;7;9;10;11;12;15;19;21] @@ p_as_list (pmap f q3);

  assert_equal [] @@ p_as_list (pmap g q0);
  assert_equal [-2;-1;0] @@ p_as_list (pmap g q1);
  assert_equal [-11;-5;-2;-1;0;1] @@ p_as_list (pmap g q2);
  assert_equal [-11;-9;-5;-2;-1;0;1;3;7] @@ p_as_list (pmap g q3)

let test_graph_1 ctxt =
  let g = add_edges
      [ { src = 1; dst = 2; };
        { src = 2; dst = 3; };
        { src = 3; dst = 4; };
        { src = 4; dst = 5; } ] empty_graph in
  let g2 = add_edges
      [ { src = 1; dst = 2; };
        { src = 3; dst = 4; };
        { src = 4; dst = 3; } ] empty_graph in
  let g3 = add_edges
      [ { src = 1; dst = 2; };
        { src = 1; dst = 3; };
        { src = 3; dst = 2; };
        { src = 2; dst = 1; } ] empty_graph in

  assert_equal true @@ graph_empty empty_graph;
  assert_equal false @@ graph_empty g;
  assert_equal false @@ graph_empty g2;

  assert_equal 0 @@ graph_size empty_graph;
  assert_equal 5 @@ graph_size g;
  assert_equal 4 @@ graph_size g2;
  assert_equal 3 @@ graph_size g3

let test_graph_2 ctxt =
  let p = add_edges
      [ { src = 1; dst = 2; };
        { src = 2; dst = 3; };
        { src = 3; dst = 4; };
        { src = 4; dst = 5; } ] empty_graph in
  let p2 = add_edges
      [ { src = 1; dst = 2; };
        { src = 3; dst = 4; };
        { src = 4; dst = 3; } ] empty_graph in
  let p3 = add_edges
      [ { src = 1; dst = 2; };
        { src = 1; dst = 3; };
        { src = 3; dst = 2; };
        { src = 2; dst = 1; } ] empty_graph in

  assert_equal [2] @@ (map (fun { dst = d } -> d) (src_edges 1 p));
  assert_equal [3] @@ (map (fun { dst = d } -> d) (src_edges 2 p));
  assert_equal [] @@ (map (fun { dst = d } -> d) (src_edges 5 p));
  assert_equal [2] @@ (map (fun { dst = d } -> d) (src_edges 1 p2));
  assert_equal [] @@ (map (fun { dst = d } -> d) (src_edges 2 p2));
  assert_equal [4] @@ (map (fun { dst = d } -> d) (src_edges 3 p2));
  assert_equal [1] @@ (map (fun { dst = d } -> d) (src_edges 2 p3));
  assert_equal [] @@ (map (fun { dst = d } -> d) (src_edges 4 p3));
  assert_equal (List.sort compare [2;3]) @@ (List.sort compare (map (fun { dst = d } -> d) (src_edges 1 p3)));

  assert_equal [true] @@ (map (fun e -> is_dst 2 e) (src_edges 1 p));
  assert_equal [true] @@ (map (fun e -> is_dst 2 e) (src_edges 1 p2));
  assert_equal (List.sort compare [true;false]) @@ (List.sort compare (map (fun e -> is_dst 2 e) (src_edges 1 p3)))

let suite =
  "public" >::: [
    "var" >:: test_var;
    "scopes" >:: test_scopes;
    "hgh_odr_1" >:: test_high_order_1;
    "hgh_odr_2" >:: test_high_order_2;
    "int_tree"  >:: test_int_tree;
    "common_1"  >:: test_int_common_1;
    "common_2"  >:: test_int_common_2;
    "ptree_1"   >:: test_ptree_1;
    "ptree_2"   >:: test_ptree_2;
    "graph_1"   >:: test_graph_1;
    "graph_2"   >:: test_graph_2
  ]

let _ = run_test_tt_main suite
