open OUnit2
open P5.SmallCTypes
open P5.Eval
open P5.Utils
open TestUtils

(* SmallC file is test/data/public_inputs/func0.c *)
let test_func_parse_one = create_system_test_parse ["public_inputs"; "func0.c"] (Seq
 (FunctionDecl ("bar", Int_Type,
   [("x", Int_Type)],
   Seq (Declare (Int_Type, "f"),
    Seq (Assign ("f", Int 41),
     Seq
      (Return
        (Add (ID "f", ID "x")),
      NoOp)))),
 FunctionDecl ("main", Int_Type, [],
  Seq (Declare (Int_Type, "f"),
   Seq
    (Assign ("f",
      FunctionCall ("bar", [Int 1])),
    NoOp)))))

(* SmallC file is test/data/public_inputs/func.c *)
let test_func_one = create_system_test [] [("f", Int_Val 42)] (Seq
   (FunctionDecl ("foo", Int_Type, [],
     Seq (Return (Int 42),
      NoOp)),
   FunctionDecl ("main", Int_Type, [],
    Seq (Declare (Int_Type, "f"),
     Seq
      (Assign ("f", FunctionCall ("foo", [])),
      NoOp)))))

let test_func_parse_two = create_system_test_parse ["public_inputs"; "func_lazy.c"] (Seq
   (FunctionDecl ("foo", Int_Type,
     [("x", Int_Type); ("y", Int_Type);
      ("z", Int_Type)],
     Seq (Declare (Int_Type, "f"),
      Seq (Assign ("f", Int 41),
       Seq
        (Return
          (Sub
            (Mult (ID "f", ID "x"),
            Int 10)),
        NoOp)))),
   Seq
    (FunctionDecl ("three", Int_Type, [],
      Seq (Print (Int 3),
       Seq (Return (Int 3),
        NoOp))),
    Seq
     (FunctionDecl ("four", Int_Type, [],
       Seq (Print (Int 4),
        Seq (Return (Int 4),
         NoOp))),
     Seq
      (FunctionDecl ("thousand", Int_Type,
        [],
        Seq (Print (Int 1000),
         Seq (Return (Int 1000),
          NoOp))),
      FunctionDecl ("main", Int_Type, [],
       Seq
        (Declare (Int_Type, "f"),
        Seq
         (Assign ("f",
           FunctionCall ("foo",
            [FunctionCall ("three", []);
             FunctionCall ("four", []);
             FunctionCall ("thousand", [])])),
         NoOp))))))))

(* Corresponds with func0_2.c *)
let test_func_eval = create_system_test [] [("f", Int_Val 44)] (Seq
   (FunctionDecl ("bar", Int_Type,
     [("x", Int_Type)],
     Seq
      (Declare (Int_Type, "f"),
      Seq
       (Assign ("f", Int 41),
       Seq
        (Return
          (Add (ID "f", ID "x")),
        NoOp)))),
   FunctionDecl ("main", Int_Type, [],
    Seq
     (Declare (Int_Type, "f"),
     Seq
      (Assign ("f",
        FunctionCall ("bar", [Int 3])),
      NoOp)))))

let test_recursive_func_eval_one = create_system_test [] [("f", Int_Val 3628800)] (Seq
   (FunctionDecl ("fact", Int_Type,
     [("x", Int_Type)],
     Seq
      (If
        (Equal (ID "x", Int 0),
        Seq (Return (Int 1),
         NoOp),
        Seq
         (Return
           (Mult
             (FunctionCall ("fact",
               [Sub (ID "x",
                 Int 1)]),
             ID "x")),
         NoOp)),
      NoOp)),
   FunctionDecl ("main", Int_Type, [],
    Seq
     (Declare (Int_Type, "f"),
     Seq
      (Assign ("f",
        FunctionCall ("fact", [Int 10])),
      NoOp)))))

