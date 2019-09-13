# Project 2A: OCaml Warmup

Due: September 19 (Late September 20) at 11:59:59 PM

Points: 65P/35R/0S

## Introduction
The goal of this project is to get you familiar with programming in OCaml. You will have to write a number of small functions, each of which is specified in three sections below.

We recommend you get started right away, going from top to bottom. The problems get increasingly more challenging, and in some cases later problems can take advantage of earlier solutions.

### Ground Rules
In your code, you may **only** use library functions found in the [`Pervasives` module][pervasives doc]. This means you **cannot** use the List module or any other module. You may **not** use any imperative structures of OCaml such as references. The `@` operator is **not** allowed.

### Project Files
To begin this project, you will need to pull updates from the git repository. The following are the relevant files:

- OCaml Files
    - **src/basics.ml**: This is where you will write your code for all parts of the project.
    - **src/basics.mli**: This file is used to describe the signature of all the functions in the module. Don't worry about this file, but make sure it exists or your code will not compile.
- Submission Scripts and Other Files
    - **submit.jar**: Run `java -jar submit.jar` to submit your project to the submit server.
    - **.submit**: Don't worry about this file, but make sure you have it.

### Notes on OCaml
OCaml is a lot different than languages you're likely used to working with, and we'd like to point out a few quirks here that may help you work your way out of common issues with the language.

- Some parts of this project are additive, meaning your solutions to earlier functions can be used to aid in writing later functions. Think about this in part 3.
- Unlike most other languages, = in OCaml is the operator for structural equality whereas == is the operator for physical equality. All functions in this project (and in this class, unless ever specified otherwise) are concerned with *structural* equality.
- The subtraction operator (-) also doubles as the negative symbol for `int`s and `float`s in OCaml. As a result, the parser has trouble identifying the difference between subtraction and a negative number. When writing negative numbers, surround them in parentheses. (i.e. `some_function 5 (-10)` works, but `some_function 5 -10` will give an error)

You can run the tests by doing `dune runtest -f`. We recommend you write student tests in `test/student.ml`.

You can interactively test your code by doing `dune utop src` (assuming you have `utop`). Then after doing `open Basics` you should be able to use any of the functions. All of your commands in `utop` need to end with two semicolons (i.e. `;;`), otherwise it will appear that your terminal is hagning.

### Important Notes about this Project
1. If a function is not defined with the `rec` keyword, you can still add `rec` to the function definition. The only reason we don't include the `rec` keyword for certain functions is to show that the function can be written without recursion.
2. You can always add a helper function for any of the functions we ask you to implement, and the helper function can also be recursive.
3. You may move around the function definitions. For example, if you think that a function from Part 2 can help you implement one of the functions for Part 1, you can move the definition of the function from Part 2 to Part 1. If you want to use a function, the function must already be defined. As long as you still pass the tests and you haven't created a syntax error, you are fine.
4. Pay special notice to the function types. Often times, you can lose sight of what you're trying to do if you don't remind yourself what all the arguments are and what you're trying to return.

## Part 1: Non-Recursive Functions
Implement the following functions that do not require recursion. Accordingly, these functions are defined without the `rec` keyword, but **you MAY add the `rec` keyword to any of the following functions or write a recursive helper function**.

#### rev_tup tup
- **Type**: `('a * 'a * 'a) -> ('a * 'a * 'a)`
- **Description**: Returns a 3-tuple in the reverse order of `tup`.
- **Examples:**
```
rev_tup (1, 2, 3) = (3, 2, 1)
rev_tup (1, 1, 1) = (1, 1, 1)
```

#### max_tup tup
- **Type**: `(int * int * int) -> int`
- **Description**: Returns the largest `int` in the 3-tuple `tup`.
- **Examples:**
```
max_tup (1, 2, 3) -> 3
max_tup (1, 1, 3) -> 3
max_tup (1, 2, 2) -> 2
max_tup (1, 1, 1) -> 1
```

#### abs x
- **Type**: `int -> int`
- **Description**: Returns the absolute value of `x`.
- **Examples:**
```
abs 1 = 1
abs (-5) = 5
```

