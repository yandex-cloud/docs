---
editable: false
sourcePath: en/_api-ref-grpc/logging/v1/api-ref/grpc/Sink/list.md
---

# Cloud Logging Service, gRPC: SinkService.List

Retrieves the list of sinks in the specified folder.

## gRPC request

**rpc List ([ListSinksRequest](#yandex.cloud.logging.v1.ListSinksRequest)) returns ([ListSinksResponse](#yandex.cloud.logging.v1.ListSinksResponse))**

## ListSinksRequest {#yandex.cloud.logging.v1.ListSinksRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. Folder ID of the sinks to return.

To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListSinkssResponse.next_page_token]
that can be used to get the next page of results in subsequent list requests.

Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListSinksResponse.next_page_token](#yandex.cloud.logging.v1.ListSinksResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters sinks listed in the response.

The expression must specify:
1. The field name. Currently filtering can only be applied to the [Sink.name](#yandex.cloud.logging.v1.Sink) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.
Example of a filter: `name="my-sink"`. ||
|#

## ListSinksResponse {#yandex.cloud.logging.v1.ListSinksResponse}

```json
{
  "sinks": [
    {
      "id": "string",
      "folder_id": "string",
      "cloud_id": "string",
      "created_at": "google.protobuf.Timestamp",
      "name": "string",
      "description": "string",
      "labels": "string",
      "service_account_id": "string",
      // Includes only one of the fields `yds`, `s3`
      "yds": {
        "stream_name": "string"
      },
      "s3": {
        "bucket": "string",
        "prefix": "string"
      }
      // end of the list of possible fields
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| sinks[] | **[Sink](#yandex.cloud.logging.v1.Sink)**

List of sinks in the specified folder. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListSinksRequest.page_size](#yandex.cloud.logging.v1.ListSinksRequest), use `next_page_token` as the value
for the [ListSinksRequest.page_token](#yandex.cloud.logging.v1.ListSinksRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## Sink {#yandex.cloud.logging.v1.Sink}

#|
||Field | Description ||
|| id | **string**

Sink ID. ||
|| folder_id | **string**

Sink folder ID. ||
|| cloud_id | **string**

Sink cloud ID. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Sink creation time. ||
|| name | **string**

Sink name. ||
|| description | **string**

Sink description. ||
|| labels | **string**

Sink labels. ||
|| service_account_id | **string**

Logs will be written to the sink on behalf of this service account ||
|| yds | **[Yds](#yandex.cloud.logging.v1.Sink.Yds)**

Yandex data stream

Includes only one of the fields `yds`, `s3`.

Logs destination ||
|| s3 | **[S3](#yandex.cloud.logging.v1.Sink.S3)**

Object storage

Includes only one of the fields `yds`, `s3`.

Logs destination ||
|#

## Yds {#yandex.cloud.logging.v1.Sink.Yds}

#|
||Field | Description ||
|| stream_name | **string**

Fully qualified name of data stream ||
|#

## S3 {#yandex.cloud.logging.v1.Sink.S3}

#|
||Field | Description ||
|| bucket | **string**

Object storage bucket ||
|| prefix | **string**

Prefix to use for saved log object names ||
|#