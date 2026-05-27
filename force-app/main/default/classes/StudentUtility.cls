public class StudentUtility
{
	public integer studentID;
    public string studentName, Address;
    public boolean isActive;
    public decimal feeAmount;
    
    // Procedure to Assign the value...
    public void AssignValue()
    {
        studentID = 1000001;
        studentName = 'Pawan Kumar';
        address = 'Sriniwas colony, kukatpally, Hyderabad'; 
        isActive = true;
        feeAmount = 200000;
    }
    public void ShowStudentDetails()
    {
        system.debug('Student ID is '+ studentID);
        system.debug('Student Name is '+ studentName);
        system.debug('Student Address is '+ address);
        System.debug('Student fee Amount is '+ feeAmount);
        System.debug('Studnt active status.'+ isActive);
	}
}