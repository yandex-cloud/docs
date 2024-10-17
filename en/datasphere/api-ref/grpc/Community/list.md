---
editable: false
sourcePath: en/_api-ref-grpc/datasphere/v2/api-ref/grpc/Community/list.md
---

# DataSphere API v2, gRPC: CommunityService.List {#List}

List communities in specified organization.

## gRPC request

**rpc List ([ListCommunitiesRequest](#yandex.cloud.datasphere.v2.ListCommunitiesRequest)) returns ([ListCommunitiesResponse](#yandex.cloud.datasphere.v2.ListCommunitiesResponse))**

## ListCommunitiesRequest {#yandex.cloud.datasphere.v2.ListCommunitiesRequest}

```json
{
  "pageSize": "int64",
  "pageToken": "string",
  "nameOrDescriptionPattern": "string",
  "ownedById": "string",
  "listPublic": "bool",
  "organizationId": "string"
}
```

#|
||Field | Description ||
|| pageSize | **int64**

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
|| listPublic | **bool**

If set to true, only public communities will be returned. ||
|| organizationId | **string**

Required field. ID of the organization to list communities in. ||
|#

## ListCommunitiesResponse {#yandex.cloud.datasphere.v2.ListCommunitiesResponse}

```json
{
  "communities": [
    {
      "id": "string",
      "createdAt": "google.protobuf.Timestamp",
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when community was created. ||
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