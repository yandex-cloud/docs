---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Channel/update.md
---

# Video API, gRPC: ChannelService.Update

Update channel.

## gRPC request

**rpc Update ([UpdateChannelRequest](#yandex.cloud.video.v1.UpdateChannelRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateChannelRequest {#yandex.cloud.video.v1.UpdateChannelRequest}

```json
{
  "channel_id": "string",
  "field_mask": "google.protobuf.FieldMask",
  "title": "string",
  "description": "string",
  "labels": "map<string, string>"
}
```

#|
||Field | Description ||
|| channel_id | **string**

Required field. ID of the channel. ||
|| field_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the channel are going to be updated. ||
|| title | **string**

Channel title. ||
|| description | **string**

Channel description. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels as `` key:value `` pairs. Maximum 64 per resource. ||
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
    "channel_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "organization_id": "string",
    "title": "string",
    "description": "string",
    "created_at": "google.protobuf.Timestamp",
    "updated_at": "google.protobuf.Timestamp",
    "labels": "map<string, string>"
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
|| metadata | **[UpdateChannelMetadata](#yandex.cloud.video.v1.UpdateChannelMetadata)**

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
|| response | **[Channel](#yandex.cloud.video.v1.Channel)**

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

## UpdateChannelMetadata {#yandex.cloud.video.v1.UpdateChannelMetadata}

#|
||Field | Description ||
|| channel_id | **string**

ID of the channel. ||
|#

## Channel {#yandex.cloud.video.v1.Channel}

Root entity for content separation.

#|
||Field | Description ||
|| id | **string**

ID of the channel. ||
|| organization_id | **string**

ID of the organization where channel should be created. ||
|| title | **string**

Channel title. ||
|| description | **string**

Channel description. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when channel was created. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time of last channel update. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels as `` key:value `` pairs. Maximum 64 per resource. ||
|#