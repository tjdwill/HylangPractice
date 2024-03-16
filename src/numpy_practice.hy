"
@author: tjdwill
@date: 15 March 2024
@title: Numpy Exercises
@description: A few of the basic exercises from Rougier's 100 Numpy Exercises repo to acclimate myself to Hy's syntax.
"
(import os)
(. os (system "cls"))
; 1. Import the numpy package under name 'np'
(import numpy :as np)

; 2. Print the numpy version and configuration
(print "Numpy version: " (. np __version__))
(print "Numpy configuration:\n")
(np.show_config)

; 3. Create a null vector of size 10
; Rougier means "zero" when he says "null".
(setv null_vec (np.zeros 10))
(print null_vec)

; 4. Find the memory size of an array.
; Num elements * Element size
(defn #^ np.ndarray get_arr_size [#^ np.ndarray arr]
    (* arr.size arr.itemsize))
(print f"Size of null array: {(get_arr_size null_vec)} bytes")

; 5. Get documentation of a function from the command line
;(help np.add)
"
Rougier's Answer:

%run python -c \"import numpy; numpy.info(numpy.add)\"
"
;' 6. Create a null vector of size 10 but the fifth value which is 1
(setv null2 (np.copy null_vec)) 
(setv (. null2 [4]) 1) 
(print null2)

; 7. Create a vector with values ranging from 10 to 49
(print (np.arange 10 50))

; 8. Reverse a vector
(print "\nProblem 8")
(setv arr (np.arange 5))
(print (. arr [(slice None None -1)]))

; 9. Create a 3x3 matrix with values ranging from 0 to 8

(setv arr (. np (arange 9) (reshape 3 3)))
(print "\nProblem 9:\n" arr)

; 10. Find indices of non-zero elements from [1,2,0,0,4,0]

(setv arr (np.array [1 2 0 0 4 0]))
(print "\nProblem 10: " (np.nonzero arr))

; 11. Create a 3x3 identity matrix
(print "\nProblem 11:\n" (np.eye 3))

; 12. Create a 3x3x3 array with random values
; As in use np.empty, or np.random.random?
(print "\nProblem 12:\n" (np.random.random :size [3 3 3]))

; 13. Create a 10x10 array with random values and find the minimum and maximum values
(setv arr (np.random.random :size [10 10]))
;(print "\nProblem 13\nMax: " (np.max arr) "\nMin: " (np.min arr))  ; this works
(print "\nProblem 13\nMax: " (. arr (max)) "\nMin: " (. arr (min))) ; Rougier solution

; 14. Create a random vector of size 30 and find the mean value 

(setv arr (np.random.random 30)
      mean (np.mean arr))
(print "\nProblem 14\nMean " mean)  ; Could also do (arr.mean) because mean is a method.

; 15. Create a 2d array with 1 on the border and 0 inside

(setv arr (np.ones [10 10]))
(setv (. arr [#((slice 1 -1) (slice 1 -1))]) 0)  ; eqiv. to arr[1:-1, 1:-1] = 0
(print "\nProblem 15\n"arr)

; 16. How to add a border (filled with 0's) around an existing array?
(print "\nProblem 16\n" (np.pad arr :pad_width 1 :mode "constant" :constant-values 0))

; 17. What is the result of each of the following expressionss?
"
a. 0 * np.nan
b. np.nan == np.nan
c. np.inf > np.nan
d. np.nan - np.nan
e. np.nan in set([np.nan])
f. 0.3 == 3 * 0.1
"

"
Expected Answers
a. np.nan
b. False
c. False
d. np.nan
e. True
f. False
"

#[ANSWER[
    My answers were all correct! NaN is not a number, so most mathematic operations on it aren't defined, meaning it should result in another NaN.
    However, `np.nan` is an object so it can be placed in a container. Therefore, the query on if it was in the set evaluated to True.
    Finally, due to floating-point imprecision, 0.3 the literal is not equal to the evaluation 3 * 0.1. The expression is imprecise and evaluates to 0.30000000000000004.
]ANSWER]

; 18. Create a 5x5 matrix with values 1,2,3,4 just below the diagonal
;(print (. arr [#((slice None) #(0 -1))]))  ; arr[:, [0, -1]]
(print "\nProblem 18\n" (np.diagflat [1 2 3 4] :k -1))  ; Could also use np.diag

; 19. Create a 8x8 matrix and fill it with a checkerboard pattern
(setv arr (np.zeros #(8 8) :dtype np.int32))
(setv (. arr [ #((slice 0 None 2) (slice 0 None 2)) ])
      1)
(setv (. arr [ #((slice 1 None 2) (slice 1 None 2)) ])
      1)
(print "\nProblem 19\n"  arr)

; 20. Consider a (6,7,8) shape array, what is the index (x,y,z) of the 100th element?

(print f"\nProblem 20: I did this using math, but Rougier used a Numpy function. I should have checked the indexing routines, smh.\n
    {(np.unravel_index :indices 99 :shape #(6 7 8))}
")

; 21. Create a checkerboard 8x8 matrix using the tile function
(print "\nProblem 21\n" (np.tile (np.eye 2) :reps #(4 4)))

; 22. Normalize a 5x5 random matrix
(setv arr (np.random.random :size [5 5]))
; (print "\nProblem 22\n" (/ arr (. arr (max))))
(print "\nProblem 22\n" (/ (- arr (arr.mean)) (arr.std)))  ; No idea what this is... is it normalizing by the mean?
"Answer: What was done above is called 'standardization'.
See: https://towardsai.net/p/data-science/how-when-and-why-should-you-normalize-standardize-rescale-your-data-3f083def38ff
" 
