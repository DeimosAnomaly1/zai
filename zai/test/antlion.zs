enum AntlionTasks {
    ANT_FLY             = 20,
    ANT_LAND            = 21,
    ANT_MELEE           = 22,
    ANT_CHASE_TARGET    = 23
}

class Antlion : BaseActor {
    override void beginPlay() {
        super.beginPlay();

        Schedule fly = Schedule.create("schedule_antlion_jump");
        fly.addTask(Task.create(TASK_STOP_MOVING, 0.0));
        fly.addTask(Task.create(TASK_FACE_TARGET, 2.0)); // turn speed
        fly.addTask(Task.create(ANT_FLY, 0.0));
        fly.addTask(Task.create(ANT_LAND, 0.0));
        schedules.push(fly);

        Schedule chase = schedule.create("schedule_antlion_chase");
        chase.addTask(Task.create(ANT_CHASE_TARGET, 0.0));
        schedules.push(chase);

        changeSchedule(findSchedule("schedule_antlion_chase"));
    }
    override void startTask(Task t) {
        super.startTask(t);
        switch(t.TID) {
            case ANT_FLY:
                //fly at player
                //set state to flying animation state
            case ANT_LAND:
                //spawn smoke particles
                completeCurrentTask();
                break;
            
        }
    }
    default {
        
    }
}