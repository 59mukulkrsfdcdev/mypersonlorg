public class SinglePrimaryContact {
    // Enforce Single Primay contact on Account
    public static void method(List<Contact> conlist, Map<Id,Contact> oldMap){
        set<Id> parentId = new set<Id>();
        
        if(!conlist.IsEmpty()){
            for(Contact con : conlist){
                if(oldMap != null){
                    Contact oldcon = oldMap.get(con.Id);
                    if(oldcon.AccountId != con.AccountId){
                        parentId.add(oldcon.AccountId);
                        parentId.add(con.AccountId);
                    }
                     else{
                    parentId.add(con.AccountId);
                }
                }
                 else{
                    parentId.add(con.AccountId);
                }
               
            }
        }
        if(!parentId.isEmpty()){
            List<Contact> contactlist = [Select id, AccountId, Primary_Contact__c from contact where AccountId In: parentId and Primary_Contact__c= true  ];
            
            Map<Id, Integer> conMap = new Map<Id, Integer>();
            if(!contactlist.isEmpty()){
                for(Contact conobj: contactlist){
                    conMap.put(conobj.AccountId,contactlist.size() );
                }
                for(Contact errcon :conlist ){
                    if(errcon.Primary_Contact__c== true && conMap.containsKey(errcon.AccountId)&& conMap.get(errcon.AccountId)>0){
                        errcon.addError('This account can not has more prime contact');
                    }
                }
            }
            
        }
        
    }

}