public class GetContactByAcnt
{
	public static void GetConAccntName(String accountName)
    {
        if( accountName != null && accountName != '')
        {
            List<Account> lstAccnt = [select id, name from account where name =: accountName];
            
            id accountRecordid = lstAccnt.get(0).id;
            
            list<Contact> lstContacts = [select id, firstname, lastname, email, phone, fax, accountID
                                        from contact
                                        where accountid =: accountRecordid ];
            
            system.debug('Contacts collection size is...'+ lstContacts.size());
            
            if(! lstcontacts.isEmpty())
            {
                for(Contact con : lstContacts)
                {
                    system.debug('contact record is.... '+ con);
				}
            }
        }
    }
}