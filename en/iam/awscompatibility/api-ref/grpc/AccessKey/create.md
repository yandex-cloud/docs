---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/awscompatibility/api-ref/grpc/AccessKey/create.md
---

# Identity and Access Management API, gRPC: AccessKeyService.Create {#Create}

Creates an access key for the specified service account.

## gRPC request

**rpc Create ([CreateAccessKeyRequest](#yandex.cloud.iam.v1.awscompatibility.CreateAccessKeyRequest)) returns ([CreateAccessKeyResponse](#yandex.cloud.iam.v1.awscompatibility.CreateAccessKeyResponse))**

## CreateAccessKeyRequest {#yandex.cloud.iam.v1.awscompatibility.CreateAccessKeyRequest}

```json
{
  "serviceAccountId": "string",
  "description": "string"
}
```

#|
||Field | Description ||
|| serviceAccountId | **string**

ID of the service account to create an access key for.
To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/ServiceAccount/list#List) request.
If not specified, it defaults to the subject that made the request. ||
|| description | **string**

Description of the access key. ||
|#

## CreateAccessKeyResponse {#yandex.cloud.iam.v1.awscompatibility.CreateAccessKeyResponse}

```json
{
  "accessKey": {
    "id": "string",
    "serviceAccountId": "string",
    "createdAt": "google.protobuf.Timestamp",
    "description": "string",
    "keyId": "string",
    "lastUsedAt": "google.protobuf.Timestamp"
  },
  "secret": "string"
}
```

#|
||Field | Description ||
|| accessKey | **[AccessKey](#yandex.cloud.iam.v1.awscompatibility.AccessKey)**

AccessKey resource. ||
|| secret | **string**

Secret access key.
The key is AWS compatible. ||
|#

## AccessKey {#yandex.cloud.iam.v1.awscompatibility.AccessKey}

An access key.
For more information, see [AWS-compatible access keys](/docs/iam/concepts/authorization/access-key).

#|
||Field | Description ||
|| id | **string**

ID of the AccessKey resource.
It is used to manage secret credentials: an access key ID and a secret access key. ||
|| serviceAccountId | **string**

ID of the service account that the access key belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| description | **string**

Description of the access key. 0-256 characters long. ||
|| keyId | **string**

ID of the access key.
The key is AWS compatible. ||
|| lastUsedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp for the last authentication using this Access key. ||
|#