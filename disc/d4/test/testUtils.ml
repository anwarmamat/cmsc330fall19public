open OUnit2

let string_of_list f xs =
  "[" ^ (String.concat "; " (List.map f xs)) ^ "]" 
let string_of_int_list = string_of_list string_of_int
let string_of_string_list = string_of_list (fun x -> x) 
