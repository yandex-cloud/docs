---
editable: false
sourcePath: en/_api-ref/cic/v1/api-ref/Partner/list.md
---

# Cloud Interconnect API, REST: Partner.List {#List}

Retrieves the list of Partner resources in the specified folder.

## HTTP request

```
GET https://cic-api.{{ api-host }}/cic/v1/partners
```

## Query parameters {#yandex.cloud.cic.v1.ListPartnersRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListPartnersResponse.nextPageToken](#yandex.cloud.cic.v1.ListPartnersResponse)
that can be used to get the next page of results in subsequent list requests. Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListPartnersResponse.nextPageToken](#yandex.cloud.cic.v1.ListPartnersResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on [Subnet.name] field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. ||
|#

## Response {#yandex.cloud.cic.v1.ListPartnersResponse}

**HTTP Code: 200 - OK**

```json
{
  "partners": [
    {
      "id": "string",
      "regionId": "string",
      "status": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| partners[] | **[Partner](#yandex.cloud.cic.v1.Partner)**

List of Partner resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListPartnersRequest.pageSize](#yandex.cloud.cic.v1.ListPartnersRequest), use
the `nextPageToken` as the value
for the [ListPartnersRequest.pageToken](#yandex.cloud.cic.v1.ListPartnersRequest) query parameter
in the next list request. Subsequent list requests will have their own
`nextPageToken` to continue paging through the results. ||
|#

## Partner {#yandex.cloud.cic.v1.Partner}

A Partner resource.

#|
||Field | Description ||
|| id | **string**

ID of the routingInstance. ||
|| regionId | **string**

ID of the region that the partner belongs to. ||
|| status | **enum** (Status)

Status of the partner.

- `STATUS_UNSPECIFIED`
- `UP`
- `DOWN` ||
|#