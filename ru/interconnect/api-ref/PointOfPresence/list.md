---
editable: false
sourcePath: en/_api-ref/cic/v1/api-ref/PointOfPresence/list.md
---

# Cloud Interconnect API, REST: PointOfPresence.List {#List}

Retrieves the list of PointOfPresence resources in the specified folder.

## HTTP request

```
GET https://cic.{{ api-host }}/cic/v1/pointOfPresences
```

## Query parameters {#yandex.cloud.cic.v1.ListPointOfPresencesRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListPointOfPresencesResponse.nextPageToken](#yandex.cloud.cic.v1.ListPointOfPresencesResponse)
that can be used to get the next page of results in subsequent list requests. Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListPointOfPresencesResponse.nextPageToken](#yandex.cloud.cic.v1.ListPointOfPresencesResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on [Subnet.name] field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. ||
|#

## Response {#yandex.cloud.cic.v1.ListPointOfPresencesResponse}

**HTTP Code: 200 - OK**

```json
{
  "pointOfPresences": [
    {
      "id": "string",
      "regionId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| pointOfPresences[] | **[PointOfPresence](#yandex.cloud.cic.v1.PointOfPresence)**

List of PointOfPresence resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListPointOfPresencesRequest.pageSize](#yandex.cloud.cic.v1.ListPointOfPresencesRequest), use
the `nextPageToken` as the value
for the [ListPointOfPresencesRequest.pageToken](#yandex.cloud.cic.v1.ListPointOfPresencesRequest) query parameter
in the next list request. Subsequent list requests will have their own
`nextPageToken` to continue paging through the results. ||
|#

## PointOfPresence {#yandex.cloud.cic.v1.PointOfPresence}

A PointOfPresence resource.

#|
||Field | Description ||
|| id | **string**

ID of the pointOfPresence. ||
|| regionId | **string**

ID of the region that the pointOfPresence belongs to. ||
|#