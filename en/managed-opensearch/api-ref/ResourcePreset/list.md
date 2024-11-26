---
editable: false
sourcePath: en/_api-ref/mdb/opensearch/v1/api-ref/ResourcePreset/list.md
---

# Managed Service for OpenSearch API, REST: ResourcePreset.List

Retrieves the list of available resource presets.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-opensearch/v1/resourcePresets
```

## Query parameters {#yandex.cloud.mdb.opensearch.v1.ListResourcePresetsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return.

If the number of available results is larger than `pageSize`, the service returns
a [ListResourcePresetsResponse.nextPageToken](#yandex.cloud.mdb.opensearch.v1.ListResourcePresetsResponse) that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the [ListResourcePresetsResponse.nextPageToken](#yandex.cloud.mdb.opensearch.v1.ListResourcePresetsResponse)
returned by the previous list request. ||
|#

## Response {#yandex.cloud.mdb.opensearch.v1.ListResourcePresetsResponse}

**HTTP Code: 200 - OK**

```json
{
  "resourcePresets": [
    {
      "id": "string",
      "zoneIds": [
        "string"
      ],
      "cores": "string",
      "memory": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| resourcePresets[] | **[ResourcePreset](#yandex.cloud.mdb.opensearch.v1.ResourcePreset)**

List of resource presets. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests.

If the number of results is larger than [ListResourcePresetsRequest.pageSize](#yandex.cloud.mdb.opensearch.v1.ListResourcePresetsRequest), use the `nextPageToken` as the value
for the [ListResourcePresetsRequest.pageToken](#yandex.cloud.mdb.opensearch.v1.ListResourcePresetsRequest) parameter in the next list request.

Each subsequent list request has its own `nextPageToken` to continue paging through the results. ||
|#

## ResourcePreset {#yandex.cloud.mdb.opensearch.v1.ResourcePreset}

A preset of resources for hardware configuration of the OpenSearch hosts.

#|
||Field | Description ||
|| id | **string**

ID of the resource preset. ||
|| zoneIds[] | **string**

IDs of the availability zones where the resource preset is available. ||
|| cores | **string** (int64)

Number of the CPU cores for an OpenSearch host created with the preset. ||
|| memory | **string** (int64)

RAM volume for an OpenSearch host created with the preset, in bytes. ||
|#