trigger RoundRobin on Lead (before insert, before update) {

    /**
 * Trigger to handle the lead assignments in a round robin manner
 */

    if (trigger.isBefore && (trigger.isInsert || trigger.isUpdate)){

        // Get the queue user details
        List<Group> queues = [
                SELECT Id,
                    (Select Id, UserOrGroupId FROM GroupMembers Order By ID ASC)
                FROM Group
                Where Type = 'Queue'AND DeveloperName = 'Lead_Ques'
        ];

        // Get the index of the last lead assigned user in the queue
       Lead_Round_Assignment__c lrr = Lead_Round_Assignment__c.getOrgDefaults();
        Integer userIndex = (lrr.get('User_Index__c') == null || Integer.valueOf(lrr.get('User_Index__c')) < -1) 
            ? -1 : Integer.valueOf(lrr.get('User_Index__c'));

        if (queues.size() > 0 && queues.get(0).GroupMembers.size() > 0) {
            Id queueId = queues.get(0).Id;
            Integer groupMemberSize = queues.get(0).GroupMembers.size();
            for (Lead l : Trigger.new) {
                
                if (l.OwnerId != queueId) {
                    Integer leadUserIndex =  (userIndex + 1) >= groupMemberSize ? 0 : userIndex + 1;
                    l.OwnerId = queues.get(0).GroupMembers.get(leadUserIndex).UserOrGroupId;
                    userIndex = leadUserIndex;
                
                }
                

            // Update the custom settings user index with the last lead assigned user
            lrr.User_Index__c = userIndex;
            update lrr;
        }
            
            
        }
    for(Lead ld: trigger.new){
                Lead1__c ldd = new Lead1__c();
        if(ld.Id!=null){
             ldd.Lead__c=ld.Id;
                 ldd.Name=ld.lastName;
               system.debug('====='+ldd.Name);
                Insert ldd;
        }
               
            }}

}