---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/organizations/{organizationId}/osLoginSettings
    method: patch
    path:
      type: object
      properties:
        organizationId:
          description: |-
            **string**
            Required field. 
          type: string
      required:
        - organizationId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        userSshKeySettings:
          description: '**[UserSshKeySettings](/docs/organization/api-ref/OsLogin/updateSettings#yandex.cloud.organizationmanager.v1.UpdateOsLoginSettingsRequest.UserSshKeySettings)**'
          $ref: '#/definitions/UserSshKeySettings'
        sshCertificateSettings:
          description: '**[SshCertificateSettings](/docs/organization/api-ref/OsLogin/updateSettings#yandex.cloud.organizationmanager.v1.UpdateOsLoginSettingsRequest.SshCertificateSettings)**'
          $ref: '#/definitions/SshCertificateSettings'
        updateMask:
          description: |-
            **string** (field-mask)
            A comma-separated names off ALL fields to be updated.
            Only the specified fields will be changed. The others will be left untouched.
            If the field is specified in `` updateMask `` and no value for that field was sent in the request,
            the field's value will be reset to the default. The default value for most fields is null or 0.
            If `` updateMask `` is not sent in the request, all fields' values will be updated.
            Fields specified in the request will be updated to provided values.
            The rest of the fields will be reset to the default.
          type: string
          format: field-mask
      additionalProperties: false
    definitions:
      UserSshKeySettings:
        type: object
        properties:
          enabled:
            description: '**boolean**'
            type: boolean
          allowManageOwnKeys:
            description: '**boolean**'
            type: boolean
      SshCertificateSettings:
        type: object
        properties:
          enabled:
            description: '**boolean**'
            type: boolean
sourcePath: en/_api-ref/organizationmanager/v1/api-ref/OsLogin/updateSettings.md
---

# Identity Hub API, REST: OsLogin.UpdateSettings

## HTTP request

```
PATCH https://organization-manager.{{ api-host }}/organization-manager/v1/organizations/{organizationId}/osLoginSettings
```

## Path parameters

#|
||Field | Description ||
|| organizationId | **string**

Required field.  ||
|#

## Body parameters {#yandex.cloud.organizationmanager.v1.UpdateOsLoginSettingsRequest}

```json
{
  "userSshKeySettings": {
    "enabled": "boolean",
    "allowManageOwnKeys": "boolean"
  },
  "sshCertificateSettings": {
    "enabled": "boolean"
  },
  "updateMask": "string"
}
```

#|
||Field | Description ||
|| userSshKeySettings | **[UserSshKeySettings](#yandex.cloud.organizationmanager.v1.UpdateOsLoginSettingsRequest.UserSshKeySettings)** ||
|| sshCertificateSettings | **[SshCertificateSettings](#yandex.cloud.organizationmanager.v1.UpdateOsLoginSettingsRequest.SshCertificateSettings)** ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|#

## UserSshKeySettings {#yandex.cloud.organizationmanager.v1.UpdateOsLoginSettingsRequest.UserSshKeySettings}

#|
||Field | Description ||
|| enabled | **boolean** ||
|| allowManageOwnKeys | **boolean** ||
|#

## SshCertificateSettings {#yandex.cloud.organizationmanager.v1.UpdateOsLoginSettingsRequest.SshCertificateSettings}

#|
||Field | Description ||
|| enabled | **boolean** ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "organizationId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "userSshKeySettings": {
      "enabled": "boolean",
      "allowManageOwnKeys": "boolean"
    },
    "sshCertificateSettings": {
      "enabled": "boolean"
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateOsLoginSettingsMetadata](#yandex.cloud.organizationmanager.v1.UpdateOsLoginSettingsMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

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

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
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
|| enabled | **boolean** ||
|| allowManageOwnKeys | **boolean** ||
|#

## SshCertificateSettings {#yandex.cloud.organizationmanager.v1.SshCertificateSettings}

#|
||Field | Description ||
|| enabled | **boolean** ||
|#