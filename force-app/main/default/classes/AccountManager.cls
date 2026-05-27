public with sharing class AccountManager {
    @auraEnabled(cacheable=true)
    
    public static List<Account> getAccount () {
        return [select id, name,AnnualRevenue, phone from account LIMIT 10 ];
    }
   
}