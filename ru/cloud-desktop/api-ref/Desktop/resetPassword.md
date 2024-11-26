---
editable: false
sourcePath: en/_api-ref/clouddesktop/v1/api-ref/Desktop/resetPassword.md
---

# Cloud Desktop API, REST: Desktop.ResetPassword

Reset password

## HTTP request

```
POST https://cloud-desktop.{{ api-host }}/cloud-desktop/v1/desktops/{desktopId}:resetPassword
```

## Path parameters

#|
||Field | Description ||
|| desktopId | **string**

Required field. ID of the desktop. ||
|#

## Body parameters {#yandex.cloud.clouddesktop.v1.api.ResetPasswordRequest}

```json
{
  "user": {
    "subjectId": "string",
    "subjectType": "string"
  }
}
```

#|
||Field | Description ||
|| user | **[User](#yandex.cloud.clouddesktop.v1.api.User)**

Required field. User of the desktop. ||
|#

## User {#yandex.cloud.clouddesktop.v1.api.User}

#|
||Field | Description ||
|| subjectId | **string**

Required field. Identity of the access binding. ||
|| subjectType | **string**

Required field. Type of the access binding, e.g. userAccount, serviceAccount, system. ||
|#

## Response {#yandex.cloud.clouddesktop.v1.api.ResetPasswordResponse}

**HTTP Code: 200 - OK**

```json
{
  "password": "string"
}
```

#|
||Field | Description ||
|| password | **string**

Generated password ||
|#