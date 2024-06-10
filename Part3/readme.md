# Custom Shell Implementation in C
## Overview
This project involves the development of a simple command-line interpreter named myshell.c. This custom shell handles basic Linux commands such as ls, cat, and sleep, without supporting pipes or complex commands. The shell is implemented in C using fork() and exec().

## Objectives
- Implement a custom shell in C to execute basic Linux commands using fork() and exec().
- Implement specific shell commands (history, cd, pwd, exit) without using the default Unix implementations.
- Ensure all commands run in the foreground and handle errors appropriately. The parent process waits for the child process to complete.
- When the compiled program is initially run, it accepts any number of arguments consisting only of paths that may contain executable commands. Any executable program within those folders is recognized by the shell.
- Unix Commands
- The program allows the user to enter any known (and simple) Unix command with any number of arguments. The command entered is assumed to be in a directory passed as an argument when the program is started (e.g., ./a.out /root/custom_folder /root/another_folder) or in a directory already in the PATH variable.

## Environment Variables
- The shell accepts any number of command-line arguments (paths).
- The shell recognizes any executable in those directories or in the directories already in the $PATH variable.
- When the shell exits, the environment variables remain unchanged from their state prior to running the shell.
- Custom Commands
- The following shell commands are implemented without using the Unix defaults:

- ```history:``` Displays the list of commands that have been entered during the session (history prints in FIFO and includes the history command itself).
- ```cd:``` Changes the current directory within the shell environment (using chdir()).
- ```pwd:``` Prints the current working directory (using getcwd()).
- ```exit:``` Exits the shell.
These commands are implemented using appropriate system calls and library functions available in C.

## Command Execution
- Commands are executed in the foreground using exec() in a forked process.
- For commands not explicitly handled (history, cd, pwd, exit), no exec() or fork() are needed.
- The shell uses strtok() with a space delimiter to parse the command into its core components.
- Error Handling
- If a system call fails, the shell uses perror() to print an error message indicating which system call failed, e.g., perror("fork failed").

## Output Specifications
- The shell does not print anything except the required output from commands or error messages.
- The prompt is displayed as follows:
```
printf("$ ");
fflush(stdout);
 ```

## Assumptions
- The shell handles up to 100 commands, with each command's length also limited to 100 characters.
- There are no spaces in the names of directories and files passed as arguments to the shell.

## Restrictions
- Adding new environment variables for command execution does not affect the existing ones prior to running the program.
- Changes to the current directory (cd) within the shell do not affect the working directory after the shell is closed.

## Example Usage
```
$ pwd
/home/user
$ cd /some/path
$ pwd
/some/path
$ history
1 pwd
2 cd /some/path
3 pwd
$ ls
file1.txt file2.txt
$ exit
```

## My Output:
![image](https://github.com/ilanitb16/BashScriptTask/assets/97344492/9277273a-05ce-4464-a79a-613fb8f18ce3)




