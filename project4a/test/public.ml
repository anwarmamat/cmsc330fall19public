open OUnit2
open P4a.SmallCTypes
open TestUtils
open P4a.TokenTypes

let test_assign1 = create_system_test ["public"; "assign1.c"]
  (Seq(Declare(Int_Type, "a"), Seq(Assign("a", Int 100), NoOp)))
let test_assign_exp = create_system_test ["public"; "assign-exp.c"]
  (Seq(Declare(Int_Type, "a"), Seq(Assign("a", Mult(Int 100, ID "a")), Seq(Print(ID "a"), NoOp))))
let test_define_1 = create_system_test ["public"; "define1.c"]
  (Seq(Declare(Int_Type, "a"), NoOp))
let test_equal = create_system_test ["public"; "equal.c"]
  (Seq(Declare(Int_Type, "a"), Seq(Assign("a", Int 100), Seq(If(Equal(ID "a", Int 100), Seq(Assign("a", Int 200), Seq(Print(ID "a"), NoOp)), NoOp), NoOp))))
let test_exp_1 = create_system_test ["public"; "exp1.c"]
  (Seq(Declare(Int_Type, "a"), Seq(Assign("a", Add(Int 2, Mult(Int 5, Pow(Int 4, Int 3)))), Seq(Print(ID "a"), NoOp))))
let test_exp_2 = create_system_test ["public"; "exp2.c"]
  (Seq(Declare(Int_Type, "a"), Seq(Assign("a", Add(Int 2, Pow(Mult(Int 5, Int 4), Int 3))), Seq(Print(ID "a"), NoOp))))
let test_greater = create_system_test ["public"; "greater.c"]
  (Seq(Declare(Int_Type, "a"), Seq(Assign("a", Int 100), Seq(If(Greater(ID "a", Int 10), Seq(Assign("a", Int 200), Seq(Print(ID "a"), NoOp)), NoOp), NoOp))))
let test_if = create_system_test ["public"; "if.c"]
  (Seq(Declare(Int_Type, "a"), Seq(Assign("a", Int 100), Seq(If(Greater(ID "a", Int 10), Seq(Assign("a", Int 200), NoOp), NoOp), NoOp))))
let test_ifelse = create_system_test ["public"; "ifelse.c"]
  (Seq(Declare(Int_Type, "a"), Seq(Assign("a", Int 100), Seq(If(Greater(ID "a", Int 10), Seq(Assign("a", Int 200), NoOp), Seq(Assign("a", Int 300), NoOp)), NoOp))))
let test_if_else_while = create_system_test ["public"; "if-else-while.c"]
  (Seq(Declare(Int_Type, "a"), Seq(Assign("a", Int 100), Seq(Declare(Int_Type, "b"), Seq(If(Greater(ID "a", Int 10), Seq(Assign("a", Int 200), NoOp), Seq(Assign("b", Int 10), Seq(While(Less(Mult(ID "b", Int 2), ID "a"), Seq(Assign("b", Add(ID "b", Int 2)), Seq(Print(ID "b"), NoOp))), Seq(Assign("a", Int 300), NoOp)))), NoOp)))))
let test_less = create_system_test ["public"; "less.c"]
  (Seq(Declare(Int_Type, "a"), Seq(Assign("a", Int 100), Seq(If(Less(ID "a", Int 200), Seq(Assign("a", Int 200), Seq(Print(ID "a"), NoOp)), NoOp), NoOp))))
let test_main = create_system_test ["public"; "main.c"]
  NoOp
let test_nested_if = create_system_test ["public"; "nested-if.c"]
  (Seq(Declare(Int_Type, "a"), Seq(Assign("a", Int 100), Seq(If(Greater(ID "a", Int 10), Seq(Assign("a", Int 200), Seq(If(Less(ID "a", Int 20), Seq(Assign("a", Int 300), NoOp), Seq(Assign("a", Int 400), NoOp)), NoOp)), NoOp), NoOp))))
let test_nested_ifelse = create_system_test ["public"; "nested-ifelse.c"]
  (Seq(Declare(Int_Type, "a"), Seq(Assign("a", Int 100), Seq(If(Greater(ID "a", Int 10), Seq(Assign("a", Int 200), Seq(If(Less(ID "a", Int 20), Seq(Assign("a", Int 300), NoOp), Seq(Assign("a", Int 400), NoOp)), NoOp)), Seq(Assign("a", Int 500), NoOp)), NoOp))))
let test_nested_while = create_system_test ["public"; "nested-while.c"]
  (Seq(Declare(Int_Type, "i"), Seq(Declare(Int_Type, "j"), Seq(Assign("i", Int 1), Seq(Declare(Int_Type, "sum"), Seq(Assign("sum", Int 0), Seq(While(Less(ID "i", Int 10), Seq(Assign("j", Int 1), Seq(While(Less(ID "j", Int 10), Seq(Assign("sum", Add(ID "sum", ID "j")), Seq(Assign("j", Add(ID "j", Int 1)), NoOp))), Seq(Assign("i", Add(ID "i", Int 1)), NoOp)))), NoOp)))))))
