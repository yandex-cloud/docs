---
editable: false
---

# Method get
Returns the specified proxy.
 
To get the list of all available proxies, make a [list](/docs/functions/mdbproxy/api-ref/Proxy/list) request.
 
## HTTP request {#https-request}
```
GET https://serverless-mdbproxy.{{ api-host }}/mdbproxy/v1/proxies/{proxyId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
proxyId | <p>Required. ID of the proxy to return.</p> <p>To get a proxy ID make a <a href="/docs/functions/mdbproxy/api-ref/Proxy/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "target": {

    // `target` includes only one of the fields `clickhouse`, `postgresql`
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
    // end of the list of possible fields`target`

  }
}
```

 
Field | Description
--- | ---
id | **string**<br><p>ID of the proxy.</p> 
folderId | **string**<br><p>Required. ID of the folder that the proxy belongs to.</p> <p>The maximum string length in characters is 50.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp for the proxy.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Required. Name of the proxy.</p> <p>Value must match the regular expression ``\|[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
description | **string**<br><p>Description of the proxy.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_./\@0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_./\@0-9a-z]*``.</p> 
target | **object**<br><p>MDB specific settings.</p> 
target.<br>clickhouse | **object**<br>Clickhouse settings for proxy. <br>`target` includes only one of the fields `clickhouse`, `postgresql`<br>
target.<br>clickhouse.<br>clusterId | **string**<br><p>Required. Cluster identifier for clickhouse.</p> <p>The maximum string length in characters is 50.</p> 
target.<br>clickhouse.<br>user | **string**<br><p>Required. Clickhouse user.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_]*``.</p> 
target.<br>clickhouse.<br>password | **string**<br><p>Clickhouse password, input only field.</p> 
target.<br>clickhouse.<br>db | **string**<br><p>Required. Clickhouse database name.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
target.<br>clickhouse.<br>endpoint | **string**<br><p>Clickhouse proxy-host for connection, output only field.</p> 
target.<br>postgresql | **object**<br>PostgreSQL settings for proxy. <br>`target` includes only one of the fields `clickhouse`, `postgresql`<br>
target.<br>postgresql.<br>clusterId | **string**<br><p>Required. Cluster identifier for postgresql.</p> <p>The maximum string length in characters is 50.</p> 
target.<br>postgresql.<br>user | **string**<br><p>Required. PostgreSQL user.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
target.<br>postgresql.<br>password | **string**<br><p>PostgreSQL password, input only field.</p> 
target.<br>postgresql.<br>db | **string**<br><p>Required. PostgreSQL database name.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
target.<br>postgresql.<br>endpoint | **string**<br><p>PostgreSQL proxy-host for connection, output only field.</p> 