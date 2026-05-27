({
    checkinCheckoutClick : function(component, event, helper, type) {
        if (navigator.geolocation) {     
            debugger;
            var opts= {}
            opts.enableHighAccuracy = false;
            opts.timeout = 3000;
            opts.maximumAge = 0;
            navigator.geolocation.getCurrentPosition(function(positionIn){
                component.set('v.checkin',positionIn);
            });           
            
        }else {
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "title": "Error!",
                "message": "Geo Location is not supported"
            });
            toastEvent.fire();                              
            
        } 
        
    },
    showToast : function(component, event, helper,message,type) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "",
            "message": message,
            "type": type
        });
        toastEvent.fire();
        //location.reload();
    }
     
})