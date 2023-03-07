---
editable: false
sourcePath: en/_api-ref/serverless/containers/containers/api-ref/Container/getRevision.md
---

# Serverless Containers Service, REST: Container.getRevision
Returns the specified revision of a container.
 
To get the list of available revision, make a [listRevisions](/docs/serverless/containers/api-ref/Container/listRevisions) request.
 
## HTTP request {#https-request}
```
GET https://serverless-containers.{{ api-host }}/containers/v1/revisions/{containerRevisionId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
containerRevisionId | <p>Required. ID of the revision to return.</p> <p>To get a revision ID make a <a href="/docs/serverless/containers/api-ref/Container/listRevisions">listRevisions</a> request.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "containerId": "string",
  "description": "string",
  "createdAt": "string",
  "image": {
    "imageUrl": "string",
    "imageDigest": "string",
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
  "resources": {
    "memory": "string",
    "cores": "string",
    "coreFraction": "string"
  },
  "executionTimeout": "string",
  "concurrency": "string",
  "serviceAccountId": "string",
  "status": "string",
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
  },
  "scalingPolicy": {
    "zoneInstancesLimit": "string",
    "zoneRequestsLimit": "string"
  },
  "logOptions": {
    "disabled": true,
    "minLevel": "string",

    // `logOptions` includes only one of the fields `logGroupId`, `folderId`
    "logGroupId": "string",
    "folderId": "string",
    // end of the list of possible fields`logOptions`

  }
}
```

 
Field | Description
--- | ---
id | **string**<br><p>ID of the revision.</p> 
containerId | **string**<br><p>ID of the container that the revision belongs to.</p> 
description | **string**<br><p>Description of the revision.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp for the revision.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
image | **object**<br><p>Image configuration for the revision.</p> <p>Revision image specification.</p> 
image.<br>imageUrl | **string**<br><p>Image URL, that is used by the revision.</p> 
image.<br>imageDigest | **string**<br><p>Digest of the image. Calculated at creation time.</p> 
image.<br>command | **object**<br><p>Override for the image's ENTRYPOINT.</p> 
image.<br>command.<br>command[] | **string**<br><p>Command that will override ENTRYPOINT of an image.</p> <p>Commands will be executed as is. The runtime will not substitute environment variables or execute shell commands. If one wants to do that, they should invoke shell interpreter with an appropriate shell script.</p> 
image.<br>args | **object**<br><p>Override for the image's CMD.</p> 
image.<br>args.<br>args[] | **string**<br><p>Arguments that will override CMD of an image.</p> <p>Arguments will be passed as is. The runtime will not substitute environment variables or execute shell commands. If one wants to do that, they should invoke shell interpreter with an appropriate shell script.</p> 
image.<br>environment | **object**<br><p>Additional environment for the container.</p> <p>Each key must match the regular expression ``[a-zA-Z][a-zA-Z0-9_]*``. The maximum string length in characters for each value is 4096.</p> 
image.<br>workingDir | **string**<br><p>Override for the image's WORKDIR.</p> 
resources | **object**<br><p>Resources allocated to the revision.</p> <p>Resources allocated to a revision.</p> 
resources.<br>memory | **string** (int64)<br><p>Amount of memory available to the revision, specified in bytes.</p> <p>Acceptable values are 134217728 to 4294967296, inclusive.</p> 
resources.<br>cores | **string** (int64)<br><p>Number of cores available to the revision.</p> <p>Acceptable values are 0 to 1, inclusive.</p> 
resources.<br>coreFraction | **string** (int64)<br><p>Specifies baseline performance for a core in percent.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
executionTimeout | **string**<br><p>Timeout for the execution of the revision.</p> <p>If the timeout is exceeded, Serverless Containers responds with a 504 HTTP code.</p> 
concurrency | **string** (int64)<br><p>The number of concurrent requests allowed per container instance.</p> 
serviceAccountId | **string**<br><p>ID of the service account associated with the revision.</p> 
status | **string**<br><p>Status of the revision.</p> <ul> <li>CREATING: Revision is being created.</li> <li>ACTIVE: Revision is currently used by the container.</li> <li>OBSOLETE: Revision is not used by the container. May be deleted later.</li> </ul> 
secrets[] | **object**<br><p>Yandex Lockbox secrets to be used by the revision.</p> 
secrets[].<br>id | **string**<br><p>ID of Yandex Lockbox secret.</p> 
secrets[].<br>versionId | **string**<br><p>ID of Yandex Lockbox secret.</p> 
secrets[].<br>key | **string**<br><p>Key in secret's payload, which value to be delivered into container environment.</p> 
secrets[].<br>environmentVariable | **string**<br><p>Environment variable in which secret's value is delivered.</p> 
connectivity | **object**<br><p>Network access. If specified the revision will be attached to specified network/subnet(s).</p> <p>Revision connectivity specification.</p> 
connectivity.<br>networkId | **string**<br><p>Network the revision will have access to.</p> 
connectivity.<br>subnetIds[] | **string**<br><p>The list of subnets (from the same network) the revision can be attached to.</p> <p>Deprecated, it is sufficient to specify only network_id, without the list of subnet_ids.</p> <p>The string length in characters for each value must be greater than 0.</p> 
provisionPolicy | **object**<br><p>Policy for provisioning instances of the revision.</p> <p>The policy is only applied when the revision is ACTIVE.</p> 
provisionPolicy.<br>minInstances | **string** (int64)<br><p>Minimum number of guaranteed provisioned container instances for all zones in total.</p> 
scalingPolicy | **object**<br><p>Policy for scaling instances of the revision.</p> 
scalingPolicy.<br>zoneInstancesLimit | **string** (int64)<br><p>Upper limit for instance count in each zone. 0 means no limit.</p> 
scalingPolicy.<br>zoneRequestsLimit | **string** (int64)<br><p>Upper limit of requests count in each zone. 0 means no limit.</p> 
logOptions | **object**<br><p>Options for logging from the container.</p> 
logOptions.<br>disabled | **boolean** (boolean)<br><p>Is logging from container disabled.</p> 
logOptions.<br>minLevel | **string**<br>Minimum log entry level.  See [LogLevel.Level] for details.<br><ul> <li> <p>TRACE: Trace log level.</p> <p>Possible use case: verbose logging of some business logic.</p> </li> <li> <p>DEBUG: Debug log level.</p> <p>Possible use case: debugging special cases in application logic.</p> </li> <li> <p>INFO: Info log level.</p> <p>Mostly used for information messages.</p> </li> <li> <p>WARN: Warn log level.</p> <p>May be used to alert about significant events.</p> </li> <li> <p>ERROR: Error log level.</p> <p>May be used to alert about errors in infrastructure, logic, etc.</p> </li> <li> <p>FATAL: Fatal log level.</p> <p>May be used to alert about unrecoverable failures and events.</p> </li> </ul> 
logOptions.<br>logGroupId | **string** <br>`logOptions` includes only one of the fields `logGroupId`, `folderId`<br><br><p>Entry should be written to log group resolved by ID.</p> <p>Value must match the regular expression ``([a-zA-Z][-a-zA-Z0-9_.]{0,63})?``.</p> 
logOptions.<br>folderId | **string** <br>`logOptions` includes only one of the fields `logGroupId`, `folderId`<br><br><p>Entry should be written to default log group for specified folder.</p> <p>Value must match the regular expression ``([a-zA-Z][-a-zA-Z0-9_.]{0,63})?``.</p> 