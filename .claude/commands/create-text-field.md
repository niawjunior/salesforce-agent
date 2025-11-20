# Create Custom Field for Salesforce Lead Object

## Overview
This instruction defines the process for creating a new custom field for the Lead object in Salesforce using the standard metadata format.

## Requirements
1. Create a new custom field for the Lead object
2. Place the field file in the correct directory structure
3. Follow Salesforce standard metadata XML format
4. Apply specific formatting rules
5. New field must be added to the package.xml

## File Structure
- **Location**: `force-app/main/default/objects/Lead/fields/`
- **File Naming Convention**: `{FieldName}__c.field-meta.xml`
- **Full Field Name Format**: `{FieldName}__c`

## XML Template and Rules
Use the following XML structure as a base:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>{FieldName}__c</fullName>
    <externalId>false</externalId>
    <label>{FieldName}</label>
    <length>50</length>
    <required>true</required>
    <trackFeedHistory>false</trackFeedHistory>
    <type>Text</type>
    <unique>false</unique>
</CustomField>
```

## Specific Requirements
1. **Field Name**: Replace `{FieldName}` with the actual field name (e.g., `TestField`)
2. **Length**: Always set to `50` (as per requirement)
3. **Required**: Always set to `true` (as per requirement)
4. **Type**: Default to `Text` unless specified otherwise
5. **Label**: Should match the field name without the `__c` suffix

## Example Implementation
For a field named "TestField", the resulting file should be:
- **File Path**: `force-app/main/default/objects/Lead/fields/TestField__c.field-meta.xml`
- **Content**:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>TestField__c</fullName>
    <externalId>false</externalId>
    <label>TestField</label>
    <length>50</length>
    <required>true</required>
    <trackFeedHistory>false</trackFeedHistory>
    <type>Text</type>
    <unique>false</unique>
</CustomField>
```

## Best Practices
1. Always validate the field name follows Salesforce naming conventions
2. Ensure the field name ends with `__c` suffix
3. Maintain consistency with existing field files in the Lead object
4. The field label should be human-readable and descriptive
5. All new fields must be added to the package.xml for deployment

## Deployment Instructions
After updating the manifest/package.xml file, deploy the changes using the following command:

```bash
sf project deploy start --manifest /Users/niawjunior/Desktop/salesforce-app/innovation-lab/manifest/package.xml
```

This command will deploy all components listed in the manifest file to your target org.

## Step-by-Step Deployment Process
1. **Update the manifest file**: Ensure your `manifest/package.xml` includes all the new components you want to deploy
2. **Validate the manifest**: Check that all components are correctly listed with proper names and types
3. **Run the deployment command**: Execute the following command in your terminal:
   ```bash
   sf project deploy start --manifest /Users/niawjunior/Desktop/salesforce-app/innovation-lab/manifest/package.xml
   ```
4. **Monitor the deployment**: Watch for any errors or warnings in the terminal output
5. **Verify deployment success**: Confirm that all components were deployed successfully in your target org
