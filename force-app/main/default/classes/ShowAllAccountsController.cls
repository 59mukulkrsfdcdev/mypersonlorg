public with sharing class ShowAllAccountsController
 {
     public list<Account> lstAccount {get; set;}
     
     public void GetAllAccount()
     {
     lstAccount = new List<Account>();
     
     lstAccount = [select id, name, rating, industry, annualrevenue, type, active__c
                     from Account];
     }
}