---
editable: false
sourcePath: en/_api-ref/serverless/eventrouter/v1/eventrouter/api-ref/Bus/get.md
---

# EventRouter Service, REST: Bus.Get

Returns the specified bus.
To get the list of all available buses, make a [List](/docs/functions/eventrouter/api-ref/Bus/list#List) request.

## HTTP request

```
GET https://serverless-eventrouter.{{ api-host }}/eventrouter/v1/buses/{busId}
```

## Path parameters

#|
||Field | Description ||
|| busId | **string**

Required field. ID of the bus to get. ||
|#

## Response {#yandex.cloud.serverless.eventrouter.v1.Bus}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "cloudId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "deletionProtection": "boolean",
  "status": "string"
}
```

#|
||Field | Description ||
|| id | **string**

ID of the bus. ||
|| folderId | **string**

ID of the folder that the bus belongs to. ||
|| cloudId | **string**

ID of the cloud that the bus resides in. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the bus. ||
|| description | **string**

Description of the bus. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|| deletionProtection | **boolean**

Deletion protection. ||
|| status | **enum** (Status)

Status of the bus.

- `STATUS_UNSPECIFIED`
- `CREATING`
- `ACTIVE`
- `DELETING` ||
|#