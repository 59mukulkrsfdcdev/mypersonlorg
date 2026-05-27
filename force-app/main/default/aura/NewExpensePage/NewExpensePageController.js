({ 
    show:function (component, event, helper){
    var res=component.get("v.res");
    },

    prev:function (component, event, helper){
    var res=component.get("v.res");
   	var count = parseInt(res);
    count=count-1;
	component.set("v.res",''+count);
    },
    
    handleUploadFinished :function(component, event, helper){
        var fileNames =[];
        var old=component.get("v.fileList");
   		var uploadfile=event.getParam("files");
        uploadfile.forEach(file => fileNames.push({value:file.name}) );
        if(old !=null)
        {
            fileNames = old.concat(fileNames) ;
        }
       // console.log(fileNames);
       
        component.set("v.fileList", fileNames); 
        alert('file Uploaded');
    },
 check : function (component, event, helper) {
      	
		//After
		var itemValue = component.get("v.exp.Expense_Comments__c");
        console.log(itemValue.length);
     
     var cmpTarget = component.find('expExpenseComments');
     	if(itemValue.length>10)
        {
         $A.util.removeClass(cmpTarget, 'slds-input');
        }else
        {
          $A.util.addClass(cmpTarget, 'slds-input');  
        }
	
    },

    createExpense : function(component, event, helper) {
      
        var action = component.get("c.saveExpense");
        action.setParams({"expRec":component.get("v.exp")});
       /* action.setCallback(this, function(data){
            console.log(data.getReturnValue());
        });*/
   
        
       action.setCallback(this, function(response){
           console.log(response.getState());
            if(response.getState()==='SUCCESS'){  
                var recordId = response.getReturnValue();
                console.log(recordId);
                var toastEvent = $A.get("e.force:showToast");
                if(recordId!=null)
                {	 
                    component.set("v.recordId",''+recordId);
                     toastEvent.setParams({
        			"title": "Success!",
       				 "message": "The record has been Saved successfully.Now you can upload the bills ",
                      "duration":' 3000',
                      "type": 'success',
             		  "mode": 'pester'
   					 });
                  	 var res=component.get("v.res");
 				 	 var count = parseInt(res);
   				 	 count=count+1;
					 component.set("v.res",''+count);
                }
                else
                {
                    toastEvent.setParams({
        			"title": "Error!",
       				 "message": "Please Check all  the required detials.",
                      "type": 'error',
             		"mode": 'pester'
                       
   					 });
                }
   				
    			toastEvent.fire();
            }
  
        });
        
        $A.enqueueAction(action);
        
    },
    closePage : function (component, event, helper) {
       
        var navService = component.find("navService");
        
         var pageReference = {
                      "type": "standard__objectPage",
                      "attributes": {
                              "objectApiName": "Expense__c",
                           		 "actionName": "home"
                                       }, 
                       "state": {
                           'message':'This is the target page'
                         }
                        };
       		 //console.log(pageReference);
   			//  navService.navigate(pageReference);
   			 navService.generateUrl(pageReference).then($A.getCallback(function(a) {
                component.set("v.url", a ? a : "#");
            }), $A.getCallback(function(error) {
                component.set("v.url", "#");
            }));
   
        navService.navigate(pageReference, true);
    },
    
    
    
    createRecord : function (component, event, helper) {
        var recid=component.get("v.recordId");
        console.log(recid);
     	 var toastEvent= $A.get("e.force:showToast");
        if(recid!=null)
        { toastEvent.setParams({
        			"title": "Success!",
       				 "message": "Documents Uploaded Successfully ",
                      "duration":' 3000',
                      "type": 'success',
             		  "mode": 'pester'   
   					 });
            toastEvent.fire();
             var navEvt = $A.get("e.force:navigateToSObject");
    			navEvt.setParams({
      			"recordId": recid,
      			"slideDevName": "related"
    			});
    navEvt.fire();
        }else if(recid==null){
          //  console.log("false block");
           
            toastEvent.setParams({
        			"title": "Error!",
       				 "message": "You didn't completed  Expense detials stage.",
                      "type": 'error',
             		"mode": 'pester'   
   					 });
            toastEvent.fire();
        }
   
    }
})