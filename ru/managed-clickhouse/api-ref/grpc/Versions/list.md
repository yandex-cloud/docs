---
editable: false
sourcePath: en/_api-ref-grpc/mdb/clickhouse/v1/api-ref/grpc/Versions/list.md
---

# Managed Service for ClickHouse API, gRPC: VersionsService.List

Returns list of available ClickHouse versions.

## gRPC request

**rpc List ([ListVersionsRequest](#yandex.cloud.mdb.clickhouse.v1.ListVersionsRequest)) returns ([ListVersionsResponse](#yandex.cloud.mdb.clickhouse.v1.ListVersionsResponse))**

## ListVersionsRequest {#yandex.cloud.mdb.clickhouse.v1.ListVersionsRequest}

```json
{
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| page_size | **int64**

The maximum number of results per page that should be returned. If the number of available
results is larger than `page_size`, the service returns a [ListVersionsResponse.next_page_token](#yandex.cloud.mdb.clickhouse.v1.ListVersionsResponse) that can be used
to get the next page of results in subsequent ListVersions requests.
Default value: 100. ||
|| page_token | **string**

Page token. Set `page_token` to the [ListVersionsResponse.next_page_token](#yandex.cloud.mdb.clickhouse.v1.ListVersionsResponse) returned by a previous ListVersions
request to get the next page of results. ||
|#

## ListVersionsResponse {#yandex.cloud.mdb.clickhouse.v1.ListVersionsResponse}

```json
{
  "version": [
    {
      "id": "string",
      "name": "string",
      "deprecated": "bool",
      "updatable_to": [
        "string"
      ]
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| version[] | **[Version](#yandex.cloud.mdb.clickhouse.v1.Version)**

Requested list of available versions. ||
|| next_page_token | **string**

This token allows you to get the next page of results for ListVersions requests,
if the number of results is larger than [ListVersionsRequest.page_size](#yandex.cloud.mdb.clickhouse.v1.ListVersionsRequest) specified in the request.
To get the next page, specify the value of `next_page_token` as a value for
the [ListVersionsRequest.page_token](#yandex.cloud.mdb.clickhouse.v1.ListVersionsRequest) parameter in the next ListVerions request. Subsequent ListVersions
requests will have their own `next_page_token` to continue paging through the results. ||
|#

## Version {#yandex.cloud.mdb.clickhouse.v1.Version}

#|
||Field | Description ||
|| id | **string**

ID of the version. ||
|| name | **string**

Name of the version. ||
|| deprecated | **bool**

Whether version is deprecated. ||
|| updatable_to[] | **string**

List of versions that can be updated from current. ||
|#