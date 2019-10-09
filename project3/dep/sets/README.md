#### insert x a
- **Type**: `'a -> 'a list -> 'a list`
- **Description**: Inserts `x` into the set `a`.
- **Examples:**
```
insert 2 []
insert 3 (insert 2 [])
insert 3 (insert 3 (insert 2 []))
```

#### elem x a
- **Type**: `'a -> 'a list -> bool`
- **Description**: Returns true iff `x` is an element of the set `a`.
- **Examples:**
```
elem 2 [] = false
elem 3 (insert 5 (insert 3 (insert 2 []))) = true
elem 4 (insert 3 (insert 2 (insert 5 []))) = false
```

#### subset a b
- **Type**: `'a list -> 'a list -> bool`
- **Description**: Return true iff `a` **is a** subset of `b`. Formally, A ⊆ B ⇔ ∀x(xϵA ⇒ xϵB).
- **Examples:**
```
subset (insert 2 (insert 4 [])) [] = false
subset (insert 5 (insert 3 [])) (insert 3 (insert 5 (insert 2 []))) = true
subset (insert 5 (insert 3 (insert 2 []))) (insert 5 (insert 3 [])) = false
```

#### eq a b
- **Type**: `'a list -> 'a list -> bool`
- **Description**: Returns true iff `a` and `b` are equal as sets. Formally, A = B ⇔ ∀x(xϵA ⇔ xϵB). (Hint: The subset relation is anti-symmetric.)
- **Examples:**
```
eq [] (insert 2 []) = false
eq (insert 2 (insert 3 [])) (insert 3 []) = false
eq (insert 3 (insert 2 [])) (insert 2 (insert 3 [])) = true
```

#### remove x a
- **Type**: `'a -> 'a list -> 'a list`
- **Description**: Removes `x` from the set `a`.
- **Examples:**
```
elem 3 (remove 3 (insert 2 (insert 3 []))) = false
eq (remove 3 (insert 5 (insert 3 []))) (insert 5 []) = true
```

#### union a b
- **Type**: `'a list -> 'a list -> 'a list`
- **Description**: Returns the union of the sets `a` and `b`. Formally, A ∪ B = {x | xϵA ∨ xϵB}.
- **Examples:**
```
eq (union [] (insert 2 (insert 3 []))) (insert 3 (insert 2 [])) = true
eq (union (insert 5 (insert 2 [])) (insert 2 (insert 3 []))) (insert 3 (insert 2 (insert 5 []))) = true
eq (union (insert 2 (insert 7 [])) (insert 5 [])) (insert 5 (insert 7 (insert 2 []))) = true
```

#### diff a b
- **Type**: `'a list -> 'a list -> 'a list`
- **Description**: Returns the difference of sets `a` and `b`. Formally, A - B = {x | xϵA ∧ ~xϵB}.
- **Examples:**
```
eq (diff (insert 1 (insert 2 [])) (insert 2 (insert 3 []))) (insert 1 []) = true
eq (diff (insert 'a' (insert 'b' (insert 'c' (insert 'd' [])))) (insert 'a' (insert 'e' (insert 'i' (insert 'o' (insert 'u' [])))))) (insert 'b' (insert 'c' (insert 'd' []))) = true
eq (diff (insert "hello" (insert "ocaml" [])) (insert "hi" (insert "ruby" []))) (insert "hello" (insert "ocaml" [])) = true
```

#### cat x a
- **Type**: `'a -> 'b list -> ('a * 'b) list`
- **Description**: Returns the set with each element replaced by a tuple of x and itself.
- **Examples:**
```
eq (cat "z" (insert "a" (insert "b" []))) (insert ("z", "a") (insert ("z", "b") [])) = true
eq (cat 1 []) [] = true
```

[pervasives doc]: https://caml.inria.fr/pub/docs/manual-ocaml/libref/Pervasives.html
[git instructions]: ../git_cheatsheet.md
[submit server]: https://submit.cs.umd.edu
[web submit link]: ../common-images/web_submit.jpg
[web upload example]: ../common-images/web_upload.jpg
[Pythagorean Theorem]: https://en.wikipedia.org/wiki/Pythagorean_theorem
[sum of cubes]: images/sum-of-cubes.png
[Euclidean Algorithm]: https://www.khanacademy.org/computing/computer-science/cryptography/modarithmetic/a/the-euclidean-algorithm
[Ackermann–Péter function]:https://en.wikipedia.org/wiki/Ackermann_function
[SetOpCalc]: https://www.mathportal.org/calculators/misc-calculators/sets-calculator.php
[SetWiki]:https://en.wikipedia.org/wiki/Set_(mathematics)#External_links
