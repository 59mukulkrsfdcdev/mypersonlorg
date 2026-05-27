public class LeadEnrichmentBatchApex {
   
     /****************************************************************
* Class Name   : LeadEnrichmentBatchApex
* Company      : Fingertipplus
* Created Date : 12-03-2025
* @description : This class is used to get the data from LeadEnrichmentTriggerHandler class and
				 it will send the data to LeadEnrichmentQueueable Queuable class in batch.
* @author      : Praveen Kumar
* User By      : 	LeadEnrichmentTriggerHandler
			   
* Change Log:
* -----------------------------------------------------------------------------
* Ver | Author 			| 	  Date 		| Description
* -----------------------------------------------------------------------------
* 1.0 | Praveen Kumar 	| 12-03-2025 	| Initial version
* -----------------------------------------------------------------------------
**************************************************************/
 /*
global class LeadEnrichmentBatchApex implements Database.Batchable<sObject>, Database.AllowsCallouts {
    
    private List<Id> leadIds;

    public LeadEnrichmentBatchApex(List<Lead__c> leadList) {
        this.leadIds = new List<Id>();
        for (Lead__c lead : leadList) {
            this.leadIds.add(lead.Id);
        }
    }

    global Database.QueryLocator start(Database.BatchableContext BC) {
        System.debug('🚀 Starting Batch Process for Leads: ' + leadIds);
        
        // Log batch start
        Apex_Log__c log = new Apex_Log__c();
        log.Request_Type__c = 'Batch Start';
        log.Request__c = 'Batch processing started for Lead IDs: ' + leadIds.size();
        log.Status__c = 'IN_PROGRESS';
        insert log;

        return Database.getQueryLocator([
            SELECT Id, Phone__c, Lead_Type__c, Lead_status__c, Bulk_Upload__c 
            FROM Lead__c 
            WHERE Id IN :leadIds
        ]);
    }

    global void execute(Database.BatchableContext BC, List<Lead__c> scope) {
        System.debug('Processing Batch Chunk: ' + scope.size() + ' leads');

        // Log batch execution
        Apex_Log__c log = new Apex_Log__c();
        log.Request_Type__c = 'Batch Execution';
        log.Request__c = 'Processing ' + scope.size() + ' leads';
        log.Status__c = 'IN_PROGRESS';
        insert log;

        System.enqueueJob(new LeadEnrichmentQueueable(scope));
    }

    global void finish(Database.BatchableContext BC) {
       
        // Log batch completion
        Apex_Log__c log = new Apex_Log__c();
        log.Request_Type__c = 'Batch Completion';
        log.Request__c = 'Batch processing completed for Lead IDs: ' + leadIds.size();
        log.Status__c = 'COMPLETED';
        insert log;
    }
}*/

}