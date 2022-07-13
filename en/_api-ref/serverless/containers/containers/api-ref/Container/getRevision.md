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
id | **string**
containerId | **string**
description | **string**
createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
image | **object**
image.<br>imageUrl | **string**
image.<br>imageDigest | **string**
image.<br>command | **object**
image.<br>command.<br>command[] | **string**
image.<br>args | **object**
image.<br>args.<br>args[] | **string**
image.<br>environment | **object**<br><p>Each key must match the regular expression ``[a-zA-Z][a-zA-Z0-9_]*``. The maximum string length in characters for each value is 4096.</p> 
image.<br>workingDir | **string**
resources | **object**
resources.<br>memory | **string** (int64)<br><p>Acceptable values are 134217728 to 8589934592, inclusive.</p> 
resources.<br>cores | **string** (int64)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
resources.<br>coreFraction | **string** (int64)<br><p>Acceptable values are 0 to 100, inclusive.</p> 
executionTimeout | **string**
concurrency | **string** (int64)
serviceAccountId | **string**
status | **string**
secrets[] | **object**
secrets[].<br>id | **string**
secrets[].<br>versionId | **string**
secrets[].<br>key | **string**
secrets[].<br>environmentVariable | **string**
connectivity | **object**
connectivity.<br>networkId | **string**
connectivity.<br>subnetIds[] | **string**
provisionPolicy | **object**
provisionPolicy.<br>minInstances | **string** (int64)