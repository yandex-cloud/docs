---
editable: false
apiPlayground:
  - url: https://compute.{{ api-host }}/compute/v1/hostTypes
    method: get
    path: null
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `pageSize`,
            the service returns a [ListHostTypesResponse.nextPageToken](/docs/compute/api-ref/HostType/list#yandex.cloud.compute.v1.ListHostTypesResponse)
            that can be used to get the next page of results in subsequent list requests.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results,
            set `pageToken` to the [ListHostTypesResponse.nextPageToken](/docs/compute/api-ref/HostType/list#yandex.cloud.compute.v1.ListHostTypesResponse)
            returned by a previous list request.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/compute/v1/api-ref/HostType/list.md
---

# Compute Cloud API, REST: HostType.List

List avaliable host types.

## HTTP request

```
GET https://compute.{{ api-host }}/compute/v1/hostTypes
```

## Query parameters {#yandex.cloud.compute.v1.ListHostTypesRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListHostTypesResponse.nextPageToken](#yandex.cloud.compute.v1.ListHostTypesResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results,
set `pageToken` to the [ListHostTypesResponse.nextPageToken](#yandex.cloud.compute.v1.ListHostTypesResponse)
returned by a previous list request. ||
|#

## Response {#yandex.cloud.compute.v1.ListHostTypesResponse}

**HTTP Code: 200 - OK**

```json
{
  "hostTypes": [
    {
      "id": "string",
      "cores": "string",
      "memory": "string",
      "disks": "string",
      "diskSize": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| hostTypes[] | **[HostType](#yandex.cloud.compute.v1.HostType)**

Lists host types. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListHostTypesRequest.pageSize](#yandex.cloud.compute.v1.ListHostTypesRequest), use `next_page_token` as the value
for the [ListHostTypesRequest.pageToken](#yandex.cloud.compute.v1.ListHostTypesRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## HostType {#yandex.cloud.compute.v1.HostType}

Represents host resources.
Note: Platform can use hosts with different number of memory and cores.
TODO: Do we need sockets here?

#|
||Field | Description ||
|| id | **string**

Unique type identifier. ||
|| cores | **string** (int64)

Total number of cores available for instances. ||
|| memory | **string** (int64)

Ammount of memory available for instances. ||
|| disks | **string** (int64)

Number of local disks available for instances ||
|| diskSize | **string** (int64)

Size of each local disk ||
|#