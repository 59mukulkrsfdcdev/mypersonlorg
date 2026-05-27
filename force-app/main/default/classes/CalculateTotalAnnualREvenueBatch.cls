Global class CalculateTotalAnnualREvenueBatch implements database.Batchable<Sobject>, Database.Stateful
{
    Global decimal totalRevenue = 0.0;
    
    Global database.QueryLocator Start(Database.BatchableContext bContext)
    {
        string selectAccountQuery = 'Select id, name, annualrevenue from account where annualrevenue != null';
        return Database.getQueryLocator(selectAccountQuery);
	}
    Global void Execute(Database.BatchableContext bcontext, list<sobject> recordtoprocess)
    {
        if(! recordtoprocess.isEmpty() )
        {
            for(Sobject record : recordtoprocess)
            {
                Account acc = (Account) record;
                totalRevenue += acc.AnnualRevenue;
			}
        }
    }
    Global void finish(Database.BatchableContext bcontext)
    {
      
         AsyncApexJob jobDetail = [select id, status, jobitemsProcessed, totalJobItems, NumberofErrors,
                                 createdby.email from asyncApexjob where id =: bcontext.getJobId()];
        
   MessageUtilityForAccount.SendBatchProcessNotification(JobDetail, totalRevenue,'CalculateTotalAnnualREvenueBatch' );
	}

}