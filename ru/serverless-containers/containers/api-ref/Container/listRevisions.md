---
editable: false
sourcePath: en/_api-ref/serverless/containers/v1/containers/api-ref/Container/listRevisions.md
---

# Serverless Containers Service, REST: Container.listRevisions
Retrieves the list of revisions for the specified container, or of all container revisions
in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://serverless-containers.{{ api-host }}/containers/v1/revisions
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>ID of the folder to list container revisions for. To get a folder ID make a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> 
containerId | <p>ID of the container to list revisions for. To get a container ID use a <a href="/docs/serverless/containers/api-ref/Container/list">list</a> request.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than ``pageSize``, the service returns a <a href="/docs/serverless/containers/api-ref/Container/listRevisions#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>Default value: 100.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token. To get the next page of results, set ``pageToken`` to the <a href="/docs/serverless/containers/api-ref/Container/listRevisions#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters resources listed in the response.</p> <p>The expression must specify:</p> <ol> <li>The field name. Currently filtering can only be applied to the ``status`` and [Revision.runtime] fields.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``). Must be 3-63 characters long and match the regular expression ``[a-z][-a-z0-9]{1,61}[a-z0-9]``. Example of a filter: ``status="ACTIVE"``.</li> </ol> <p>The maximum string length in characters is 1000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "revisions": [
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

        // `revisions[].logOptions` includes only one of the fields `logGroupId`, `folderId`
        "logGroupId": "string",
        "folderId": "string",
        // end of the list of possible fields`revisions[].logOptions`

      },
      "storageMounts": [
        {
          "bucketId": "string",
          "prefix": "string",
          "readOnly": true,
          "mountPointPath": "string"
        }
      ]
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
revisions[] | **object**<br><p>List of revisions for the specified folder or container.</p> 
revisions[].<br>id | **string**<br><p>ID of the revision.</p> 
revisions[].<br>containerId | **string**<br><p>ID of the container that the revision belongs to.</p> 
revisions[].<br>description | **string**<br><p>Description of the revision.</p> 
revisions[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp for the revision.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
revisions[].<br>image | **object**<br><p>Image configuration for the revision.</p> <p>Revision image specification.</p> 
revisions[].<br>image.<br>imageUrl | **string**<br><p>Image URL, that is used by the revision.</p> 
revisions[].<br>image.<br>imageDigest | **string**<br><p>Digest of the image. Calculated at creation time.</p> 
revisions[].<br>image.<br>command | **object**<br><p>Override for the image's ENTRYPOINT.</p> 
revisions[].<br>image.<br>command.<br>command[] | **string**<br><p>Command that will override ENTRYPOINT of an image.</p> <p>Commands will be executed as is. The runtime will not substitute environment variables or execute shell commands. If one wants to do that, they should invoke shell interpreter with an appropriate shell script.</p> 
revisions[].<br>image.<br>args | **object**<br><p>Override for the image's CMD.</p> 
revisions[].<br>image.<br>args.<br>args[] | **string**<br><p>Arguments that will override CMD of an image.</p> <p>Arguments will be passed as is. The runtime will not substitute environment variables or execute shell commands. If one wants to do that, they should invoke shell interpreter with an appropriate shell script.</p> 
revisions[].<br>image.<br>environment | **object**<br><p>Additional environment for the container.</p> <p>Each key must match the regular expression ``[a-zA-Z][a-zA-Z0-9_]*``. The maximum string length in characters for each value is 4096.</p> 
revisions[].<br>image.<br>workingDir | **string**<br><p>Override for the image's WORKDIR.</p> 
revisions[].<br>resources | **object**<br><p>Resources allocated to the revision.</p> <p>Resources allocated to a revision.</p> 
revisions[].<br>resources.<br>memory | **string** (int64)<br><p>Amount of memory available to the revision, specified in bytes.</p> <p>Acceptable values are 134217728 to 4294967296, inclusive.</p> 
revisions[].<br>resources.<br>cores | **string** (int64)<br><p>Number of cores available to the revision.</p> <p>Acceptable values are 0 to 1, inclusive.</p> 
revisions[].<br>resources.<br>coreFraction | **string** (int64)<br><p>Specifies baseline performance for a core in percent.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
revisions[].<br>executionTimeout | **string**<br><p>Timeout for the execution of the revision.</p> <p>If the timeout is exceeded, Serverless Containers responds with a 504 HTTP code.</p> 
revisions[].<br>concurrency | **string** (int64)<br><p>The number of concurrent requests allowed per container instance.</p> 
revisions[].<br>serviceAccountId | **string**<br><p>ID of the service account associated with the revision.</p> 
revisions[].<br>status | **string**<br><p>Status of the revision.</p> <ul> <li>CREATING: Revision is being created.</li> <li>ACTIVE: Revision is currently used by the container.</li> <li>OBSOLETE: Revision is not used by the container. May be deleted later.</li> </ul> 
revisions[].<br>secrets[] | **object**<br><p>Yandex Lockbox secrets to be used by the revision.</p> 
revisions[].<br>secrets[].<br>id | **string**<br><p>ID of Yandex Lockbox secret.</p> 
revisions[].<br>secrets[].<br>versionId | **string**<br><p>ID of Yandex Lockbox secret.</p> 
revisions[].<br>secrets[].<br>key | **string**<br><p>Key in secret's payload, which value to be delivered into container environment.</p> 
revisions[].<br>secrets[].<br>environmentVariable | **string**<br><p>Environment variable in which secret's value is delivered.</p> 
revisions[].<br>connectivity | **object**<br><p>Network access. If specified the revision will be attached to specified network/subnet(s).</p> <p>Revision connectivity specification.</p> 
revisions[].<br>connectivity.<br>networkId | **string**<br><p>Network the revision will have access to.</p> 
revisions[].<br>connectivity.<br>subnetIds[] | **string**<br><p>The list of subnets (from the same network) the revision can be attached to.</p> <p>Deprecated, it is sufficient to specify only network_id, without the list of subnet_ids.</p> <p>The string length in characters for each value must be greater than 0.</p> 
revisions[].<br>provisionPolicy | **object**<br><p>Policy for provisioning instances of the revision.</p> <p>The policy is only applied when the revision is ACTIVE.</p> 
revisions[].<br>provisionPolicy.<br>minInstances | **string** (int64)<br><p>Minimum number of guaranteed provisioned container instances for all zones in total.</p> 
revisions[].<br>scalingPolicy | **object**<br><p>Policy for scaling instances of the revision.</p> 
revisions[].<br>scalingPolicy.<br>zoneInstancesLimit | **string** (int64)<br><p>Upper limit for instance count in each zone. 0 means no limit.</p> 
revisions[].<br>scalingPolicy.<br>zoneRequestsLimit | **string** (int64)<br><p>Upper limit of requests count in each zone. 0 means no limit.</p> 
revisions[].<br>logOptions | **object**<br><p>Options for logging from the container.</p> 
revisions[].<br>logOptions.<br>disabled | **boolean** (boolean)<br><p>Is logging from container disabled.</p> 
revisions[].<br>logOptions.<br>minLevel | **string**<br>Minimum log entry level.  See [LogLevel.Level] for details.<br><ul> <li> <p>TRACE: Trace log level.</p> <p>Possible use case: verbose logging of some business logic.</p> </li> <li> <p>DEBUG: Debug log level.</p> <p>Possible use case: debugging special cases in application logic.</p> </li> <li> <p>INFO: Info log level.</p> <p>Mostly used for information messages.</p> </li> <li> <p>WARN: Warn log level.</p> <p>May be used to alert about significant events.</p> </li> <li> <p>ERROR: Error log level.</p> <p>May be used to alert about errors in infrastructure, logic, etc.</p> </li> <li> <p>FATAL: Fatal log level.</p> <p>May be used to alert about unrecoverable failures and events.</p> </li> </ul> 
revisions[].<br>logOptions.<br>logGroupId | **string** <br>`revisions[].logOptions` includes only one of the fields `logGroupId`, `folderId`<br><br><p>Entry should be written to log group resolved by ID.</p> <p>Value must match the regular expression ``([a-zA-Z][-a-zA-Z0-9_.]{0,63})?``.</p> 
revisions[].<br>logOptions.<br>folderId | **string** <br>`revisions[].logOptions` includes only one of the fields `logGroupId`, `folderId`<br><br><p>Entry should be written to default log group for specified folder.</p> <p>Value must match the regular expression ``([a-zA-Z][-a-zA-Z0-9_.]{0,63})?``.</p> 
revisions[].<br>storageMounts[] | **object**<br><p>S3 mounts to be used by the version.</p> 
revisions[].<br>storageMounts[].<br>bucketId | **string**<br><p>Required. S3 bucket name for mounting.</p> <p>The string length in characters must be 3-63. Value must match the regular expression ``[-.0-9a-zA-Z]*``.</p> 
revisions[].<br>storageMounts[].<br>prefix | **string**<br><p>S3 bucket prefix for mounting.</p> 
revisions[].<br>storageMounts[].<br>readOnly | **boolean** (boolean)<br><p>Is mount read only.</p> 
revisions[].<br>storageMounts[].<br>mountPointPath | **string**<br><p>Required. Mount point path inside the container for mounting.</p> <p>The string length in characters must be 1-300. Value must match the regular expression ``[-_0-9a-zA-Z/]*``.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/serverless/containers/api-ref/Container/listRevisions#query_params">pageSize</a>, use ``nextPageToken`` as the value for the <a href="/docs/serverless/containers/api-ref/Container/listRevisions#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``nextPageToken`` to continue paging through the results.</p> 