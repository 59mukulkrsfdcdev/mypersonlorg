public class CustomWrapper 
{
    public id recordId {get; set;}
    public string firstName {get; set;}
    public string lastName {get; set;}
    public string emailID {get; set;}
    public string contactNumber {get; set;}
    public string fax {get; set;}
    
    public Boolean isSelected {get; set;}
    
    public CustomWrapper(Lead ldRecord, boolean checkedStatus)
    {
        recordId = ldRecord.Id;
        firstName = ldRecord.FirstName;
        lastName = ldRecord.LastName;
        emailId = ldRecord.Email;
        contactNumber = ldRecord.Phone;
        fax = ldRecord.Fax;
        
        isSelected = checkedStatus;
        
    }
    
    public CustomWrapper(Contact con, boolean checkedStatus)
    {
        recordId = con.Id;
        firstName = con.FirstName;
        lastName = con.LastName;
        emailID = con.Email;
        contactNumber = con.Phone;
        fax = con.Fax;
        
        isSelected = checkedStatus;
	}

}