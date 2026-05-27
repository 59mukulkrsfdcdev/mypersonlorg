public class CandidateExtensionController
 {
     public Candidate__c cnd{get; set;}

    public CandidateExtensionController(ApexPages.StandardController controller) 
    {
        cnd = (Candidate__c) controller.getRecord();
    }
    
    public void CustomSave()
    {
        integer recordsCount = [select count() from Candidate__c where name =: cnd.name];
        
        if(recordsCount>0)
        {
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.Error,'Candidate Name is Already Exist.'));
        }
        else
        {
            insert cnd;
             ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.Confirm,'Candidate Record Inserted Successfully'));
        
        }
    }

}