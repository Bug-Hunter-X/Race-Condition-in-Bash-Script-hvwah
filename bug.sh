#!/bin/bash

# This script demonstrates a race condition bug.

# Create a file with initial value 0
echo 0 > counter.txt

# Function to increment counter
increment_counter() {
  # Read the current value
  current_value=$(cat counter.txt)

  # Increment the value
  new_value=$((current_value + 1))

  # Write the new value back to the file
  echo $new_value > counter.txt
}

# Run increment_counter in parallel using multiple processes
for i in {1..10}; do
  increment_counter &
done

wait  # wait for all background processes to finish

# Print final counter value, should be 10
echo "Final counter value: $(cat counter.txt)"