---
editable: false
sourcePath: en/_api-ref-grpc/datasphere/v2/api-ref/grpc/Community/get.md
---

# DataSphere API v2, gRPC: CommunityService.Get {#Get}

Returns community.

## gRPC request

**rpc Get ([GetCommunityRequest](#yandex.cloud.datasphere.v2.GetCommunityRequest)) returns ([Community](#yandex.cloud.datasphere.v2.Community))**

## GetCommunityRequest {#yandex.cloud.datasphere.v2.GetCommunityRequest}

```json
{
  "communityId": "string"
}
```

#|
||Field | Description ||
|| communityId | **string**

Required field. ID of the community. ||
|#

## Community {#yandex.cloud.datasphere.v2.Community}

```json
{
  "id": "string",
  "createdAt": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "labels": "string",
  "createdById": "string",
  "organizationId": "string",
  "zoneId": "string"
}
```

#|
||Field | Description ||
|| id | **string**

ID of the community. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when community was created. ||
|| name | **string**

Name of the community. ||
|| description | **string**

Description of the comminuty. ||
|| labels | **string**

Labels of the community. ||
|| createdById | **string**

ID of the user who created the community. ||
|| organizationId | **string**

ID of the organization to which community belongs. ||
|| zoneId | **string**

ID of the zone where this community was created ||
|#