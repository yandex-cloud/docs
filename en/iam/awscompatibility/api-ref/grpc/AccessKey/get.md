---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/awscompatibility/api-ref/grpc/AccessKey/get.md
---

# Access Key, gRPC: AccessKeyService.Get

Returns the specified access key.

To get the list of available access keys, make a [List](/docs/iam/awscompatibility/api-ref/grpc/AccessKey/list#List) request.

## gRPC request

**rpc Get ([GetAccessKeyRequest](#yandex.cloud.iam.v1.awscompatibility.GetAccessKeyRequest)) returns ([AccessKey](#yandex.cloud.iam.v1.awscompatibility.AccessKey))**

## GetAccessKeyRequest {#yandex.cloud.iam.v1.awscompatibility.GetAccessKeyRequest}

```json
{
  "access_key_id": "string"
}
```

#|
||Field | Description ||
|| access_key_id | **string**

Required field. ID of the AccessKey resource to return.
To get the access key ID, use a [AccessKeyService.List](/docs/iam/awscompatibility/api-ref/grpc/AccessKey/list#List) request. ||
|#

## AccessKey {#yandex.cloud.iam.v1.awscompatibility.AccessKey}

```json
{
  "id": "string",
  "service_account_id": "string",
  "created_at": "google.protobuf.Timestamp",
  "description": "string",
  "key_id": "string",
  "last_used_at": "google.protobuf.Timestamp"
}
```

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