---
editable: false
sourcePath: en/_api-ref/mdb/clickhouse/v1/api-ref/FormatSchema/get.md
---

# Managed Service for ClickHouse API, REST: FormatSchema.get

 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{clusterId}/formatSchemas/{formatSchemaName}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. The maximum string length in characters is 50.</p> 
formatSchemaName | <p>Required. The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
 
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
name | **string**
clusterId | **string**
type | **string**
uri | **string**