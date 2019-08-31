ops = ['+', '-', '*', '/']
# Use an array as a stack of pending operands
pending = []
total = nil

system "clear && printf '\e[3J'"
puts "This calculator uses Reverse Polish Notation\n\
Enter each operand or operation on its own line, e.g.\n\
1\n\
2\n\
+  \e[32m(will output \"= 3\")\e[0m\n\n"

puts "\n(enter \"q\" to exit)\e[2A" # \e[nA moves the cursor up n line(s),
# so this message will always appear immediately following the user's cursor,
# and because we used "puts", it will be at the beginning of the line

while input = gets.chomp
  # Loop indefinitely, getting input from the user at the start of each loop
  print "\033[2K" # Clears current line (now the line following user input)
  if input == "q"
    exit
  elsif ops.include? input
    # The user has given a valid operation, so it's time to do some math.
    if pending.empty? || (pending.count == 1 && total == nil)
      puts "There must be at least 2 numbers to operate upon."
    else
      # Get right-side operand from end of stack
      right = pending.pop
      if pending.count == 0
        # Nothing left in stack, so use total as left-side operand
        total = total.send(input.to_sym, right)
        puts "= #{total}"
      else
        # Replace next element in stack with the result of performing the
        # operation using that element as the left side operand.
        left = pending.pop
        pending.push left.send(input.to_sym, right)
        puts "= #{pending.last}"
      end
    end
  elsif input.match? /^\d+$/
    # If the input is a number, push it onto the pending stack
    pending.push input.to_i
  else
    # We don't know how to handle the given input. We'll tell the user so they
    # have an idea what happened.
    puts "\"#{input}\" is not a recognized input."
  end
  puts "\n(enter \"q\" to exit)\e[2A"
end
