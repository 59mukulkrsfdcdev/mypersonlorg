public class ContactListController {
    @AuraEnabled
    public static List<Contact> getContactList(){
        list<Contact> ContactList= [select id, firstName, lastName, email, phone from Contact where email != null];
        return ContactList;
    }

}