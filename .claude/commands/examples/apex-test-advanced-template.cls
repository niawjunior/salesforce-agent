@isTest
private class {ApexClassName}Test {

    // Test data factory method
    private static {ObjectName} createTestRecord() {
        {ObjectName} testObj = new {ObjectName}();
        testObj.Name = 'Test Record';
        testObj.{FieldName} = 'Test Value';
        return testObj;
    }
    
    @isTest
    static void testWithTestContext() {
        Test.startTest();
        
        // Insert test data if needed
        {ObjectName} testRecord = createTestRecord();
        // insert testRecord;
        
        // Test your method
        List<String> result = {ApexClassName}.get{FieldNameWithoutCustom}PicklistValues();
        
        // Assertions
        System.assertNotEquals(null, result);
        
        Test.stopTest();
    }
}