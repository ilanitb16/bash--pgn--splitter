#!/bin/bash

# Function to display the chess board
print_board() {
    clear
    echo "Move $1/${#moves_history[@]}"
    for ((i=0; i<8; i++)); do
        echo -n "$((8-i)) "
        for ((j=0; j<8; j++)); do
            echo -n "${board[i*8+j]} "
        done
        echo "$((8-i))"
    done
    echo "  a b c d e f g h"
}

# Function to initialize the chess board
init_board() {
    board=(r n b q k b n r \
           p p p p p p p p \
           . . . . . . . . \
           . . . . . . . . \
           . . . . . . . . \
           . . . . . . . . \
           P P P P P P P P \
           R N B Q K B N R)
}

# Function to load the PGN file and parse moves using Python script
load_pgn() {
    if [ ! -f "$1" ]; then
        echo "File does not exist: $1"
        exit 1
    fi
    
    echo "Metadata from PGN file:"
    grep -E '^\[.*\]$' "$1"
    
    moves_pgn=$(grep -E '^[0-9]+\.' "$1" | tr '\n' ' ')
    moves_uci=($(python3 parse_moves.py "$moves_pgn"))
    moves_history=("${moves_uci[@]}")
}

# Function to move forward
move_forward() {
    if [ "$move_index" -lt "${#moves_history[@]}" ]; then
        move=${moves_history[move_index]}
        board[${move:2:1}${move:3:1}]=${board[${move:0:1}${move:1:1}]}
        board[${move:0:1}${move:1:1}]="."
        ((move_index++))
    else
        echo "No more moves available."
    fi
}

# Function to move backward
move_backward() {
    if [ "$move_index" -gt 0 ]; then
        ((move_index--))
        move=${moves_history[move_index]}
        board[${move:0:1}${move:1:1}]=${board[${move:2:1}${move:3:1}]}
        board[${move:2:1}${move:3:1}]="."
    fi
}

# Function to handle user input
handle_input() {
    case $key in
        d) move_forward ;;
        a) move_backward ;;
        w) init_board; move_index=0 ;;
        s) init_board; move_index=0; while [ "$move_index" -lt "${#moves_history[@]}" ]; do move_forward; done ;;
        q) echo "Exiting."; exit 0 ;;
        *) echo "Invalid key pressed: $key" ;;
    esac
}

# Main script
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <pgn-file>"
    exit 1
fi

init_board
load_pgn "$1"
move_index=0

while true; do
    print_board "$move_index"
    echo "Press 'd' to move forward, 'a' to move back, 'w' to go to the start, 's' to go to the end, 'q' to quit:"
    read -n 1 key
    handle_input
done
