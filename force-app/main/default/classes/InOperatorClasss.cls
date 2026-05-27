public class InOperatorClasss
{
    
	// Write an apex program, to fetch the account records associated wiht the below industries.
	// Banking, finance, Healthcare, Manufacturin, Technolgy, communication
    
    	public static void GetAccountIndustry()
    {
        string[] industryList = new string[]{ 'Banking','Finance', 'Manufacturing','Technolgy','communication'};   
    
            /*static query
         list<Account> acntlist = [select id, name, rating, industry, type, annualrevenue, active__c
                                  from account
                                  where industry IN :industryList ];
        */
        //Dynamic SOQL
        string selectAccountQuery = 'select id, name, rating, industry, type, annualrevenue, active__c from account where industry IN :industryList';
      
		list<Account> lstaccount = database.query(selectAccountQuery );
        
        system.debug('Collection size is ..'+ lstaccount.size());
        
        if(! lstaccount.isEmpty())
        {
          for(Account ac : lstaccount)
          {
              system.debug('Account records is.... '+ ac);
          }
		}
    }


// Write an apex program, to fetch all the associated contacts belongs to associated with the below industries.
	// Banking, finance, Healthcare, Manufacturin, Technolgy, communication

	public static void GetContactByIndustry()
    {
        string[] industryList = new string[]{ 'Banking','Finance', 'Manufacturing','Technolgy','communication'};   
    
        // Get account Record Id's....
        Map<Id, Account> mapaccnt = new map<id, account> ([select id, name from account 
                                                          where industry IN : industryList ]);
        
        if(! mapaccnt.isEmpty())
        {
            list<contact> lstcon = [select id, firstname, lastname, email, phone, fax
                                   from contact
                                   where accountid IN : mapaccnt.keySet()];
            system.debug('Contact collection xize is.... '+ lstcon.size());
        
        if(!lstcon.isEmpty())
        {
            for(contact con : lstcon)
            {
                System.debug('Contact record is ..'+ con);
            }
		}
        
        }     
            /*
        //Dynamic SOQL
        string selectAccountQuery = 'select id, name, rating, industry, type, annualrevenue, active__c from account where industry IN :industryList';
      
		list<Account> lstaccount = database.query(selectAccountQuery );
        
        system.debug('Collection size is ..'+ lstaccount.size());
        
        if(! lstaccount.isEmpty())
        {
          for(Account ac : lstaccount)
          {
              // write SOQL query to fetch the contacts....
              list<contact> lstContact = [select id, firstname, lastname, email from contact where accountid =: ac.id];
              system.debug('Account records is.... '+ ac);
          }
		}
        */
    }
}