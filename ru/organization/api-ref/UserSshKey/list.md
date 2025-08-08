---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/userSshKeys
    method: get
    path: null
    query:
      type: object
      properties:
        organizationId:
          description: |-
            **string**
            Required field. 
          type: string
        subjectId:
          description: |-
            **string**
            if empty, list all organization keys
          type: string
        pageSize:
          description: '**string** (int64)'
          type: string
          format: int64
        pageToken:
          description: '**string**'
          type: string
      required:
        - organizationId
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/organizationmanager/v1/api-ref/UserSshKey/list.md
---

# Identity Hub API, REST: UserSshKey.List

## HTTP request

```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/userSshKeys
```

## Query parameters {#yandex.cloud.organizationmanager.v1.ListUserSshKeysRequest}

#|
||Field | Description ||
|| organizationId | **string**

Required field.  ||
|| subjectId | **string**

if empty, list all organization keys ||
|| pageSize | **string** (int64) ||
|| pageToken | **string** ||
|#

## Response {#yandex.cloud.organizationmanager.v1.ListUserSshKeysResponse}

**HTTP Code: 200 - OK**

```json
{
  "sshKeys": [
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
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| sshKeys[] | **[UserSshKey](#yandex.cloud.organizationmanager.v1.UserSshKey)** ||
|| nextPageToken | **string** ||
|#

## UserSshKey {#yandex.cloud.organizationmanager.v1.UserSshKey}

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