open SmallCTypes
open TokenTypes

val parse_top_level : token list -> stmt

(* Yeah don't touch this either thx *)
val parse_expr_wrapper : token list -> expr
val parse_stmt_wrapper : token list -> stmt
