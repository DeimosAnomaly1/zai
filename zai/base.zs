class BaseActor : Actor abstract {
    state idealState;

    float idealAngle;
    
    vector3 idealPos;
    vector3 savedPos;
    vector3 targetPos;

    virtual void startTask(Task t) {
        //Default AI task executions
        switch(t.TID) {
            case TASK_STOP_MOVING:
                if(vel == (0, 0, 0)) {
                    completeCurrentTask();
                    break;
                }
                else {
                    vel = (0,0,0);
                    completeCurrentTask();
                    break;
                }
            default:
                break;
        }
    }
    default {
        Health 20;
		Radius 20;
		Height 56;
		Speed 8;
		PainChance 200;
		Monster;
		+FLOORCLIP
    }
}