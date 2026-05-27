public class BulkInsertContactRecords {
    
    public static void DeletcontactRecordByFirstName(String startingchar)
    {
        if(startingchar != null && startingchar != '')
        {
            startingchar += '%';
            list<contact> lstcontact = [select id, firstname from contact where firstname like : startingchar];
            
            if(! lstcontact.isEmpty())
            {
                Delete lstcontact;
            }
        }
    }
    
    public static void Insertcontact(integer recordscount)
    {
        list<contact> lstcontact = new list<contact>();
        
        for(integer index =1; index <= recordscount; index++)
        {
            Contact cntct = new Contact();
            
            cntct.FirstName = 'BBulkkk Record';
            cntct.LastName = 'Contacttt'+ index;
            cntct.Title = 'DDev';
            cntct.Phone = '7976544543';
            cntct.Fax = '9878898799';
            cntct.Email = 'Bukhjhulkdev@gmail.com';
            cntct.Department = 'Developmentyy';
            cntct.Pan_Number__c= 'JGJIUG87HG';
            
            lstcontact.add(cntct);
            
        }
        if(! lstcontact.isEmpty())
        {
            insert lstcontact;
            for(Contact con :lstcontact )
            {
                system.debug('Contact record is.... '+ con);
            }
        }
    }

}