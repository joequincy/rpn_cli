ops = ['+', '-', '*', '/']
# Use an array as a stack of pending operands
pending = []
total = nil

while input = gets.chomp
  # Loop indefinitely, getting input from the user at the start of each loop
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
end
