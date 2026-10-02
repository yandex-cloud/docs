---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/idp/users:resolveExternalIds
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        userpoolId:
          description: |-
            **string**
            Required field. ID of the userpool to resolve external IDs in.
            The maximum string length in characters is 50.
          type: string
        externalIds:
          description: |-
            **string**
            List of external IDs to resolve.
            The maximum string length in characters for each value is 256. The number of elements must be in the range 1-1000.
          type: array
          items:
            type: string
      required:
        - userpoolId
      additionalProperties: false
    definitions: null
---

# Identity Provider API, REST: User.ResolveExternalIds

Resolves external IDs to internal user IDs.

## HTTP request

```
POST https://organization-manager.{{ api-host }}/organization-manager/v1/idp/users:resolveExternalIds
```

## Body parameters {#yandex.cloud.organizationmanager.v1.idp.ResolveExternalIdsRequest}

```json
{
  "userpoolId": "string",
  "externalIds": [
    "string"
  ]
}
```

Request to resolve external IDs to internal user IDs.

#|
||Field | Description ||
|| userpoolId | **string**

Required field. ID of the userpool to resolve external IDs in.

The maximum string length in characters is 50. ||
|| externalIds[] | **string**

List of external IDs to resolve.

The maximum string length in characters for each value is 256. The number of elements must be in the range 1-1000. ||
|#

## Response {#yandex.cloud.organizationmanager.v1.idp.ResolveExternalIdsResponse}

**HTTP Code: 200 - OK**

```json
{
  "resolvedUsers": [
    {
      "userId": "string",
      "externalId": "string",
      "userpoolId": "string",
      "passwordCreatedAt": "string"
    }
  ]
}
```

Response for the [UserService.ResolveExternalIds](#ResolveExternalIds) operation.

#|
||Field | Description ||
|| resolvedUsers[] | **[ResolvedUser](#yandex.cloud.organizationmanager.v1.idp.ResolvedUser)**

List of resolved users. ||
|#

## ResolvedUser {#yandex.cloud.organizationmanager.v1.idp.ResolvedUser}

Information about a resolved user.

#|
||Field | Description ||
|| userId | **string**

Internal user ID. ||
|| externalId | **string**

External identifier. ||
|| userpoolId | **string**

ID of the userpool the user belongs to. ||
|| passwordCreatedAt | **string** (date-time)

Timestamp when the user's current password was created.
For synchronized passwords, this is the time when the password was last set in the source directory.
Omitted if the timestamp is unknown.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#