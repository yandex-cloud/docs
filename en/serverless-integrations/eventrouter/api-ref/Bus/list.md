---
editable: false
sourcePath: en/_api-ref/serverless/eventrouter/v1/eventrouter/api-ref/Bus/list.md
---

# EventRouter Service, REST: Bus.List {#List}

Retrieves the list of buses in the specified folder.

## HTTP request

```
GET https://serverless-eventrouter.{{ api-host }}/eventrouter/v1/buses
```

## Query parameters {#yandex.cloud.serverless.eventrouter.v1.ListBusesRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list buses in. ||
|| pageSize | **string** (int64)

Maximum number of buses to return. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListBusesResponse.nextPageToken](#yandex.cloud.serverless.eventrouter.v1.ListBusesResponse) returned by a previous list request. ||
|| filter | **string**

Supported fields for filter:
name
created_at ||
|#

## Response {#yandex.cloud.serverless.eventrouter.v1.ListBusesResponse}

**HTTP Code: 200 - OK**

```json
{
  "buses": [
    {
      "id": "string",
      "folderId": "string",
      "cloudId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "string",
      "deletionProtection": "boolean",
      "status": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| buses[] | **[Bus](#yandex.cloud.serverless.eventrouter.v1.Bus)**

List of buses. ||
|| nextPageToken | **string**

Token for getting the next page of the list of buses. ||
|#

## Bus {#yandex.cloud.serverless.eventrouter.v1.Bus}

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
|| labels | **string**

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