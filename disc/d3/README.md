# Discussion 3 - CMSC330 Fall 2019

## Announcements

1. Project 1 was due on Tuesday, and the late deadline was on Wednesday. How was it?

2. Project 2A is up.

3. To run the public tests in this discussion exercise (as well as your student tests if you decide to write any), execute the command `dune runtest -f`.

## OCaml

1. OCaml is a functional, statically typed, explicitly declared, compiled language with a strong emphasis on immutability.   
   Although OCaml allows side effects (mutability) and loops, in this class we will have (mostly) no side effects, and recursion only.


2. Expressions and Types
  - All expressions in OCaml have a certain type (`int`, `string`, `float`, ...).
  - Structural equality in Ocaml is a single `=` and physical equality is `==` (we **WONT** be using `==`).
  - If/else in Ocaml is an expression, NOT a statement like it is in Java/C. That is, it evaluates to a result.
   Although it appears like an if/else statement, it is closer to the `?` (ternary) operator in Java. `if x > 5 then "big" else "small"` is similar to `x > 5 ? "big" : "small"`.
   Since OCaml is statically typed, it needs to assign a type to the if/else expression. For this to succeed, both the `then` and the `else` branch MUST be of the same type.

3. Functions
    - OCaml functions are created like variables
        - There's a keyword ("let") followed by the function name and parameters.
        - This is followed by an equals sign, and then the body of the function
        - Also like Ruby, you don't need to say return. Functions return the last value.
    - Unlike Ruby, you can't have "steps" of statements. This will become more clear the more you work with the language.
    - Functions are first class data!!!
        - Functions also have types
        - Show a basic example (e.g. `let f x = x + 1` is `int -> int`)
        - Functions can be assigned to variables, passed to other functions, and returned from functions, like objects!! More on that next week.

4. Lists
  - Like most languages, defined with square brackets []
  - Unlike Ruby lists, OCaml lists can only contain one type (i.e. they are homogenous)
  - Items are separated by semicolons, not commas
  - Lists are inserted into using colons
      - `1::[] -> [1]`
      - This operator is called `cons`. Make it a habit to call it `cons`.
      - For `a::b` to succeed, a must be of type `'a` and b must be of type `'a` list
  - They are linked lists; you cannot index them, and we disallow iteration
      - Every list is a head, with a reference to a tail (the rest of the list)
      - We don't have the whole `class LinkedList contains Node head` and `class Node contains data` kind of structure anymore. In OCaml, it's `me` and `the rest of the list`.

5. Pattern Matching
    - OCaml has this really cool feature where you can match data by structure
    - The syntax for this is, 
        - `let f x y = match x with [] -> 0`
            - This says, we're going to match the parameter x with the structure of an empty list, and return 0
    - Lists are what you'll primarily be matching, and there are some important match structures to know (replace the brackets in that function with these)
        - `h::t` matches the head (first element) and tail (remaining list) of a list
        - `h::[]` matches a list with a single element and binds `h` to that element
        - `[h]` does the same
        - `h1::h2::t` matches the first two elements of a list (similar to h::t)
        - `h::_` matches the head of the list and discards the tail.
        - `_::t` matches the tail of the list and discards the head.

6. Polymorphism
   - In OCaml, certain functions can be applied to several types. For example, consider `let cons elem lst = elem::lst` can logically take an `int` and an `int list` or a `string` and `string list` or any `X` and `X list`. Since OCaml is obsessed with assigning types to everything, it will assign use `'a` to mean an uncertain type. The function `cons` would be `'a -> 'a list -> 'a list`. 
   - Note: `'b` is used when you have a type which may or may not be the same as `'a`. For example, `let first_arg a b = a` is a function where `a` and `b` may or may not be the same type.
