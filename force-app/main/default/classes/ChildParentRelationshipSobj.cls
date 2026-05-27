public class ChildParentRelationshipSobj
{
    public static void GetPositionNdHiringManagerByStatus(string positionstatus)
    {
        list<position__c> lstpos = [select id, name, location__c, position_status__c, close_date__c, maximum_pay__c,
                                   Hiring_Manager__r.name, Hiring_Manager__r.location__c, Hiring_Manager__r.email_id__c, Hiring_Manager__r.contact_number__c
                                   from position__c
                                   	where position_status__c =: positionstatus];
        system.debug('collection size is... '+ lstpos.size());
        if(!lstpos.isEmpty())
        {
            for(position__c pos : lstpos)
            {
                system.debug('position name is... '+ pos.name);
                system.debug('psoition location is ... '+ pos.location__c);
                system.debug('Status is... '+ pos.position_status__c);
                system.debug('close date is... '+ pos.close_date__c);
                //Parent details...
                system.debug('Hiring Manager name--- '+ pos.Hiring_Manager__r.name);
                system.debug('Hiring Manager Location is.... '+ pos.Hiring_Manager__r.location__c);
                system.debug('Hiring Manager email id is.... '+ pos.Hiring_Manager__r.email_id__c);
                
                
            }
        }
    }
    
    public static void GetcontactAndAssociatedParentDetails(String contactlastname)
    {
        string contquery ='select id, firstname, lastname, email, phone, fax, account.name, account.rating, account.industry, account.type, account.active__c, account.owner.firstname, account.owner.lastname, account.owner.email from contact where lastname =: contactlastname and accountid != null';
       
        
       list<contact> lstcon = Database.query(contquery);
        
        system.debug('Contact collection size is... '+ lstcon.size());
        
        if(!lstcon.isEmpty())
        {
            for(contact co : lstcon)
            {
                System.debug('Contact name is.... '+ co.FirstName +' '+ co.LastName);
                system.debug('conatct email is.. '+ co.Email);
                system.debug('contact phone is... '+ co.Phone);
                
                //Parent record detail
                system.debug('Parent account name is... '+ co.account.name);
                
                system.debug('Parent account rating is... '+ co.account.rating);
                
                system.debug('Parent account active status is... '+ co.account.active__c);
                
                //Grand parent record detail
                system.debug('Account owner name is.. '+ co.account.owner.firstname + ' '+ co.account.owner.lastname);
                
                system.debug('Account owner name is.. '+ co.account.owner.email);
                
            }
        }
    }

}