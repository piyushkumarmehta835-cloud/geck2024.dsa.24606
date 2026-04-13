#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main() {
    int pid1, pid2, pid3;

    printf("\n===== Program Start =====\n");
    printf("Original Process PID: %d\n", getpid());

    // First fork
    pid1 = fork();

    if(pid1 < 0) {
        printf("Fork 1 Failed\n");
        return 1;
    }

    // Child 1
    if(pid1 == 0) {
        printf("\n[Child 1] PID: %d, Parent PID: %d\n", getpid(), getppid());

        // Second fork inside Child 1
        pid2 = fork();

        if(pid2 < 0) {
            printf("Fork 2 Failed\n");
            return 1;
        }

        if(pid2 == 0) {
            // Child 2
            printf("\n[Child 2] PID: %d, Parent PID: %d\n", getpid(), getppid());

            // Third fork inside Child 2
            pid3 = fork();

            if(pid3 == 0) {
                printf("\n[Child 3] PID: %d, Parent PID: %d\n", getpid(), getppid());
            }
            else {
                wait(NULL);
                printf("[Child 2] Child 3 Finished\n");
            }
        }
        else {
            wait(NULL);
            printf("[Child 1] Child 2 Finished\n");
        }
    }
    else {
        // Parent Process
        printf("\n[Parent] PID: %d\n", getpid());
        printf("[Parent] Created Child 1 PID: %d\n", pid1);

        wait(NULL); // Wait for Child 1
        printf("[Parent] Child 1 Finished\n");
    }

    printf("Process %d Ending\n", getpid());

    return 0;
}
