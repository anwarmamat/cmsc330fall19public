# Discussion 2 - CMSC330 Fall 2019

## Announcements

1. You may attend any discussion if you oversleep, have an interview etc. On quiz days, however, you MUST notify both your own TA and the TA whose discussion you will be attending, and must have very good reason to attend a different section.

2. Check Piazza before coming to office hours. Use the Piazza search bar before posting a new question.

3. Project 1 is up, due Tuesday, September 10th.

4. Project 0 was due last week. Use c9.io for now if you haven't done it already but you MUST finish it over the weekend.

5. Some useful git commands are:<br/>
    a) **git clone:** git clone is used to get a copy of a remote git repository on your local file system. When you clone a repository,
    you not only get its current state (all its files and folders), you also get its history (past commits) as well as other important data about the repository. You only have to run this command once as long as you don't delete the local repository from your file system. The syntax is `git clone <url>`<br />
    b) **git pull:** git pull fetches the most up to date version of your local git repository from its remote location and merges any updates from the remote copy of the local branch you have checked out into the local copy. You will most likely stick to the master branch (the default branch) unless you are more familiar with git. Every update made to the github repository for this class (like new projects and discussion exercises) will be on the remote master branch. Therefore, running `git pull origin master` will automatically update your local master brach with the most up to date changes from the remote master branch.
## Ruby

1. `Code blocks`. 
  * Code blocks are similar to lambda expressions in Java. They are like functions that can be passed to other functions.
  * Functions that accept code blocks are able to perform a general task, calling a code block to handle the part of the task that is specific to what the user of the function is trying to achieve.
  * Some examples of Ruby builtin functions that accept code blocks are: `each` method of arrays and hashes, `map` method of arrays.
  * Your functions can also accept and use code blocks.

2. `Yield`. This is how you handle code blocks that others pass to you.
   * ALL functions take a HIDDEN code block argument. This code block can be called with `yield` for no arguments, yield(x) for one argument, yield(x,y) for two and so on.
   * Here are some basic examples.

   ```
   def do_it_twice
     yield
     yield
   end

   do_it_twice { puts "hello" }
   > hello
     hello
   ```

   ```
   def do_it_with_1_and_10
     yield 1
     yield 10
   end

   do_it_with_1_and_10 { |x| puts x }
   > 1
     10
   ```

3. `Regex`
   * Regular expressions define and test the structure of strings.
   * Ruby has excellent support for them, and you will want to use them in your project.
   * There are three main components of regular expressions
     * Literals, like 1 or hello or faf3ga4ga4a
     * Character classes, like `\w `or `[A-Za-z0-9]`
     * Operators, like `\*, ?, +, {0}`, etc.
   * The website [Rubular](https://rubular.com/) can be used to practice writing regular expressions as well as to test out your regular expression.
   * `=~` attempts to match a String w/ a Regexp. If a match is found, the index of the match is returned. If not, nil is returned.
    If the Regexp has parentheses, the substrings corresponding to the sets of parentheses are assigned to $1, $2, $3, and so on. (The order is from left to right based on the left parentheses.)
   * More Regex features can be found on the docs: <https://ruby-doc.org/core-trunk/doc/regexp_rdoc.html>

4. `Testing`
  * Writing student tests is very useful. The public test cases we provide for projects might cover the basics but there are still edge cases that need to be tested.
  * To write your student tests in Ruby, follow the structure found in public.rb and make the obvious changes.
    * Name the file something like student_test.rb. The name is for your reference.
    * Keep the two require statements found at the top  of public.rb.
    * Create your test class and make sure it extends the module `Minitest::Test`.
    * Write methods to test different functionalities and cases in your code, using assertions to verify your results. The documentation for assertions can be found [here](https://www.rubydoc.info/gems/minitest/5.9.0/Minitest/Assertions).
