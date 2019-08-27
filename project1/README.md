# Project 1: WordNet
Due: September 10th (Late September 11th) at 11:59 PM
Points: 35P/35R/30S

## Before You Start
If you have not completed the installations required for this course, refer to the unofficial [Project 0](../project0). In order to do Project 1, you must have everything related to Ruby installed correctly (running the P0 public test will tell you if it is set up properly). If you have any troubles and/or concerns with installation, post on Piazza or come to office hours to talk to a TA.

## Introduction
[WordNet][wordnet home] is a semantic lexicon for the English language that is used extensively by computational linguists and cognitive scientists. WordNet groups words into sets of synonyms called *synsets* and describes semantic relationships between them. Relevant to this project is the *is-a* relationship, which connects a *hyponym* (more specific synset) to a *hypernym* (more general synset). For example, a plant organ is a hypernym to plant root and plant root is a hypernym to carrot.

## Structure of WordNet Graph
In order to perform operations on WordNet, you will construct your own representation of hypernym relationships using the provided graph implementation (in `graph.rb`). Each vertex `v` is a non-negative integer representing a synset id, and each directed edge `v->w` represents `w` as a hypernym of `v`. The graph is directed and acyclic (DAG), though not necessarily a tree since each synset can have several hypernyms. A small subset of the WordNet graph is illustrated below.
![Sample WordNet Graph][sample graph]

## Input File Formats
The WordNet is represented by two files which must each be formed as described below in order to be valid. A major part of this project will be to process and load from these supplied input files.

### Synsets File
The synsets file is a list of all of the synsets in WordNet (i.e. the vertices of the graph above). A synset is a list of nouns that share the same meaning. Each line of a valid synsets file consists of two fields:
- **Synset id**: A non-negative integer identifying the synset.
- **Synset**: A comma-delimited list of one or more nouns that belong to the synset. Nouns are made up of letters (uppercase and lowercase), numbers, underscores, dashes, periods, apostrophes, and forward slashes. These criteria will always define valid nouns wherever valid nouns are referenced in this document.

**Note**: A noun can appear in more than one synset. A noun will appear once for each meaning the noun has. For example, all of the following synsets contain the noun "word", but with different meanings.
```
id: 37559 synset: discussion,give-and-take,word
id: 50266 synset: news,intelligence,tidings,word
id: 60429 synset: parole,word,word_of_honor
id: 60430 synset: password,watchword,word,parole,countersign
```

### Hypernyms File
The hypernyms file contains the hypernym relationships between synsets. Each line of a valid hypernyms file contains two fields:
- **Synset id**: A non-negative integer identifying the synset these edges originate from.
- **Hypernym ids**: A comma-delimited list of one or more non-negative integers representing synsets that edges will go to.

Each line of the file represents a set of edges from a synset to its hypernyms. For example, the line
```
from: 171 to: 22798,57458
```
means that the synset 171 ("Actified") has 2 hypernyms: 22798 ("antihistamine") and 57458 ("nasal_decongestant"), meaning that Actified is both an antihistamine and a nasal decongestant. The synsets are obtained from lines in the synsets file with the corresponding synset ids.

**Note**: A synset's hypernyms are not restricted to being listed on a single line. They may be split among multiple lines. For example, the hypernyms from the example above may also be represented as follows:
```
from: 171 to: 22798
from: 171 to: 57458
```

## A Note on Types
Ruby has no built in way to restrict the types passed to methods. As such, all method types specified in this document are the only ones you need to handle. You may assume that no arguments will be passed outside of the types we specify, and your program may do anything in cases where improperly typed arguments are passed. This is undefined behavior for this program and will not be tested.

The expected types will be represented in the following format at the beginning of each section:
```
load : (String) -> Array or nil
```
This example defines a method called `load` that takes a single String as an argument and either returns an Array or nil, meaning that you may assume that a String will be passed in and you are responsible for ensuring that only an Array or nil is returned. This also means that a subclass of String could be passed in or that a subclass of Array could be returned.

**Note**: Some shorthand is used to avoid verbosity in type siguatures.
- `Integer` is used to refer to the union of `Fixnum` and `Bignum`.
- `Bool` is used to refer to the union of `TrueClass` and `FalseClass`.
- `nil` is used to refer to `NilClass`.

## Part 1: Synsets
The first part of this project consists of parsing from the synset file and implementing operations that pertain to single synsets. Information on the valid file format can be found above. These methods will be implemented in the `Synsets` class in `wordnet.rb`.

The methods you must implement have the following signatures:
```
class Synsets
    addSet : (Integer, Array) -> Bool
    load : (String) -> Array or nil
    lookup : (Integer) -> Array
    findSynsets : (Object) -> Array or Hash or nil
end
```

