---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/workload/oidc/workload-identity/api-ref/grpc/Federation/update.md
---

# Federation, gRPC: FederationService.Update

Updates the specified OIDC workload identity federation.

## gRPC request

**rpc Update ([UpdateFederationRequest](#yandex.cloud.iam.v1.workload.oidc.UpdateFederationRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateFederationRequest {#yandex.cloud.iam.v1.workload.oidc.UpdateFederationRequest}

```json
{
  "federation_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "disabled": "bool",
  "audiences": [
    "string"
  ],
  "jwks_url": "string",
  "labels": "map<string, string>"
}
```

#|
||Field | Description ||
|| federation_id | **string**

Required field. ID of the OIDC workload identity federation to update.
To get the OIDC workload identity federation ID, make a [FederationService.List](/docs/iam/workload-identity/api-ref/grpc/Federation/list#List) request. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the OIDC workload identity federation are going to be updated. ||
|| name | **string**

Name of the OIDC workload identity federation.
The name must be unique within the folder. ||
|| description | **string**

Description of the OIDC workload identity federation. ||
|| disabled | **bool**

True - the OIDC workload identity federation is disabled and cannot be used for authentication.
False - the OIDC workload identity federation is enabled and can be used for authentication. ||
|| audiences[] | **string**

List of trusted values for aud claim. ||
|| jwks_url | **string**

URL reference to trusted keys in format of JSON Web Key Set. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `` key:value `` pairs ||
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
    "federation_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "name": "string",
    "folder_id": "string",
    "description": "string",
    "enabled": "bool",
    "audiences": [
      "string"
    ],
    "issuer": "string",
    "jwks_url": "string",
    "labels": "map<string, string>",
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
|| metadata | **[UpdateFederationMetadata](#yandex.cloud.iam.v1.workload.oidc.UpdateFederationMetadata)**

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
|| response | **[Federation](#yandex.cloud.iam.v1.workload.oidc.Federation)**

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

## UpdateFederationMetadata {#yandex.cloud.iam.v1.workload.oidc.UpdateFederationMetadata}

#|
||Field | Description ||
|| federation_id | **string**

ID of the OIDC workload identity federation that is being updated. ||
|#

## Federation {#yandex.cloud.iam.v1.workload.oidc.Federation}

A OIDC workload identity federation.

#|
||Field | Description ||
|| id | **string**

Id of the OIDC workload identity federation. ||
|| name | **string**

Name of the OIDC workload identity federation
The name is unique within the folder. 3-63 characters long. ||
|| folder_id | **string**

ID of the folder that the OIDC workload identity federation belongs to. ||
|| description | **string**

Description of the service account. 0-256 characters long. ||
|| enabled | **bool**

True - the OIDC workload identity federation is enabled and can be used for authentication.
False - the OIDC workload identity federation is disabled and cannot be used for authentication. ||
|| audiences[] | **string**

List of trusted values for aud claim. ||
|| issuer | **string**

URL of the external IdP server to be used for authentication. ||
|| jwks_url | **string**

URL reference to trusted keys in format of JSON Web Key Set. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `` key:value `` pairs ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|#