### Description
Implements a CLI calculator which takes input in [Reverse Polish Notation](http://mathworld.wolfram.com/ReversePolishNotation.html). This project is a code challenge for a prospective employer.

After cloning, run the calculator with
`$ ruby rpn.rb`

The calculator expects each operand and operator to be entered separately on its own line, e.g.
```sh
1
2
+
```
The result will be printed on the next line preceded by an `=` sign, and will be used as the first operand in the next sequence.

The following is the output from an example run.
```sh
1
2
+
= 3.0
4
5
-
= -1.0
+
= 2.0
```
Expressed in one line, this would be `(1 + 2) + (4 - 5) = 2`

### Approach
I started by laying out the basic interaction pattern:
- The core logic should loop indefinitely until the user inputs "q".
- If an operator is given, do math.
- If a numeric operand is given, add it to the stack of pending operands
- If the input is neither operation, numeric, nor "q", alert the user that the input is unrecognized.

I initially misread the prompt and wrote a version with the mistaken assumption that a series of operands followed by an operator should _all_ have that operation applied e.g. `6 4 2 /` is treated as `6 / (4 / 2)`, and results in `3`. This script was more complicated, as it used an enumerator to process through the stack. I have committed it to the repository as `original_attempt.rb`.

I then re-read the prompt to verify accuracy and realized that I'd made the misinterpretation. I recovered the working parts (everything shown in the Initial commit) and began again. This time, it was merely implementing a postfix calculator. _Note: I am familiar with this concept and I'm relatively certain I've implemented something like it on a free code challenge site in the past (2016 or prior) using Javascript. I'm not 100% certain about that though, because I can't seem to find it on any of my profiles._

Since I had the framework described in the bullet points above, I just needed to handle an operator. I first ensured that we have enough operands to actually complete the operation. For this, I pop the last element off the array of pending operands and designate it as the right side of the operation. If the array is now empty, I perform the operation with the total as the left side, and assign the result to the total. Otherwise I pop the next element off the array and use it as the left side of the operation, then push the result back onto the array.

I then spent some time on making sure that the messaging presented to the user was clear, and experimented with some terminal escape sequences to make it feel more coherent. I solicited feedback from a fellow who is not a programmer, who immediately tried `7 2 /` and asked if it was supposed to round off the result. Although I had intentionally set up the calculator to only allow integers, I then changed it to use floats instead, as this seemed more useful (and of course it was the _first_ thing the user tried, so that's a pretty solid indicator that it's a valuable addition).

### Highlights
Once I understood the prompt correctly, the logic for running through the operations was very straightforward and clean. I left plenty of comments because this is a code challenge, but I feel that the code is very readable without comments.

### Next Steps
As of now, the user cannot reset the grand total. I would want to add support for a command like "c" to clear the total.

I would also want to do some simple checks on unrecognized commands to provide better feedback. For example, if a user puts multiple numbers separated by a space or both an operand and an operator in a single input, I could have an error message reminding the user that the calculator only supports one operand or operator per line.

It might also be nice to separately determine whether a user has input a float or an integer, then add the operand to the stack with the appropriate type. Operations would be performed as usual, with two exceptions:
- If the operation is division, I would ensure one side was a float so that it didn't accidentally result in integer math rounding.
- At the end of each operation, I would want to check if the result could be converted to an integer without losing precision. That way I could display the output of `6 3 /` as `2` instead of `2.0`.
