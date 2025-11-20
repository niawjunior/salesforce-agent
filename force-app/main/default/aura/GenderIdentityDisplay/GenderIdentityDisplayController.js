({
    doInit : function(component, event, helper) {
        // Call Apex method to get Color picklist values as a test
        var action = component.get("c.getColorPicklistValues");

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.genderOptions", response.getReturnValue());
                component.set("v.infoMessage", "Showing Color field options as a demo since GenderIdentity field may not be available.");
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors && errors[0] && errors[0].message) {
                    console.error("Error:", errors[0].message);
                    component.set("v.errorMessage", errors[0].message);
                } else {
                    console.error("Error fetching picklist values:", errors);
                    component.set("v.errorMessage", "Unknown error occurred while fetching options.");
                }
            }
        });

        $A.enqueueAction(action);
    },

    selectGender : function(component, event, helper) {
        // Get the gender from the button's data attribute
        var button = event.currentTarget;
        var gender = button.getAttribute("data-gender");
        component.set("v.selectedGender", gender);
    }
})