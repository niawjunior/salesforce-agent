public with sharing class LeadColorPicklistDisplayController {

    @AuraEnabled
    public static List<String> getColorPicklistValues() {
        try {
            // Get the Lead.Color__c field describe result
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
