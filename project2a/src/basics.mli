val rev_tup : 'a * 'b * 'c -> 'c * 'b * 'a
val max_tup : 'a * 'a * 'a -> 'a
val abs : int -> int
val area : int * int -> int * int -> int
val volume : int * int * int -> int * int * int -> int
val equiv_frac : int * int -> int * int -> bool
val factorial : int -> int
val pow : int -> int -> int
val tail : int -> int -> int
val log : int -> int -> int
val len : int -> int
val contains : int -> int -> bool
type lookup_table
val empty_table : unit -> lookup_table
val push_scope : lookup_table -> lookup_table
val pop_scope : lookup_table -> lookup_table
val add_var : string -> int -> lookup_table -> lookup_table
val lookup : string -> lookup_table -> int
