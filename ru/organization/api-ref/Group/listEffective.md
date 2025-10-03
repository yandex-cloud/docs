---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/groups:listEffective
    method: get
    path: null
    query:
      type: object
      properties:
        subjectId:
          description: |-
            **string**
            Required field. ID of the subject to list groups for.
          type: string
        organizationId:
          description: |-
            **string**
            The ID of the organization to scope the group search to.
            If omitted and the subject belongs to a single organization,
            that organization's ID will be used automatically.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `pageSize`, the service returns a [ListEffectiveResponse.nextPageToken](#yandex.cloud.organizationmanager.v1.ListEffectiveResponse)
            that can be used to get the next page of results in subsequent list requests.
            Acceptable values are 0 to 1000, inclusive. Default value: 100.
          default: '100'
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. Set `pageToken`
            to the [ListEffectiveResponse.nextPageToken](#yandex.cloud.organizationmanager.v1.ListEffectiveResponse)
            returned by a previous list request to get the next page of results.
          type: string
        filter:
          description: |-
            **string**
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
          type: string
      required:
        - subjectId
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/organizationmanager/v1/api-ref/Group/listEffective.md
---

# Identity Hub API, REST: Group.ListEffective

Returns groups that the subject belongs to within a specific organization.

## HTTP request

```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/groups:listEffective
```

## Query parameters {#yandex.cloud.organizationmanager.v1.ListEffectiveRequest}

#|
||Field | Description ||
|| subjectId | **string**

Required field. ID of the subject to list groups for. ||
|| organizationId | **string**

The ID of the organization to scope the group search to.
If omitted and the subject belongs to a single organization,
that organization's ID will be used automatically. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListEffectiveResponse.nextPageToken](#yandex.cloud.organizationmanager.v1.ListEffectiveResponse)
that can be used to get the next page of results in subsequent list requests.
Acceptable values are 0 to 1000, inclusive. Default value: 100. ||
|| pageToken | **string**

Page token. Set `pageToken`
to the [ListEffectiveResponse.nextPageToken](#yandex.cloud.organizationmanager.v1.ListEffectiveResponse)
returned by a previous list request to get the next page of results. ||
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

Must be 1-1000 characters long. ||
|#

## Response {#yandex.cloud.organizationmanager.v1.ListEffectiveResponse}

**HTTP Code: 200 - OK**

```json
{
  "groupMembershipInfo": [
    {
      "groupId": "string",
      "groupName": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| groupMembershipInfo[] | **[GroupMembershipInfo](#yandex.cloud.organizationmanager.v1.GroupMembershipInfo)**

List of group membership information.
Contains groups where the specified subject is a member. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListEffectiveRequest.pageSize](#yandex.cloud.organizationmanager.v1.ListEffectiveRequest), use the `nextPageToken` as the value
for the [ListEffectiveRequest.pageToken](#yandex.cloud.organizationmanager.v1.ListEffectiveRequest) query parameter in the next list request.
Each subsequent list request will have its own `nextPageToken` to continue paging through the results. ||
|#

## GroupMembershipInfo {#yandex.cloud.organizationmanager.v1.GroupMembershipInfo}

#|
||Field | Description ||
|| groupId | **string**

ID of the group the subject is a member of. ||
|| groupName | **string**

Name of the group the subject is a member of. ||
|#