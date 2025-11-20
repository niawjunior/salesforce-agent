({
    doInit : function(component, event, helper) {
        // Call Apex method to get picklist values
        var action = component.get("c.getColorPicklistValues");

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.picklistOptions", response.getReturnValue());
            } else if (state === "ERROR") {
                console.error("Error fetching color picklist values:", response.getError());
            }
        });

        $A.enqueueAction(action);
    },

    selectColor : function(component, event, helper) {
        // Get the color from the button's data attribute
        var button = event.currentTarget;
        var color = button.getAttribute("data-color");
        component.set("v.selectedColor", color);
    }
})