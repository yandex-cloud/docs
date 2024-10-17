---
editable: false
sourcePath: en/_api-ref/organizationmanager/v1/api-ref/UserSshKey/get.md
---

# Cloud Organization API, REST: UserSshKey.Get {#Get}

## HTTP request

```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/userSshKeys/{userSshKeyId}
```

## Path parameters

#|
||Field | Description ||
|| userSshKeyId | **string**

Required field.  ||
|#

## Response {#yandex.cloud.organizationmanager.v1.UserSshKey}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "subjectId": "string",
  "data": "string",
  "name": "string",
  "fingerprint": "string",
  "organizationId": "string",
  "createdAt": "string",
  "expiresAt": "string"
}
```

#|
||Field | Description ||
|| id | **string** ||
|| subjectId | **string** ||
|| data | **string** ||
|| name | **string** ||
|| fingerprint | **string** ||
|| organizationId | **string** ||
|| createdAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| expiresAt | **string** (date-time)

Used for temporary keys, if empty the key doesn't expire

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#