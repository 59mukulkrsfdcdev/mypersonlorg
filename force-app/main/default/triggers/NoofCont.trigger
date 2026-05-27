trigger NoofCont on Contact (after insert, after update , after unDelete, after delete) {
    
    /*  if(Trigger.IsInsert){

Set<Id> acid = new Set<Id>();

For(Contact con : Trigger.New){

if(con.AccountId != null){
acid.add(con.AccountId);
}
}

Map<Id, Integer> countcont = new Map<Id, Integer>();

List<AggregateResult > count = [Select AccountId, Count(Id) cont from Contact where AccountId IN :acid Group by AccountId];
For(AggregateResult ar : count){
countcont.put((Id)ar.get('AccountId'), (Integer)ar.get('cont'));

}
List<Account> lstac = new List<Account>();

For(Contact con : Trigger.new){
Integer cont = countcont.get(con.AccountId);
if(countcont.containskey(con.AccountId)){
Account ac = new Account();
ac.Id = con.AccountId;
ac.AccountNumber = String.ValueOf(cont);
lstac.add(ac);
}
}

if(lstac.size()>0){
update lstac;
}

}
*/    
    // Write the trigger to count the number of contacts assosiate with account. using aggergate query
    
    
    //Trigger ContactTrigger on Trigger( After Insert){
    
    
    Set<Id> accId = new Set<Id>();
    
    if(Trigger.IsInsert || Trigger.IsUnDelete){
        
        For(Contact  con : Trigger.New){
            
            if(con.AccountId != null) {
                
                accId.add(con.AccountId);
            }
        }
        
    }
    
    if(Trigger.IsDelete){
        
        for( Contact con : Trigger.Old){
            
            if(con.AccountId != null ){
                
                accId.add(con.AccountId);
            }
        }
    }
    if(Trigger.isUpdate){
        
        For(Contact con : TRigger.new){
            
            if(con.AccountId != Trigger.OldMap.get(con.Id).AccountId){
                
                accId.add(con.AccountId);
            }
            
        }
    }
    
    Map<Id, Integer> noOfContact = new Map<Id, Integer>();
    
    For(AggregateResult ar :  [Select AccountId , Count(Id) cont From Contact Where AccountId =: accId Group By AccountId]){
        
        noOfContact.put((Id)ar.get('AccountId'), (Integer)ar.get('cont'));
    }
    
    List<Account> acclist = new List<Account>();
    
    For( Id acIdd : accId){
        Integer count = noOfContact.get(acIdd );
        Account acc = new Account();
        
        acc.Id = acIdd ;
        acc.AccountNumber = String.Valueof(count);
        acclist.add(acc);
        
        
        
    }
    
    if(!acclist.isEmpty()){
        update acclist;
    }
}