---
editable: false
sourcePath: en/_api-ref-grpc/serverless/eventrouter/v1/eventrouter/api-ref/grpc/Connector/get.md
---

# EventRouter Service, gRPC: ConnectorService.Get {#Get}

Returns the specified bus.
To get the list of all available connectors, make a [List](/docs/functions/eventrouter/api-ref/grpc/Connector/list#List) request.

## gRPC request

**rpc Get ([GetConnectorRequest](#yandex.cloud.serverless.eventrouter.v1.GetConnectorRequest)) returns ([Connector](#yandex.cloud.serverless.eventrouter.v1.Connector))**

## GetConnectorRequest {#yandex.cloud.serverless.eventrouter.v1.GetConnectorRequest}

```json
{
  "connectorId": "string"
}
```

#|
||Field | Description ||
|| connectorId | **string**

Required field. ID of the connector to return. ||
|#

## Connector {#yandex.cloud.serverless.eventrouter.v1.Connector}

```json
{
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
```

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
- `SUBJECT_NOT_FOUND`: service account not found ||
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