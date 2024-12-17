---
editable: false
sourcePath: en/_api-ref-grpc/datasphere/v2/api-ref/grpc/Community/get.md
---

# DataSphere API v2, gRPC: CommunityService.Get

Returns community.

## gRPC request

**rpc Get ([GetCommunityRequest](#yandex.cloud.datasphere.v2.GetCommunityRequest)) returns ([Community](#yandex.cloud.datasphere.v2.Community))**

## GetCommunityRequest {#yandex.cloud.datasphere.v2.GetCommunityRequest}

```json
{
  "community_id": "string"
}
```

#|
||Field | Description ||
|| community_id | **string**

Required field. ID of the community. ||
|#

## Community {#yandex.cloud.datasphere.v2.Community}

```json
{
  "id": "string",
  "created_at": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "created_by_id": "string",
  "organization_id": "string",
  "zone_id": "string"
}
```

#|
||Field | Description ||
|| id | **string**

ID of the community. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when community was created. ||
|| name | **string**

Name of the community. ||
|| description | **string**

Description of the comminuty. ||
|| labels | **object** (map<**string**, **string**>)

Labels of the community. ||
|| created_by_id | **string**

ID of the user who created the community. ||
|| organization_id | **string**

ID of the organization to which community belongs. ||
|| zone_id | **string**

ID of the zone where this community was created ||
|#