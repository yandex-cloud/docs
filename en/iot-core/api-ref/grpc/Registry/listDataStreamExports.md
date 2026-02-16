---
editable: false
sourcePath: en/_api-ref-grpc/iot/devices/v1/api-ref/grpc/Registry/listDataStreamExports.md
---

# IoT Core Service, gRPC: RegistryService.ListDataStreamExports

Retrieves the list of YDS exports for the specified registry.

## gRPC request

**rpc ListDataStreamExports ([ListDataStreamExportsRequest](#yandex.cloud.iot.devices.v1.ListDataStreamExportsRequest)) returns ([ListDataStreamExportsResponse](#yandex.cloud.iot.devices.v1.ListDataStreamExportsResponse))**

## ListDataStreamExportsRequest {#yandex.cloud.iot.devices.v1.ListDataStreamExportsRequest}

```json
{
  "registry_id": "string"
}
```

#|
||Field | Description ||
|| registry_id | **string**

Required field. ID of the registry to list YDS exports in.

To get a registry ID make a [RegistryService.List](/docs/iot-core/api-ref/grpc/Registry/list#List) request. ||
|#

## ListDataStreamExportsResponse {#yandex.cloud.iot.devices.v1.ListDataStreamExportsResponse}

```json
{
  "data_stream_exports": [
    {
      "id": "string",
      "name": "string",
      "registry_id": "string",
      "mqtt_topic_filter": "string",
      "database": "string",
      "stream": "string",
      "service_account_id": "string",
      "created_at": "google.protobuf.Timestamp"
    }
  ]
}
```

#|
||Field | Description ||
|| data_stream_exports[] | **[DataStreamExport](#yandex.cloud.iot.devices.v1.DataStreamExport)**

List of YDS exports for the specified registry. ||
|#

## DataStreamExport {#yandex.cloud.iot.devices.v1.DataStreamExport}

A Yandex Data Streams export.

#|
||Field | Description ||
|| id | **string**

ID of the YDS export. ||
|| name | **string**

Name of the YDS export. ||
|| registry_id | **string**

ID of the registry that the YDS export belongs to. ||
|| mqtt_topic_filter | **string**

MQTT topic whose messages export to YDS. ||
|| database | **string**

YDS database. ||
|| stream | **string**

YDS stream name. ||
|| service_account_id | **string**

ID of the service account which has permission to write to data stream. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|#