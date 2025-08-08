---
editable: false
sourcePath: en/_api-ref-grpc/serverless/eventrouter/v1/eventrouter/api-ref/grpc/Connector/list.md
---

# EventRouter Service, gRPC: ConnectorService.List

Retrieves the list of connectors in the specified folder.

## gRPC request

**rpc List ([ListConnectorsRequest](#yandex.cloud.serverless.eventrouter.v1.ListConnectorsRequest)) returns ([ListConnectorsResponse](#yandex.cloud.serverless.eventrouter.v1.ListConnectorsResponse))**

## ListConnectorsRequest {#yandex.cloud.serverless.eventrouter.v1.ListConnectorsRequest}

```json
{
  // Includes only one of the fields `bus_id`, `folder_id`
  "bus_id": "string",
  "folder_id": "string",
  // end of the list of possible fields
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| bus_id | **string**

ID of the bus to list connectors in.

Includes only one of the fields `bus_id`, `folder_id`.

ID of the folder or bus to list connectors in. ||
|| folder_id | **string**

ID of the folder to list connectors in.

Includes only one of the fields `bus_id`, `folder_id`.

ID of the folder or bus to list connectors in. ||
|| page_size | **int64**

The maximum number of results per response. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
`next_page_token` returned by a previous list request. ||
|| filter | **string**

Supported fields for filter:
name
created_at ||
|#

## ListConnectorsResponse {#yandex.cloud.serverless.eventrouter.v1.ListConnectorsResponse}

```json
{
  "connectors": [
    {
      "id": "string",
      "bus_id": "string",
      "folder_id": "string",
      "cloud_id": "string",
      "created_at": "google.protobuf.Timestamp",
      "name": "string",
      "description": "string",
      "labels": "map<string, string>",
      "source": {
        // Includes only one of the fields `data_stream`, `message_queue`, `timer`, `event_service_source`, `audit_trails`
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
        },
        "timer": {
          "cron_expression": "string",
          "time_zone": "string",
          "payload": "string"
        },
        "event_service_source": "EventServiceSource",
        "audit_trails": "AuditTrails"
        // end of the list of possible fields
      },
      "deletion_protection": "bool",
      "status": "Status"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| connectors[] | **[Connector](#yandex.cloud.serverless.eventrouter.v1.Connector)**

List of connectors. ||
|| next_page_token | **string**

Token for getting the next page of the list of results. ||
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
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|| source | **[Source](#yandex.cloud.serverless.eventrouter.v1.Source)**

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

## Source {#yandex.cloud.serverless.eventrouter.v1.Source}

#|
||Field | Description ||
|| data_stream | **[DataStream](#yandex.cloud.serverless.eventrouter.v1.DataStream)**

Includes only one of the fields `data_stream`, `message_queue`, `timer`, `event_service_source`, `audit_trails`. ||
|| message_queue | **[MessageQueue](#yandex.cloud.serverless.eventrouter.v1.MessageQueue)**

Includes only one of the fields `data_stream`, `message_queue`, `timer`, `event_service_source`, `audit_trails`. ||
|| timer | **[Timer](#yandex.cloud.serverless.eventrouter.v1.Timer)**

Includes only one of the fields `data_stream`, `message_queue`, `timer`, `event_service_source`, `audit_trails`. ||
|| event_service_source | **[EventServiceSource](#yandex.cloud.serverless.eventrouter.v1.EventServiceSource)**

Includes only one of the fields `data_stream`, `message_queue`, `timer`, `event_service_source`, `audit_trails`. ||
|| audit_trails | **[AuditTrails](#yandex.cloud.serverless.eventrouter.v1.AuditTrails)**

Includes only one of the fields `data_stream`, `message_queue`, `timer`, `event_service_source`, `audit_trails`. ||
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

## Timer {#yandex.cloud.serverless.eventrouter.v1.Timer}

#|
||Field | Description ||
|| cron_expression | **string**

Required field. cron expression, with second precision ||
|| time_zone | **string**

time zone, e.g. Europe/Moscow ||
|| payload | **string**

payload to send to target ||
|#

## EventServiceSource {#yandex.cloud.serverless.eventrouter.v1.EventServiceSource}

#|
||Field | Description ||
|| Empty | > ||
|#

## AuditTrails {#yandex.cloud.serverless.eventrouter.v1.AuditTrails}

#|
||Field | Description ||
|| Empty | > ||
|#