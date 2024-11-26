---
editable: false
sourcePath: en/_api-ref/logging/v1/api-ref/Export/list.md
---

# Cloud Logging Service, REST: Export.List

Retrieves the list of exports in the specified folder.

## HTTP request

```
GET https://logging.{{ api-host }}/logging/v1/exports
```

## Query parameters {#yandex.cloud.logging.v1.ListExportsRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. Folder ID of the exports to return.

To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListExportssResponse.next_page_token]
that can be used to get the next page of results in subsequent list requests.

Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListExportsResponse.nextPageToken](#yandex.cloud.logging.v1.ListExportsResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters exports listed in the response.

The expression must specify:
1. The field name. Currently filtering can only be applied to the [Export.name](#yandex.cloud.logging.v1.Export) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.
Example of a filter: `name="my-export"`. ||
|#

## Response {#yandex.cloud.logging.v1.ListExportsResponse}

**HTTP Code: 200 - OK**

```json
{
  "exports": [
    {
      "id": "string",
      "folderId": "string",
      "cloudId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "string",
      "groupId": "string",
      "sinkId": "string",
      "params": {
        "resourceTypes": [
          "string"
        ],
        "resourceIds": [
          "string"
        ],
        "streamNames": [
          "string"
        ],
        "levels": [
          "string"
        ],
        "filter": "string"
      }
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| exports[] | **[Export](#yandex.cloud.logging.v1.Export)**

List of exports in the specified folder. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListExportsRequest.pageSize](#yandex.cloud.logging.v1.ListExportsRequest), use `next_page_token` as the value
for the [ListExportsRequest.pageToken](#yandex.cloud.logging.v1.ListExportsRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## Export {#yandex.cloud.logging.v1.Export}

#|
||Field | Description ||
|| id | **string**

Export ID. ||
|| folderId | **string**

Export folder ID. ||
|| cloudId | **string**

Export cloud ID. ||
|| createdAt | **string** (date-time)

Export creation time.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Export name. ||
|| description | **string**

Export description. ||
|| labels | **string**

Export lables. ||
|| groupId | **string**

Group logs are exported from. ||
|| sinkId | **string**

Sink logs are exported to. ||
|| params | **[ExportParams](#yandex.cloud.logging.v1.ExportParams)**

Parameters of logs filtration. ||
|#

## ExportParams {#yandex.cloud.logging.v1.ExportParams}

#|
||Field | Description ||
|| resourceTypes[] | **string** ||
|| resourceIds[] | **string** ||
|| streamNames[] | **string** ||
|| levels[] | **enum** (Level)

- `LEVEL_UNSPECIFIED`: Default log level.

  Equivalent to not specifying log level at all.
- `TRACE`: Trace log level.

  Possible use case: verbose logging of some business logic.
- `DEBUG`: Debug log level.

  Possible use case: debugging special cases in application logic.
- `INFO`: Info log level.

  Mostly used for information messages.
- `WARN`: Warn log level.

  May be used to alert about significant events.
- `ERROR`: Error log level.

  May be used to alert about errors in infrastructure, logic, etc.
- `FATAL`: Fatal log level.

  May be used to alert about unrecoverable failures and events. ||
|| filter | **string** ||
|#