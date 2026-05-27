public class AccountSearchController 
{
    public string searchTest {get; set;}
    public transient List<Account> lstAccount {get; set;}
    
    public void SearchAccount()
    {
        if(searchTest != '' && searchTest != null)
        {
        searchTest += '%';
        
        lstAccount = new List<Account>();
        
        lstAccount = [select id, name, rating, industry, annualrevenue, type,active__c, phone,fax from Account where name like: searchTest];
        
        
    
    }
    }
    
}