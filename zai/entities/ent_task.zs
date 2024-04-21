//Based on Source SDK implmentation
//https://github.com/ValveSoftware/source-sdk-2013/blob/master/mp/src/game/server/ai_task.h

enum BaseTaskFailureCodes {
	NO_TASK_FAILURE,
	FAIL_NO_TARGET,
	// FAIL_WEAPON_OWNED,
	FAIL_ITEM_NO_FIND,
	FAIL_SCHEDULE_NOT_FOUND,
	FAIL_NO_ENEMY,
	FAIL_NO_COVER,
	FAIL_NO_FLANK,
	FAIL_NO_SHOOT,
	FAIL_NO_WALK,
	FAIL_ALREADY_LOCKED,
	FAIL_NO_SOUND,
	FAIL_NO_SCENT,
	FAIL_BAD_ACTIVITY,
	FAIL_NO_GOAL,
	FAIL_NO_PLAYER,
	FAIL_BAD_POSITION,
	FAIL_STUCK_ONTOP,
	FAIL_ITEM_TAKEN,

	NUM_FAIL_CODES,
}

enum TaskStatus {
    TSTAT_NEW                       = 0, // Just started
    TSTAT_RUN_MOVE_AND_TASK         = 1, // Running task with movement
    TSTAT_RUN_MOVE                  = 2, // Just running movement
    TSTAT_RUN_TASK                  = 3, // Just running task
    TSTAT_COMPLETE                  = 4, // Completed this task, get next task
}

// the float argument is the spread of fire which is just a basic quadratic
// createTask("Flank", argFloat: 2.5);
class Task {
    int argInt;
    float argFloat;

	int status;

	int aT;

	static Task create(int i, float f) {
		Task t = new("Task");
		t.argInt = i;
		t.argFloat = f;
		return t;
	}

	void setStatus() {
		status = TSTAT_COMPLETE;
	}
}

//Shared tasks are task that are basically available for all entities
enum SharedTasks {
    TASK_INVALID = 0,
    // Forces the activity to reset, activities are basically the currently played animation
    // We don't need this as we have states
    // TASK_RESET_ACTIVITY,

    TASK_WAIT, // Waits for the specified number of seconds.

    TASK_ANNOUNCE_ATTACK, // Make announce attack sound

    // Waits for the specified number of seconds. Will constantly turn to 
    // face the enemy while waiting. 
    TASK_WAIT_FACE_ENEMY,

    // Waits up to the specified number of seconds. Will constantly turn to 
    // face the enemy while waiting. 
    TASK_WAIT_FACE_ENEMY_RANDOM,

    // Wait until the player is visible to this character.
    TASK_WAIT_VISIBLE,

    // Set target to the nearest potential target
    TASK_TARGET_PLAYER,

    // Walk to target's location
    TASK_SCRIPT_WALK_TO_TARGET,

    // Run to target's location
    TASK_SCRIPT_RUN_TO_TARGET,

    // Move to within specified range of target
    TASK_MOVE_TO_TARGET_RANGE,

    // Move to within specified range of our nav goal
    TASK_MOVE_TO_GOAL_RANGE,

    // Path that moves the character a few steps forward of where it is.
    TASK_MOVE_AWAY_PATH,

    TASK_GET_PATH_AWAY_FROM_BEST_SOUND,

    // Store current position for later reference
    TASK_STORE_LASTPOSITION,

    // Clear stored position
    TASK_CLEAR_LASTPOSITION,

    // Store current position for later reference
    TASK_STORE_POSITION_IN_SAVEPOSITION,

    // Store best sound position for later reference
    TASK_STORE_BESTSOUND_IN_SAVEPOSITION,
    TASK_STORE_BESTSOUND_REACTORIGIN_IN_SAVEPOSITION,

    TASK_REACT_TO_COMBAT_SOUND,

    // Store current enemy position in saveposition
    TASK_STORE_ENEMY_POSITION_IN_SAVEPOSITION,

    // Path to last position (Last position must be stored with TASK_STORE_LAST_POSITION)
    TASK_GET_PATH_TO_LASTPOSITION,

    // Path to saved position (Save position must by set in code or by a task)
    TASK_GET_PATH_TO_SAVEPOSITION,

    // Path to location that has line of sight to saved position (Save position must by set in code or by a task)
    TASK_GET_PATH_TO_SAVEPOSITION_LOS,

    // Path to random node
    TASK_GET_PATH_TO_RANDOM_NODE,

    // Path to source of loudest heard sound that I care about
    TASK_GET_PATH_TO_BESTSOUND,

    // Path to source of the strongest scend that I care about
    TASK_GET_PATH_TO_BESTSCENT,

    // Clear m_flMoveWaitFinished (timer that inhibits movement)
    // TASK_CLEAR_MOVE_WAIT,

    // Decide on the appropriate small flinch state, and use it. 
    TASK_SMALL_FLINCH,

    // Decide on the appropriate big flinch state, and use it. 
    TASK_BIG_FLINCH,

    // Prevent dodging for a certain amount of time.
    TASK_DEFER_DODGE,

    // Turn to face ideal yaw
    TASK_FACE_IDEAL,

