public with sharing class ApiAuthService {
    private static final String BASE_URL = 'https://api.escuelajs.co/api/v1';
    private static final Integer TIMEOUT_MS = 12000; // 12 seconds timeout

    @AuraEnabled
    public static AuthResponse login(String email, String password) {
        // Validate inputs
        if (String.isBlank(email) || String.isBlank(password)) {
            throw new AuthException('Email and password are required');
        }
        
        HttpRequest request = createRequest(
            BASE_URL + '/auth/login',
            'POST',
            new Map<String, String>{
                'email' => email,
                'password' => password
            }
        );
        
        return (AuthResponse) handleResponse(request, AuthResponse.class);
    }

    @AuraEnabled(cacheable=true)
    public static List<User> getAllUsers() {
        HttpRequest request = createRequest(
            BASE_URL + '/users',
            'GET',
            null
        );
        return (List<User>) handleResponse(request, List<User>.class);
    }

    @AuraEnabled(cacheable=true)
    public static List<Category> fetchAllCategories() {
        HttpRequest request = createRequest(
            BASE_URL + '/categories',
            'GET',
            null
        );
        return (List<Category>) handleResponse(request, List<Category>.class);
    }

    @AuraEnabled(cacheable=true)
    public static List<Product> getAllProducts() {
        HttpRequest request = createRequest(
            BASE_URL + '/products',
            'GET',
            null
        );
        return (List<Product>) handleResponse(request, List<Product>.class);
    }

    // ========== PRIVATE HELPER METHODS ==========
    
    private static HttpRequest createRequest(String endpoint, String method, Map<String, Object> body) {
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod(method);
        request.setHeader('Content-Type', 'application/json');
        request.setTimeout(TIMEOUT_MS);
        
        if (body != null) {
            request.setBody(JSON.serialize(body));
        }
        return request;
    }
    
    private static Object handleResponse(HttpRequest request, Type resultType) {
        Http http = new Http();
        HttpResponse response;
        
        try {
            response = http.send(request);
            System.debug('API Response: ' + response.getBody());
            
            if (response.getStatusCode() == 200 || response.getStatusCode() == 201) {
                return JSON.deserialize(response.getBody(), resultType);
            } else {
                throw new AuthException(parseErrorMessage(response));
            }
        } catch (Exception e) {
            System.debug('Exception: ' + e.getMessage() + ' | ' + e.getStackTraceString());
            throw new AuthException('Request failed: ' + e.getMessage());
        }
    }
    
    private static String parseErrorMessage(HttpResponse response) {
        try {
            Map<String, Object> errorResponse = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            
            if (errorResponse.containsKey('message')) {
                return (String) errorResponse.get('message');
            }
            if (errorResponse.containsKey('error')) {
                return (String) errorResponse.get('error');
            }
        } catch (Exception e) {
            System.debug('Error parsing error response: ' + e.getMessage());
        }
        return 'Status: ' + response.getStatusCode() + ' | Body: ' + response.getBody().abbreviate(255);
    }

    // ========== WRAPPER CLASSES ==========
    
    public class AuthResponse {
        @AuraEnabled public String access_token;
        @AuraEnabled public String refresh_token;
    }
    
    public class User {
        @AuraEnabled public Integer id;
        @AuraEnabled public String email;
        @AuraEnabled public String name;
        @AuraEnabled public String role;
        @AuraEnabled public String avatar;
        // Note: Removed password field for security
    }
    
    public class Category {
        @AuraEnabled public Integer id;
        @AuraEnabled public String name;
        @AuraEnabled public String slug;
        @AuraEnabled public String image;
    }
    
    public class Product {
        @AuraEnabled public Integer id;
        @AuraEnabled public String title;
        @AuraEnabled public String slug;
        @AuraEnabled public Decimal price;
        @AuraEnabled public String description;
        @AuraEnabled public Category category; // Nested category object
        @AuraEnabled public List<String> images; // List of image URLs
    }
    
    public class AuthException extends Exception {}
}