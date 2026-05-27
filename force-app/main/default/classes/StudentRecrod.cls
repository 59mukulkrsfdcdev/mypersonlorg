/*
Write an apex program to fetch all candidate record and fetch all candidate records and store it into "Map" collection.

*/

public class StudentRecrod 
{
	public static void GetPostionRecrod()
    {
        Map<id, position__c> mapPos = new Map<id, position__c>([select id, name, location__c, position_status__c,
                                     maximum_pay__c,close_date__c from Position__c]);
        
        if(!mapPos.isEmpty())
        {
            for(Position__c pos : mapPos.values())
            {
                System.debug('Position record id is ---- '+ pos.Id);
                system.debug('Position name is ---- '+ pos.Name);
                system.debug('Position locationo is ...... '+ pos.Location__c);
                system.debug('Position status is ----- '+ pos.Position_Status__c);
                System.debug('Position maximum pay is ..... '+ pos.Maximum_Pay__c);
                system.debug('Position close date is ..... '+ pos.Close_Date__c);
                System.debug('-----------------------------------------------------');
                
			}
		}
       /* Map<id,Position__c> mapPos = new Map<id, Position__c>();
        list<Position__c> lstPos = [select id, name, location__c, position_status__c,
                                     maximum_pay__c,close_date__c from Position__c];
        // copy the record to map....
        if(! lstPos.isEmpty())
        {
            for(Position__c pos: lstPos )
            {
                mapPos.put(pos.id,pos);
			}
        }
	*/
        
        
	}
}