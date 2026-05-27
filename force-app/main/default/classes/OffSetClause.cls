public class OffSetClause 
{
	public static void GetposWithOffset(integer recordsLimit, integer recordToSkip)
    {
        list <Position__c> lstPos = [select id, name, location__c, position_status__c,
                                     close_date__c, minimum_pay__c, maximum_pay__c
                                     from Position__c
                                     order by name
                                     limit: recordsLimit
                                     offset : recordToSkip];
        
        System.debug('Resultset records ocunt is.... '+ lstpos.size());
        
        if(! lstPos.isEmpty())
        {
            for(Position__c pos : lstPos)
            {
                System.debug('Position record is..... '+ pos);
			}
        }
	}
}