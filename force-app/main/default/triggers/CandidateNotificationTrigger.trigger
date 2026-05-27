trigger CandidateNotificationTrigger on Candidate__c (after insert, after update)
{
    if(trigger.isinsert && trigger.isAfter)
    {
        for( Candidate__c can : Trigger.new)
        {
            string emailsubject = 'Congratulatins'+ can.Name + 'Your candidature has been successfully submitted';
            Messagingutility.SendEmailToCandidate(can, emailsubject);
                        
        }
        /*
        if(!Trigger.new.isEmpty())
        {
            string emailsubject = 'Congratulatins Your candidature has been successfully submitted';
            
            Messagingutility.SendEmailToCandidate(trigger.new, emailsubject);
        }
*/
    }
    
    if(trigger.isAfter && trigger.isupdate)
    {
         for(Candidate__c ca : trigger.new)
         {
             if(trigger.oldMap.get(ca.Id).Candidature_Status__c != trigger.NewMap.get(ca.Id).Candidature_Status__c)
             {
                  string emailsubject = 'Congratulatins'+ ca.Name + 'Your candidature status has change notification ';
            Messagingutility.SendEmailToCandidate(ca, emailsubject);
           
             }
            }
    }


}