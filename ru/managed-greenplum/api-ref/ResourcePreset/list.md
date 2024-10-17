---
editable: false
sourcePath: en/_api-ref/mdb/greenplum/v1/api-ref/ResourcePreset/list.md
---

# Managed Service for Greenplum® API, REST: ResourcePreset.List {#List}

Retrieves the list of available resource presets.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-greenplum/v1/resourcePresets
```

## Query parameters {#yandex.cloud.mdb.greenplum.v1.ListResourcePresetsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return.

If the number of available results is larger than `pageSize`, the service returns a [ListResourcePresetsResponse.nextPageToken](#yandex.cloud.mdb.greenplum.v1.ListResourcePresetsResponse) that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the [ListResourcePresetsResponse.nextPageToken](#yandex.cloud.mdb.greenplum.v1.ListResourcePresetsResponse) returned by the previous list request. ||
|| type | **enum** (Type)

Required field. Required. ResourcePreset type - master or segment.

- `TYPE_UNSPECIFIED`
- `MASTER`: Greenplum® master host.
- `SEGMENT`: Greenplum® segment host. ||
|#

## Response {#yandex.cloud.mdb.greenplum.v1.ListResourcePresetsResponse}

**HTTP Code: 200 - OK**

```json
{
  "resourcePresets": [
    {
      "id": "string",
      "zoneIds": [
        "string"
      ],
      "diskTypeIds": [
        "string"
      ],
      "cores": "string",
      "memory": "string",
      "type": "string",
      "hostCountDivider": "string",
      "maxSegmentInHostCount": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| resourcePresets[] | **[ResourcePreset](#yandex.cloud.mdb.greenplum.v1.ResourcePreset)**

List of resource presets. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests.

If the number of results is larger than [ListResourcePresetsRequest.pageSize](#yandex.cloud.mdb.greenplum.v1.ListResourcePresetsRequest), use the `nextPageToken` as the value for the [ListResourcePresetsRequest.pageToken](#yandex.cloud.mdb.greenplum.v1.ListResourcePresetsRequest) parameter in the next list request.

Each subsequent list request has its own `nextPageToken` to continue paging through the results. ||
|#

## ResourcePreset {#yandex.cloud.mdb.greenplum.v1.ResourcePreset}

A preset of resources for hardware configuration of Greenplum® hosts.

#|
||Field | Description ||
|| id | **string**

ID of the resource preset. ||
|| zoneIds[] | **string**

IDs of availability zones where the resource preset is available. ||
|| diskTypeIds[] | **string**

IDs of availability disk types available in the resource preset. ||
|| cores | **string** (int64)

Number of CPU cores for a Greenplum® host created with the preset. ||
|| memory | **string** (int64)

RAM volume for a Greenplum® host created with the preset, in bytes. ||
|| type | **enum** (Type)

Host type.

- `TYPE_UNSPECIFIED`
- `MASTER`: Greenplum® master host.
- `SEGMENT`: Greenplum® segment host. ||
|| hostCountDivider | **string** (int64)

The number of hosts must be divisible by `hostCountDivider`. ||
|| maxSegmentInHostCount | **string** (int64)

Maximum number of segments in segment host. ||
|#