---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-clickhouse/v1/changeFreezes/{changeFreezeId}
    method: get
    path:
      type: object
      properties:
        changeFreezeId:
          description: |-
            **string**
            Required field. ID of the change freeze to retrieve.
            The maximum string length in characters is 50.
          type: string
      required:
        - changeFreezeId
      additionalProperties: false
    query: null
    body: null
    definitions: null
---

# Managed Service for ClickHouse API, REST: ChangeFreeze.Get

Retrieves the specific change freeze by ID.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-clickhouse/v1/changeFreezes/{changeFreezeId}
```

## Path parameters

#|
||Field | Description ||
|| changeFreezeId | **string**

Required field. ID of the change freeze to retrieve.

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.maintenance.v2.ChangeFreeze}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "resourcePath": [
    {
      "id": "string",
      "type": "string"
    }
  ],
  "startAt": "string",
  "endAt": "string",
  "durationSeconds": "string",
  "reason": "string",
  "createdBy": "string",
  "createdAt": "string",
  "status": "string",
  "updatedBy": "string",
  "updatedAt": "string"
}
```

#|
||Field | Description ||
|| id | **string**

ID of the change freeze. ||
|| resourcePath[] | **[Resource](#yandex.cloud.maintenance.v2.Resource)**

Full path to the resource affected by the change freeze,
represented as a hierarchy from specific resource to top-level container. ||
|| startAt | **string** (date-time)

The time when the change freeze is scheduled to start.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| endAt | **string** (date-time)

The time when the change freeze is scheduled to end.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| durationSeconds | **string** (int64)

Duration of the change freeze in seconds. ||
|| reason | **string**

Reason for the change freeze. ||
|| createdBy | **string**

The user who created the change freeze. ||
|| createdAt | **string** (date-time)

The creation time of the change freeze.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| status | **enum** (Status)

Status of the change freeze.

- `SCHEDULED`: Change freeze is scheduled for a future time.
- `ACTIVE`: Change freeze is currently active.
- `COMPLETED`: Change freeze is completed.
- `CANCELLED`: Change freeze is cancelled. ||
|| updatedBy | **string**

The user who last updated the change freeze. ||
|| updatedAt | **string** (date-time)

The time when the change freeze was last updated.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#

## Resource {#yandex.cloud.maintenance.v2.Resource}

#|
||Field | Description ||
|| id | **string**

ID of the resource ||
|| type | **string**

The type of the resource, e.g. resource-manager.cloud, resource-manager.folder, compute.instance, etc. ||
|#