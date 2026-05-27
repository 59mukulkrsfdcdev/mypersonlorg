public class Edge {
    
public static void GetContactsByAccountName(string accountName)
{
    if(accountName!=null && accountName!= '')
    {
        List <Account> listAccounts =[Select id,name from Account where name = : accountName];
        id accountRecordId = listAccounts.get(0).id;
        List<contact>listContacts = [Select id,firstName,lastName,email,phone,fax,accountId from contact where accountId=: AccountRecordId];
        system.debug('Contact Collection size is : '+ listContacts.size() );
        if(! listcontacts.isEmpty())
        {
            for(contact con : listcontacts)
            {
                system.debug('Contact Record is : '+ con);
            }
        }
    }
}
}