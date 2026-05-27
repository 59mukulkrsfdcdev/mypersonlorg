Global class UpdateContactBatch implements Database.Batchable<sobject>
{
    Global Database.QueryLocator start(Database.BatchableContext bcontext)
    {
        string slectcontactquery = 'select id, firstname, lastname, Department, Title, Pan_Number__c from contact';
        return database.getQueryLocator(slectcontactquery);
    }
    global void execute(database.BatchableContext bcontext, list<sobject> recordtoProcess)
    {
        list<contact> contoupdate = new list<contact>();
        
        if(! recordtoProcess.isEmpty())
        {
            for(Sobject contrecd : recordtoProcess)
            {
                contact con = (contact) contrecd;
                
                con.Department = 'Sales Department';
                con.Title = 'Team member';
                con.Pan_Number__c = 'ADDGEEHN';
                
                contoupdate.add(con);
                
            }
            if(! contoupdate.isEmpty())
            {
               // update contoupdate;
            	database.SaveResult[] result = database.update(contoupdate, false);
            }
        }
        
    }
    Global void finish(Database.BatchableContext bcontext)
    {
        system.debug('Batch jon id..... '+ bcontext.getJobId());
        AsyncApexJob jobDetail = [select id, status, jobitemsProcessed, totalJobItems, NumberofErrors,
                                 createdby.email from asyncApexjob where id =: bcontext.getJobId()];
    
    MessagingUtility.SendBatchProcessNotification(jobDetail);
    }

}