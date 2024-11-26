---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/api-ref/grpc/Organization/list.md
---

# Cloud Organization API, gRPC: OrganizationService.List

Retrieves the list of Organization resources.

## gRPC request

**rpc List ([ListOrganizationsRequest](#yandex.cloud.organizationmanager.v1.ListOrganizationsRequest)) returns ([ListOrganizationsResponse](#yandex.cloud.organizationmanager.v1.ListOrganizationsResponse))**

## ListOrganizationsRequest {#yandex.cloud.organizationmanager.v1.ListOrganizationsRequest}

```json
{
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListOrganizationsResponse.next_page_token](#yandex.cloud.organizationmanager.v1.ListOrganizationsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| page_token | **string**

Page token. Set `page_token`
to the [ListOrganizationsResponse.next_page_token](#yandex.cloud.organizationmanager.v1.ListOrganizationsResponse)
returned by a previous list request to get the next page of results. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on the [Organization.name](#yandex.cloud.organizationmanager.v1.Organization) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. ||
|#

## ListOrganizationsResponse {#yandex.cloud.organizationmanager.v1.ListOrganizationsResponse}

```json
{
  "organizations": [
    {
      "id": "string",
      "created_at": "google.protobuf.Timestamp",
      "name": "string",
      "description": "string",
      "title": "string",
      "labels": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| organizations[] | **[Organization](#yandex.cloud.organizationmanager.v1.Organization)**

List of Organization resources. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListOrganizationsRequest.page_size](#yandex.cloud.organizationmanager.v1.ListOrganizationsRequest), use
the `next_page_token` as the value
for the [ListOrganizationsRequest.page_token](#yandex.cloud.organizationmanager.v1.ListOrganizationsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## Organization {#yandex.cloud.organizationmanager.v1.Organization}

An Organization resource. For more information, see [Organization](/docs/organization/enable-org).

#|
||Field | Description ||
|| id | **string**

ID of the organization. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the organization. 3-63 characters long. ||
|| description | **string**

Description of the organization. 0-256 characters long. ||
|| title | **string**

Display name of the organization. 0-256 characters long. ||
|| labels | **string**

Resource labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|#