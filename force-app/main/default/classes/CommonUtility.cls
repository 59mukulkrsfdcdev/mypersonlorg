public class CommonUtility
{
	// User to insert a Hiring Manager Record
	public void InsertHiringManagerRecord()
    {
        // Creating the object for the Hiring_manager__c class...
       Hiring_manager__c hr = new Hiring_manager__c();
        // Assign the vlaue...
        
        hr.Name = 'Mukul Kumar';
        hr.Location__c = 'Bangalore';
        hr.Email_Id__c = 'sridhar@gmail.com';
        hr.Contact_Number__c = '99998899';
        
        // inser the record..
        insert hr;
        if(hr.Id != null)
        {
            system.debug('Hiring Manager record has been created successfully and record ID is....'+ hr.Id);
        }
	}
     
    // Used to create a position Record..
    public void CreateNewPosition()
    {
        // Create the object for the Position__c class
        
        Position__c pos = new Position__c();
        
        // Assgin the value..
        pos.Name = 'Oracle Developer';
        pos.Number_of_Position__c = 4;
        pos.Location__c = 'Bangalore';
        pos.Position_Status__c = 'New Position';
        
        pos.Open_Date__c = system.today();
        pos.Close_Date__c = system.today().AddDays(20);
        
        pos.Minimum_Pay__c = 900000;
        pos.Maximum_Pay__c = 1300000;
        
        pos.Travel_Required__c = true;
        pos.Passport_Required__c = true;
        
        pos.HR_email_ID__c = 'sweta@gmail.com';
        
        pos.Position_Description__c = 'Required 3+ years experience in c++ Application Developere';
        pos.Skills_Required__c = 'Required 3+ years experience in c++ Application Developere';
        
        pos.RecordTypeId = Schema.SObjectType.Position__c.GetRecordTypeInfosByName().Get('IT Position Record Type').GetRecordTypeId();
        
        // Insert the Position record
        
        insert pos;
        
        if(pos.Id != null)
        {
            System.debug('Position record inserted successfully with record ID is.... '+ pos.Id);
         }
        
        
    }
}