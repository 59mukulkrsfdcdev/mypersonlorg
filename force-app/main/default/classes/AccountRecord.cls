public class AccountRecord 
{
    public static void GetPosByLoc(String cityName)
    {
        	list <Position__c> lstPos = [select id, name, location__c, position_status__c,maximum_pay__c,close_date__c 
                                         , travel_required__c from Position__c
                                        where location__c =: cityname];
        system.debug('Position records collection size is.... ' + lstPos.size());
        
        if(!lstPos.isEmpty())
        {
            for(Position__c pos: lstPos)
            {
                system.debug('Psotion record is.. '+ pos);
            }
        }
}
    
    
    
	public static void GetBankingAccount()
    {
	List<Account> lstAcnt = [select id, name, rating, industry, type, annualrevenue, active__c
                            from account
                            where industry = 'Banking'];
        if(!lstacnt.isEmpty())
        {
            System.debug('Account collection size is ..... '+ lstacnt.size());
            
            for(Account acc : lstacnt)
            {
                System.debug('Account record is .. '+ acc);
			}
        }
        
    }
}