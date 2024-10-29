---
editable: false
sourcePath: en/_api-ref-grpc/resourcemanager/v1/api-ref/grpc/Cloud/listOperations.md
---

# Resource Manager API, gRPC: CloudService.ListOperations {#ListOperations}

Lists operations for the specified cloud.

## gRPC request

**rpc ListOperations ([ListCloudOperationsRequest](#yandex.cloud.resourcemanager.v1.ListCloudOperationsRequest)) returns ([ListCloudOperationsResponse](#yandex.cloud.resourcemanager.v1.ListCloudOperationsResponse))**

## ListCloudOperationsRequest {#yandex.cloud.resourcemanager.v1.ListCloudOperationsRequest}

```json
{
  "cloudId": "string",
  "pageSize": "int64",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| cloudId | **string**

Required field. ID of the Cloud resource to list operations for. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListCloudOperationsResponse.nextPageToken](#yandex.cloud.resourcemanager.v1.ListCloudOperationsResponse)
that can be used to get the next page of results in subsequent list requests.
Acceptable values are 0 to 1000, inclusive. Default value: 100. ||
|| pageToken | **string**

Page token. Set `pageToken`
to the [ListCloudOperationsResponse.nextPageToken](#yandex.cloud.resourcemanager.v1.ListCloudOperationsResponse)
returned by a previous list request to get the next page of results. ||
|#

## ListCloudOperationsResponse {#yandex.cloud.resourcemanager.v1.ListCloudOperationsResponse}

```json
{
  "operations": [
    {
      "id": "string",
      "description": "string",
      "createdAt": "google.protobuf.Timestamp",
      "createdBy": "string",
      "modifiedAt": "google.protobuf.Timestamp",
      "done": "bool",
      "metadata": "google.protobuf.Any",
      // Includes only one of the fields `error`, `response`
      "error": "google.rpc.Status",
      "response": "google.protobuf.Any"
      // end of the list of possible fields
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| operations[] | **[Operation](#yandex.cloud.operation.Operation)**

List of operations for the specified cloud. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListCloudOperationsRequest.pageSize](#yandex.cloud.resourcemanager.v1.ListCloudOperationsRequest), use the `nextPageToken` as the value
for the [ListCloudOperationsRequest.pageToken](#yandex.cloud.resourcemanager.v1.ListCloudOperationsRequest) query parameter in the next list request.
Each subsequent list request will have its own `nextPageToken` to continue paging through the results. ||
|#

## Operation {#yandex.cloud.operation.Operation}

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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
|| response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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