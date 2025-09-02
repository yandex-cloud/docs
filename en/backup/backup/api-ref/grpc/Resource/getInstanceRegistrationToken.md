---
editable: false
sourcePath: en/_api-ref-grpc/backup/v1/backup/api-ref/grpc/Resource/getInstanceRegistrationToken.md
---

# Cloud Backup API, gRPC: ResourceService.GetInstanceRegistrationToken

Get instance registration token to install backup agent withot SA attached to instance

## gRPC request

**rpc GetInstanceRegistrationToken ([GetInstanceRegistrationTokenRequest](#yandex.cloud.backup.v1.GetInstanceRegistrationTokenRequest)) returns ([GetInstanceRegistrationTokenResponse](#yandex.cloud.backup.v1.GetInstanceRegistrationTokenResponse))**

## GetInstanceRegistrationTokenRequest {#yandex.cloud.backup.v1.GetInstanceRegistrationTokenRequest}

```json
{
  "folder_id": "string",
  "type": "ResourceType"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. Folder ID. ||
|| type | enum **ResourceType**

Type of resource. Could be compute VM or baremetal server.

- `RESOURCE_TYPE_UNSPECIFIED`
- `COMPUTE`: Resource is Compute Cloud VM
- `BMS`: Resource is baremetal server
- `EXTERNAL_VM`: Resource is VM
- `EXTERNAL_SERVER`: Resource is server ||
|#

## GetInstanceRegistrationTokenResponse {#yandex.cloud.backup.v1.GetInstanceRegistrationTokenResponse}

```json
{
  "instance_registration_id": "string",
  "expired_at": "google.protobuf.Timestamp"
}
```

#|
||Field | Description ||
|| instance_registration_id | **string**

Instance registration token id for instance registration. ||
|| expired_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Token expiration timestamp. ||
|#