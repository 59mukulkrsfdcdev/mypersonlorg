public class UpdateRecordss 
{
    public static void upsertLeadRecordValues()
    {
        list<Lead> leadsToUpsert = new list<lead>();
        
        //updating he lead record
        list<lead> lstlead = [ select id, firstname, lastname, status from lead where isconverted = false];
        if(! lstlead.isEmpty())
        {
            for( lead ld : lstlead)
            {
                ld.status = 'Working-Offer Discount';
                ld.AnnualRevenue = 4000000;
                leadsToUpsert.add(ld);
            }
            //Creating a lead record...
            lead l = new lead();
            l.FirstName = 'Sgfgample';
            l.LastName = 'Teshght lead';
            l.Company = 'HCbgL';
            l.Status = 'Working- ocntacted';
            l.AnnualRevenue = 1238799;
            l.Industry = 'finance';
            l.Pan_Number__c = 'AOJDJJ88K';
            l.Passport_Number__c = 'ADLDDLSK';
            l.ProductInterest__c = 'Desktops';
            l.Title = 'Manager';
            // add the new lead record
            leadsToUpsert.add(l);
            
            // Upser the record to database
            if(! leadsToUpsert.isEmpty())
            {
                upsert leadsToUpsert;
            }
        }
    }
    
    
    public static void synchronizedAccountPhoneAfx(string accountName)
    {
        list<contact> contactstoupdate = new list<contact>();
        if(accountName != null && accountName != '')
        {
            list<account> lstaccount = [select id, name, rating, phone, fax,
                                       (select id, firstname, lastname, phone, fax from contacts)
                                       from account];           
            if(! lstaccount.isEmpty())
            {
                for(Account acc : lstaccount)
                {
                    for(contact con : acc.contacts){
                        //assign the values...
                        con.Phone = acc.Phone;
                        con.Fax = acc.Fax;
                        // Add it to the collection
                        contactstoupdate.add(con);          
                    }
                }
                // commit the changes back to database
                if(! contactstoupdate.isEmpty())
                {
                    update contactstoupdate;
                }
            }
		}
    }
    
    
    
    // Reurnt all unassociated contact
    public static list<contact> GetAllUnassociatedContact()
    {
         return[select id, firstname, lastname, accountid from Contact where accountid = null];
    }
    // assign the contact to specify account
    public static void AssignContacttoAccountByName(String accountName)
    {
        list<contact> contactToUpdate = new list<contact>();
        if(accountName != null && accountName != '')
        {
            account accrecord = [select id, name from account where name =: accountName limit 1 ];
            
            if( accrecord != null)
            {
                for(contact con : GetAllUnassociatedContact() )
                {
                    con.AccountId = accrecord.Id;
                    contactToUpdate.add(con);
				}
                
                if(! contactToUpdate.isEmpty())
                {
                    update contactToUpdate;
                }
            }
        }
    }
    
    // De- activate the user by name..
    
    public static void DeactivateUserByname(String userId)
    {
        User usertoDeactivate = [select id, username, isActive from User where username =: userID and isActive = true];
        
        if(usertoDeactivate != null)
        {
            usertoDeactivate.IsActive = False;
            update usertoDeactivate;
        }
    }
    public static void UpdateAccountEdgeCom()
    {
        // Get the record..
        Account acc = [select id, name, rating, industry, type, ownership from Account where name = 'Check Public Manual record test'];
       if(acc!= null)
       {
           //assign the values...
          acc.Rating = 'Hot';
           acc.Type = 'Techonlogy Partenr';
           acc.Industry = 'Insurance';
           acc.Ownership = 'Subsidiary';
           acc.Site = 'Manufacturing';
           acc.Passport_Number__c = 'AFLFLLS88';
           
           
           //update the record...
           update acc;
       }
    }

}