---
editable: false
sourcePath: en/_api-ref-grpc/datasphere/v2/api-ref/grpc/Community/list.md
---

# DataSphere API v2, gRPC: CommunityService.List

List communities in specified organization.

## gRPC request

**rpc List ([ListCommunitiesRequest](#yandex.cloud.datasphere.v2.ListCommunitiesRequest)) returns ([ListCommunitiesResponse](#yandex.cloud.datasphere.v2.ListCommunitiesResponse))**

## ListCommunitiesRequest {#yandex.cloud.datasphere.v2.ListCommunitiesRequest}

```json
{
  "page_size": "int64",
  "page_token": "string",
  "name_or_description_pattern": "string",
  "owned_by_id": "string",
  "list_public": "bool",
  "organization_id": "string"
}
```

#|
||Field | Description ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListCommunitiesResponse.next_page_token](#yandex.cloud.datasphere.v2.ListCommunitiesResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListCommunitiesResponse.next_page_token](#yandex.cloud.datasphere.v2.ListCommunitiesResponse) returned by a previous list request. ||
|| name_or_description_pattern | **string**

Community name or description pattern.
Only communities with names or descriptions matching specified pattern will be returned. ||
|| owned_by_id | **string**

ID of the user. Only communities owned by specified user will be returned. ||
|| list_public | **bool**

If set to true, only public communities will be returned. ||
|| organization_id | **string**

Required field. ID of the organization to list communities in. ||
|#

## ListCommunitiesResponse {#yandex.cloud.datasphere.v2.ListCommunitiesResponse}

```json
{
  "communities": [
    {
      "id": "string",
      "created_at": "google.protobuf.Timestamp",
      "name": "string",
      "description": "string",
      "labels": "string",
      "created_by_id": "string",
      "organization_id": "string",
      "zone_id": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| communities[] | **[Community](#yandex.cloud.datasphere.v2.Community)**

List of communities matching filters in list communities request. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListCommunitiesRequest.page_size](#yandex.cloud.datasphere.v2.ListCommunitiesRequest), use
the `next_page_token` as the value
for the [ListCommunitiesRequest.page_token](#yandex.cloud.datasphere.v2.ListCommunitiesRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## Community {#yandex.cloud.datasphere.v2.Community}

#|
||Field | Description ||
|| id | **string**

ID of the community. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when community was created. ||
|| name | **string**

Name of the community. ||
|| description | **string**

Description of the comminuty. ||
|| labels | **string**

Labels of the community. ||
|| created_by_id | **string**

ID of the user who created the community. ||
|| organization_id | **string**

ID of the organization to which community belongs. ||
|| zone_id | **string**

ID of the zone where this community was created ||
|#