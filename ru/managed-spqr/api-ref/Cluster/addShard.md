---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-spqr/v1/clusters/{clusterId}/shards
    method: post
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the SPQR cluster to add a shard to.
            To get the cluster ID, use a [ClusterService.List](/docs/managed-spqr/api-ref/Cluster/list#List) request.
          type: string
      required:
        - clusterId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        shardSpec:
          description: |-
            **[ShardSpec](#yandex.cloud.mdb.spqr.v1.ShardSpec)**
            Required field. Properties of the shard to be created.
          $ref: '#/definitions/ShardSpec'
      required:
        - shardSpec
      additionalProperties: false
    definitions:
      MDBPostgreSQL:
        type: object
        properties:
          clusterId:
            description: |-
              **string**
              Required field. 
            type: string
        required:
          - clusterId
      ShardSpec:
        type: object
        properties:
          shardName:
            description: |-
              **string**
              Required field. Name of the SPQR shard to create.
            pattern: ^[a-zA-Z0-9][a-zA-Z0-9-]*$
            type: string
          mdbPostgresql:
            description: |-
              **[MDBPostgreSQL](#yandex.cloud.mdb.spqr.v1.MDBPostgreSQL)**
              Properties of the MDB PostgreSQL cluster
              Includes only one of the fields `mdbPostgresql`.
            $ref: '#/definitions/MDBPostgreSQL'
        required:
          - shardName
        oneOf:
          - required:
              - mdbPostgresql
---

# Managed Service for SPQR API, REST: Cluster.AddShard

Creates a new shard.

## HTTP request

```
POST https://{{ api-host-mdb }}/managed-spqr/v1/clusters/{clusterId}/shards
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the SPQR cluster to add a shard to.
To get the cluster ID, use a [ClusterService.List](/docs/managed-spqr/api-ref/Cluster/list#List) request. ||
|#

## Body parameters {#yandex.cloud.mdb.spqr.v1.AddClusterShardRequest}

```json
{
  "shardSpec": {
    "shardName": "string",
    // Includes only one of the fields `mdbPostgresql`
    "mdbPostgresql": {
      "clusterId": "string"
    }
    // end of the list of possible fields
  }
}
```

#|
||Field | Description ||
|| shardSpec | **[ShardSpec](#yandex.cloud.mdb.spqr.v1.ShardSpec)**

Required field. Properties of the shard to be created. ||
|#

## ShardSpec {#yandex.cloud.mdb.spqr.v1.ShardSpec}

#|
||Field | Description ||
|| shardName | **string**

Required field. Name of the SPQR shard to create. ||
|| mdbPostgresql | **[MDBPostgreSQL](#yandex.cloud.mdb.spqr.v1.MDBPostgreSQL)**

Properties of the MDB PostgreSQL cluster

Includes only one of the fields `mdbPostgresql`. ||
|#

## MDBPostgreSQL {#yandex.cloud.mdb.spqr.v1.MDBPostgreSQL}

TODO move to hosts.proto when it's created
Configuration for MDB PostgreSQL host

#|
||Field | Description ||
|| clusterId | **string**

Required field.  ||
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
    "shardName": "string"
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
    "clusterId": "string"
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
|| metadata | **[AddClusterShardMetadata](#yandex.cloud.mdb.spqr.v1.AddClusterShardMetadata)**

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
|| response | **[Shard](#yandex.cloud.mdb.spqr.v1.Shard)**

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

## AddClusterShardMetadata {#yandex.cloud.mdb.spqr.v1.AddClusterShardMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the SPQR cluster that a shard is being added to. ||
|| shardName | **string**

Name of the shard being added. ||
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

## Shard {#yandex.cloud.mdb.spqr.v1.Shard}

#|
||Field | Description ||
|| name | **string**

Name of the shard. ||
|| clusterId | **string**

ID of the cluster that the shard belongs to. ||
|#