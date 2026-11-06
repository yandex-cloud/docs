---
editable: false
apiPlayground:
  - url: https://baremetal.{{ api-host }}/v2/extend/stacklandClusters/versions
    method: get
    path: null
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is greater than `page_size`,
            the service returns a [ListStacklandVersionsResponse.nextPageToken](#yandex.cloud.baremetal.v2.extend.ListStacklandVersionsResponse)
            that can be used to get the next page of results in subsequent list requests.
            Default value is 20.
            The maximum value is 1000.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `page_token` to the
            [ListStacklandVersionsResponse.nextPageToken](#yandex.cloud.baremetal.v2.extend.ListStacklandVersionsResponse) returned by a previous list request.
          type: string
      additionalProperties: false
    body: null
    definitions: null
---

# Extend API, REST: StacklandCluster.ListStacklandVersions

Lists of available stackland versions.


## HTTP request

```
GET https://baremetal.{{ api-host }}/v2/extend/stacklandClusters/versions
```

## Query parameters {#yandex.cloud.baremetal.v2.extend.ListStacklandVersionsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is greater than `page_size`,
the service returns a [ListStacklandVersionsResponse.nextPageToken](#yandex.cloud.baremetal.v2.extend.ListStacklandVersionsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20.

The maximum value is 1000. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListStacklandVersionsResponse.nextPageToken](#yandex.cloud.baremetal.v2.extend.ListStacklandVersionsResponse) returned by a previous list request. ||
|#

## Response {#yandex.cloud.baremetal.v2.extend.ListStacklandVersionsResponse}

**HTTP Code: 200 - OK**

```json
{
  "stacklandVersions": [
    {
      "stacklandVersionId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| stacklandVersions[] | **[StacklandVersion](#yandex.cloud.baremetal.v2.extend.StacklandVersion)**

List of StacklandVersion resources. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListStacklandVersionsRequest.pageSize](#yandex.cloud.baremetal.v2.extend.ListStacklandVersionsRequest), use `next_page_token` as the value
for the [ListStacklandVersionsRequest.pageToken](#yandex.cloud.baremetal.v2.extend.ListStacklandVersionsRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## StacklandVersion {#yandex.cloud.baremetal.v2.extend.StacklandVersion}

#|
||Field | Description ||
|| stacklandVersionId | **string**

Stackland version. ||
|#