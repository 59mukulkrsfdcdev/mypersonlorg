public class DynamicSoql 
{
    
    public static void GetPositionStatus(String posStatus)
    {
        if(posStatus != null && posStatus !='')
        {
            string positionQuery ='Select id, name, location__c, position_status__c, minimum_pay__c, close_date__c, maximum_pay__c from position__c where position_status__c =:PosStatus';
            
            List<Position__c> lstpos = DataBase.query(positionquery);
            system.debug('Collection size is .... '+ lstpos.size());
            
            if(! lstpos.isEmpty())
            {
                for(Position__c pos : lstpos)
                {
                    system.debug('Position record is.....'+ pos);
				}
			}
            
            
		}
	}
    
    /*
	public static void GetContactsBySearchText(String searchText)
    {
        if(searchText != null && searchText != '')
        {
            string contactsQuery = 'select id, firstname, lastname,email, title, phone, fax, birthdate from contact';
       if(Pattern.matches('^[a-zA-Z0-9._|\\\\%#~`=?&/$^*!}{+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}$', searchText))
       {
        System.debug('User input is in email format'); 
           contactsQuery += 'Where email =: searchText';
       }
            else
            {
                system.debug('User input is in string format ');
                searchText += '%';
            contactsQuery += 'Where lastname like: searchText';
            }
            system.debug(' Qery is ...'+ contactsQuery);
            
            // Execute the query
            list<contact> lstcont = Database.query(contactsQuery);
            system.debug('Search result count is ....: '+ lstcont.size());
            if(! lstcont.isEmpty())
            {
                for(Contact con : lstcont)
                {
                    System.debug('Contact record is..'+ con);
                }
            }
                        
        }
    }
	*/
     public static void GetContactsBySearchText(string searchText)
    {
        if(searchText != null && searchText != '')
        {
            string contactsQuery = 'select id, firstname, lastname, email, title, phone, fax, birthdate from contact ';
            if(pattern.matches('^[a-zA-Z0-9._|\\\\%#~`=?&/$^*!}{+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}$', searchText))
            {
                system.debug('User input is in email format');
                contactsQuery += 'where email =:  searchText';
                
                
            }
            else
            {
                system.debug('User input is a string');
                searchText += '%';
				contactsQuery += 'where lastname Like :  searchText';

            }
           
            // Execute the query
            List<Contact> lstContacts = Database.query(contactsQuery);
            system.debug('Search results count is:' + lstContacts.size());
            if(! lstContacts.isEmpty())
            {
                for(contact con : lstContacts)
                {
                    system.debug('Contact record is: '+ con);
                }
            }
            
        }
        
    }
	
}