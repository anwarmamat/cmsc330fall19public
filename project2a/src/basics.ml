(***********************************)
(* Part 1: Non-Recursive Functions *)
(***********************************)

let rev_tup tup = failwith "unimplemented"

let max_tup tup = failwith "unimplemented"

let abs x = failwith "unimplemented"

let area x y = failwith "unimplemented"

let volume x y = failwith "unimplemented"

let equiv_frac (a, b) (x, y) = failwith "unimplemented"

(*******************************)
(* Part 2: Recursive Functions *)
(*******************************)

let rec factorial x = failwith "unimplemented"

let rec pow x = failwith "unimplemented"

let rec tail x num = failwith "unimplemented"

let rec log x y = failwith "unimplemented"

let rec len x = failwith "unimplemented"

let rec contains sub x = failwith "unimplemented"

(*********************)
(* Part 3: Variables *)
(*********************)

type lookup_table = unit

let empty_table () : lookup_table = failwith "unimplemented"

let push_scope (table:lookup_table) : lookup_table = failwith "unimplemented"

let pop_scope (table:lookup_table) : lookup_table = failwith "unimplemented"

let add_var name value (table:lookup_table) : lookup_table = failwith "unimplemented"

let rec lookup name (table:lookup_table) = failwith "unimplemented"
