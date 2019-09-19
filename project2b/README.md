# Project 2B: OCaml Higher Order Functions and Data
Due: October 2 (Late October 3) at 11:59:59 PM
Points: 65P/35R/0S

## Introduction
The goal of this project is to increase your familiarity with programming in OCaml and give you practice using higher order functions and user-defined types. You will have to write a number of small functions, the specifications of which are given below. Some of them start out as code we provide you. In our reference solution, each function typically requires writing or modifying 1-8 lines of code.

You should be able to complete Part 1 after the lecture on high-order functions and the remaining sections after the lecture on user-defined types.

### Ground Rules
In your code, you may **only** use library functions found in the [`Pervasives` module][pervasives doc] and the functions provided in `funs.ml`. You **may** use the `@` operator. You **cannot** use the `List` module. You **may not** use any imperative structures of OCaml such as references.

The secret tests are worth 0 points, but check that you did not use any features that were not allowed. You will **lose** points if you fail these tests.

At a few points in this project, you will need to raise an `Invalid_argument` exception. Use the `invalid_arg` function to do so:
```
invalid_arg "something went wrong"
```
Use the error message that the function specifies as the argument.

## Part 0: Variable Lookup (Part 3 from last project)
Since this is a continuation of the previous project, we recommend you just copy your basics.ml file into this project and work from it.  A blank version of the file has been provided if you would prefer to use that.  While the functions from part 1 and 2 are removed from that file, it is fine if you keep them from last project or add them to this file.  They will not be directly tested again, but can be used for your implementation.

For this part of the project, you will be trying to implement a variable lookup table. You will need to implement your own data type `lookup_table` in `basics.ml`. You want to select a type that can be used to build all of the following functions. You'll find it easiest to start working on this part after you have read the directions for the entire section.

Consider the following code snippet in C that demonstrates the function of block scopes.

```
{
  int a = 30;
  int b = 40;
  {
    int a = 20;
    int c = 10;
    // POINT A
  }
  // POINT B
}
```

As you may remember from 216, the inner braces create a new "scope" for variable bindings. At Point A (marked in a comment), `a` is bound to 20, but as soon as the scope is popped on the next line (the closing curly brace), `a` returns to 30, since it was bound to that value in the previous scope. `c` is completely dropped out of memory at Point B, since it was only defined in the inner scope. Additionally, `b` is still bound to 40 at Point A, since it was bound in the outer scope. In Part 3, you'll be trying to implement your own data structure, which you'll define as `type lookup_table`, and you'll try to replicate this behavior.

If you're a little rusty on block scoping, you can check out [this link][block scope] or play around with scopes and print statements in C using gcc. Note that you do *not* have to worry about types, since every value will be an `int`.

Since we are not forcing you to implement the lookup table in any particular way, we will only test your table through the functions that you implement (specified below). This means that there are many different ways to solve this portion of the project, and as long as all the functions behave as expected, it doesn't matter exactly how you store the data.

#### type lookup_table
- **Description**: This is not a function. Rather, it is a type that you'll have to define based on what you think is necessary for the below requirements.

#### empty_table ()
- **Type**: `unit -> lookup_table`
- **Description**: Returns a new empty `lookup_table` with no scopes. The implementation of this will depend on how you define the lookup table above.
- **Examples:**
```
empty_table ()
```

#### push_scope table
- **Type**: `lookup_table -> lookup_table`
- **Description**: Returns a `lookup_table` that has an added inner scope.
- **Examples:**
```
empty_table ()
push_scope (empty_table ())
```

#### pop_scope table
- **Type**: `lookup_table -> lookup_table`
- **Description**: Returns a `lookup_table` that has removed its most recent scope. All of the bindings previous to the dropped scope should remain intact. If no scopes are left, throw a failure with `failwith "No scopes remain!"`
- **Examples:**
```
empty_table ()
push_scope (empty_table ())
pop_scope (push_scope (empty_table ()))
pop_scope (pop_scope (push_scope (empty_table ()))) = Exception
```

