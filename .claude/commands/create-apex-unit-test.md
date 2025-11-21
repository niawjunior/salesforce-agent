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
See @.claude/commands/examples/apex-test-basic-template.cls for the complete test class template.

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

## Deployment with Tests

### Important: Deploy Tests Before Running
**Test classes must be deployed to your org before you can run them.** The deployment process makes the test class available in your Salesforce environment.

### Update Package.xml
Ensure your test class is included in package.xml:
See @.claude/commands/examples/package-xml-example.xml for the XML structure.

### Step 1: Deploy Test Classes
```bash
sf project deploy start --manifest path/to/package.xml
```

### Step 2: Run Tests After Deployment

**Option A: Synchronous Execution (Wait for Results)**
```bash
sf apex run test --class-names {ApexClassName}Test --synchronous
```

**Option B: Asynchronous Execution (Retrieve Results Later)**
```bash
# Run tests asynchronously
sf apex run test --class-names {ApexClassName}Test

# Retrieve results using the test run ID provided
sf apex get test -i {TestRunId} -o {Username}
```

**Option C: Run All Tests with Coverage Report**
```bash
# Run all tests with code coverage
sf apex run test --code-coverage

# Retrieve results using the test run ID provided
sf apex get test -i {TestRunId} -o {Username}
```

### Execute Tests via Developer Console
1. Open Developer Console
2. Go to Test → New Apex Class
3. Enter test class name
4. Click "Run"

### Understanding Test Results
When running tests asynchronously (without `--synchronous`), you'll receive a test run ID. Use this ID to retrieve results:

```bash
# Example output after running tests
Run "sf apex get test -i 707Qy00000myk1G -o psb@wise-koala-tg9v5t.com" to retrieve test results

# Retrieve the results
sf apex get test -i 707Qy00000myk1G -o psb@wise-koala-tg9v5t.com
```

The test results include:
- Test outcome (Pass/Fail)
- Pass rate and execution time
- Individual test method results
- Code coverage metrics (when using --code-coverage)

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
See @.claude/commands/examples/apex-test-advanced-template.cls for advanced testing techniques with test data factory methods.

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
# Run all tests (synchronous)
sf apex run test --code-coverage --synchronous

# Run all tests (asynchronous - retrieve results later)
sf apex run test --code-coverage
sf apex get test -i {TestRunId} -o {Username}

# Run specific test class (synchronous)
sf apex run test --class-names {ApexClassName}Test --code-coverage --synchronous

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
3. **Deploy the test class first** using `sf project deploy start`
4. Run tests to verify they pass using `sf apex run test --class-names {ClassName}Test --synchronous`
5. Check code coverage meets requirements
6. Deploy with tests to ensure production readiness