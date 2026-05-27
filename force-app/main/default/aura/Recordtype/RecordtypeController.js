({doInit : function(component,event,helper){
        helper.getRecordTypes(component,event,helper);        
    },
    optionSelected : function(component,event,helper){
        component.set("v.loading",true);
        var recordName = event.target.getAttribute("value");
        var recordTypes = component.get("v.availableRecordTypes");
        for(var i=0;i<recordTypes.length;i++){
            if(recordName==recordTypes[i].value){   
                component.set("v.recordTypeId",recordTypes[i].key);
                break;
            }
        }
    }
})