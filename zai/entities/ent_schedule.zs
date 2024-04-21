enum ScheduleCreateStatus {
	SCS_FAIL,
	SCS_SUCCESS
}

enum ScheduleStatus {
	SES_SCHEDULE_STATUS_RUNNING					= 0,
	SES_SCHEDULE_STATUS_FINISHED				= 1
}

class ScheduleManager {
	array<Schedule> schedules;

	private Schedule currentSchedule;

	ScheduleCreateStatus createScheduleFromBuffer(string name, string scheduleBuffer, int schedule_id) {
		if(!readString(scheduleBuffer)) {
			return SCS_FAIL;
		}
		return SCS_SUCCESS;
	}

	bool readString(out string buffer) {

		// read a string buffer
		// create the tasks with args
		// create the schedule and save it in the schedules
		return true;
	}

	Schedule getCurrSchedule() {
		return currentSchedule;
	}

	void addTasks(Schedule schedule) {}

	// is there a task running?
	bool isTaskRunning() {
		for(int i = 0; i < schedules.size(); ++i) {
			if(schedules[i].taskList[i].status == (TSTAT_RUN_TASK || TSTAT_RUN_MOVE || TSTAT_RUN_MOVE_AND_TASK)) {
				return true;
			}
		}
		return false;
	}
}

class Schedule {
    private int id;

    private string name;

    array<Task> taskList;

	private Task currentTask;

	//TODO: implmement a list of conditions that can interrupt the schedule

    int getID() {
        return id;
    }

	int getNumOfTasks() {
		return taskList.size();
	}

	string getName() {
		return name;
	}

	Task getCurrTask() {
		return currentTask;
	}

	void goToNextTask() {
		if(taskList[taskList.find(currentTask) + 1] != null) {
			currentTask = taskList[taskList.find(currentTask) + 1];
		}
	}
}