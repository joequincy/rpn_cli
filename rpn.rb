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
      # Do math
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
