class Schedule {
    array<Task> tasks;
    array<Interruption> interruptions;

    Interruption currentInterruption;

    int status;

    string name;

    bool NULLConditions;

    Task currTask;

    static Schedule create(string name) {
        Schedule s = new("Schedule");
        s.name = name;
        if(ZAI_SchedulingDebug && s != null) console.printf("Schedule (%s) has successfully been created.", name);
        return s;
    }
    void addTask(Task task) { 
        tasks.push(task);
        if(ZAI_SchedulingDebug) {
            console.printf("addTask(): Task with:\n\tdata: (%d)\n\targument: (%f)\nhas been pushed to schedule (%s)", task.TID, task.argF, self.name);
        }
    }
    void interuption(int interruptionID, Schedule fallBack) {
        Interruption inter = Interruption.create(interruptionID, fallBack);
        interruptions.push(inter);
        if(ZAI_SchedulingDebug) {
            console.printf("Successfully added interruption to schedule: (%s)");
        }
    }
    /*
    Schedule s = Schedule.create();

    s.addTask(Task.create(TASK_STOP_MOVING, 0)) // no argument
    s.addTask(Task.create(TASK_FACE_TARGET, 30.0)) // turn speed
    s.addTask(Task.create(TASK_RANGE_ATTACK1, 2)) // spread
    s.interruption(INTERRUPTION_TARGET_OOF, IdleWander) // target out of sight
    s.interruption(INTERRUPTION_TARGET_DEAD, IdleWander)
    s.interruption(INTERRUPTION_NO_TARGET, IdleWander)
    s.interruption(INTERRUPTION_TARGET_TOO_CLOSE, RUN_FROM_TARGET);
    */
}