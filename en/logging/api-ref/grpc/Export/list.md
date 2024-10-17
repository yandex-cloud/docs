---
editable: false
sourcePath: en/_api-ref-grpc/logging/v1/api-ref/grpc/Export/list.md
---

# Cloud Logging Service, gRPC: ExportService.List {#List}

Retrieves the list of exports in the specified folder.

## gRPC request

**rpc List ([ListExportsRequest](#yandex.cloud.logging.v1.ListExportsRequest)) returns ([ListExportsResponse](#yandex.cloud.logging.v1.ListExportsResponse))**

## ListExportsRequest {#yandex.cloud.logging.v1.ListExportsRequest}

```json
{
  "folderId": "string",
  "pageSize": "int64",
  "pageToken": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. Folder ID of the exports to return.

To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| pageSize | **int64**

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

## ListExportsResponse {#yandex.cloud.logging.v1.ListExportsResponse}

```json
{
  "exports": [
    {
      "id": "string",
      "folderId": "string",
      "cloudId": "string",
      "createdAt": "google.protobuf.Timestamp",
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
          "Level"
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Export creation time. ||
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
|| levels[] | enum **Level**

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