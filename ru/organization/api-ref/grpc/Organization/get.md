---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/api-ref/grpc/Organization/get.md
---

# Cloud Organization API, gRPC: OrganizationService.Get

Returns the specified Organization resource.

To get the list of available Organization resources, make a [List](/docs/organization/api-ref/grpc/Organization/list#List) request.

## gRPC request

**rpc Get ([GetOrganizationRequest](#yandex.cloud.organizationmanager.v1.GetOrganizationRequest)) returns ([Organization](#yandex.cloud.organizationmanager.v1.Organization))**

## GetOrganizationRequest {#yandex.cloud.organizationmanager.v1.GetOrganizationRequest}

```json
{
  "organization_id": "string"
}
```

#|
||Field | Description ||
|| organization_id | **string**

Required field. ID of the Organization resource to return.
To get the organization ID, use a [OrganizationService.List](/docs/organization/api-ref/grpc/Organization/list#List) request. ||
|#

## Organization {#yandex.cloud.organizationmanager.v1.Organization}

```json
{
  "id": "string",
  "created_at": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "title": "string",
  "labels": "map<string, string>"
}
```

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
|| labels | **object** (map<**string**, **string**>)

Resource labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|#