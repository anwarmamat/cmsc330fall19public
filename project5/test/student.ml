open OUnit2
open P5.SmallCTypes
open P5.Eval
open P5.Utils
open TestUtils

(* SmallC file is test/data/public_inputs/func0.c *)
let test_sample = create_system_test_parse ["student_inputs"; "sample.c"] @@
    P5.SmallCTypes.FunctionDecl ("main", P5.SmallCTypes.Int_Type, [],
     P5.SmallCTypes.Seq (P5.SmallCTypes.Declare (P5.SmallCTypes.Int_Type, "a"),
      P5.SmallCTypes.Seq (P5.SmallCTypes.Assign ("a", P5.SmallCTypes.Int 42),
       P5.SmallCTypes.Seq (P5.SmallCTypes.Print (P5.SmallCTypes.ID "a"),
        P5.SmallCTypes.NoOp))))

let student =
  "student" >::: [
    "sample" >:: test_sample;
  ]

let _ = run_test_tt_main student
