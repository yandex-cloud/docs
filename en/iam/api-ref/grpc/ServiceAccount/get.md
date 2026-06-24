---
editable: false
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
To get the service account ID, use a [ServiceAccountService.List](/docs/iam/api-ref/grpc/ServiceAccount/list#List) request.

The maximum string length in characters is 50. ||
|#

## ServiceAccount {#yandex.cloud.iam.v1.ServiceAccount}

```json
{
  "id": "string",
  "folder_id": "string",
  "created_at": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "last_authenticated_at": "google.protobuf.Timestamp",
  "status": "Status",
  "expires_at": "google.protobuf.Timestamp"
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
|| labels | **object** (map<**string**, **string**>)

Resource labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|| last_authenticated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp for the last authentication of this service account. ||
|| status | enum **Status**

Current status of the service account.
Determines whether the service account can authenticate and access the system.

- `CREATING`: The service account is in the process of being created.
- `ACTIVE`: The service account is active and can authenticate.
Active service accounts have full access to the system according to their permissions.
- `SUSPENDED`: The service account is suspended and cannot authenticate.
Suspended service accounts retain their data but cannot access the system.
- `DELETING`: The service account is in the process of being deleted.
This is a transitional state before the service account is completely removed from the system. ||
|| expires_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the service account expires. ||
|#