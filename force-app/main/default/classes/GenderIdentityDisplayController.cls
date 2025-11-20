public with sharing class GenderIdentityDisplayController {

    @AuraEnabled
    public static List<String> getGenderIdentityPicklistValues() {
        try {
            Schema.DescribeFieldResult fieldResult;

            // Try to get GenderIdentity field using different approaches
            try {
                // First try as standard field
                fieldResult = Lead.SObjectType.fields.GenderIdentity.getDescribe();
            } catch (Exception e1) {
                try {
                    // Try as Gender Identity (with space) using Schema getGlobalDescribe
                    Map<String, Schema.SObjectType> globalDescribe = Schema.getGlobalDescribe();
                    Schema.SObjectType leadType = globalDescribe.get('Lead');
                    if (leadType != null) {
                        Map<String, Schema.SObjectField> fieldMap = leadType.getDescribe().fields.getMap();
                        SObjectField genderField = fieldMap.get('Gender_Identity__c');
                        if (genderField != null) {
                            fieldResult = genderField.getDescribe();
                        } else {
                            throw new AuraHandledException('GenderIdentity field not found on Lead object. Please ensure the field exists and is accessible.');
                        }
                    } else {
                        throw new AuraHandledException('Lead object not found.');
                    }
                } catch (Exception e2) {
                    // Since we don't know the exact field name, let's create a fallback
                    throw new AuraHandledException('GenderIdentity field not found on Lead object. The field may not exist or may not be accessible.');
                }
            }

            List<Schema.PicklistEntry> picklistValues = fieldResult.getPicklistValues();
            List<String> options = new List<String>();

            for (Schema.PicklistEntry entry : picklistValues) {
                if (entry.isActive()) {
                    options.add(entry.getValue());
                }
            }

            return options;
        } catch (AuraHandledException e) {
            throw e; // Re-throw AuraHandled exceptions as-is
        } catch (Exception e) {
            throw new AuraHandledException('Error fetching gender identity picklist values: ' + e.getMessage());
        }
    }

    // Alternative method for fields that we know exist
    @AuraEnabled
    public static List<String> getColorPicklistValues() {
        try {
            // Use the Color__c field that we know exists
            Schema.DescribeFieldResult fieldResult = Lead.Color__c.getDescribe();
            List<Schema.PicklistEntry> picklistValues = fieldResult.getPicklistValues();
            List<String> options = new List<String>();

            for (Schema.PicklistEntry entry : picklistValues) {
                if (entry.isActive()) {
                    options.add(entry.getValue());
                }
            }

            return options;
        } catch (Exception e) {
            throw new AuraHandledException('Error fetching color picklist values: ' + e.getMessage());
        }
    }
}