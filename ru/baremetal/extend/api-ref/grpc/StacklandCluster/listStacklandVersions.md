---
editable: false
---

# Extend API, gRPC: StacklandClusterService.ListStacklandVersions

Lists of available stackland versions.


## gRPC request

**rpc ListStacklandVersions ([ListStacklandVersionsRequest](#yandex.cloud.baremetal.v2.extend.ListStacklandVersionsRequest)) returns ([ListStacklandVersionsResponse](#yandex.cloud.baremetal.v2.extend.ListStacklandVersionsResponse))**

## ListStacklandVersionsRequest {#yandex.cloud.baremetal.v2.extend.ListStacklandVersionsRequest}

```json
{
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is greater than `page_size`,
the service returns a [ListStacklandVersionsResponse.next_page_token](#yandex.cloud.baremetal.v2.extend.ListStacklandVersionsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20.

The maximum value is 1000. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListStacklandVersionsResponse.next_page_token](#yandex.cloud.baremetal.v2.extend.ListStacklandVersionsResponse) returned by a previous list request. ||
|#

## ListStacklandVersionsResponse {#yandex.cloud.baremetal.v2.extend.ListStacklandVersionsResponse}

```json
{
  "stackland_versions": [
    {
      "stackland_version_id": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| stackland_versions[] | **[StacklandVersion](#yandex.cloud.baremetal.v2.extend.StacklandVersion)**

List of StacklandVersion resources. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListStacklandVersionsRequest.page_size](#yandex.cloud.baremetal.v2.extend.ListStacklandVersionsRequest), use `next_page_token` as the value
for the [ListStacklandVersionsRequest.page_token](#yandex.cloud.baremetal.v2.extend.ListStacklandVersionsRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## StacklandVersion {#yandex.cloud.baremetal.v2.extend.StacklandVersion}

#|
||Field | Description ||
|| stackland_version_id | **string**

Stackland version. ||
|#