### Adding to the Synsets
You must first implement a method `addSet(synset_id, nouns)` which, given a non-negative synset id and an array of nouns in the synset, adds this entry to the object. If the synset id is negative, the list of nouns is empty, or the synset id has already been defined, return false without modifying the current object. Otherwise, return true and store the new synset.

### Loading from File
You must next implement a method `load(synsets_file)` which, given a String representing a path to the synset file to load, validates the file and stores its contents in a logical way. The exact internal representation of the data is up to you, but a hash is a very advisable structure for this purpose.

You may assume that the file exists. If any line is invalid misformed according to the rules in the file format section, the object's state should not be changed and an array of invalid line numbers (indexed from 1) should be returned in ascending order. Additionally, lines attempting to re-define a synset should be counted as invalid and be added to this array. That is:
```
id: 37559 synset: discussion
...
id: 37559 synset: word
```
should not create a synset with two words, but should rather count the second definition as an invalid line.

This method may be called multiple times. Repeated loads should each augment the contents of the structure, adding all entries from the new file to the current instance and essentially behaving like extensions of previous loads, almost like one single long file.

If all lines of the file are properly formed as described in the file format section, then the data should be stored (again, exactly how is up to you) and `nil` should be returned. If any lines are misformed as described above, the load should fail, the stored data should remain exactly as before the call (even ignoring correct lines from the file), and the aforementioned array of line numbers (indexed from 1) should be returned.


### Lookup Operations

The method `lookup(synset_id)` should take a synset id and return an array of the nouns in the synset. If there is no entry for the requested id, return an empty array.

The method `findSynsets(to_find)` will behave differently depending on if it is given a String or an Array as its argument.
- **String**: When supplied a String, this method should return an array of 0 or more synset ids corresponding to synsets containing this noun.
- **Array**: When supplied an array of nouns, this method should return a hash where each key is a single noun from the array and each value is an array of synset ids corresponsing to synsets containing the noun. This is similar to when a String argument is provided, but allows for batch processing.
- **Anything else**: If anything but a String or an Array is provided, this method should simply return `nil`.

## Part 2: Hypernyms
The second part of this project requires you to construct and operate on a graph representing the hypernym relationships among members of the WordNet.

For the `Hypernyms` class, the methods you must implement have the following signatures:
```
class Hypernyms
    addHypernym : (Integer, Integer) -> Bool
    load : (String) -> Array or nil
    lca : (Integer, Integer) -> Array or nil
end
```

### Adding Edges
You must first implement a method `addHypernym(source, destination)` which, given two synset ids, creates a hypernym relationship where the destination is a hypernym of the source. This method should return `false` if either supplied synset id is negative or if both synset ids are the same. Otherwise, the new hypernym relationship should be added and `true` should be returned. If the hypernym relation already exists, you should still return true.

### Loading from File
Just as in part 1, you must implement a method `load(hypernyms_file)` which, given a String representing a path to the hypernyms file to load, validates the file and stores its contents in an instance of the provided graph class. Although you are not responsible for writing the `Graph` class yourself, you are responsible for understanding how it works.

You may assume that the file exists. If any line is invalid misformed according to the rules in the file format section, the object's state should not be changed and an array of invalid line numbers should be returned in ascending order. Unlike part 1, lines that are properly formed but define edges from an id that has already had outgoing edges defined should be counted as **valid**. That is:
```
from: 1 to: 2
...
from: 1 to: 4
...
from: 1 to: 4
```
should count all three lines as valid, but should not actually create duplicate edges.

If any line of the file is invalid, the object's state should not be changed and an array of invalid line numbers should be returned. If all lines of the file are properly formed as described in the file format section, then the data should be stored and `nil` should be returned.

This method may be called multiple times. Repeated successful loads should each augment the contents of the structure, treating it just like an initial load. However, if a load fails on a structure that has already been successfully loaded, the data should not be replaced or affected in any way.

### Ancestral Paths

In this part, you will find the least common ancestors of two nouns. An ancestral path between two ids `v` and `w` in the graph is a directed path from `v` to a common ancestor `x`, together with a directed path from `w` to the same ancestor `x`. A shortest ancestral path, or *SAP*, between ID `v` and ID `w` is an ancestral path of minimum total length. The common ancestor that participates in the path is called the lowest common ancestor, or *LCA*, of v and w. In the graph below, one ancestral path between ids 4 and 6 is of length 3 with common ancestor 5 (4->5 and 6->7->5). However, the SAP between 4 and 6 is of length 2 with common ancestor 7 (4->7 and 6->7). This makes 7 the LCA of 4 and 6.
![Ancestry Example][ancestry example]

The method `lca(id1, id2)` should take a synset id and return an array of all synset ids that are lowest common ancestors of the two provided synset ids according to the definition provided above. If either of the ids are not contained in the graph, this method should return `nil`. If no common ancestor is found, then an empty array should be returned.

