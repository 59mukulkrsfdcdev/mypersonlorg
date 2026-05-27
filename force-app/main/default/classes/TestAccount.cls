public class TestAccount {
public static void  GetBankingAccounts()
    {
        List<Account> lstAccount = [select id, name, rating, annualrevenue, active__c from Account where industry = 'Banking' ];
        System.debug('hhjg'+ lstAccount.size() );
        if(lstAccount.size()>0)
        {
            system.debug('Account collections size is :'+lstAccount.size());
            for(Account acc : lstAccount)
            {
                system.debug('Account record is :'+ acc);
            }
        }
    }
    
    public static void Dynamic_string_and_email_format(string text)
    {
        if (text!=' ' && text!=Null)
        {
            string contactquery='select id,email,firstname,lastname,PAN_Number__c from Contact';
            if (pattern.matches( '^[a-zA-Z0-9._|\\\\%#~`=?&/$^*!}{+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,4}$', text))
            {
                system.debug('User input was Email Format');
             	//contactquery +='where email =: text';
                
               contactquery += ' Where Email = \'' +  text + '\''; 
            }
            else
            {
                system.debug('User input was String Format');
                text +='%';
               // contactquery+='where lastname like : text';
                  contactquery += ' Where Lastname like ' + '\'%' + text + '\'';
            }
            list<contact> lstcon=database.query(contactquery);
            system.debug('Size: '+lstcon.size());
            if (! lstcon.isempty())
            {
               for (contact con: lstcon)
            	{
                	system.debug('Record : '+con);
            	} 
            }            
        }
    }
    public static void Parent_To_Child(string accountName)
    {
        list<Account> lstAcc = [select id, name, rating,
                               (select id, firstname, lastname from contacts),
                               (select id, name, amount, closeDate, stageName from opportunities),
                               (select id, subject, description, status, priority from cases)
                               from account where name =: accountName];
        system.debug('Accounts collection size is :'+lstAcc.size());
        if(! lstAcc.isEmpty())
        {
            for(account acc : lstAcc)
            {
                system.debug('account record is:'+acc);
                system.debug('-----------------------------------------------------------------------------');
                
                system.debug('Associated contact record count :'+acc.contacts.size());
                if(! acc.contacts.isEmpty())
                {
                    for(contact con : acc.contacts)
                    {
                        system.debug('contact record is:'+con);
                    }
                }
                 system.debug('-----------------------------------------------------------------------------');
                 system.debug('Associated opportunity record count :'+acc.opportunities.size());
                if(! acc.opportunities.isEmpty())
                {
                    for(opportunity opty : acc.opportunities)
                    {
                        system.debug('opportunity record is:'+opty);
                    }
                }
                system.debug('-----------------------------------------------------------------------------');
                 system.debug('Associated case record count :'+acc.cases.size());
                if(! acc.cases.isEmpty())
                {
                    for(case cs : acc.cases)
                    {
                        system.debug('case record is:'+cs);
                    }
            }
        }
        
    }
        
}
}