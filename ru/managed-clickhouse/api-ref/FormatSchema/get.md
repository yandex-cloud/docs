---
editable: false
sourcePath: en/_api-ref/mdb/clickhouse/v1/api-ref/FormatSchema/get.md
---

# Managed Service for ClickHouse API, REST: FormatSchema.get
Returns detailed information about a given format schema.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{clusterId}/formatSchemas/{formatSchemaName}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ClickHouse cluster ID.</p> <p>To get a ClickHouse cluster ID, use the <a href="/docs/managed-clickhouse/api-ref/Cluster/list">list</a> method.</p> <p>The maximum string length in characters is 50.</p> 
formatSchemaName | <p>Required. Format schema name.</p> <p>To get a format schema name, use the <a href="/docs/managed-clickhouse/api-ref/FormatSchema/list">list</a> method.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
 
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
name | **string**<br><p>Format schema name.</p> 
clusterId | **string**<br><p>ClickHouse cluster ID.</p> 
type | **string**<br><p>Schema type. Possible values are the following:</p> <ul> <li>FORMAT_SCHEMA_TYPE_PROTOBUF - <a href="https://protobuf.dev/">Protobuf</a> data format (including <a href="https://clickhouse.com/docs/en/interfaces/formats#protobufsingle">ProtobufSingle</a>).</li> <li>FORMAT_SCHEMA_TYPE_CAPNPROTO - <a href="https://capnproto.org/">Cap'n Proto</a> data format.</li> </ul> 
uri | **string**<br><p>Link to the file of a format schema in Yandex Object Storage. Managed Service for ClickHouse works only with format schemas imported to Object Storage.</p> 