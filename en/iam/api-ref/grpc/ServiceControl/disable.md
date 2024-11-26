---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/api-ref/grpc/ServiceControl/disable.md
---

# Identity and Access Management API, gRPC: ServiceControlService.Disable

Disable a service in the specified resource container.

## gRPC request

**rpc Disable ([DisableServiceRequest](#yandex.cloud.iam.v1.DisableServiceRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## DisableServiceRequest {#yandex.cloud.iam.v1.DisableServiceRequest}

```json
{
  "service_id": "string",
  "resource": {
    "id": "string",
    "type": "string"
  }
}
```

#|
||Field | Description ||
|| service_id | **string**

Required field. ID of the Service. ||
|| resource | **[Resource](#yandex.cloud.iam.v1.Resource)**

Required field. Resource container to disable a service in.

It is supported only resource-manager.cloud resource container now. ||
|#

## Resource {#yandex.cloud.iam.v1.Resource}

A Resource. For more information, see [Resource](/docs/iam/concepts/access-control/resources-with-access-control).

#|
||Field | Description ||
|| id | **string**

Required field. ID of the resource. ||
|| type | **string**

Required field. The type of the resource, e.g. resource-manager.folder, billing.account, compute.snapshot, etc. ||
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
    "service_id": "string",
    "resource": {
      "id": "string",
      "type": "string"
    }
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "service_id": "string",
    "resource": {
      "id": "string",
      "type": "string"
    },
    "updated_at": "google.protobuf.Timestamp",
    "status": "Status"
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
|| metadata | **[DisableServiceMetadata](#yandex.cloud.iam.v1.DisableServiceMetadata)**

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
|| response | **[Service](#yandex.cloud.iam.v1.Service)**

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

## DisableServiceMetadata {#yandex.cloud.iam.v1.DisableServiceMetadata}

#|
||Field | Description ||
|| service_id | **string**

ID of the Service. ||
|| resource | **[Resource](#yandex.cloud.iam.v1.Resource2)**

Resource container. ||
|#

## Resource {#yandex.cloud.iam.v1.Resource2}

A Resource. For more information, see [Resource](/docs/iam/concepts/access-control/resources-with-access-control).

#|
||Field | Description ||
|| id | **string**

Required field. ID of the resource. ||
|| type | **string**

Required field. The type of the resource, e.g. resource-manager.folder, billing.account, compute.snapshot, etc. ||
|#

## Service {#yandex.cloud.iam.v1.Service}

A Service.

#|
||Field | Description ||
|| service_id | **string**

ID of the service. ||
|| resource | **[Resource](#yandex.cloud.iam.v1.Resource2)**

Resource that the service belongs to. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time of the last status update of the service. ||
|| status | enum **Status**

Current status of the service.

- `STATUS_UNSPECIFIED`
- `ENABLED`: The service is enabled.
- `PAUSED`: The service is paused.
- `DISABLED`: The service is disabled.
- `ENABLING`: The service is being enabled.
- `RESUMING`: The service is being resumed.
- `PAUSING`: The service is being paused.
- `DISABLING`: The service is being disabled.
- `ERROR`: The service is in error state.
- `DEFAULT`: The service could be auto enabled. ||
|#