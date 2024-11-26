---
editable: false
sourcePath: en/_api-ref-grpc/mdb/mongodb/v1/api-ref/grpc/Cluster/updateHosts.md
---

# Managed Service for MongoDB API, gRPC: ClusterService.UpdateHosts

Updates the specified parameters for the host.

## gRPC request

**rpc UpdateHosts ([UpdateClusterHostsRequest](#yandex.cloud.mdb.mongodb.v1.UpdateClusterHostsRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateClusterHostsRequest {#yandex.cloud.mdb.mongodb.v1.UpdateClusterHostsRequest}

```json
{
  "cluster_id": "string",
  "update_host_specs": [
    {
      "host_name": "string",
      "hidden": "google.protobuf.BoolValue",
      "secondary_delay_secs": "google.protobuf.Int64Value",
      "priority": "google.protobuf.DoubleValue",
      "assign_public_ip": "bool",
      "update_mask": "google.protobuf.FieldMask",
      "tags": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the MongoDB cluster to update hosts from.
To get the MongoDB cluster ID, use a [ClusterService.List](/docs/managed-mongodb/api-ref/grpc/Cluster/list#List) request. ||
|| update_host_specs[] | **[UpdateHostSpec](#yandex.cloud.mdb.mongodb.v1.UpdateHostSpec)**

New configurations to apply to hosts of a Managed Service for MongoDB cluster. ||
|#

## UpdateHostSpec {#yandex.cloud.mdb.mongodb.v1.UpdateHostSpec}

#|
||Field | Description ||
|| host_name | **string**

Required field. Host to be updated. Specify the [host FQDN](https://yandex.cloud/en/docs/managed-mongodb/operations/connect/#fqdn). ||
|| hidden | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Determines if the host is a hidden replica set member.

Such members cannot become primary in a replica set, and they are invisible to client applications. However, hidden members can participate in elections of the primary host. For more information, see the [MongoDB documentation](https://www.mongodb.com/docs/manual/core/replica-set-hidden-member/). ||
|| secondary_delay_secs | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The time, in seconds, by which the given replica set member lags behind the primary host. ||
|| priority | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

Priority of the host to be elected as the primary in the replica set.

The minimum value is `0` if the Managed Service for MongoDB cluster contains three or more secondary hosts. Otherwise, the minimum value is `1`. ||
|| assign_public_ip | **bool**

Determines whether the host should get a public IP address after the update. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the MongoDB host should be updated. ||
|| tags | **string**

Host tag list that contains key-value pairs for the given replica set member. For more information about how to specify the tags and what values to choose, see the [MongoDB documentation](https://www.mongodb.com/docs/manual/reference/replica-configuration/#mongodb-rsconf-rsconf.members-n-.tags). ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "cluster_id": "string",
    "host_names": [
      "string"
    ]
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Empty"
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateClusterHostsMetadata](#yandex.cloud.mdb.mongodb.v1.UpdateClusterHostsMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**

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

## UpdateClusterHostsMetadata {#yandex.cloud.mdb.mongodb.v1.UpdateClusterHostsMetadata}

#|
||Field | Description ||
|| cluster_id | **string**

ID of the MongoDB cluster to update host from. ||
|| host_names[] | **string**

Name of host that are being updated. ||
|#