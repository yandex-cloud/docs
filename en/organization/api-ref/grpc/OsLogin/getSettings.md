---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/api-ref/grpc/OsLogin/getSettings.md
---

# Cloud Organization API, gRPC: OsLoginService.GetSettings {#GetSettings}

OsLogin settings

## gRPC request

**rpc GetSettings ([GetOsLoginSettingsRequest](#yandex.cloud.organizationmanager.v1.GetOsLoginSettingsRequest)) returns ([OsLoginSettings](#yandex.cloud.organizationmanager.v1.OsLoginSettings))**

## GetOsLoginSettingsRequest {#yandex.cloud.organizationmanager.v1.GetOsLoginSettingsRequest}

```json
{
  "organizationId": "string"
}
```

#|
||Field | Description ||
|| organizationId | **string**

Required field.  ||
|#

## OsLoginSettings {#yandex.cloud.organizationmanager.v1.OsLoginSettings}

```json
{
  "userSshKeySettings": {
    "enabled": "bool",
    "allowManageOwnKeys": "bool"
  },
  "sshCertificateSettings": {
    "enabled": "bool"
  }
}
```

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