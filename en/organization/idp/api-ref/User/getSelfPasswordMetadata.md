---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/idp/users:getSelfPasswordMetadata
    method: get
    path: null
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/organizationmanager/v1/idp/api-ref/User/getSelfPasswordMetadata.md
---

# Identity Provider API, REST: User.GetSelfPasswordMetadata

Returns metadata about the authenticated user's password.

## HTTP request

```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/idp/users:getSelfPasswordMetadata
```

## Response {#yandex.cloud.organizationmanager.v1.idp.PasswordMetadata}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "type": "string",
  "createdAt": "string",
  "expiresAt": "string",
  "lastUsage": {
    "usedAt": "string",
    "ipAddress": "string"
  }
}
```

Metadata about a user's password.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the password. ||
|| type | **enum** (PasswordType)

Type of the password.

- `PASSWORD_TYPE_UNSPECIFIED`: The password type is not specified.
- `TEMPORARY`: Temporary password that must be changed on first use.
- `PERMANENT`: Permanent password. ||
|| createdAt | **string** (date-time)

Timestamp when the password was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| expiresAt | **string** (date-time)

Timestamp when the password expires.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| lastUsage | **[PasswordUsage](#yandex.cloud.organizationmanager.v1.idp.PasswordMetadata.PasswordUsage)**

Information about the last usage of the password. ||
|#

## PasswordUsage {#yandex.cloud.organizationmanager.v1.idp.PasswordMetadata.PasswordUsage}

Information about password usage.

#|
||Field | Description ||
|| usedAt | **string** (date-time)

Timestamp when the password was last used.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| ipAddress | **string**

IP address from which the password was used. ||
|#