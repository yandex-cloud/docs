---
editable: false
sourcePath: en/_api-ref-grpc/resourcemanager/v1/api-ref/grpc/Cloud/get.md
---

# Resource Manager API, gRPC: CloudService.Get {#Get}

Returns the specified Cloud resource.

To get the list of available Cloud resources, make a [List](/docs/resource-manager/api-ref/grpc/Cloud/list#List) request.

## gRPC request

**rpc Get ([GetCloudRequest](#yandex.cloud.resourcemanager.v1.GetCloudRequest)) returns ([Cloud](#yandex.cloud.resourcemanager.v1.Cloud))**

## GetCloudRequest {#yandex.cloud.resourcemanager.v1.GetCloudRequest}

```json
{
  "cloudId": "string"
}
```

#|
||Field | Description ||
|| cloudId | **string**

Required field. ID of the Cloud resource to return.
To get the cloud ID, use a [CloudService.List](/docs/resource-manager/api-ref/grpc/Cloud/list#List) request. ||
|#

## Cloud {#yandex.cloud.resourcemanager.v1.Cloud}

```json
{
  "id": "string",
  "createdAt": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "organizationId": "string",
  "labels": "string"
}
```

A Cloud resource. For more information, see [Cloud](/docs/resource-manager/concepts/resources-hierarchy#cloud).

#|
||Field | Description ||
|| id | **string**

ID of the cloud. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the cloud. 3-63 characters long. ||
|| description | **string**

Description of the cloud. 0-256 characters long. ||
|| organizationId | **string**

ID of the organization that the cloud belongs to. ||
|| labels | **string**

Resource labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|#