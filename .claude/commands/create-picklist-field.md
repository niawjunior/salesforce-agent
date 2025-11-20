# Create Picklist Field for Salesforce Objects

## Overview
This instruction defines the process for creating a new picklist (dropdown) field for any Salesforce object (Lead, Account, Opportunity, etc.) using the standard metadata format.

## Requirements
1. Create a new picklist field for the specified object
2. Place the field file in the correct directory structure
3. Follow Salesforce standard metadata XML format for picklist fields
4. Apply specific formatting rules
5. New field must be added to the package.xml

## File Structure
- **Location**: `force-app/main/default/objects/{ObjectName}/fields/`
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
    <required>{Required}</required>
    <trackFeedHistory>false</trackFeedHistory>
    <type>Picklist</type>
    <valueSet>
        <restricted>true</restricted>
        <valueSetDefinition>
            <sorted>false</sorted>
            <value>
                <fullName>{Value1}</fullName>
                <default>false</default>
                <label>{Value1}</label>
            </value>
            <value>
                <fullName>{Value2}</fullName>
                <default>false</default>
                <label>{Value2}</label>
            </value>
        </valueSetDefinition>
    </valueSet>
</CustomField>
```

## Specific Requirements
1. **Field Name**: Replace `{FieldName}` with the actual field name (e.g., `Status`)
2. **Object Name**: Replace `{ObjectName}` with the target object (e.g., `Lead`, `Account`, `Opportunity`)
3. **Field Label**: Should match the field name without the `__c` suffix
4. **Required**: Set to `true` or `false` based on your requirements
5. **Type**: Must be `Picklist`
6. **Value Set**: Must include at least one picklist value
7. **Value Structure**: Each value must have:
   - `fullName`: The internal value name
   - `default`: Set to `false` for all values (only one can be `true`)
   - `label`: The display label for the value

## Example Implementation
For a field named "Status" with values "New", "Contacted", and "Converted" on the Lead object, the resulting file should be:
- **File Path**: `force-app/main/default/objects/Lead/fields/Status__c.field-meta.xml`
- **Content**:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Status__c</fullName>
    <externalId>false</externalId>
    <label>Status</label>
    <required>false</required>
    <trackFeedHistory>false</trackFeedHistory>
    <type>Picklist</type>
    <valueSet>
        <restricted>true</restricted>
        <valueSetDefinition>
            <sorted>false</sorted>
            <value>
                <fullName>New</fullName>
                <default>false</default>
                <label>New</label>
            </value>
            <value>
                <fullName>Contacted</fullName>
                <default>false</default>
                <label>Contacted</label>
            </value>
            <value>
                <fullName>Converted</fullName>
                <default>false</default>
                <label>Converted</label>
            </value>
        </valueSetDefinition>
    </valueSet>
</CustomField>
```

### Additional Examples

**Example 1: Required priority field on Account object**
- **File Path**: `force-app/main/default/objects/Account/fields/Priority__c.field-meta.xml`
```xml
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Priority__c</fullName>
    <externalId>false</externalId>
    <label>Priority</label>
    <required>true</required>
    <trackFeedHistory>false</trackFeedHistory>
    <type>Picklist</type>
    <valueSet>
        <restricted>true</restricted>
        <valueSetDefinition>
            <sorted>false</sorted>
            <value>
                <fullName>High</fullName>
                <default>false</default>
                <label>High</label>
            </value>
            <value>
                <fullName>Medium</fullName>
                <default>true</default>
                <label>Medium</label>
            </value>
            <value>
                <fullName>Low</fullName>
                <default>false</default>
                <label>Low</label>
            </value>
        </valueSetDefinition>
    </valueSet>
</CustomField>
```

**Example 2: Optional category field on Opportunity object**
- **File Path**: `force-app/main/default/objects/Opportunity/fields/Category__c.field-meta.xml`
```xml
<?xml version="1.0" encoding="UTF-8"?>
<CustomField xmlns="http://soap.sforce.com/2006/04/metadata">
    <fullName>Category__c</fullName>
    <externalId>false</externalId>
    <label>Category</label>
    <required>false</required>
    <trackFeedHistory>false</trackFeedHistory>
    <type>Picklist</type>
    <valueSet>
        <restricted>true</restricted>
        <valueSetDefinition>
            <sorted>true</sorted>
            <value>
                <fullName>Existing Customer</fullName>
                <default>false</default>
                <label>Existing Customer</label>
            </value>
            <value>
                <fullName>New Customer</fullName>
                <default>false</default>
                <label>New Customer</label>
            </value>
            <value>
                <fullName>Partner</fullName>
                <default>false</default>
                <label>Partner</label>
            </value>
        </valueSetDefinition>
    </valueSet>
</CustomField>
```

### Supported Objects
This template works with standard Salesforce objects including:
- Lead
- Account
- Opportunity
- Contact
- Case
- And any other standard or custom object

## Best Practices
1. Always validate the field name follows Salesforce naming conventions
2. Ensure the field name ends with `__c` suffix
3. Maintain consistency with existing field files in the target object
4. The field label should be human-readable and descriptive
5. All picklist values should be meaningful and relevant to the business use case
6. Only one value should be marked as default (if any)
7. All new fields must be added to the package.xml for deployment

## Deployment Instructions
After updating the manifest/package.xml file, deploy the changes using the following command:

```bash
sf project deploy start --manifest /Users/niawjunior/Desktop/salesforce-app/innovation-lab/manifest/package.xml
```

## Step-by-Step Deployment Process
1. **Update the manifest file**: Ensure your `manifest/package.xml` includes all the new components you want to deploy
2. **Validate the manifest**: Check that all components are correctly listed with proper names and types
3. **Run the deployment command**: Execute the following command in your terminal:
   ```bash
   sf project deploy start --manifest /Users/niawjunior/Desktop/salesforce-app/innovation-lab/manifest/package.xml
   ```
4. **Monitor the deployment**: Watch for any errors or warnings in the terminal output
5. **Verify deployment success**: Confirm that all components were deployed successfully in your target org

## Advanced Options
For more complex picklist configurations, you can:
1. Set `<restricted>false</restricted>` for unrestricted picklists
2. Add `<sorted>true</sorted>` to sort values alphabetically
3. Mark one value as default by setting `<default>true</default>` for that value
4. Add multiple values with different labels and full names as needed

## Sample Usage
To create a picklist field named "Priority" with values "High", "Medium", and "Low" on the Account object:

1. Create the file: `force-app/main/default/objects/Account/fields/Priority__c.field-meta.xml`
2. Populate it with the XML structure above, replacing placeholders with actual values
3. Update package.xml to include the new field
4. Deploy using the deployment command
