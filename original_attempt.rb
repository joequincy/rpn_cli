ops = ['+', '-', '*', '/']
pending = []
total = nil

# Loop indefinitely, getting input from the user at the start of each loop
while input = gets.chomp
  if input == "q"
    exit
  elsif ops.include? input
    # The user has given a valid operation, so it's time to do some math.
    if pending.empty?
      puts "There are no numbers to operate upon."
    else
      # Prepare enumerator for iterating over the pending stack from
      # right to left
      enumerator = pending.reverse.each.with_index
      endpoint = pending.count - 1
      # Start running total with rightmost number
      running, index = enumerator.next
      until index == endpoint
        # Until we've reached the end of the pending stack, execute
        # the operation against the next number in the stack, passing
        # our running total
        left, index = enumerator.next
        running = left.send(input.to_sym, running)
      end
      # If we already have a grand total, execute the operation against that
      # total, passing our running total... otherwise assign the running total
      # as the initial grand total
      total = (total ? total.send(input.to_sym, running) : running)
      puts "= #{total}"
    end
    pending = []
  elsif input.match? /^\d+$/
    # If the input is a number, push it onto the pending stack
    pending.push input.to_i
  else
    # We don't know how to handle the given input. We'll tell the user so they
    # have an idea what happened.
    puts "\"#{input}\" is not a recognized input."
  end
end
