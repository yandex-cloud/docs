---
editable: false
sourcePath: en/_api-ref-grpc/serverless/eventrouter/v1/eventrouter/api-ref/grpc/Connector/create.md
---

# EventRouter Service, gRPC: ConnectorService.Create

Creates a connector in the specified folder.

## gRPC request

**rpc Create ([CreateConnectorRequest](#yandex.cloud.serverless.eventrouter.v1.CreateConnectorRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateConnectorRequest {#yandex.cloud.serverless.eventrouter.v1.CreateConnectorRequest}

```json
{
  "bus_id": "string",
  "name": "string",
  "description": "string",
  "labels": "string",
  "source": {
    // Includes only one of the fields `data_stream`, `message_queue`
    "data_stream": {
      "database": "string",
      "stream_name": "string",
      "consumer": "string",
      "service_account_id": "string"
    },
    "message_queue": {
      "queue_arn": "string",
      "service_account_id": "string",
      "visibility_timeout": "google.protobuf.Duration",
      "batch_size": "int64",
      "polling_timeout": "google.protobuf.Duration"
    }
    // end of the list of possible fields
  },
  "deletion_protection": "bool"
}
```

#|
||Field | Description ||
|| bus_id | **string**

Required field. ID of the bus to create a connector in. ||
|| name | **string**

Name of the connector. ||
|| description | **string**

Description of the connector. ||
|| labels | **string**

Labels for the connector. ||
|| source | **[Source](#yandex.cloud.serverless.eventrouter.v1.Source)**

Source of the connector. ||
|| deletion_protection | **bool**

Flag that disallow deletion of the connector. ||
|#

## Source {#yandex.cloud.serverless.eventrouter.v1.Source}

#|
||Field | Description ||
|| data_stream | **[DataStream](#yandex.cloud.serverless.eventrouter.v1.DataStream)**

Includes only one of the fields `data_stream`, `message_queue`. ||
|| message_queue | **[MessageQueue](#yandex.cloud.serverless.eventrouter.v1.MessageQueue)**

Includes only one of the fields `data_stream`, `message_queue`. ||
|#

## DataStream {#yandex.cloud.serverless.eventrouter.v1.DataStream}

#|
||Field | Description ||
|| database | **string**

Required field. Stream database.
example: /ru-central1/aoegtvhtp8ob********/cc8004q4lbo6******** ||
|| stream_name | **string**

Required field. Stream name, absolute or relative. ||
|| consumer | **string**

Required field. Consumer name. ||
|| service_account_id | **string**

Required field. Service account which has read permission on the stream. ||
|#

## MessageQueue {#yandex.cloud.serverless.eventrouter.v1.MessageQueue}

#|
||Field | Description ||
|| queue_arn | **string**

Required field. Queue ARN.
Example: yrn:yc:ymq:ru-central1:aoe***:test ||
|| service_account_id | **string**

Required field. Service account which has read access to the queue. ||
|| visibility_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Queue visibility timeout override. ||
|| batch_size | **int64**

Batch size for polling. ||
|| polling_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Queue polling timeout. ||
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
    "connector_id": "string",
    "bus_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "bus_id": "string",
    "folder_id": "string",
    "cloud_id": "string",
    "created_at": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "string",
    "source": {
      // Includes only one of the fields `data_stream`, `message_queue`
      "data_stream": {
        "database": "string",
        "stream_name": "string",
        "consumer": "string",
        "service_account_id": "string"
      },
      "message_queue": {
        "queue_arn": "string",
        "service_account_id": "string",
        "visibility_timeout": "google.protobuf.Duration",
        "batch_size": "int64",
        "polling_timeout": "google.protobuf.Duration"
      }
      // end of the list of possible fields
    },
    "deletion_protection": "bool",
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateConnectorMetadata](#yandex.cloud.serverless.eventrouter.v1.CreateConnectorMetadata)**

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

## CreateConnectorMetadata {#yandex.cloud.serverless.eventrouter.v1.CreateConnectorMetadata}

#|
||Field | Description ||
|| connector_id | **string**

ID of the connector that is being created. ||
|| bus_id | **string**

ID of the bus that the connector is created in. ||
|#

## Connector {#yandex.cloud.serverless.eventrouter.v1.Connector}

#|
||Field | Description ||
|| id | **string**

ID of the connector. ||
|| bus_id | **string**

ID of the bus that the connector belongs to. ||
|| folder_id | **string**

ID of the folder that the connector resides in. ||
|| cloud_id | **string**

ID of the cloud that the connector resides in. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the connector. ||
|| description | **string**

Description of the connector. ||
|| labels | **string**

Resource labels as `key:value` pairs. ||
|| source | **[Source](#yandex.cloud.serverless.eventrouter.v1.Source2)**

Source of the connector. ||
|| deletion_protection | **bool**

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

## Source {#yandex.cloud.serverless.eventrouter.v1.Source2}

#|
||Field | Description ||
|| data_stream | **[DataStream](#yandex.cloud.serverless.eventrouter.v1.DataStream2)**

Includes only one of the fields `data_stream`, `message_queue`. ||
|| message_queue | **[MessageQueue](#yandex.cloud.serverless.eventrouter.v1.MessageQueue2)**

Includes only one of the fields `data_stream`, `message_queue`. ||
|#

## DataStream {#yandex.cloud.serverless.eventrouter.v1.DataStream2}

#|
||Field | Description ||
|| database | **string**

Required field. Stream database.
example: /ru-central1/aoegtvhtp8ob********/cc8004q4lbo6******** ||
|| stream_name | **string**

Required field. Stream name, absolute or relative. ||
|| consumer | **string**

Required field. Consumer name. ||
|| service_account_id | **string**

Required field. Service account which has read permission on the stream. ||
|#

## MessageQueue {#yandex.cloud.serverless.eventrouter.v1.MessageQueue2}

#|
||Field | Description ||
|| queue_arn | **string**

Required field. Queue ARN.
Example: yrn:yc:ymq:ru-central1:aoe***:test ||
|| service_account_id | **string**

Required field. Service account which has read access to the queue. ||
|| visibility_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Queue visibility timeout override. ||
|| batch_size | **int64**

Batch size for polling. ||
|| polling_timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Queue polling timeout. ||
|#