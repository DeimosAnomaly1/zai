extend class BaseActor {
    int currentTaskStatus;
    int taskIndex;
    int scheduleIndex;
    
    Schedule currSched;

    array<Schedule> schedules;

    virtual void maintainSchedule() {
        for(int i = 0; i < 10; ++i) {
            if(currSched != null && currentTaskComplete() && !taskIsRunning()) {
                if(ZAI_SchedulingDebug) console.printf("maintainSchedule(): (%s)'s current task finished, going to next task at: (%d)", currSched.name, currSched.tasks[taskIndex + 1]);
                gotoNextScheduledTask();
            }

            if(isScheduleComplete()) {
                if(ZAI_SchedulingDebug) console.printf("maintainSchedule(): (%s) is finished, will wait for a new schedule.", currSched.name);
                cleanUpSchedule();
            }

            if (getCurrentTask().status == TASK_NEW) {
                Task task = getCurrentTask();
                beginTask(task);
                startTask(task);
            }

            //TODO: check idealState
        }
    }

    bool taskIsRunning() {
        for(int i; i < currSched.tasks.size(); ++i) {
            Task t = currSched.tasks[i];
            if(t.status == TASK_INPROGRESS) return true;
        }
        return false;
    }

    void beginTask(Task t) {
        t.status = TASK_INPROGRESS;
    }

    Task getCurrentTask() {
        if(taskIndex < 0 || isScheduleComplete()) {
            return null;
        }
        else {
            if(ZAI_SchedulingDebug) console.printf("getCurrentTask(): (%s)'s current task is %d", currSched.name, currSched.tasks[taskIndex]);
            return currSched.tasks[taskIndex];
        }
    }

    void completeCurrentTask() {
        currSched.tasks[taskIndex].status == TASK_COMPLETE;
    }

    void updateInterruptions() {
        for(int i = 0; i < currSched.interruptions.size(); ++i) {
            Interruption s = currSched.interruptions[i];
            if(s.update() == INT_TRUE) {
                changeSchedule(s.fallBack);
            }
        }
    }

    void gotoNextScheduledTask() {
        if(hasScheduledTask()) {
            currSched.currTask = currSched.tasks[taskIndex];
            currSched.currTask.status = TASK_NEW;
        }
        //schedule is done we can clean everything up.
        else {
            cleanUpSchedule(); // reset the current in case we use this schedule again, and it starts at the beginning
        }
    }

    void cleanUpSchedule() {
        taskIndex = 0;
        currSched.currTask = null; // reset the current in case we use this schedule again, and it starts at the beginning
        currSched.currentInterruption = null;
        currSched = null;
    }

    void changeSchedule(Schedule sched) {
        if(currSched != null) {
            cleanUpSchedule();
        }
        else if (sched == null) return;
        currSched = sched;
        if(ZAI_SchedulingDebug) console.printf("(%s)'s Schedule has been changed to (%s)", getClassName(), sched.name);
    }

    bool hasScheduledTask() {
        return currSched.tasks[taskIndex++] != null;
    }

    bool validSchedule(Schedule sched) {
        //if there is no interruption in the first slot, it is likely empty
        return (sched.interruptions[0] == null && !sched.NULLConditions);
    }

    bool isScheduleComplete() {
        return taskIndex >= currSched.tasks.size();
    }

    bool currentTaskComplete() {
        return currSched.currTask.status == TASK_COMPLETE;
    }

    Schedule findSchedule(string name) {
        for(int i = 0; i < schedules.size(); ++i) {
            if(schedules[i].name == name) {
                if(ZAI_SchedulingDebug) {
                    console.printf("findSchedule(): Found schedule %s", schedules[i].name);
                }
                return schedules[i];
            }
        }
        if(ZAI_SchedulingDebug) {
            console.printfex(PRINT_MEDIUM, "WARNING:\n\tfindSchedule(): Could not find schedule (%s)", name);
        }
        return null;
    }
}