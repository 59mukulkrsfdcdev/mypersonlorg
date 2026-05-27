({
	doInit : function(component, event, helper) {
        /*Step 1*/
        var action = component.get('c.getContactList');
        /* Step 2 optional */
       
        /*Step 4*/
        action.setCallback(this, function(response){
               var responseValue = response.getReturnValue();
        		console.log('responseValue',responseValue);
        		component.set('v.contactList', responseValue);
        
                           });
        $A.enqueueAction(action,false);
		
	}
})