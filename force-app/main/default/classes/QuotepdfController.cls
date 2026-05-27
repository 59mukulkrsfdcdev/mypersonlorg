public class QuotepdfController {
    Public String numToWord{get;set;}
    public Account qu{get;set;}
    public user ut{get;set;}
    public id recid{get;set;}
    Public set<Id> prdId{get;set;}
    public integer rowmerge{get;set;}
    public string renderas{get;set;}
    public string phone{get;set;}
    public string Name{get;set;}
    public Decimal Amount{get;set;}
    
   
    
    
    
    
    public QuotepdfController(ApexPages.StandardController controller) {
        
        
        recid = ApexPages.currentPage().getParameters().get('id'); 
        prdId = new set<Id>();
        
        qu=[Select Id,Name,Phone,AnnualRevenue from Account where id=:recid]; 
       
        Name= qu.Name;
        Phone= qu.Phone;
        Amount=qu.AnnualRevenue;
      	AmounInWord amtow = new AmounInWord();
        
        numToWord = amtow.getNumberTOWordConvertion(qu.AnnualRevenue);
        
        system.debug(numToWord );
        
        
        renderas = 'pdf';
    }

}