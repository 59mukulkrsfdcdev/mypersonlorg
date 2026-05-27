/*
     * @ class Name: LeadHandler
     * @ Description : This class contains all the methods to be used to process lead records.
     * @ Auther : Praveen Kumar
     * @ Created Date : 12/ 05/ 2022
     * @ References : AutoleadConvert - Trigger
     * @ Modified By:
     * 			user Name 		Modified Date 		Reason
     * -------------------------------------------------------------
     * 		Praveen 		12/05/2022			To fix the defect (Id: 2345
    
  */


public class LeadHandler 
{
     /*
     * @ Method Name: AfterUpdate
     * @ Description : This method is used to convert lead record automatically.
     * @ Auther : Praveen Kumar
     * @ Created Date : 12/ 05/ 2022
     * @ Parameters: List<Lead>
     * 		Name		Type
     * ----------------------------
     * 		List<lead>  lstlead
     * 
     * @ Returns : N/A
     * @ Throws : DMLExceptions
  */
    public static void afterupdate(list<lead> lstlead)
    {
          LeadStatus ldStatus = [select id, masterlabel, isConverted from leadstatus where isConverted = true];
        list<Database.LeadConvert> leadtoConvert = new list<Database.LeadConvert>();
        
        for(lead ld : lstlead)
        {
            // create a leadconvert class object...
            
            if(ld.isconverted == false && ld.status == 'Closed - Converted')
            {
                
				Database.LeadConvert lconvert = new Database.LeadConvert();
                
                lconvert.setLeadId(ld.Id);
                 
                lconvert.setSendNotificationEmail(true);
                
                lconvert.setConvertedStatus(ldStatus.MasterLabel);
                
                lconvert.setDoNotCreateOpportunity(ld.Do_not_Create_Opportunity__c);
                
                // Add it to the collection...
                leadtoConvert.add(lconvert);
			} 
     
        }
        try
        {
         if(!leadtoConvert.isempty())
         {
            database.LeadConvertResult[] res = database.convertLead(leadtoConvert);
         }
        }
        catch(DMLException dmlex)
        {
            system.debug('DML exception are occured upon lead conversion');
            system.debug('Excepition message is.... '+ dmlex.getMessage());
            system.debug('Exeption statck trace string is... '+ dmlex.getStackTraceString());
            system.debug('Root couse--- '+ dmlex.getCause());
            system.debug('Show line number .... '+ dmlex.getLineNumber());
            
        }
        catch(Exception ex)
        {
            system.debug('Exception are occured upon lead conversion ... '+ ex.getMessage());
		}
    }

}