---
editable: false
sourcePath: en/_api-ref/datasphere/v2/api-ref/Community/list.md
---

# DataSphere API v2, REST: Community.List {#List}

List communities in specified organization.

## HTTP request

```
GET https://datasphere.{{ api-host }}/datasphere/v2/communities
```

## Query parameters {#yandex.cloud.datasphere.v2.ListCommunitiesRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListCommunitiesResponse.nextPageToken](#yandex.cloud.datasphere.v2.ListCommunitiesResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListCommunitiesResponse.nextPageToken](#yandex.cloud.datasphere.v2.ListCommunitiesResponse) returned by a previous list request. ||
|| nameOrDescriptionPattern | **string**

Community name or description pattern.
Only communities with names or descriptions matching specified pattern will be returned. ||
|| ownedById | **string**

ID of the user. Only communities owned by specified user will be returned. ||
|| listPublic | **boolean**

If set to true, only public communities will be returned. ||
|| organizationId | **string**

Required field. ID of the organization to list communities in. ||
|#

## Response {#yandex.cloud.datasphere.v2.ListCommunitiesResponse}

**HTTP Code: 200 - OK**

```json
{
  "communities": [
    {
      "id": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "labels": "string",
      "createdById": "string",
      "organizationId": "string",
      "zoneId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| communities[] | **[Community](#yandex.cloud.datasphere.v2.Community)**

List of communities matching filters in list communities request. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListCommunitiesRequest.pageSize](#yandex.cloud.datasphere.v2.ListCommunitiesRequest), use
the `nextPageToken` as the value
for the [ListCommunitiesRequest.pageToken](#yandex.cloud.datasphere.v2.ListCommunitiesRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## Community {#yandex.cloud.datasphere.v2.Community}

#|
||Field | Description ||
|| id | **string**

ID of the community. ||
|| createdAt | **string** (date-time)

Time when community was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the community. ||
|| description | **string**

Description of the comminuty. ||
|| labels | **string**

Labels of the community. ||
|| createdById | **string**

ID of the user who created the community. ||
|| organizationId | **string**

ID of the organization to which community belongs. ||
|| zoneId | **string**

ID of the zone where this community was created ||
|#