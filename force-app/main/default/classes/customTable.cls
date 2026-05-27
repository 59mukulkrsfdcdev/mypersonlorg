public with sharing class customTable {

  @AuraEnabled(cacheable=true)
  public static List<Account> getAccounts() {
    return [SELECT Id, Name, Phone FROM Account];
  }
}