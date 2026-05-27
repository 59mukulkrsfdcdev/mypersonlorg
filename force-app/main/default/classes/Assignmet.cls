global class Assignmet {
     @AuraEnabled
    global static void startDay( decimal latt,decimal lon, string assigninId){  
        Account assing1 = [select id,Actual_Start_Date__c,Check_in__Latitude__s,Check_in__Longitude__s from  Account where id =: assigninId];
        
        assing1.Check_in__Latitude__s = latt;
        assing1.Check_in__Longitude__s = lon;
        
        assing1.Actual_Start_Date__c=DateTime.now();
        
        
        update assing1;
        
    }
    @AuraEnabled
    global static void endDay( decimal  latt,decimal lon, string assignoutId){  
        Account assing2 = [select id,Check_in__Latitude__s,Actual_End_Date__c,Check_out__Latitude__s,Check_out__Longitude__s from  Account where id =: assignoutId];
        
        
        assing2.Check_out__Latitude__s = latt;
        assing2.Check_out__Longitude__s = lon;
        
        assing2.Actual_End_Date__c=DateTime.now();
        
        update assing2;
    }



}