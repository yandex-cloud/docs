---
editable: false
---

# Method getRevision

 

 
## HTTP request {#https-request}
```
GET https://serverless-containers.{{ api-host }}/containers/v1/revisions/{containerRevisionId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
containerRevisionId | <p>Required.</p> 
 
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
  }
}
```

 
Field | Description
--- | ---
id | **string**<br>
containerId | **string**<br>
description | **string**<br>
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
image | **object**<br>
image.<br>imageUrl | **string**<br>
image.<br>imageDigest | **string**<br>
image.<br>command | **object**<br>
image.<br>command.<br>command[] | **string**<br>
image.<br>args | **object**<br>
image.<br>args.<br>args[] | **string**<br>
image.<br>environment | **object**<br><p>Each key must match the regular expression ``[a-zA-Z][a-zA-Z0-9_]*``. The maximum string length in characters for each value is 4096.</p> 
image.<br>workingDir | **string**<br>
resources | **object**<br>
resources.<br>memory | **string** (int64)<br><p>Acceptable values are 134217728 to 8589934592, inclusive.</p> 
resources.<br>cores | **string** (int64)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
resources.<br>coreFraction | **string** (int64)<br><p>Acceptable values are 0 to 100, inclusive.</p> 
executionTimeout | **string**<br>
concurrency | **string** (int64)<br>
serviceAccountId | **string**<br>
status | **string**<br>
secrets[] | **object**<br>
secrets[].<br>id | **string**<br>
secrets[].<br>versionId | **string**<br>
secrets[].<br>key | **string**<br>
secrets[].<br>environmentVariable | **string**<br>
connectivity | **object**<br>
connectivity.<br>networkId | **string**<br>
connectivity.<br>subnetIds[] | **string**<br>
provisionPolicy | **object**<br>
provisionPolicy.<br>minInstances | **string** (int64)<br>