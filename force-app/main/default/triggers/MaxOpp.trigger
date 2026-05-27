trigger MaxOpp on Opportunity (after insert, after update, after delete, after undelete) {
    
    if(Trigger.IsAfter && Trigger.IsUpdate){
        OppTriggerclass.method(Trigger.New, Trigger.OldMap);
    }
    else if(trigger.isAfter && trigger.isDelete){
    OppTriggerclass.method(Trigger.old, null);
        
    }
    else if(trigger.isAfter &&(trigger.isInsert||trigger.isUnDelete) ){
        OppTriggerclass.method(Trigger.new, null);
    
    }

}