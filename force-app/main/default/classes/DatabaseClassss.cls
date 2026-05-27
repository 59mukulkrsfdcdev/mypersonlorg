public class DatabaseClassss 
{
    //Method to demonstrate the database.insert() method... to allow partial processing..
    public static void InsertNewContacts()
    {
        // Use the Bulkification process....
        list<contact> lstcontactToInsert = new list<contact>();
        
        // Prepare the colleciton of records....
        for(integer count = 100; count <= 130 ; count++)
        {
            // create contact records.....
            Contact con = new contact();
            
            con.FirstName = 'New Data';
            con.LastName = 'For contact'+ count;
            con.Title = 'Manager';
            con.Phone = ' 9879387893';
            con.Fax = '938749289';
            if(count != 120 )
            {
                con.Pan_Number__c= 'BCDSDF98J';
                
            }
            con.Department = 'IT Departement';
            // add the reocrds to the collection...
            lstcontactToInsert.add(con);
        }
        // insert the reocrd to the object...
        if(! lstcontactToInsert.isEmpty())
        {
             database.SaveResult[] res =  database.insert(lstcontactToInsert, false);
            
            if(! res.isEmpty())
            {
                // Get the result of each record...
                for(Database.saveResult re : res)
                {
                    // operation successfull....
                    if(re.isSuccess())
                    {
                        system.debug('Record has been successfully.. Record id is... '+ re.getId());
                        
                    }
                    else
                    {
                        // Get the error message... for failed records..
                        for( Database.Error err : re.getErrors())
                        {
                            system.debug('Error message is.... '+ err.GetMessage());
                            system.debug('Error status is... '+ err.getStatusCode());
                            system.debug('Effected fileds are... '+ err.getFields());
                        }
                    }
                }
            }
        }
    }

}