---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/api-ref/grpc/OsLogin/updateSettings.md
---

# Cloud Organization API, gRPC: OsLoginService.UpdateSettings {#UpdateSettings}

## gRPC request

**rpc UpdateSettings ([UpdateOsLoginSettingsRequest](#yandex.cloud.organizationmanager.v1.UpdateOsLoginSettingsRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateOsLoginSettingsRequest {#yandex.cloud.organizationmanager.v1.UpdateOsLoginSettingsRequest}

```json
{
  "organizationId": "string",
  "userSshKeySettings": {
    "enabled": "bool",
    "allowManageOwnKeys": "bool"
  },
  "sshCertificateSettings": {
    "enabled": "bool"
  },
  "updateMask": "google.protobuf.FieldMask"
}
```

#|
||Field | Description ||
|| organizationId | **string**

Required field.  ||
|| userSshKeySettings | **[UserSshKeySettings](#yandex.cloud.organizationmanager.v1.UpdateOsLoginSettingsRequest.UserSshKeySettings)** ||
|| sshCertificateSettings | **[SshCertificateSettings](#yandex.cloud.organizationmanager.v1.UpdateOsLoginSettingsRequest.SshCertificateSettings)** ||
|| updateMask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)** ||
|#

## UserSshKeySettings {#yandex.cloud.organizationmanager.v1.UpdateOsLoginSettingsRequest.UserSshKeySettings}

#|
||Field | Description ||
|| enabled | **bool** ||
|| allowManageOwnKeys | **bool** ||
|#

## SshCertificateSettings {#yandex.cloud.organizationmanager.v1.UpdateOsLoginSettingsRequest.SshCertificateSettings}

#|
||Field | Description ||
|| enabled | **bool** ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "createdBy": "string",
  "modifiedAt": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "organizationId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "userSshKeySettings": {
      "enabled": "bool",
      "allowManageOwnKeys": "bool"
    },
    "sshCertificateSettings": {
      "enabled": "bool"
    }
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateOsLoginSettingsMetadata](#yandex.cloud.organizationmanager.v1.UpdateOsLoginSettingsMetadata)**

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
|| response | **[OsLoginSettings](#yandex.cloud.organizationmanager.v1.OsLoginSettings)**

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

## UpdateOsLoginSettingsMetadata {#yandex.cloud.organizationmanager.v1.UpdateOsLoginSettingsMetadata}

#|
||Field | Description ||
|| organizationId | **string** ||
|#

## OsLoginSettings {#yandex.cloud.organizationmanager.v1.OsLoginSettings}

#|
||Field | Description ||
|| userSshKeySettings | **[UserSshKeySettings](#yandex.cloud.organizationmanager.v1.UserSshKeySettings)** ||
|| sshCertificateSettings | **[SshCertificateSettings](#yandex.cloud.organizationmanager.v1.SshCertificateSettings)** ||
|#

## UserSshKeySettings {#yandex.cloud.organizationmanager.v1.UserSshKeySettings}

#|
||Field | Description ||
|| enabled | **bool** ||
|| allowManageOwnKeys | **bool** ||
|#

## SshCertificateSettings {#yandex.cloud.organizationmanager.v1.SshCertificateSettings}

#|
||Field | Description ||
|| enabled | **bool** ||
|#