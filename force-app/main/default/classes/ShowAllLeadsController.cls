public class ShowAllLeadsController 
{
    public List<lead> lstLead {get; set;}
    
    // Default Constructor....
    public ShowAllLeadsController()
    {
        lstLead = new List<Lead>();
        
        lstLead = [select id, firstname, lastname, email, company, status, phone,
                       fax, annualrevenue from lead where isConverted = false];
    }
}