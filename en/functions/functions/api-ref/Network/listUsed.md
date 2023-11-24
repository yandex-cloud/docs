---
editable: false
sourcePath: en/_api-ref/serverless/functions/v1/functions/api-ref/Network/listUsed.md
---

# Cloud Functions Service, REST: Network.listUsed
Retrieves the list of networks in the specified scope that are used in serverless resources.
 

 
## HTTP request {#https-request}
```
GET https://serverless-functions.{{ api-host }}/functions/v1/networks/used
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than ``pageSize``, the service returns a <a href="/docs/functions/functions/api-ref/Network/listUsed#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>Default value: 100.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set ``pageToken`` to the <a href="/docs/functions/functions/api-ref/Network/listUsed#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
cloudId | <p>ID of the cloud to list used networks in.</p> 
folderId | <p>ID of the folder to list used networks in.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "networks": [
    {
      "networkId": "string",
      "cloudId": "string",
      "folderId": "string",
      "status": "string",
      "willBeCleanedUpAt": "string",
      "connectionsCount": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
networks[] | **object**<br><p>List of used networks in the specified scope.</p> 
networks[].<br>networkId | **string**<br><p>ID of the VPC network.</p> 
networks[].<br>cloudId | **string**<br><p>ID of the cloud that the network belongs to.</p> 
networks[].<br>folderId | **string**<br><p>ID of the folder that the network belongs to.</p> 
networks[].<br>status | **string**<br><p>Status of the network.</p> <ul> <li>CREATING: Network is connecting to its first serverless resource.</li> <li>ACTIVE: Network is already being used by some serverless resources.</li> <li>OBSOLETE: Network is no longer used by any serverless resources. It will be cleaned-up after a while.</li> </ul> 
networks[].<br>willBeCleanedUpAt | **string** (date-time)<br><p>Clean-up timestamp of the obsolete network.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
networks[].<br>connectionsCount | **string** (int64)<br><p>Number of serverless resources connected to the network.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/functions/functions/api-ref/Network/listUsed#query_params">pageSize</a>, use ``nextPageToken`` as the value for the <a href="/docs/functions/functions/api-ref/Network/listUsed#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``nextPageToken`` to continue paging through the results.</p> 