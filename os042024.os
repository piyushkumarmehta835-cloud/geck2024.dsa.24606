#include <stdio.h>

void fcfs(int n, int bt[]) {
    int wt[n], tat[n];
    float avg_wt = 0, avg_tat = 0;

    wt[0] = 0;
    for(int i = 1; i < n; i++)
        wt[i] = wt[i-1] + bt[i-1];

    for(int i = 0; i < n; i++) {
        tat[i] = wt[i] + bt[i];
        avg_wt += wt[i];
        avg_tat += tat[i];
    }

    printf("\n--- FCFS Scheduling ---\n");
    printf("P\tBT\tWT\tTAT\n");
    for(int i = 0; i < n; i++)
        printf("%d\t%d\t%d\t%d\n", i+1, bt[i], wt[i], tat[i]);

    printf("Average WT = %.2f\n", avg_wt/n);
    printf("Average TAT = %.2f\n", avg_tat/n);
}

void sjf(int n, int bt[]) {
    int wt[n], tat[n], temp;

    // Sorting
    for(int i = 0; i < n; i++) {
        for(int j = i+1; j < n; j++) {
            if(bt[i] > bt[j]) {
                temp = bt[i];
                bt[i] = bt[j];
                bt[j] = temp;
            }
        }
    }

    wt[0] = 0;
    for(int i = 1; i < n; i++)
        wt[i] = wt[i-1] + bt[i-1];

    float avg_wt = 0, avg_tat = 0;

    printf("\n--- SJF Scheduling ---\n");
    printf("P\tBT\tWT\tTAT\n");
    for(int i = 0; i < n; i++) {
        tat[i] = wt[i] + bt[i];
        avg_wt += wt[i];
        avg_tat += tat[i];
        printf("%d\t%d\t%d\t%d\n", i+1, bt[i], wt[i], tat[i]);
    }

    printf("Average WT = %.2f\n", avg_wt/n);
    printf("Average TAT = %.2f\n", avg_tat/n);
}

void roundRobin(int n, int bt[], int tq) {
    int rt[n], time = 0, remain = n;

    for(int i = 0; i < n; i++)
        rt[i] = bt[i];

    printf("\n--- Round Robin Scheduling ---\n");

    while(remain != 0) {
        for(int i = 0; i < n; i++) {
            if(rt[i] > 0) {
                if(rt[i] <= tq) {
                    time += rt[i];
                    printf("Process %d finished at time %d\n", i+1, time);
                    rt[i] = 0;
                    remain--;
                } else {
                    rt[i] -= tq;
                    time += tq;
                }
            }
        }
    }
}

int main() {
    int n, choice;

    printf("Enter number of processes: ");
    scanf("%d", &n);

    int bt[n];

    printf("Enter Burst Time:\n");
    for(int i = 0; i < n; i++) {
        printf("P%d: ", i+1);
        scanf("%d", &bt[i]);
    }

    while(1) {
        printf("\n===== MENU =====\n");
        printf("1. FCFS Scheduling\n");
        printf("2. SJF Scheduling\n");
        printf("3. Round Robin\n");
        printf("4. Exit\n");
        printf("Enter your choice: ");
        scanf("%d", &choice);

        switch(choice) {
            case 1:
                fcfs(n, bt);
                break;

            case 2:
                sjf(n, bt);
                break;

            case 3: {
                int tq;
                printf("Enter Time Quantum: ");
                scanf("%d", &tq);
                roundRobin(n, bt, tq);
                break;
            }

            case 4:
                return 0;

            default:
                printf("Invalid choice!\n");
        }
    }

    return 0;
}
