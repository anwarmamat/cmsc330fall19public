module type Stack = sig
    type 'a stack
    exception EmptyStack

    val new_stack: 'a stack
    val push: 'a stack -> 'a -> 'a stack
    val peek: 'a stack -> 'a
    val pop: 'a stack -> 'a * 'a stack 
end

(* TODO:Create a ListStack module that has the above signature. Make sure to define the abastract type stack in your module. For pop and peek,
raise an Empty stack exception if the stack is empty. Make sure to include execption EmptyStack in your module definition. *)


module type Comparable = 
    sig
        type t
        val compare: t -> t -> int
    end

(* TODO: Complete the BinaryTreeImple module function insert given below *)
module BinaryTreeImpl = 
    functor(T: Comparable) -> 
        struct
            type t = T.t
            type tree = 
                |Leaf
                |Node of  tree * t * tree 

            let new_tree = failwith "unimplimented"
            let rec contains tree (value:t) = match tree with
                |Leaf -> false
                |Node (left, v, right) -> let res = T.compare value v in
                    if res < 0 then
                        contains left value
                    else if res > 0 then
                        contains right value
                    else
                         true
            let rec insert tree (value:t) = match tree with
                |Leaf -> Node (Leaf, value, Leaf)
                |Node (left, v, right) -> let res = T.compare value v in
                    if res < 0 then
                        failwith "unimplimented"
                    else if res > 0 then
                        failwith "unimplimented"
                    else
                        failwith "unimplimented"
        end

(* TODO: Define a module called StringBinaryTree that is a string version of the BinaryTreeImpl module. Hint: Functor*)
