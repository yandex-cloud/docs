---
editable: false
sourcePath: en/_api-ref/mdb/clickhouse/v1/api-ref/FormatSchema/index.md
---

# Managed Service for ClickHouse API, REST: FormatSchema methods
A set of methods for managing [format schemas](https://clickhouse.com/docs/en/interfaces/formats) for input and output data.
## JSON Representation {#representation}
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

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Adds a format schema to a cluster.
[delete](delete.md) | Deletes a format schema from a cluster.
[get](get.md) | Returns detailed information about a given format schema.
[list](list.md) | Returns a list of format schemas in a cluster.
[update](update.md) | Changes a format schema.