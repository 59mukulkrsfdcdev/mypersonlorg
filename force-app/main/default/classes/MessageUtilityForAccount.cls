public class MessageUtilityForAccount 
{
    
    public static void SendBatchProcessNotification(AsyncApexJob jobDetails, decimal totalrevenue, string JobName)
    {
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        
        string[] toadress = new string[]{ jobdetails.createdby.email, '59mukulkr@gmail.com'};
            email.setToAddresses(toadress);
        string emailsubj = 'Batch job: '+ jobName+' - '+ jobdetails.id +  'Status Notification';
        	email.setSubject(emailsubj);
        
        string emailcontent = 'Please find the below process status for the batch job: ' + jobName +' <br/>'+
            				'<br/> Batch Job id is ...'+ jobdetails.id+
            				'<br/> job status .... '+ jobdetails.status+
            				'<br/> Total Batch Processed .... '+ jobdetails.jobItemsProcessed+
            				'<br/> Total Number of Batches ..... '+ jobdetails.totalJobItems+
            				'<br/> Number of batvhes failed ..... '+ jobdetails.NumberofErrors;
        
        if(totalrevenue > 0.0)
        {
            emailContent += '<br/> Total Annual Revenue is..... : '+ totalrevenue;
        }
        email.setHtmlBody(emailcontent);
        email.setReplyTo('support@dell.com');
        email.setSenderDisplayName('Contact Batch Processing status notification');
        
        Messaging.sendEmail(new Messaging.singleEmailMessage[]{email});
		}

}