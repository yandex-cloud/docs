---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{clusterId}/shardGroups:batchUpdate
    method: post
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the ClickHouse cluster that contains the shard groups to update.
            The maximum string length in characters is 50.
          type: string
      required:
        - clusterId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        shardGroupSpecs:
          description: |-
            **[UpdateShardGroupSpec](#yandex.cloud.mdb.clickhouse.v1.UpdateShardGroupSpec)**
            Updates of the shard groups.
            The number of elements must be greater than 0.
          type: array
          items:
            $ref: '#/definitions/UpdateShardGroupSpec'
      additionalProperties: false
    definitions:
      Replica:
        type: object
        properties:
          host:
            description: |-
              **string**
              Required field. Name (FQDN) or IP address of the external replica host. Identifies the replica within the external shard.
            type: string
          updateMask:
            description: |-
              **string** (field-mask)
              A comma-separated names off ALL fields to be updated.
              Only the specified fields will be changed. The others will be left untouched.
              If the field is specified in `` updateMask `` and no value for that field was sent in the request,
              the field's value will be reset to the default. The default value for most fields is null or 0.
              If `` updateMask `` is not sent in the request, all fields' values will be updated.
              Fields specified in the request will be updated to provided values.
              The rest of the fields will be reset to the default.
            type: string
            format: field-mask
          port:
            description: |-
              **string** (int64)
              Port to connect to the external replica. If not specified, the default ClickHouse port is used.
            type: string
            format: int64
          secure:
            description: |-
              **boolean**
              Whether to use a secure (SSL/TLS) connection when connecting to the external replica.
            type: boolean
          user:
            description: |-
              **string**
              Name of the user to authenticate with on the external replica.
            type: string
          password:
            description: |-
              **string**
              Password of the user to authenticate with on the external replica.
            type: string
          priority:
            description: |-
              **string** (int64)
              Priority of the external replica for load balancing.
            type: string
            format: int64
        required:
          - host
      ExternalShard:
        type: object
        properties:
          name:
            description: |-
              **string**
              Name of the external shard.
            type: string
          weight:
            description: |-
              **string** (int64)
              Relative weight of the external shard considered when writing data to the cluster.
              For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/operations/table_engines/distributed/).
            type: string
            format: int64
          replicas:
            description: |-
              **[Replica](#yandex.cloud.mdb.clickhouse.v1.UpdateShardGroupSpec.ExternalShard.Replica)**
              List of replicas contained in the external shard.
            type: array
            items:
              $ref: '#/definitions/Replica'
      UpdateShardGroupSpec:
        type: object
        properties:
          shardGroupName:
            description: |-
              **string**
              Required field. Name of the shard group that should be updated.
              The maximum string length in characters is 63.
            type: string
          updateMask:
            description: |-
              **string** (field-mask)
              A comma-separated names off ALL fields to be updated.
              Only the specified fields will be changed. The others will be left untouched.
              If the field is specified in `` updateMask `` and no value for that field was sent in the request,
              the field's value will be reset to the default. The default value for most fields is null or 0.
              If `` updateMask `` is not sent in the request, all fields' values will be updated.
              Fields specified in the request will be updated to provided values.
              The rest of the fields will be reset to the default.
            type: string
            format: field-mask
          shardNames:
            description: |-
              **string**
              Updated list of shard names that belongs to the shard group.
            type: array
            items:
              type: string
          externalShardSpecs:
            description: |-
              **[ExternalShard](/docs/managed-clickhouse/api-ref/Cluster/getShardGroup#yandex.cloud.mdb.clickhouse.v1.ExternalShard)**
              External shards of the shard group.
            type: array
            items:
              $ref: '#/definitions/ExternalShard'
          description:
            description: |-
              **string**
              Updated description of the shard group.
            type: string
        required:
          - shardGroupName
alternate:
  - href: en/managed-clickhouse/api-ref/Cluster/updateShardGroups.md
    type: text/markdown
    title: Markdown version
---

# Managed Service for ClickHouse API, REST: Cluster.UpdateShardGroups

Updates the specified shard groups.


## HTTP request

```
POST https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{clusterId}/shardGroups:batchUpdate
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the ClickHouse cluster that contains the shard groups to update.

The maximum string length in characters is 50. ||
|#

## Body parameters {#yandex.cloud.mdb.clickhouse.v1.UpdateClusterShardGroupsRequest}

```json
{
  "shardGroupSpecs": [
    {
      "shardGroupName": "string",
      "updateMask": "string",
      "shardNames": [
        "string"
      ],
      "externalShardSpecs": [
        {
          "name": "string",
          "updateMask": "string",
          "weight": "string",
          "replicaSpecs": [
            {
              "host": "string",
              "updateMask": "string",
              "port": "string",
              "secure": "boolean",
              "user": "string",
              "password": "string",
              "priority": "string"
            }
          ]
        }
      ],
      "description": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| shardGroupSpecs[] | **[UpdateShardGroupSpec](#yandex.cloud.mdb.clickhouse.v1.UpdateShardGroupSpec)**

Updates of the shard groups.

The number of elements must be greater than 0. ||
|#

## UpdateShardGroupSpec {#yandex.cloud.mdb.clickhouse.v1.UpdateShardGroupSpec}

#|
||Field | Description ||
|| shardGroupName | **string**

Required field. Name of the shard group that should be updated.

The maximum string length in characters is 63. ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| shardNames[] | **string**

Updated list of shard names that belongs to the shard group. ||
|| externalShardSpecs[] | **[ExternalShard](#yandex.cloud.mdb.clickhouse.v1.UpdateShardGroupSpec.ExternalShard)**

External shards of the shard group. ||
|| description | **string**

Updated description of the shard group. ||
|#

## ExternalShard {#yandex.cloud.mdb.clickhouse.v1.UpdateShardGroupSpec.ExternalShard}

#|
||Field | Description ||
|| name | **string**

Required field. Name of the external shard. Identifies the external shard within the shard group. ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| weight | **string** (int64)

Relative weight of the external shard considered when writing data to the cluster. ||
|| replicaSpecs[] | **[Replica](#yandex.cloud.mdb.clickhouse.v1.UpdateShardGroupSpec.ExternalShard.Replica)**

Replicas of the external shard. ||
|#

## Replica {#yandex.cloud.mdb.clickhouse.v1.UpdateShardGroupSpec.ExternalShard.Replica}

#|
||Field | Description ||
|| host | **string**

Required field. Name (FQDN) or IP address of the external replica host. Identifies the replica within the external shard. ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| port | **string** (int64)

Port to connect to the external replica. If not specified, the default ClickHouse port is used. ||
|| secure | **boolean**

Whether to use a secure (SSL/TLS) connection when connecting to the external replica. ||
|| user | **string**

Name of the user to authenticate with on the external replica. ||
|| password | **string**

Password of the user to authenticate with on the external replica. ||
|| priority | **string** (int64)

Priority of the external replica for load balancing. ||
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
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
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
|| metadata | **object**

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
|| response | **object**

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