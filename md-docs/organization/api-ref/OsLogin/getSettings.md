[Документация Yandex Cloud](../../../index.md) > [Yandex Identity Hub](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [OsLogin](index.md) > GetSettings

# Identity Hub API, REST: OsLogin.GetSettings

OsLogin settings

## HTTP request

```
GET https://organization-manager.api.cloud.yandex.net/organization-manager/v1/organizations/{organizationId}/osLoginSettings
```

## Path parameters

#|
||Field | Description ||
|| organizationId | **string**

Required field.

The maximum string length in characters is 50. ||
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