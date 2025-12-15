---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/saml/api-ref/grpc/Federation/suspendUserAccounts.md
---

# SAML Federation API, gRPC: FederationService.SuspendUserAccounts

Suspend federated user accounts.
Method skips non-existent federated user accounts and returns ones that were actually suspended.

## gRPC request

**rpc SuspendUserAccounts ([SuspendFederatedUserAccountsRequest](#yandex.cloud.organizationmanager.v1.saml.SuspendFederatedUserAccountsRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## SuspendFederatedUserAccountsRequest {#yandex.cloud.organizationmanager.v1.saml.SuspendFederatedUserAccountsRequest}

```json
{
  "federation_id": "string",
  "subject_ids": [
    "string"
  ],
  "reason": "string"
}
```

#|
||Field | Description ||
|| federation_id | **string**

Required field. ID of the federation to suspend users of.

The maximum string length in characters is 50. ||
|| subject_ids[] | **string**

List of subjects to suspend.

The number of elements must be in the range 1-1000. The string length in characters for each value must be 1-50. ||
|| reason | **string**

Reason of the suspension

The maximum string length in characters is 256. ||
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
    "federation_id": "string",
    "subject_ids": [
      "string"
    ],
    "reason": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "subject_ids": [
      "string"
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[SuspendFederatedUserAccountsMetadata](#yandex.cloud.organizationmanager.v1.saml.SuspendFederatedUserAccountsMetadata)**

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
|| response | **[SuspendFederatedUserAccountsResponse](#yandex.cloud.organizationmanager.v1.saml.SuspendFederatedUserAccountsResponse)**

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

## SuspendFederatedUserAccountsMetadata {#yandex.cloud.organizationmanager.v1.saml.SuspendFederatedUserAccountsMetadata}

#|
||Field | Description ||
|| federation_id | **string**

ID of the federation to suspend subjects of. ||
|| subject_ids[] | **string**

List of subjects to suspend. ||
|| reason | **string**

Reason of the suspension. ||
|#

## SuspendFederatedUserAccountsResponse {#yandex.cloud.organizationmanager.v1.saml.SuspendFederatedUserAccountsResponse}

#|
||Field | Description ||
|| subject_ids[] | **string**

Subjects that were actually suspended. ||
|#