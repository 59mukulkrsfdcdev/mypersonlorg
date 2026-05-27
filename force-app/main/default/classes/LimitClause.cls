public class LimitClause
{
 // Apex program, to fetch only one hiring manager manager record 
 	public static void GetOnlyOneHiringManagerRecord()
    {
        Hiring_Manager__c hr = [select id, name, location__c, contact_number__c, email_id__c
                               from Hiring_Manager__c
                               Limit 1];
        if(hr != null)
        {
            system.debug('Hiring Manager id is.... '+ hr.Id);
            system.debug('Hiring Manager Name is ..... '+ hr.Name);
            system.debug('Location is .... '+ hr.Location__c);
            system.debug('Email id is.... '+ hr.Email_Id__c);
            system.debug('contact Number is..... '+ hr.Contact_Number__c);
		}
    }
}