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
filter | A filter expression that filters proxies listed in the response.  The expression must specify: 1. The field name. Currently filtering can only be applied to the [Proxy.name](/docs/functions/mdbproxy/api-ref/Proxy#representation) field. 2. A conditional operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. 3. The value. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`. Example of a filter: `name=my-proxy`.  The maximum string length in characters is 1000.
 
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

        // `proxies[].target` includes only one of the fields `clickhouse`, `postgresql`
        "clickhouse": {
          "clusterId": "string",
          "user": "string",
          "password": "string",
          "db": "string",
          "endpoint": "string"
        },
        "postgresql": {
          "clusterId": "string",
          "user": "string",
          "password": "string",
          "db": "string",
          "endpoint": "string"
        },
        // end of the list of possible fields`proxies[].target`

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
proxies[].<br>name | **string**<br><p>Required. Name of the proxy.</p> <p>Value must match the regular expression ``\|[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
proxies[].<br>description | **string**<br><p>Description of the proxy.</p> 
proxies[].<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_./\@0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_./\@0-9a-z]*``.</p> 
proxies[].<br>target | **object**<br><p>MDB specific settings.</p> 
proxies[].<br>target.<br>clickhouse | **object**<br>Clickhouse settings for proxy. <br>`proxies[].target` includes only one of the fields `clickhouse`, `postgresql`<br><br>
proxies[].<br>target.<br>clickhouse.<br>clusterId | **string**<br><p>Required. Cluster identifier for clickhouse.</p> <p>The maximum string length in characters is 50.</p> 
proxies[].<br>target.<br>clickhouse.<br>user | **string**<br><p>Required. Clickhouse user.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_]*``.</p> 
proxies[].<br>target.<br>clickhouse.<br>password | **string**<br><p>Clickhouse password, input only field.</p> 
proxies[].<br>target.<br>clickhouse.<br>db | **string**<br><p>Required. Clickhouse database name.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
proxies[].<br>target.<br>clickhouse.<br>endpoint | **string**<br><p>Clickhouse proxy-host for connection, output only field.</p> 
proxies[].<br>target.<br>postgresql | **object**<br>PostgreSQL settings for proxy. <br>`proxies[].target` includes only one of the fields `clickhouse`, `postgresql`<br><br>
proxies[].<br>target.<br>postgresql.<br>clusterId | **string**<br><p>Required. Cluster identifier for postgresql.</p> <p>The maximum string length in characters is 50.</p> 
proxies[].<br>target.<br>postgresql.<br>user | **string**<br><p>Required. PostgreSQL user.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
proxies[].<br>target.<br>postgresql.<br>password | **string**<br><p>PostgreSQL password, input only field.</p> 
proxies[].<br>target.<br>postgresql.<br>db | **string**<br><p>Required. PostgreSQL database name.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
proxies[].<br>target.<br>postgresql.<br>endpoint | **string**<br><p>PostgreSQL proxy-host for connection, output only field.</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/functions/mdbproxy/api-ref/Proxy/list#query_params">pageSize</a>, use ``nextPageToken`` as the value for the <a href="/docs/functions/mdbproxy/api-ref/Proxy/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``nextPageToken`` to continue paging through the results.</p> <p>The maximum string length in characters is 100.</p> 