#### add_var name value table
- **Type**: `string -> int -> lookup_table -> lookup_table`
- **Description**: Updates the most recent scope in `table` to include a new variable named `name` with value `value`. If no scopes exist in `table`, raise a failure with `failwith "There are no scopes to add a variable to!"`
- **Examples:**
```
empty_table ()
add_var "hello" 3 (push_scope (empty_table ()))
add_var "hi" 5 (add_var "hello" 3 (push_scope (empty_table ())))
add_var "hello" 6 (add_var "hi" 5 (add_var "hello" 3 (push_scope (empty_table ()))))
add_var "oops" 1 (empty_table ()) = Exception
```

#### lookup name table
- **Type**: `string -> lookup_table -> int`
- **Description**: Returns the value associated with `name` in `table` in the current environment. If multiple values have been assigned to the same variable name, the most recently bound value in the current scope should be returned. If no variable named `name` is in `table`, raise a failure with `failwith "Variable not found!"`.
- **Examples:**
```
lookup "hello" (add_var "hello" 3 (push_scope (empty_table ()))) = 3
lookup "hello" (add_var "hi" 5 (add_var "hello" 3 (push_scope (empty_table ())))) = 3
lookup "hello" (add_var "hello" 6 (add_var "hi" 5 (add_var "hello" 3 (push_scope (empty_table ()))))) = 6
lookup "hello" (empty_table ()) = Exception
```

## Part 1: High Order Functions
Write the following functions in `higher.ml` using `map`, `fold`, or `fold_right` as defined in the file `funs.ml`. You **must** use `map`, `fold`, or `fold_right` to complete these functions, so **no functions in `higher.ml` should be defined using the `rec` keyword**. You will lose points if this rule is not followed. Use the other provided functions in `funs.ml` to make completing the functions easier.

Some of these functions will require just map or fold, but some will require a combination of the two. The map/reduce design pattern may come in handy: Map over a list to convert it to a new list which you then process a second time using fold. The idea is that you first process the list using map, and then reduce the resulting list using fold.

#### length lst
- **Type**: `'a list -> int`
- **Description**: Returns the length of the input list
- **Examples**:
```ocaml
length [] = 0
length [1;2;3] = 3
length ["one"; "two"; "three"; "four"] = 4
```
#### split_on pivot lst
- **Type**: `'a -> 'a list -> ('a list * 'a list)`
- **Description**:  This function takes in a pivot element and splits the list into two parts
The left is all elements before the pivot and the right element is all the elements after the pivot. If the pivot does not exist it should act as if the pivot is at the end of the list.
Note: You may assume that the pivot element does not repeat
- **Examples**:
```ocaml
split_on 18 [1;2;3;4;18;6;7;8;9] = ([1;2;3;4], [6;7;8;9])
split_on 18 [1;2;3;4;18] = ([1;2;3;4], [])
split_on 18 [18;6;7;8;9] = ([], [6;7;8;9])
split_on 18 [1;2;3;4] = ([1;2;3;4], [])
```
#### flat_pair lst
- **Type**: `('a * 'a) list -> 'a list`
- **Description**: Takes in a list of tuples and pulls out the elements, turning them into a compiled list.
- **Examples**
```ocaml
flat_pair [(1,2); (3,4); (5,6)] = [1;2;3;4;5;6]
flat_pair [("hi", " "); ("there", "!")] = ["hi"; " "; "there"; "!"]
```
#### comp fns arg
- **Type**: `('a -> 'a) list -> 'a -> 'a`
- **Description**: `comp` returns the value after arg is applied to the composition of all the functions in list.
 Note: In math function composition is right to left
- **Examples**
```ocaml
let f x = x + 1;;
let g x = x * 100;;
let h x = x - 1;;
comp [f; g; h] 2 = 101
comp [(^) "!"; (^) "?"; (^) "wot"] " in tarnation" = "!?wot in tarnation"
```

#### ap fns args
- **Type**: `('a -> 'b) list -> 'a list -> 'b list`
- **Description**: Applies each function in `fns` to each argument in `args` in order.

