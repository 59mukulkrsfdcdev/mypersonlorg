public class OppTriggerclass {
    // update the parent account field with the opportunity name that has Highest Amount
    
    public static void method(List<Opportunity> opplist, Map<id, Opportunity> oldMap){
        set<Id> parentId = new set<Id>();
        
        if(!opplist.isEmpty()){
            for(Opportunity newopp : opplist){
                if(oldMap != null){
                    Opportunity oldOpp = oldMap.get(newopp.Id);
                    
                    if(oldOpp.AccountId != newopp.AccountId){
                        parentId.add(oldOpp.AccountId);
                        parentId.add(newopp.AccountId);
                    }
                    else{
                         parentId.add(newopp.AccountId);
                    }
                }
                  else{
             parentId.add(newopp.AccountId);
        }
      
                
            }
        }
        
        if(!parentId.IsEmpty()){
            List<Account> acclist = [Select Max_Opp_Name__c, (Select Name, Amount from Opportunities where Amount != null order by 
                                                             Amount desc limit 1) From Account where Id IN: parentId];
            
            List<Account> listToUpdate = new List<Account>();
            if(!acclist.isEmpty()){
                for(Account acc : acclist){
                    if(!acc.Opportunities.isEmpty()){
                        acc.Max_Opp_Name__c= acc.Opportunities[0].Name;
                        listToUpdate.add(acc);
                    }
                    else{
                         acc.Max_Opp_Name__c=null;
                        listToUpdate.add(acc);
                    }
                }
            }
            if(!listToUpdate.isEmpty()){
                update listToUpdate;
            }
            
        }
        
    }

}