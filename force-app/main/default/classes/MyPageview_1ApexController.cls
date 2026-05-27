public class MyPageview_1ApexController {
    
    @RemoteAction
    public static string getChartData(String user, Date startDate, Date endDate) {
      system.debug('user'+user+'Start Date '+startDate +'End Date'+endDate);
        // Query to retrieve data based on user, startDate, and endDate
        List<AggregateResult> results = [SELECT User__c, SUM(Duration__c) totalDuration FROM Page_View__c WHERE User__c = :user AND CreatedDate >= :startDate AND CreatedDate <= :endDate GROUP BY User__c ];

     return 'Praveen';
}
}