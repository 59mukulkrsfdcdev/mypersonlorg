public class LikeOperator 
{
    // write an apex program, to fetch the account whose name starts with 'Acc'
	public static void GetAccntByStartCharacter(String startingChar)
    {
        if(startingChar != null && startingChar !='')
        {
            startingChar += '%';
            list<Account> lstAccnt = [select id, name, annualRevenue, industry, rating, 
                                     type from Account
                                     where name like :startingChar];
            
            system.debug('Resulset size is.... '+ lstAccnt.size() );
            if(! lstAccnt.isEmpty())
            {
                for(Account ac : lstAccnt)
                {
                      system.debug('Account record is ..... '+ ac);
                }
            }
        }
        
	}
}