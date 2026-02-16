---
editable: false
sourcePath: en/_api-ref-grpc/apploadbalancer/v1/api-ref/grpc/LoadBalancer/removeSniMatch.md
---

# Application Load Balancer API, gRPC: LoadBalancerService.RemoveSniMatch

Deletes the specified SNI handler.

This request does not allow to delete [TlsListener.default_handler](/docs/application-load-balancer/api-ref/grpc/LoadBalancer/get#yandex.cloud.apploadbalancer.v1.TlsListener).

## gRPC request

**rpc RemoveSniMatch ([RemoveSniMatchRequest](#yandex.cloud.apploadbalancer.v1.RemoveSniMatchRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## RemoveSniMatchRequest {#yandex.cloud.apploadbalancer.v1.RemoveSniMatchRequest}

```json
{
  "load_balancer_id": "string",
  "listener_name": "string",
  "sni_match_name": "string"
}
```

#|
||Field | Description ||
|| load_balancer_id | **string**

Required field. ID of the application load balancer to remove the SNI handler from. ||
|| listener_name | **string**

Required field. Name of the listener te remove the SNI handler from. ||
|| sni_match_name | **string**

Required field. Name of the SNI handler to remove. ||
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
    "load_balancer_id": "string",
    "listener_name": "string",
    "sni_match_name": "string"
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
|| metadata | **[RemoveSniMatchMetadata](#yandex.cloud.apploadbalancer.v1.RemoveSniMatchMetadata)**

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

## RemoveSniMatchMetadata {#yandex.cloud.apploadbalancer.v1.RemoveSniMatchMetadata}

#|
||Field | Description ||
|| load_balancer_id | **string**

ID of the application load balancer that the SNI handler is being removed from. ||
|| listener_name | **string**

Name of the listener that the SNI handler is being removed from. ||
|| sni_match_name | **string**

Name of the SNI handler that is being removed. ||
|#