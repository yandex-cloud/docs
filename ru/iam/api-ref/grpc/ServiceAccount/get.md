---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/api-ref/grpc/ServiceAccount/get.md
---

# Identity and Access Management API, gRPC: ServiceAccountService.Get {#Get}

Returns the specified ServiceAccount resource.

To get the list of available ServiceAccount resources, make a [List](/docs/iam/api-ref/grpc/ServiceAccount/list#List) request.

## gRPC request

**rpc Get ([GetServiceAccountRequest](#yandex.cloud.iam.v1.GetServiceAccountRequest)) returns ([ServiceAccount](#yandex.cloud.iam.v1.ServiceAccount))**

## GetServiceAccountRequest {#yandex.cloud.iam.v1.GetServiceAccountRequest}

```json
{
  "serviceAccountId": "string"
}
```

#|
||Field | Description ||
|| serviceAccountId | **string**

Required field. ID of the ServiceAccount resource to return.
To get the service account ID, use a [ServiceAccountService.List](/docs/iam/api-ref/grpc/ServiceAccount/list#List) request. ||
|#

## ServiceAccount {#yandex.cloud.iam.v1.ServiceAccount}

```json
{
  "id": "string",
  "folderId": "string",
  "createdAt": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "labels": "string",
  "lastAuthenticatedAt": "google.protobuf.Timestamp"
}
```

A ServiceAccount resource. For more information, see [Service accounts](/docs/iam/concepts/users/service-accounts).

#|
||Field | Description ||
|| id | **string**

ID of the service account. ||
|| folderId | **string**

ID of the folder that the service account belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the service account.
The name is unique within the cloud. 3-63 characters long. ||
|| description | **string**

Description of the service account. 0-256 characters long. ||
|| labels | **string**

Resource labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|| lastAuthenticatedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp for the last authentication of this service account. ||
|#