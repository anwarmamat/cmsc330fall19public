open OUnit2
open Exercise

let setup = 
    let open ListStack in 
        let s = new_stack in
        let s = push s 5 in
        let s = push s 6 in 
        let s = push s 7 in
        s

let rec push_values_on_stack stack values =
    let open ListStack in
        match values with
            |[] -> stack
            |h::t -> push_values_on_stack (push h) t
            
let test_push stack = 
    let open ListStack in
        assert_equal 8 (peek (push stack 8));
        assert_equal 9 (peek (push (push stack 8) 9))

let test_pop stack = 
    let open ListStack in
        let (top1, stack) = pop stack in 
        let (top2, stack) = pop stack in
        let (top3, stack) = pop stack in
        assert_equal 7 top1;
        assert_equal 6 top2;
        assert_equal 5 top3;
        assert_raises EmptyStack (fun () -> (pop stack))


let test_peek_raises_exception =
    let open ListStack in
        let stack = new_stack in
        assert_raises ListStack.EmptyStack (fun () -> (peek stack))

let test_contains_and_insert = 
    let open StringBinaryTree in
        assert_equal false (contains new_tree "hi");
        assert_equal true (contains (insert new_tree "hi") "hi");
        assert_equal false (contains (insert new_tree "hey") "hi")
    
let suite = 
  "Test ListStack" >::: [
    "test_top" >::
    (fun _ ->
        let stack = setup in
       test_push stack);
    "test_pop" >::
    (fun _ ->
        let stack = setup in
        test_pop stack);
    "test_peek_raises_exception" >::
    (fun _ -> test_peek_raises_exception);
    "test_contais" >::
    (fun _ -> test_contains_and_insert)
  ]

let () =
  run_test_tt_main suite