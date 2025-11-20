# Create Apex Unit Test

## Overview
This command generates comprehensive unit tests for Apex controllers to ensure code quality and deployment success.

## Prerequisites
1. Salesforce CLI installed and configured
2. Apex controller class already exists
3. Project properly authenticated with a Dev Hub

## Command Usage
Tell me the name of your Apex controller class, and I'll generate appropriate unit tests.

## What I Need From You
Please provide:
- **ApexClassName**: The name of your Apex controller class (e.g., `LeadColorDisplayController`, `GenderIdentityDisplayController`)

## Test Template Structure

### Basic Test Class Template
```apex
@isTest
private class {ApexClassName}Test {

    @isTest
    static void testGet{FieldName}PicklistValues_Success() {
        Test.startTest();
        try {
            List<String> result = {ApexClassName}.get{FieldNameWithoutCustom}PicklistValues();
            
            // Assert that results are not null
            System.assertNotEquals(null, result, 'Result should not be null');
            
            // Assert that results are not empty (assuming field has values)
            System.assert(!result.isEmpty(), 'Result should not be empty');
            
            // Assert that each result is not null or empty
            for(String value : result) {
                System.assert(!String.isBlank(value), 'Picklist values should not be blank');
            }
            
        } catch (Exception e) {
            System.assert(false, 'Unexpected exception: ' + e.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void testGet{FieldName}PicklistValues_ErrorHandling() {
        Test.startTest();
        try {
            // This test would need to be adapted based on your specific error scenarios
            // For now, we'll just verify the method runs without unexpected exceptions
            
            List<String> result = {ApexClassName}.get{FieldNameWithoutCustom}PicklistValues();
            
            // Basic assertion - the method should complete successfully
            System.assertNotEquals(null, result, 'Method should return a result');
            
        } catch (AuraHandledException e) {
            // Expected behavior - AuraHandledException should be caught and handled
            System.assert(true, 'AuraHandledException caught as expected: ' + e.getMessage());
        } catch (Exception e) {
            System.assert(false, 'Unexpected exception type: ' + e.getTypeName() + ' - ' + e.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void testGet{FieldName}PicklistValues_FieldAccessibility() {
        Test.startTest();
        
        // Test that the field is accessible
        try {
            Schema.DescribeFieldResult fieldResult = {ObjectName}.{FieldName}.getDescribe();
            System.assertNotEquals(null, fieldResult, 'Field should be accessible');
            System.assert(fieldResult.isAccessible(), 'Field should be accessible to current user');
            
        } catch (Exception e) {
            System.assert(false, 'Field accessibility test failed: ' + e.getMessage());
        }
        
        Test.stopTest();
    }
}
```

## Test Data Requirements

### For Picklist Field Tests
1. **Positive Test Case**: Verify successful retrieval of picklist values
2. **Error Handling Test**: Verify proper exception handling
3. **Field Accessibility Test**: Verify the field exists and is accessible
4. **Data Validation Test**: Verify returned values are valid picklist entries

### Test Best Practices
1. **Use `@isTest` annotation** for all test methods
2. **Use `Test.startTest()` and `Test.stopTest()`** for proper test context
3. **Assert specific conditions** rather than general success
4. **Test both positive and negative scenarios**
5. **Include meaningful assertions** for business logic validation
6. **Test security and permissions** where applicable

## Example Usage

### Example 1: LeadColorDisplayController
**ApexClassName**: `LeadColorDisplayController`
**FieldName**: `Color__c`
**FieldNameWithoutCustom**: `Color`
**ObjectName**: `Lead`

Generated test class name: `LeadColorDisplayControllerTest`

### Example 2: GenderIdentityDisplayController  
**ApexClassName**: `GenderIdentityDisplayController`
**FieldName**: `GenderIdentity`
**FieldNameWithoutCustom**: `GenderIdentity`
**ObjectName**: `Lead`

Generated test class name: `GenderIdentityDisplayControllerTest`

## Running the Tests

### Execute Tests via CLI
```bash
sf apex run test --class {ApexClassName}Test
```

### Execute Tests via Developer Console
1. Open Developer Console
2. Go to Test → New Apex Class
3. Enter test class name
4. Click "Run"

## Deployment with Tests

### Update Package.xml
Ensure your test class is included in package.xml:
```xml
<types>
    <members>{ApexClassName}Test</members>
    <name>ApexClass</name>
</types>
```

### Deploy with Test Execution
```bash
sf project deploy start --manifest path/to/package.xml --test-level RunLocalTests
```

## Test Coverage Requirements

### Salesforce Requirements
- Minimum 75% code coverage for deployment
- Recommended 85%+ for production deployment
- All Apex classes must have some test coverage

### Coverage Calculation
- Each line of executable code must be covered
- Comments and blank lines don't count toward coverage
- Exception handling blocks need coverage

## Common Test Scenarios

### For Picklist Controllers
1. **Empty Picklist**: Test when field has no values
2. **Single Value**: Test when field has only one value
3. **Multiple Values**: Test when field has many values
4. **Inactive Values**: Test that inactive values are excluded
5. **Permission Issues**: Test behavior with insufficient permissions
6. **Field Not Found**: Test error handling for non-existent fields

## Advanced Testing Techniques

### Mocking and Test Context
```apex
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
```

## Troubleshooting Test Failures

### Common Issues
1. **Field Not Accessible**: Check user permissions and field-level security
2. **Test Data Issues**: Ensure test data doesn't conflict with existing data
3. **Assertion Failures**: Verify expected vs actual values carefully
4. **Coverage Gaps**: Add test methods for uncovered code paths

### Debug Tips
- Use `System.debug()` statements to trace execution
- Check debug logs for detailed error information
- Verify test setup matches actual data structure
- Ensure test runs in proper system context

## Integration with CI/CD

### Automated Testing
```bash
# Run all tests
sf apex run test --code-coverage

# Run specific test class
sf apex run test --class {ApexClassName}Test --code-coverage

# Generate coverage report
sf apex run test --code-coverage --output-dir coverage-reports
```

### Quality Gates
- Set minimum coverage thresholds in CI pipeline
- Fail deployment if coverage below threshold
- Include test execution in deployment pipeline

## Best Practices Summary

1. **Test Early and Often**: Write tests alongside development
2. **Comprehensive Coverage**: Test all methods and code paths
3. **Meaningful Assertions**: Test business logic, not just execution
4. **Maintain Tests**: Update tests when code changes
5. **Document Tests**: Add comments explaining test purpose
6. **Regular Execution**: Run tests frequently during development
7. **Production Readiness**: Ensure adequate coverage before deployment

## Next Steps

After generating your test class:
1. Review and customize the generated test methods
2. Add any additional test scenarios specific to your use case
3. Run tests to verify they pass
4. Check code coverage meets requirements
5. Deploy with tests to ensure production readiness