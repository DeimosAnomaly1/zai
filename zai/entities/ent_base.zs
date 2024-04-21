enum TargettingFlags {
    CST_EVERYTHING_EXCEPT_SELF      = 1,
    CST_NEUTRAL_TOO_EVERYTHING      = 1<<2,
    CST_HOSTILE_TO_HUMANS           = 1<<3,
    CST_HOSTILE_TO_CREATURES        = 1<<4,
    CST_USE_HATE_LIST               = 1<<5
}

class BaseActor : Actor {
    string[8] hateList; // use dynamic arrays later

    int wishAngle;

    //X is the angle
    //Y is the pitch
    vector2 transAngle;

	ScheduleManager schedMan;

    default {
        speed 1;
		maxStepHeight 48;
		maxDropoffHeight 192;
		reactionTime 24;
		painChance 0;

        +FLOORCLIP
    }
    virtual void onInit() {
        // to initialize the hate list
        // to initialize friend list
        // to initialize special code when targetting actors
		// build schedules
		buildSchedule();
    }

    virtual void onDeath() {}
    virtual void onUpdate() {}
    virtual void onTarget() {}
	virtual void buildSchedule() {}
	virtual void startTask(Task t) {}

    override void beginPlay() {
        super.beginPlay();
        onInit();
    }

    void conFacePosition(vector3 tPos, int turnSpeed = 25) {
        vector3 dir = (pos - tPos);
        float yAngle = pos dot dir;

        pitch = yAngle;
    }
    
    void conActorMoveTo() {}
}