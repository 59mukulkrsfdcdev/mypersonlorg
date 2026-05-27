public with sharing class ApiDataService {
    
    // Method to get all users
    @AuraEnabled
    public static List<User> getAllUsers() {
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.escuelajs.co/api/v1/users');
        request.setMethod('GET');
        request.setTimeout(12000); // 12 seconds timeout
        
        Http http = new Http();
        HttpResponse response = http.send(request);
        
        if (response.getStatusCode() == 200) {
            // Parse the response according to the exact API format
            return (List<User>) JSON.deserialize(response.getBody(), List<User>.class);
        } else {
            String errorMessage = 'Failed to fetch users. Status: ' + response.getStatusCode();
            try {
                Map<String, Object> errorResponse = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                if (errorResponse.containsKey('message')) {
                    errorMessage = (String) errorResponse.get('message');
                }
            } catch (Exception e) {
                System.debug('Error parsing error response: ' + e.getMessage());
            }
            throw new ApiException(errorMessage);
        }
    }
    
    // User wrapper class matching the API response structure exactly
    public class User {
        @AuraEnabled public Integer id;
        @AuraEnabled public String email;
        @AuraEnabled public String password; // Note: In real apps, be careful with exposing passwords
        @AuraEnabled public String name;
        @AuraEnabled public String role;
        @AuraEnabled public String avatar;
    }
    
     @AuraEnabled(cacheable=true)
    public static List<Category> fetchAllCategories() {
        // Create HTTP request
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.escuelajs.co/api/v1/categories');
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        request.setTimeout(12000); // 12 second timeout
        
        try {
            // Send request
            HttpResponse response = new Http().send(request);
            
            // Check response status code
            if (response.getStatusCode() == 200) {
                // Deserialize the JSON response into Category objects
                List<Category> categories = (List<Category>)JSON.deserialize(
                    response.getBody(), 
                    List<Category>.class
                );
                return categories;
            } else {
                // Handle API errors
                String errorMessage = 'Failed to fetch categories. Status: ' + response.getStatusCode();
                try {
                    // Try to parse error message from response
                    Map<String, Object> errorResponse = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
                    if (errorResponse.containsKey('message')) {
                        errorMessage = (String)errorResponse.get('message');
                    }
                } catch (Exception e) {
                    System.debug('Error parsing error response: ' + e.getMessage());
                }
                throw new ApiException(errorMessage);
            }
        } catch (Exception e) {
            // Handle exceptions
            System.debug('Exception while fetching categories: ' + e.getMessage());
            throw new ApiException('Failed to fetch categories: ' + e.getMessage());
        }
    }
    
    // Wrapper class matching the API response structure
    public class Category {
        @AuraEnabled public Integer id;
        @AuraEnabled public String name;
        @AuraEnabled public String slug;
        @AuraEnabled public String image;
    }
    
    public class ApiException extends Exception {}
}