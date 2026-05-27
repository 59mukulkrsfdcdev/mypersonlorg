public class SitevisitwhatsNotificationScheduler {
    /*
    global class SitevisitwhatsNotificationScheduler implements Database.Batchable<sObject>,Database.Stateful,Schedulable {
    
    global SitevisitwhatsNotificationScheduler(){
    }
    global Database.QueryLocator start(Database.BatchableContext BC) {
        //   Datetime currentDate = Datetime.now();
        // Datetime previousDate = currentDate.addDays(-1);
        //  String query = 'SELECT Id, Name,Project__c,Allocated_Project__c,Email__c,Secondary_Email__c,Lead_Owner_Mobile_No__c,Lead_Owner_Email_ID__c,Lead_Owner_Full_Name__c , (SELECT Id, Status__c, Name FROM Site_Visit__r WHERE Status__c = \'Completed\') FROM lead__c WHERE CreatedDate = :previousDate ';
        
        //  return Database.getQueryLocator([select id, Name,(Select id,Status__c from Site_Visit__r where Status__c='Completed' limit 1  ) from Lead__c where Lead_Created_Date__c=1]);
        
        // return Database.getQueryLocator(query);
        
        return Database.getQueryLocator([SELECT Id,Name,Lead_ID__c,Phone__c,Country_Code__c,Email__c FROM Lead__c WHERE Lead_status__c NOT IN ('SV Schedule','SV Done', 'Closed Lost','Booked(Negotiation)','Lost' ) AND Allocated_Project__c='JRC Wild Woods' AND Lead_Age__c = 1]);
        
    }
    global void execute(Database.BatchableContext BC, List<lead__c> scope) {
        system.debug('++++'+scope);
        for(lead__c ld : scope){
            //   lucepControllerforafter5hr.Submitleadforqualification(ld.Name,ld.Lead_ID__c,ld.Lead_ID__c,ld.Phone__c,ld.Country_Code__c,ld.Email__c,'12', 'JRC Wildwoods');
            
            // WelcomeMailController.sendWelcomeEmailtoCustomer(ld.id);
            
        }
    }
    
    global void finish(Database.BatchableContext BC) {
        // Execute any post-processing logic if needed
    }
    
    
    global void execute(SchedulableContext SC){
        database.executeBatch(new SitevisitwhatsNotificationScheduler(),100);
        List<Lead__c> lstsite =[SELECT Id,Name,Lead_ID__c,Phone__c,Country_Code__c,Email__c FROM Lead__c WHERE Lead_status__c NOT IN ('SV Schedule','SV Done', 'Closed Lost','Booked(Negotiation)','Lost' ) AND Allocated_Project__c='JRC Wild Woods' AND Lead_Age__c = 1];
        system.debug(lstsite.size());
        if(lstsite.size()>0){
            
            for(Lead__c ld : lstsite){
                lucepController.Submitleadforqualification(ld.Name,ld.Lead_ID__c,ld.Lead_ID__c,ld.Phone__c,ld.Country_Code__c,ld.Email__c,'11', 'JRC Wildwoods');
                
                // WelcomeMailController.sendWelcomeEmailtoCustomer(ld.Contact1__c);
                
            }
        }
        
    } 

    
}*/

}