open EvalUtils
open SmallCTypes

let print_expr args _ = 
  List.map unparse_expr args
  |> String.concat "\n"
  |> print_output_string
  |> print_output_newline 

let builtins = [
  ("print_expr", print_expr);
  ("print_env", fun _ env -> print_ln (env_to_string env));
]

let is_builtin n = List.mem_assoc n builtins

let call_builtin (n: string) (args: expr list) (env: environment) = 
  (List.assoc n builtins) args env