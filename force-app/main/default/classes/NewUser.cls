public class NewUser {
    public static void newUser(){
        
    
        Profile p = [select id from Profile where name='Chater free User' LIMIT 1];
      
        User u = new User(alias = 'Praveen', 
                          email='praveenkr810@gmail.com',
                          emailencodingkey='UTF-8', 
                          firstName='Praveen', 
                          lastname='Kumar', 
                          languagelocalekey='en_US',
                          localesidkey='en_US', 
                          profileid = p.id,
                          timezonesidkey='Europe/London', 
                          username='praveenkr@gmail.com');
        
        insert u;
        system.debug('User Created');
        
    }
}