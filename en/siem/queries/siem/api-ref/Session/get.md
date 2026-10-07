---
editable: false
apiPlayground:
  - url: https://siem.{{ api-host }}/siem/v1/queries/sessions/{sessionId}
    method: get
    path:
      type: object
      properties:
        sessionId:
          description: |-
            **string**
            Required field. Required. ID of the Session to return.
            The maximum string length in characters is 50.
          type: string
      required:
        - sessionId
      additionalProperties: false
    query: null
    body: null
    definitions: null
---

# Yandex Cloud SIEM Queries API, REST: Session.Get

Returns the specified Session.

The caller must have the `siem.queries.get` permission to the requested Session.

## HTTP request

```
GET https://siem.{{ api-host }}/siem/v1/queries/sessions/{sessionId}
```

## Path parameters

#|
||Field | Description ||
|| sessionId | **string**

Required field. Required. ID of the Session to return.

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.siem.v1.queries.Session}

**HTTP Code: 200 - OK**

```json
{
  "siemInstanceId": "string",
  "id": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "status": "string",
  "createdAt": "string",
  "updatedAt": "string",
  "createdBy": "string",
  "updatedBy": "string"
}
```

Session is a container for Datasets and Searches.

#|
||Field | Description ||
|| siemInstanceId | **string**

Required. ID of related SIEM instance. ||
|| id | **string**

Required field. Required. Unique ID of the Session.
This ID is assigned by services in the process of creating a Session.

The maximum string length in characters is 50. ||
|| name | **string**

Required field. Required. Name of the Session. 1-64 characters long.

The maximum string length in characters is 64. ||
|| description | **string**

The description of the Session. 0-256 characters long.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|| status | **enum** (Status)

Session status

- `CREATING`: Session is being created
- `ACTIVE`: Session is active
- `UPDATING`: Session is updating
- `DELETING`: Session is deleting
- `DELETED`: Session is deleted ||
|| createdAt | **string** (date-time)

The time when Session was created at.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

The time when Session was last updated at.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who created Session ||
|| updatedBy | **string**

ID of the user or service account who updated Session. ||
|#