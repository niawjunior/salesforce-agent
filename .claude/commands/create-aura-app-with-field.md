# Create Aura Application with Field Display

## Quick Reference - Placeholder Replacements
Before using this template, identify your values:
- **AppName**: Your application name (e.g., `LeadStatusDisplay`, `AccountTypeDisplay`)
- **FieldName**: Your field name exactly as in Salesforce (e.g., `Status`, `Type`, `Color__c`)
- **FieldNameLower**: Field name in lowercase (e.g., `status`, `type`, `color`)
- **FieldLabel**: User-friendly field label (e.g., `Status`, `Type`, `Color`)
- **ObjectName**: Object name (e.g., `Lead`, `Account`, `Opportunity`)

## Overview
This instruction defines the process for creating a new Aura application in Salesforce that displays a specified picklist field from any object.

## Requirements
1. Create a new Aura application using Salesforce CLI
2. Configure the application to display a specified field from any object
3. Implement proper Aura component structure with markup, controller, and helper
4. Follow Salesforce best practices for Aura development
5. Only focus on Picklist, No Extra logic for simpler implementations

## Prerequisites
1. Salesforce CLI installed and configured
2. Project properly authenticated with a Dev Hub
3. Object with the specified field already created

## Command Syntax
```bash
sf lightning generate app --name {AppName} --output-dir force-app/main/default/aura
```

## Step-by-Step Process

### Step 1: Generate the Aura Application
Run the following command to create the basic Aura application structure:
```bash
sf lightning generate app --name {AppName} --output-dir force-app/main/default/aura
```

This will create the following files:
- `{AppName}/{AppName}.app-meta.xml`
- `{AppName}/{AppName}.app`
- `{AppName}/{AppName}.auradoc`
- `{AppName}/{AppName}Controller.js`
- `{AppName}/{AppName}.css`
- `{AppName}/{AppName}Helper.js`
- `{AppName}/{AppName}Renderer.js`
- `{AppName}/{AppName}.svg`

### Step 2: Configure the Application Markup ({AppName}.app)

Replace all placeholders with your specific values:
- `{AppName}` → Your application name (e.g., `StatusPicklistDisplay`)
- `{FieldName}` → Your field name (e.g., `Status`, `Priority`, `Color__c`)
- `{FieldNameLower}` → Field name in lowercase (e.g., `status`, `priority`, `color`)
- `{FieldLabel}` → User-friendly field label (e.g., `Status`, `Priority`, `Color`)
- `{ObjectName}` → Object name (e.g., `Lead`, `Account`, `Opportunity`)

```xml
<aura:application extends="force:slds" controller="{AppName}Controller">
    <aura:attribute name="{fieldNameLower}Options" type="String[]" />
    <aura:attribute name="selected{FieldName}" type="String" />
    <aura:attribute name="errorMessage" type="String" />
    <aura:attribute name="infoMessage" type="String" />

    <!-- Initialize the component -->
    <aura:handler name="init" value="{!this}" action="{!c.doInit}"/>

    <div class="slds-box slds-theme_default">
        <h2 class="slds-text-heading_small slds-m-bottom_medium">{FieldLabel} Selector</h2>

        <!-- Info Message Display -->
        <div aura:if="{!v.infoMessage}" class="slds-notify slds-notify_alert slds-theme_alert-texture slds-m-bottom_medium" role="alert">
            <span class="slds-assistive-text">info</span>
            <span class="slds-icon_container slds-m-right_x-small">
                <lightning:icon iconName="utility:info" size="x-small" alternativeText="info"/>
            </span>
            {!v.infoMessage}
        </div>

        <!-- Error Message Display -->
        <div aura:if="{!v.errorMessage}" class="slds-notify slds-notify_alert slds-theme_alert-texture slds-theme_warning slds-m-bottom_medium" role="alert">
            <span class="slds-assistive-text">error</span>
            <span class="slds-icon_container slds-m-right_x-small">
                <lightning:icon iconName="utility:error" size="x-small" alternativeText="error"/>
            </span>
            {!v.errorMessage}
        </div>

        <!-- {FieldLabel} Selection Section -->
        <div class="slds-section slds-is-open">
            <h3 class="slds-section__title slds-theme_shade">
                <span class="slds-truncate slds-p-horizontal_small" title="Select {FieldLabel}">Select {FieldLabel}</span>
            </h3>
            <div class="slds-section__content">
                <div aura:if="{!v.{fieldNameLower}Options.length > 0}">
                    <div class="{fieldNameLower}-picker">
                        <aura:iteration items="{!v.{fieldNameLower}Options}" var="{fieldNameLower}">
                            <button class="{!'slds-button slds-button_neutral {fieldNameLower}-btn ' + (v.selected{FieldName} == {fieldNameLower} ? 'selected' : '')}"
                                    onclick="{!c.select{FieldName}}"
                                    data-{fieldNameLower}="{!{fieldNameLower}}">
                                {!{fieldNameLower}}
                            </button>
                        </aura:iteration>
                    </div>

                    <!-- Selected {FieldLabel} Display -->
                    <div aura:if="{!v.selected{FieldName}}" class="slds-m-top_medium">
                        <p class="slds-text-heading_small">Selected: {!v.selected{FieldName}}</p>
                    </div>
                </div>
                
                <!-- No options available message -->
                <div aura:if="{!v.{fieldNameLower}Options.length == 0}" class="slds-text-body_regular slds-text-color_weak">
                    No options are available. This could mean:
                    <ul class="slds-list_dotted">
                        <li>The {FieldName} field doesn't exist on the {ObjectName} object</li>
                        <li>You don't have permission to access this field</li>
                        <li>The field is not a picklist type</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</aura:application>
```

