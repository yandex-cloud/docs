---
editable: false
sourcePath: en/_api-ref-grpc/cdn/v1/api-ref/grpc/Shielding/activate.md
---

# Cloud CDN API, gRPC: ShieldingService.Activate

Activate shielding for a resource.

## gRPC request

**rpc Activate ([ActivateShieldingRequest](#yandex.cloud.cdn.v1.ActivateShieldingRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## ActivateShieldingRequest {#yandex.cloud.cdn.v1.ActivateShieldingRequest}

```json
{
  "resource_id": "string",
  "location_id": "int64"
}
```

Request to activate shielding for a specific resource.

#|
||Field | Description ||
|| resource_id | **string**

Required field. ID of the resource to activate shielding for. ||
|| location_id | **int64**

ID of the location to activate shielding in, allowing selection of a suitable geographical location. ||
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
    "resource_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "location_id": "int64",
    "data_center": "string",
    "country": "string",
    "city": "string"
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
|| metadata | **[ActivateShieldingMetadata](#yandex.cloud.cdn.v1.ActivateShieldingMetadata)**

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
|| response | **[ShieldingDetails](#yandex.cloud.cdn.v1.ShieldingDetails)**

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

## ActivateShieldingMetadata {#yandex.cloud.cdn.v1.ActivateShieldingMetadata}

Metadata for shielding activation, detailing the operations performed.

#|
||Field | Description ||
|| resource_id | **string**

Required field. ID of the resource for which shielding is being activated. ||
|#

## ShieldingDetails {#yandex.cloud.cdn.v1.ShieldingDetails}

Message representing the details of a shielding server.

#|
||Field | Description ||
|| location_id | **int64**

Unique identifier for the geographical location of the shielding server. ||
|| data_center | **string**

Name of the data center where the shielding server is located. ||
|| country | **string**

Country where the shielding server's data center is located, useful for understanding geographical distribution. ||
|| city | **string**

City where the shielding server's data center is situated, providing a more precise location than just the country. ||
|#