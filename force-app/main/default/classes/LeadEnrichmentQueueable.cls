public class LeadEnrichmentQueueable {
    
    /****************************************************************
* Class Name   : LeadEnrichmentQueueable
* Company      : Fingertipplus
* Created Date : 12-03-2025
* @description : This Queueable class is responsible for enriching 
                 Lead records by making external API callouts 
                 to fetch phone, work, and lifestyle profile data.
                 It processes Leads in an asynchronous manner and 
                 logs API requests and responses.
* @author      : Praveen Kumar
* Used By      : LeadEnrichmentBatchApex
* Implements   : Queueable, Database.AllowsCallouts
* 
* Change Log:
* -----------------------------------------------------------------------------
* Ver | Author         | Date        | Description
* -----------------------------------------------------------------------------
* 1.0 | Praveen Kumar | 12-03-2025  | Initial version
* -----------------------------------------------------------------------------
*************************************************************

global class LeadEnrichmentQueueable implements Queueable, Database.AllowsCallouts {
    private List<Lead__c> leads;
    global static List<Lead__c> ldlist = new List<Lead__c>();
    
    List<Apex_Log__c> logsToInsert = new List<Apex_Log__c>();
     
    public LeadEnrichmentQueueable(List<Lead__c> leads) {
        this.leads = leads;
    }
    global void execute(QueueableContext context) {
        List<Apex_Log__c> logs = new List<Apex_Log__c>();
        List<Lead__c> leadsToUpdate = new List<Lead__c>();
        
        for (Lead__c lead : leads) {
            try {
                System.debug('🔍 Processing Lead ID: ' + lead.Id);
                
                // Log before calling APIs
                logs.add(createLog(lead.Id, 'API_CALL_STARTED', 'Processing API calls for Lead'));
                
                // phoneProfile(lead.Id);
                // workProfile(lead.Id);
                // lifestyleProfile(lead.Id);
                Map<String, Object> phoneProfileData = phoneProfile(lead.id);
                Map<String, Object> workProfileData = workProfile(lead.Id);
                Map<String, Object> lifestyleProfileData = lifestyleProfile(lead.id);
                Lead__c updatedLeads = new Lead__c(Id = lead.Id);
                
                // Update lead record with callout results
                Lead__c updatedLead = updateLeadRecord(updatedLeads, phoneProfileData, workProfileData, lifestyleProfileData);
                leadsToUpdate.add(updatedLead);
                
                // Log API call completion
                logs.add(createLog(lead.Id, 'API_CALL_SUCCESS', 'API calls completed successfully'));
                
            } catch (Exception e) {
                // Log API failure
                logs.add(createLog(lead.Id, 'API_CALL_FAILED', 'Error: ' + e.getMessage()));
                System.debug('❌ Error processing Lead ID: ' + lead.Id + ' - ' + e.getMessage());
            }
        }
        if (!leadsToUpdate.isEmpty()) {
            update leadsToUpdate;
        }
        // Insert logs
        if (!logs.isEmpty()) {
            insert logs;
        }
        if (!logsToInsert.isEmpty()) {
            insert logsToInsert;
        }
    }
    
    private static Apex_Log__c createLog(String leadId, String type, String message) {
        Apex_Log__c log = new Apex_Log__c();
        log.Request_Type__c = type;
        log.Request__c = 'Lead ID: ' + leadId + ' - ' + message;
        log.Status__c = (type == 'API_CALL_FAILED') ? 'FAILED' : 'SUCCESS';
        return log;
    }
    
    private Map<String, Object> phoneProfile(String leadId){
        Map<String, Object> responseData = new Map<String, Object>();
        Apex_Log__c log = new Apex_Log__c();
        log.Request_Type__c = 'PHONE_PROFILE';
        Lead__c lead = [select id ,Name, Phone__c from Lead__c where Id =: leadId];
        try {
            // Get API Endpoint & API Key from Custom Labels
            String endpoint = Label.WorkProfileEndPoint;
            String apiKey = Label.WorkProfileAPI;
            
            // Prepare request body
            Map<String, Object> requestBody = new Map<String, Object>{
                'mobileNumber' => lead.Phone__c,
                    'fullName' => lead.Name,
                    'enrichmentType' => new List<String>{ 'PHONE_PROFILE' }
            };
                
                system.debug('Inside phoneProfileCallout');
            String jsonBody = JSON.serialize(requestBody);
            system.debug(jsonBody);
            log.Request__c = jsonBody;
            
            // Create HTTP Request
            HttpRequest req = new HttpRequest();
            req.setEndpoint(endpoint);
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('x-api-key', apiKey);
            req.setBody(jsonBody);
            req.setTimeout(100 * 1000);
            
            // Callout to API
            Http http = new Http();
            HTTPResponse res = http.send(req);
            system.debug(res.getStatusCode());
            // Parse Response
            if (res.getStatusCode() == 200) {
                log.status__c = 'SUCCESS';
                Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
                responseData = responseMap;
                log.response__c = JSON.serialize(responseMap);
            } else {
                log.status__c = 'FAILED';
                log.Error_Message__c = 'HTTP Status: ' + res.getStatusCode();
            }
        } catch (Exception e) {
            log.status__c = 'FAILED';
            log.Error_Message__c = e.getMessage();
        }
        
        // Add log to list
          logsToInsert.add(log);
        return responseData;  
    }
    
    
    private Map<String, Object> workProfile(String leadId) {
        Map<String, Object> responseData = new Map<String, Object>();
        Apex_Log__c log = new Apex_Log__c();
        log.Request_Type__c = 'WORK_PROFILE';
        Lead__c lead = [select id ,Name, Phone__c from Lead__c where Id =: leadId];
        
        try {
            // Get API Endpoint & API Key from Custom Labels
            String endpoint = Label.WorkProfileEndPoint;
            String apiKey = Label.WorkProfileAPI;
            
            // Prepare request body
            Map<String, Object> requestBody = new Map<String, Object>{
                'mobileNumber' => lead.Phone__c,
                    'fullName' => lead.Name,
                    'enrichmentType' => new List<String>{ 'WORK_PROFILE' }
            };
                
                String jsonBody = JSON.serialize(requestBody);
            system.debug(jsonBody);
            log.Request__c = jsonBody;
            
            // Create HTTP Request
            HttpRequest req = new HttpRequest();
            req.setEndpoint(endpoint);
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('x-api-key', apiKey);
            req.setBody(jsonBody);
            req.setTimeout(100 * 1000);
            
            // Callout to API
            Http http = new Http();
            HTTPResponse res = http.send(req);
            system.debug(res.getStatusCode());
            // Parse Response
            if (res.getStatusCode() == 200) {
                log.status__c = 'SUCCESS';
                Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
                responseData = responseMap;
                log.response__c = JSON.serialize(responseMap);
            } else {
                log.status__c = 'FAILED';
                log.Error_Message__c = 'HTTP Status: ' + res.getStatusCode();
            }
        } catch (Exception e) {
            log.status__c = 'FAILED';
            log.Error_Message__c = e.getMessage();
        }
        
        // Add log to list
         logsToInsert.add(log);
        return responseData;
    }
    
    
    private Map<String, Object> lifestyleProfile(String leadId){
        Map<String, Object> responseData = new Map<String, Object>();
        Apex_Log__c log = new Apex_Log__c();
        log.Request_Type__c = 'LIFESTYLE_PROFILE';
        Lead__c lead = [select id ,Name, Phone__c from Lead__c where Id =: leadId];
        
        try {
            // Get API Endpoint & API Key from Custom Labels
            String endpoint = Label.WorkProfileEndPoint;
            String apiKey = Label.WorkProfileAPI;
            
            // Prepare request body
            Map<String, Object> requestBody = new Map<String, Object>{
                'mobileNumber' => lead.Phone__c,
                    'fullName' => lead.Name,
                    'enrichmentType' => new List<String>{ 'LIFESTYLE_PROFILE' }
            };
                
                String jsonBody = JSON.serialize(requestBody);
            log.Request__c = jsonBody;
            
            // Create HTTP Request
            HttpRequest req = new HttpRequest();
            req.setEndpoint(endpoint);
            req.setMethod('POST');
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('x-api-key', apiKey);
            req.setBody(jsonBody);
            req.setTimeout(100 * 1000);
            
            // Callout to API
            Http http = new Http();
            HTTPResponse res = http.send(req);
            system.debug(res.getStatusCode());
            // Parse Response
            if (res.getStatusCode() == 200) {
                log.status__c = 'SUCCESS';
                Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
                responseData = responseMap;
                log.response__c = JSON.serialize(responseMap);
            } else {
                log.status__c = 'FAILED';
                log.Error_Message__c = 'HTTP Status: ' + res.getStatusCode();
            }
        } catch (Exception e) {
            log.status__c = 'FAILED';
            log.Error_Message__c = e.getMessage();
        }
        
        // Add log to list
          logsToInsert.add(log);
        return responseData;
        
    }
    
     
    private Lead__c updateLeadRecord(Lead__c lead, Map<String, Object> phoneProfileData, Map<String, Object> workProfileData, Map<String, Object> lifestyleProfileData) {
        system.debug('Insidethe updateLeadRecord');
        system.debug(phoneProfileData);
        // Update Phone Profile fields
        if (phoneProfileData != null) {
            Map<String, Object> status = (Map<String, Object>) phoneProfileData.get('status');
            Map<String, Object> data = (Map<String, Object>) phoneProfileData.get('data');
            
            system.debug('Inside the Phone Profile');
            if (status != null ) {
                if (status.get('code') == 'success' || status.get('code') == 'not_available') {
                    if (data.containsKey('phoneProfile')) {
                        Map<String, Object> phoneProfile = (Map<String, Object>) data.get('phoneProfile');
                        lead.Current_Network__c = (String) phoneProfile.get('Current_Network__c');
                        lead.Connection_Type__c = (String) phoneProfile.get('Connection_Type__c');
                        lead.Home_Network__c = (String) phoneProfile.get('Home_Network__c');
                        lead.Age_of_Mobile__c = (Decimal) phoneProfile.get('Age_of_Mobile__c');
                        lead.Circle__c = (String) phoneProfile.get('Circle__c');
                        lead.Phone_Profile_Enrichment_Date__c = System.Now();
                        lead.Phone_Profile_Status__c = (String) phoneProfile.get('Phone_Profile_Status_c');
                        lead.Phone_Profile_API_HTTP_Status__c = String.valueOf(phoneProfile.get('Phone_Profile_API_HTTP_Status_c'));
                        
                        system.debug(data);
                   
                    }
                    
                }  
                if(status.get('code') == 'junk'){
                    if (data.containsKey('phoneProfile')) {
                        Map<String, Object> phoneProfile = (Map<String, Object>) data.get('phoneProfile');
                        lead.Phone_Profile_Enrichment_Date__c = System.Now().addHours(5).addMinutes(30);
                        lead.Phone_Profile_Status__c = (String) phoneProfile.get('Phone_Profile_Status_c');
                        lead.Phone_Profile_API_HTTP_Status__c = String.valueOf(phoneProfile.get('Phone_Profile_API_HTTP_Status_c'));
                        lead.Lead_status__c='Invalid';
                        lead.Lost_Reason__c='Junk enquiry';
                        system.debug(data);
                        
                        
                    }
                }
            }
            
        }
        
        // Update Work Profile fields
        if (workProfileData != null ) {
            Map<String, Object> status = (Map<String, Object>) workProfileData.get('status');
            Map<String, Object> data = (Map<String, Object>) workProfileData.get('data');
            
            
            System.debug('Inside the Work Profile');
            if (status != null ) {
                if (status.get('code') == 'success' || status.get('code') == 'not_available') {
                    if (data.containsKey('workProfile')) {
                        Map<String, Object> workProfile = (Map<String, Object>) data.get('workProfile');
                        lead.Current_Company__c = (String) workProfile.get('Current_Company__c');
                        lead.Current_Company_Work_Exp__c = (Decimal) workProfile.get('Current_Company_Work_Exp__c');
                        lead.Over_All_Work_Experience__c = (Decimal) workProfile.get('Overall_Work_Experience__c');
                        lead.UAN_Number__c = (String) workProfile.get('UAN_Number__c');
                        lead.Work_Profile_Enrichment_Date__c = System.today();
                        lead.Work_Profile_Status__c = (String) workProfile.get('Work_Profile_Status_c');
                        lead.Work_Profile_API_Http_Status__c = String.valueOf(workProfile.get('Work_Profile_API_HTTP_Status_c')) ;
                        system.debug(data);
                        
                    }
                    
                }
                if(status.get('code') == 'junk'){
                    lead.Work_Profile_Enrichment_Date__c = System.today();
                    lead.Work_Profile_Status__c = (String) status.get('message');
                    lead.Work_Profile_API_Http_Status__c =String.valueOf(status.get('httpStatus'));
                    system.debug(data);
                    
                    
                }
            }
        }
        
        // Update Lifestyle Profile fields
        if (lifestyleProfileData != null ) {
            System.debug('Insiethe Lifestyle Profile');
            Map<String, Object> status = (Map<String, Object>) lifestyleProfileData.get('status');
            Map<String, Object> data = (Map<String, Object>) lifestyleProfileData.get('data');
            if (status != null ) {
                if (status.get('code') == 'success' || status.get('code') == 'not_available') {
                    if (data.containsKey('lifestyleProfile')&& data.get('lifestyleProfile') != null) {
                        Map<String, Object> lifestyleProfile = (Map<String, Object>) data.get('lifestyleProfile');
                        
                        lead.Lifestyle_Profile_Status__c = (lifestyleProfile.containsKey('Lifestyle_Profile_Status_c') && lifestyleProfile.get('Lifestyle_Profile_Status_c') != null) ? (String) lifestyleProfile.get('Lifestyle_Profile_Status_c') : null;
                        
                        lead.Lifestyle_Profile_API_HTTP_Status__c = (lifestyleProfile.containsKey('Lifestyle_Profile_API_HTTP_Status_c') && lifestyleProfile.get('Lifestyle_Profile_API_HTTP_Status_c') != null) ? String.valueOf( lifestyleProfile.get('Lifestyle_Profile_API_HTTP_Status_c')) : null;
                        
                        lead.Lifestyle_Profile_Enrichment_Date__c = System.today();
                        
                        lead.Vehcile_Number__c = (lifestyleProfile.containsKey('Vehicle_Number__c') && lifestyleProfile.get('Vehicle_Number__c') != null)  ? (String) lifestyleProfile.get('Vehicle_Number__c')   : null;
                        
                        lead.Vehcile_Registered_Address__c = (lifestyleProfile.containsKey('Vehicle_Registered_Address__c') && lifestyleProfile.get('Vehicle_Registered_Address__c') != null) ? (String) lifestyleProfile.get('Vehicle_Registered_Address__c') : null;
                        
                        lead.Vehcile_Brand__c = (lifestyleProfile.containsKey('Vehicle_Brand__c') && lifestyleProfile.get('Vehicle_Brand__c') != null) ? (String) lifestyleProfile.get('Vehicle_Brand__c') : null;
                        
                        lead.Vehcile_Model__c = (lifestyleProfile.containsKey('Vehicle_Model__c') && lifestyleProfile.get('Vehicle_Model__c') != null) ? (String) lifestyleProfile.get('Vehicle_Model__c') : null;
                        
                        lead.Is_Vehcile_Financed__c = (lifestyleProfile.containsKey('Is_Vehicle_Financed__c') && lifestyleProfile.get('Is_Vehicle_Financed__c') != null) ? (Boolean) lifestyleProfile.get('Is_Vehicle_Financed__c') : false; // Default to false if null
                        
                        lead.Vehcile_Category__c = (lifestyleProfile.containsKey('Vehicle_Category__c') && lifestyleProfile.get('Vehicle_Category__c') != null) ? (String) lifestyleProfile.get('Vehicle_Category__c') : null;
                        
                        lead.Vehcile_Financier__c = (lifestyleProfile.containsKey('Vehicle_Financier__c') && lifestyleProfile.get('Vehicle_Financier__c') != null) ? (String) lifestyleProfile.get('Vehicle_Financier__c')  : null;
                        
                        // Safe handling of registration_date conversion
                        if (lifestyleProfile.containsKey('registration_date') && lifestyleProfile.get('registration_date') != null) {
                            try {
                                lead.Vehcile_Registration_Date__c = Date.valueOf((String) lifestyleProfile.get('registration_date'));
                            } catch (Exception e) {
                                system.debug('Error converting registration_date to Date: ' + e.getMessage());
                                lead.Vehcile_Registration_Date__c = null; // Set to null if conversion fails
                            }
                        } else {
                            lead.Vehcile_Registration_Date__c = null;
                        }
                        
                        lead.Vehcile_Color__c = (lifestyleProfile.containsKey('color') && lifestyleProfile.get('color') != null) ? (String) lifestyleProfile.get('color') : null;
                        system.debug(data);
                    } 
                }
                if(status.get('code') == 'junk'){
                    lead.Lifestyle_Profile_Status__c =  (String) status.get('message');
                    lead.Lifestyle_Profile_API_HTTP_Status__c = String.valueOf(status.get('httpStatus'));
                    lead.Lifestyle_Profile_Enrichment_Date__c = System.today();
                    system.debug(data);
                    
                    
                }
            }
        }
        
        return lead;
    }
    
}
*/ 
}