let test_recursive_func_eval_two = create_system_test [] [("f", Int_Val 13)] (Seq
   (FunctionDecl ("fib", Int_Type,
     [("x", Int_Type)],
     Seq
      (If
        (Equal (ID "x", Int 0),
        Seq (Return (Int 1),
         NoOp),
        Seq
         (If
           (Equal (ID "x",
             Int 1),
           Seq (Return (Int 1),
            NoOp),
           Seq
            (Return
              (Add
                (FunctionCall ("fib",
                  [Sub (ID "x",
                    Int 1)]),
                FunctionCall ("fib",
                 [Sub (ID "x",
                   Int 2)]))),
            NoOp)),
         NoOp)),
      NoOp)),
   FunctionDecl ("main", Int_Type, [],
    Seq
     (Declare (Int_Type, "f"),
     Seq
      (Assign ("f",
        FunctionCall ("fib", [Int 6])),
      NoOp)))))

let test_func_lazy_eval_one = create_system_test [] [("f", Int_Val 113)] (Seq
   (FunctionDecl ("foo", Int_Type,
     [("x", Int_Type); ("y", Int_Type);
      ("z", Int_Type)],
     Seq
      (Declare (Int_Type, "f"),
      Seq
       (Assign ("f", Int 41),
       Seq
        (Return
          (Sub
            (Mult (ID "f",
              ID "x"),
            Int 10)),
        NoOp)))),
   Seq
    (FunctionDecl ("three", Int_Type,
      [],
      Seq (Print (Int 3),
       Seq (Return (Int 3),
        NoOp))),
    Seq
     (FunctionDecl ("four", Int_Type,
       [],
       Seq (Print (Int 4),
        Seq (Return (Int 4),
         NoOp))),
     Seq
      (FunctionDecl ("thousand", Int_Type,
        [],
        Seq (Print (Int 1000),
         Seq
          (Return (Int 1000),
          NoOp))),
      FunctionDecl ("main", Int_Type,
       [],
       Seq
        (Declare (Int_Type, "f"),
        Seq
         (Assign ("f",
           FunctionCall ("foo",
            [FunctionCall ("three", []);
             FunctionCall ("four", []);
             FunctionCall ("thousand", [])])),
         NoOp)))))))) ~output:"3\n"

let test_func_lazy_eval_two = create_system_test [] [("f", Int_Val 42)] (Seq
 (FunctionDecl ("foo", Int_Type,
   [("x", Int_Type); ("y", Int_Type)],
   Seq
    (Declare (Int_Type, "f"),
    Seq (Assign ("f", Int 41),
     Seq
      (Return
        (Add (ID "f", ID "x")),
      NoOp)))),
 Seq
  (FunctionDecl ("one", Int_Type, [],
    Seq (Print (Int 1),
     Seq (Return (Int 1),
      NoOp))),
  Seq
   (FunctionDecl ("two", Int_Type, [],
     Seq (Print (Int 2),
      Seq (Return (Int 2),
       NoOp))),
   FunctionDecl ("main", Int_Type, [],
    Seq
     (Declare (Int_Type, "f"),
     Seq
      (Assign ("f",
        FunctionCall ("foo",
         [FunctionCall ("one", []);
          FunctionCall ("two", [])])),
      NoOp))))))) ~output:"1\n"

let test_func_lazy_rec = create_system_test []  [("f", Int_Val 113)] (
  Seq(
    FunctionDecl("foo", Int_Type, [("x", Int_Type); ("y", Int_Type)],
        Seq(Declare(Int_Type, "f"), Seq(Assign("f", Int 41), Seq(Return(Sub(Mult(ID "f", ID "x"), Int 10)), NoOp)))), Seq(
    FunctionDecl("loop", Int_Type, [],
        Seq(Declare(Int_Type, "x"), Seq(While(Bool true, Seq(Assign("x", Int 1), NoOp)), Seq(Return(Int 3), NoOp)))), Seq(
    FunctionDecl("three", Int_Type, [],
        Seq(Print(Int 3), Seq(Return(Int 3), NoOp))),
    FunctionDecl("main", Int_Type, [],
        Seq(Declare(Int_Type, "f"), Seq(Assign("f", FunctionCall("foo", [FunctionCall("three", []); FunctionCall("loop", [])])), NoOp))))))
)  ~output:"3\n"

