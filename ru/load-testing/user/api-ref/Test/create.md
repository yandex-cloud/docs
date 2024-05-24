---
editable: false
sourcePath: en/_api-ref/loadtesting/api/v1/user/api-ref/Test/create.md
---

# Load Testing API, REST: Test.create
Creates (runs) a test in the specified folder.
 

 
## HTTP request {#https-request}
```
POST https://loadtesting.{{ api-host }}/loadtesting/api/v1/tests
```
 
## Body parameters {#body_params}
 
```json 
{
  "folderId": "string",
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
  "testDetails": {
    "name": "string",
    "description": "string",
    "tags": [
      {
        "key": "string",
        "value": "string"
      }
    ],
    "loggingLogGroupId": "string",
    "artifactSettings": {
      "isArchive": true,
      "filterInclude": [
        "string"
      ],
      "filterExclude": [
        "string"
      ],
      "objectStorageBucket": "string"
    }
  }
}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>Required. ID of the folder to create a test in.</p> <p>The maximum string length in characters is 50.</p> 
configurations[] | **object**<br><p>Test configuration associated with agents on which they will be executed. In case of multiple configurations, a multitest will be created.</p> 
configurations[].<br>configId | **string**<br><p>ID of the config.</p> 
configurations[].<br>agentSelector | **object**<br><p>Agent selection criterion.</p> <p>Agent selection criterion.</p> <p>The structure is used by service to determine on which agents a specific test should be executed.</p> 
configurations[].<br>agentSelector.<br>agentId | **string** <br>`configurations[].agentSelector` includes only one of the fields `agentId`, `matchByFilter`, `anonymousAgent`<br><br><p>Selection by agent ID.</p> 
configurations[].<br>agentSelector.<br>matchByFilter | **string** <br>`configurations[].agentSelector` includes only one of the fields `agentId`, `matchByFilter`, `anonymousAgent`<br><br><p>Selection by filter string.</p> 
configurations[].<br>agentSelector.<br>anonymousAgent | **boolean** (boolean) <br>`configurations[].agentSelector` includes only one of the fields `agentId`, `matchByFilter`, `anonymousAgent`<br><br><p>Select anonymoud (i.e. not registered) agents.</p> 
configurations[].<br>files | **object**<br><p>Additional files to be used during test execution, represented as ``rel_path:file`` pairs.</p> <p>``rel_path`` can be either a simple file name, a relative path, or absolute path. Files are downloaded by the agent to appropriate location.</p> <p>Use cases include:</p> <ul> <li><a href="/docs/load-testing/concepts/payload">Test Data files</a>.</li> <li>Custom Pandora executable.</li> <li>JMeter executable or ".jmx" scenario.</li> <li>etc.</li> </ul> 
testDetails | **object**<br><p>Test details. Name, tags etc.</p> <p>Test meta information.</p> 
testDetails.<br>name | **string**<br><p>Name of the test.</p> <p>Value must match the regular expression ``\|[a-z]([-a-z0-9]{0,61}[a-z0-9])?``.</p> 
testDetails.<br>description | **string**<br><p>Description of the test.</p> <p>The maximum string length in characters is 256.</p> 
testDetails.<br>tags[] | **object**<br><p>Tags assigned to the test.</p> 
testDetails.<br>tags[].<br>key | **string**<br><p>Key of the tag.</p> 
testDetails.<br>tags[].<br>value | **string**<br><p>Value of the tag.</p> 
testDetails.<br>loggingLogGroupId | **string**<br><p>ID of the logging group to which test artifacts are uploaded.</p> 
testDetails.<br>artifactSettings | **object**<br><p>Settings which define where to upload test artifacts and which files should be included.</p> <p>Artifact upload settings.</p> <p>Defines where to upload test artifacts and which files should be included.</p> 
testDetails.<br>artifactSettings.<br>isArchive | **boolean** (boolean)<br><p>Setting which defines whether artifact files should be archived prior to uploading.</p> 
testDetails.<br>artifactSettings.<br>filterInclude[] | **string**<br><p>Filter strings defining which files should be included to artifacts. GLOB format.</p> <p>Example:</p> <ul> <li>['*'] - all files will be uploaded.</li> <li>['<em>.log', '</em>.yaml] - all ``.log`` and ``.yaml`` files will be uploaded.</li> </ul> 
testDetails.<br>artifactSettings.<br>filterExclude[] | **string**<br><p>Filter strings defining which files should be excluded from artifacts. GLOB format.</p> <p>Example:</p> <ul> <li>filter_include=['*'], filter_exclude=['phout.log'] - upload all ``.log`` files excluding ``phout.log``.</li> </ul> 
testDetails.<br>artifactSettings.<br>objectStorageBucket | **string**<br><p>Name of output object storage bucket in test's folder.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // end of the list of possible fields

}
```
An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 