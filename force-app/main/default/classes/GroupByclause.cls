public class GroupByclause 
{
    public static void GetAccountCountByIndusrty()
    {
        AggregateResult[] aggResults = [select industry, count(id) recordscount from account group by Industry];
        
        System.debug('Industry collection size... '+ aggResults.size());
        
        if(! aggResults.isEmpty())
        {
            for(AggregateResult res : aggResults)
            {
                system.debug('Industry name: '+ res.Get('Industry') + '--- Records count:  '+ res.Get('recordscount') );
            }
        }
	}
    
    Public static void GetRecordCount()
    {
        // Static SOQL Query....
        integer recordcount = [select count() from account];
        system.debug('Account records count is.... '+ recordcount);
        
        //Dynamic SOQL Query....
        string recordcntquery = 'select count() from account';
        integer acntrcrdcnt = Database.countQuery(recordcntquery);
        system.debug('Account records collection size is.....' + acntrcrdcnt);
	}

}