#### area x y
- **Type**: `(int * int) -> (int * int) -> int`
- **Description**: Takes in the Cartesian coordinates (2-dimensional) of two opposite corners of a rectangle and returns the area of the rectangle. The sides of the rectangle are parallel to the axes.
- **Examples:**
```
area (1, 1) (2, 2) = 1
area (2, 2) (1, 1) = 1
area (0, 1) (2, 3) = 4
area (1, 1) (1, 1) = 0
```

#### volume x y
- **Type**: `(int * int * int) -> (int * int * int) -> int`
- **Description**: Takes in the Cartesian coordinates (3-dimensional) of two opposite corners of a rectangular prism and returns its volume. The sides of the rectangular prism are parallel to the axes.
- **Examples:**
```
volume (1, 1, 1) (2, 2, 2) = 1
volume (2, 2, 2) (1, 1, 1) = 1
volume (0, 1, 2) (2, 3, 5) = 12
volume (1, 1, 1) (1, 1, 1) = 0
```

#### equiv_frac (a, b) (x, y)
- **Type**: `(int * int) -> (int * int) -> bool`
- **Description**: Takes in two fractions in the form of 2-tuples, a/b and x/y, and returns whether or not the two fractions are equivalent. In the case of division by 0, `false` should be returned. The optimal solution does not require recursion, but again, you **may** add the `rec` keyword or define your own recursive helper function if you would like.
- **Examples:**
```
equiv_frac (1, 2) (2, 4) = true
equiv_frac (2, 4) (1, 2) = true
equiv_frac (1, 2) (1, 2) = true
equiv_frac (3, 12) (2, 6) = false
equiv_frac (1, 2) (3, 4) = false
equiv_frac (1, 0) (2, 0) = false
```

## Part 2: Recursive Functions
Implement the following functions using recursion.

#### factorial x
- **Type**: `int -> int`
- **Description**: Returns the factorial of `x`. You can assume `x` is non-negative.
- **Examples:**
```
factorial 3 = 6
factorial 2 = 2
factorial 1 = 1
```

#### pow x p
- **Type**: `int -> int -> int`
- **Description**: Returns `x` raise to the `p`. Assume `p` is non-negative.
- **Examples:**
```
pow 3 1 = 3
pow 3 2 = 9
pow (-3) 3 = -27
```

#### tail x num
- **Type**: `int -> int -> int`
- **Description**: Returns the last `num` digits of `x`. If there are fewer than `num` digits in `x`, return `x` in its entirety. You may assume `num` and `x` are both non-negative.
- **Examples:**
```
tail 154 1 = 4
tail 154 2 = 54
tail 154 3 = 154
tail 154 4= 154
tail 154 0 = 0
```

#### log x y
- **Type**: `int -> int -> int`
- **Description**: Returns the log of `y` with base `x` rounded-down to an integer. You may assume the answer is non-negative, `x` >= 2, and `y` >= 1.
- **Examples:**
```
log 4 4 = 1
log 4 16 = 2
log 4 15 = 1
log 4 64 = 3
```

#### len x
- **Type**: `int -> int`
- **Description**: Returns the number of numerical digits in `x`.
- **Examples:**
```
len 1 = 1
len 10 = 2
len 15949 = 5
```

#### contains sub x
- **Type**: `int -> int -> bool`
- **Description**: Returns whether `sub` can be found (continuously) within the digits of `x`.
- **Examples:**
```
contains 1 1 = true
contains 1 19 = true
contains 445 1544533 = true
contains 123 1243 = false
contains 123 321 = false
```


## Part 3: Variable Lookup
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

## Academic Integrity
Please **carefully read** the academic honesty section of the course syllabus. **Any evidence** of impermissible cooperation on projects, use of disallowed materials or resources, or unauthorized use of computer accounts, **will be** submitted to the Student Honor Council, which could result in an XF for the course, or suspension or expulsion from the University. Be sure you understand what you are and what you are not permitted to do in regards to academic integrity when it comes to project assignments. These policies apply to all students, and the Student Honor Council does not consider lack of knowledge of the policies to be a defense for violating them. Full information is found in the course syllabus, which you should review before starting.

[pervasives doc]: https://caml.inria.fr/pub/docs/manual-ocaml/libref/Pervasives.html
[submit server]: https://submit.cs.umd.edu
[block scope]: https://www.geeksforgeeks.org/scope-rules-in-c/
