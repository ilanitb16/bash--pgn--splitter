#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <string.h>
#include <errno.h>

// Define max number of commands and length for each command
#define MAX_CMDS 100
#define MAX_LEN 100

// Command history
char *cmd_history[MAX_CMDS];
int cmd_count = 0;

// Declare the Functions
void start_shell(int argc, char **argv);
void execute(char *cmd, char **args);
void add_history(char *cmd);
void show_history();
void change_dir(char *path);
void print_cwd();

int main(int argc, char **argv) {
    start_shell(argc, argv);
    return 0;
}

void start_shell(int argc, char **argv) {
    char input[MAX_LEN];
    char *arguments[MAX_CMDS];
    char *tok;
    int idx;

    // First prompt
    printf("$ ");
    fflush(stdout);

    while (fgets(input, MAX_LEN, stdin) != NULL) {
        // Remove newline 
        input[strcspn(input, "\n")] = 0;

        // Parse
        idx = 0;
        tok = strtok(input, " ");
        while (tok != NULL) {
            arguments[idx++] = tok;
            tok = strtok(NULL, " ");
        }
        arguments[idx] = NULL;

        // Add input to history array
        add_history(input);

        // Check for the custom commands
        if (strcmp(arguments[0], "history") == 0) {
            show_history();
        } else if (strcmp(arguments[0], "cd") == 0) {
            change_dir(arguments[1]);
        } else if (strcmp(arguments[0], "pwd") == 0) {
            print_cwd();
        } else if (strcmp(arguments[0], "exit") == 0) {
            exit(0);
        } else {
            execute(arguments[0], arguments);
        }

        // Prompt next command
        printf("$ ");
        fflush(stdout);
    }
}

void execute(char *cmd, char **args) {
    pid_t pid; // Process ID
    int stat; // Status of the child process

    pid = fork(); // Create new process: forking the current one
    if (pid < 0) {
        perror("fork failed"); //  creation of child process failed because fork() < 0
        exit(1);
    } else if (pid == 0) {
        // Child process
        if (execvp(cmd, args) < 0) {
            perror("exec failed");
            exit(1);
        }
    } else {
        // Parent process
        if (wait(&stat) < 0) {
            perror("wait failed");
            exit(1);
        }
    }
}

void add_history(char *cmd) {
    // If not full
    if (cmd_count < MAX_CMDS) {
        cmd_history[cmd_count++] = strdup(cmd); // Add command to history and count++
    } else {
        free(cmd_history[0]); // If its full, free the memory allocated for the oldest command
        for (int i = 1; i < MAX_CMDS; i++) {
            cmd_history[i - 1] = cmd_history[i]; // Shift commands one index left
        }
        cmd_history[MAX_CMDS - 1] = strdup(cmd); // Add the new command to the end of the history
    }
}

void show_history() {
    // print history
    for (int i = 0; i < cmd_count; i++) {
        printf("%d %s\n", i + 1, cmd_history[i]);
    }
}

void change_dir(char *path) {
    // try changin path
    if (chdir(path) != 0) {
        // When chdir() returns a non-zero val => error occurred
        perror("chdir failed");
    }
}

void print_cwd() {
    char cwd[1024]; // init Buffer to store cwd
    if (getcwd(cwd, sizeof(cwd)) != NULL) {
        printf("%s\n", cwd); // In case of success we print
    } else {
        perror("getcwd failed");
    }
}
