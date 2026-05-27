public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static  List<Contact> getContact (Id accountId){
        try{
            if(String.isEmpty(accountId)){
                throw new AuraHandledException('Invalid Account Id');
            }
            return [select id,Name,Phone, Email from Contact where AccountId =: accountId];
        }
        catch(Exception E){
            throw new AuraHandledException('Error in Fetching ' + E.getMessage());
        }
    }

    @AuraEnabled
    public static Contact addContact(){
        Contact con = new Contact(FirstName ='Praveen', LastName ='Test', Email='test@gmail.com ');
        insert con;
        return con;
    }
    
    @AuraEnabled
    public static void deleteContact( Id contactId ){
       delete [select id from Contact where Id =: contactId];

    }

    
}