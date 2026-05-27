public class infovelocitycontroller_1 {
    
    /****************************************************************
* Class Name   : infovelocitycontroller_1
* Company      : Fingertipplus
* Created Date : 12-03-2025
* @description : This class is responsible for call Info4 Velocity API to send the Booking Data from Salesforce to Info4 Velocity ERP System
and update the Booking Record according to Response.
* @author      : Praveen Kumar
* Used By      : BookingTrigger and SendBookingToERP Aura Component.
* 
* Change Log:
* -----------------------------------------------------------------------------
* Ver | Author         | Date        | Description
* -----------------------------------------------------------------------------
* 1.0 | Praveen Kumar | 18-03-2025  | Initial version
* -----------------------------------------------------------------------------
*************************************************************
global without sharing class infovelocitycontroller_1{
    
    global static List<Apex_Log__c> logList = new List<Apex_Log__c>();
    global static  String errorMessage='';
    
    // Get SecurityToken
    global static string getToken(){
        system.debug('hi');
        Apex_Log__c log = new Apex_Log__c();
        log.Request_Type__c ='get tokenid';
        string endpoint = label.endPoint+'GetSecurityToken?apiUser='+label.apiUser+'&apiKey='+label.apiKey; // be sure this is configured in "Remote Site Settings"
        string apiUser= label.apiUser;
        string apikey = label.apiKey; 
        string method = 'GET';
        String outcomeMsg;
        if (Limits.getCallouts() >= Limits.getLimitCallouts()) {
            outcomeMsg = 'Maximum number of callouts has been reached.';
            log.Status__c = 'FAILED';
            log.Error_Message__c = 'Maximum number of callouts has been reached.';
            // check for credentials error
        } else if (endpoint == null || apiUser == null || apikey == null) {
            outcomeMsg = 'Please verify your API Credentials';
            log.Status__c = 'FAILED';
            log.Error_Message__c = 'Please verify your API Credentials';
            // configure and perform the callout
        } else {
            
            // define transaction variables
            HttpRequest req = new HttpRequest();
            HttpResponse res = new HttpResponse();
            Http h = new Http();
            
            
            
            // Configure the request
            req.setEndpoint(endpoint);
            req.setMethod(method);
            
            // Add authentication parameters to the request body
            //req.setBody('apiUser=' + EncodingUtil.urlEncode(apiUser, 'UTF-8') + '&apiKey=' + EncodingUtil.urlEncode(apiKey, 'UTF-8'));
            
            //req.setTimeout(120000);
            
            // Add basic authentication to header
            // Create payload
            // String payload = 'account_key='+EncodingUtil.urlEncode(account_key,'UTF-8')+'&action=token_create&for_action=lead_submit&apikey='+EncodingUtil.urlEncode(apikey,'UTF-8');
            // log.Request__c =payload;
            // Configure standard headers
            //req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
            
            //system.debug(payload);
            // req.setBody(payload);
            
            // Attempt the callout - create return error on exception
            try {
                
                // Perform callout and set response
                res = h.send(req);
                system.debug('result body '+res.getBody());
                // check response 
                system.debug(res.getStatusCode());
                if ((res.getStatusCode() == 200 || res.getStatusCode() == 201) && res.getBody() != null && res.getBody() != null) {
                    log.status__c='SUCCESS';
                    log.response__c= res.getBody();
                    
                    Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
                    Map<String, Object> m2 = (Map<String, Object>) m.get('Response');
                    infovelocitycontroller_1.Response result = (infovelocitycontroller_1.Response) JSON.deserialize(JSON.serialize(m2),infovelocitycontroller_1.Response.class);
                    system.debug(result);
                    system.debug(result.tokenId);
                    outcomeMsg = result.tokenId;
                } else {
                    // callout failed
                    outcomeMsg = 'Error: Callout failed. Please review the debug log for additional details.';
                    log.status__c='FAILED';
                    log.response__c= 'Status code : '+res.getStatusCode() +' Response body: '+ res.getBody();
                    log.Error_Message__c = 'Status code : '+res.getStatusCode()+ ' Error: Callout failed. Please review the response for additional details.';
                } 
                
            } catch (exception e) {
                // Unexpected exceptions will be caught here, like a deserialization error.
                outcomeMsg = 'Error: An exception has been encountered while calling out to Integration:  ' + e.getMessage();
                log.status__c='FAILED';
                log.Error_Message__c = e.getMessage();
            }
        }       
        logList.add(log);
        // insert logList;
        return outcomeMsg;
    }
    
    global class Response{
        public string tokenId;
        public string status;
        public string message;
    }
    
    @future (callout=true)
    global static void customercreation(string bookingId){
        system.debug('---');
        List<Booking__c> bk = new List<Booking__c>();
        Booking__c bookingrec = [Select id,Title__c,Customer_Name__c,Mobile__c,City1__c,Country__c,State__c,Pincode__c,Country_Code__c,Residential_Status__c,Clouser_Created_Date__c,Booking_Type__c,Unit_Type__c,
                                 Gender__c,Enquiry_Source__c,Sub_Enquiry_Source__c,Lead2__c,OwnerId,Category__c,Followup_Date__c,PAN_Number__c,Street__c,Country1__c,state1__c,Project__c,
                                 City2__c,Pincode1__c,Permanent_Add_Street__c,Permanent_Add_Country__c,Permanent_Add_State__c,Permanent_Add_City__c,Permanent_Add_Pin__c,Occupation__c,Sub_Project__c,
                                 Unit_No__c,Booked_By__c,Booked_At__c,Booking_Date__c,Booking_Through__c,Finance__c,Quote__r.Payment_Plan__r.Name,Booking_Currency__c,
                                 Convertion_Rate__c,Discount_Type__c,Discount__c,Agent_Name__c,Nature_of_Agent__c,Agent_Type__c,Vendor_Type__c,Agent_Pan_No__c,Agent_Address__c,
                                 Agent_Country__c,Agent_State__c,Agent_City__c,Agent_Pin__c,Agent_Phone__c,Brokerage__c,Constitution__c,Area_of_Operation__c,Register_Brokerage_Non_Brokerage__c,
                                 GSTIN__c,RERA_Certificate_No__c,Bank_Name__c,Account_Number__c,IFSC_Swift_Code__c,URL__c,Email__c,Email1__c,Owner.FirstName,Owner.lastName,Lead_Created_Date__c,
                                 Assign_To1__c,Designation__c, Lead2__r.Created_Date__c,Lead2__r.Lead_Type__c,Address_Proof_No__c, Lead2__r.Lead_ID__c, Project1__r.Name,
                                 X4th_Co_Applicant_Relation__c,X4th_Co_Applicant_Mobile__c,X4th_Co_Applicant_Nationality__c,X4th_Co_Applicant_Last_Name__c,X4th_Co_Applicant_Name__c,X4th_Co_Applicant_Title__c,
                                 X3rd_Co_Applicant_Relation__c,X3rd_Co_Applicant_Mobile__c,X3rd_Co_Applicant_Nationality__c,X3rd_Co_Applicant_Last_Name__c,X3rd_Co_Applicant_Name__c,X3rd_Co_Applicant_Title__c,
                                 X2st_Co_Applicant_Relation__c,X2nd_Co_Applicant_Mobile__c,X2st_Co_Applicant_Nationality__c,X2nd_Co_Applicant_Last_Name__c,X2nd_Co_Applicatn_Name__c,X2nd_Co_ApplicantTitle__c,
                                 X1st_Co_Applicant_Relation__c,X1st_Co_Applicant_Title__c,X1st_Co_Applicant_Name__c,X1st_Co_Applicant_Last_Name__c,X1st_Co_Applicant_Nationality__c,X1st_Co_Applicant_Mobile__c  from Booking__c where ID =:bookingId];
        
        
        User owenr = [select id,manager.name,manager.Id from user where id =:bookingrec.OwnerID];
        system.debug('Inside the Customer Creation');
        String SalesManager = 'Admin Admin';
        
        Apex_Log__c log = new Apex_Log__c();
        log.Request_Type__c ='Submit For Customer Creation';
        string accessToken = infovelocitycontroller_1.getToken();
        string endpoint = label.endPoint+'CustomerCreation'; // be sure this is configured in "Remote Site Settings"
        system.debug(endpoint);
        string method = 'POST';
        String outcomeMsg;
        
        if (Limits.getCallouts() >= Limits.getLimitCallouts()) {
            outcomeMsg = 'Maximum number of callouts has been reached.';
            log.Status__c = 'FAILED';
            log.Error_Message__c = 'Maximum number of callouts has been reached.';
            // check for credentials error
        } else if (endpoint == null || accessToken == null) {
            outcomeMsg = 'Please verify your API Credentials';
            log.Status__c = 'FAILED';
            log.Error_Message__c = 'Please verify your API Credentials';
            // configure and perform the callout
        } else {
            
            // define transaction variables
            HttpRequest req = new HttpRequest();
            HttpResponse res = new HttpResponse();
            Http h = new Http();
            
            // Configure the request
            req.setEndpoint(endpoint);
            req.setMethod(method);
            //req.setTimeout(120000);
            
            // Add basic authentication to header
            // Create payload
            
            String oaddprof = (bookingrec.Address_Proof_No__c != null) ? EncodingUtil.urlEncode(bookingrec.Address_Proof_No__c,'UTF-8') : '';
            String ostreet = (bookingrec.Street__c != null) ? EncodingUtil.urlEncode(bookingrec.Street__c,'UTF-8') : '';
            String ocountry = (bookingrec.Country1__c != null) ? EncodingUtil.urlEncode(bookingrec.Country1__c,'UTF-8') : '';
            String ostate = (bookingrec.state1__c != null) ? EncodingUtil.urlEncode(bookingrec.state1__c,'UTF-8') : '';
            String ocity = (bookingrec.City2__c != null) ? EncodingUtil.urlEncode(bookingrec.City2__c,'UTF-8') : '';
            String opincode = (bookingrec.Pincode1__c != null) ? EncodingUtil.urlEncode(bookingrec.Pincode1__c,'UTF-8') : '';
            
            // lastest update for removing mandatory field
            String lateoccupation = (bookingrec.Occupation__c != null) ? EncodingUtil.urlEncode(bookingrec.Occupation__c,'UTF-8') : 'NA';
            String latedesignation = (bookingrec.Designation__c != null) ? EncodingUtil.urlEncode(bookingrec.Designation__c,'UTF-8') : 'NA';
            String latCurrentCity = (bookingrec.City1__c != null) ? EncodingUtil.urlEncode(bookingrec.City1__c,'UTF-8') : '';
            String lateCurrentPinCode = (bookingrec.Pincode__c != null) ? EncodingUtil.urlEncode(bookingrec.Pincode__c,'UTF-8') : '';
            String lateCurrentCountry = (bookingrec.Country__c != null) ? EncodingUtil.urlEncode(bookingrec.Country__c,'UTF-8') : '';
            String lateCurrentState = (bookingrec.State__c != null) ? EncodingUtil.urlEncode(bookingrec.State__c,'UTF-8') : '';
            // email added on 31-12-2024
            String email = (bookingrec.Email1__c != null) ? EncodingUtil.urlEncode(bookingrec.Email1__c,'UTF-8') : '';
            
            
            String payload = 'TokenId='+EncodingUtil.urlEncode(accessToken,'UTF-8')+
                '&Title='+EncodingUtil.urlEncode(bookingrec.Title__c,'UTF-8')+
                '&FirstName='+EncodingUtil.urlEncode(bookingrec.Customer_Name__c,'UTF-8')+
                '&Mobile='+EncodingUtil.urlEncode(bookingrec.Mobile__c,'UTF-8')+
                '&Email='+email+
                '&CurrentResidentialAddress='+EncodingUtil.urlEncode(bookingrec.Permanent_Add_Street__c,'UTF-8')+
                '&CurrentCountry='+lateCurrentCountry+
                '&CurrentCity='+latCurrentCity+
                '&CurrentState='+lateCurrentState+
                '&CurrentPinCode='+lateCurrentPinCode+
                '&CountryCode='+EncodingUtil.urlEncode(bookingrec.Country_Code__c,'UTF-8')+
                '&ResidentialStatus='+EncodingUtil.urlEncode(bookingrec.Residential_Status__c,'UTF-8')+
                '&Gender='+EncodingUtil.urlEncode(bookingrec.Gender__c,'UTF-8')+
                '&EnquirySource='+EncodingUtil.urlEncode(bookingrec.Enquiry_Source__c,'UTF-8')+
                '&SubEnquirySource='+EncodingUtil.urlEncode('','UTF-8')+
                '&SalesManager='+EncodingUtil.urlEncode(SalesManager,'UTF-8')+
                '&LeadCreatedDate='+EncodingUtil.urlEncode(String.valueOf(bookingrec.Lead_Created_Date__c),'UTF-8')+
                '&ClosureCreatedDate='+EncodingUtil.urlEncode(String.valueOf(bookingrec.Clouser_Created_Date__c),'UTF-8')+
                '&Category='+EncodingUtil.urlEncode(bookingrec.Category__c,'UTF-8')+
                '&LeadType='+EncodingUtil.urlEncode('Sales','UTF-8')+
                '&FollowUpDate='+EncodingUtil.urlEncode(String.valueOf(bookingrec.Followup_Date__c),'UTF-8')+
                '&PanCardNo='+EncodingUtil.urlEncode(bookingrec.PAN_Number__c,'UTF-8')+
                '&AddressProofNumber='+oaddprof+
                '&OfficeAddStreet='+ostreet+
                '&OfficeAddCountry='+ocountry+
                '&OfficeAddState='+ostate+
                '&OfficeAddCity='+ocity+
                '&OfficeAddPin='+opincode+
                '&PermanentAddStreet='+EncodingUtil.urlEncode(bookingrec.Permanent_Add_Street__c,'UTF-8')+
                '&PermanentAddCountry='+EncodingUtil.urlEncode(bookingrec.Permanent_Add_Country__c,'UTF-8')+
                '&PermanentAddState='+EncodingUtil.urlEncode(bookingrec.Permanent_Add_State__c,'UTF-8')+
                '&PermanentAddCity='+EncodingUtil.urlEncode(bookingrec.Permanent_Add_City__c,'UTF-8')+
                '&PermanentAddPin='+EncodingUtil.urlEncode(bookingrec.Permanent_Add_Pin__c,'UTF-8')+
                '&Occupation='+lateoccupation+
                '&leadId='+EncodingUtil.urlEncode(bookingrec.Lead2__r.Lead_ID__c.replace('Ld-',''),'UTF-8')+
                '&leadRemarks='+EncodingUtil.urlEncode('Test','UTF-8')+
                '&Designation='+latedesignation;
            log.Request__c =payload;
            
            bk.add(bookingrec);
            // Configure standard headers
            req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
            
            system.debug(payload);
            req.setBody(payload);
            
            // Attempt the callout - create return error on exception
            try {
                
                // Perform callout and set response
                res = h.send(req);
                system.debug('result body '+res.getBody());
                // check response 
                system.debug(res.getStatusCode());
                if ((res.getStatusCode() == 200 || res.getStatusCode() == 201) && res.getBody() != null && res.getBody() != null) {
                    log.status__c='SUCCESS';
                    log.response__c= res.getBody();
                    List<Object> responseList = (List<Object>) JSON.deserializeUntyped(res.getBody());
                    for (Object responseObj : responseList) {
                        Map<String, Object> responseMap = (Map<String, Object>) responseObj;
                        
                        if (responseMap.containsKey('status') && responseMap.get('status') == 'Failed') {
                            if (responseMap.containsKey('message')) {
                                Object msgObj = responseMap.get('message');
                                
                                // Handle message as a **list or string**
                                if (msgObj instanceof List<Object>) {
                                    for (Object msgItem : (List<Object>) msgObj) {
                                        errorMessage += String.valueOf(msgItem) + '; ';
                                    }
                                } else if (msgObj instanceof String) {
                                    errorMessage += String.valueOf(msgObj) + '; ';
                                }
                            }
                        }
                    }
                    // leadQualificationResponse result = (leadQualificationResponse) JSON.deserialize(res.getBody(),leadQualificationResponse.class);
                    //  system.debug(result);
                    if(bk.size()>0){
                        system.debug('---');
                        mapbookingtoWrapper(bk);
                    }
                } else {
                    // callout failed
                    outcomeMsg = 'Error: Callout failed. Please review the debug log for additional details.';
                    log.status__c='FAILED';
                    log.response__c= 'Status code : '+res.getStatusCode() +' Response body: '+ res.getBody();
                    log.Error_Message__c = 'Status code : '+res.getStatusCode()+ ' Error: Callout failed. Please review the response for additional details.';
                } 
                
            } catch (exception e) {
                // Unexpected exceptions will be caught here, like a deserialization error.
                outcomeMsg = 'Error: An exception has been encountered while calling out to Integration:  ' + e.getMessage();
                log.status__c='FAILED';
                log.Error_Message__c = e.getMessage();
            }
        }       
        logList.add(log);
        upsert logList;
        
        
    }
    //it will call from Trigger
    public static void mapbookingtoWrapper(List<Booking__c> booking){
        
        string accessToken = getToken();
        system.debug(booking);
        List<infovelocitycontroller_1.ApiRequestWrapper> outReqList = new List<infovelocitycontroller_1.ApiRequestWrapper>();
        
        for(Booking__c bk : booking){
            infovelocitycontroller_1.ApiRequestWrapper mapwrp = new infovelocitycontroller_1.ApiRequestWrapper();
            mapwrp.TokenId=accessToken;
            mapwrp.CustomerName= bk.Customer_Name__c;
            mapwrp.MobileNo= bk.Mobile__c;
            mapwrp.BookingType= bk.Booking_Type__c;
            mapwrp.Project= bk.Project1__r.Name;
            mapwrp.SubProject= bk.Sub_Project__c;
            mapwrp.UnitType= bk.Unit_Type__c;
            mapwrp.UnitNo= bk.Unit_No__c;
            mapwrp.AssignTo= bk.Assign_To1__c;
            mapwrp.BookedBy= bk.Owner.FirstName+' '+bk.Owner.lastName;
            mapwrp.BookedAt= bk.Booked_At__c;
            mapwrp.BookingDate= bk.Booking_Date__c;
            mapwrp.BookingThrough= bk.Booking_Through__c;
            mapwrp.FinanceType= bk.Finance__c;
            mapwrp.PaymentPlan= bk.Quote__r.Payment_Plan__r.Name;
            mapwrp.BookingCurrency= bk.Booking_Currency__c;
            mapwrp.ConversionRate= bk.Convertion_Rate__c;
            mapwrp.DiscountType= bk.Discount_Type__c;
            mapwrp.DiscountAmt= bk.Discount__c;
            mapwrp.AgentName= bk.Agent_Name__c;
            mapwrp.NatureOfAgent= bk.Nature_of_Agent__c;
            mapwrp.AgentType= bk.Agent_Type__c;
            mapwrp.VendorType= bk.Vendor_Type__c;
            mapwrp.AgentPanNo= bk.Agent_Pan_No__c;
            mapwrp.AgentAddr= bk.Agent_Address__c;
            mapwrp.AgentCountry= bk.Agent_Country__c;
            mapwrp.AgentState= bk.Agent_State__c;
            mapwrp.AgentCity= bk.Agent_City__c;
            mapwrp.AgentPin= bk.Agent_Pin__c;
            mapwrp.AgentPhone= bk.Agent_Phone__c;
            mapwrp.BrokeragePerc= bk.Brokerage__c;
            mapwrp.Constitution= bk.Constitution__c;
            mapwrp.AreaOfOperation= bk.Area_of_Operation__c;
            mapwrp.RegisteredBrokerageNonBrokerage= bk.Register_Brokerage_Non_Brokerage__c;
            mapwrp.GSTIN= bk.GSTIN__c;
            mapwrp.RERACertificateNo= bk.RERA_Certificate_No__c;
            mapwrp.BankName= bk.Bank_Name__c;
            mapwrp.AccountNo= bk.Account_Number__c;
            mapwrp.IFSCSwiftCode= bk.IFSC_Swift_Code__c;
            mapwrp.Mobile= bk.Mobile__c;
            mapwrp.EmailId= bk.Email__c;
            mapwrp.URL= bk.URL__c;
            
            mapwrp.CoAppTitle1=bk.X1st_Co_Applicant_Title__c;
            mapwrp.CoAppFirstName1=bk.X1st_Co_Applicant_Name__c;
            mapwrp.CoAppLastName1=bk.X1st_Co_Applicant_Last_Name__c;
            mapwrp.CoAppCountry1=bk.X1st_Co_Applicant_Nationality__c;
            mapwrp.CoAppMobile1=bk.X1st_Co_Applicant_Mobile__c;
            mapwrp.CoAppRelation1=bk.X1st_Co_Applicant_Relation__c;
            
            mapwrp.CoAppTitle2=bk.X2nd_Co_ApplicantTitle__c;
            mapwrp.CoAppFirstName2=bk.X2nd_Co_Applicatn_Name__c;
            mapwrp.CoAppLastName2=bk.X2nd_Co_Applicant_Last_Name__c;
            mapwrp.CoAppCountry2=bk.X2st_Co_Applicant_Nationality__c;
            mapwrp.CoAppMobile2=bk.X2nd_Co_Applicant_Mobile__c;
            mapwrp.CoAppRelation2=bk.X2st_Co_Applicant_Relation__c;
            
            mapwrp.CoAppTitle3=bk.X3rd_Co_Applicant_Title__c;
            mapwrp.CoAppFirstName3=bk.X3rd_Co_Applicant_Name__c;
            mapwrp.CoAppLastName3=bk.X3rd_Co_Applicant_Last_Name__c;
            mapwrp.CoAppCountry3=bk.X3rd_Co_Applicant_Nationality__c;
            mapwrp.CoAppMobile3=bk.X3rd_Co_Applicant_Mobile__c;
            mapwrp.CoAppRelation3=bk.X3rd_Co_Applicant_Relation__c;
            
            mapwrp.CoAppTitle4=bk.X4th_Co_Applicant_Title__c;
            mapwrp.CoAppFirstName4=bk.X4th_Co_Applicant_Name__c;
            mapwrp.CoAppLastName4=bk.X4th_Co_Applicant_Last_Name__c;
            mapwrp.CoAppCountry4=bk.X4th_Co_Applicant_Nationality__c;
            mapwrp.CoAppMobile4=bk.X4th_Co_Applicant_Mobile__c;
            mapwrp.CoAppRelation4=bk.X4th_Co_Applicant_Relation__c;
            
            
            // List<Co_Applicant__c> capp =[select id,Name,Title__c,First_Name__c,Last_Name__c,Nationality__c,Mobile__c,Relation__c from Co_Applicant__c where Booking__c =:bk.id ];
            
            List<Charge_Type__c> ctp = [select id,Name,Amount_Type__c,Charge_Amount__c,Charge_Type__c,Chargetype_Id__c,No_of_Item__c,Rate_or_Fixed_Amount__c,Unit__c,Quote__c,Booking__c from Charge_Type__c where Booking__c=:bk.Id ];
            system.debug(ctp);
            List<ChargeDetail> Cd = new List<ChargeDetail>();
            List<PassiveCharge> pc = new List<PassiveCharge>();
            // List<PLCDetail> PD = new List<PLCDetail>();
            //  List<CarParkDetail> CPD = new List<CarParkDetail>();
            for(Charge_Type__c ct : ctp){
                if(ct.Charge_Type__c=='Charge Detail'){
                    ChargeDetail cd1 = new ChargeDetail();
                    cd1.id=ct.Chargetype_Id__c;
                    cd1.ChargeName=ct.Name;
                    cd1.AmountType=ct.Amount_Type__c;
                    cd1.RateorFixedAmount=ct.Rate_or_Fixed_Amount__c;
                    cd1.ChargeAmount=ct.Charge_Amount__c;
                    Cd.add(cd1);
                }
                else if(ct.Charge_Type__c=='Passive Charge'){
                    PassiveCharge psv = new PassiveCharge();
                    psv.id= ct.Chargetype_Id__c;
                    psv.ChargeName= ct.Name;
                    psv.RateorFixedAmount= ct.Rate_or_Fixed_Amount__c;
                    pc.add(psv);
                    
                }
            }
            
            mapwrp.ChargeDetails= cd;
            mapwrp.PassiveCharges= pc;
            //  mapwrp.PLCDetails= PD;
            //mapwrp.CarParkDetails= CPD;
            
            outReqList.add(mapwrp);
            string s1 = JSON.serialize(mapwrp);
            string requestBody= s1.replaceAll('null', '""');
            
            system.debug(requestBody);
            
            infovelocitycontroller_1.createdbooking(requestBody,bk.id);
        }
    }
    global class ApiRequestWrapper {
        public String TokenId;
        public String CustomerName;
        public String MobileNo;
        public String BookingType;
        public String Project;
        public String SubProject;
        public String UnitType;
        public String UnitNo;
        public String AssignTo;
        public String BookedBy;
        public String BookedAt;
        public Date BookingDate;
        public String BookingThrough;
        public String FinanceType;
        public String PaymentPlan;
        public String BookingCurrency;
        public String ConversionRate;
        public String DiscountType;
        public Decimal DiscountAmt;
        public String AgentName;
        public String NatureOfAgent;
        public String AgentType;
        public String VendorType;
        public String AgentPanNo;
        public String AgentAddr;
        public String AgentCountry;
        public String AgentState;
        public String AgentCity;
        public String AgentPin;
        public String AgentPhone;
        public String BrokeragePerc;
        public String Constitution;
        public String AreaOfOperation;
        public String RegisteredBrokerageNonBrokerage;
        public String GSTIN;
        public String RERACertificateNo;
        public String BankName;
        public String AccountNo;
        public String IFSCSwiftCode;
        public String Mobile;
        public String EmailId;
        public String URL;
        public String CoAppTitle1;
        public String CoAppFirstName1;
        public String CoAppLastName1;
        public String CoAppCountry1;
        public String CoAppMobile1;
        public String CoAppRelation1;
        public String CoAppTitle2;
        public String CoAppFirstName2;
        public String CoAppLastName2;
        public String CoAppCountry2;
        public String CoAppMobile2;
        public String CoAppRelation2;
        public String CoAppTitle3;
        public String CoAppFirstName3;
        public String CoAppLastName3;
        public String CoAppCountry3;
        public String CoAppMobile3;
        public String CoAppRelation3;
        public String CoAppTitle4;
        public String CoAppFirstName4;
        public String CoAppLastName4;
        public String CoAppCountry4;
        public String CoAppMobile4;
        public String CoAppRelation4;
        public List<ChargeDetail> ChargeDetails; 
        public List<PassiveCharge> PassiveCharges;
        // public List<PLCDetail> PLCDetails;
        //public List<CarParkDetail> CarParkDetails;
        
    }
    public class ChargeDetail {
        public string Id;
        public String ChargeName;
        public string AmountType;
        public Decimal RateorFixedAmount;
        public Decimal ChargeAmount;
    }
    public class PassiveCharge {
        public string Id;
        public String ChargeName;
        public Decimal RateorFixedAmount;
    }
  
    
    // @future (callout=true)
    global static void createdbooking(string requestBody,String BookingID){
        system.debug('Inside the createdbooking'+requestBody+BookingID);
        List<Apex_Log__c> logList = new List<Apex_Log__c>();
        Apex_Log__c log = new Apex_Log__c();
        log.Request_Type__c ='Create Booking';
        log.Request__c =requestBody;
        //log.send_notification__c = TRUE;
        string endpoint = label.endPoint+'BookingCreationWithChargeDetails'; // be sure this is configured in "Remote Site Settings"
        string apiUser= label.apiUser;
        string apikey = label.apiKey; 
        string method = 'POST';
        String outcomeMsg;
        
        if (Limits.getCallouts() >= Limits.getLimitCallouts()) {
            outcomeMsg = 'Maximum number of callouts has been reached.';
            log.Status__c = 'FAILED';
            log.Error_Message__c = 'Maximum number of callouts has been reached.';
            // check for credentials error
        } else if (endpoint == null || apikey == null || apiUser == null) {
            outcomeMsg = 'Please verify your API Credentials';
            log.Status__c = 'FAILED';
            log.Error_Message__c = 'Please verify your API Credentials';
            // configure and perform the callout
        } else {
            
            // define transaction variables
            HttpRequest req = new HttpRequest();
            HttpResponse res = new HttpResponse();
            Http h = new Http();
            
            // Configure the request
            req.setEndpoint(endpoint);
            req.setMethod(method);
            //req.setTimeout(120000);
            
            
            // Configure standard headers
            // This tells the API that we are sending and receiving the data as a JSON object 
            req.setHeader('Content-Type', 'application/json');
            
            system.debug(requestBody);
            req.setBody(requestBody);
            
            // Attempt the callout - create return error on exception
            try {
                
                // Perform callout and set response
                res = h.send(req);
                system.debug('result body '+res.getBody());
                // check response 
                if ((res.getStatusCode() == 200 || res.getStatusCode() == 201) && res.getBody() != null && res.getBody() != null) {
                    log.status__c='SUCCESS';
                    if(res.getBody().length()<100000){
                        log.response__c= res.getBody();
                    } 
                    // Parse JSON response
                    List<Object> responseList = (List<Object>)JSON.deserializeUntyped(res.getBody());
                    
                    String currentuser = UserInfo.getUserId();
                    if (responseList != null && responseList.size() > 0) {
                        Map<String, Object> responseObject = (Map<String, Object>)responseList[0];
                        
                        String status = (String)responseObject.get('status');
                        
                        if (status != null && status.equalsIgnoreCase('success')) {
                            List<Object> messageList = (List<Object>)responseObject.get('message');
                            
                            if (messageList != null && messageList.size() > 0) {
                                Map<String, Object> messageObject = (Map<String, Object>)messageList[0];
                                
                                String infobookingId = (String)messageObject.get('BookingId');
                                
                                if (infobookingId != null) {
                                    Booking__c bk = new Booking__c();
                                    bk.Id = BookingID;
                                    bk.Info_Velocity_Id__c = infobookingId;
                                    
                                    bk.Response__c='Booking Created in ERP Successfully and Info Velocity Id is : '+ infobookingId;
                                    bk.API_Status__c='Success';
                                    bk.Not_Sync__c = false;
                                    bk.Error_Message__c='';
                                    
                                    Update bk;
                                    errorMessage='Booking Created in ERP Successfully and Info Velocity Id is : '+ infobookingId;
                                    
                                    sendCustomNotification(currentuser, BookingID, errorMessage);
                                }
                                system.debug('====');
                            }
                        } else {
                            // Handle failure status
                            // errorMessage = String.valueof(responseObject.get('message'));
                            errorMessage += String.valueof(responseObject.get('message')) + '; ';
                            
                            // String errorMessage = (String)responseObject.get('message');
                            system.debug(errorMessage);
                            
                            Booking__c bk = new Booking__c();
                            bk.Id = BookingID;
                            bk.Not_Sync__c = true;
                            bk.Error_Message__c=errorMessage;
                            bk.API_Status__c='FAILED';
                            Update bk;
                            sendCustomNotification(currentuser, BookingID, errorMessage);
                            log.status__c='FAILED';
                            log.response__c= 'Status code : '+res.getStatusCode() +' Response body: '+ res.getBody();
                            log.Error_Message__c = errorMessage;
                            
                        }
                    }
                    
                } else {
                    // callout failed
                    outcomeMsg = 'Error: Callout failed. Please review the debug log for additional details.';
                    log.status__c='FAILED';
                    log.response__c= 'Status code : '+res.getStatusCode() +' Response body: '+ res.getBody();
                    log.Error_Message__c = 'Status code : '+res.getStatusCode()+ ' Error: Callout failed. Please review the response for additional details.';
                } 
                
            } catch (exception e) {
                // Unexpected exceptions will be caught here, like a deserialization error.
                outcomeMsg = 'Error: An exception has been encountered while calling out to Integration:  ' + e.getMessage();
                log.status__c='FAILED';
                log.Error_Message__c = e.getMessage();
            }
        }       
        logList.add(log);
        insert logList;     
    }
    
    public static void sendCustomNotification(String userId, String bkid, String message) {
        try {
            // Get Custom Notification Type ID
            CustomNotificationType notificationType = [SELECT Id FROM CustomNotificationType WHERE DeveloperName = 'BookingFailure' LIMIT 1];
            Set<String> recipientsIds = new Set<String>();
            recipientsIds.add(userId);
            // Create notification
            Messaging.CustomNotification notification = new Messaging.CustomNotification();
            notification.setTitle('Booking Notification');
            notification.setBody(message);
            notification.setSenderId(UserInfo.getUserId());
            notification.setTargetId(bkid); // Send notification to the User
            notification.setNotificationTypeId(notificationType.Id);
            notification.send(recipientsIds);
            
            System.debug('Custom Notification sent to user: ' + userId);
        } catch (Exception e) {
            System.debug('Error sending custom notification: ' + e.getMessage());
        }
    }
    @AuraEnabled
    public static string callCustomercreation(string recId){
        if (String.isBlank(recId)) {
            throw new AuraHandledException('Record Id cannot be null or empty');
        }
        else{
            customercreation(recId);
            return 'API Called';
        }
    }
}
*/
}