### Step 3: Update the Controller ({AppName}Controller.js)

Replace all placeholders with your specific values:
- `{FieldName}` → Your field name (e.g., `Status`, `Priority`, `Color__c`)
- `{FieldNameWithoutCustom}` → Field name without `__c` for custom fields (e.g., `Status`, `Priority`, `Color`)
- `{FieldNameLower}` → Field name in lowercase (e.g., `status`, `priority`, `color`)
- `{FieldLabel}` → User-friendly field label (e.g., `Status`, `Priority`, `Color`)

**IMPORTANT**: For custom fields ending with `__c`, use `{FieldNameWithoutCustom}` in the Apex method call and JavaScript function names (remove the `__c` suffix).

```javascript
({
    doInit : function(component, event, helper) {
        // Call Apex method to get {FieldLabel} picklist values
        var action = component.get("c.get{FieldNameWithoutCustom}PicklistValues");

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.{fieldNameLower}Options", response.getReturnValue());
                component.set("v.infoMessage", "Successfully loaded {FieldLabel} options.");
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors && errors[0] && errors[0].message) {
                    console.error("Error:", errors[0].message);
                    component.set("v.errorMessage", errors[0].message);
                } else {
                    console.error("Error fetching {FieldLabel} picklist values:", errors);
                    component.set("v.errorMessage", "Unknown error occurred while fetching options.");
                }
            }
        });

        $A.enqueueAction(action);
    },

    select{FieldNameWithoutCustom} : function(component, event, helper) {
        // Get the {fieldNameLower} from the button's data attribute
        var button = event.currentTarget;
        var {fieldNameLower} = button.getAttribute("data-{fieldNameLower}");
        component.set("v.selected{FieldName}", {fieldNameLower});
    }
})
```

### Step 4: Update the Helper ({AppName}Helper.js)
Add the following JavaScript to the helper file:

```javascript
({
    // Helper methods can be added here for more complex logic
    // For simple implementations, this file can remain minimal
})
```

### Step 5: Update the CSS ({AppName}.css)
Add the following CSS for styling:

```css
.THIS .container {
    padding: 1rem;
}

.THIS .field-display {
    margin: 1rem 0;
    padding: 1rem;
    border: 1px solid #e1e8f0;
    border-radius: 4px;
}
```

### Step 6: Create an Apex Controller (Required for Functionality)
Create an Apex class to fetch picklist values:

1. Create file: `force-app/main/default/classes/{AppName}Controller.cls`
2. Content:

Replace all placeholders with your specific values:
- `{AppName}` → Your application name (e.g., `StatusPicklistDisplay`)
- `{FieldName}` → Your field name (e.g., `Status`, `Priority`, `Color__c`)
- `{FieldNameWithoutCustom}` → Field name without `__c` for custom fields (e.g., `Status`, `Priority`, `Color`)
- `{FieldLabel}` → User-friendly field label (e.g., `Status`, `Priority`, `Color`)
- `{ObjectName}` → Object name (e.g., `Lead`, `Account`, `Opportunity`)

