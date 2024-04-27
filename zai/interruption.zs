enum InterruptStatus {
    INT_TRUE,
    INT_FALSE
}

class Interruption {
    int id;
    Schedule fallBack;

    static Interruption create(int id, Schedule fallBack) {
        let i = new("Interruption");
        if(ZAI_SchedulingDebug && i != null) {
            console.printf("Interruption.create() with:\n");
            console.printf("\t interruption id: %d", i);
            console.printf("\t fallback schedule name: %s", fallBack.name);
            console.printf("Interruption successfully created.");
        }
        i.id = id;
        i.fallBack = fallBack;
        return i;
    }
    int update() {
        return INT_FALSE;
    }
}