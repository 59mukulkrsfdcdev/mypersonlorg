public class EmailProgram {
    public static void email(){
        
Messaging.reserveSingleEmailCapacity(5);

Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
String[] toAddresses = new String[] {'praveenkr810@gmail.com','cavinash504@gmail.com','59mukulkr@gmail.com'}; 

  
mail.setToAddresses(toAddresses);


mail.setReplyTo('59mukulkr@gmail.com');

mail.setSenderDisplayName('Praveen Kumar');

mail.setSubject('New Email for Checking');


mail.setUseSignature(false);

mail.setPlainTextBody('Hello This is Praveen. I hope you are doing good');

Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        System.debug('Email Sent');
    }

}