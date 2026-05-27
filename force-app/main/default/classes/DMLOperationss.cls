public class DMLOperationss 
{
   
    // insert Hiring manager records
    public static void CreateBulkHiringManagerRecord(integer recordsTOinsert)
    {
     for(integer counter = 1; counter <= recordsTOinsert; counter++)
     {
         Hiring_Manager__c hr = new Hiring_Manager__c();
         
         hr.Name ='New Recrutier - '+ counter;
         hr.Location__c = 'Chennai';
         hr.Contact_Number__c = '9988775568';
         hr.Email_Id__c = 'newrecruiter'+counter+'@gmail.com';
         
         insert hr;
         if(hr.Id != null)
         {
             system.debug('Record inserted successfully. Record id is... '+ hr.Id);
         }
         
     }
    }
    
        
    public static void InsertNewContact()
    {
        // creating the object for contact class
        Contact con = new Contact();
        
       // Assigning the values for fields...
       con.firstName ='Java';
        con.LastName = 'Programming';
        con.Title = 'Manager';
        con.Birthdate = Date.newInstance(1985, 10, 23);
        con.Phone = '8979879887';
        con.Email = 'javadev@gmail.com';
        con.Pan_Number__c= 'AAOjhPJ87H';
        con.Department = 'Developer';
        
        // insert the record into the object...
        insert con;
        if(con.Id != null)
        {
            system.debug('Contact record inserted sccessfully. contact ID is... '+ con.Id );
        }
    }

}