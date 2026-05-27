({
	handleBlur: function (cmp, event) {
    var validity = cmp.find("myinput").get("v.validity");
    console.log(validity.valid); //returns true
},
     onClick: function (cmp, evt, helper) {
        var allValid = cmp.find('field').reduce(function (validSoFar, inputCmp) {
            inputCmp.reportValidity();
            return validSoFar && inputCmp.checkValidity();
        }, true);
        if (allValid) {
            alert('All form entries look valid. Ready to submit!');
        } else {
            alert('Please update the invalid form entries and try again.');
        }
    },
    register : function(component, event) {
        var inputCmp = component.find("inputCmp");
        var value = inputCmp.get("v.value");
        // is input valid text?
        if (value === "John Doe") {
            inputCmp.setCustomValidity("John Doe is already registered");
        } else {
            inputCmp.setCustomValidity(""); // if there was a custom error before, reset it
        }
        inputCmp.reportValidity(); // Tells lightning:input to show the error right away without needing interaction
    },
     submitForm: function (cmp, event, helper) {
              var options = cmp.find("colors");
              var result = [];
              for (var i=0; i<options.length; i++) {
                  if (options[i].get("v.checked")) {
                      result.push(options[i].get('v.value'));
                  }
              }
              cmp.set('v.selection', result.join(', '));
          },
})