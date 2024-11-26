---
editable: false
sourcePath: en/_api-ref/dataproc/v1/api-ref/ResourcePreset/list.md
---

# Data Proc API, REST: ResourcePreset.List

Retrieves the list of available ResourcePreset resources.

## HTTP request

```
GET https://dataproc.{{ api-host }}/dataproc/v1/resourcePresets
```

## Query parameters {#yandex.cloud.dataproc.v1.ListResourcePresetsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListResourcePresetsResponse.nextPageToken](#yandex.cloud.dataproc.v1.ListResourcePresetsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the [ListResourcePresetsResponse.nextPageToken](#yandex.cloud.dataproc.v1.ListResourcePresetsResponse)
returned by a previous list request. ||
|#

## Response {#yandex.cloud.dataproc.v1.ListResourcePresetsResponse}

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
|| resourcePresets[] | **[ResourcePreset](#yandex.cloud.dataproc.v1.ResourcePreset)**

List of ResourcePreset resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListResourcePresetsRequest.pageSize](#yandex.cloud.dataproc.v1.ListResourcePresetsRequest), use the `nextPageToken` as the value
for the [ListResourcePresetsRequest.pageToken](#yandex.cloud.dataproc.v1.ListResourcePresetsRequest) parameter in the next list request. Each subsequent
list request will have its own `nextPageToken` to continue paging through the results. ||
|#

## ResourcePreset {#yandex.cloud.dataproc.v1.ResourcePreset}

A ResourcePreset resource for describing hardware configuration presets.

#|
||Field | Description ||
|| id | **string**

ID of the ResourcePreset resource. ||
|| zoneIds[] | **string**

IDs of availability zones where the resource preset is available. ||
|| cores | **string** (int64)

Number of CPU cores for a Data Proc host created with the preset. ||
|| memory | **string** (int64)

RAM volume for a Data Proc host created with the preset, in bytes. ||
|#