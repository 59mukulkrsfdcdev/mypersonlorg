public class AccountsPaginationController {
    public ApexPages.StandardSetController setCon{
        get{
            if(setCon==null){
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator([Select id, name, rating, industry, type, annualrevenue, active__C, phone from Account]));
            }
            return setCon;
        }
        set;
    }
    public List<Account> getAccounts(){
        setCon.setPageSize(5);
        return (List<Account>) setCon.getRecords();
    }
}