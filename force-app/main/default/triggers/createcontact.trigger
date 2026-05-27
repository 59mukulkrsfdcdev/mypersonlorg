trigger createcontact on Account (after insert, after update) {
    
    if(trigger.isInsert )
    {
        list<contact> con = new list<contact>();
        
        for(Account ac: trigger.new)
        {
            for( integer i=1; i< ac.NC__c;i++){
            contact c = new contact();
            c.lastname= ac.name+''+ i;
            c.accountid= ac.id;
            c.MobilePhone= ac.Phone+''+i;
               
            con.add(c);
               
            }
            
        }
        
        insert con;
       triggerController.method1(trigger.new);
    
    }
}