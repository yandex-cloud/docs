---
editable: false
apiPlayground:
  - url: https://serverless-eventrouter.{{ api-host }}/eventrouter/v1/connectors/{connectorId}
    method: get
    path:
      type: object
      properties:
        connectorId:
          description: |-
            **string**
            Required field. ID of the connector to return.
          type: string
      required:
        - connectorId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/serverless/eventrouter/v1/eventrouter/api-ref/Connector/get.md
---

# EventRouter Service, REST: Connector.Get

Returns the specified bus.
To get the list of all available connectors, make a [List](/docs/serverless-integrations/eventrouter/api-ref/Connector/list#List) request.

## HTTP request

```
GET https://serverless-eventrouter.{{ api-host }}/eventrouter/v1/connectors/{connectorId}
```

## Path parameters

#|
||Field | Description ||
|| connectorId | **string**

Required field. ID of the connector to return. ||
|#

## Response {#yandex.cloud.serverless.eventrouter.v1.Connector}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "busId": "string",
  "folderId": "string",
  "cloudId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "source": {
    // Includes only one of the fields `dataStream`, `messageQueue`, `timer`, `eventServiceSource`, `auditTrails`
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
    },
    "eventServiceSource": "object",
    "auditTrails": "object"
    // end of the list of possible fields
  },
  "deletionProtection": "boolean",
  "status": "string"
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
|| source | **[Source](#yandex.cloud.serverless.eventrouter.v1.Source)**

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

## Source {#yandex.cloud.serverless.eventrouter.v1.Source}

#|
||Field | Description ||
|| dataStream | **[DataStream](#yandex.cloud.serverless.eventrouter.v1.DataStream)**

Includes only one of the fields `dataStream`, `messageQueue`, `timer`, `eventServiceSource`, `auditTrails`. ||
|| messageQueue | **[MessageQueue](#yandex.cloud.serverless.eventrouter.v1.MessageQueue)**

Includes only one of the fields `dataStream`, `messageQueue`, `timer`, `eventServiceSource`, `auditTrails`. ||
|| timer | **[Timer](#yandex.cloud.serverless.eventrouter.v1.Timer)**

Includes only one of the fields `dataStream`, `messageQueue`, `timer`, `eventServiceSource`, `auditTrails`. ||
|| eventServiceSource | **object**

Includes only one of the fields `dataStream`, `messageQueue`, `timer`, `eventServiceSource`, `auditTrails`. ||
|| auditTrails | **object**

Includes only one of the fields `dataStream`, `messageQueue`, `timer`, `eventServiceSource`, `auditTrails`. ||
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