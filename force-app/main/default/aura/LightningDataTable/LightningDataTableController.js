({
	doinit : function(component, event, helper) {
        
        component.set("v.mycolumdata",[
            {label:'Account Name',fieldName:'Name', type:'text'},
            {label:'Phone',fieldName:'Phone', type:'text'},
            {label:'Industry',fieldName:'Industry', type:'text'},
        ]);
            var action = component.get("c.fetchAccount");
            action.setCallback(this,function(response){
            var state = response.getState();
            if(state==="SUCCESS"){
            component.set("v.mydata",response.getReturnValue());
            var scrollTop = event.target.scrollTop
        var scrollHeight = event.target.scrollHeight
        var clientHeight = event.target.clientHeight
        
        var count = component.get("v.count")
        var allAccounts = component.get("v.mydata")
        var allAccountsLoaded = component.get("v.allAccountsLoaded")
        
        var dataToShow = component.get("v.dataToShow")

        
        if(((scrollHeight - clientHeight) <= (scrollTop + 1)) && !allAccountsLoaded){
            alert('HI')
            var nextSetOfData = allAccounts.splice(count , 1)
            dataToShow.push(nextSetOfData)
            component.set("v.dataToShow", dataToShow)
            
            
            if(dataToShow.length === allAccounts.length){
                allAccountsLoaded = true;
                component.set("v.allAccountsLoaded", allAccountsLoaded)
            }
        }
            }
            });
            $A.enqueueAction(action);
		
	},
          
})