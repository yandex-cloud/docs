---
editable: false
sourcePath: en/_api-ref/organizationmanager/v1/api-ref/Group/listMembers.md
---

# Cloud Organization API, REST: Group.ListMembers

List group active members.

## HTTP request

```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/groups/{groupId}:listMembers
```

## Path parameters

#|
||Field | Description ||
|| groupId | **string**

Required field. ID of the Group resource to list members for. ||
|#

## Query parameters {#yandex.cloud.organizationmanager.v1.ListGroupMembersRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListGroupMembersResponse.nextPageToken](#yandex.cloud.organizationmanager.v1.ListGroupMembersResponse)
that can be used to get the next page of results in subsequent list requests.
Acceptable values are 0 to 1000, inclusive. Default value: 100. ||
|| pageToken | **string**

Page token. Set `pageToken`
to the [ListGroupMembersResponse.nextPageToken](#yandex.cloud.organizationmanager.v1.ListGroupMembersResponse)
returned by a previous list request to get the next page of results. ||
|#

## Response {#yandex.cloud.organizationmanager.v1.ListGroupMembersResponse}

**HTTP Code: 200 - OK**

```json
{
  "members": [
    {
      "subjectId": "string",
      "subjectType": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| members[] | **[GroupMember](#yandex.cloud.organizationmanager.v1.GroupMember)**

List of members for the specified group. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListGroupMembersRequest.pageSize](#yandex.cloud.organizationmanager.v1.ListGroupMembersRequest), use the `nextPageToken` as the value
for the [ListGroupMembersRequest.pageToken](#yandex.cloud.organizationmanager.v1.ListGroupMembersRequest) query parameter in the next list request.
Each subsequent list request will have its own `nextPageToken` to continue paging through the results. ||
|#

## GroupMember {#yandex.cloud.organizationmanager.v1.GroupMember}

#|
||Field | Description ||
|| subjectId | **string**

ID of the subject. ||
|| subjectType | **string**

Type of the subject.

It can contain one of the following values:
* `userAccount`: An account on Yandex, added to Yandex Cloud.
* `federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory. ||
|#