#!/bin/bash


#####################################
#
# Script Author: Jamiu
#
# Date: 03-01-2025
#
# Version: v1
#
# Mysterious Bash
#
#####################################



# Welcome to the Mysterious Script Challenge!
# Your task is to unravel the mystery behind this script and understand what it does.
# Once you've deciphered its objective, your mission is to improve the script by adding comments and explanations for clarity.

# DISCLAIMER: This script is purely fictional and does not perform any harmful actions.
# It's designed to challenge your scripting skills and creativity.

# The Mysterious Function

#!/bin/bash

# Welcome to the Mysterious Script Challenge!
# This script performs a series of transformations on a given input file.

# DISCLAIMER: This script is purely fictional and does not perform any harmful actions.

# The Mysterious Function
mysterious_function() {
    local input_file="$1"  # The input file to be processed
    local output_file="$2" # The file where the result will be saved

    # Step 1: Apply ROT13 cipher to the input file and save it to output file
    tr 'A-Za-z' 'N-ZA-Mn-za-m' < "$input_file" > "$output_file"

    # Step 2: Reverse the output file content
    rev "$output_file" > "reversed_temp.txt"

    # Step 3: Generate a random number between 1 and 10
    random_number=$(( ( RANDOM % 10 ) + 1 ))

    # Mystery loop: Reverse and apply ROT13 multiple times
    for (( i=0; i<$random_number; i++ )); do
        # Reverse the content of reversed_temp.txt
        rev "reversed_temp.txt" > "temp_rev.txt"

        # Apply ROT13 again to the reversed content
        tr 'A-Za-z' 'N-ZA-Mn-za-m' < "temp_rev.txt" > "temp_enc.txt"

        # Move the newly encoded file to replace reversed_temp.txt
        mv "temp_enc.txt" "reversed_temp.txt"
    done

    # Clean up temporary files
    rm "temp_rev.txt"
}

# Main Script Execution

# Check if two arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <input_file> <output_file>"
    exit 1
fi

input_file="$1"  # First argument: Input file
output_file="$2" # Second argument: Output file

# Check if the input file exists
if [ ! -f "$input_file" ]; then
    echo "Error: Input file not found!"
    exit 1
fi

# Call the mysterious function to begin the process
mysterious_function "$input_file" "$output_file"

# Display the mysterious output
echo "The mysterious process is complete. Check the '$output_file' for the result!"