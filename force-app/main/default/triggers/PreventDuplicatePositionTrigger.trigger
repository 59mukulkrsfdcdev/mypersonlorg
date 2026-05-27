trigger PreventDuplicatePositionTrigger on Position__c (before insert, before update) 
{
    if(trigger.isBefore && (Trigger.isInsert || trigger.isupdate))
    {
        for( Position__c pos : trigger.new)
        {
            integer recordscount = [ select count() from position__c where name =: pos.Name];
                
                if(recordscount > 0)
            {
                pos.AddError('We can create the position record. As Already a position record exisst wiht this name');
            }
        }
    }

}