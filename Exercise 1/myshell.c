#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <string.h>
#include <errno.h>

// Define the maximum number of commands and the maximum length of each command
#define MAX_COMMANDS 100
#define MAX_LENGTH 100

// Command history
char *history[MAX_COMMANDS];
int history_count = 0;

// Function prototypes
void execute_command(char *cmd, char **args);
void add_to_history(char *cmd);
void display_history();
void change_directory(char *path);
void print_working_directory();
void run_shell(int argc, char **argv);

int main(int argc, char **argv) {
    run_shell(argc, argv);
    return 0;
}

void run_shell(int argc, char **argv) {
    char command[MAX_LENGTH];
    char *args[MAX_COMMANDS];
    char *token;
    int i;

    // Initial prompt
    printf("$ ");
    fflush(stdout);

    // Main loop
    while (fgets(command, MAX_LENGTH, stdin) != NULL) {
        // Remove newline character
        command[strcspn(command, "\n")] = 0;

        // Parse the command
        i = 0;
        token = strtok(command, " ");
        while (token != NULL) {
            args[i++] = token;
            token = strtok(NULL, " ");
        }
        args[i] = NULL;

        // Add command to history
        add_to_history(command);

        // Check for built-in commands
        if (strcmp(args[0], "history") == 0) {
            display_history();
        } else if (strcmp(args[0], "cd") == 0) {
            change_directory(args[1]);
        } else if (strcmp(args[0], "pwd") == 0) {
            print_working_directory();
        } else if (strcmp(args[0], "exit") == 0) {
            exit(0);
        } else {
            execute_command(args[0], args);
        }

        // Prompt for next command
        printf("$ ");
        fflush(stdout);
    }
}

void execute_command(char *cmd, char **args) {
    pid_t pid;
    int status;

    pid = fork();
    if (pid < 0) {
        perror("fork failed");
        exit(1);
    } else if (pid == 0) {
        // Child process
        if (execvp(cmd, args) < 0) {
            perror("exec failed");
            exit(1);
        }
    } else {
        // Parent process
        if (wait(&status) < 0) {
            perror("wait failed");
            exit(1);
        }
    }
}

void add_to_history(char *cmd) {
    if (history_count < MAX_COMMANDS) {
        history[history_count++] = strdup(cmd);
    } else {
        free(history[0]);
        for (int i = 1; i < MAX_COMMANDS; i++) {
            history[i - 1] = history[i];
        }
        history[MAX_COMMANDS - 1] = strdup(cmd);
    }
}

void display_history() {
    for (int i = 0; i < history_count; i++) {
        printf("%d %s\n", i + 1, history[i]);
    }
}

void change_directory(char *path) {
    if (chdir(path) != 0) {
        perror("chdir failed");
    }
}

void print_working_directory() {
    char cwd[1024];
    if (getcwd(cwd, sizeof(cwd)) != NULL) {
        printf("%s\n", cwd);
    } else {
        perror("getcwd failed");
    }
}
