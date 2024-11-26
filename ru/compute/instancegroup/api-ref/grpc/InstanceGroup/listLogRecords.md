---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/instancegroup/api-ref/grpc/InstanceGroup/listLogRecords.md
---

# Compute Cloud Instance Groups API, gRPC: InstanceGroupService.ListLogRecords

Lists logs for the specified instance group.

## gRPC request

**rpc ListLogRecords ([ListInstanceGroupLogRecordsRequest](#yandex.cloud.compute.v1.instancegroup.ListInstanceGroupLogRecordsRequest)) returns ([ListInstanceGroupLogRecordsResponse](#yandex.cloud.compute.v1.instancegroup.ListInstanceGroupLogRecordsResponse))**

## ListInstanceGroupLogRecordsRequest {#yandex.cloud.compute.v1.instancegroup.ListInstanceGroupLogRecordsRequest}

```json
{
  "instance_group_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| instance_group_id | **string**

Required field. ID of the InstanceGroup resource to list logs for.
To get the instance group ID, use a [InstanceGroupService.List](/docs/compute/api-ref/grpc/InstanceGroup/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListInstanceGroupLogRecordsResponse.next_page_token](#yandex.cloud.compute.v1.instancegroup.ListInstanceGroupLogRecordsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token. To get the next page of results,
set `page_token` to the [ListInstanceGroupLogRecordsResponse.next_page_token](#yandex.cloud.compute.v1.instancegroup.ListInstanceGroupLogRecordsResponse)
returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
Currently you can use filtering only on the [InstanceGroup.name](/docs/compute/api-ref/grpc/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.InstanceGroup) field. ||
|#

## ListInstanceGroupLogRecordsResponse {#yandex.cloud.compute.v1.instancegroup.ListInstanceGroupLogRecordsResponse}

```json
{
  "log_records": [
    {
      "timestamp": "google.protobuf.Timestamp",
      "message": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| log_records[] | **[LogRecord](#yandex.cloud.compute.v1.instancegroup.LogRecord)**

Lists logs for the specified instance group. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListInstanceGroupLogRecordsRequest.page_size](#yandex.cloud.compute.v1.instancegroup.ListInstanceGroupLogRecordsRequest), use
`next_page_token` as the value
for the [ListInstanceGroupLogRecordsRequest.page_token](#yandex.cloud.compute.v1.instancegroup.ListInstanceGroupLogRecordsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## LogRecord {#yandex.cloud.compute.v1.instancegroup.LogRecord}

#|
||Field | Description ||
|| timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Log timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| message | **string**

The log message. ||
|#