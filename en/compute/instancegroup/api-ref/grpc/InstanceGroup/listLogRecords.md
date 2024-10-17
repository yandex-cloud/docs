---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/instancegroup/api-ref/grpc/InstanceGroup/listLogRecords.md
---

# Compute Cloud Instance Groups API, gRPC: InstanceGroupService.ListLogRecords {#ListLogRecords}

Lists logs for the specified instance group.

## gRPC request

**rpc ListLogRecords ([ListInstanceGroupLogRecordsRequest](#yandex.cloud.compute.v1.instancegroup.ListInstanceGroupLogRecordsRequest)) returns ([ListInstanceGroupLogRecordsResponse](#yandex.cloud.compute.v1.instancegroup.ListInstanceGroupLogRecordsResponse))**

## ListInstanceGroupLogRecordsRequest {#yandex.cloud.compute.v1.instancegroup.ListInstanceGroupLogRecordsRequest}

```json
{
  "instanceGroupId": "string",
  "pageSize": "int64",
  "pageToken": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| instanceGroupId | **string**

Required field. ID of the InstanceGroup resource to list logs for.
To get the instance group ID, use a [InstanceGroupService.List](/docs/compute/api-ref/grpc/InstanceGroup/list#List) request. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListInstanceGroupLogRecordsResponse.nextPageToken](#yandex.cloud.compute.v1.instancegroup.ListInstanceGroupLogRecordsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results,
set `pageToken` to the [ListInstanceGroupLogRecordsResponse.nextPageToken](#yandex.cloud.compute.v1.instancegroup.ListInstanceGroupLogRecordsResponse)
returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
Currently you can use filtering only on the [InstanceGroup.name](/docs/compute/api-ref/grpc/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.InstanceGroup) field. ||
|#

## ListInstanceGroupLogRecordsResponse {#yandex.cloud.compute.v1.instancegroup.ListInstanceGroupLogRecordsResponse}

```json
{
  "logRecords": [
    {
      "timestamp": "google.protobuf.Timestamp",
      "message": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| logRecords[] | **[LogRecord](#yandex.cloud.compute.v1.instancegroup.LogRecord)**

Lists logs for the specified instance group. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListInstanceGroupLogRecordsRequest.pageSize](#yandex.cloud.compute.v1.instancegroup.ListInstanceGroupLogRecordsRequest), use
`nextPageToken` as the value
for the [ListInstanceGroupLogRecordsRequest.pageToken](#yandex.cloud.compute.v1.instancegroup.ListInstanceGroupLogRecordsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## LogRecord {#yandex.cloud.compute.v1.instancegroup.LogRecord}

#|
||Field | Description ||
|| timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Log timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| message | **string**

The log message. ||
|#