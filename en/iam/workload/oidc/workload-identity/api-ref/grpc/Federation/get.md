---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/workload/oidc/workload-identity/api-ref/grpc/Federation/get.md
---

# Federation, gRPC: FederationService.Get {#Get}

Returns the specified OIDC workload identity federation.

To get the list of available OIDC workload identity federation, make a [List](/docs/iam/workload-identity/api-ref/grpc/Federation/list#List) request.

## gRPC request

**rpc Get ([GetFederationRequest](#yandex.cloud.iam.v1.workload.oidc.GetFederationRequest)) returns ([Federation](#yandex.cloud.iam.v1.workload.oidc.Federation))**

## GetFederationRequest {#yandex.cloud.iam.v1.workload.oidc.GetFederationRequest}

```json
{
  "federationId": "string"
}
```

#|
||Field | Description ||
|| federationId | **string**

Required field. ID of the OIDC workload identity federation to return.
To get the OIDC workload identity federation ID, make a [FederationService.List](/docs/iam/workload-identity/api-ref/grpc/Federation/list#List) request. ||
|#

## Federation {#yandex.cloud.iam.v1.workload.oidc.Federation}

```json
{
  "id": "string",
  "name": "string",
  "folderId": "string",
  "description": "string",
  "enabled": "bool",
  "audiences": [
    "string"
  ],
  "issuer": "string",
  "jwksUrl": "string",
  "labels": "string",
  "createdAt": "google.protobuf.Timestamp"
}
```

A OIDC workload identity federation.

#|
||Field | Description ||
|| id | **string**

Id of the OIDC workload identity federation. ||
|| name | **string**

Name of the OIDC workload identity federation
The name is unique within the folder. 3-63 characters long. ||
|| folderId | **string**

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
|| jwksUrl | **string**

URL reference to trusted keys in format of JSON Web Key Set. ||
|| labels | **string**

Resource labels as `` key:value `` pairs ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|#