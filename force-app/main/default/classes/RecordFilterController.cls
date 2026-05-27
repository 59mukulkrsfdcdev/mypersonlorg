public with sharing class RecordFilterController {
    
    
    public RecordFilterController() {
    }

    public List<Page_View__c> getFilteredCheckins(String profile, String user, String startDate, String endDate) {
         system.debug('startDate - ' + startDate + ' endDate- ' + endDate);
        
         Date sDate = startDate != null ? Date.valueOf(startDate) : null;
         Date eDate = endDate != null ? Date.valueOf(endDate) : null;
        
        String query = 'SELECT Name, Location__Latitude__s, Location__Longitude__s, User_Name__c, Profile_Name__c FROM Checkin__c WHERE CreatedDate >= :sDate AND CreatedDate <= :eDate';
        
        if (profile != null && profile != '') {
            query += ' AND Profile_Name__c = :profile';
        }
        
        if (user != null && user != '') {
            query += ' AND User_Name__c = :user';
        }
        
        List<Page_View__c> ld = Database.query(query);
        return ld;
    }
    
    @RemoteAction
    public static String getCheckinsJson(String profile, String user, String startDate, String endDate) {
          system.debug('startDate - ' + startDate + ' endDate- ' + endDate);
       return 'Yes';
        
    }
}