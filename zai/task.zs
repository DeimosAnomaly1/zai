enum TaskStatus {
    TASK_NEW,
    TASK_COMPLETE,
    TASK_INPROGRESS
}

class Task {
    int status;
    int TID;
    float argF;

    static Task create(int tid, float argf) {
        Task t = new("Task");
        t.TID = tid;
        t.argF = argf;
        return t;
    }
}

enum SharedTasks {
    INVALID_TASK = 0,
    TASK_STOP_MOVING,
    TASK_FACE_TARGET,
}