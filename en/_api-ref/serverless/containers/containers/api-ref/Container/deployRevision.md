---
editable: false
---

# Method deployRevision
Deploys a revision for the specified container.
 

 
## HTTP request {#https-request}
```
POST https://serverless-containers.{{ api-host }}/containers/v1/revisions:deploy
```
 
## Body parameters {#body_params}
 
```json 
{
  "containerId": "string",
  "description": "string",
  "resources": {
    "memory": "string",
    "cores": "string",
    "coreFraction": "string"
  },
  "executionTimeout": "string",
  "serviceAccountId": "string",
  "imageSpec": {
    "imageUrl": "string",
    "command": {
      "command": [
        "string"
      ]
    },
    "args": {
      "args": [
        "string"
      ]
    },
    "environment": "object",
    "workingDir": "string"
  },
  "concurrency": "string",
  "secrets": [
    {
      "id": "string",
      "versionId": "string",
      "key": "string",
      "environmentVariable": "string"
    }
  ],
  "connectivity": {
    "networkId": "string",
    "subnetIds": [
      "string"
    ]
  },
  "provisionPolicy": {
    "minInstances": "string"
  }
}
```

 
Field | Description
--- | ---
containerId | **string**<br><p>Required. ID of the container to create a revision for.</p> <p>To get a container ID, make a <a href="/docs/serverless/containers/api-ref/Container/list">list</a> request.</p> 
description | **string**<br><p>Description of the revision.</p> 
resources | **object**<br><p>Required. Resources allocated to the revision.</p> <p>Resources allocated to a revision.</p> 
resources.<br>memory | **string** (int64)<br><p>Amount of memory available to the revision, specified in bytes.</p> <p>Acceptable values are 134217728 to 8589934592, inclusive.</p> 
resources.<br>cores | **string** (int64)<br><p>Number of cores available to the revision.</p> <p>Acceptable values are 0 to 1, inclusive.</p> 
resources.<br>coreFraction | **string** (int64)<br><p>Specifies baseline performance for a core in percent.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
executionTimeout | **string**<br><p>Timeout for the execution of the revision.</p> <p>If the timeout is exceeded, Serverless Containers responds with a 504 HTTP code.</p> <p>The maximum value is 600 seconds.</p> 
serviceAccountId | **string**<br><p>ID of the service account to associate with the revision.</p> 
imageSpec | **object**<br><p>Required. Image configuration for the revision.</p> <p>Revision image specification.</p> 
imageSpec.<br>imageUrl | **string**<br><p>Required. Image URL, that is used by the revision.</p> 
imageSpec.<br>command | **object**<br><p>Override for the image's ENTRYPOINT.</p> 
imageSpec.<br>command.<br>command[] | **string**<br><p>Command that will override ENTRYPOINT of an image.</p> <p>Commands will be executed as is. The runtime will not substitute environment variables or execute shell commands. If one wants to do that, they should invoke shell interpreter with an appropriate shell script.</p> 
imageSpec.<br>args | **object**<br><p>Override for the image's CMD.</p> 
imageSpec.<br>args.<br>args[] | **string**<br><p>Arguments that will override CMD of an image.</p> <p>Arguments will be passed as is. The runtime will not substitute environment variables or execute shell commands. If one wants to do that, they should invoke shell interpreter with an appropriate shell script.</p> 
imageSpec.<br>environment | **object**<br><p>Additional environment for the container.</p> <p>Each key must match the regular expression ``[a-zA-Z][a-zA-Z0-9_]*``. The maximum string length in characters for each value is 4096.</p> 
imageSpec.<br>workingDir | **string**<br><p>Override for the image's WORKDIR.</p> 
concurrency | **string** (int64)<br><p>The number of concurrent requests allowed per container instance.</p> <p>The default value is 1.</p> 
secrets[] | **object**<br><p>Yandex Lockbox secrets to be used by the revision.</p> 
secrets[].<br>id | **string**<br><p>ID of Yandex Lockbox secret.</p> 
secrets[].<br>versionId | **string**<br><p>ID of Yandex Lockbox secret.</p> 
secrets[].<br>key | **string**<br><p>Key in secret's payload, which value to be delivered into container environment.</p> 
secrets[].<br>environmentVariable | **string**<br><p>Environment variable in which secret's value is delivered.</p> 
connectivity | **object**<br><p>Network access. If specified the revision will be attached to specified network/subnet(s).</p> <p>Revision connectivity specification.</p> 
connectivity.<br>networkId | **string**<br><p>Network the revision will have access to.</p> 
connectivity.<br>subnetIds[] | **string**<br><p>The list of subnets (from the same network) the revision can be attached to.</p> <p>Deprecated, it is sufficient to specify only network_id, without the list of subnet_ids.</p> 
provisionPolicy | **object**<br><p>Policy for provisioning instances of the revision.</p> <p>The policy is only applied when the revision is ACTIVE.</p> 
provisionPolicy.<br>minInstances | **string** (int64)<br><p>Minimum number of guaranteed provisioned container instances for all zones in total.</p> 
 
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
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 