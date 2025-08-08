---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/groups
    method: get
    path: null
    query:
      type: object
      properties:
        organizationId:
          description: |-
            **string**
            Required field. ID of the organization to list groups in.
            To get the organization ID, use a [yandex.cloud.organizationmanager.v1.OrganizationService.List](/docs/organization/api-ref/Organization/list#List) request.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `pageSize`,
            the service returns a [ListGroupsResponse.nextPageToken](/docs/organization/api-ref/Group/list#yandex.cloud.organizationmanager.v1.ListGroupsResponse)
            that can be used to get the next page of results in subsequent list requests.
            Default value: 100.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. Set `pageToken`
            to the [ListGroupsResponse.nextPageToken](/docs/organization/api-ref/Group/list#yandex.cloud.organizationmanager.v1.ListGroupsResponse)
            returned by a previous list request to get the next page of results.
          type: string
        filter:
          description: |-
            **string**
            A filter expression that filters resources listed in the response.
            The expression must specify:
            1. The field name. Currently you can use filtering only on the [Group.name](/docs/organization/api-ref/Group/get#yandex.cloud.organizationmanager.v1.Group) field.
            2. An `=` operator.
            3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.
          type: string
      required:
        - organizationId
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/organizationmanager/v1/api-ref/Group/list.md
---

# Identity Hub API, REST: Group.List

Retrieves the list of group resources.

## HTTP request

```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/groups
```

## Query parameters {#yandex.cloud.organizationmanager.v1.ListGroupsRequest}

#|
||Field | Description ||
|| organizationId | **string**

Required field. ID of the organization to list groups in.
To get the organization ID, use a [yandex.cloud.organizationmanager.v1.OrganizationService.List](/docs/organization/api-ref/Organization/list#List) request. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListGroupsResponse.nextPageToken](#yandex.cloud.organizationmanager.v1.ListGroupsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. Set `pageToken`
to the [ListGroupsResponse.nextPageToken](#yandex.cloud.organizationmanager.v1.ListGroupsResponse)
returned by a previous list request to get the next page of results. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on the [Group.name](#yandex.cloud.organizationmanager.v1.Group) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. ||
|#

## Response {#yandex.cloud.organizationmanager.v1.ListGroupsResponse}

**HTTP Code: 200 - OK**

```json
{
  "groups": [
    {
      "id": "string",
      "organizationId": "string",
      "createdAt": "string",
      "name": "string",
      "description": "string",
      "subjectContainerId": "string",
      "externalId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| groups[] | **[Group](#yandex.cloud.organizationmanager.v1.Group)**

List of Group resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListGroupsRequest.pageSize](#yandex.cloud.organizationmanager.v1.ListGroupsRequest), use
the `nextPageToken` as the value
for the [ListGroupsRequest.pageToken](#yandex.cloud.organizationmanager.v1.ListGroupsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## Group {#yandex.cloud.organizationmanager.v1.Group}

A Group resource.
For more information, see [Groups](/docs/organization/operations/manage-groups).

#|
||Field | Description ||
|| id | **string**

ID of the group. ||
|| organizationId | **string**

ID of the organization that the group belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the group. ||
|| description | **string**

Description of the group. ||
|| subjectContainerId | **string**

Id of the subject container that external group belongs to. It is set if group is external. ||
|| externalId | **string**

Id of the group from external system. It is set if group is external. ||
|#