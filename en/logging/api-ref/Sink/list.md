---
editable: false
sourcePath: en/_api-ref/logging/v1/api-ref/Sink/list.md
---

# Cloud Logging Service, REST: Sink.List

Retrieves the list of sinks in the specified folder.

## HTTP request

```
GET https://logging.{{ api-host }}/logging/v1/sinks
```

## Query parameters {#yandex.cloud.logging.v1.ListSinksRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. Folder ID of the sinks to return.

To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListSinkssResponse.next_page_token]
that can be used to get the next page of results in subsequent list requests.

Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListSinksResponse.nextPageToken](#yandex.cloud.logging.v1.ListSinksResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters sinks listed in the response.

The expression must specify:
1. The field name. Currently filtering can only be applied to the [Sink.name](#yandex.cloud.logging.v1.Sink) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.
Example of a filter: `name="my-sink"`. ||
|#

## Response {#yandex.cloud.logging.v1.ListSinksResponse}

**HTTP Code: 200 - OK**

```json
{
  "sinks": [
    {
      "id": "string",
      "folderId": "string",
      "cloudId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "serviceAccountId": "string",
      // Includes only one of the fields `yds`, `s3`
      "yds": {
        "streamName": "string"
      },
      "s3": {
        "bucket": "string",
        "prefix": "string"
      }
      // end of the list of possible fields
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| sinks[] | **[Sink](#yandex.cloud.logging.v1.Sink)**

List of sinks in the specified folder. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListSinksRequest.pageSize](#yandex.cloud.logging.v1.ListSinksRequest), use `next_page_token` as the value
for the [ListSinksRequest.pageToken](#yandex.cloud.logging.v1.ListSinksRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## Sink {#yandex.cloud.logging.v1.Sink}

#|
||Field | Description ||
|| id | **string**

Sink ID. ||
|| folderId | **string**

Sink folder ID. ||
|| cloudId | **string**

Sink cloud ID. ||
|| createdAt | **string** (date-time)

Sink creation time.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Sink name. ||
|| description | **string**

Sink description. ||
|| labels | **object** (map<**string**, **string**>)

Sink labels. ||
|| serviceAccountId | **string**

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
|| streamName | **string**

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