---
editable: false
sourcePath: en/_api-ref-grpc/loadtesting/api/v1/user/api-ref/grpc/Config/list.md
---

# Load Testing API, gRPC: ConfigService.List {#List}

Retrieves the list of configs in the specified folder.

## gRPC request

**rpc List ([ListConfigsRequest](#yandex.cloud.loadtesting.api.v1.ListConfigsRequest)) returns ([ListConfigsResponse](#yandex.cloud.loadtesting.api.v1.ListConfigsResponse))**

## ListConfigsRequest {#yandex.cloud.loadtesting.api.v1.ListConfigsRequest}

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

ID of the folder to list configs in. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListConfigsResponse.nextPageToken](#yandex.cloud.loadtesting.api.v1.ListConfigsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListConfigsResponse.nextPageToken](#yandex.cloud.loadtesting.api.v1.ListConfigsResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters tests listed in the response. ||
|#

## ListConfigsResponse {#yandex.cloud.loadtesting.api.v1.ListConfigsResponse}

```json
{
  "configs": [
    {
      "id": "string",
      "folderId": "string",
      "yamlString": "string",
      "name": "string",
      "createdAt": "google.protobuf.Timestamp",
      "createdBy": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| configs[] | **[Config](#yandex.cloud.loadtesting.api.v1.config.Config)**

List of configs in the specified folder. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListConfigsRequest.pageSize](#yandex.cloud.loadtesting.api.v1.ListConfigsRequest), use `next_page_token` as the value
for the [ListConfigsRequest.pageToken](#yandex.cloud.loadtesting.api.v1.ListConfigsRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## Config {#yandex.cloud.loadtesting.api.v1.config.Config}

Test config.

#|
||Field | Description ||
|| id | **string**

ID of the test config. Generated at creation time. ||
|| folderId | **string**

ID of the folder that the config belongs to. ||
|| yamlString | **string**

Config content in YAML format. ||
|| name | **string**

Name of the config. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

UA or SA that created the config. ||
|#