# Hylang Practice
A repo for familiarizing myself with Hy syntax and idioms. I'm nowhere near being able to leverage Lisp-type idioms such as macros yet (have to learn Lisp for that), but I can at least work toward comfortably writing Python in Hy.

---

# How do I [...] in Hy?

## Import Modules

```hy
; Hy imports
; Specify namespace using keyword `as`
(import
  argparse
  pathlib [Path]
  ; third-party libs
  matplotlib [
      colors
      pyplot :as plt
      animation
  ]
  numpy :as np
  kmeans *  ; global import
)
; can have multiple import expressions
(import itertools)
```

```python
# Python equivalent
import argparse
from pathlib import Path
# third-party libs
from matplotlib import colors, pyplot as plt, animation
import numpy as np
from kmeans import *

import itertools

```

---

## Set variables

```hy
>>> (setv var-name value)
(setv
    x 3
    y 4)
>>> (setv [x y] [y x])  ; x = 4; y = 3
>>> (setv [a b #* c] [1 2])
a = 1
b = 2
c = []
```

## Pass in keyword arguments

```python
"Use the `:keyword` symbol followed by the value"
(somefunc :this_keyword 10)
(print "text1" "text2" :sep "\n")
```

## Perform conditional logic

Use macros. 

```hy
(if (and True False)
  (something)
  (something else))  ; second clause is the else statement
```

`pass` doesn't appear to be a keyword, so just put `None` instead

```hy
(if (not some_really_detailed_condition)
  (do    ; This allows us to execute multiple statements in the if macro
    (foo x y)
    (bar j)
    (baz))
  None)  ; else pass
```

Alternatively, use then `when` macro which is syntactic sugar for `(if <condition> <true-clause> None)`:

```hy
(when (not some_really_detailed_condition)
  (do
    (foo x y)
    (bar j)
    (baz))
  (do 
    second thing)
  (do third thing))
```

`cond` allows you to perform the `if...elif...` chain:

```hy
(cond 
  (CONDITION 1)   ; if
    (do stuff)
  (CONDITION 2)   ; elif
    (do this instead)
  ...
  (CONDITION N)   ; elif
    (have we hit True yet?)
  ; # Optional if we want to provide our own else clause
  True
    (This is the else clause))
```

## Use flow control (`for`, `while`)

* https://hylang.org/hy/doc/v0.28.0/api#for
* https://hylang.org/hy/doc/v0.28.0/api#while

```hy
(while (CONDITION)
  ; loop execution here
  LOOP BODY
  ; optional. Executes if loop exits naturally (the condition is broken)
  (else
    BODY))

; for loop
(for [variable iterable]
  BODY
  (else
    BODY))

; try this
(setv greeting "Hello, World!")
(for [[i char] (enumerate greeting)]
  (print i char :sep ": "))
; I don't use async for loops, but you can look at the docs to learn how to do that
```


## Create a new function

* [Named Functions](https://hylang.org/hy/doc/v0.28.0/api#defn)
* [Lambda Functions](https://hylang.org/hy/doc/v0.28.0/api#fn)
  
```hy
; Named
(defn <function_name> [<arglist>]
    <body>)

; Anonymous
(fn [x] (* x x))  ; Pass as an argument or assign it a name using `setv`
```

Optionally, you can use decorators, define type parameters, and provide a function return annotation before declaring the function name. If you include more than one of the optional descriptors, they must appear in the above order.

```hy
(defn [decorator1 decorator2] :tp [T1 T2] #^ type-annotation func-name [params] ...)
```

Here is an (involved) example:


```hy
; Hy version
(defn #^ (get tuple #(dict np.ndarray)) cluster [
  #^ list data
  #^ int k
  *
  [initial_means None]
  #^ int [ndim None]
  #^ float [tolerance 0.001]
  #^ int [max-iterations 250]
]
  ; BODY
  ...)
```

```python
# Python version
def cluster(
        data: list,
        k: int,
        *,
        initial_means = None,
        ndim: int = None,
        tolerance: float = 0.001, 
        max_iterations: int = 250,
) -> tuple[dict, np.ndarray]:
  # BODY
  ...
```

For `*args` and `**kwargs`, use the Hy equivalent `#* args` and `#** kwargs`.


## Define default values to functions
   
```hy
; Example 
; #* is the `unpack-iterable` macro (applies to `e`)
(defn test [a b [c None] [d "literal"] #* e]  
    [a b c d e])

(print (test 1 2))            ; => [1, 2, None, 'x', ()]
(print (test 1 2 3 4 5 6 7))  ; => [1, 2, 3, 4, (5, 6, 7)]  
```

## Define a class

```hy
(defclass FooBar [<insert super classes here>]
    (defn __init__ [self x]
        (setv self.x x))
    (defn get-x [self]
        self.x))
```

## Access class attributes and methods

```hy
(import numpy :as np)
(setv arr (np.arange 10))
(print arr.shape)                 ; => (10,)
(print (. arr shape))             ; => (10,)
(print (.sum fb))                 ; => 45
(print (arr.sum :axis None))      ; => 45
(print (. arr (sum :axis None)))  ; => 45
```
