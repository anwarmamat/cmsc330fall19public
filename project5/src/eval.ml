open SmallCTypes
open EvalUtils
open Builtins

exception TypeError of string
exception DeclareError of string
exception DivByZeroError

let assoc_opt k t =
  if List.mem_assoc k t then
    Some (List.assoc k t)
  else
    None

(* Insert value into environment and raise Declare error with passed message *)
let insert_val (k: string) (v: value) (env: environment) (msg: string): environment = failwith "Unfinished"

(* Helper function useful for inserting primitive values into the environment *)
let insert_primitive k v typ env =
  failwith "Unfinished"

(* Get value from environment and raise DeclareEror if it is not found. *)
let get_val env k = failwith "Unfinished"

(* Function references *)
let funcs = ref []

(* Used to access functions outside module. *)
let get_funcs () = !funcs

let reset_funcs () = funcs := []

let add_func name typ params body =
  if (List.mem_assoc name !funcs) then
    raise (DeclareError ("Function " ^ name ^" already exists"))
  else
    funcs := (name, (typ, params, body))::!funcs

let get_func name = List.assoc name !funcs

let get_type: (value -> data_type) = function
  | _ -> failwith "Unfinished"

let is_thunk (env: environment) (id: string): bool = failwith "Unfinished"

(* checks that value equals expected data_type fails with TypeError otherwise *)
let check_type (expect: data_type) (v: value): value = failwith "Unfinished"

(* Creates thunks for each argument and inserts them into new environment used to evaluate function body.
    Fails if too many or too few arguments and "if" parameters. *)
let rec new_func_scope (params: parameter list) (args: expr list) (curr_env: environment): environment =
  failwith "Unfinished"

(* Functions are mutually recursive *)
(* Replace this with your code from P4 and add to it to complete this project *)
and eval_expr env t = failwith "unimplemented"

(* Replace this with your code from P4 and add to it to complete this project *)
and eval_stmt env = failwith "unimplemented"