- **Examples:**
```
ap [] [1;2;3;4] = []
ap [succ] [] = []
ap [(fun x -> x^"?"); (fun x -> x^"!")] ["foo";"bar"] = ["foo?";"bar?";"foo!";"bar!"]
ap [pred;succ] [1;2] = [0;1;2;3]
ap [int_of_float;fun x -> (int_of_float x)*2] [1.0;2.0;3.0] = [1; 2; 3; 2; 4; 6]

```

Note the types of `map`, `ap`, and `flatmap`. Do you see the similarities?

```
map : ('a -> 'b) -> 'a list -> 'b list
ap : ('a -> 'b) list -> 'a list -> 'b list
flatmap : ('a -> 'b list) -> 'a list -> 'b list
```

## Part 2: Integer BST
The remaining sections will be implemented in `data.ml`.

Here, you will write functions that will operate on a binary search tree whose nodes contain integers. Provided below is the type of `int_tree`.

```
type int_tree =
    IntLeaf
  | IntNode of int * int_tree * int_tree
```

According to this definition, an ``int_tree`` is either: empty (just a leaf), or a node (containing an integer, left subtree, and right subtree). An empty tree is just a leaf.

```
let empty_int_tree = IntLeaf
```

Like lists, BSTs are immutable. Once created we cannot change it. To insert an element into a tree, create a new tree that is the same as the old, but with the new element added. Let's write `insert` for our `int_tree`. Recall the algorithm for inserting element `x` into a tree:

- *Empty tree?* Return a single-node tree.
- `x` *less than the current node?* Return a tree that has the same content as the present tree but where the left subtree is instead the tree that results from inserting `x` into the original left subtree.
- `x` *already in the tree?* Return the tree unchanged.
- `x` *greater than the current node?* Return a tree that has the same content as the present tree but where the right subtree is instead the tree that results from inserting `x` into the original right subtree.

Here's one implementation:

```
let rec int_insert x t =
  match t with
    IntLeaf -> IntNode (x, IntLeaf, IntLeaf)
  | IntNode (y, l, r) when x < y -> IntNode (y, int_insert x l, r)
  | IntNode (y, l, r) when x = y -> t
  | IntNode (y, l, r) -> IntNode (y, l, int_insert x r)
```

**Note**: The `when` syntax may be unfamiliar to you - it acts as an extra guard in addition to the pattern. For example, `IntNode (y, l, r) when x < y` will only be matched when the tree is an `IntNode` and `x < y`. This serves a similar purpose to having an if statement inside of the general `IntNode` match case, but allows for more readable syntax in many cases.

Let's try writing a function which determines whether a tree contains an element. This follows a similar procedure except we'll be returning a boolean if the element is a member of the tree.

```
let rec int_mem x t =
  match t with
    IntLeaf -> false
  | IntNode (y, l, r) when x < y -> int_mem x l
  | IntNode (y, l, r) when x = y -> true
  | IntNode (y, l, r) -> int_mem x r
```

It's your turn now! Write the following functions which operate on `int_tree`.

#### int_insert_all lst t
- **Type**: `int list -> int_tree -> int_tree`
- **Description**: Returns a tree which is the same as tree `t`, but with all the integers in list `lst` added to it. The elements should be added in the order they appear in the list. Try to use fold to implement this in one line.
- **Examples:**
```
int_as_list (int_insert_all [1;2;3] empty_int_tree) = [1;2;3]
```

#### int_depth t
- **Type**: `int_tree -> int`
- **Description**: Returns the height tree `t`.
- **Examples:**
```
int_depth empty_int_tree = 0
int_depth (int_insert 1 (int_insert 2 empty_int_tree)) = 2
int_depth (int_insert 4 (int_insert 3 (int_insert 2 empty_int_tree))) = 3
```

#### int_common t x y
- **Type**: `int_tree -> int -> int -> int`
- **Description**: Returns the closest common ancestor of `x` and `y` in the tree `t` (i.e. the lowest shared parent in the tree). Raises exception `Invalid_argument("int_common")` on an empty tree or where `x` or `y` don't exist in tree `t`.
- **Examples:**
```
let t = int_insert_all [6;1;8;5;10;13;9;4] empty_int_tree;;
int_common t 1 10 = 6
int_common t 8 9 = 8
```

