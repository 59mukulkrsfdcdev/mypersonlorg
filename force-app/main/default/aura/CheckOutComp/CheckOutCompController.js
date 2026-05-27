({
    checkoutClick : function(component, event, helper) { 
         

        helper.checkinCheckoutClick(component, event, helper,'checkout');
        debugger;
    },
    checkoutChange: function(component, event, helper) {
        var CheckoutId = component.get('v.recordId');
        var action=component.get("c.endDay");
        var position = component.get('v.checkout'); 
        action.setParams({
            'latt': ''+position.coords.latitude,
            'lon': ''+position.coords.longitude,
            'assignoutId' : CheckoutId
        });
        action.setCallback(this,function(response){ 
            if(response.getState()=="SUCCESS"){     
                helper.showToast(component, event, helper,'Checkout Successfully','success');
                $A.get('e.force:refreshView').fire();
                $A.get("e.force:closeQuickAction").fire();
                location.reload();
            }
            if(response.getState()!="SUCCESS"){   
                helper.showToast(component, event, helper,'Distance is more than 100m','Error');
               
                $A.get("e.force:closeQuickAction").fire();      
            }
        });
        $A.enqueueAction(action);
        
        
    }
    
})