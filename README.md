# BashScriptTask
This project encompasses three distinct tasks aimed at enhancing scripting and programming skills in Bash and C. Each task addresses a unique problem, providing practical solutions through well-structured code. Below is an overview of each task included in this project. Also, you can find all the testing information and results below.

## Overview
1. PGN File Splitter Bash Script
This task involves creating a Bash script named pgn_split.sh that processes chess games recorded in Portable Game Notation (PGN) format. The script splits multiple chess games contained in a single PGN file into separate files within a specified destination directory.

### Key Features
- Validates the presence of required command-line arguments.
- Verifies the existence of the source PGN file.
- Ensures the destination directory exists or creates it if necessary.
- Splits multiple chess games from the source PGN file into individual files.

2. Chess Simulator Bash Script
This task involves developing a Bash script to simulate a chess game. The script allows users to input moves in algebraic notation, validates the moves, updates the board state, and displays the board after each move.

### Key Features
- Accepts moves in standard algebraic notation.
- Validates the legality of each move.
- Updates and displays the chessboard state after each move.
- Detects and announces check, checkmate, and stalemate conditions.

3. Custom Shell Implementation in C
This task involves creating a simple command-line interpreter named myshell.c. This custom shell handles basic Linux commands such as ls, cat, and sleep, without supporting pipes or complex commands. The shell is implemented in C using fork() and exec().

### Key Features
- Executes basic Linux commands using fork() and exec().
- Implements custom shell commands (history, cd, pwd, exit) without using the default Unix implementations.
- Ensures all commands run in the foreground and handles errors appropriately.
- Recognizes executable programs within specified directories or those in the PATH variable.
- Each task is designed to reinforce key programming concepts and provide hands-on experience with real-world applications. The scripts and programs developed in this project demonstrate proficiency in handling file operations, user input, process management, and command execution.

## Testing Part 1 and 2
This part contains an explanation of how to run the tests and the output I got on both machines before submssion.

### How to run the tests?
1. Clone this repository ```https://github.com/ilanitb16/BashScriptTask.git```
2. ```cd Operation-Systems-Exercises/```
3. ```cd Exercise\ 1/```
4. ```cd tester```
5. Install chess ```pip install chess```
6. run the file ```./tester.sh```
7. In case of ```-bash: ./tester.sh: Permission denied``` execute the command: ```chmod 777 tester.sh``` and then run ``` ./tester.sh```
8. When testing part 3, ```chmod 777 part3.out```

Example:
![image](https://github.com/ilanitb16/BashScriptTask/assets/97344492/afa457bb-2f3f-47a1-a4f8-cd4d5b7f48e8)

### Part 1 Results on Mobax:
![image](https://github.com/ilanitb16/BashScriptTask/assets/97344492/ec07c68b-cf51-4cbf-8e60-656d008f3836)

### Part 2 Results on Mobax:
![image](https://github.com/ilanitb16/BashScriptTask/assets/97344492/f4b21260-6e2c-4185-985e-2da8d38dbeb2)

### Part 3 Results on Mobax:
![image](https://github.com/ilanitb16/BashScriptTask/assets/97344492/6777339e-6abb-4f7c-b463-6595bfad2617)


### Part 1 Results on VM:
![image](https://github.com/ilanitb16/BashScriptTask/assets/97344492/3609bbbb-fcf5-4d08-8460-de6e0f7f3486)

### Part 2 Results on Vm:
![image](https://github.com/ilanitb16/BashScriptTask/assets/97344492/7bca116b-f63c-489b-ab87-de910a7af8b0)

### Part 3 Results on Vm:
![image](https://github.com/ilanitb16/BashScriptTask/assets/97344492/804bd92d-ae42-4885-b92a-99dd05154445)
