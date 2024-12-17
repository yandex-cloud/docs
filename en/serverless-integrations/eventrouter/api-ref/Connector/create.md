---
editable: false
sourcePath: en/_api-ref/serverless/eventrouter/v1/eventrouter/api-ref/Connector/create.md
---

# EventRouter Service, REST: Connector.Create

Creates a connector in the specified folder.

## HTTP request

```
POST https://serverless-eventrouter.{{ api-host }}/eventrouter/v1/connectors
```

## Body parameters {#yandex.cloud.serverless.eventrouter.v1.CreateConnectorRequest}

```json
{
  "busId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "source": {
    // Includes only one of the fields `dataStream`, `messageQueue`, `timer`
    "dataStream": {
      "database": "string",
      "streamName": "string",
      "consumer": "string",
      "serviceAccountId": "string"
    },
    "messageQueue": {
      "queueArn": "string",
      "serviceAccountId": "string",
      "visibilityTimeout": "string",
      "batchSize": "string",
      "pollingTimeout": "string"
    },
    "timer": {
      "cronExpression": "string",
      "timeZone": "string",
      "payload": "string"
    }
    // end of the list of possible fields
  },
  "deletionProtection": "boolean"
}
```

#|
||Field | Description ||
|| busId | **string**

Required field. ID of the bus to create a connector in. ||
|| name | **string**

Name of the connector. ||
|| description | **string**

Description of the connector. ||
|| labels | **object** (map<**string**, **string**>)

Labels for the connector. ||
|| source | **[Source](#yandex.cloud.serverless.eventrouter.v1.Source)**

Source of the connector. ||
|| deletionProtection | **boolean**

Flag that disallow deletion of the connector. ||
|#

## Source {#yandex.cloud.serverless.eventrouter.v1.Source}

#|
||Field | Description ||
|| dataStream | **[DataStream](#yandex.cloud.serverless.eventrouter.v1.DataStream)**

Includes only one of the fields `dataStream`, `messageQueue`, `timer`. ||
|| messageQueue | **[MessageQueue](#yandex.cloud.serverless.eventrouter.v1.MessageQueue)**

Includes only one of the fields `dataStream`, `messageQueue`, `timer`. ||
|| timer | **[Timer](#yandex.cloud.serverless.eventrouter.v1.Timer)**

Includes only one of the fields `dataStream`, `messageQueue`, `timer`. ||
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
|| visibilityTimeout | **string** (duration)

Queue visibility timeout override. ||
|| batchSize | **string** (int64)

Batch size for polling. ||
|| pollingTimeout | **string** (duration)

Queue polling timeout. ||
|#

## Timer {#yandex.cloud.serverless.eventrouter.v1.Timer}

#|
||Field | Description ||
|| cronExpression | **string**

Required field. cron expression, with second precision ||
|| timeZone | **string**

time zone, e.g. Europe/Moscow ||
|| payload | **string**

payload to send to target ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "connectorId": "string",
    "busId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "id": "string",
    "busId": "string",
    "folderId": "string",
    "cloudId": "string",
    "createdAt": "string",
    "name": "string",
    "description": "string",
    "labels": "object",
    "source": {
      // Includes only one of the fields `dataStream`, `messageQueue`, `timer`
      "dataStream": {
        "database": "string",
        "streamName": "string",
        "consumer": "string",
        "serviceAccountId": "string"
      },
      "messageQueue": {
        "queueArn": "string",
        "serviceAccountId": "string",
        "visibilityTimeout": "string",
        "batchSize": "string",
        "pollingTimeout": "string"
      },
      "timer": {
        "cronExpression": "string",
        "timeZone": "string",
        "payload": "string"
      }
      // end of the list of possible fields
    },
    "deletionProtection": "boolean",
    "status": "string"
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateConnectorMetadata](#yandex.cloud.serverless.eventrouter.v1.CreateConnectorMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

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
|| connectorId | **string**

ID of the connector that is being created. ||
|| busId | **string**

ID of the bus that the connector is created in. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the connector. ||
|| description | **string**

Description of the connector. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|| source | **[Source](#yandex.cloud.serverless.eventrouter.v1.Source2)**

Source of the connector. ||
|| deletionProtection | **boolean**

Deletion protection. ||
|| status | **enum** (Status)

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
|| dataStream | **[DataStream](#yandex.cloud.serverless.eventrouter.v1.DataStream2)**

Includes only one of the fields `dataStream`, `messageQueue`, `timer`. ||
|| messageQueue | **[MessageQueue](#yandex.cloud.serverless.eventrouter.v1.MessageQueue2)**

Includes only one of the fields `dataStream`, `messageQueue`, `timer`. ||
|| timer | **[Timer](#yandex.cloud.serverless.eventrouter.v1.Timer2)**

Includes only one of the fields `dataStream`, `messageQueue`, `timer`. ||
|#

## DataStream {#yandex.cloud.serverless.eventrouter.v1.DataStream2}

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

## MessageQueue {#yandex.cloud.serverless.eventrouter.v1.MessageQueue2}

#|
||Field | Description ||
|| queueArn | **string**

Required field. Queue ARN.
Example: yrn:yc:ymq:ru-central1:aoe***:test ||
|| serviceAccountId | **string**

Required field. Service account which has read access to the queue. ||
|| visibilityTimeout | **string** (duration)

Queue visibility timeout override. ||
|| batchSize | **string** (int64)

Batch size for polling. ||
|| pollingTimeout | **string** (duration)

Queue polling timeout. ||
|#

## Timer {#yandex.cloud.serverless.eventrouter.v1.Timer2}

#|
||Field | Description ||
|| cronExpression | **string**

Required field. cron expression, with second precision ||
|| timeZone | **string**

time zone, e.g. Europe/Moscow ||
|| payload | **string**

payload to send to target ||
|#