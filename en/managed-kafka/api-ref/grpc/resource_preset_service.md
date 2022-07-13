---
editable: false
sourcePath: en/_api-ref-grpc/managed-kafka/api-ref/grpc/resource_preset_service.md
---

# ResourcePresetService

A set of methods for managing Kafka resource presets.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified resource preset. |
| [List](#List) | Retrieves the list of available resource presets. |

## Calls ResourcePresetService {#calls}

## Get {#Get}

Returns the specified resource preset. <br>To get the list of available resource presets, make a [List](#List) request.

**rpc Get ([GetResourcePresetRequest](#GetResourcePresetRequest)) returns ([ResourcePreset](#ResourcePreset))**

### GetResourcePresetRequest {#GetResourcePresetRequest}

Field | Description
--- | ---
resource_preset_id | **string**<br>Required. ID of the resource preset to return. <br>To get the resource preset ID, use a [ResourcePresetService.List](#List) request. 


### ResourcePreset {#ResourcePreset}

Field | Description
--- | ---
id | **string**<br>ID of the resource preset. 
zone_ids[] | **string**<br>IDs of availability zones where the resource preset is available. 
cores | **int64**<br>Number of CPU cores for a Kafka broker created with the preset. 
memory | **int64**<br>RAM volume for a Kafka broker created with the preset, in bytes. 


## List {#List}

Retrieves the list of available resource presets.

**rpc List ([ListResourcePresetsRequest](#ListResourcePresetsRequest)) returns ([ListResourcePresetsResponse](#ListResourcePresetsResponse))**

### ListResourcePresetsRequest {#ListResourcePresetsRequest}

Field | Description
--- | ---
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the service returns a [ListResourcePresetsResponse.next_page_token](#ListResourcePresetsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. <br>To get the next page of results, set `page_token` to the [ListResourcePresetsResponse.next_page_token](#ListResourcePresetsResponse), returned by the previous list request. The maximum string length in characters is 100.


### ListResourcePresetsResponse {#ListResourcePresetsResponse}

Field | Description
--- | ---
resource_presets[] | **[ResourcePreset](#ResourcePreset1)**<br>List of resource presets. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. <br>If the number of results is larger than [ListResourcePresetsRequest.page_size](#ListResourcePresetsRequest), use `next_page_token` as the value for the [ListResourcePresetsRequest.page_token](#ListResourcePresetsRequest) parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. The maximum string length in characters is 100.


### ResourcePreset {#ResourcePreset1}

Field | Description
--- | ---
id | **string**<br>ID of the resource preset. 
zone_ids[] | **string**<br>IDs of availability zones where the resource preset is available. 
cores | **int64**<br>Number of CPU cores for a Kafka broker created with the preset. 
memory | **int64**<br>RAM volume for a Kafka broker created with the preset, in bytes. 


