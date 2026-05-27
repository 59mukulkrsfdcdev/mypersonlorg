trigger PrimaryCon on Contact (before insert, before update) {
    if(Trigger.isBefore && trigger.isUpdate){
        SinglePrimaryContact.method(Trigger.new, Trigger.oldMap);
    }
    else if(trigger.isBefore && trigger.isInsert){
         SinglePrimaryContact.method(Trigger.new,null);
    }

}