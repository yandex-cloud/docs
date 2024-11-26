---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/api-ref/grpc/Group/list.md
---

# Cloud Organization API, gRPC: GroupService.List

Retrieves the list of group resources.

## gRPC request

**rpc List ([ListGroupsRequest](#yandex.cloud.organizationmanager.v1.ListGroupsRequest)) returns ([ListGroupsResponse](#yandex.cloud.organizationmanager.v1.ListGroupsResponse))**

## ListGroupsRequest {#yandex.cloud.organizationmanager.v1.ListGroupsRequest}

```json
{
  "organization_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| organization_id | **string**

Required field. ID of the organization to list groups in.
To get the organization ID, use a [yandex.cloud.organizationmanager.v1.OrganizationService.List](/docs/organization/api-ref/grpc/Organization/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListGroupsResponse.next_page_token](#yandex.cloud.organizationmanager.v1.ListGroupsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| page_token | **string**

Page token. Set `page_token`
to the [ListGroupsResponse.next_page_token](#yandex.cloud.organizationmanager.v1.ListGroupsResponse)
returned by a previous list request to get the next page of results. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on the [Group.name](#yandex.cloud.organizationmanager.v1.Group) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. ||
|#

## ListGroupsResponse {#yandex.cloud.organizationmanager.v1.ListGroupsResponse}

```json
{
  "groups": [
    {
      "id": "string",
      "organization_id": "string",
      "created_at": "google.protobuf.Timestamp",
      "name": "string",
      "description": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| groups[] | **[Group](#yandex.cloud.organizationmanager.v1.Group)**

List of Group resources. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListGroupsRequest.page_size](#yandex.cloud.organizationmanager.v1.ListGroupsRequest), use
the `next_page_token` as the value
for the [ListGroupsRequest.page_token](#yandex.cloud.organizationmanager.v1.ListGroupsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## Group {#yandex.cloud.organizationmanager.v1.Group}

A Group resource.
For more information, see [Groups](/docs/organization/operations/manage-groups).

#|
||Field | Description ||
|| id | **string**

ID of the group. ||
|| organization_id | **string**

ID of the organization that the group belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the group. ||
|| description | **string**

Description of the group. ||
|#