trigger OppAmount on Opportunity ( after insert, after update, after delete) {
    
    Map<Id, List<Opportunity>> acctoopp = new Map<Id, List<Opportunity>>();
    Set<Id> acctIds = new Set<Id>();
    List<Opportunity> opptyList = new List<Opportunity>();
    if(trigger.isUpdate || trigger.isInsert){
        for(Opportunity oppty : trigger.New){
            if(oppty.AccountId != null){
                acctIds.add(oppty.AccountId);
            }
        }    
    }
    if(trigger.isDelete){
        for(Opportunity oppty : trigger.old){
            if(oppty.AccountId != null){
                acctIds.add(oppty.AccountId);
            }
        }    
    }
    if(acctIds.size() > 0){
        opptyList = [SELECT Amount, AccountId FROM Opportunity WHERE AccountId IN : acctIds];
        for(Opportunity oppty : opptyList){
            if(!acctoopp.containsKey(oppty.AccountId)){
                acctoopp.put(oppty.AccountId, new List<Opportunity>());
            }
            acctoopp.get(oppty.AccountId).add(oppty); 
        }   
        List<Account> acctList = new List<Account>();
        acctList = [SELECT Opportunity_Total_Amount__c  FROM Account WHERE Id IN: acctIds];
        for(Account acct : acctList){
            List<Opportunity> opplist = new List<Opportunity>();
            opplist = acctoopp.get(acct.Id);
            Double oppyamount = 0;
            for(Opportunity oppty : opplist){
                if(oppty.Amount != null){
                    oppyamount += oppty.Amount;
                }
            }
            acct.Opportunity_Total_Amount__c  = oppyamount;
        }
        update acctList;
    }



}