let test_print = create_system_test ["public"; "print.c"]
  (Seq(Declare(Int_Type, "a"), Seq(Assign("a", Int 100), Seq(Print(ID "a"), NoOp))))
let test_test1 = create_system_test ["public"; "test1.c"]
  (Seq(Declare(Int_Type, "a"), Seq(Assign("a", Int 10), Seq(Declare(Int_Type, "b"), Seq(Assign("b", Int 1), Seq(Declare(Int_Type, "sum"), Seq(Assign("sum", Int 0), Seq(While(Less(ID "b", ID "a"), Seq(Assign("sum", Add(ID "sum", ID "b")), Seq(Assign("b", Add(ID "b", Int 1)), Seq(Print(ID "sum"), Seq(If(Greater(ID "a", ID "b"), Seq(Print(Int 10), NoOp), Seq(Print(Int 20), NoOp)), Seq(Print(ID "sum"), NoOp)))))), NoOp))))))))
let test_test2 = create_system_test ["public"; "test2.c"]
  (Seq(Declare(Int_Type, "a"), Seq(Assign("a", Int 10), Seq(Declare(Int_Type, "b"), Seq(Assign("b", Int 20), Seq(Declare(Int_Type, "c"), Seq(If(Less(ID "a", ID "b"), Seq(If(Less(Pow(ID "a", Int 2), Pow(ID "b", Int 3)), Seq(Print(ID "a"), NoOp), Seq(Print(ID "b"), NoOp)), NoOp), Seq(Assign("c", Int 1), Seq(While(Less(ID "c", ID "a"), Seq(Print(ID "c"), Seq(Assign("c", Add(ID "c", Int 1)), NoOp))), NoOp))), NoOp)))))))
let test_test3 = create_system_test ["public"; "test3.c"]
  (Seq(Declare(Int_Type, "a"), Seq(Assign("a", Int 10), Seq(Declare(Int_Type, "b"), Seq(Assign("b", Int 2), Seq(Declare(Int_Type, "c"), Seq(Assign("c", Add(ID "a", Mult(ID "b", Pow(Int 3, Int 3)))), Seq(Print(Equal(ID "c", Int 1)), NoOp))))))))
let test_test4 = create_system_test ["public"; "test4.c"]
  (Seq(Declare(Int_Type, "x"), Seq(Declare(Int_Type, "y"), Seq(Declare(Int_Type, "a"), Seq(While(Equal(ID "x", ID "y"), Seq(Assign("a", Int 100), NoOp)), Seq(If(Equal(ID "a", ID "b"), Seq(Print(Int 20), NoOp), Seq(Print(Int 10), NoOp)), NoOp))))))
let test_test_assoc1 = create_system_test ["public"; "test-assoc1.c"]
  (Seq(Declare(Int_Type, "a"), Seq(Assign("a", Add(Int 2, Add(Int 3, Int 4))), Seq(Declare(Int_Type, "b"), Seq(Assign("b", Mult(Int 2, Mult(Int 3, Int 4))), Seq(Declare(Int_Type, "c"), Seq(Assign("c", Pow(Int 2, Pow(Int 3, Int 4))), Seq(Declare(Int_Type, "d"), Seq(If(Greater(Int 5, Greater(Int 6, Int 1)), Seq(Print(Int 10), NoOp), NoOp), Seq(Print(ID "a"), Seq(Print(ID "b"), Seq(Print(ID "c"), NoOp))))))))))))
let test_while = create_system_test ["public"; "while.c"]
  (Seq(Declare(Int_Type, "a"), Seq(Assign("a", Int 10), Seq(Declare(Int_Type, "b"), Seq(Assign("b", Int 1), Seq(While(Less(ID "b", ID "a"), Seq(Print(ID "b"), Seq(Assign("b", Add(ID "b", Int 2)), NoOp))), NoOp))))))
let test_for = create_system_test ["public"; "for.c"]
  (Seq(Declare(Int_Type, "a"), Seq(For("a", Int 1, Int 10, Seq(Print(ID "a"), NoOp)), NoOp)))

let suite =
  "public" >::: [
    "assign1" >:: test_assign1;
    "assign_exp" >:: test_assign_exp;
    "define1" >:: test_define_1;
    "equal" >:: test_equal;
    "exp1" >:: test_exp_1;
    "exp2" >:: test_exp_2;
    "greater" >:: test_greater;
    "if" >:: test_if;
    "ifelse" >:: test_ifelse;
    "if_else_while" >:: test_if_else_while;
    "less" >:: test_less;
    "main" >:: test_main;
    "nested_if" >:: test_nested_if;
    "nested_ifelse" >:: test_nested_ifelse;
    "nested_while" >:: test_nested_while;
    "print" >:: test_print;
    "test1" >:: test_test1;
    "test2" >:: test_test2;
    "test3" >:: test_test3;
    "test4" >:: test_test4;
    "test_assoc1" >:: test_test_assoc1;
    "while" >:: test_while;
    "for" >:: test_for
  ]

let _ = run_test_tt_main suite
