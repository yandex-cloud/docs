---
editable: false
apiPlayground:
  - url: https://compute.{{ api-host }}/compute/v1/diskTypes
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
            the service returns a [ListDiskTypesResponse.nextPageToken](/docs/compute/api-ref/DiskType/list#yandex.cloud.compute.v1.ListDiskTypesResponse)
            that can be used to get the next page of results in subsequent list requests.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `pageToken` to the
            [ListDiskTypesResponse.nextPageToken](/docs/compute/api-ref/DiskType/list#yandex.cloud.compute.v1.ListDiskTypesResponse) returned by a previous list request.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/compute/v1/api-ref/DiskType/list.md
---

# Compute Cloud API, REST: DiskType.List

Retrieves the list of disk types for the specified folder.

## HTTP request

```
GET https://compute.{{ api-host }}/compute/v1/diskTypes
```

## Query parameters {#yandex.cloud.compute.v1.ListDiskTypesRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListDiskTypesResponse.nextPageToken](#yandex.cloud.compute.v1.ListDiskTypesResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListDiskTypesResponse.nextPageToken](#yandex.cloud.compute.v1.ListDiskTypesResponse) returned by a previous list request. ||
|#

## Response {#yandex.cloud.compute.v1.ListDiskTypesResponse}

**HTTP Code: 200 - OK**

```json
{
  "diskTypes": [
    {
      "id": "string",
      "description": "string",
      "zoneIds": [
        "string"
      ]
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| diskTypes[] | **[DiskType](#yandex.cloud.compute.v1.DiskType)**

List of disk types. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListDiskTypesRequest.pageSize](#yandex.cloud.compute.v1.ListDiskTypesRequest), use
the `nextPageToken` as the value
for the [ListDiskTypesRequest.pageToken](#yandex.cloud.compute.v1.ListDiskTypesRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## DiskType {#yandex.cloud.compute.v1.DiskType}

#|
||Field | Description ||
|| id | **string**

ID of the disk type. ||
|| description | **string**

Description of the disk type. 0-256 characters long. ||
|| zoneIds[] | **string**

Array of availability zones where the disk type is available. ||
|#