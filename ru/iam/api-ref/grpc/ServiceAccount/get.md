---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/api-ref/grpc/ServiceAccount/get.md
---

# Identity and Access Management API, gRPC: ServiceAccountService.Get

Returns the specified ServiceAccount resource.

To get the list of available ServiceAccount resources, make a [List](/docs/iam/api-ref/grpc/ServiceAccount/list#List) request.

## gRPC request

**rpc Get ([GetServiceAccountRequest](#yandex.cloud.iam.v1.GetServiceAccountRequest)) returns ([ServiceAccount](#yandex.cloud.iam.v1.ServiceAccount))**

## GetServiceAccountRequest {#yandex.cloud.iam.v1.GetServiceAccountRequest}

```json
{
  "service_account_id": "string"
}
```

#|
||Field | Description ||
|| service_account_id | **string**

Required field. ID of the ServiceAccount resource to return.
To get the service account ID, use a [ServiceAccountService.List](/docs/iam/api-ref/grpc/ServiceAccount/list#List) request. ||
|#

## ServiceAccount {#yandex.cloud.iam.v1.ServiceAccount}

```json
{
  "id": "string",
  "folder_id": "string",
  "created_at": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "labels": "string",
  "last_authenticated_at": "google.protobuf.Timestamp"
}
```

A ServiceAccount resource. For more information, see [Service accounts](/docs/iam/concepts/users/service-accounts).

#|
||Field | Description ||
|| id | **string**

ID of the service account. ||
|| folder_id | **string**

ID of the folder that the service account belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the service account.
The name is unique within the cloud. 3-63 characters long. ||
|| description | **string**

Description of the service account. 0-256 characters long. ||
|| labels | **string**

Resource labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|| last_authenticated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp for the last authentication of this service account. ||
|#