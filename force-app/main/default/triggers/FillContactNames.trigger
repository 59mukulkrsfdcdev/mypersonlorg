trigger FillContactNames on Contract (after update, after insert) {
 /*     Set<id> accIdList = new Set<id>();
    for(Contact con : Trigger.new)
    {
        accIdList.add(con.accountid);
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
*/
}