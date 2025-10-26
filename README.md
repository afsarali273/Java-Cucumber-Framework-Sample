# Sample Test Project

This is a sample Maven project demonstrating how to use **SandsAutoFramework** as a dependency.

## Project Structure

```
SampleTestProject/
├── pom.xml                           # Maven configuration
├── testng.xml                        # TestNG suite configuration
├── src/test/
│   ├── java/com/sample/tests/
│   │   └── TestRunner.java          # Cucumber TestNG runner
│   └── resources/
│       ├── config.properties        # Project-specific config overrides
│       └── features/
│           ├── ui_test.feature      # UI test scenarios
│           └── api_test.feature     # API test scenarios
```

## Prerequisites

1. **Install Framework JAR** to local Maven repository:
   ```bash
   cd /Users/afsarali/AquaProjects/SandsAutoFramework
   mvn clean install
   ```

2. **Java 11+** installed
3. **Maven 3.6+** installed

## Running Tests

### Local Development (TestNG Runner)

For local development and debugging, use the TestNG runner:

#### Run All Tests
```bash
mvn clean test
```

#### Run Only UI Tests
```bash
mvn test -Dcucumber.filter.tags="@UI"
```

#### Run Only API Tests
```bash
mvn test -Dcucumber.filter.tags="@API"
```

#### Run with Specific Browser
```bash
mvn test -Dbrowser=firefox
```

#### Run in Headless Mode
```bash
mvn test -Dheadless=true
```

### CI Pipeline (Cucumber CLI Runner)

For CI/CD pipelines, use the CLI runner for better control and performance:

#### Run All Tests (CI)
```bash
mvn clean compile test-compile exec:java -Dexec.mainClass="com.sample.tests.CucumberCLIRunner"
```

#### Run with Tags (CI)
```bash
mvn exec:java -Dexec.mainClass="com.sample.tests.CucumberCLIRunner" -Dcucumber.filter.tags="@UI" -Dthread_count=5
```

#### Run with Profile (CI)
```bash
mvn clean test -Pcucumber-cli -Dcucumber.filter.tags="@API" -Dthread_count=3
```

#### CI Pipeline Examples
```yaml
# GitHub Actions / Jenkins
- name: Run UI Tests
  run: mvn exec:java -Dexec.mainClass="com.sample.tests.CucumberCLIRunner" -Dcucumber.filter.tags="@UI" -Dheadless=true -Dthread_count=4

- name: Run API Tests  
  run: mvn exec:java -Dexec.mainClass="com.sample.tests.CucumberCLIRunner" -Dcucumber.filter.tags="@API" -Dthread_count=6
```

## Configuration

Project-specific configuration is in `src/test/resources/config.properties`.

Override any framework default by adding properties:

```properties
# Example overrides
framework.type=playwright
browser=chrome
base.url=https://your-app.com
environment=qa
```

## Test Examples

### UI Test Example
```gherkin
@UI
Feature: Web UI Testing
  Scenario: Search on Google
    Given open browser
    And navigate to "https://www.google.com"
    When type "Selenium automation" into "textarea[name='q']"
    And press enter on element "textarea[name='q']"
    Then page should contain text "results"
```

### API Test Example
```gherkin
@API
Feature: REST API Testing
  Scenario: Get user details
    When user sends GET request to "/users/1"
    Then response status code should be 200
    And json path "name" should not be null
```

## Reports

After test execution, reports are generated in:

- **Cucumber HTML**: `test-output/cucumber-reports/cucumber.html`
- **ExtentReport**: `test-output/reports/ExtentReport_*.html`
- **CustomReport**: `test-output/reports/CustomReport_*.html`
- **Allure**: Run `mvn allure:serve` to view

## Adding Custom Steps

Create project-specific step definitions:

```java
package com.sample.stepdefinitions;

import io.cucumber.java.en.*;

public class CustomSteps {
    
    @Given("custom step for my project")
    public void customStep() {
        // Your custom logic
    }
}
```

Update TestRunner glue:
```java
glue = {
    "com.automation.stepdefinitions",  // Framework steps
    "com.automation.hooks",             // Framework hooks
    "com.sample.stepdefinitions"        // Your custom steps
}
```

## Framework Features Used

✅ **150+ Pre-built Step Definitions** - No need to write step definitions  
✅ **Multi-Framework Support** - Selenium, Playwright, API  
✅ **Unified Logging** - All actions logged to multiple reports  
✅ **Variable Substitution** - Use `${variableName}` in steps  
✅ **Thread-Safe** - Parallel execution ready  
✅ **Multiple Reports** - ExtentReports, Allure, Cucumber HTML  

## Troubleshooting

### Framework JAR not found
```bash
# Install framework to local Maven repo
cd ../SandsAutoFramework
mvn clean install
```

### Browser driver issues
Framework auto-manages drivers. Ensure internet connection for first-time download.

### Port conflicts (API tests)
Change base URL in `config.properties` if needed.

## Next Steps

1. Add more feature files in `src/test/resources/features/`
2. Override config in `config.properties` as needed
3. Add project-specific step definitions if required
4. Run tests: `mvn clean test`

## Support

Refer to framework documentation: `SandsAutoFramework/COMMON_STEPS_REFERENCE.md`
