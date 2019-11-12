---
editable: false
---

# Method get

 

 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/{clusterId}/mlModels/{mlModelName}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. The maximum string length in characters is 50.
mlModelName | Required. The maximum string length in characters is 63. Value must match the regular expression `` [a-zA-Z0-9_-]* ``.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "name": "string",
  "clusterId": "string",
  "type": "string",
  "uri": "string"
}
```

 
Field | Description
--- | ---
name | **string**<br>
clusterId | **string**<br>
type | **string**<br>
uri | **string**<br>