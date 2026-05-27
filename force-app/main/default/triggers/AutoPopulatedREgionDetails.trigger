trigger AutoPopulatedREgionDetails on Customer__c (before insert, before update)
{
    if(trigger.isbefore && (trigger.isInsert || trigger.isupdate))
    {
        for( customer__c cust : Trigger.new)
        {
            if(cust.Region_Name__c != null && cust.Region_Name__c != '')
            {
               cust.Region_Manager_Name__c = RegionDetails__c.GetValues(cust.Region_Name__c).Region_Manager__c;
              /*  
                if(cust.Region_Name__c == 'Asia')
                    cust.Region_Manager_Name__c = 'Mukesh Kumar';
                else if(cust.Region_Name__c =='America')
                    cust.Region_Manager_Name__c =' David ';
                else if(cust.Region_Name__c == 'Europe') 
                    cust.Region_Manager_Name__c = ' Ashley';
                else if(cust.Region_Name__c == 'Middle Ease')
                    cust.Region_Manager_Name__c = 'Abdul ';
                else if(cust.Region_Name__c == 'China')
                    cust.Region_Manager_Name__c = 'Dong lee';
                else if(cust.Region_Name__c == 'Australia')
                    cust.Region_Manager_Name__c = 'Jessey';
                else if(cust.Region_Name__c == 'Japan')
                    cust.Region_Manager_Name__c =' Domnic';
*/
            }
        }
    } 

}