let test_for_function = create_system_test_eval ["public_inputs"; "forfunction.c"] [("x",Int_Val 3)] ~output:"1\n2\n3\n"
let test_while_function = create_system_test_eval ["public_inputs"; "whilefunction.c"] [("x",Int_Val 3)] ~output:"1\n2\n"
let test_function_in_function = create_system_test_eval ["public_inputs"; "functioninfunction.c"] [("x",Int_Val 512)] ~output:"8\n16\n32\n64\n128\n256\n"
let test_mixed_function = create_system_test_eval ["public_inputs"; "mixedfunction.c"] [("x",Int_Val 24);("b",Bool_Val false)] ~output:"24\n"
let test_mixed_function_2 = create_system_test_eval ["public_inputs"; "mixedfunction2.c"] [("k",Int_Val 6)] ~output:"0\n4\n7\n0\n12\n0\n19\n0\n28\n0\n"
let test_mixed_function_3 = create_system_test_eval ["public_inputs"; "mixedfunction3.c"] [("k",Int_Val 6);("x",Int_Val 6);("y",Int_Val 6);("z",Int_Val 6)] ~output:"0\n4\n7\n0\n12\n0\n19\n0\n28\n0\n7\n0\n0\n10\n15\n0\n22\n0\n31\n0\n12\n0\n0\n15\n0\n20\n27\n0\n36\n0\n19\n0\n0\n22\n0\n27\n0\n34\n43\n0\n28\n0\n0\n31\n0\n36\n0\n43\n0\n52\n0\n7\n10\n0\n0\n15\n0\n22\n0\n31\n0\n10\n0\n13\n18\n1\n25\n2\n34\n3\n15\n0\n18\n1\n0\n23\n30\n1\n39\n2\n22\n0\n25\n2\n1\n30\n0\n37\n46\n1\n31\n0\n34\n3\n2\n39\n1\n46\n0\n55\n0\n12\n15\n0\n20\n0\n0\n27\n0\n36\n0\n15\n1\n18\n23\n0\n1\n30\n2\n39\n0\n20\n0\n23\n0\n28\n35\n2\n44\n4\n27\n0\n30\n1\n35\n2\n0\n42\n51\n2\n36\n0\n39\n2\n44\n4\n2\n51\n0\n60\n0\n19\n22\n0\n27\n0\n34\n0\n0\n43\n0\n22\n2\n25\n30\n1\n37\n0\n1\n46\n0\n27\n1\n30\n2\n35\n42\n0\n2\n51\n0\n34\n0\n37\n0\n42\n0\n49\n58\n3\n43\n0\n46\n1\n51\n2\n58\n3\n0\n67\n0\n28\n31\n0\n36\n0\n43\n0\n52\n0\n0\n31\n3\n34\n39\n2\n46\n1\n55\n0\n0\n36\n2\n39\n4\n44\n51\n2\n60\n0\n0\n43\n1\n46\n2\n51\n3\n58\n67\n0\n0\n52\n0\n55\n0\n60\n0\n67\n0\n76\n7\n0\n0\n10\n0\n15\n0\n22\n0\n31\n0\n10\n13\n0\n1\n18\n2\n25\n3\n34\n0\n15\n18\n1\n23\n0\n1\n30\n2\n39\n0\n22\n25\n2\n30\n1\n37\n0\n1\n46\n0\n31\n34\n3\n39\n2\n46\n1\n55\n0\n10\n0\n0\n13\n18\n1\n25\n2\n34\n3\n13\n0\n0\n16\n21\n0\n28\n0\n37\n0\n1\n18\n21\n0\n0\n26\n33\n0\n42\n0\n2\n25\n28\n0\n0\n33\n0\n40\n49\n0\n3\n34\n37\n0\n0\n42\n0\n49\n0\n58\n15\n0\n1\n18\n0\n23\n30\n1\n39\n2\n18\n1\n0\n21\n26\n0\n0\n33\n0\n42\n23\n0\n0\n26\n0\n31\n38\n1\n47\n2\n1\n30\n33\n0\n38\n1\n0\n45\n54\n1\n2\n39\n42\n0\n47\n2\n1\n54\n0\n63\n22\n0\n2\n25\n1\n30\n0\n37\n46\n1\n25\n2\n0\n28\n33\n0\n40\n0\n0\n49\n30\n1\n0\n33\n1\n38\n45\n0\n1\n54\n37\n0\n0\n40\n0\n45\n0\n52\n61\n2\n1\n46\n49\n0\n54\n1\n61\n2\n0\n70\n31\n0\n3\n34\n2\n39\n1\n46\n0\n55\n34\n3\n0\n37\n42\n0\n49\n0\n58\n0\n39\n2\n0\n42\n2\n47\n54\n1\n63\n0\n46\n1\n0\n49\n1\n54\n2\n61\n70\n0\n55\n0\n0\n58\n0\n63\n0\n70\n0\n79\n12\n0\n15\n0\n0\n20\n0\n27\n0\n36\n15\n0\n1\n18\n23\n0\n30\n1\n39\n2\n0\n20\n0\n23\n28\n0\n2\n35\n4\n44\n0\n27\n1\n30\n35\n2\n42\n0\n2\n51\n0\n36\n2\n39\n44\n4\n51\n2\n60\n0\n0\n15\n18\n1\n0\n23\n1\n30\n2\n39\n1\n18\n21\n0\n0\n26\n0\n33\n0\n42\n23\n0\n0\n26\n31\n0\n1\n38\n2\n47\n30\n1\n0\n33\n38\n1\n45\n0\n1\n54\n39\n2\n0\n42\n47\n2\n54\n1\n63\n0\n20\n0\n23\n0\n0\n28\n35\n2\n44\n4\n0\n23\n26\n0\n0\n31\n38\n1\n47\n2\n28\n0\n31\n0\n0\n36\n43\n0\n52\n0\n2\n35\n1\n38\n43\n0\n0\n50\n59\n0\n4\n44\n2\n47\n52\n0\n0\n59\n0\n68\n27\n0\n30\n1\n2\n35\n0\n42\n51\n2\n1\n30\n33\n0\n1\n38\n0\n45\n54\n1\n35\n2\n38\n1\n0\n43\n50\n0\n0\n59\n42\n0\n45\n0\n0\n50\n0\n57\n66\n1\n2\n51\n1\n54\n59\n0\n66\n1\n0\n75\n36\n0\n39\n2\n4\n44\n2\n51\n0\n60\n2\n39\n42\n0\n2\n47\n1\n54\n0\n63\n44\n4\n47\n2\n0\n52\n59\n0\n68\n0\n51\n2\n54\n1\n0\n59\n1\n66\n75\n0\n60\n0\n63\n0\n0\n68\n0\n75\n0\n84\n19\n0\n22\n0\n27\n0\n0\n34\n0\n43\n22\n0\n2\n25\n1\n30\n37\n0\n46\n1\n27\n0\n30\n1\n2\n35\n42\n0\n51\n2\n0\n34\n0\n37\n0\n42\n49\n0\n3\n58\n0\n43\n1\n46\n2\n51\n58\n3\n67\n0\n0\n22\n25\n2\n30\n1\n0\n37\n1\n46\n2\n25\n28\n0\n33\n0\n0\n40\n0\n49\n1\n30\n33\n0\n1\n38\n45\n0\n54\n1\n37\n0\n0\n40\n0\n45\n52\n0\n2\n61\n46\n1\n0\n49\n1\n54\n61\n2\n70\n0\n0\n27\n1\n30\n35\n2\n0\n42\n2\n51\n30\n1\n0\n33\n38\n1\n0\n45\n1\n54\n2\n35\n1\n38\n43\n0\n0\n50\n0\n59\n42\n0\n45\n0\n0\n50\n57\n0\n1\n66\n51\n2\n54\n1\n0\n59\n66\n1\n75\n0\n34\n0\n37\n0\n42\n0\n0\n49\n58\n3\n0\n37\n40\n0\n45\n0\n0\n52\n61\n2\n0\n42\n0\n45\n50\n0\n0\n57\n66\n1\n49\n0\n52\n0\n57\n0\n0\n64\n73\n0\n3\n58\n2\n61\n1\n66\n73\n0\n0\n82\n43\n0\n46\n1\n51\n2\n3\n58\n0\n67\n1\n46\n49\n0\n54\n1\n2\n61\n0\n70\n2\n51\n1\n54\n59\n0\n1\n66\n0\n75\n58\n3\n61\n2\n66\n1\n0\n73\n82\n0\n67\n0\n70\n0\n75\n0\n0\n82\n0\n91\n28\n0\n31\n0\n36\n0\n43\n0\n0\n52\n31\n0\n3\n34\n2\n39\n1\n46\n55\n0\n36\n0\n39\n2\n4\n44\n2\n51\n60\n0\n43\n0\n46\n1\n51\n2\n3\n58\n67\n0\n0\n52\n0\n55\n0\n60\n0\n67\n76\n0\n0\n31\n34\n3\n39\n2\n46\n1\n0\n55\n3\n34\n37\n0\n42\n0\n49\n0\n0\n58\n2\n39\n42\n0\n2\n47\n1\n54\n63\n0\n1\n46\n49\n0\n54\n1\n2\n61\n70\n0\n55\n0\n0\n58\n0\n63\n0\n70\n79\n0\n0\n36\n2\n39\n44\n4\n51\n2\n0\n60\n39\n2\n0\n42\n47\n2\n54\n1\n0\n63\n4\n44\n2\n47\n52\n0\n59\n0\n0\n68\n2\n51\n1\n54\n59\n0\n1\n66\n75\n0\n60\n0\n63\n0\n0\n68\n0\n75\n84\n0\n0\n43\n1\n46\n2\n51\n58\n3\n0\n67\n46\n1\n0\n49\n1\n54\n61\n2\n0\n70\n51\n2\n54\n1\n0\n59\n66\n1\n0\n75\n3\n58\n2\n61\n1\n66\n73\n0\n0\n82\n67\n0\n70\n0\n75\n0\n0\n82\n91\n0\n52\n0\n55\n0\n60\n0\n67\n0\n0\n76\n0\n55\n58\n0\n63\n0\n70\n0\n0\n79\n0\n60\n0\n63\n68\n0\n75\n0\n0\n84\n0\n67\n0\n70\n0\n75\n82\n0\n0\n91\n76\n0\n79\n0\n84\n0\n91\n0\n0\n100\n"


  (* Example of how to add your own test from an input file.  
  It takes the list which is the path to the file starting from data, the final environment, and 
  an optional string of the expected strings printed during execution. *)
let sample_file_test = create_system_test_eval ["student_inputs"; "sample.c"] [("a", Int_Val 42)] ~output:"42\n"

let public =
  "public" >::: [

    "func_parse_one" >:: test_func_parse_one;
    "func_one" >:: test_func_one;
    "sample_file_test" >:: sample_file_test;

    "func_parse_two" >:: test_func_parse_two;
    "func_eval" >:: test_func_eval;
    "recursive_func_eval_one" >:: test_recursive_func_eval_one;
    "recursive_func_eval_two" >:: test_recursive_func_eval_two;
    "func_lazy_eval_one" >:: test_func_lazy_eval_one;
    "func_lazy_eval_two" >:: test_func_lazy_eval_two;
    "func_lazy_rec" >:: test_func_lazy_rec;
     "test_for_function" >:: test_for_function;
   "test_while_function" >:: test_while_function; 
   "test_function_in_function" >:: test_function_in_function; 
    "test_mixed_function" >:: test_mixed_function;
    "test_mixed_function_2" >:: test_mixed_function_2;         
    "test_mixed_function_3" >:: test_mixed_function_3;         

  ]

let _ = run_test_tt_main public
