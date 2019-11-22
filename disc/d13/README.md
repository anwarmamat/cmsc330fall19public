# Discussion 13 (Fall 2019)

## OCaml Modules
* Modules in OCaml combine types, functions and data that are conceptually related
* Create a module using:
    ```
    module {ModuleName} = struct
        (* Definitions *)
    end
    ```
    * Example:
        ```
            module Naturals = struct
             let start = ref 0
             let next_natural = start := !start + 1; start
             let prev_natural = start := !start - 1; start
             let set_start v = start := v; ()
            end 
        ```
* Access module values using . operator. E.g.: List.length [], Naturals.start e.t.c
* Bring a modules data, function and type into scope by opening it. E.g `open Naturals`
* Use `let Open {ModuleName} in {expression}` to locally open a module.
    * This can help you prevent overshadowing names from other modules (polluting the namespace).
* Module signatures are like interfaces. They can be used to explicityly type your module (OCaml already infers your module's type). Only data defined in the signature is made known to a user of your module. 
    * This allows for abstraction.
    * Look at your discussion exercise for an example.

## Functors
*  Functors are "Functions" from module to module
*  With functors, you can define a module in a parameterized way. To get a specific implimentation of the module, you will have to provide another module as a parameter.