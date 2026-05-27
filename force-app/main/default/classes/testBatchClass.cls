public class testBatchClass implements Database.Batchable<sObject>{
    
    public Database.QueryLocator start( Database.BatchableContext bc){
        List<Lead> ldst = [select id from Lead];
        
        return Database.getqueryLocator([select id from Lead]);
       
    } 
    public void execute (Database.BatchableContext bc , List<sObject> cs){
        
    }
    public void finish (Database.BatchableContext bc){
}

}