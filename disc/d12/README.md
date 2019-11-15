# Discussion 12 - CMSC330 Fall 2019

## Rust Motivation
* Needs of the community: memory management, thread safety, speed
* Paradigms: both functional and imperative, but emphasizes functional
* Syntactically similar to C/C++ but semantically more like OCaml
* Statically scoped, statically typed, no type inference, compiled, explicit declarations
* The compiler is bootstrapped - which means that the compiler for Rust is written in Rust
 * There are issues with this - it's [vulnerable](https://github.com/rust-lang/rust/issues/48707) to [trusting-trust attacks](https://en.wikipedia.org/wiki/Backdoor_(computing))

## Rust setup / Cargo
* For most people: Go to Rust's [website](https://www.rust-lang.org/en-US/) and follow the instructions. Hopefully they did this as part of P0.
* Grace: Use the command "module load rust" to setup the environment.
* You can experiment w/ code snippets here: https://play.rust-lang.org/
* Cargo
	* "Cargo downloads your Rust project’s dependencies and compiles your project."
	* Create new project w/ `cargo new project_name` (use `lib` option to create a library instead of a binary)
		* Eric did this for the discussion exercises already
	* (`cd` into the project directory)
	* Build project w/ `cargo build`
	* Run tests w/ `cargo test test_name` (or omit test_name to run all tests)
		* `cargo test` builds the project automatically
		* You can demonstrate this w/ the discussion exercises.

## Ownership
* Basics
	* Each value has a variable which is its owner.
	* There can be one owner at a time.
	* When an owner goes out of scope, the value is dropped (freed)
* Transfer of ownership
```
x = String::from("hello"); // x is the owner
y = x; // now, y is the owner
println!(x) // fails
```
* ...
	* Here x transfers ownership of the string to y.
	* After x transfers ownership, you can't "use" (e.g. modify, print) x. It will not compile.
	* `y = x;` basically renames the string from x to y, and you'd better just forget about x.
	* In Rust-speak, this is called a move.
	* An exception is primitive values
		* x = 3; y = x; does not do a move. Primitive values are copied.
* References and borrowing
	* A reference is like a pointer. There are 2 kinds:
		* An immutable reference `&x`
		* A mutable reference `&mut x`
	* You can either have any number of immutable references OR 1 mutable reference, but not both.
	* You can't make a mutable reference of an immutable variable (that doesn't make sense). In that case, you can only have any number of immutable references.
	* When you make a mutable reference, it borrows mutate privileges from the owner.
	* When the mutable reference goes out of scope, it returns mutate privileges to the owner.
```
x = String::from("hello"); // x is the owner
{ // new scope
		y = &mut x; // y is a mutable reference of x
		z = &x; // fails because x has a mutable reference, x can't have an immutable reference (and vice versa)
		z = &mut x; // fails because x can only have 1 mutable reference.
		x.push_str("friend"); // fails because y has mutate privileges now
		y.push_str("friend"); // ok because y has mutate privileges now
} // y leaves scope, and gives mutate privileges back to x
x.push_str("friend"); //ok because x has mutate privileges now
```
* ...
	* Metaphor:
		* Owner x has a mini-whiteboard. When x leaves scope, x is responsible for throwing the mini-whiteboard in the trash (freeing the memory).
		* x can have any number of immutable references OR 1 mutable reference.
		* Any number of immutable references is a bunch of VIEWERS a, b, c who are viewing x's whiteboard from afar. Their eyes are locked onto x. The viewers can't edit the whiteboard.
		* 1 mutable reference is a person d who borrows x's whiteboard. d can't do this if there are already viewers a, b, and c who have their eyes fixed on x. d can edit the whiteboard, but now x can't. When d goes out of scope, d returns the whiteboard to x.
	* Functions which edit a parameter use a mutable reference.
	* Functions which view a parameter use an immutable reference.
