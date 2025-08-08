---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-elasticsearch/v1/clusters/{clusterId}/hosts:batchCreate
    method: post
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the Elasticsearch cluster.
            To get the Elasticsearch cluster ID, make a [ClusterService.List](/docs/managed-elasticsearch/api-ref/Cluster/list#List) request.
          type: string
      required:
        - clusterId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        hostSpecs:
          description: |-
            **[HostSpec](/docs/managed-elasticsearch/api-ref/Cluster/create#yandex.cloud.mdb.elasticsearch.v1.HostSpec)**
            One or more configurations of hosts to be added to the Elasticsearch cluster.
          type: array
          items:
            $ref: '#/definitions/HostSpec'
      additionalProperties: false
    definitions:
      HostSpec:
        type: object
        properties:
          zoneId:
            description: |-
              **string**
              ID of the availability zone where the host resides.
            type: string
          subnetId:
            description: |-
              **string**
              ID of the subnet the host resides in.
            type: string
          assignPublicIp:
            description: |-
              **boolean**
              The flag that defines whether a public IP address is assigned to the host.
              If the value is `true`, then this host is available on the Internet via it's public IP address.
            type: boolean
          type:
            description: |-
              **enum** (Type)
              Required field. Host type.
              - `TYPE_UNSPECIFIED`: Host type is unspecified. Default value.
              - `DATA_NODE`: The host is an Elasticsearch data node.
              - `MASTER_NODE`: The host is an Elasticsearch master node.
            type: string
            enum:
              - TYPE_UNSPECIFIED
              - DATA_NODE
              - MASTER_NODE
          shardName:
            description: |-
              **string**
              The shard name to create on the host.
            pattern: '[a-zA-Z0-9_-]*'
            type: string
        required:
          - type
sourcePath: en/_api-ref/mdb/elasticsearch/v1/api-ref/Cluster/addHosts.md
---

# Managed Service for Elasticsearch API, REST: Cluster.AddHosts

Adds new hosts to the specified Elasticsearch cluster.

## HTTP request

```
POST https://{{ api-host-mdb }}/managed-elasticsearch/v1/clusters/{clusterId}/hosts:batchCreate
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Elasticsearch cluster.

To get the Elasticsearch cluster ID, make a [ClusterService.List](/docs/managed-elasticsearch/api-ref/Cluster/list#List) request. ||
|#

## Body parameters {#yandex.cloud.mdb.elasticsearch.v1.AddClusterHostsRequest}

```json
{
  "hostSpecs": [
    {
      "zoneId": "string",
      "subnetId": "string",
      "assignPublicIp": "boolean",
      "type": "string",
      "shardName": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| hostSpecs[] | **[HostSpec](#yandex.cloud.mdb.elasticsearch.v1.HostSpec)**

One or more configurations of hosts to be added to the Elasticsearch cluster. ||
|#

## HostSpec {#yandex.cloud.mdb.elasticsearch.v1.HostSpec}

#|
||Field | Description ||
|| zoneId | **string**

ID of the availability zone where the host resides. ||
|| subnetId | **string**

ID of the subnet the host resides in. ||
|| assignPublicIp | **boolean**

The flag that defines whether a public IP address is assigned to the host.

If the value is `true`, then this host is available on the Internet via it's public IP address. ||
|| type | **enum** (Type)

Required field. Host type.

- `TYPE_UNSPECIFIED`: Host type is unspecified. Default value.
- `DATA_NODE`: The host is an Elasticsearch data node.
- `MASTER_NODE`: The host is an Elasticsearch master node. ||
|| shardName | **string**

The shard name to create on the host. ||
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
    "hostNames": [
      "string"
    ]
  },
  // Includes only one of the fields `error`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
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
|| metadata | **[AddClusterHostsMetadata](#yandex.cloud.mdb.elasticsearch.v1.AddClusterHostsMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## AddClusterHostsMetadata {#yandex.cloud.mdb.elasticsearch.v1.AddClusterHostsMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the Elasticsearch cluster. ||
|| hostNames[] | **string**

Names of the host that are being added. ||
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