#!/bin/bash

# Check if a file is provided as an argument
if [ $# -eq 0 ]; then
    echo "Usage: $0 <filename>"
    exit 1
fi

filename="$1"
counter=0
merged_lines=""

# Read the file line by line
while IFS= read -r line; do
    counter=$((counter + 1))
    merged_lines+="${line}"

    # Check if 10 lines have been read
    if [ $counter -eq 50 ]; then
        echo -e "add element inet proute v4vpn {\n\t$merged_lines\n}"
        counter=0
        merged_lines=""
    else
        merged_lines+=",\n\t"
    fi
done < "$filename"

# Check if there are remaining lines
if [ $counter -gt 0 ]; then
    echo -e "add element inet proute v4vpn {\n\t$merged_lines\n}"
fi

