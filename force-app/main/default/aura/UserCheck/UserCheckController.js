({
   /* doInit : function(c, e, h){

  },
    activeButton : function(c, e, h){
        let inputText = c.find("inpsummary").get("v.value");
        if(inputText != null){
            c.set('v.isButtonActive',false);
        }       
    },*/
    doInit : function(component,event,helper){
    
           
     //   helper.changebooleanvaluetrue(component, event, helper);
        component.set('v.checkboxcondition',false);
        	
        	//component.get("v.isButtonActive",true);
    },
    enable : function(component,event,helper){
        	component.set('v.checkboxcondition',false);
       // System.debug("----------------------------->"+'v.checkboxcondition')
        //helper.changebooleanvaluetrue(component, event, helper);
        $A.get("e.force:closeQuickAction").fire();
        	component.set('v.isenableButtonActive',false);
        	component.set("v.issisableButtonActive",true);
        component.set("{!v.checktrueorfalse}",false);
       $A.get("e.force:closeQuickAction").fire();
        $A.get('e.force:refreshView').fire();
        //location.reload();
    },
    Disable : function(component,event,helper){
        	component.set('v.checkboxcondition',true);
       	//System.debug("----------------------------->"+'v.checkboxcondition')
        	//helper.changebooleanvaluefalse(component, event, helper);
        $A.get("e.force:closeQuickAction").fire();
        	component.set("v.isenableButtonActive",false);
        	component.set("v.issisableButtonActive",true);
        component.set("{!v.checktrueorfalse}",true);
        $A.get("e.force:closeQuickAction").fire();
       //$A.get('e.force:refreshView').fire();
       //location.reload();
    },
    onClickCheckBox : function(component,event,helper){
        
    }
    
})