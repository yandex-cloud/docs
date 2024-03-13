---
editable: false
sourcePath: en/_api-ref/serverless/functions/v1/functions/api-ref/Function/getVersion.md
---

# Cloud Functions Service, REST: Function.getVersion
Returns the specified version of a function.
 
To get the list of available version, make a [listVersions](/docs/functions/functions/api-ref/Function/listVersions) request.
 
## HTTP request {#https-request}
```
GET https://serverless-functions.{{ api-host }}/functions/v1/versions/{functionVersionId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
functionVersionId | <p>Required. ID of the version to return.</p> <p>To get a version ID make a <a href="/docs/functions/functions/api-ref/Function/listVersions">listVersions</a> request.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "functionId": "string",
  "description": "string",
  "createdAt": "string",
  "runtime": "string",
  "entrypoint": "string",
  "resources": {
    "memory": "string"
  },
  "executionTimeout": "string",
  "serviceAccountId": "string",
  "imageSize": "string",
  "status": "string",
  "tags": [
    "string"
  ],
  "logGroupId": "string",
  "environment": "object",
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
  "tmpfsSize": "string"
}
```
Version of a function. For details about the concept, see [Function versions](/docs/functions/concepts/function#version).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the version.</p> 
functionId | **string**<br><p>ID of the function that the version belongs to.</p> 
description | **string**<br><p>Description of the version.</p> <p>The string length in characters must be 0-256.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp for the version.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
runtime | **string**<br><p>ID of the runtime environment for the function.</p> <p>Supported environments and their identifiers are listed in the <a href="/docs/functions/concepts/runtime">Runtime environments</a>.</p> 
entrypoint | **string**<br><p>Entrypoint for the function: the name of the function to be called as the handler.</p> <p>Specified in the format ``<function file name>.<handler name>``, for example, ``index.myFunction``.</p> 
resources | **object**<br><p>Resources allocated to the version.</p> <p>Resources allocated to a version.</p> 
resources.<br>memory | **string** (int64)<br><p>Amount of memory available to the version, specified in bytes, multiple of 128MB.</p> <p>Acceptable values are 134217728 to 4294967296, inclusive.</p> 
executionTimeout | **string**<br><p>Timeout for the execution of the version.</p> <p>If the timeout is exceeded, Cloud Functions responds with a 504 HTTP code.</p> 
serviceAccountId | **string**<br><p>ID of the service account associated with the version.</p> 
imageSize | **string** (int64)<br><p>Final size of the deployment package after unpacking.</p> 
status | **string**<br><p>Status of the version.</p> <ul> <li>CREATING: Version is being created.</li> <li>ACTIVE: Version is ready to use.</li> </ul> 
tags[] | **string**<br><p>Version tags. For details, see <a href="/docs/functions/concepts/function#tag">Version tag</a>.</p> 
logGroupId | **string**<br><p>ID of the log group for the version.</p> 
environment | **object**<br><p>Environment settings for the version.</p> 
connectivity | **object**<br><p>Network access. If specified the version will be attached to specified network/subnet(s).</p> <p>Version connectivity specification.</p> 
connectivity.<br>networkId | **string**<br><p>Network the version will have access to. It's essential to specify network with subnets in all availability zones.</p> 
connectivity.<br>subnetId[] | **string**<br><p>Complete list of subnets (from the same network) the version can be attached to. It's essential to specify at least one subnet for each availability zones.</p> <p>The string length in characters for each value must be greater than 0.</p> 
namedServiceAccounts | **object**<br><p>Additional service accounts to be used by the version.</p> 
secrets[] | **object**<br><p>Yandex Lockbox secrets to be used by the version.</p> 
secrets[].<br>id | **string**<br><p>ID of Yandex Lockbox secret.</p> 
secrets[].<br>versionId | **string**<br><p>ID of Yandex Lockbox version.</p> 
secrets[].<br>key | **string**<br><p>Key in secret's payload, which value to be delivered into function environment.</p> 
secrets[].<br>environmentVariable | **string**<br><p>environment variable in which secret's value to be delivered.</p> 
logOptions | **object**<br><p>Options for logging from the function</p> 
logOptions.<br>disabled | **boolean** (boolean)<br><p>Is logging from function disabled.</p> 
logOptions.<br>minLevel | **string**<br>Minimum log entry level.  See [LogLevel.Level] for details.<br><ul> <li> <p>TRACE: Trace log level.</p> <p>Possible use case: verbose logging of some business logic.</p> </li> <li> <p>DEBUG: Debug log level.</p> <p>Possible use case: debugging special cases in application logic.</p> </li> <li> <p>INFO: Info log level.</p> <p>Mostly used for information messages.</p> </li> <li> <p>WARN: Warn log level.</p> <p>May be used to alert about significant events.</p> </li> <li> <p>ERROR: Error log level.</p> <p>May be used to alert about errors in infrastructure, logic, etc.</p> </li> <li> <p>FATAL: Fatal log level.</p> <p>May be used to alert about unrecoverable failures and events.</p> </li> </ul> 
logOptions.<br>logGroupId | **string** <br>`logOptions` includes only one of the fields `logGroupId`, `folderId`<br><br><p>Entry should be written to log group resolved by ID.</p> <p>Value must match the regular expression ``([a-zA-Z][-a-zA-Z0-9_.]{0,63})?``.</p> 
logOptions.<br>folderId | **string** <br>`logOptions` includes only one of the fields `logGroupId`, `folderId`<br><br><p>Entry should be written to default log group for specified folder.</p> <p>Value must match the regular expression ``([a-zA-Z][-a-zA-Z0-9_.]{0,63})?``.</p> 
storageMounts[] | **object**<br><p>S3 mounts to be used by the version.</p> 
storageMounts[].<br>bucketId | **string**<br><p>Required. S3 bucket name for mounting.</p> <p>The string length in characters must be 3-63. Value must match the regular expression ``[-.0-9a-zA-Z]*``.</p> 
storageMounts[].<br>prefix | **string**<br><p>S3 bucket prefix for mounting.</p> 
storageMounts[].<br>mountPointName | **string**<br><p>Required. Mount point directory name (not path) for mounting.</p> <p>The string length in characters must be 1-100. Value must match the regular expression ``[-_0-9a-zA-Z]*``.</p> 
storageMounts[].<br>readOnly | **boolean** (boolean)<br><p>Is mount read only.</p> 
asyncInvocationConfig | **object**<br><p>Config for asynchronous invocations of the version</p> 
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
tmpfsSize | **string** (int64)<br><p>Optional size of in-memory mounted /tmp directory in bytes.</p> 