---
editable: false
---

# Identity Hub API, gRPC: GroupService.ListEffective

Returns groups that the subject belongs to within a specific organization.

## gRPC request

**rpc ListEffective ([ListEffectiveRequest](#yandex.cloud.organizationmanager.v1.ListEffectiveRequest)) returns ([ListEffectiveResponse](#yandex.cloud.organizationmanager.v1.ListEffectiveResponse))**

## ListEffectiveRequest {#yandex.cloud.organizationmanager.v1.ListEffectiveRequest}

```json
{
  "subject_id": "string",
  "organization_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| subject_id | **string**

Required field. ID of the subject to list groups for.

The maximum string length in characters is 50. ||
|| organization_id | **string**

The ID of the organization to scope the group search to.
If omitted and the subject belongs to a single organization,
that organization's ID will be used automatically.

The maximum string length in characters is 50. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListEffectiveResponse.next_page_token](#yandex.cloud.organizationmanager.v1.ListEffectiveResponse)
that can be used to get the next page of results in subsequent list requests.
Acceptable values are 0 to 1000, inclusive. Default value: 100.

Acceptable values are 0 to 1000, inclusive. ||
|| page_token | **string**

Page token. Set `page_token`
to the [ListEffectiveResponse.next_page_token](#yandex.cloud.organizationmanager.v1.ListEffectiveResponse)
returned by a previous list request to get the next page of results.

The maximum string length in characters is 2000. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression supports the following operations:
- `=` for exact match: `name = 'example-name'`
- `IN` for multiple values: `id IN ('id1', 'id2')`
- `contains` for domain substring search: `name contains 'example'`
- `AND` for combining conditions: `name contains 'my-group' AND name contains 'name'`

Available fields for filtering:
- `id` - group ID
- `name` - group name

Must be 1-1000 characters long.

The maximum string length in characters is 1000. ||
|#

## ListEffectiveResponse {#yandex.cloud.organizationmanager.v1.ListEffectiveResponse}

```json
{
  "group_membership_info": [
    {
      "group_id": "string",
      "group_name": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| group_membership_info[] | **[GroupMembershipInfo](#yandex.cloud.organizationmanager.v1.GroupMembershipInfo)**

List of group membership information.
Contains groups where the specified subject is a member. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListEffectiveRequest.page_size](#yandex.cloud.organizationmanager.v1.ListEffectiveRequest), use the `next_page_token` as the value
for the [ListEffectiveRequest.page_token](#yandex.cloud.organizationmanager.v1.ListEffectiveRequest) query parameter in the next list request.
Each subsequent list request will have its own `next_page_token` to continue paging through the results. ||
|#

## GroupMembershipInfo {#yandex.cloud.organizationmanager.v1.GroupMembershipInfo}

#|
||Field | Description ||
|| group_id | **string**

ID of the group the subject is a member of. ||
|| group_name | **string**

Name of the group the subject is a member of. ||
|#