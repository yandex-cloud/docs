---
editable: false
sourcePath: en/_api-ref-grpc/clouddesktop/v1/api-ref/grpc/Desktop/resetPassword.md
---

# Cloud Desktop API, gRPC: DesktopService.ResetPassword

Reset password

## gRPC request

**rpc ResetPassword ([ResetPasswordRequest](#yandex.cloud.clouddesktop.v1.api.ResetPasswordRequest)) returns ([ResetPasswordResponse](#yandex.cloud.clouddesktop.v1.api.ResetPasswordResponse))**

## ResetPasswordRequest {#yandex.cloud.clouddesktop.v1.api.ResetPasswordRequest}

```json
{
  "desktop_id": "string",
  "user": {
    "subject_id": "string",
    "subject_type": "string"
  }
}
```

#|
||Field | Description ||
|| desktop_id | **string**

Required field. ID of the desktop. ||
|| user | **[User](#yandex.cloud.clouddesktop.v1.api.User)**

Required field. User of the desktop. ||
|#

## User {#yandex.cloud.clouddesktop.v1.api.User}

#|
||Field | Description ||
|| subject_id | **string**

Required field. Identity of the access binding. ||
|| subject_type | **string**

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