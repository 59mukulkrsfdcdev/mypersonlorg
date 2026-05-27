public class CustomController 
{
    public integer customerID {get;set;}
    public string customerName {get;set;}
    public string Address{get;set;}
    public string emailId{get;set;}
    public date dob {get;set;}
    
    // Define the Constructor
    
    public CustomController()
    {
        customerId = 200002;
        customerName = 'Ramesh Kumar';
        Address = 'Srinivas Coloney, SR Nagar, Hydrabad';
        emailID = 'ramesh@gmail.com';
        dob = date.newinstance(1990,10,30);
    }
    
    
}