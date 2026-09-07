---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-redis/v1/changeFreezes
    method: get
    path: null
    query:
      type: object
      properties:
        resourcePath:
          description: |-
            **[Resource](#yandex.cloud.maintenance.v2.Resource)**
            Full path to the resource to list change freezes for.
            The number of elements must be in the range 1-128.
          type: array
          items:
            $ref: '#/definitions/Resource'
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of change freezes to return per response.
            The maximum value is 1000.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Token to retrieve the next page of results. Omitted on the first request.
            The maximum string length in characters is 500.
          type: string
        filter:
          description: |-
            **string**
            Filter list by various fields.
            The maximum string length in characters is 300.
          type: string
      additionalProperties: false
    body: null
    definitions:
      Resource:
        type: object
        properties:
          id:
            description: |-
              **string**
              ID of the resource
            type: string
          type:
            description: |-
              **string**
              The type of the resource, e.g. resource-manager.cloud, resource-manager.folder, compute.instance, etc.
            type: string
---

# Managed Service for Redis API, REST: ChangeFreeze.List

Lists change freezes by conditions, specified in request.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-redis/v1/changeFreezes
```

## Query parameters {#yandex.cloud.maintenance.v2.ListChangeFreezesRequest}

#|
||Field | Description ||
|| resourcePath[] | **[Resource](#yandex.cloud.maintenance.v2.Resource)**

Full path to the resource to list change freezes for.

The number of elements must be in the range 1-128. ||
|| pageSize | **string** (int64)

The maximum number of change freezes to return per response.

The maximum value is 1000. ||
|| pageToken | **string**

Token to retrieve the next page of results. Omitted on the first request.

The maximum string length in characters is 500. ||
|| filter | **string**

Filter list by various fields.

The maximum string length in characters is 300. ||
|#

## Resource {#yandex.cloud.maintenance.v2.Resource}

#|
||Field | Description ||
|| id | **string**

ID of the resource ||
|| type | **string**

The type of the resource, e.g. resource-manager.cloud, resource-manager.folder, compute.instance, etc. ||
|#

## Response {#yandex.cloud.maintenance.v2.ListChangeFreezesResponse}

**HTTP Code: 200 - OK**

```json
{
  "changeFreezes": [
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
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| changeFreezes[] | **[ChangeFreeze](#yandex.cloud.maintenance.v2.ChangeFreeze)**

List of change freezes. ||
|| nextPageToken | **string**

Token to retrieve the next page of results. ||
|#

## ChangeFreeze {#yandex.cloud.maintenance.v2.ChangeFreeze}

#|
||Field | Description ||
|| id | **string**

ID of the change freeze. ||
|| resourcePath[] | **[Resource](#yandex.cloud.maintenance.v2.Resource2)**

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

## Resource {#yandex.cloud.maintenance.v2.Resource2}

#|
||Field | Description ||
|| id | **string**

ID of the resource ||
|| type | **string**

The type of the resource, e.g. resource-manager.cloud, resource-manager.folder, compute.instance, etc. ||
|#