---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/api-ref/grpc/GroupMapping/listItems.md
---

# Cloud Organization API, gRPC: GroupMappingService.ListItems {#ListItems}

Returns all the group mappings items

Filtering is only supported by external_group_id or internal_group_id

## gRPC request

**rpc ListItems ([ListGroupMappingItemsRequest](#yandex.cloud.organizationmanager.v1.ListGroupMappingItemsRequest)) returns ([ListGroupMappingItemsResponse](#yandex.cloud.organizationmanager.v1.ListGroupMappingItemsResponse))**

## ListGroupMappingItemsRequest {#yandex.cloud.organizationmanager.v1.ListGroupMappingItemsRequest}

```json
{
  "federationId": "string",
  "pageSize": "int64",
  "pageToken": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| federationId | **string**

Required field.  ||
|| pageSize | **int64** ||
|| pageToken | **string** ||
|| filter | **string** ||
|#

## ListGroupMappingItemsResponse {#yandex.cloud.organizationmanager.v1.ListGroupMappingItemsResponse}

```json
{
  "groupMappingItems": [
    {
      "externalGroupId": "string",
      "internalGroupId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| groupMappingItems[] | **[GroupMappingItem](#yandex.cloud.organizationmanager.v1.GroupMappingItem)** ||
|| nextPageToken | **string** ||
|#

## GroupMappingItem {#yandex.cloud.organizationmanager.v1.GroupMappingItem}

Group mapping represents which external (federated) groups should match which internal (cloud) groups

#|
||Field | Description ||
|| externalGroupId | **string**

Required field. External group id (received from identity provider) ||
|| internalGroupId | **string**

Required field. Internal cloud group id ||
|#