#### int_level lvl t
- **Type**: `int -> int_tree -> int list`
- **Description**: Returns a list of integers where the integers are all on the same level of the tree, from left to right
- **Examples:**
```
let t = (int_insert 1 (int_insert 3 (int_insert 2 empty_int_tree)))
int_level_print 1 t = [1;3]
```

## Part 3: Polymorphic BST
Our type `int_tree` is limited to integer elements. We want to define a binary search tree over *any* totally ordered type. Let's define the type `'a atree` to do so.

```
type 'a atree =
    Leaf
  | Node of 'a * 'a atree * 'a atree
```

This defintion is the same as `int_tree` except it's polymorphic. The nodes may contain any type `'a`, not just integers. Since a tree may contain any value, we need a way to compare values. We define a type for comparison functions.

```
type 'a compfn = 'a -> 'a -> int
```

Any comparison function will take two `'a` values and return an integer. If the integer is negative, the first value is less than the second; if positive, the first value is greater; if 0 they're equal.

Finally, we can bundle the two previous types to create a polymorphic BST.

```
type 'a ptree = 'a compfn * 'a atree
```

An empty tree is just a leaf and some comparison function.

```
let empty_ptree f : 'a ptree = (f, Leaf)
```

You can modify the code from your `int_tree` functions to implement some functions on `ptree`. Remember to use the bundled comparison function!

#### pinsert x t
- **Type**: `'a -> 'a ptree -> 'a ptree`
- **Description**: Returns a tree which is the same as tree `t`, but with `x` added to it.
- **Examples:**
```
let int_comp x y = if x < y then -1 else if x > y then 1 else 0;;
let t0 = empty_ptree int_comp;;
let t1 = pinsert 1 (pinsert 8 (pinsert 5 t0));;
```

#### pmem x t
- **Type**: `'a -> 'a ptree -> bool`
- **Description**: Returns true iff `x` is an element of tree `t`.
- **Examples:**
```
(* see definitions of t0 and t1 above *)
pmem 5 t0 = false
pmem 5 t1 = true
pmem 1 t1 = true
pmem 2 t1 = false
```

#### pinsert_all lst t
- **Type**: `'a list -> 'a ptree -> 'a ptree`
- **Description**: Returns a tree which is the same as tree `t`, but with all the elements in list `lst` added to it. The elements should be added in the order they appear in the list. Try to use fold to implement this in one line.
- **Examples:**
```
p_as_list (pinsert_all [1;2;3] t0) = [1;2;3]
p_as_list (pinsert_all [1;2;3] t1) = [1;2;3;5;8]
```

#### p_as_list t
- **Type**: `'a ptree -> 'a list`
- **Description**: Returns a list where the values correspond to an [in-order traversal][wikipedia inorder traversal] on tree `t`.
- **Examples:**
```
p_as_list (pinsert 2 (pinsert 1 t0)) = [1;2]
p_as_list (p_insert 2 (p_insert 2 (p_insert 3 t0))) = [2;3]
```

#### pmap f t
- **Type**: `('a -> 'a) -> 'a ptree -> 'a ptree`
- **Description**: Returns a tree where the function `f` is applied to all the elements of `t`.
- **Examples:**
```
p_as_list (pmap (fun x -> x * 2) t1) = [2;10;16]
p_as_list (pmap (fun x -> x * (-1)) t1) = [-8;-5;-1]
```
Part 4: Graphs with Records
--------------------------------------
For the last part of this project, you will implement functions which operate on directed graphs.

Here are the types for graphs. They use OCaml's record syntax.

```
type node = int
type edge = { src: node; dst: node; }
type graph = { nodes: int_tree; edges: edge list }
```

A graph is record with two fields: a set of nodes aptly called "nodes" (represented as an `int_tree`), and a list of edges. A node is represented as an integer, and an edge is a record identifying its source and destination nodes.

An empty graph has no nodes (i.e., the empty integer tree) and has no edges (the empty list).

