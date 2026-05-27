public class triggerController {
 public static void method1(List<Account>acc1){
        Set<id> accIdList = new Set<id>();
        for(Account con : acc1)
        {
            accIdList.add(con.id);
        }
        for(Account acc : [Select id, name, ContactName__c, 
                           (Select Id, name, LastName From Contacts) 
                           From Account Where Id In : accIdList])
        {
            List<String> lstSrting = new List<String>();
            for(Contact con : acc.contacts)
            {
                lstSrting.add(con.lastname);
            }
            acc.ContactName__c = String.join(lstSrting, ',');
            update acc;
        }
        
    }
}