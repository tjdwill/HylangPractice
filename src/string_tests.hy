; This is a program that aims to test strings

; Are newline textual formatting carried over into the string?

(setv new-triple-quote "Hello,

I'm writing this as a test for Hy strings.
This line should be on a new line.

This line should have a gap between it and the last.




Multiple newlines.")

(print new-triple-quote)

; f strings

(print (. "\nF-string test:" (upper)))
(print f"Let's attempt an f-string. 1+1 = {(+ 1 1)}")
(print "Did it output 2? The expression I put in was 

1+1 = {(+ 1 1)}

Interstingly enough, it appears that f-strings are only meant to be on a single
line. Attempting to place newlines resulted in syntax error in the VSCode
application. Let's test for sure though. We'll see if the program crashes from
the following:")
(print f"Crash test {(+ 0 0)} " :end "\n\n")

(print "Oh, the program still works; the syntax highlighting just messes up
because it expects the closing quotation to be on the same line as the closing
curly bracket 

So, if you want multiple lines, you can pass in multiple f-strings to play
nicely with the VSCode Syntax Highlighter. Good to know.
")

(setv test-format f"{1 :05d}")
(print "Formatting Example: f\"{1 :05d}\"\n"
test-format)

"
Can this string serve as a comment?

Yes, it can!
"

; Bracket Strings

(print "\nBRACKET STRINGS
What on Earth is a bracket string?")

(setv bracket-string #[FOO[Hello ' "" test]FOO])
(print bracket-string)