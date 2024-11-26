---
editable: false
sourcePath: en/_api-ref-grpc/mdb/greenplum/v1/api-ref/grpc/ResourcePreset/list.md
---

# Managed Service for Greenplum® API, gRPC: ResourcePresetService.List

Retrieves the list of available resource presets.

## gRPC request

**rpc List ([ListResourcePresetsRequest](#yandex.cloud.mdb.greenplum.v1.ListResourcePresetsRequest)) returns ([ListResourcePresetsResponse](#yandex.cloud.mdb.greenplum.v1.ListResourcePresetsResponse))**

## ListResourcePresetsRequest {#yandex.cloud.mdb.greenplum.v1.ListResourcePresetsRequest}

```json
{
  "page_size": "int64",
  "page_token": "string",
  "type": "Type"
}
```

#|
||Field | Description ||
|| page_size | **int64**

The maximum number of results per page to return.

If the number of available results is larger than `page_size`, the service returns a [ListResourcePresetsResponse.next_page_token](#yandex.cloud.mdb.greenplum.v1.ListResourcePresetsResponse) that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the [ListResourcePresetsResponse.next_page_token](#yandex.cloud.mdb.greenplum.v1.ListResourcePresetsResponse) returned by the previous list request. ||
|| type | enum **Type**

Required field. Required. ResourcePreset type - master or segment.

- `TYPE_UNSPECIFIED`
- `MASTER`: Greenplum® master host.
- `SEGMENT`: Greenplum® segment host. ||
|#

## ListResourcePresetsResponse {#yandex.cloud.mdb.greenplum.v1.ListResourcePresetsResponse}

```json
{
  "resource_presets": [
    {
      "id": "string",
      "zone_ids": [
        "string"
      ],
      "disk_type_ids": [
        "string"
      ],
      "cores": "int64",
      "memory": "int64",
      "type": "Type",
      "host_count_divider": "int64",
      "max_segment_in_host_count": "int64"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| resource_presets[] | **[ResourcePreset](#yandex.cloud.mdb.greenplum.v1.ResourcePreset)**

List of resource presets. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests.

If the number of results is larger than [ListResourcePresetsRequest.page_size](#yandex.cloud.mdb.greenplum.v1.ListResourcePresetsRequest), use the `next_page_token` as the value for the [ListResourcePresetsRequest.page_token](#yandex.cloud.mdb.greenplum.v1.ListResourcePresetsRequest) parameter in the next list request.

Each subsequent list request has its own `next_page_token` to continue paging through the results. ||
|#

## ResourcePreset {#yandex.cloud.mdb.greenplum.v1.ResourcePreset}

A preset of resources for hardware configuration of Greenplum® hosts.

#|
||Field | Description ||
|| id | **string**

ID of the resource preset. ||
|| zone_ids[] | **string**

IDs of availability zones where the resource preset is available. ||
|| disk_type_ids[] | **string**

IDs of availability disk types available in the resource preset. ||
|| cores | **int64**

Number of CPU cores for a Greenplum® host created with the preset. ||
|| memory | **int64**

RAM volume for a Greenplum® host created with the preset, in bytes. ||
|| type | enum **Type**

Host type.

- `TYPE_UNSPECIFIED`
- `MASTER`: Greenplum® master host.
- `SEGMENT`: Greenplum® segment host. ||
|| host_count_divider | **int64**

The number of hosts must be divisible by `host_count_divider`. ||
|| max_segment_in_host_count | **int64**

Maximum number of segments in segment host. ||
|#