---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-clickhouse/v1/versions
    method: get
    path: null
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page that should be returned. If the number of available
            results is larger than `pageSize`, the service returns a [ListVersionsResponse.nextPageToken](#yandex.cloud.mdb.clickhouse.v1.ListVersionsResponse) that can be used
            to get the next page of results in subsequent ListVersions requests.
            Default value: 100.
            Acceptable values are 0 to 1000, inclusive.
          default: '100'
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. Set `pageToken` to the [ListVersionsResponse.nextPageToken](#yandex.cloud.mdb.clickhouse.v1.ListVersionsResponse) returned by a previous ListVersions
            request to get the next page of results.
            The maximum string length in characters is 100.
          type: string
      additionalProperties: false
    body: null
    definitions: null
---

# Managed Service for ClickHouse API, REST: Versions.List

Returns list of available ClickHouse versions.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-clickhouse/v1/versions
```

## Query parameters {#yandex.cloud.mdb.clickhouse.v1.ListVersionsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page that should be returned. If the number of available
results is larger than `pageSize`, the service returns a [ListVersionsResponse.nextPageToken](#yandex.cloud.mdb.clickhouse.v1.ListVersionsResponse) that can be used
to get the next page of results in subsequent ListVersions requests.
Default value: 100.

Acceptable values are 0 to 1000, inclusive. ||
|| pageToken | **string**

Page token. Set `pageToken` to the [ListVersionsResponse.nextPageToken](#yandex.cloud.mdb.clickhouse.v1.ListVersionsResponse) returned by a previous ListVersions
request to get the next page of results.

The maximum string length in characters is 100. ||
|#

## Response {#yandex.cloud.mdb.clickhouse.v1.ListVersionsResponse}

**HTTP Code: 200 - OK**

```json
{
  "version": [
    {
      "id": "string",
      "name": "string",
      "deprecated": "boolean",
      "updatableTo": [
        "string"
      ],
      "lts": "boolean",
      "fullVersion": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| version[] | **[Version](#yandex.cloud.mdb.clickhouse.v1.Version)**

Requested list of available versions. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for ListVersions requests,
if the number of results is larger than [ListVersionsRequest.pageSize](#yandex.cloud.mdb.clickhouse.v1.ListVersionsRequest) specified in the request.
To get the next page, specify the value of `nextPageToken` as a value for
the [ListVersionsRequest.pageToken](#yandex.cloud.mdb.clickhouse.v1.ListVersionsRequest) parameter in the next ListVerions request. Subsequent ListVersions
requests will have their own `nextPageToken` to continue paging through the results. ||
|#

## Version {#yandex.cloud.mdb.clickhouse.v1.Version}

#|
||Field | Description ||
|| id | **string**

ID of the version. ||
|| name | **string**

Name of the version. ||
|| deprecated | **boolean**

Whether version is deprecated. ||
|| updatableTo[] | **string**

List of versions that can be updated from current. ||
|| lts | **boolean**

Whether version is LTS. ||
|| fullVersion | **string**

Full version. ||
|#