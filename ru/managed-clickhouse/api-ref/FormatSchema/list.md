---
editable: false
sourcePath: en/_api-ref/mdb/clickhouse/v1/api-ref/FormatSchema/list.md
---

# Managed Service for ClickHouse API, REST: FormatSchema.List {#List}

Returns a list of format schemas in a cluster.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{clusterId}/formatSchemas
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ClickHouse cluster ID.

To get a ClickHouse cluster ID, use the [ClusterService.List](/docs/managed-clickhouse/api-ref/Cluster/list#List) method. ||
|#

## Query parameters {#yandex.cloud.mdb.clickhouse.v1.ListFormatSchemasRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of the results is larger than `pageSize`, the service returns [ListFormatSchemasResponse.nextPageToken](#yandex.cloud.mdb.clickhouse.v1.ListFormatSchemasResponse). You can use it to get the next page of the results in subsequent requests of a format schema list. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the [ListFormatSchemasResponse.nextPageToken](#yandex.cloud.mdb.clickhouse.v1.ListFormatSchemasResponse) returned by the previous format schema list request. ||
|#

## Response {#yandex.cloud.mdb.clickhouse.v1.ListFormatSchemasResponse}

**HTTP Code: 200 - OK**

```json
{
  "formatSchemas": [
    {
      "name": "string",
      "clusterId": "string",
      "type": "string",
      "uri": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| formatSchemas[] | **[FormatSchema](#yandex.cloud.mdb.clickhouse.v1.FormatSchema)**

List of format schemas. ||
|| nextPageToken | **string**

This token allows you to get the next page of results when requesting the format schema list. If the number of the results is larger than [ListFormatSchemasRequest.pageSize](#yandex.cloud.mdb.clickhouse.v1.ListFormatSchemasRequest), use the `nextPageToken` as the value for the [ListFormatSchemasRequest.pageToken](#yandex.cloud.mdb.clickhouse.v1.ListFormatSchemasRequest) parameter in the next request. Each subsequent request will have its own `nextPageToken` to continue paging through the results. ||
|#

## FormatSchema {#yandex.cloud.mdb.clickhouse.v1.FormatSchema}

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