@isTest

public class UpdateContactBatchTest 
{
    public static  testmethod void TestContactsUpdateBatch()
    {
        list<Contact> lstContact = new list<Contact>();
        for(integer count = 1; count < 100; count++)
        {
            Contact con = new Contact(firstname = 'Sample', lastname = 'Contact'+ count ,email= 'sample@gmail.com',
                                     title = 'Manager', department = 'IT Department', phone = '89273923',
                                     fax = '9824729', pan_number__c = 'AFDSFSFS');
            lstContact.add(con);
            
		}
        Test.startTest();
        insert lstContact;
        
        // Create the object of the batchclass....
        
        UpdateContactBatch contBatch = new UpdateContactBatch();
        Database.executeBatch(contBatch);
        
        Test.stopTest();
        
    }

}