**IMPORTANT**: For custom fields ending with `__c`, use `{FieldNameWithoutCustom}` in the Apex method name (remove the `__c` suffix).

```apex
public with sharing class {AppName}Controller {

    @AuraEnabled
    public static List<String> get{FieldNameWithoutCustom}PicklistValues() {
        try {
            // Get the {ObjectName}.{FieldName} field describe result
            Schema.DescribeFieldResult fieldResult = {ObjectName}.{FieldName}.getDescribe();
            List<Schema.PicklistEntry> picklistValues = fieldResult.getPicklistValues();
            List<String> options = new List<String>();

            for (Schema.PicklistEntry entry : picklistValues) {
                if (entry.isActive()) {
                    options.add(entry.getValue());
                }
            }

            return options;
        } catch (Exception e) {
            throw new AuraHandledException('Error fetching {FieldLabel} picklist values: ' + e.getMessage());
        }
    }
}
```

3. Create the metadata file: `force-app/main/default/classes/{AppName}Controller.cls-meta.xml`
4. Content:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<ApexClass xmlns="http://soap.sforce.com/2006/04/metadata">
    <apiVersion>58.0</apiVersion>
    <status>Active</status>
</ApexClass>
```

### Step 7: Update the Application Metadata ({AppName}.app-meta.xml)
Ensure the metadata file contains:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<AuraDefinitionBundle xmlns="http://soap.sforce.com/2006/04/metadata">
    <apiVersion>58.0</apiVersion>
    <description>A Lightning Application that displays a field from any object</description>
</AuraDefinitionBundle>
```

## Usage Example

### Example 1: Create a Lead Status Picklist Display App
```bash
sf lightning generate app --name LeadStatusDisplay --output-dir force-app/main/default/aura
```

**Replace placeholders:**
- `{AppName}` → `LeadStatusDisplay`
- `{FieldName}` → `Status`
- `{FieldNameLower}` → `status`
- `{FieldLabel}` → `Status`
- `{ObjectName}` → `Lead`

### Example 2: Create an Account Type Picklist Display App
```bash
sf lightning generate app --name AccountTypeDisplay --output-dir force-app/main/default/aura
```

**Replace placeholders:**
- `{AppName}` → `AccountTypeDisplay`
- `{FieldName}` → `Type`
- `{FieldNameLower}` → `type`
- `{FieldLabel}` → `Type`
- `{ObjectName}` → `Account`

### Example 3: Create a Lead Color Custom Field Picklist Display App
```bash
sf lightning generate app --name LeadColorDisplay --output-dir force-app/main/default/aura
```

**Replace placeholders:**
- `{AppName}` → `LeadColorDisplay`
- `{FieldName}` → `Color__c`
- `{FieldNameWithoutCustom}` → `Color` (remove `__c` for method names)
- `{FieldNameLower}` → `color`
- `{FieldLabel}` → `Color`
- `{ObjectName}` → `Lead`

**Special Note for Custom Fields**: For custom fields ending with `__c`, the Apex method name and JavaScript function names should use `{FieldNameWithoutCustom}` (without the `__c` suffix), but the field reference in Apex should still use the full `{FieldName}` with `__c`.

### Complete Implementation Steps
1. Edit `force-app/main/default/aura/{AppName}/{AppName}.app` with the updated markup from Step 2 (replace all placeholders)
2. Edit `force-app/main/default/aura/{AppName}/{AppName}Controller.js` with the updated JavaScript from Step 3 (replace all placeholders)
3. Create the Apex controller `force-app/main/default/classes/{AppName}Controller.cls` with the content from Step 6 (replace all placeholders)
4. Create the metadata file `force-app/main/default/classes/{AppName}Controller.cls-meta.xml` with the content from Step 6
5. Deploy the application:
```bash
sf project deploy start --manifest /Users/niawjunior/Desktop/salesforce-app/innovation-lab/manifest/package.xml
```

### How to Use the Component
To use this component in a page or console:
1. **In a Lightning Page**: Drag and drop the `{AppName}` component onto a Lightning page
2. **In Developer Console**:
   - Go to Setup → Lightning Components
   - Click "Preview" for the `{AppName}` component

