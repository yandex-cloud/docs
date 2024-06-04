---
editable: false
sourcePath: en/_api-ref/serverless/functions/v1/functions/api-ref/Function/createVersion.md
---

# Cloud Functions Service, REST: Function.createVersion
Creates a version for the specified function.
 

 
## HTTP request {#https-request}
```
POST https://serverless-functions.{{ api-host }}/functions/v1/versions
```
 
## Body parameters {#body_params}
 
```json 
{
  "functionId": "string",
  "runtime": "string",
  "description": "string",
  "entrypoint": "string",
  "resources": {
    "memory": "string"
  },
  "executionTimeout": "string",
  "serviceAccountId": "string",
  "environment": "object",
  "tag": [
    "string"
  ],
  "connectivity": {
    "networkId": "string",
    "subnetId": [
      "string"
    ]
  },
  "namedServiceAccounts": "object",
  "secrets": [
    {
      "id": "string",
      "versionId": "string",
      "key": "string",
      "environmentVariable": "string"
    }
  ],
  "logOptions": {
    "disabled": true,
    "minLevel": "string",

    // `logOptions` includes only one of the fields `logGroupId`, `folderId`
    "logGroupId": "string",
    "folderId": "string",
    // end of the list of possible fields`logOptions`

  },
  "storageMounts": [
    {
      "bucketId": "string",
      "prefix": "string",
      "mountPointName": "string",
      "readOnly": true
    }
  ],
  "asyncInvocationConfig": {
    "retriesCount": "string",
    "successTarget": {

      // `asyncInvocationConfig.successTarget` includes only one of the fields `emptyTarget`, `ymqTarget`
      "emptyTarget": {},
      "ymqTarget": {
        "queueArn": "string",
        "serviceAccountId": "string"
      },
      // end of the list of possible fields`asyncInvocationConfig.successTarget`

    },
    "failureTarget": {

      // `asyncInvocationConfig.failureTarget` includes only one of the fields `emptyTarget`, `ymqTarget`
      "emptyTarget": {},
      "ymqTarget": {
        "queueArn": "string",
        "serviceAccountId": "string"
      },
      // end of the list of possible fields`asyncInvocationConfig.failureTarget`

    },
    "serviceAccountId": "string"
  },
  "tmpfsSize": "string",
  "concurrency": "string",

  //  includes only one of the fields `package`, `content`, `versionId`
  "package": {
    "bucketName": "string",
    "objectName": "string",
    "sha256": "string"
  },
  "content": "string",
  "versionId": "string",
  // end of the list of possible fields

}
```

 
Field | Description
--- | ---
functionId | **string**<br><p>Required. ID of the function to create a version for.</p> <p>To get a function ID, make a <a href="/docs/functions/functions/api-ref/Function/list">list</a> request.</p> 
runtime | **string**<br><p>Required. Runtime environment for the version.</p> 
description | **string**<br><p>Description of the version</p> <p>The string length in characters must be 0-256.</p> 
entrypoint | **string**<br><p>Required. Entrypoint of the version.</p> 
resources | **object**<br>Required. Resources allocated to the version.
resources.<br>memory | **string** (int64)<br><p>Amount of memory available to the version, specified in bytes, multiple of 128MB.</p> <p>Acceptable values are 134217728 to 4294967296, inclusive.</p> 
executionTimeout | **string**<br><p>Required. Timeout for the execution of the version.</p> <p>If the timeout is exceeded, Cloud Functions responds with a 504 HTTP code.</p> 
serviceAccountId | **string**<br><p>ID of the service account to associate with the version.</p> 
environment | **object**<br><p>Environment settings for the version.</p> <p>Each key must match the regular expression ``[a-zA-Z][a-zA-Z0-9_]*``. The maximum string length in characters for each value is 4096.</p> 
tag[] | **string**<br><p>Function version tags. For details, see <a href="/docs/functions/concepts/function#tag">Version tag</a>.</p> <p>Each value must match the regular expression ``[a-z][-_0-9a-z]*``.</p> 
connectivity | **object**<br>Function version connectivity. If specified the version will be attached to specified network/subnet(s).
connectivity.<br>networkId | **string**<br><p>Network the version will have access to. It's essential to specify network with subnets in all availability zones.</p> 
connectivity.<br>subnetId[] | **string**<br><p>Complete list of subnets (from the same network) the version can be attached to. It's essential to specify at least one subnet for each availability zones.</p> <p>The string length in characters for each value must be greater than 0.</p> 
namedServiceAccounts | **object**<br><p>Additional service accounts to be used by the version.</p> 
secrets[] | **object**<br><p>Yandex Lockbox secrets to be used by the version.</p> 
secrets[].<br>id | **string**<br><p>ID of Yandex Lockbox secret.</p> 
secrets[].<br>versionId | **string**<br><p>ID of Yandex Lockbox version.</p> 
secrets[].<br>key | **string**<br><p>Key in secret's payload, which value to be delivered into function environment.</p> 
secrets[].<br>environmentVariable | **string**<br><p>environment variable in which secret's value to be delivered.</p> 
logOptions | **object**<br>Options for logging from the function
logOptions.<br>disabled | **boolean** (boolean)<br><p>Is logging from function disabled.</p> 
logOptions.<br>minLevel | **string**<br>Minimum log entry level.  See [LogLevel.Level] for details.<br><ul> <li> <p>TRACE: Trace log level.</p> <p>Possible use case: verbose logging of some business logic.</p> </li> <li> <p>DEBUG: Debug log level.</p> <p>Possible use case: debugging special cases in application logic.</p> </li> <li> <p>INFO: Info log level.</p> <p>Mostly used for information messages.</p> </li> <li> <p>WARN: Warn log level.</p> <p>May be used to alert about significant events.</p> </li> <li> <p>ERROR: Error log level.</p> <p>May be used to alert about errors in infrastructure, logic, etc.</p> </li> <li> <p>FATAL: Fatal log level.</p> <p>May be used to alert about unrecoverable failures and events.</p> </li> </ul> 
logOptions.<br>logGroupId | **string** <br>`logOptions` includes only one of the fields `logGroupId`, `folderId`<br><br><p>Entry should be written to log group resolved by ID.</p> <p>Value must match the regular expression ``([a-zA-Z][-a-zA-Z0-9_.]{0,63})?``.</p> 
logOptions.<br>folderId | **string** <br>`logOptions` includes only one of the fields `logGroupId`, `folderId`<br><br><p>Entry should be written to default log group for specified folder.</p> <p>Value must match the regular expression ``([a-zA-Z][-a-zA-Z0-9_.]{0,63})?``.</p> 
storageMounts[] | **object**<br><p>S3 mounts to be used by the version.</p> 
storageMounts[].<br>bucketId | **string**<br><p>Required. S3 bucket name for mounting.</p> <p>The string length in characters must be 3-63. Value must match the regular expression ``[-.0-9a-zA-Z]*``.</p> 
storageMounts[].<br>prefix | **string**<br><p>S3 bucket prefix for mounting.</p> 
storageMounts[].<br>mountPointName | **string**<br><p>Required. Mount point directory name (not path) for mounting.</p> <p>The string length in characters must be 1-100. Value must match the regular expression ``[-_0-9a-zA-Z]*``.</p> 
storageMounts[].<br>readOnly | **boolean** (boolean)<br><p>Is mount read only.</p> 
asyncInvocationConfig | **object**<br>Config for asynchronous invocations of the version
asyncInvocationConfig.<br>retriesCount | **string** (int64)<br><p>Number of retries of version invocation</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
asyncInvocationConfig.<br>successTarget | **object**<br><p>Required. Target for successful result of the version's invocation</p> <p>Target to which a result of an invocation will be sent</p> 
asyncInvocationConfig.<br>successTarget.<br>emptyTarget | **object**<br>Target to ignore a result <br>`asyncInvocationConfig.successTarget` includes only one of the fields `emptyTarget`, `ymqTarget`<br>
asyncInvocationConfig.<br>successTarget.<br>ymqTarget | **object**<br>Target to send a result to ymq <br>`asyncInvocationConfig.successTarget` includes only one of the fields `emptyTarget`, `ymqTarget`<br>
asyncInvocationConfig.<br>successTarget.<br>ymqTarget.<br>queueArn | **string**<br><p>Required. Queue ARN</p> 
asyncInvocationConfig.<br>successTarget.<br>ymqTarget.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
asyncInvocationConfig.<br>failureTarget | **object**<br><p>Required. Target for unsuccessful result, if all retries failed</p> <p>Target to which a result of an invocation will be sent</p> 
asyncInvocationConfig.<br>failureTarget.<br>emptyTarget | **object**<br>Target to ignore a result <br>`asyncInvocationConfig.failureTarget` includes only one of the fields `emptyTarget`, `ymqTarget`<br>
asyncInvocationConfig.<br>failureTarget.<br>ymqTarget | **object**<br>Target to send a result to ymq <br>`asyncInvocationConfig.failureTarget` includes only one of the fields `emptyTarget`, `ymqTarget`<br>
asyncInvocationConfig.<br>failureTarget.<br>ymqTarget.<br>queueArn | **string**<br><p>Required. Queue ARN</p> 
asyncInvocationConfig.<br>failureTarget.<br>ymqTarget.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
asyncInvocationConfig.<br>serviceAccountId | **string**<br><p>Service account which can invoke version</p> 
tmpfsSize | **string** (int64)<br><p>Optional size of in-memory mounted /tmp directory in bytes. Available for versions with resources.memory greater or equal to 1024 MiB.</p> <p>0 or in range from 512 MiB to 3/4 of resources.memory.</p> 
concurrency | **string** (int64)<br><p>The maximum number of requests processed by a function instance at the same time</p> <p>Acceptable values are 0 to 16, inclusive.</p> 
package | **object**<br>Functions deployment package. <br> includes only one of the fields `package`, `content`, `versionId`<br>
package.<br>bucketName | **string**<br><p>Required. Name of the bucket that stores the code for the version.</p> 
package.<br>objectName | **string**<br><p>Required. Name of the object in the bucket that stores the code for the version.</p> 
package.<br>sha256 | **string**<br><p>SHA256 hash of the version deployment package.</p> 
content | **string** (byte) <br> includes only one of the fields `package`, `content`, `versionId`<br><br><p>Content of the deployment package.</p> <p>The maximum string length in characters is 52428800.</p> 
versionId | **string** <br> includes only one of the fields `package`, `content`, `versionId`<br><br><p>ID of the version to be copied from. Source version must belong to the same folder as the created version and the user must have read permissions to the source version.</p> 
 
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