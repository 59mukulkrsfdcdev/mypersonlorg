/****************************************************************
* Class Name   : LeadEnrichmentTriggerHandler
* Company      : Fingertipplus
* Created Date : 12-03-2025
* @description : This class is used to get the Lead data from lead Trigger and after that it will call LeadEnrichmentBatchApex Batch apex Class
* @author      : Praveen Kumar
* User By      : 	LeadTrigger
			   
* Change Log:
* -----------------------------------------------------------------------------
* Ver | Author 			| 	  Date 		| Description
* -----------------------------------------------------------------------------
* 1.0 | Praveen Kumar 	| 12-03-2025 	| Initial version
* -----------------------------------------------------------------------------
*************************************************************/
public class LeadEnrichmentTriggerHandler {/*
    private static Boolean isBatchExecuted = false;

    public static void handleLeadEnrichment(List<Lead__c> leadList) {
        if (!isBatchExecuted && !leadList.isEmpty()) {
            isBatchExecuted = true; // Prevent multiple executions

            // Pass only the trigger records to the batch job
            LeadEnrichmentBatchApex batchJob = new LeadEnrichmentBatchApex(leadList);
            Database.executeBatch(batchJob, 200);
        }
    }*/
}