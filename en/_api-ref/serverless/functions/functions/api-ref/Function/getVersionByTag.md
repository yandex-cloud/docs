---
editable: false
---

# Method getVersionByTag
Returns all versions with the specified tag.
 
To get the list of all available versions, make a [listVersions](/docs/functions/functions/api-ref/Function/listVersions) request.
 
## HTTP request {#https-request}
```
GET https://serverless-functions.{{ api-host }}/functions/v1/versions:byTag
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
functionId | <p>Required. ID of the function whose versions should be listed.</p> <p>To get a function ID use a <a href="/docs/functions/functions/api-ref/Function/list">list</a> request.</p> 
tag | <p>Version tag.</p> <p>To get the history of version tags make a <a href="/docs/functions/functions/api-ref/Function/listTagHistory">listTagHistory</a> request.</p> <p>Value must match the regular expression ``[a-z][-_0-9a-z]*\|[$]latest``.</p> 
 
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
  ]
}
```
Version of a function. For details about the concept, see [Function versions](/docs/functions/concepts/function#version).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the version.</p> 
functionId | **string**<br><p>ID of the function that the version belongs to.</p> 
description | **string**<br><p>Description of the version.</p> <p>The string length in characters must be 0-256.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp for the version.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
runtime | **string**<br><p>ID of the runtime environment for the function.</p> <p>Supported environments and their identifiers are listed in the <a href="/docs/functions/concepts/runtime">Runtime environments</a>.</p> 
entrypoint | **string**<br><p>Entrypoint for the function: the name of the function to be called as the handler.</p> <p>Specified in the format ``&lt;function file name&gt;.&lt;handler name&gt;``, for example, ``index.myFunction``.</p> 
resources | **object**<br><p>Resources allocated to the version.</p> <p>Resources allocated to a version.</p> 
resources.<br>memory | **string** (int64)<br><p>Amount of memory available to the version, specified in bytes.</p> <p>Acceptable values are 134217728 to 4294967296, inclusive.</p> 
executionTimeout | **string**<br><p>Timeout for the execution of the version.</p> <p>If the timeout is exceeded, Cloud Functions responds with a 504 HTTP code.</p> 
serviceAccountId | **string**<br><p>ID of the service account associated with the version.</p> 
imageSize | **string** (int64)<br><p>Final size of the deployment package after unpacking.</p> 
status | **string**<br><p>Status of the version.</p> <ul> <li>CREATING: Version is being created.</li> <li>ACTIVE: Version is ready to use.</li> </ul> 
tags[] | **string**<br><p>Version tags. For details, see <a href="/docs/functions/concepts/function#tag">Version tag</a>.</p> 
logGroupId | **string**<br><p>ID of the log group for the version.</p> 
environment | **object**<br><p>Environment settings for the version.</p> 
connectivity | **object**<br><p>Network access. If specified the version will be attached to specified network/subnet(s).</p> <p>Version connectivity specification.</p> 
connectivity.<br>networkId | **string**<br><p>Network the version will have access to. It's essential to specify network with subnets in all availability zones.</p> 
connectivity.<br>subnetId[] | **string**<br><p>Complete list of subnets (from the same network) the version can be attached to. It's essential to specify at least one subnet for each availability zones.</p> 
namedServiceAccounts | **object**<br><p>Additional service accounts to be used by the version.</p> 
secrets[] | **object**<br><p>Lockbox secrets to be used by the version</p> 
secrets[].<br>id | **string**<br><p>ID of lockbox secret</p> 
secrets[].<br>versionId | **string**<br><p>ID of secret version</p> 
secrets[].<br>key | **string**<br><p>Key in secret's payload, which value to be delivered into function environment</p> 
secrets[].<br>environmentVariable | **string**<br><p>environment variable in which secret's value to be delivered</p> 