public class HavinggClass 
{
    public static void GetDuplicateAccByname()
    {
        AggregateResult[] aggresult = [select name, count(id) recordscount from account
                                      group by Name
                                      Having count(id) > 1];
        system.debug('Duplicate account collection size is.. '+ aggresult.size());
        
        if(!aggresult.isEmpty())
        {
            for(AggregateResult res : aggresult)
            {
                system.debug('Account name: '+ res.get('Name') +'----Records count is.. '+ res.get('recordscount'));
            }
		}
    }
    
	public static void GetLocNdPos()
    {
        AggregateResult[] aggResults = [select location__c, count(id) positionscount from Position__c
        									group by Location__c
        									Having count(id) >= 2];
    
    System.debug('Collection count is ...... '+ aggResults.size());
        if(! aggResults.isEmpty())
        {
            for(AggregateResult res : aggResults)
            {
                system.debug('Location name: '+ res.get('Location__c') + '-----Position count: '+ res.get('positionscount'));
            }
        }
    }

}