```
let empty_graph = { nodes = empty_int_tree; edges = [] }
```

Provided below is a function which adds an edge to a graph. Its type is `edge -> graph -> graph`.

```
let add_edge e { nodes = ns; edges = es } =
  let { src = s; dst = d } = e in
  let ns' = int_insert s ns in
  let ns'' = int_insert d ns' in
  let es' = e::es in
  { nodes = ns''; edges = es' }
```

Given an edge `e` and graph `g`, it returns a new graph that is the same as `g`, but with `e` added. Note this routine makes no attempt to eliminate duplicate edges; these could add some inefficiency, but should not harm correctness.

We also provide a function `add_edges : edge list -> graph -> graph` to add multiple edges at once.

Write the following functions which operate on `graph`. You can assume that the graph value these functions receive is only created by graph functions themselves in your solution. In other words, you can assume that any invariants about the graph data structure that are enforced by your code will be satisfied — we will not build graph values from scratch.

#### graph_empty g
- **Type**: `graph -> bool`
- **Description**: Returns true iff graph `g` is empty.
- **Examples:**
```
graph_empty (add_edge { src = 1; dst = 2 } empty_graph) = false
graph_empty empty_graph = true
```

#### graph_size g
- **Type**: `graph -> int`
- **Description**: Returns the number of nodes in graph `g`.
- **Examples:**
```
graph_size (add_edge { src = 1; dst = 2 } empty_graph) = 2
graph_size (add_edge { src = 1; dst = 1 } empty_graph) = 1
```

#### is_dst n e
- **Type**: `node -> edge -> bool`
- **Description**: Returns true iff node `n` is the destination of edge `e`.
- **Examples:**
```
is_dst 1 { src = 1; dst = 2 } = false
is_dst 2 { src = 1; dst = 2 } = true
```

#### src_edges n g
- **Type**: `node -> graph -> edge list`
- **Description**: Returns a list of edges in graph `g` whose source node is `n`.
- **Examples:**
```
src_edges 1 (add_edges [{src=1;dst=2}; {src=1;dst=3}; {src=2;dst=2}] empty_graph) = [{src=1;dst=2}; {src=1;dst=3}]
```

#### reachable n g
- **Type**: `node -> graph -> int_tree`
- **Description**: Returns the set of nodes reachable from node `n` in graph `g`, where the set is represented as an `int_tree`. If `n` is neither a source nor a destination in the graph, `IntLeaf` should be returned.
- **Examples:**
```
int_as_list
 (reachable 1
   (add_edges [{src=1;dst=2}; {src=1;dst=3}; {src=2;dst=2}] empty_graph)) =
   [1;2;3]

int_as_list
 (reachable 3
   (add_edges [{src=1;dst=2}; {src=1;dst=3}; {src=2;dst=2}] empty_graph)) =
   [3]

int_as_list
 (reachable 2
   (add_edges [{src=0;dst=1}] empty_graph)) =
   []
```


## Academic Integrity
Please **carefully read** the academic honesty section of the course syllabus. **Any evidence** of impermissible cooperation on projects, use of disallowed materials or resources, or unauthorized use of computer accounts, **will be** submitted to the Student Honor Council, which could result in an XF for the course, or suspension or expulsion from the University. Be sure you understand what you are and what you are not permitted to do in regards to academic integrity when it comes to project assignments. These policies apply to all students, and the Student Honor Council does not consider lack of knowledge of the policies to be a defense for violating them. Full information is found in the course syllabus, which you should review before starting.

[pervasives doc]: https://caml.inria.fr/pub/docs/manual-ocaml/libref/Pervasives.html
[git instructions]: ../git_cheatsheet.md
[wikipedia inorder traversal]: https://en.wikipedia.org/wiki/Tree_traversal#In-order
[wikipedia preorder traversal]: https://en.wikipedia.org/wiki/Tree_traversal#Pre-order_(NLR)
[submit server]: submit.cs.umd.edu
[web submit link]: image-resources/web_submit.jpg
[web upload example]: image-resources/web_upload.jpg
