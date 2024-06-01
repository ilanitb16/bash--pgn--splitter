#!/bin/bash

usage() {
    echo "Usage: $0 <source_pgn_file> <destination_directory>"
    exit 1
}

if [ "$#" -ne 2 ]; then 
    usage
fi

source_pgn="$1"
destination_dir="$2"
source_pgn_basename=$(basename "$source_pgn" .pgn)

if [ ! -f "$source_pgn" ]; then
    echo "Error: File '$source_pgn' does not exist."
    exit 1
fi

if [ ! -d "$destination_dir" ]; then
    mkdir -p "$destination_dir"
    echo "Created directory '$destination_dir'."
fi

awk '/^\[Event/ { if (x) close(x); x=sprintf("%s/%s_%d.pgn", "'"$destination_dir"'", "'"$source_pgn_basename"'", ++i) } { print > x }' "$source_pgn"

echo "All games have been split and saved to '$destination_dir'."

chmod +x pgn_split.sh