---
editable: false
---

# Method list
Retrieves the list of brokers in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://iot-broker.{{ api-host }}/iot-broker/v1/brokers
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. ID of the folder to list brokers in.  To get a folder ID make a [list](/docs/resource-manager/api-ref/Folder/list) request.  The maximum string length in characters is 50.
pageSize | The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a [nextPageToken](/docs/iot-core/broker/api-ref/Broker/list#responses) that can be used to get the next page of results in subsequent list requests. Default value: 100.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. To get the next page of results, set `page_token` to the [nextPageToken](/docs/iot-core/broker/api-ref/Broker/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "brokers": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "status": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
brokers[] | **object**<br><p>A broker.</p> 
brokers[].<br>id | **string**<br><p>ID of the broker.</p> 
brokers[].<br>folderId | **string**<br><p>ID of the folder that the broker belongs to.</p> 
brokers[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
brokers[].<br>name | **string**<br><p>Name of the broker. The name is unique within the folder.</p> 
brokers[].<br>description | **string**<br><p>Description of the broker. 0-256 characters long.</p> 
brokers[].<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
brokers[].<br>status | **string**<br><p>Status of the broker.</p> <ul> <li>CREATING: Broker is being created.</li> <li>ACTIVE: Broker is ready to use.</li> <li>DELETING: Broker is being deleted.</li> </ul> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/iot-core/broker/api-ref/Broker/list#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/iot-core/broker/api-ref/Broker/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 