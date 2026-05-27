public with sharing class overrideStandabuttonwithLC 
{
     @AuraEnabled
    public static ID saveExpense(Expense__C expRec){
        try{
            System.debug('Expenses::'+exprec);
            insert expRec;
        }
        catch(Exception e){
            system.debug('e-->' + e.getMessage());
        }
        
        return expRec.Id;
    }  

}