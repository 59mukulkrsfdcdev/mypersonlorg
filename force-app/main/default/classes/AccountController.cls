public class AccountController {
    @AuraEnabled
    public static list<Account> fetchAccount(){
        return [Select Name,Rating,Industry,Phone from Account   ORDER BY Name ASC];
    }
   /* @AuraEnabled
    public static List<Account> getAccounts(Integer pageNumber, Integer pageSize) {
        Integer offset = (pageNumber - 1) * pageSize;
        return [SELECT Id, Name, Industry FROM Account ORDER BY Name ASC LIMIT :pageSize OFFSET :offset];
    }*/
 @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
        return [SELECT Id, Name, Industry, Phone, Type FROM Account LIMIT 10];//
    }
public class AccountContactWrapper {
        @AuraEnabled public List<Account> accounts;
        @AuraEnabled public List<Contact> contacts;

        public AccountContactWrapper(List<Account> accounts, List<Contact> contacts) {
            this.accounts = accounts;
            this.contacts = contacts;
        }
    }
 @AuraEnabled(cacheable=true)
    public static AccountContactWrapper fetchData() {
        List<Account> accList = [SELECT Id, Name, Industry, Phone FROM Account LIMIT 10];
        List<Contact> conList = [SELECT Id, FirstName, LastName, Email, Phone FROM Contact LIMIT 10];
        return new AccountContactWrapper(accList, conList);
    }

    @AuraEnabled
    public static void processWrapper(AccountContactWrapper wrapper) {
        System.debug('Received Accounts: ' + wrapper.accounts);
        System.debug('Received Contacts: ' + wrapper.contacts);
    }
}