## Part 3: WordNet Command Line
We have provided a simple frontend to WordNet for you, however we have not implemented the parser that recognizes commands and gives back responses. The frontend can be started by running `interactive.rb` (which you do not need to modify, though you may if you would like to add your own testing features).

The WordNet environment tracks an instance of `Synsets` and an instance of `Hypernyms` and performs operations on them according to provided commands. The structure of the `CommandParser` class is as follows:
```
class CommandParser
    parse : (String) -> Hash
end
```

### Parsing Commands

All you must implement for the `CommandParser` class is the method `parse(command)`. This method is given a String command and is responsible for performing an action and providing a response. A command may contain arbitrary leading and trailing whitespace, and arguments may be separated by one or more whitespace characters. A response is represented as a hash with entries as follows:
- **:recognized_command** *(the leading colon is intentional; [this is a symbol, not a String][symbol documentation])*: This will vary based on the command, but the purpose is to identify how to process the data portion of the response. Each command section that follows will clearly specify what to set this field to. If the command is not recognized, set the value to `:invalid`.
- **:result**: This key's value will correspond to the resulting data after processing the command.

The commands that you will need to parse are as follows:

---
#### load
**Recognized Command**: `:load`

**Command Format**: `load <synset_file> <hypernym_file>`

**Behavior**: The load command takes two arguments, the synset file name and the hypernym file name respectively. File names may contain word characters (i.e. letters, numbers, and underscores) as well as forward slashes, dashes, and periods and must be validated as part of checking the structure of the command. The files should be load into `Synsets` object and the `Hypernyms` objects using their `load : (String)` methods. Neither object should be modified unless all the following conditions are met:
- The synset file is valid
- The hypernym file is valid
- All synsets referenced by the hypernym file are defined in the synsets file or in the already-loaded synsets of the contained `Synsets` object (remember, multiple loads augment the data instead of replacing it).

You may add any methods you need to any of the provided classes in order to validate these criteria.

The `:result` field should be set to `true` in case of success and `false` in case of failure according to the criteria above. If the command is misformed or additional arguments are supplied, then set `:result` to `:error`.

When using the interactive terminal, this is an example of expected behavior:
![An example of the interactive terminal][interactive example]

---
#### lookup
**Recognized Command**: `:lookup`

**Command Format**: `lookup <synset_id>`

**Behavior**: The lookup command takes exactly one synset id as an argument and sets `:result` to whatever is returned by calling `lookup : (Integer)` on the `Synsets` object. If the synset id isn't properly formed (by the same rules as the synset input file) or the wrong number of arguments is supplied then `:result` should be set to `:error`.

---
#### find
**Recognized Command**: `:find`

**Command Format**: `find <noun>`

**Behavior**: The find command sets `:result` to the result of `findSynsets : Object` called with only **one** noun passed as a single String. If the noun is invalid (by the same rules as the synset input file) or additional arguments are supplied then `:result` should be set to `:error`.

---
#### findmany
**Recognized Command**: `:findmany`

**Command Format**: `findmany <noun1>[,<noun2>,<noun3>...]`

**Behavior**: The findmany command sets `:result` to the result of `findSynsets : Object` called with **one or more** nouns passed as an Array. The list of nouns will be comma separated with no whitespace just as in a valid input file. If the form of the list isn't valid or additional arguments are supplied, then set `:result` to `:error`.

---
#### lca
**Recognized Command**: `:lca`

**Command Format**: `lca <id1> <id2>`

**Behavior**: The lca command takes two synset ids as arguments and looks up their least common ancestors. The `:result` field should be set to the result of calling `lca : (Integer, Integer)`, or `:error` if the command is misformed (i.e. wrong number of arguments or the arguments are not valid Integers).

## Submitting
To submit the project go to the project folder in a terminal and run `java -jar submit.jar`.  It will prompt you for you login the first time, use your directory ID and password.  If for some reason this does not work, you can simply upload the `wordnet.rb` file to the submit server manually.

## Academic Integrity
Please **carefully read** the academic honesty section of the course syllabus. **Any evidence** of impermissible cooperation on projects, use of disallowed materials or resources, or unauthorized use of computer accounts, **will be** submitted to the Student Honor Council, which could result in an XF for the course, or suspension or expulsion from the University. Be sure you understand what you are and what you are not permitted to do in regards to academic integrity when it comes to project assignments. These policies apply to all students, and the Student Honor Council does not consider lack of knowledge of the policies to be a defense for violating them. Full information is found in the course syllabus, which you should review before starting.

[wordnet home]: http://wordnet.princeton.edu/
[cloning instructions]: ../git_cheatsheet.md
[sample graph]: images/sample-graph.png
[ancestry example]: images/ancestry-example.png
[symbol documentation]: https://ruby-doc.org/core-2.3.0/Symbol.html
[interactive example]: images/interactive-example.png
[submit server]: submit.cs.umd.edu
[web submit link]: images/web_submit.jpg
[web upload example]: images/web_upload.jpg
