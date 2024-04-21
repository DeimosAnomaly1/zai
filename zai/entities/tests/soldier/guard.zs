enum GuardTasks {
	GUARD_FIRE,
}
enum GuardFails {
    TARGET_RUSHED
}


class TestGuard : ConsHumanBase {
	bool isMidAir;
	bool facingTarget;

    override void buildSchedule() {
		if(schedMan.schedules.size() > 0) {
			for(int i = 0; i < schedMan.schedules.size(); ++i)
				schedMan.schedules[i] = null;
		}
		schedMan.createScheduleFromBuffer
		(
			"guard_fire",               // add this schedule with THIS name, and push it to the array

			"	Tasks"
			"		TASK_STOP_MOVING				0"
			"		TASK_FACE_ENEMY                 8"
			"		GUARD_FIRE                      3"
			"	"
			"	Interrupts"
			"		FAIL_NO_TARGET"
			"	FallBack"               // find a schedule with this name in the `schedules` array
			"		guard_reload",
			1
		);
    }

	override void startTask(Task t) {
        if(schedMan.isTaskRunning()) return;

		switch(t.aT) {
			case GUARD_FIRE:
				if(!target || target.health < 1 || distance2d(target) >= 320) {
					t.status = TSTAT_COMPLETE;
					break;
				}
                setStateLabel("FirePre");
                break;
		}
	}
	/*
		wait for task to be finished before moving to next task
		if no more tasks left, pick another schedule
	*/
}