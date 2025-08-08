---
editable: false
sourcePath: en/_api-ref-grpc/baremetal/v1alpha/api-ref/grpc/PrivateCloudConnection/create.md
---

# BareMetal API, gRPC: PrivateCloudConnectionService.Create

Creates a private cloud connection in the specified folder.

## gRPC request

**rpc Create ([CreatePrivateCloudConnectionRequest](#yandex.cloud.baremetal.v1alpha.CreatePrivateCloudConnectionRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreatePrivateCloudConnectionRequest {#yandex.cloud.baremetal.v1alpha.CreatePrivateCloudConnectionRequest}

```json
{
  "routing_instance_id": "string",
  "vrf_id": "string"
}
```

#|
||Field | Description ||
|| routing_instance_id | **string**

ID of Cloud Router Routing Instance. ||
|| vrf_id | **string**

ID of VRF that is connected to routing Instance.

To get the VRF ID, use a [VrfService.List](/docs/baremetal/api-ref/grpc/Vrf/list#List) request. ||
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
    "private_cloud_connection_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folder_id": "string",
    "cloud_id": "string",
    "routing_instance_id": "string",
    "vrf_id": "string",
    "status": "Status",
    "name": "string",
    "created_at": "google.protobuf.Timestamp"
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreatePrivateCloudConnectionMetadata](#yandex.cloud.baremetal.v1alpha.CreatePrivateCloudConnectionMetadata)**

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
|| response | **[PrivateCloudConnection](#yandex.cloud.baremetal.v1alpha.PrivateCloudConnection)**

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

## CreatePrivateCloudConnectionMetadata {#yandex.cloud.baremetal.v1alpha.CreatePrivateCloudConnectionMetadata}

#|
||Field | Description ||
|| private_cloud_connection_id | **string**

ID of the private cloud connection that is being created. ||
|#

## PrivateCloudConnection {#yandex.cloud.baremetal.v1alpha.PrivateCloudConnection}

A Private cloud connection resource.

#|
||Field | Description ||
|| id | **string**

ID of the private cloud connection. ||
|| folder_id | **string**

ID of the folder that the private cloud connection belongs to. ||
|| cloud_id | **string**

ID of the cloud that the private cloud connection belongs to. ||
|| routing_instance_id | **string**

ID of Cloud Router Routing Instance. ||
|| vrf_id | **string**

ID of VRF that is connected to routing Instance. ||
|| status | enum **Status**

Status of the private cloud connection.

- `STATUS_UNSPECIFIED`: Unspecified private cloud connection status.
- `CREATING`: Private cloud connection is waiting for network resources to be allocated.
- `READY`: Private cloud connection is ready to use.
- `ERROR`: Private cloud connection encountered a problem and cannot operate.
- `DELETING`: Private cloud connection is being deleted.
- `UPDATING`: Private cloud connection is being updated. ||
|| name | **string**

Name of the private cloud connection. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|#