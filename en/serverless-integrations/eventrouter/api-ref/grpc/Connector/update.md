---
editable: false
sourcePath: en/_api-ref-grpc/serverless/eventrouter/v1/eventrouter/api-ref/grpc/Connector/update.md
---

# EventRouter Service, gRPC: ConnectorService.Update {#Update}

Updates the specified connector.

## gRPC request

**rpc Update ([UpdateConnectorRequest](#yandex.cloud.serverless.eventrouter.v1.UpdateConnectorRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateConnectorRequest {#yandex.cloud.serverless.eventrouter.v1.UpdateConnectorRequest}

```json
{
  "connectorId": "string",
  "updateMask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "labels": "string",
  "deletionProtection": "bool"
}
```

#|
||Field | Description ||
|| connectorId | **string**

Required field. ID of the connector to update. ||
|| updateMask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the connector are going to be updated. ||
|| name | **string**

New name of the connector. ||
|| description | **string**

New description of the connector. ||
|| labels | **string**

New labels of the connector. ||
|| deletionProtection | **bool**

New flag that disallow deletion of the connector. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "createdBy": "string",
  "modifiedAt": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "connectorId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "busId": "string",
    "folderId": "string",
    "cloudId": "string",
    "createdAt": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "string",
    "source": {
      // Includes only one of the fields `dataStream`, `messageQueue`
      "dataStream": {
        "database": "string",
        "streamName": "string",
        "consumer": "string",
        "serviceAccountId": "string"
      },
      "messageQueue": {
        "queueArn": "string",
        "serviceAccountId": "string",
        "visibilityTimeout": "google.protobuf.Duration",
        "batchSize": "int64",
        "pollingTimeout": "google.protobuf.Duration"
      }
      // end of the list of possible fields
    },
    "deletionProtection": "bool",
    "status": "Status"
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateConnectorMetadata](#yandex.cloud.serverless.eventrouter.v1.UpdateConnectorMetadata)**

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
|| response | **[Connector](#yandex.cloud.serverless.eventrouter.v1.Connector)**

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

## UpdateConnectorMetadata {#yandex.cloud.serverless.eventrouter.v1.UpdateConnectorMetadata}

#|
||Field | Description ||
|| connectorId | **string**

Required field. ID of the connector that is being updated. ||
|#

## Connector {#yandex.cloud.serverless.eventrouter.v1.Connector}

#|
||Field | Description ||
|| id | **string**

ID of the connector. ||
|| busId | **string**

ID of the bus that the connector belongs to. ||
|| folderId | **string**

ID of the folder that the connector resides in. ||
|| cloudId | **string**

ID of the cloud that the connector resides in. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the connector. ||
|| description | **string**

Description of the connector. ||
|| labels | **string**

Resource labels as `key:value` pairs. ||
|| source | **[Source](#yandex.cloud.serverless.eventrouter.v1.Source)**

Source of the connector. ||
|| deletionProtection | **bool**

Deletion protection. ||
|| status | enum **Status**

Status of the connector.

- `STATUS_UNSPECIFIED`
- `RUNNING`
- `STOPPED`: disabled by user
- `RESOURCE_NOT_FOUND`: source does not exist
- `PERMISSION_DENIED`: service account does not have read permission on source
- `SUBJECT_NOT_FOUND`: service account not found
- `DELETING`: deletion in progress
- `CREATING`: creation in progress ||
|#

## Source {#yandex.cloud.serverless.eventrouter.v1.Source}

#|
||Field | Description ||
|| dataStream | **[DataStream](#yandex.cloud.serverless.eventrouter.v1.DataStream)**

Includes only one of the fields `dataStream`, `messageQueue`. ||
|| messageQueue | **[MessageQueue](#yandex.cloud.serverless.eventrouter.v1.MessageQueue)**

Includes only one of the fields `dataStream`, `messageQueue`. ||
|#

## DataStream {#yandex.cloud.serverless.eventrouter.v1.DataStream}

#|
||Field | Description ||
|| database | **string**

Required field. Stream database.
example: /ru-central1/aoegtvhtp8ob********/cc8004q4lbo6******** ||
|| streamName | **string**

Required field. Stream name, absolute or relative. ||
|| consumer | **string**

Required field. Consumer name. ||
|| serviceAccountId | **string**

Required field. Service account which has read permission on the stream. ||
|#

## MessageQueue {#yandex.cloud.serverless.eventrouter.v1.MessageQueue}

#|
||Field | Description ||
|| queueArn | **string**

Required field. Queue ARN.
Example: yrn:yc:ymq:ru-central1:aoe***:test ||
|| serviceAccountId | **string**

Required field. Service account which has read access to the queue. ||
|| visibilityTimeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Queue visibility timeout override. ||
|| batchSize | **int64**

Batch size for polling. ||
|| pollingTimeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Queue polling timeout. ||
|#