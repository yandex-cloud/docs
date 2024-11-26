---
editable: false
sourcePath: en/_api-ref/compute/v1/instancegroup/api-ref/InstanceGroup/listLogRecords.md
---

# Compute Cloud Instance Groups API, REST: InstanceGroup.ListLogRecords

Lists logs for the specified instance group.

## HTTP request

```
GET https://compute.{{ api-host }}/compute/v1/instanceGroups/{instanceGroupId}:logs
```

## Path parameters

#|
||Field | Description ||
|| instanceGroupId | **string**

Required field. ID of the InstanceGroup resource to list logs for.
To get the instance group ID, use a [InstanceGroupService.List](/docs/compute/api-ref/InstanceGroup/list#List) request. ||
|#

## Query parameters {#yandex.cloud.compute.v1.instancegroup.ListInstanceGroupLogRecordsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

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
Currently you can use filtering only on the [InstanceGroup.name](/docs/compute/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.InstanceGroup) field. ||
|#

## Response {#yandex.cloud.compute.v1.instancegroup.ListInstanceGroupLogRecordsResponse}

**HTTP Code: 200 - OK**

```json
{
  "logRecords": [
    {
      "timestamp": "string",
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
|| timestamp | **string** (date-time)

Log timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| message | **string**

The log message. ||
|#