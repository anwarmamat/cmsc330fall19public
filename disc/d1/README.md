# Discussion 1 - CMSC330 Fall 2019

## Administrative/Announcements

1. Welcome to CMSC330!

2. This class is about learning different programming paradigms. You will learn to program in Ruby and OCaml, and possibly receive a brief introduction to Rust. Over the duration of the class, you will come to realize that this class is not so much about learning these 3 languages as it is about learning *when* to use them, what their strengths/weaknesses are, and the history behind their making. In addition to learning programming languages, about half the semester will be devoted to concepts about how languages work - how those letters you type on your screen turn into machine code. We will go over automatons, tokenizing, parsing, lambda calculus and such.

3. Tips for getting a good grade in 330:
  * Start projects early! 40% of your grade is projects. Some individual projects may be worth as much as 8%, which means if you get 50/100 on the project, you're already losing half a letter grade! Conversely, you can excel at projects and really boost your grade.
  * Use previous quizzes and exams. They are up on the course website and they're highly representative of all the quizzes and exams we'll have this semester.
  * Come to class and discussion. We'll be showing some really cool examples.
  * Please ask us conceptual questions in office hours. TAs love getting questions like "I don't understand X, could you clarify it for me please?".

4. You may attend any discussion if you oversleep, have an interview etc. On quiz days, however, you MUST notify both your own TA and the TA whose discussion you will be attending, and must have very good reason to attend a different section.

5. Often, students run into similar problems, or have similar questions. Make sure to check Piazza before coming to office hours for answers to your questions. Use the Piazza search bar before posting a new question.

6. Project 1 is up and is due on the 10th of September.

7. Project 0 should be done by now. Use c9.io or Grace for now if you haven't done it already but you MUST finish it over the weekend.


## Ruby

1. Ruby is a dynamically typed, implicitly declared, interpreted scripting language. In this class, we really care about terminology like this - knowing what these terms mean makes it so much easier to pick up new languages with similar features.

Dynamic typing means that variables don't have a fixed type (like they do in Java). It also means that types are checked at runtime and not at compile time like statically typed languages (e.g Java). A variable `x` can be an `int` (specific to Ruby: `FixNum`) for the first 5 lines and then you can make it a `string`. Implicit declaration means that you don't need to tell the compiler or interpreter that you can declaring a new variable - you can just assign to it and start using it.

An interpreted language is one where the interpreter converts the first line of source code to machine code, runs it, then moves on to the second line, converts and runs, moves on to the third, and so on and so forth. This is different from Java or C (which are compiled), and the compiler converts all of the source code to machine code first, then runs the whole thing.

2. Try a few examples in irb:
  * Type `a = 1` followed by `a = "hi"` and then `puts a` to demonstrate implicit declaration and dynamic typing
  * Ruby has `if`, `elsif` and `else` which do what you think they would do. It also supports trailing `if` (for example, try `puts "hi" if 4 > 2`). This is especially useful if you have a method that needs to check for input validity (e.g. `return ERROR if invalid(input)`).
  * Ruby doesn't have the `++` operator.
  * All variables in Ruby are objects. No primitives. Even numbers and bools are objects. In fact `5 + 7` is syntactic sugar for calling the method `+` on the object 5 and passing the object 7 as an argument, i.e., `5.+(7)`. You can often skip parenthesis in Ruby method calls, e.g. with the `puts()` method.
  * Try `.inspect` and `.methods`. E.g. `"hi".methods` will list all String methods. Library convention is that methods which return a `bool` end in `?` and methods that modify the string/array/object end in `!` (e.g. `include?` checks if a string contains a substring or not). The `.inspect` method will print arrays like you would see them in source code (e.g. try `puts a.inspect` where `a` is some array).

3. Clone today's discussion from the public repo.
	This can be done by `git clone "https://github.com/anwarmamat/cmsc330spring19-public"`.
 Today's exercises ARE GRADED, and we have provided the public tests in public.rb to test your code. We will have **unannounced** graded labs (like mini-mini projects or worksheets).

  * Arrays in Ruby are heterogenous and of indefinite length because Ruby loves you. Can be declared using `Array.new()` or `[]`. Example: shift_letters (Note: this example has some Character methods we don't expect you to memorize)
  * Hashes in Ruby can have heterogenous keys. What data structure in Java are hashes most similar to? (Hint: it's in the name). You should learn to love hashes. They can be initialized using `{}` or `Hash.new(default value)`. Example: add_to_inventory
  * Classes in Ruby are straightforward. Constructor must be named `initialize`. You may not overload constructors - or any method for that matter. Instance variables have an `@`. Static variables have an `@@`. Example: WordCount
  * Testing in Ruby is done using Minitest. A class must be defined that extends `Minitest::Test`. The `setup` function is run before each test in case you want to setup/cleanup before each test. Test names start with `test_` and have various assert statements.
  Check out `public.rb`. In the past, we've had students who got full points on public and release test for P1 but 0s on the secret tests, so learn how to use Ruby testing and write student tests!
