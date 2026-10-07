---
editable: false
apiPlayground:
  - url: https://siem.{{ api-host }}/siem/v1/queries/searches/{searchId}
    method: get
    path:
      type: object
      properties:
        searchId:
          description: |-
            **string**
            Required field. Required. ID of the Search to return.
            The maximum string length in characters is 50.
          type: string
      required:
        - searchId
      additionalProperties: false
    query: null
    body: null
    definitions: null
---

# Yandex Cloud SIEM Queries API, REST: Search.Get

Returns the specified Search.

## HTTP request

```
GET https://siem.{{ api-host }}/siem/v1/queries/searches/{searchId}
```

## Path parameters

#|
||Field | Description ||
|| searchId | **string**

Required field. Required. ID of the Search to return.

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.siem.v1.queries.Search}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "sessionId": "string",
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

Search is a resource describing a single search in session.

#|
||Field | Description ||
|| id | **string**

Required field. Required. Unique ID of the Search.
This ID is assigned by services in the process of creating a Search.

The maximum string length in characters is 50. ||
|| sessionId | **string**

Required field. Required. ID of the Session that Search belongs to.

The maximum string length in characters is 50. ||
|| name | **string**

Required field. Required. Name of the Search.
The name is unique within the Session. 1-64 characters long.

The maximum string length in characters is 64. ||
|| description | **string**

The description of the Search. 0-256 characters long.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|| status | **enum** (Status)

Search status

- `CREATING`: Search is being created
- `ACTIVE`: Search is active
- `UPDATING`: Search is being updated
- `DELETING`: Search is being deleted
- `DELETED`: Search is deleted ||
|| createdAt | **string** (date-time)

The time when Search was created at.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

The time when Search was last updated at.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who created the Search. ||
|| updatedBy | **string**

ID of the user or service account who updated the Search. ||
|#