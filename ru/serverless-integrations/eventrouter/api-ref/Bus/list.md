---
editable: false
sourcePath: en/_api-ref/serverless/eventrouter/v1/eventrouter/api-ref/Bus/list.md
---

# EventRouter Service, REST: Bus.list
Retrieves the list of buses in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://serverless-eventrouter.{{ api-host }}/eventrouter/v1/buses
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to list buses in.</p> 
pageSize | <p>Maximum number of buses to return.</p> 
pageToken | <p>Page token. To get the next page of results, set ``page_token`` to the <a href="/docs/functions/eventrouter/api-ref/Bus/list#responses">nextPageToken</a> returned by a previous list request.</p> 
filter | <p>Supported fields for filter: name created_at</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "buses": [
    {
      "id": "string",
      "folderId": "string",
      "cloudId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "deletionProtection": true,
      "status": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
buses[] | **object**<br><p>List of buses.</p> 
buses[].<br>id | **string**<br><p>ID of the bus.</p> 
buses[].<br>folderId | **string**<br><p>ID of the folder that the bus belongs to.</p> 
buses[].<br>cloudId | **string**<br><p>ID of the cloud that the bus resides in.</p> 
buses[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
buses[].<br>name | **string**<br><p>Name of the bus.</p> 
buses[].<br>description | **string**<br><p>Description of the bus.</p> 
buses[].<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> 
buses[].<br>deletionProtection | **boolean** (boolean)<br><p>Deletion protection.</p> 
buses[].<br>status | **string**<br><p>Status of the bus.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list of buses.</p> 