    // Find an interesting direction to face. Don't face into walls, corners if you can help it.
    TASK_FACE_REASONABLE,

    // Turn to face the way I should walk or run
    TASK_FACE_PATH,

    // Turn to face a player
    TASK_FACE_PLAYER,

    // Turn to face the enemy
    TASK_FACE_ENEMY,

    // Turn to face A_Face(target)
    TASK_FACE_TARGET,

    // Turn to face stored last position (last position must be stored first!)
    TASK_FACE_LASTPOSITION,

    // Turn to face stored save position (save position must be stored first!)
    TASK_FACE_SAVEPOSITION,

    // Turn to face directly away from stored save position (save position must be stored first!)
    TASK_FACE_AWAY_FROM_SAVEPOSITION,

    // Set the current facing to be the ideal
    TASK_SET_IDEAL_YAW_TO_CURRENT,

    // Attack the enemy (should be facing the enemy)
    TASK_RANGE_ATTACK1,
    TASK_RANGE_ATTACK2,
    TASK_MELEE_ATTACK1,
    TASK_MELEE_ATTACK2,

    // Reload weapon if this entity has a weapon ofc
    TASK_RELOAD,

    // Execute special attack
    TASK_SPECIAL_ATTACK1,
    TASK_SPECIAL_ATTACK2,

    // Emit an angry sound
    TASK_SOUND_ANGRY,

    // Emit a dying sound
    TASK_SOUND_DEATH,

    // Emit an idle sound
    TASK_SOUND_IDLE,

    // Emit a sound because you are pissed off because you just saw someone you don't like
    TASK_SOUND_WAKE,

    // Emit a pain sound
    TASK_SOUND_PAIN,

    // Emit a death sound
    TASK_SOUND_DIE,

    // Speak a sentence
    TASK_SPEAK_SENTENCE,

    // Wait for the current sentence I'm speaking to finish
    TASK_WAIT_FOR_SPEAK_FINISH,

    // Immediately change to a schedule of the specified type
    TASK_SET_SCHEDULE,

    // Set the specified schedule to execute if the current schedule fails.
    TASK_SET_FAIL_SCHEDULE,

    // How close to route goal do I need to get
    TASK_SET_TOLERANCE_DISTANCE,

    // How many seconds should I spend search for a route
    TASK_SET_ROUTE_SEARCH_TIME,

    // Return to use of default fail schedule
    TASK_CLEAR_FAIL_SCHEDULE,

    // tries lateral cover first, then node cover
    TASK_FIND_COVER_FROM_BEST_SOUND,

    // tries lateral cover first, then node cover
    TASK_FIND_COVER_FROM_ENEMY,

    // Find a place to hide from the enemy, somewhere on either side of me
    TASK_FIND_LATERAL_COVER_FROM_ENEMY,

    // Find a place further from the saved position
    TASK_FIND_BACKAWAY_FROM_SAVEPOSITION,

    // Fine a place to hide from the enemy, anywhere. Use the node system.
    TASK_FIND_NODE_COVER_FROM_ENEMY,

    // Find a place to hide from the enemy that's within the specified distance
    TASK_FIND_NEAR_NODE_COVER_FROM_ENEMY,

    // data for this one is there MINIMUM aceptable distance to the cover.
    TASK_FIND_FAR_NODE_COVER_FROM_ENEMY,

    // Find a place to go that can't see to where I am now.
    TASK_FIND_COVER_FROM_ORIGIN,

    // Unhook from the AI system.
    TASK_DIE,

    TASK_STOP_MOVING,
    
    // Turn left the specified number of degrees
    TASK_TURN_LEFT,

    // Turn right the specified number of degrees
    TASK_TURN_RIGHT,

    // Remember the specified piece of data
    TASK_REMEMBER,

    // Forget the specified piece of data
    TASK_FORGET,
    
    // Wait until current movement is complete. 
    TASK_WAIT_FOR_MOVEMENT,

    // Wait until a single-step movement is complete.
    TASK_WAIT_FOR_MOVEMENT_STEP,

    // Wait until I can't hear any danger sound.
    TASK_WAIT_UNTIL_NO_DANGER_SOUND,

    TASK_ITEM_PICKUP,
    // TASK_ITEM_RUN_PATH,

    // Use small hull for tight navigation
    TASK_USE_SMALL_HULL,

    // wait until you are on ground
    TASK_FALL_TO_GROUND,

    // Wander for a specfied amound of time
    TASK_WANDER,

    TASK_FREEZE,

    // regather conditions at the start of a schedule (all conditions are cleared between schedules)
    TASK_GATHER_CONDITIONS,

    // Require an enemy be seen after the task is run to be considered a candidate enemy
    TASK_IGNORE_OLD_ENEMIES,
    
    TASK_DEBUG_BREAK,

    // Add a specified amount of health to this NPC
    TASK_ADD_HEALTH,

    // Add a gesture layer and wait until it's finished
    TASK_ADD_GESTURE_WAIT,

    // Add a gesture layer
    TASK_ADD_GESTURE,

    // ======================================
    // IMPORTANT: This must be the last enum
    // ======================================
    LAST_SHARED_TASK
}