### Important Notes
- This documentation provides a generic template that can be adapted for ANY picklist field
- Replace ALL placeholders with your specific values before implementation
- The field reference in the Apex class should be updated to match your specific object and field (e.g., `Lead.Color__c`, `Account.Type`, `Opportunity.Status`)
- **CRITICAL**: The `.app` file MUST include the `controller` attribute in the `<aura:application>` tag to connect to the Apex controller
- **CRITICAL**: Attribute names in the markup must match exactly with those used in the JavaScript controller (e.g., `v.statusOptions` in markup must match `component.set("v.statusOptions", ...)` in controller)

## Troubleshooting
If you only see the heading and no other content:
1. **Check that the Apex controller method is properly implemented** - The method name in the JavaScript controller must exactly match the method name in the Apex class
2. **Verify the controller reference** - Ensure the `.app` file includes `controller="{AppName}Controller"` in the `<aura:application>` tag
3. **Check attribute name consistency** - Ensure attribute names used in the component markup match exactly with those referenced in the controller
4. **Check browser console for JavaScript errors**
5. **Ensure the component has proper permissions to access the object and field**
6. **Make sure the component is properly deployed to your org**

### Common Error: "Unable to find action 'methodName' on the controller"
This error occurs when:
1. The `.app` file doesn't include the `controller` attribute
2. The Apex method name doesn't match what's being called in JavaScript
3. The Apex class isn't properly deployed or has compilation errors

### Special Issue: Custom Field Names with __c Suffix
**Problem**: Apex method names cannot contain double underscores (`__c`), which causes deployment failures.

**Solution**:
- For custom fields like `Color__c`, use `{FieldNameWithoutCustom}` placeholder in Apex method names
- Apex method: `getColorPicklistValues()` (NOT `getColor__cPicklistValues()`)
- JavaScript call: `component.get("c.getColorPicklistValues")` (NOT `c.getColor__cPicklistValues()`)
- JavaScript function: `selectColor()` (NOT `selectColor__c()`)
- Field reference in Apex: Still use full field name `Lead.Color__c.getDescribe()`

**Example for Color__c field:**
- `{FieldName}` → `Color__c`
- `{FieldNameWithoutCustom}` → `Color` (used in method names)
- `{FieldNameLower}` → `color` (used in attribute names)

## Best Practices
1. Always validate that the field exists on the object before referencing it
2. Use proper error handling in controllers
3. Implement proper styling using SLDS (Salesforce Lightning Design System)
4. Follow Aura component naming conventions
5. Make sure to include the required field in the SOQL query
6. Test the component in a sandbox or developer org first
7. Consider using Lightning Data Service for better performance
8. **Avoid inline styles in Aura components** to prevent syntax errors. Instead, use CSS classes with dynamic class names when needed (e.g., `<div class="{!'my-class color-' + v.colorValue}">`) to apply dynamic styling.

   For dynamic colors or backgrounds, create CSS classes in the component's CSS file and use dynamic class binding:

   ```
   <!-- Instead of using inline styles -->
   <div class="color-indicator" style="{!'background-color: ' + v.selectedColor + ';'}"></div>
   
   <!-- Use CSS classes with dynamic class binding -->
   <div class="color-indicator {!'bg-' + v.selectedColor}"></div>
   ```

9. **Avoid JavaScript method calls in Aura expressions** like `toLowerCase()`, `toUpperCase()`, etc. These are not supported in Aura expressions. Instead, transform strings in the controller or helper and bind the transformed values to component attributes.
10. **Always include metadata files for Apex classes** - Every Apex class must have a corresponding `.cls-meta.xml` file in the same directory with proper XML structure to prevent "File not found" errors during deployment.
11. **Use `event.currentTarget` instead of `event.getSource()`** when handling events on buttons or other elements in Aura components. The `getSource()` method isn't available on button elements in the same way it is on other components. When using `onclick` handlers on buttons, always use `event.currentTarget.getAttribute("data-color")` to access the clicked element's attributes.
12. **Remove unnecessary attributes and logic** - For simpler implementations, remove all object-specific attributes and logic to reduce complexity and potential errors.
13. **Follow separation of concerns** - For more complex components, consider separating data operations into helper methods. This improves reusability and makes code easier to maintain. The typical pattern is:
    - Controller: Handles UI logic and component interactions
    - Helper: Contains reusable business logic and data operations  
    - Apex: Handles data access and server-side operations
