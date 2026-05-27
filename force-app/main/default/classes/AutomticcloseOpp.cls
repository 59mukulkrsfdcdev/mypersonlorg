public class AutomticcloseOpp {
    public static void method(List<Account> acclist, Map<Id, Account> oldMap){
        set<id> accId = new set<Id>();
        if(!acclist.isEmpty()){
            for(Account acc : acclist){
                if(acc.Close_All_Opp__c== true && oldMap.containskey(acc.id) && oldMap.get(acc.id).Close_All_Opp__c== false){
                    accId.add(acc.id);
                }
            }
        }
        list<Opportunity> listOpp = new List<Opportunity>();
        if(!accId.isEmpty()){
            list<Opportunity> oolist = [select id, AccountId from Opportunity where AccountId In: accId and stageName!='Close won' and Probability >= 70];
        	
            if(!oolist.IsEmpty()){
                for(Opportunity opp : oolist){
                    opp.StageName='Closed won';
                    opp.CloseDate= system.today();
                    listOpp.add(opp);
                }
            }
        }
        update listOpp;
    }

}