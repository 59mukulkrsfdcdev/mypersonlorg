trigger closeopp on Account (after update) {
    if(trigger.isAfter && trigger.isUpdate){
        AutomticcloseOpp.method(Trigger.New, Trigger.OldMap);
    }

}