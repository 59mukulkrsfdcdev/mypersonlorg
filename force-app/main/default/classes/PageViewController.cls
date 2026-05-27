public class PageViewController {
    public List<SelectOption> profiles { get; set; }
    public List<SelectOption> users { get; set; }
    public String selectedProfile { get; set; }
    public String selectedUser { get; set; }
    public Date startDate { get; set; }
    public Date endDate { get; set; }

    public PageViewController() {
        profiles = getProfiles();
        users = getAllUsers(); 
    }

    public List<SelectOption> getProfiles() {
        List<SelectOption> options = new List<SelectOption>();
        for (Profile p : [SELECT Id, Name FROM Profile]) {
            options.add(new SelectOption(p.Id, p.Name));
        }
        return options;
    }

    public List<SelectOption> getAllUsers() {
        system.debug('==');
        List<SelectOption> options = new List<SelectOption>();
        for (User u : [SELECT Id, Name FROM User]) {
            options.add(new SelectOption(u.Id, u.Name));
        }
        return options;
    }

    @RemoteAction
    public static List<SelectOption> fetchUsers(String profileId) {
        List<SelectOption> options = new List<SelectOption>();
        system.debug(profileId);
        if (profileId != null && profileId!='') {
            for (User u : [SELECT Id, Name FROM User WHERE ProfileId = :profileId]) {
                options.add(new SelectOption(u.Id, u.Name));
            }
        }
        return options;
    }

    @RemoteAction
    
    public static List<Map<String, Object>> fetchPageViewData(String userId, Date startDate, Date endDate) {
        List<Map<String, Object>> chartData = new List<Map<String, Object>>();
        
        String query = 'SELECT COUNT(Id) countRecord, Event_Date__c, SUM(Duration__c) sumDuration, AVG(Duration__c) avgDuration ' +
                       'FROM Page_View__c ' +
                       'WHERE Event_Date__c != null ' +
                       'AND User__c = :userId ' +
                       'AND Event_Date__c >= :startDate ' +
                       'AND Event_Date__c <= :endDate ' +
                       'GROUP BY Event_Date__c ' +
                       'ORDER BY Event_Date__c';
        
        AggregateResult[] results = Database.query(query);
        
        for (AggregateResult ar : results) {
            Map<String, Object> data = new Map<String, Object>();
            data.put('date', ar.get('Event_Date__c'));
            data.put('count', ar.get('countRecord'));
            data.put('sumDuration', ar.get('sumDuration'));
            data.put('avgDuration', ar.get('avgDuration'));
            chartData.add(data);
        }
        
        return chartData;
    }
      @RemoteAction
    public static List<Map<String, Object>> getPageViewData(String profile, String user, String startDate, String endDate) {
        List<Map<String, Object>> pageViewData = new List<Map<String, Object>>();
/*
        // Build dynamic query components
        String profileFilter = (!String.isEmpty(profile)) ;  // Fallback if no profile filter
        String userFilter = (!String.isEmpty(user)) ;  // Fallback if no user filter
        //String dateFilter = '1=1';  // Default to no filter
        
        if (!String.isEmpty(startDate)) {
            dateFilter = 'Event_Date__c >= :Date.valueOf(startDate)';
        }
        if (!String.isEmpty(endDate)) {
            dateFilter += ' AND Event_Date__c <= :Date.valueOf(endDate)';
        }
        */

        // Construct dynamic query
        String query = 'SELECT COUNT(Id) countRecord, Event_Date__c, ' +
                       'SUM(Duration__c) sumDuration, AVG(Duration__c) avgDuration ' +
                       'FROM Page_View__c ' +
                       ' GROUP BY Event_Date__c, User__c ' +
                       'ORDER BY Event_Date__c';

        // Execute the query with dynamic bindings for profile and user
        List<AggregateResult> results = Database.query(query);
        system.debug(results);
        // Process the results and map them into a response format
        for (AggregateResult ar : results) {
            Map<String, Object> rowData = new Map<String, Object>();
            rowData.put('eventDate', ar.get('Event_Date__c'));
            rowData.put('countRecord', ar.get('countRecord'));
            rowData.put('sumDuration', ar.get('sumDuration'));
            rowData.put('avgDuration', ar.get('avgDuration'));
            pageViewData.add(rowData);
        }

        return pageViewData;
    }

}