14. **Simplified approach for basic components** - For very simple components like this one, it's acceptable for the controller to directly call Apex methods. This reduces complexity and is perfectly valid for straightforward use cases.
15. **Proper conditional rendering syntax** - In Aura components, use `aura:otherwise` instead of `aura:set attribute="else"` for conditional content. This is critical for proper rendering of alternate content when conditions change.

## Common Issues and Solutions
1. **Field Not Found Error**: Ensure the field exists on the object and the name is spelled correctly
2. **Component Not Loading**: Check that the component is properly referenced in a page or console
3. **Missing Permissions**: Ensure the user has access to the object and the specific field
4. **JavaScript Method in Expressions Error**: Avoid using JavaScript methods like `toLowerCase()` in Aura expressions. Instead, handle string transformations in the controller or helper and bind the processed values to attributes.
5. **Missing Metadata File Error**: Ensure that every Apex class has a corresponding `.cls-meta.xml` metadata file in the same directory with proper XML structure.
6. **Event Handling Error**: When using `onclick` on buttons in Aura components, use `event.currentTarget` to access the clicked element instead of `event.getSource()`. The `getSource()` method isn't available on button elements in the same way it is on other components.
7. **Init Attribute Error**: Avoid using `init="{!c.doInit}"` in the application markup if you're experiencing issues. Instead, use `init="{!c.doInit}"` but ensure the controller method is properly implemented.
8. **Component Structure Issues**: For simpler implementations, remove all object-specific attributes and logic to reduce complexity and potential errors.
9. **Attribute Name Mismatch Error**: Ensure that attribute names used in the component markup match exactly with those referenced in the controller and helper. For example, if the markup uses `v.picklistOptions`, make sure the controller sets `v.picklistOptions` and not `v.colorOptions` or any other variation. This is critical for proper data binding and component functionality.
10. **Missing Controller Reference Error**: The `.app` file MUST include `controller="{AppName}Controller"` in the `<aura:application>` tag. Without this, the JavaScript controller cannot find the Apex methods.

## Testing and Validation
Before deployment, it's important to validate your Aura application:

### Syntax Checking
1. **Check Aura component syntax**:
   ```bash
   sf lightning component validate --name {AppName}
   ```

### Unit Testing (if applicable)
1. **Run JavaScript tests** (if you have Jasmine or other testing frameworks set up):
   ```bash
   sf lightning test run
   ```

2. **Run Apex tests** for any Apex controllers:
   ```bash
   sf apex run test --class {AppName}Controller
   ```

### Local Testing
1. **Test in Developer Console**:
   - Open Salesforce Developer Console
   - Navigate to "Debug" → "Open Developer Console"
   - Create a new Lightning Component tab
   - Add your component to a page to test functionality

2. **Use Salesforce Setup**:
   - Go to Setup → Lightning Components
   - Find your component and click "Preview"

## Deployment Instructions
After creating and configuring your Aura application:

1. **Update the manifest file**: Ensure your `manifest/package.xml` includes all the new components
2. **Validate the manifest**: Check that all components are correctly listed with proper names and types
3. **Run the deployment command**:
   ```bash
   sf project deploy start --manifest /Users/niawjunior/Desktop/salesforce-app/innovation-lab/manifest/package.xml
   ```
4. **Monitor the deployment**: Watch for any errors or warnings in the terminal output
5. **Verify deployment success**: Confirm that all components were deployed successfully in your target org

## Important Note
When implementing this component in a real scenario, ensure that the Apex controller properly fetches data from Salesforce rather than using mock data. The example provided uses mock data for demonstration purposes only, but in production, the controller should retrieve actual records from the database using SOQL queries.

## Simplified Implementation Guidance
For a simpler implementation that avoids object-specific complexities:
1. Remove all object-specific attributes from the application markup
2. Remove all object-specific logic from the controller and helper
3. Focus only on fetching and displaying picklist values
4. Ensure the Apex controller only handles picklist values
5. Make sure all component files are properly structured with correct metadata

## Best Practices for Testing
1. Always test components in a sandbox environment first
2. Validate all field references exist on the object
3. Test with different data scenarios
4. Ensure proper error handling for missing data
5. Check component performance and responsiveness
