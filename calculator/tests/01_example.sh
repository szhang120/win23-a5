#!/usr/bin/env bash

# (The absolute path to the program is provided as the first and only argument.)
CALCULATOR=$1

echo "We've set up a GitHub Actions Workflow that will run all"
echo "of the shell scripts in this directory as a series of tests."
echo
echo "To fail any test, you should use the exit 1 command;"
echo "To end a test early as a success, you should use the exit 0 command."

echo "Invoke your program with the \$CALCULATOR variable; an example is below"


# Test 01: Ensure the program runs without error with a simple, valid invocation.
if ! $CALCULATOR 1 + 1; then  # If the return code of $PROGRAM is non-zero (i.e. error)...
  echo 'ERROR! A valid run of the calculator (1 + 1) failed!'
  exit 1
fi

# Test 02: Ensure simple case has correct output...
if [[ $($CALCULATOR 1 + 1) -ne 2 ]]; then  # If the output of the program is not 2...
  echo 'ERROR! A valid run of the calculator (1 + 1) failed to produce 2 as an output!'
  exit 1
fi

# Test 03: Ensure program errors with an invalid operand
if $CALCULATOR 3 @ 2; then  # If the return code of $PROGRAM is zero (i.e. success)...
  echo 'ERROR! An invalid run of the application (3 @ 2) apparently succeeded?!'
  exit 1
fi

#!/bin/bash
# CI Test Suite for the Calculator Program
# Addresses Part I – Writing CI tests

# Ensure that the calculator executable is available.
# Assuming tests/ directory is inside the calculator directory.
if [ ! -x "../calculator" ]; then
    echo "Calculator executable not found. Building the program..."
    cd .. && make
    cd tests
fi

# Function to test a calculation.
# Usage: test_calculation operator operand1 operand2 expected_result
test_calculation() {
    op=$1
    a=$2
    b=$3
    expected=$4

    result=$(../calculator "$op" "$a" "$b")
    if [ "$result" == "$expected" ]; then
        echo "Test passed for: $a $op $b = $result"
    else
        echo "Test FAILED for: $a $op $b. Expected $expected but got $result"
        exit 1
    fi
}

# extra 1: check 25*25 = 625
test_calculation '*' 25 25 625

# extra 2: check 55 / 5 = 11
test_calculation / 55 5 11

# extra 3: check 12 + 12 = 24
test_calculation + 12 12 24

# extra 3: check 12 - 12 = 0
test_calculation - 12 12 0

echo "All tests passed!"
