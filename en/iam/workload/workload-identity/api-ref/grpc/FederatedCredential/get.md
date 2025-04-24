---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/workload/workload-identity/api-ref/grpc/FederatedCredential/get.md
---

# Workload Identity, gRPC: FederatedCredentialService.Get

Returns the specified federated credential.

To get the list of available federated credentials, make a [List](/docs/iam/workload/workload-identity/api-ref/grpc/FederatedCredential/list#List) request.

## gRPC request

**rpc Get ([GetFederatedCredentialRequest](#yandex.cloud.iam.v1.workload.GetFederatedCredentialRequest)) returns ([FederatedCredential](#yandex.cloud.iam.v1.workload.FederatedCredential))**

## GetFederatedCredentialRequest {#yandex.cloud.iam.v1.workload.GetFederatedCredentialRequest}

```json
{
  "federated_credential_id": "string"
}
```

#|
||Field | Description ||
|| federated_credential_id | **string**

Required field. ID of the federated credential to return.
To get the federated credential ID, make a [FederatedCredentialService.List](/docs/iam/workload/workload-identity/api-ref/grpc/FederatedCredential/list#List) request. ||
|#

## FederatedCredential {#yandex.cloud.iam.v1.workload.FederatedCredential}

```json
{
  "id": "string",
  "service_account_id": "string",
  "federation_id": "string",
  "external_subject_id": "string",
  "created_at": "google.protobuf.Timestamp"
}
```

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