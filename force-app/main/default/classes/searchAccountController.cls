public class searchAccountController {
    @AuraEnabled
    public static List<Account> fetchaccount(String searchkeyword){
        string keyss = searchkeyword +'%';
        List<Account> acclist = new List<Account>();
        List<Account> accclist =[Select Name, industry,Type,phone from Account where Name like: keyss limit 10];
        for(Account acc:accclist){
            acclist.add(acc);
        }
        return acclist;
}

}