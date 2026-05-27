({
	doClick : function(component, event, helper) {
        alert(component.isValid());
        alert(component.getName());
        alert(component.get('v.Whom'));
        // 2 parameter
        // Key- Attribute
        // value- That we wanted to set in the attribute 
        // 
        var agecomp = component.find('testInput');
        alert(agecomp.get('v.value'));
        agecomp.set('v.value', 65);
        
        component.set('v.Whom', 'Test Value');
		
	}
})