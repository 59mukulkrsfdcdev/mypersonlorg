trigger CheckIn on Account (before insert, before update) {
    
        
        for(Account a:trigger.new)
        {
          decimal dist = a.Distance_bt_Check_in_check_out__c;
        if(dist>100 )
        {
            a.adderror('Distance should not be more then 100 m');
        }
            
        
    }

}