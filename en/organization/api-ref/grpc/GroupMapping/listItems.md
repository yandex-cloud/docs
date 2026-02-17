---
editable: false
---

# Identity Hub API, gRPC: GroupMappingService.ListItems

Returns all the group mappings items

Filtering is only supported by external_group_id or internal_group_id

## gRPC request

**rpc ListItems ([ListGroupMappingItemsRequest](#yandex.cloud.organizationmanager.v1.ListGroupMappingItemsRequest)) returns ([ListGroupMappingItemsResponse](#yandex.cloud.organizationmanager.v1.ListGroupMappingItemsResponse))**

## ListGroupMappingItemsRequest {#yandex.cloud.organizationmanager.v1.ListGroupMappingItemsRequest}

```json
{
  "federation_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| federation_id | **string**

Required field.

The maximum string length in characters is 50. ||
|| page_size | **int64**

Acceptable values are 0 to 1000, inclusive. ||
|| page_token | **string**

The maximum string length in characters is 2000. ||
|| filter | **string**

The maximum string length in characters is 1000. ||
|#

## ListGroupMappingItemsResponse {#yandex.cloud.organizationmanager.v1.ListGroupMappingItemsResponse}

```json
{
  "group_mapping_items": [
    {
      "external_group_id": "string",
      "internal_group_id": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| group_mapping_items[] | **[GroupMappingItem](#yandex.cloud.organizationmanager.v1.GroupMappingItem)** ||
|| next_page_token | **string** ||
|#

## GroupMappingItem {#yandex.cloud.organizationmanager.v1.GroupMappingItem}

Group mapping represents which external (federated) groups should match which internal (cloud) groups

#|
||Field | Description ||
|| external_group_id | **string**

Required field. External group id (received from identity provider)

The maximum string length in characters is 1000. ||
|| internal_group_id | **string**

Required field. Internal cloud group id

The maximum string length in characters is 50. ||
|#