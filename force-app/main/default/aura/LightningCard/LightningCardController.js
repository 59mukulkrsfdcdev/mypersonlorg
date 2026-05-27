({
	findAccount : function(component, event, helper) {
        
        var action = component.get("c.fetchaccount");
        alert('Hi')
        action.setParams({
            searchkeyword:component.get("v.searchkeyWord")
        });
        
        action.setCallback(this,function(response){
            var state = response.getState();
            var resp =response.getReturnValue();
            
            if(state==="SUCCESS"){
                
                component.set("v.accountlist",resp );
             
            }
        });
        $A.enqueueAction(action);
       
		
	}
})