---
editable: false
---

# Method list
Retrieves the list of proxies in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://serverless-mdbproxy.api.cloud.yandex.net/mdbproxy/v1/proxies
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. ID of the folder to list proxies in.  To get a folder ID make a [list](/docs/resource-manager/api-ref/Folder/list) request.  The maximum string length in characters is 50.
pageSize | The maximum number of results per page to return. If the number of available results is larger than `pageSize`, the service returns a [nextPageToken](/docs/functions/mdbproxy/api-ref/Proxy/list#responses) that can be used to get the next page of results in subsequent list requests.  Default value: 100.  Acceptable values are 0 to 1000, inclusive.
pageToken | Page token. To get the next page of results, set `pageToken` to the [nextPageToken](/docs/functions/mdbproxy/api-ref/Proxy/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "proxies": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "target": {
        "postgresql": {
          "clusterId": "string",
          "user": "string",
          "password": "string",
          "db": "string",
          "endpoint": "string"
        }
      }
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
proxies[] | **object**<br><p>List of proxies in the specified folder.</p> 
proxies[].<br>id | **string**<br><p>ID of the proxy.</p> 
proxies[].<br>folderId | **string**<br><p>Required. ID of the folder that the proxy belongs to.</p> <p>The maximum string length in characters is 50.</p> 
proxies[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp for the proxy.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
proxies[].<br>name | **string**<br><p>Required. Name of the proxy.</p> <p>Value must match the regular expression `` \|[a-z][-a-z0-9]{1,61}[a-z0-9] ``.</p> 
proxies[].<br>description | **string**<br><p>Description of the proxy.</p> 
proxies[].<br>labels | **object**<br><p>Resource labels as `key:value` pairs.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression `` [a-z][-<em>./@0-9a-z]* ``. The maximum string length in characters for each value is 63. Each value must match the regular expression `` [-</em>./@0-9a-z]* ``.</p> 
proxies[].<br>target | **object**<br><p>MDB specific settings.</p> 
proxies[].<br>target.<br>postgresql | **object**<br>PostgreSQL settings for proxy.<br>
proxies[].<br>target.<br>postgresql.<br>clusterId | **string**<br><p>Required. Cluster identifier for postgresql.</p> <p>The maximum string length in characters is 50.</p> 
proxies[].<br>target.<br>postgresql.<br>user | **string**<br><p>Required. PostgreSQL user.</p> <p>The maximum string length in characters is 63. Value must match the regular expression `` [a-zA-Z0-9_]* ``.</p> 
proxies[].<br>target.<br>postgresql.<br>password | **string**<br><p>PostgreSQL password, input only field.</p> 
proxies[].<br>target.<br>postgresql.<br>db | **string**<br><p>Required. PostgreSQL database name.</p> <p>The maximum string length in characters is 63. Value must match the regular expression `` [a-zA-Z0-9_-]* ``.</p> 
proxies[].<br>target.<br>postgresql.<br>endpoint | **string**<br><p>PostgreSQL proxy-host for connection, output only field.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/functions/mdbproxy/api-ref/Proxy/list#query_params">pageSize</a>, use `nextPageToken` as the value for the <a href="/docs/functions/mdbproxy/api-ref/Proxy/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own `nextPageToken` to continue paging through the results.</p> <p>The maximum string length in characters is 100.</p> 