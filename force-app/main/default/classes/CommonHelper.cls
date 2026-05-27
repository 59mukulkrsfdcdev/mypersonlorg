public class CommonHelper 
{
    // to fetch all lead records...
    public static void GetLeadRecord()
    {
        list<lead> lstlead = [select id, firstname, lastname, email, company,status from lead];
        
        system.debug('Result set collection size is.. '+ lstlead.size());
        if(!lstlead.isEmpty())
        {
            for(lead ld :lstlead)
            {
                system.debug('lead id is --- '+ ld.id);
                system.debug('lead id is --- '+ ld.firstname+ ' '+ ld.LastName);
                system.debug('lead email id is --- '+ ld.email);
                system.debug('lead company is --- '+ ld.company);
                system.debug('lead status is --- '+ ld.status);
                
                System.debug('======================================');
            }
        }
    }
    
	public void GetAllHiringManager()
    {
        list<Hiring_Manager__c> lstManager = [select id, name, location__c, email_id__c from Hiring_Manager__c];
        
        system.debug('Hiring Manager collection size is...' + lstManager.size());
        
        if(! lstManager.isEmpty())
        {
            for(Hiring_Manager__c hr : lstManager)
            {
                System.debug('Hiring manager record is.... '+ hr);
			}
        }
    }
}