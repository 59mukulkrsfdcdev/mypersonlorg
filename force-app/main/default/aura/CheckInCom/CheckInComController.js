({
    checkinClick : function(component, event, helper) { 
         //var changeType = event.getParams().changeType;

        helper.checkinCheckoutClick(component, event, helper,'checkin');
        debugger;
    },
    checkinChange: function(component, event, helper) {
        var CheckinId = component.get('v.recordId');
        var action=component.get("c.startDay");
        var position = component.get('v.checkin'); 
        action.setParams({
           
            
            
         'latt': ''+position.coords.latitude,
            'lon': ''+position.coords.longitude,
        'assigninId' : CheckinId
        });
        action.setCallback(this,function(response){ 
            if(response.getState()=="SUCCESS"){     
                helper.showToast(component, event, helper,'Checkin Successfully','success');
                $A.get('e.force:refreshView').fire();
                $A.get("e.force:closeQuickAction").fire();
                location.reload();
            }
            if(response.getState()!="SUCCESS"){   
                helper.showToast(component, event, helper,'Something went wrong, please contact admin','Error');
               // helper.showToast(component, event, helper,'If the The Planed date is Future Date then You can not visit...','Error');
                $A.get("e.force:closeQuickAction").fire();      
            }
        });
        $A.enqueueAction(action);
        
        
    }
    
})