---
editable: false
sourcePath: en/_api-ref/loadtesting/api/v1/user/api-ref/Test/get.md
---

# Load Testing API, REST: Test.get
Returns the specified test.
 
To get the list of all available tests, make a [list](/docs/load-testing/user/api-ref/Test/list) request.
 
## HTTP request {#https-request}
```
GET https://loadtesting.{{ api-host }}/loadtesting/api/v1/tests/{testId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
testId | <p>Required. ID of the test to return.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "configurations": [
    {
      "configId": "string",
      "agentSelector": {

        // `configurations[].agentSelector` includes only one of the fields `agentId`, `matchByFilter`, `anonymousAgent`
        "agentId": "string",
        "matchByFilter": "string",
        "anonymousAgent": true,
        // end of the list of possible fields`configurations[].agentSelector`

      },
      "files": "object"
    }
  ],
  "details": {
    "name": "string",
    "description": "string",
    "tags": [
      {
        "key": "string",
        "value": "string"
      }
    ],
    "loggingLogGroupId": "string"
  },
  "summary": {
    "status": "string",
    "createdAt": "string",
    "createdBy": "string",
    "startedAt": "string",
    "finishedAt": "string",
    "isFinished": true,
    "error": "string",
    "imbalancePoint": {
      "at": "string",
      "rps": "string"
    },
    "assignedAgentId": "string"
  },
  "folderId": "string"
}
```
Load Test.

In context of the service, Test represents a single testing task/job.
 
Field | Description
--- | ---
id | **string**<br><p>ID of the test. Generated at creation time.</p> 
configurations[] | **object**<br><p>Configuration of the test.</p> <p>A test can have multiple configurations if it can be executed on multiple agents simultaneously. For more information, see <a href="docs/load-testing/tutorials/loadtesting-multiply">Load testing using multiple agents</a>.</p> 
configurations[].<br>configId | **string**<br><p>ID of the config.</p> 
configurations[].<br>agentSelector | **object**<br><p>Agent selection criterion.</p> <p>Agent selection criterion.</p> <p>The structure is used by service to determine on which agents a specific test should be executed.</p> 
configurations[].<br>agentSelector.<br>agentId | **string** <br>`configurations[].agentSelector` includes only one of the fields `agentId`, `matchByFilter`, `anonymousAgent`<br><br><p>Selection by agent ID.</p> 
configurations[].<br>agentSelector.<br>matchByFilter | **string** <br>`configurations[].agentSelector` includes only one of the fields `agentId`, `matchByFilter`, `anonymousAgent`<br><br><p>Selection by filter string.</p> 
configurations[].<br>agentSelector.<br>anonymousAgent | **boolean** (boolean) <br>`configurations[].agentSelector` includes only one of the fields `agentId`, `matchByFilter`, `anonymousAgent`<br><br><p>Select anonymoud (i.e. not registered) agents.</p> 
configurations[].<br>files | **object**<br><p>Additional files to be used during test execution, represented as ``rel_path:file`` pairs.</p> <p>``rel_path`` can be either a simple file name, a relative path, or absolute path. Files are downloaded by the agent to appropriate location.</p> <p>Use cases include:</p> <ul> <li><a href="https://cloud.yandex.com/en-ru/docs/load-testing/concepts/payload">Test Data files</a>.</li> <li>Custom Pandora executable.</li> <li>JMeter executable or ".jmx" scenario.</li> <li>etc.</li> </ul> 
details | **object**<br><p>Test meta information. Name, description, etc.</p> <p>Test meta information.</p> 
details.<br>name | **string**<br><p>Name of the test.</p> <p>Value must match the regular expression ``\|[a-z]([-a-z0-9]{0,61}[a-z0-9])?``.</p> 
details.<br>description | **string**<br><p>Description of the test.</p> <p>The maximum string length in characters is 256.</p> 
details.<br>tags[] | **object**<br><p>Tags assigned to the test.</p> 
details.<br>tags[].<br>key | **string**<br><p>Key of the tag.</p> 
details.<br>tags[].<br>value | **string**<br><p>Value of the tag.</p> 
details.<br>loggingLogGroupId | **string**<br><p>ID of the logging group to which test artifacts are uploaded.</p> 
summary | **object**<br><p>Test execution information.</p> <p>Process of test and some results</p> 
summary.<br>status | **string**<br><p>Status of the test.</p> <ul> <li> <p>STATUS_UNSPECIFIED: Status is unspecified. - CREATED: Test has been created, but not started by any agent.</p> </li> <li> <p>INITIATED: Execution stage: initialization.</p> </li> <li> <p>PREPARING: Execution stage: data preparation and warm-up.</p> </li> <li> <p>RUNNING: Execution stage: load generation.</p> </li> <li> <p>FINISHING: Execution stage: termination.</p> </li> <li> <p>DONE: Test is done.</p> </li> <li> <p>POST_PROCESSING: Execution stage: results post-processing.</p> </li> <li> <p>FAILED: Test has failed due to some error.</p> </li> <li> <p>STOPPING: Test is being stopped.</p> </li> <li> <p>STOPPED: Test has been stopped.</p> </li> <li> <p>AUTOSTOPPED: Test has been stopped automatically by satisfying autostop condition.</p> </li> <li> <p>WAITING: Execution stage: waiting for a trigger to start.</p> </li> <li> <p>DELETING: Test is being deleted.</p> </li> <li> <p>LOST: Test status has not been reported in a while during execution stage.</p> <p>Means that either an agent is too busy to send it, got offline, or failed without reporting a final status.</p> </li> </ul> 
summary.<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
summary.<br>createdBy | **string**<br><p>UA or SA that created the test.</p> 
summary.<br>startedAt | **string** (date-time)<br><p>Test start timestamp.</p> <p>Empty if the test has not been started yet.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
summary.<br>finishedAt | **string** (date-time)<br><p>Test finish timestamp.</p> <p>Empty if the test has not been finished yet.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
summary.<br>isFinished | **boolean** (boolean)<br><p>Indicates whether the test is finished.</p> 
summary.<br>error | **string**<br><p>Error message.</p> 
summary.<br>imbalancePoint | **object**<br><p>Detected imbalance point.</p> <p>Contains information about a state at the moment it has been <a href="/docs/load-testing/concepts/auto-stop">auto-stopped</a>.</p> <p>Empty if no auto-stop occured.</p> <p>Test imbalance point.</p> 
summary.<br>imbalancePoint.<br>at | **string** (date-time)<br><p>Imbalance moment timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
summary.<br>imbalancePoint.<br>rps | **string** (int64)<br><p>Imbalance moment RPS.</p> 
summary.<br>assignedAgentId | **string**<br><p>ID of the agent that executed the test.</p> 
folderId | **string**<br><p>ID of the folder that the test belongs to.</p> 