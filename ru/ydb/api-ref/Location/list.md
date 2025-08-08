---
editable: false
apiPlayground:
  - url: https://ydb.{{ api-host }}/ydb/v1/locations
    method: get
    path: null
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page that should be returned. If the number of available
            results is larger than `page_size`, the service returns a `next_page_token` that can be used
            to get the next page of results in subsequent ListLocations requests.
            Acceptable values are 0 to 1000, inclusive. Default value: 100.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. Set `page_token` to the `next_page_token` returned by a previous ListLocations
            request to get the next page of results.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/ydb/v1/api-ref/Location/list.md
---

# Managed Service for YDB API, REST: Location.List

Returns the list of available locations.

## HTTP request

```
GET https://ydb.{{ api-host }}/ydb/v1/locations
```

## Query parameters {#yandex.cloud.ydb.v1.ListLocationsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page that should be returned. If the number of available
results is larger than `page_size`, the service returns a `next_page_token` that can be used
to get the next page of results in subsequent ListLocations requests.
Acceptable values are 0 to 1000, inclusive. Default value: 100. ||
|| pageToken | **string**

Page token. Set `page_token` to the `next_page_token` returned by a previous ListLocations
request to get the next page of results. ||
|#

## Response {#yandex.cloud.ydb.v1.ListLocationsResponse}

**HTTP Code: 200 - OK**

```json
{
  "locations": [
    {
      "id": "string",
      "description": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| locations[] | **[Location](#yandex.cloud.ydb.v1.Location)**

Requested list of locations. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for ListLocations requests,
if the number of results is larger than `page_size` specified in the request.
To get the next page, specify the value of `next_page_token` as a value for
the `page_token` parameter in the next ListLocations request. Subsequent ListLocations
requests will have their own `next_page_token` to continue paging through the results. ||
|#

## Location {#yandex.cloud.ydb.v1.Location}

#|
||Field | Description ||
|| id | **string** ||
|| description | **string** ||
|#