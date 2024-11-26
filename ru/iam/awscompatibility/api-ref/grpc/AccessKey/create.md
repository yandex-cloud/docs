---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/awscompatibility/api-ref/grpc/AccessKey/create.md
---

# Access Key, gRPC: AccessKeyService.Create

Creates an access key for the specified service account.

## gRPC request

**rpc Create ([CreateAccessKeyRequest](#yandex.cloud.iam.v1.awscompatibility.CreateAccessKeyRequest)) returns ([CreateAccessKeyResponse](#yandex.cloud.iam.v1.awscompatibility.CreateAccessKeyResponse))**

## CreateAccessKeyRequest {#yandex.cloud.iam.v1.awscompatibility.CreateAccessKeyRequest}

```json
{
  "service_account_id": "string",
  "description": "string"
}
```

#|
||Field | Description ||
|| service_account_id | **string**

ID of the service account to create an access key for.
To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/ServiceAccount/list#List) request.
If not specified, it defaults to the subject that made the request. ||
|| description | **string**

Description of the access key. ||
|#

## CreateAccessKeyResponse {#yandex.cloud.iam.v1.awscompatibility.CreateAccessKeyResponse}

```json
{
  "access_key": {
    "id": "string",
    "service_account_id": "string",
    "created_at": "google.protobuf.Timestamp",
    "description": "string",
    "key_id": "string",
    "last_used_at": "google.protobuf.Timestamp"
  },
  "secret": "string"
}
```

#|
||Field | Description ||
|| access_key | **[AccessKey](#yandex.cloud.iam.v1.awscompatibility.AccessKey)**

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
|| service_account_id | **string**

ID of the service account that the access key belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| description | **string**

Description of the access key. 0-256 characters long. ||
|| key_id | **string**

ID of the access key.
The key is AWS compatible. ||
|| last_used_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp for the last authentication using this Access key. ||
|#