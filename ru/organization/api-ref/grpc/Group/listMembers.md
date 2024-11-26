---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/api-ref/grpc/Group/listMembers.md
---

# Cloud Organization API, gRPC: GroupService.ListMembers

List group active members.

## gRPC request

**rpc ListMembers ([ListGroupMembersRequest](#yandex.cloud.organizationmanager.v1.ListGroupMembersRequest)) returns ([ListGroupMembersResponse](#yandex.cloud.organizationmanager.v1.ListGroupMembersResponse))**

## ListGroupMembersRequest {#yandex.cloud.organizationmanager.v1.ListGroupMembersRequest}

```json
{
  "group_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| group_id | **string**

Required field. ID of the Group resource to list members for. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListGroupMembersResponse.next_page_token](#yandex.cloud.organizationmanager.v1.ListGroupMembersResponse)
that can be used to get the next page of results in subsequent list requests.
Acceptable values are 0 to 1000, inclusive. Default value: 100. ||
|| page_token | **string**

Page token. Set `page_token`
to the [ListGroupMembersResponse.next_page_token](#yandex.cloud.organizationmanager.v1.ListGroupMembersResponse)
returned by a previous list request to get the next page of results. ||
|#

## ListGroupMembersResponse {#yandex.cloud.organizationmanager.v1.ListGroupMembersResponse}

```json
{
  "members": [
    {
      "subject_id": "string",
      "subject_type": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| members[] | **[GroupMember](#yandex.cloud.organizationmanager.v1.GroupMember)**

List of members for the specified group. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListGroupMembersRequest.page_size](#yandex.cloud.organizationmanager.v1.ListGroupMembersRequest), use the `next_page_token` as the value
for the [ListGroupMembersRequest.page_token](#yandex.cloud.organizationmanager.v1.ListGroupMembersRequest) query parameter in the next list request.
Each subsequent list request will have its own `next_page_token` to continue paging through the results. ||
|#

## GroupMember {#yandex.cloud.organizationmanager.v1.GroupMember}

#|
||Field | Description ||
|| subject_id | **string**

ID of the subject. ||
|| subject_type | **string**

Type of the subject.

It can contain one of the following values:
* `userAccount`: An account on Yandex, added to Yandex Cloud.
* `federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory. ||
|#