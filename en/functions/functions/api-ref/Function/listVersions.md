---
editable: false
sourcePath: en/_api-ref/serverless/functions/v1/functions/api-ref/Function/listVersions.md
---

# Cloud Functions Service, REST: Function.listVersions
Retrieves the list of versions for the specified function, or of all function versions
in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://serverless-functions.{{ api-host }}/functions/v1/versions
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>ID of the folder to list function versions for. To get a folder ID make a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> 
functionId | <p>ID of the function to list versions for. To get a function ID use a <a href="/docs/functions/functions/api-ref/Function/list">list</a> request.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than ``pageSize``, the service returns a <a href="/docs/functions/functions/api-ref/Function/listVersions#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>Default value: 100.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token. To get the next page of results, set ``pageToken`` to the <a href="/docs/functions/functions/api-ref/Function/listVersions#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters resources listed in the response.</p> <p>The expression must specify:</p> <ol> <li>The field name. Currently filtering can only be applied to the ``status`` and ``runtime`` fields.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``). Must be 3-63 characters long and match the regular expression ``[a-z][-a-z0-9]{1,61}[a-z0-9]``. Example of a filter: ``status="ACTIVE"``.</li> </ol> <p>The maximum string length in characters is 1000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "versions": [
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

        // `versions[].logOptions` includes only one of the fields `logGroupId`, `folderId`
        "logGroupId": "string",
        "folderId": "string",
        // end of the list of possible fields`versions[].logOptions`

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

          // `versions[].asyncInvocationConfig.successTarget` includes only one of the fields `emptyTarget`, `ymqTarget`
          "emptyTarget": {},
          "ymqTarget": {
            "queueArn": "string",
            "serviceAccountId": "string"
          },
          // end of the list of possible fields`versions[].asyncInvocationConfig.successTarget`

        },
        "failureTarget": {

          // `versions[].asyncInvocationConfig.failureTarget` includes only one of the fields `emptyTarget`, `ymqTarget`
          "emptyTarget": {},
          "ymqTarget": {
            "queueArn": "string",
            "serviceAccountId": "string"
          },
          // end of the list of possible fields`versions[].asyncInvocationConfig.failureTarget`

        },
        "serviceAccountId": "string"
      },
      "tmpfsSize": "string",
      "concurrency": "string",
      "mounts": [
        {
          "name": "string",
          "mode": "string",

          // `versions[].mounts[]` includes only one of the fields `objectStorage`, `ephemeralDiskSpec`
          "objectStorage": {
            "bucketId": "string",
            "prefix": "string"
          },
          "ephemeralDiskSpec": {
            "size": "string",
            "blockSize": "string"
          },
          // end of the list of possible fields`versions[].mounts[]`

        }
      ]
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
versions[] | **object**<br><p>List of versions for the specified folder or function.</p> 
versions[].<br>id | **string**<br><p>ID of the version.</p> 
versions[].<br>functionId | **string**<br><p>ID of the function that the version belongs to.</p> 
versions[].<br>description | **string**<br><p>Description of the version.</p> <p>The string length in characters must be 0-256.</p> 
versions[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp for the version.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
versions[].<br>runtime | **string**<br><p>ID of the runtime environment for the function.</p> <p>Supported environments and their identifiers are listed in the <a href="/docs/functions/concepts/runtime">Runtime environments</a>.</p> 
versions[].<br>entrypoint | **string**<br><p>Entrypoint for the function: the name of the function to be called as the handler.</p> <p>Specified in the format ``<function file name>.<handler name>``, for example, ``index.myFunction``.</p> 
versions[].<br>resources | **object**<br><p>Resources allocated to the version.</p> <p>Resources allocated to a version.</p> 
versions[].<br>resources.<br>memory | **string** (int64)<br><p>Amount of memory available to the version, specified in bytes, multiple of 128MB.</p> <p>Acceptable values are 134217728 to 8589934592, inclusive.</p> 
versions[].<br>executionTimeout | **string**<br><p>Timeout for the execution of the version.</p> <p>If the timeout is exceeded, Cloud Functions responds with a 504 HTTP code.</p> 
versions[].<br>serviceAccountId | **string**<br><p>ID of the service account associated with the version.</p> 
versions[].<br>imageSize | **string** (int64)<br><p>Final size of the deployment package after unpacking.</p> 
versions[].<br>status | **string**<br><p>Status of the version.</p> <ul> <li>CREATING: Version is being created.</li> <li>ACTIVE: Version is ready to use.</li> <li>OBSOLETE: Version will be deleted soon.</li> <li>DELETING: Version is being deleted.</li> </ul> 
versions[].<br>tags[] | **string**<br><p>Version tags. For details, see <a href="/docs/functions/concepts/function#tag">Version tag</a>.</p> 
versions[].<br>environment | **object**<br><p>Environment settings for the version.</p> 
versions[].<br>connectivity | **object**<br><p>Network access. If specified the version will be attached to specified network/subnet(s).</p> <p>Version connectivity specification.</p> 
versions[].<br>connectivity.<br>networkId | **string**<br><p>Network the version will have access to. It's essential to specify network with subnets in all availability zones.</p> 
versions[].<br>connectivity.<br>subnetId[] | **string**<br><p>Complete list of subnets (from the same network) the version can be attached to. It's essential to specify at least one subnet for each availability zones.</p> <p>The string length in characters for each value must be greater than 0.</p> 
versions[].<br>namedServiceAccounts | **object**<br><p>Additional service accounts to be used by the version.</p> 
versions[].<br>secrets[] | **object**<br><p>Yandex Lockbox secrets to be used by the version.</p> 
versions[].<br>secrets[].<br>id | **string**<br><p>ID of Yandex Lockbox secret.</p> 
versions[].<br>secrets[].<br>versionId | **string**<br><p>ID of Yandex Lockbox version.</p> 
versions[].<br>secrets[].<br>key | **string**<br><p>Key in secret's payload, which value to be delivered into function environment.</p> 
versions[].<br>secrets[].<br>environmentVariable | **string**<br><p>environment variable in which secret's value to be delivered.</p> 
versions[].<br>logOptions | **object**<br><p>Options for logging from the function</p> 
versions[].<br>logOptions.<br>disabled | **boolean** (boolean)<br><p>Is logging from function disabled.</p> 
versions[].<br>logOptions.<br>minLevel | **string**<br>Minimum log entry level.  See [LogLevel.Level] for details.<br><ul> <li> <p>TRACE: Trace log level.</p> <p>Possible use case: verbose logging of some business logic.</p> </li> <li> <p>DEBUG: Debug log level.</p> <p>Possible use case: debugging special cases in application logic.</p> </li> <li> <p>INFO: Info log level.</p> <p>Mostly used for information messages.</p> </li> <li> <p>WARN: Warn log level.</p> <p>May be used to alert about significant events.</p> </li> <li> <p>ERROR: Error log level.</p> <p>May be used to alert about errors in infrastructure, logic, etc.</p> </li> <li> <p>FATAL: Fatal log level.</p> <p>May be used to alert about unrecoverable failures and events.</p> </li> </ul> 
versions[].<br>logOptions.<br>logGroupId | **string** <br>`versions[].logOptions` includes only one of the fields `logGroupId`, `folderId`<br><br><p>Entry should be written to log group resolved by ID.</p> <p>Value must match the regular expression ``([a-zA-Z][-a-zA-Z0-9_.]{0,63})?``.</p> 
versions[].<br>logOptions.<br>folderId | **string** <br>`versions[].logOptions` includes only one of the fields `logGroupId`, `folderId`<br><br><p>Entry should be written to default log group for specified folder.</p> <p>Value must match the regular expression ``([a-zA-Z][-a-zA-Z0-9_.]{0,63})?``.</p> 
versions[].<br>storageMounts[] | **object**<br><p>S3 mounts to be used by the version.</p> 
versions[].<br>storageMounts[].<br>bucketId | **string**<br><p>Required. S3 bucket name for mounting.</p> <p>The string length in characters must be 3-63. Value must match the regular expression ``[-.0-9a-zA-Z]*``.</p> 
versions[].<br>storageMounts[].<br>prefix | **string**<br><p>S3 bucket prefix for mounting.</p> 
versions[].<br>storageMounts[].<br>mountPointName | **string**<br><p>Required. Mount point directory name (not path) for mounting.</p> <p>The string length in characters must be 1-100. Value must match the regular expression ``[-_0-9a-zA-Z]*``.</p> 
versions[].<br>storageMounts[].<br>readOnly | **boolean** (boolean)<br><p>Is mount read only.</p> 
versions[].<br>asyncInvocationConfig | **object**<br><p>Config for asynchronous invocations of the version</p> 
versions[].<br>asyncInvocationConfig.<br>retriesCount | **string** (int64)<br><p>Number of retries of version invocation</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
versions[].<br>asyncInvocationConfig.<br>successTarget | **object**<br><p>Required. Target for successful result of the version's invocation</p> <p>Target to which a result of an invocation will be sent</p> 
versions[].<br>asyncInvocationConfig.<br>successTarget.<br>emptyTarget | **object**<br>Target to ignore a result <br>`versions[].asyncInvocationConfig.successTarget` includes only one of the fields `emptyTarget`, `ymqTarget`<br>
versions[].<br>asyncInvocationConfig.<br>successTarget.<br>ymqTarget | **object**<br>Target to send a result to ymq <br>`versions[].asyncInvocationConfig.successTarget` includes only one of the fields `emptyTarget`, `ymqTarget`<br>
versions[].<br>asyncInvocationConfig.<br>successTarget.<br>ymqTarget.<br>queueArn | **string**<br><p>Required. Queue ARN</p> 
versions[].<br>asyncInvocationConfig.<br>successTarget.<br>ymqTarget.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
versions[].<br>asyncInvocationConfig.<br>failureTarget | **object**<br><p>Required. Target for unsuccessful result, if all retries failed</p> <p>Target to which a result of an invocation will be sent</p> 
versions[].<br>asyncInvocationConfig.<br>failureTarget.<br>emptyTarget | **object**<br>Target to ignore a result <br>`versions[].asyncInvocationConfig.failureTarget` includes only one of the fields `emptyTarget`, `ymqTarget`<br>
versions[].<br>asyncInvocationConfig.<br>failureTarget.<br>ymqTarget | **object**<br>Target to send a result to ymq <br>`versions[].asyncInvocationConfig.failureTarget` includes only one of the fields `emptyTarget`, `ymqTarget`<br>
versions[].<br>asyncInvocationConfig.<br>failureTarget.<br>ymqTarget.<br>queueArn | **string**<br><p>Required. Queue ARN</p> 
versions[].<br>asyncInvocationConfig.<br>failureTarget.<br>ymqTarget.<br>serviceAccountId | **string**<br><p>Required. Service account which has write permission on the queue.</p> <p>The maximum string length in characters is 50.</p> 
versions[].<br>asyncInvocationConfig.<br>serviceAccountId | **string**<br><p>Service account which can invoke version</p> 
versions[].<br>tmpfsSize | **string** (int64)<br><p>Optional size of in-memory mounted /tmp directory in bytes.</p> 
versions[].<br>concurrency | **string** (int64)<br><p>The maximum number of requests processed by a function instance at the same time</p> <p>Acceptable values are 0 to 16, inclusive.</p> 
versions[].<br>mounts[] | **object**<br><p>Mounts to be used by the version.</p> 
versions[].<br>mounts[].<br>name | **string**<br><p>Required. Unique mount point name. Device will be mounted into /function/storage/<name></p> <p>The string length in characters must be 1-100. Value must match the regular expression ``[-_0-9a-zA-Z]*``.</p> 
versions[].<br>mounts[].<br>mode | **string**<br>Mount's mode
versions[].<br>mounts[].<br>objectStorage | **object**<br>Object storage mounts <br>`versions[].mounts[]` includes only one of the fields `objectStorage`, `ephemeralDiskSpec`<br>
versions[].<br>mounts[].<br>objectStorage.<br>bucketId | **string**<br><p>Required. ObjectStorage bucket name for mounting.</p> <p>The string length in characters must be 3-63. Value must match the regular expression ``[-.0-9a-zA-Z]*``.</p> 
versions[].<br>mounts[].<br>objectStorage.<br>prefix | **string**<br><p>ObjectStorage bucket prefix for mounting.</p> 
versions[].<br>mounts[].<br>ephemeralDiskSpec | **object**<br>Working disk (worker-local non-shared read-write NBS disk templates) <br>`versions[].mounts[]` includes only one of the fields `objectStorage`, `ephemeralDiskSpec`<br>
versions[].<br>mounts[].<br>ephemeralDiskSpec.<br>size | **string** (int64)<br><p>The size of disk for mount in bytes</p> <p>Value must be greater than 0.</p> 
versions[].<br>mounts[].<br>ephemeralDiskSpec.<br>blockSize | **string** (int64)<br><p>Optional block size of disk for mount in bytes</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/functions/functions/api-ref/Function/listVersions#query_params">pageSize</a>, use ``nextPageToken`` as the value for the <a href="/docs/functions/functions/api-ref/Function/listVersions#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``nextPageToken`` to continue paging through the results.</p> 