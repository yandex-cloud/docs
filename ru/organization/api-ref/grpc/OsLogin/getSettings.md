---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/api-ref/grpc/OsLogin/getSettings.md
---

# Cloud Organization API, gRPC: OsLoginService.GetSettings

OsLogin settings

## gRPC request

**rpc GetSettings ([GetOsLoginSettingsRequest](#yandex.cloud.organizationmanager.v1.GetOsLoginSettingsRequest)) returns ([OsLoginSettings](#yandex.cloud.organizationmanager.v1.OsLoginSettings))**

## GetOsLoginSettingsRequest {#yandex.cloud.organizationmanager.v1.GetOsLoginSettingsRequest}

```json
{
  "organization_id": "string"
}
```

#|
||Field | Description ||
|| organization_id | **string**

Required field.  ||
|#

## OsLoginSettings {#yandex.cloud.organizationmanager.v1.OsLoginSettings}

```json
{
  "user_ssh_key_settings": {
    "enabled": "bool",
    "allow_manage_own_keys": "bool"
  },
  "ssh_certificate_settings": {
    "enabled": "bool"
  }
}
```

#|
||Field | Description ||
|| user_ssh_key_settings | **[UserSshKeySettings](#yandex.cloud.organizationmanager.v1.UserSshKeySettings)** ||
|| ssh_certificate_settings | **[SshCertificateSettings](#yandex.cloud.organizationmanager.v1.SshCertificateSettings)** ||
|#

## UserSshKeySettings {#yandex.cloud.organizationmanager.v1.UserSshKeySettings}

#|
||Field | Description ||
|| enabled | **bool** ||
|| allow_manage_own_keys | **bool** ||
|#

## SshCertificateSettings {#yandex.cloud.organizationmanager.v1.SshCertificateSettings}

#|
||Field | Description ||
|| enabled | **bool** ||
|#