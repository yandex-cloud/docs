---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/workload/workload-identity/api-ref/grpc/FederatedCredential/create.md
---

# Workload Identity, gRPC: FederatedCredentialService.Create

Creates a federated credential for the specified service account.

## gRPC request

**rpc Create ([CreateFederatedCredentialRequest](#yandex.cloud.iam.v1.workload.CreateFederatedCredentialRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateFederatedCredentialRequest {#yandex.cloud.iam.v1.workload.CreateFederatedCredentialRequest}

```json
{
  "service_account_id": "string",
  "federation_id": "string",
  "external_subject_id": "string"
}
```

#|
||Field | Description ||
|| service_account_id | **string**

Required field. ID of the service account to create a federated credential for.
To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/ServiceAccount/list#List) request. ||
|| federation_id | **string**

Required field. ID of the workload identity federation that is used for authentication. ||
|| external_subject_id | **string**

Required field. Id of the external subject. ||
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
    "federated_credential_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "service_account_id": "string",
    "federation_id": "string",
    "external_subject_id": "string",
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
|| metadata | **[CreateFederatedCredentialMetadata](#yandex.cloud.iam.v1.workload.CreateFederatedCredentialMetadata)**

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
|| response | **[FederatedCredential](#yandex.cloud.iam.v1.workload.FederatedCredential)**

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

## CreateFederatedCredentialMetadata {#yandex.cloud.iam.v1.workload.CreateFederatedCredentialMetadata}

#|
||Field | Description ||
|| federated_credential_id | **string**

ID of the federated credential that is being created. ||
|#

## FederatedCredential {#yandex.cloud.iam.v1.workload.FederatedCredential}

A federated credential.

#|
||Field | Description ||
|| id | **string**

Id of the federated credential. ||
|| service_account_id | **string**

Id of the service account that the federated credential belongs to. ||
|| federation_id | **string**

ID of the workload identity federation which is used for authentication. ||
|| external_subject_id | **string**

Id of the external subject. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|#