---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/api-ref/grpc/GroupMapping/updateItems.md
---

# Cloud Organization API, gRPC: GroupMappingService.UpdateItems

Updates group mapping items for a specified federation
Errors:
- if federation is not found
- if internal group in the mapping added does not exist
In case of any error, no changes are applied to existing group mapping

This call is idempotent. The following actions do nothing:
- adding group mapping items that are already present
- removing group mapping items that are not present
Such parts of request will be ignored. Others will be applied.

## gRPC request

**rpc UpdateItems ([UpdateGroupMappingItemsRequest](#yandex.cloud.organizationmanager.v1.UpdateGroupMappingItemsRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateGroupMappingItemsRequest {#yandex.cloud.organizationmanager.v1.UpdateGroupMappingItemsRequest}

```json
{
  "federation_id": "string",
  "group_mapping_item_deltas": [
    {
      "item": {
        "external_group_id": "string",
        "internal_group_id": "string"
      },
      "action": "Action"
    }
  ]
}
```

Request for updating group mapping configuration

#|
||Field | Description ||
|| federation_id | **string**

Required field. Federation the group mapping update is requested ||
|| group_mapping_item_deltas[] | **[GroupMappingItemDelta](#yandex.cloud.organizationmanager.v1.GroupMappingItemDelta)**

A collection of mapping items to add or remove (ignores update_fields). ||
|#

## GroupMappingItemDelta {#yandex.cloud.organizationmanager.v1.GroupMappingItemDelta}

Message describes the user's request to change (add or remove) a single group mapping.

#|
||Field | Description ||
|| item | **[GroupMappingItem](#yandex.cloud.organizationmanager.v1.GroupMappingItem)** ||
|| action | enum **Action**

- `ACTION_UNSPECIFIED`
- `ADD`: Group mapping item is to be added
- `REMOVE`: Group mapping item is to be removed ||
|#

## GroupMappingItem {#yandex.cloud.organizationmanager.v1.GroupMappingItem}

Group mapping represents which external (federated) groups should match which internal (cloud) groups

#|
||Field | Description ||
|| external_group_id | **string**

Required field. External group id (received from identity provider) ||
|| internal_group_id | **string**

Required field. Internal cloud group id ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "federation_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "group_mapping_item_deltas": [
      {
        "item": {
          "external_group_id": "string",
          "internal_group_id": "string"
        },
        "action": "Action"
      }
    ]
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateGroupMappingItemsMetadata](#yandex.cloud.organizationmanager.v1.UpdateGroupMappingItemsMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[UpdateGroupMappingItemsResponse](#yandex.cloud.organizationmanager.v1.UpdateGroupMappingItemsResponse)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## UpdateGroupMappingItemsMetadata {#yandex.cloud.organizationmanager.v1.UpdateGroupMappingItemsMetadata}

#|
||Field | Description ||
|| federation_id | **string** ||
|#

## UpdateGroupMappingItemsResponse {#yandex.cloud.organizationmanager.v1.UpdateGroupMappingItemsResponse}

#|
||Field | Description ||
|| group_mapping_item_deltas[] | **[GroupMappingItemDelta](#yandex.cloud.organizationmanager.v1.GroupMappingItemDelta2)**

Effective changes that were applied ||
|#

## GroupMappingItemDelta {#yandex.cloud.organizationmanager.v1.GroupMappingItemDelta2}

Message describes the user's request to change (add or remove) a single group mapping.

#|
||Field | Description ||
|| item | **[GroupMappingItem](#yandex.cloud.organizationmanager.v1.GroupMappingItem2)** ||
|| action | enum **Action**

- `ACTION_UNSPECIFIED`
- `ADD`: Group mapping item is to be added
- `REMOVE`: Group mapping item is to be removed ||
|#

## GroupMappingItem {#yandex.cloud.organizationmanager.v1.GroupMappingItem2}

Group mapping represents which external (federated) groups should match which internal (cloud) groups

#|
||Field | Description ||
|| external_group_id | **string**

Required field. External group id (received from identity provider) ||
|| internal_group_id | **string**

Required field. Internal cloud group id ||
|#