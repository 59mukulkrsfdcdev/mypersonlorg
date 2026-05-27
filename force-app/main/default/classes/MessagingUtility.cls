public class MessagingUtility 
{
	public static void SendEmailToCandidate(Candidate__c cnd, string emailsubject)
    {
        if(cnd != null)
        {
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            
            string[] toaddress = new string[]{cnd.Email_Id__c, '59mukulkr@gmail.com'};
                
            email.setToAddresses(toaddress);
            
            string[] ccaddress = new string[]{cnd.Email_Id__c, 'praveenkr810@gmail.com'};
                //email.setCcAddresses(ccaddress);
            string[] bccaddress = new string[]{cnd.Email_Id__c, 'support@gmail.com'};
              //  email.setBccAddresses(bccaddress);
            
            email.setReplyTo('praveenkr810@gmail.com');
            email.setSenderDisplayName('Accenture recruitment team');
            
            email.setSubject(emailsubject);
            
            string emailbody ='Dear ' + cnd.Name + ', Thanks for showing the interest in our organization open position.'+
                				'Your cnadidature has been submitted successfully for the position. '+ cnd.Position_Name__c +
                				'Once or our HR will get back to you, once your profile get shortlisted';
           // email.setPlainTextBody(emailbody);    
            string htmlemailbody = 'Dear ' + cnd.Name + ', <br/><br/>'+
                					'Thanks for showing interest in our organization position. <br/><br/>'+
                					'We are please to inform you, that your candidature has been submitted sucessfully. <br/>'+
                					'Please have a look into you details ....<br/><br/>'+
                					'Candidate ID: '+ cnd.Candidate_ID_c__c+
                					'<br/>Candidate Name: '+ cnd.Name+
            						'<br/>Location: '+ cnd.Location__c+
            						'<br/>Email ID : '+ cnd.Email_Id__c+
            						'<br/>Candidature Status : ' + cnd.Candidature_Status__c+
            						'<br/>Current Ctc: '+ cnd.Current_CTC__c+
                					'<br/>Expected ctc: '+ cnd.Expected_CTC__c+
                					'<br/>Notice Period: '+ cnd.Notice_Period__c+
                					'<br/>Technical Skills: '+ cnd.Technical_Skills__c+
                					'<br/><br/> Thanks & Regards, <br/>'+
                					'Talent Aquisition Team, <br/> Accenture Inc';
            
            email.setHtmlBody(htmlemailbody);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});
            						                                        
            
		}
    }
    public static void SendEmailToCandidate(List<Candidate__c> lstcnd, string emailsubject)
    {
        if(!lstcnd.isEmpty())
        {
            list<Messaging.SingleEmailMessage> emailNotification = new  list<Messaging.SingleEmailMessage>();
             
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            for(Candidate__c cnd :  lstcnd)
            {
                       
            string[] toaddress = new string[]{cnd.Email_Id__c, '59mukulkr@gmail.com'};
                
            email.setToAddresses(toaddress);
            
            string[] ccaddress = new string[]{cnd.Email_Id__c, 'praveenkr810@gmail.com'};
                //email.setCcAddresses(ccaddress);
            string[] bccaddress = new string[]{cnd.Email_Id__c, 'support@gmail.com'};
              //  email.setBccAddresses(bccaddress);
            
            email.setReplyTo('praveenkr810@gmail.com');
            email.setSenderDisplayName('Accenture recruitment team');
            
            email.setSubject(emailsubject);
            
            string emailbody ='Dear ' + cnd.Name + ', Thanks for showing the interest in our organization open position.'+
                				'Your cnadidature has been submitted successfully for the position. '+ cnd.Position_Name__c +
                				'Once or our HR will get back to you, once your profile get shortlisted';
           // email.setPlainTextBody(emailbody);
            
            string htmlemailbody = 'Dear ' + cnd.Name + ', <br/><br/>'+
                					'Thanks for showing interest in our organization position. <br/><br/>'+
                					'We are please to inform you, that your candidature has been submitted sucessfully. <br/>'+
                					'Please have a look into you details ....<br/><br/>'+
                					'Candidate ID: '+ cnd.Candidate_ID_c__c+
                					'<br/>Candidate Name: '+ cnd.Name+
            						'<br/>Location: '+ cnd.Location__c+
            						'<br/>Email ID : '+ cnd.Email_Id__c+
            						'<br/>Candidature Status : ' + cnd.Candidature_Status__c+
            						'<br/>Current Ctc: '+ cnd.Current_CTC__c+
                					'<br/>Expected ctc: '+ cnd.Expected_CTC__c+
                					'<br/>Notice Period: '+ cnd.Notice_Period__c+
                					'<br/>Technical Skills: '+ cnd.Technical_Skills__c+
                					'<br/><br/> Please click on this link to view the record. <a.href= '+ system.Url.getSalesforceBaseUrl().ToExternalform()+ '/'+ cnd.Id+ '> click Here to view the records</a> <br/><br/>'+
                					'<br/><br/> Thanks & Regards, <br/>'+
                					'Talent Aquisition Team, <br/> Accenture Inc';
            
            email.setHtmlBody(htmlemailbody);
                emailNotification.add(email);
                
            } 			
            if(! emailNotification.isEmpty())
            {
                Messaging.SendEmailResult[] res =  Messaging.sendEmail(emailNotification, false);
            }
            
		}
}
    
    public static void SendNotificationToContactForPanDetails()
    {
        // Get the contact records, to send the notification
        
        Map<id, Contact> mapcontoSend =new Map<id, Contact>([select id, firstname, email, pan_number__c from Contact
                                                         where pan_number__c = null and email != null]);
    if(!mapcontoSend.isempty())
    {
        // Create the object of massemailmessage class..
        
        Messaging.MassEmailMessage massEmail = new Messaging.MassEmailMessage();
        list<ID> contacid = new list<id>();
        
        contacid.addall(mapcontoSend.keyset());
        // supply the list of contact id's..
        massemail.setTargetObjectIds(contacid);
        
        emailtemplate temp = [select id, name from emailtemplate where name = 'PAN Number Notification Template' limit 1];
        
        if(temp != null)
        {
            massemail.setTemplateId(temp.Id);
            
            messaging.sendEmail(new messaging.MassEmailMessage[]{massemail});
        }
   
	}
    }
    
    public static void SendBatchProcessNotification(AsyncApexJob jobDetails)
    {
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        
        string[] toadress = new string[]{ jobdetails.createdby.email, '59mukulkr@gmail.com'};
            email.setToAddresses(toadress);
        string emailsubj = 'Batch job: UpdateContactBatch - '+ jobdetails.id + 'Status Notification';
        	email.setSubject(emailsubj);
        
        string emailcontent = 'Please find the below process status for the batch job: updatecontactsBatch. <br/>'+
            				'<br/> Batch Job id is ...'+ jobdetails.id+
            				'<br/> job status .... '+ jobdetails.status+
            				'<br/> Total Batch Processed .... '+ jobdetails.jobItemsProcessed+
            				'<br/> Total Number of Batches ..... '+ jobdetails.totalJobItems+
            				'<br/> Number of batvhes failed ..... '+ jobdetails.NumberofErrors;
        
        email.setHtmlBody(emailcontent);
        email.setReplyTo('support@dell.com');
        email.setSenderDisplayName('Contact Batch Processing status notification');
        
        Messaging.sendEmail(new Messaging.singleEmailMessage[]{email});
		}
}