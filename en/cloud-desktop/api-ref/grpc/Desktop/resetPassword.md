---
editable: false
sourcePath: en/_api-ref-grpc/clouddesktop/v1/api-ref/grpc/Desktop/resetPassword.md
---

# Cloud Desktop API, gRPC: DesktopService.ResetPassword {#ResetPassword}

Reset password

## gRPC request

**rpc ResetPassword ([ResetPasswordRequest](#yandex.cloud.clouddesktop.v1.api.ResetPasswordRequest)) returns ([ResetPasswordResponse](#yandex.cloud.clouddesktop.v1.api.ResetPasswordResponse))**

## ResetPasswordRequest {#yandex.cloud.clouddesktop.v1.api.ResetPasswordRequest}

```json
{
  "desktopId": "string",
  "user": {
    "subjectId": "string",
    "subjectType": "string"
  }
}
```

#|
||Field | Description ||
|| desktopId | **string**

Required field. ID of the desktop. ||
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

## ResetPasswordResponse {#yandex.cloud.clouddesktop.v1.api.ResetPasswordResponse}

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