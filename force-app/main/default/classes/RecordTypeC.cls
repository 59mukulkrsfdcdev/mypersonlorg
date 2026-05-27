public class RecordTypeC {
 @AuraEnabled
    public static Map<String,String> GetAvailableRecordTypeAccount()
    {
        Map<String,String> recordTypeMap = new Map<String,String>();
        Schema.DescribeSObjectResult R = Account.SObjectType.getDescribe();
        List<Schema.RecordTypeInfo> RT = R.getRecordTypeInfos();
        
        for(RecordType rec : [SELECT Id,  Name, DeveloperName, Description FROM RecordType WHERE SobjectType = 'Account']) {
            recordTypeMap.put(rec.Name, rec.Description);
            system.debug('recordtype' + recordtypemap);
        }
        return recordTypeMap;
    }   
}