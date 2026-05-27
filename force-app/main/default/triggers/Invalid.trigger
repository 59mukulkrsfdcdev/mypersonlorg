trigger Invalid on Account (before insert, before update) {
    if(trigger.isUpdate&& trigger.isbefore){
       
            for(Account a : trigger.new){
                List<contact> con = [Select id, lastName from Contact where accountid=: a.Id];
                if(a.Invalide__c==true){
                    for(Contact c:con){
                        c.Invalide__c=true;
                    }
                   
                }
                else{
                     for(Contact c:con){
                        c.Invalide__c=false;
                    }
                }
                 update con;
            }
        }
    }