#!/bin/bash

# This script demonstrates a solution to the race condition bug using flock.

# Create a file with initial value 0
echo 0 > counter.txt

# Function to increment counter using flock to ensure atomicity
increment_counter() {
  flock -n -e 20 counter.txt || exit 1
  # Read the current value
  current_value=$(cat counter.txt)
  # Increment the value
  new_value=$((current_value + 1))
  # Write the new value back to the file
  echo $new_value > counter.txt
  flock -u 20 counter.txt
}

# Run increment_counter in parallel using multiple processes
for i in {1..10}; do
  increment_counter &
done

wait  # wait for all background processes to finish

# Print final counter value, should be 10
echo "Final counter value: $(cat counter.txt)"