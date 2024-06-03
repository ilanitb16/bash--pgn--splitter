msg1="Press 'd' to move forward, 'a' to move back, 'w' to go to the start, 's' to go to the end. 'q' to quit: "
msg2=Exiting.
uci_moves=("e2e4" "e7e5" "g1f3" "b8c6")

# Define Unicode characters for chess pieces
WHITE_PAWN="♙"
BLACK_PAWN="♟"
WHITE_ROOK="♖"
BLACK_ROOK="♜"
WHITE_KNIGHT="♘"
BLACK_KNIGHT="♞"
WHITE_BISHOP="♗"
BLACK_BISHOP="♝"
WHITE_QUEEN="♕"
BLACK_QUEEN="♛"
WHITE_KING="♔"
BLACK_KING="♚"

# Initialize the chessboard
# board=(
#     $BLACK_ROOK $BLACK_KNIGHT $BLACK_BISHOP $BLACK_QUEEN $BLACK_KING $BLACK_BISHOP $BLACK_KNIGHT $BLACK_ROOK
#     $BLACK_PAWN $BLACK_PAWN $BLACK_PAWN $BLACK_PAWN $BLACK_PAWN $BLACK_PAWN $BLACK_PAWN $BLACK_PAWN
#     "." "." "." "." "." "." "." "."
#     "." "." "." "." "." "." "." "."
#     "." "." "." "." "." "." "." "."
#     "." "." "." "." "." "." "." "."
#     $WHITE_PAWN $WHITE_PAWN $WHITE_PAWN $WHITE_PAWN $WHITE_PAWN $WHITE_PAWN $WHITE_PAWN $WHITE_PAWN
#     $WHITE_ROOK $WHITE_KNIGHT $WHITE_BISHOP $WHITE_QUEEN $WHITE_KING $WHITE_BISHOP $WHITE_KNIGHT $WHITE_ROOK
# )


function initialize_board(){
  echo $BLACK_ROOK $BLACK_KNIGHT $BLACK_BISHOP $BLACK_QUEEN $BLACK_KING $BLACK_BISHOP $BLACK_KNIGHT $BLACK_ROOK
  echo $BLACK_PAWN $BLACK_PAWN $BLACK_PAWN $BLACK_PAWN $BLACK_PAWN $BLACK_PAWN $BLACK_PAWN $BLACK_PAWN
  echo "." "." "." "." "." "." "." "."
  echo "." "." "." "." "." "." "." "."
  echo "." "." "." "." "." "." "." "."
  echo "." "." "." "." "." "." "." "."
  echo $WHITE_PAWN $WHITE_PAWN $WHITE_PAWN $WHITE_PAWN $WHITE_PAWN $WHITE_PAWN $WHITE_PAWN $WHITE_PAWN
  echo $WHITE_ROOK $WHITE_KNIGHT $WHITE_BISHOP $WHITE_QUEEN $WHITE_KING $WHITE_BISHOP $WHITE_KNIGHT $WHITE_ROOK
}

# Function to move a piece
move_piece() {
    local start_row=$1
    local start_col=$2
    local end_row=$3
    local end_col=$4

    local start_index=$((start_row * 8 + start_col))
    local end_index=$((end_row * 8 + end_col))

    board[$end_index]=${board[$start_index]}
    board[$start_index]="."
}

uci_to_move() {
    local move=$1
    local start_col=$(($(printf "%d" "'${move:0:1}") - $(printf "%d" "'a")))
    local start_row=$((8 - ${move:1:1}))
    local end_col=$(($(printf "%d" "'${move:2:1}") - $(printf "%d" "'a")))
    local end_row=$((8 - ${move:3:1}))
    # printf "$start_row $start_col $end_row $end_col"


    echo "$start_row $start_col $end_row $end_col"
    #echo "6 4 4 4"
}

uci_to_back() {
    local move=$1
    local start_col=$(($(printf "%d" "'${move:0:1}") - $(printf "%d" "'a")))
    local start_row=$((8 - ${move:1:1}))
    local end_col=$(($(printf "%d" "'${move:2:1}") - $(printf "%d" "'a")))
    local end_row=$((8 - ${move:3:1}))

    echo "$end_row $end_col $start_row $start_col"
}

display_board(){
  # clear
  echo "Move $next_move/${#uci_moves[@]}"

  local i j

  for ((i=0; i<8; i++)); do
      for ((j=0; j<8; j++)); do
          index=$((i * 8 + j))
          echo -n "${board[$index]} "
      done
      echo
  done
}

move_forward(){
  if (($next_move < "${#uci_moves[@]}")); then
    uci_move=${uci_moves[$next_move]}
    #echo UCI MOVE: $uci_move

    move=$(uci_to_move $uci_move)
    #echo $move
    set -- $move
    move_piece $1 $2 $3 $4
    next_move=$((next_move + 1))
  else
    echo "No more moves available."
  fi
}

move_backward(){
  if (($next_move > 0)); then
    next_move=$((next_move - 1))

    uci_move=${uci_moves[$next_move]}
    #echo UCI MOVE: $uci_move

    move=$(uci_to_back $uci_move)
    #echo $move
    set -- $move
    move_piece $1 $2 $3 $4
  fi
}

play_to_end(){
  start_new_game
  
  for uci_move in "${uci_moves[@]}"; do
    move=$(uci_to_move $uci_move)
    set -- $move
    move_piece $1 $2 $3 $4
  done
}

start_new_game(){
  next_move=$((0))
  board=($(initialize_board))
}

exit_game(){
  echo $msg2
  exit 0
}

start_new_game

while true
  do
    display_board
    echo $msg1
    read -n1 command
    
    case $command in
      d) move_forward ;;
      a) move_backward ;;
      w) start_new_game ;;
      s) play_to_end ;;
      q) exit_game ;;
      *) echo "Invalid key pressed: $command" ;;
    esac

  done