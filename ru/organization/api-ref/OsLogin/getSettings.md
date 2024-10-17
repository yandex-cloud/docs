---
editable: false
sourcePath: en/_api-ref/organizationmanager/v1/api-ref/OsLogin/getSettings.md
---

# Cloud Organization API, REST: OsLogin.GetSettings {#GetSettings}

OsLogin settings

## HTTP request

```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/organizations/{organizationId}/osLoginSettings
```

## Path parameters

#|
||Field | Description ||
|| organizationId | **string**

Required field.  ||
|#

## Response {#yandex.cloud.organizationmanager.v1.OsLoginSettings}

**HTTP Code: 200 - OK**

```json
{
  "userSshKeySettings": {
    "enabled": "boolean",
    "allowManageOwnKeys": "boolean"
  },
  "sshCertificateSettings": {
    "enabled": "boolean"
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
|| enabled | **boolean** ||
|| allowManageOwnKeys | **boolean** ||
|#

## SshCertificateSettings {#yandex.cloud.organizationmanager.v1.SshCertificateSettings}

#|
||Field | Description ||
|| enabled | **boolean** ||
|#