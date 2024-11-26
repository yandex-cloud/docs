---
editable: false
sourcePath: en/_api-ref-grpc/cic/v1/api-ref/grpc/PointOfPresence/list.md
---

# Cloud Interconnect API, gRPC: PointOfPresenceService.List

Retrieves the list of PointOfPresence resources in the specified folder.

## gRPC request

**rpc List ([ListPointOfPresencesRequest](#yandex.cloud.cic.v1.ListPointOfPresencesRequest)) returns ([ListPointOfPresencesResponse](#yandex.cloud.cic.v1.ListPointOfPresencesResponse))**

## ListPointOfPresencesRequest {#yandex.cloud.cic.v1.ListPointOfPresencesRequest}

```json
{
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListPointOfPresencesResponse.next_page_token](#yandex.cloud.cic.v1.ListPointOfPresencesResponse)
that can be used to get the next page of results in subsequent list requests. Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListPointOfPresencesResponse.next_page_token](#yandex.cloud.cic.v1.ListPointOfPresencesResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on [Subnet.name] field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. ||
|#

## ListPointOfPresencesResponse {#yandex.cloud.cic.v1.ListPointOfPresencesResponse}

```json
{
  "point_of_presences": [
    {
      "id": "string",
      "region_id": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| point_of_presences[] | **[PointOfPresence](#yandex.cloud.cic.v1.PointOfPresence)**

List of PointOfPresence resources. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListPointOfPresencesRequest.page_size](#yandex.cloud.cic.v1.ListPointOfPresencesRequest), use
the `next_page_token` as the value
for the [ListPointOfPresencesRequest.page_token](#yandex.cloud.cic.v1.ListPointOfPresencesRequest) query parameter
in the next list request. Subsequent list requests will have their own
`next_page_token` to continue paging through the results. ||
|#

## PointOfPresence {#yandex.cloud.cic.v1.PointOfPresence}

A PointOfPresence resource.

#|
||Field | Description ||
|| id | **string**

ID of the pointOfPresence. ||
|| region_id | **string**

ID of the region that the pointOfPresence belongs to. ||
|#