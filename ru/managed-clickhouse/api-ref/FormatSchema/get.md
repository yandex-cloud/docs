---
editable: false
sourcePath: en/_api-ref/mdb/clickhouse/v1/api-ref/FormatSchema/get.md
---

# Managed Service for ClickHouse API, REST: FormatSchema.Get {#Get}

Returns detailed information about a given format schema.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{clusterId}/formatSchemas/{formatSchemaName}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ClickHouse cluster ID.

To get a ClickHouse cluster ID, use the [ClusterService.List](/docs/managed-clickhouse/api-ref/Cluster/list#List) method. ||
|| formatSchemaName | **string**

Required field. Format schema name.

To get a format schema name, use the [FormatSchemaService.List](/docs/managed-clickhouse/api-ref/FormatSchema/list#List) method. ||
|#

## Response {#yandex.cloud.mdb.clickhouse.v1.FormatSchema}

**HTTP Code: 200 - OK**

```json
{
  "name": "string",
  "clusterId": "string",
  "type": "string",
  "uri": "string"
}
```

#|
||Field | Description ||
|| name | **string**

Format schema name. ||
|| clusterId | **string**

ClickHouse cluster ID. ||
|| type | **enum** (FormatSchemaType)

Schema type. Possible values are the following:

* FORMAT_SCHEMA_TYPE_PROTOBUF - [Protobuf](https://protobuf.dev/) data format (including [ProtobufSingle](https://clickhouse.com/docs/en/interfaces/formats#protobufsingle)).
* FORMAT_SCHEMA_TYPE_CAPNPROTO - [Cap'n Proto](https://capnproto.org/) data format.

- `FORMAT_SCHEMA_TYPE_UNSPECIFIED`
- `FORMAT_SCHEMA_TYPE_PROTOBUF`
- `FORMAT_SCHEMA_TYPE_CAPNPROTO` ||
|| uri | **string**

Link to the file of a format schema in Yandex Object Storage. Managed Service for ClickHouse works only with format schemas imported to Object Storage. ||
|#