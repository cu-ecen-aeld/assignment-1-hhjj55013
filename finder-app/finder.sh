#!/bin/bash
# finder script for assignment 1
# Check if both arguments are provided
if [ $# -ne 2 ]; then
    #echo "Usage: $0 <filesdir> <searchstr>"
    echo "Error: two arguments (a directory, and a text to search for within the directory) should be supplied."
    exit 1
fi

# Extract the arguments
filesdir="$1"
searchstr="$2"

# Check if filesdir is a directory
if [ ! -d "$filesdir" ]; then
    echo "Error: $filesdir is not a directory."
    exit 1
fi

# Find files and count matching lines
num_files=0
num_lines=0

# Recursively search for matching lines in files
search_files() {
    local dir=$1
    local search=$2

    for file in "$dir"/*; do
        if [ -f "$file" ]; then
            ((num_files++))
            match_count=$(grep -c "$search" "$file")
            ((num_lines+=match_count))
        elif [ -d "$file" ]; then
            search_files "$file" "$search"
        fi
    done
}

# Call the search function with the provided arguments
search_files "$filesdir" "$searchstr"

# Print the results
echo "The number of files are $num_files and the number of matching lines are $num_lines"