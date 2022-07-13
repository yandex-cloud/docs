---
editable: false
sourcePath: en/_api-ref-grpc/ydb/api-ref/grpc/resource_preset_service.md
---

# ResourcePresetService



| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified resource preset. |
| [List](#List) | Returns the list of available resource presets. |

## Calls ResourcePresetService {#calls}

## Get {#Get}

Returns the specified resource preset.

**rpc Get ([GetResourcePresetRequest](#GetResourcePresetRequest)) returns ([ResourcePreset](#ResourcePreset))**

### GetResourcePresetRequest {#GetResourcePresetRequest}

Field | Description
--- | ---
resource_preset_id | **string**<br>Required. Required. ID of the resource preset to return. 


### ResourcePreset {#ResourcePreset}

Field | Description
--- | ---
id | **string**<br> 
cores | **int64**<br> 
memory | **int64**<br> 


## List {#List}

Returns the list of available resource presets.

**rpc List ([ListResourcePresetsRequest](#ListResourcePresetsRequest)) returns ([ListResourcePresetsResponse](#ListResourcePresetsResponse))**

### ListResourcePresetsRequest {#ListResourcePresetsRequest}

Field | Description
--- | ---
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a `next_page_token` that can be used to get the next page of results in subsequent ListResourcePresets requests. Acceptable values are 0 to 1000, inclusive. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. Set `page_token` to the `next_page_token` returned by a previous ListResourcePresets request to get the next page of results. The maximum string length in characters is 100.


### ListResourcePresetsResponse {#ListResourcePresetsResponse}

Field | Description
--- | ---
resource_presets[] | **[ResourcePreset](#ResourcePreset1)**<br>Requested list of resource presets. 
next_page_token | **string**<br>This token allows you to get the next page of results for ListResourcePresets requests, if the number of results is larger than `page_size` specified in the request. To get the next page, specify the value of `next_page_token` as a value for the `page_token` parameter in the next ListResourcePresets request. Subsequent ListResourcePresets requests will have their own `next_page_token` to continue paging through the results. 


### ResourcePreset {#ResourcePreset1}

Field | Description
--- | ---
id | **string**<br> 
cores | **int64**<br> 
memory | **int64**<br> 


