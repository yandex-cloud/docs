---
editable: false
apiPlayground:
  - url: https://rest-assistant.{{ api-host }}/users/v1/users/{userId}
    method: patch
    path:
      type: object
      properties:
        userId:
          description: |-
            **string**
            Required field. ID of the user to update.
          type: string
      required:
        - userId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        updateMask:
          description: |-
            **string** (field-mask)
            Required field. A comma-separated names off ALL fields to be updated.
            Only the specified fields will be changed. The others will be left untouched.
            If the field is specified in `` updateMask `` and no value for that field was sent in the request,
            the field's value will be reset to the default. The default value for most fields is null or 0.
            If `` updateMask `` is not sent in the request, all fields' values will be updated.
            Fields specified in the request will be updated to provided values.
            The rest of the fields will be reset to the default.
          type: string
          format: field-mask
        name:
          description: |-
            **string**
            New name for the user.
          type: string
        description:
          description: |-
            **string**
            New description for the user.
          type: string
        expirationConfig:
          description: |-
            **`ExpirationConfig`**
            New expiration configuration for the user.
          $ref: '#/definitions/ExpirationConfig'
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            New set of labels for the user.
          type: string
      required:
        - updateMask
      additionalProperties: false
    definitions:
      ExpirationConfig:
        type: object
        properties:
          expirationPolicy:
            description: |-
              **enum** (ExpirationPolicy)
              - `EXPIRATION_POLICY_UNSPECIFIED`
              - `STATIC`
              - `SINCE_LAST_ACTIVE`
            type: string
            enum:
              - EXPIRATION_POLICY_UNSPECIFIED
              - STATIC
              - SINCE_LAST_ACTIVE
          ttlDays:
            description: '**string** (int64)'
            type: string
            format: int64
sourcePath: en/_api-ref/ai/assistants/v1/users/api-ref/User/update.md
---

# Users, REST: User.Update

Update an existing user.

## HTTP request

```
PATCH https://rest-assistant.{{ api-host }}/users/v1/users/{userId}
```

## Path parameters

Request message for updating an existing user.

#|
||Field | Description ||
|| userId | **string**

Required field. ID of the user to update. ||
|#

## Body parameters {#yandex.cloud.ai.assistants.v1.users.UpdateUserRequest}

```json
{
  "updateMask": "string",
  "name": "string",
  "description": "string",
  "expirationConfig": {
    "expirationPolicy": "string",
    "ttlDays": "string"
  },
  "labels": "object"
}
```

Request message for updating an existing user.

#|
||Field | Description ||
|| updateMask | **string** (field-mask)

Required field. A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| name | **string**

New name for the user. ||
|| description | **string**

New description for the user. ||
|| expirationConfig | **[ExpirationConfig](#yandex.cloud.ai.common.ExpirationConfig)**

New expiration configuration for the user. ||
|| labels | **object** (map<**string**, **string**>)

New set of labels for the user. ||
|#

## ExpirationConfig {#yandex.cloud.ai.common.ExpirationConfig}

#|
||Field | Description ||
|| expirationPolicy | **enum** (ExpirationPolicy)

- `EXPIRATION_POLICY_UNSPECIFIED`
- `STATIC`
- `SINCE_LAST_ACTIVE` ||
|| ttlDays | **string** (int64) ||
|#

## Response {#yandex.cloud.ai.assistants.v1.users.User}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "name": "string",
  "description": "string",
  "source": "string",
  "createdBy": "string",
  "createdAt": "string",
  "updatedBy": "string",
  "updatedAt": "string",
  "expirationConfig": {
    "expirationPolicy": "string",
    "ttlDays": "string"
  },
  "expiresAt": "string",
  "labels": "object"
}
```

#|
||Field | Description ||
|| id | **string**

Unique identifier of the user. ||
|| folderId | **string**

ID of the folder that the user belongs to. ||
|| name | **string**

Name of the user. ||
|| description | **string**

Description of the user. ||
|| source | **string** ||
|| createdBy | **string**

Identifier of the subject who created this user. ||
|| createdAt | **string** (date-time)

Timestamp representing when the user was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedBy | **string**

Identifier of the subject who last updated this user. ||
|| updatedAt | **string** (date-time)

Timestamp representing the last time this user was updated.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| expirationConfig | **[ExpirationConfig](#yandex.cloud.ai.common.ExpirationConfig2)**

Configuration for the expiration of the user, defining when and how the user will expire. ||
|| expiresAt | **string** (date-time)

Timestamp representing when the user will expire.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| labels | **object** (map<**string**, **string**>)

Set of key-value pairs that can be used to organize and categorize the user. ||
|#

## ExpirationConfig {#yandex.cloud.ai.common.ExpirationConfig2}

#|
||Field | Description ||
|| expirationPolicy | **enum** (ExpirationPolicy)

- `EXPIRATION_POLICY_UNSPECIFIED`
- `STATIC`
- `SINCE_LAST_ACTIVE` ||
|| ttlDays | **string** (int64) ||
|#