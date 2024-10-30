---
editable: false
sourcePath: en/_api-ref-grpc/mdb/clickhouse/v1/api-ref/grpc/FormatSchema/get.md
---

# Managed Service for ClickHouse API, gRPC: FormatSchemaService.Get {#Get}

Returns detailed information about a given format schema.

## gRPC request

**rpc Get ([GetFormatSchemaRequest](#yandex.cloud.mdb.clickhouse.v1.GetFormatSchemaRequest)) returns ([FormatSchema](#yandex.cloud.mdb.clickhouse.v1.FormatSchema))**

## GetFormatSchemaRequest {#yandex.cloud.mdb.clickhouse.v1.GetFormatSchemaRequest}

```json
{
  "clusterId": "string",
  "formatSchemaName": "string"
}
```

#|
||Field | Description ||
|| clusterId | **string**

Required field. ClickHouse cluster ID.

To get a ClickHouse cluster ID, use the [ClusterService.List](/docs/managed-clickhouse/api-ref/grpc/Cluster/list#List) method. ||
|| formatSchemaName | **string**

Required field. Format schema name.

To get a format schema name, use the [FormatSchemaService.List](/docs/managed-clickhouse/api-ref/grpc/FormatSchema/list#List) method. ||
|#

## FormatSchema {#yandex.cloud.mdb.clickhouse.v1.FormatSchema}

```json
{
  "name": "string",
  "clusterId": "string",
  "type": "FormatSchemaType",
  "uri": "string"
}
```

#|
||Field | Description ||
|| name | **string**

Format schema name. ||
|| clusterId | **string**

ClickHouse cluster ID. ||
|| type | enum **FormatSchemaType**

Schema type. Possible values are the following:

* FORMAT_SCHEMA_TYPE_PROTOBUF - [Protobuf](https://protobuf.dev/) data format (including [ProtobufSingle](https://clickhouse.com/docs/en/interfaces/formats#protobufsingle)).
* FORMAT_SCHEMA_TYPE_CAPNPROTO - [Cap'n Proto](https://capnproto.org/) data format.

- `FORMAT_SCHEMA_TYPE_UNSPECIFIED`
- `FORMAT_SCHEMA_TYPE_PROTOBUF`
- `FORMAT_SCHEMA_TYPE_CAPNPROTO` ||
|| uri | **string**

Link to the file of a format schema in Yandex Object Storage. Managed Service for ClickHouse works only with format schemas imported to Object Storage. ||
|#