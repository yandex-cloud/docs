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
revisions[] | **object**<br>
revisions[].<br>id | **string**<br>
revisions[].<br>containerId | **string**<br>
revisions[].<br>description | **string**<br>
revisions[].<br>createdAt | **string** (date-time)<br><p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
revisions[].<br>image | **object**<br>
revisions[].<br>image.<br>imageUrl | **string**<br>
revisions[].<br>image.<br>imageDigest | **string**<br>
revisions[].<br>image.<br>command | **object**<br>
revisions[].<br>image.<br>command.<br>command[] | **string**<br>
revisions[].<br>image.<br>args | **object**<br>
revisions[].<br>image.<br>args.<br>args[] | **string**<br>
revisions[].<br>image.<br>environment | **object**<br><p>Each key must match the regular expression ``[a-zA-Z][a-zA-Z0-9_]*``. The maximum string length in characters for each value is 4096.</p> 
revisions[].<br>image.<br>workingDir | **string**<br>
revisions[].<br>resources | **object**<br>
revisions[].<br>resources.<br>memory | **string** (int64)<br><p>Acceptable values are 134217728 to 8589934592, inclusive.</p> 
revisions[].<br>resources.<br>cores | **string** (int64)<br><p>Acceptable values are 0 to 1, inclusive.</p> 
revisions[].<br>resources.<br>coreFraction | **string** (int64)<br><p>Acceptable values are 0 to 100, inclusive.</p> 
revisions[].<br>executionTimeout | **string**<br>
revisions[].<br>concurrency | **string** (int64)<br>
revisions[].<br>serviceAccountId | **string**<br>
revisions[].<br>status | **string**<br>
revisions[].<br>secrets[] | **object**<br>
revisions[].<br>secrets[].<br>id | **string**<br>
revisions[].<br>secrets[].<br>versionId | **string**<br>
revisions[].<br>secrets[].<br>key | **string**<br>
revisions[].<br>secrets[].<br>environmentVariable | **string**<br>
revisions[].<br>connectivity | **object**<br>
revisions[].<br>connectivity.<br>networkId | **string**<br>
revisions[].<br>connectivity.<br>subnetIds[] | **string**<br>
revisions[].<br>provisionPolicy | **object**<br>
revisions[].<br>provisionPolicy.<br>minInstances | **string** (int64)<br>
nextPageToken | **string**<br>