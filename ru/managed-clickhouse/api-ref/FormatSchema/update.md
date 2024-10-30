---
editable: false
sourcePath: en/_api-ref/mdb/clickhouse/v1/api-ref/FormatSchema/update.md
---

# Managed Service for ClickHouse API, REST: FormatSchema.Update {#Update}

Changes a format schema.

## HTTP request

```
PATCH https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{clusterId}/formatSchemas/{formatSchemaName}
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

## Body parameters {#yandex.cloud.mdb.clickhouse.v1.UpdateFormatSchemaRequest}

```json
{
  "updateMask": "string",
  "uri": "string"
}
```

#|
||Field | Description ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| uri | **string**

[Link to the file](/docs/managed-clickhouse/operations/s3-access#get-link-to-object) of a format schema in Yandex Object Storage. Managed Service for ClickHouse works only with format schemas imported to Object Storage. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "clusterId": "string",
    "formatSchemaName": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "name": "string",
    "clusterId": "string",
    "type": "string",
    "uri": "string"
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateFormatSchemaMetadata](#yandex.cloud.mdb.clickhouse.v1.UpdateFormatSchemaMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[FormatSchema](#yandex.cloud.mdb.clickhouse.v1.FormatSchema)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## UpdateFormatSchemaMetadata {#yandex.cloud.mdb.clickhouse.v1.UpdateFormatSchemaMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ClickHouse cluster ID. ||
|| formatSchemaName | **string**

Format schema name. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
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