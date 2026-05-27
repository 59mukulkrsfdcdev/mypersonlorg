public class RelationshipQueriesClasss 
{
	 public static void GetAssociatedRecordByParent(String accountName)
     {
     	list<account> lstacnt = [select id, name, rating, industry, annualrevenue, type, active__c,
                                (select id, firstname, lastname, email,phone, fax from contacts),
                                (select id, name, amount, closedate, stagename from opportunities),
                                (select id, subject, status, priority from cases)
                                from account where name =: accountName];
         System.debug('Accoount collection size is... '+ lstacnt.size());
         
         if(!lstacnt.isEmpty())
         {
             for(Account ac : lstacnt)
             {
                 system.debug('Account record is...'+ ac);
                 system.debug('==============================================================');
                 
                 system.debug('Associated contact records count....'+ ac.contacts.size());
                 
                 if(!ac.contacts.isEmpty())
                 {
                     for(contact con : ac.contacts)
                     {
                         system.debug('Associated count record is.... '+ con);
                     }
                 }
                 
                  system.debug('==============================================================');
                
                 system.debug('Associtated opportunities count.... '+ ac.opportunities.size());
                 
                 if(!ac.opportunities.isEmpty())
                 {
                     for(Opportunity op : ac.opportunities)
                     {
                         system.debug('Opportunity record is...'+ op);
						}
                 }
                 
                  system.debug('==============================================================');
                
                 system.debug('Associated cases count is..... '+ ac.cases.size());
                 
                 if(! ac.cases.isEmpty())
                 {
                     for(case ca : ac.cases)
                     {
                         system.debug('Cases record is... '+ ca);
                     }
                 }
             }
         }
     }
}