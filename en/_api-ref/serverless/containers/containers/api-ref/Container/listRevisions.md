---
editable: false
---

# Method listRevisions

 

 
## HTTP request {#https-request}
```
GET https://serverless-containers.{{ api-host }}/containers/v1/revisions
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | 
containerId | 
pageSize | <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>The maximum string length in characters is 100.</p> 
filter | <p>The maximum string length in characters is 1000.</p> 
 
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
      }
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
revisions[] | **object**
revisions[].<br>id | **string**
revisions[].<br>containerId | **string**
revisions[].<br>description | **string**
revisions[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
revisions[].<br>image | **object**
revisions[].<br>image.<br>imageUrl | **string**
revisions[].<br>image.<br>imageDigest | **string**
revisions[].<br>image.<br>command | **object**
revisions[].<br>image.<br>command.<br>command[] | **string**
revisions[].<br>image.<br>args | **object**
revisions[].<br>image.<br>args.<br>args[] | **string**
revisions[].<br>image.<br>environment | **object**<br><p>Each key must match the regular expression ``[a-zA-Z][a-zA-Z0-9_]*``. The maximum string length in characters for each value is 4096.</p> 
revisions[].<br>image.<br>workingDir | **string**
revisions[].<br>resources | **object**
revisions[].<br>resources.<br>memory | **string** (int64)<br><p>Acceptable values are 134217728 to 8589934592, inclusive.</p> 
revisions[].<br>resources.<br>cores | **string** (int64)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
revisions[].<br>resources.<br>coreFraction | **string** (int64)<br><p>Acceptable values are 0 to 100, inclusive.</p> 
revisions[].<br>executionTimeout | **string**
revisions[].<br>concurrency | **string** (int64)
revisions[].<br>serviceAccountId | **string**
revisions[].<br>status | **string**
revisions[].<br>secrets[] | **object**
revisions[].<br>secrets[].<br>id | **string**
revisions[].<br>secrets[].<br>versionId | **string**
revisions[].<br>secrets[].<br>key | **string**
revisions[].<br>secrets[].<br>environmentVariable | **string**
revisions[].<br>connectivity | **object**
revisions[].<br>connectivity.<br>networkId | **string**
revisions[].<br>connectivity.<br>subnetIds[] | **string**
revisions[].<br>provisionPolicy | **object**
revisions[].<br>provisionPolicy.<br>minInstances | **string** (int64)
nextPageToken | **string**