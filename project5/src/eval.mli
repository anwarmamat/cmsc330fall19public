exception TypeError of string
exception DeclareError of string
exception DivByZeroError

open SmallCTypes

val get_funcs: unit -> (string * func_def) list
val reset_funcs: unit -> unit
val eval_expr : environment -> expr -> value
val eval_stmt : environment -> stmt -> environment
val assoc_opt: string ->  environment -> value option
val insert_val: string -> value -> environment -> string -> environment
val insert_primitive: string -> value -> data_type -> environment -> environment
