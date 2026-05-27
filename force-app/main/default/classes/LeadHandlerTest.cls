@isTest
public class LeadHandlerTest
{
    public static testmethod void TestAutoLeadConvertion()
    {
        //Create a lead Record....
        Lead ldrecord = new lead(firstname = 'Test', lastname = 'Lead', company = 'SampleTest',
                                status = 'Open - Not Contacted', AnnualRevenue = 3400, rating = 'Hot',
                                industry = 'Banking', phone = '98989889', email = 'sampleTest@gmail.com',
                                 pan_number__c = 'QFSSFEE');
        insert ldrecord;
        // Update the Lead Status...
        
        ldrecord.status = 'Closed - Converted';
        
        update ldrecord;
        
    }

}