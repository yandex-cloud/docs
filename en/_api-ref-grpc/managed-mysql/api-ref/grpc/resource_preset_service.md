---
editable: false
---

# ResourcePresetService

A set of methods for managing MySQL resource presets. 

See [the documentation](/docs/managed-mysql/concepts/instance-types) for details.

| Call | Description |
| --- | --- |
| [Get](#Get) | Retrieves information about a resource preset. |
| [List](#List) | Retrieves the list of available resource presets. |

## Calls ResourcePresetService {#calls}

## Get {#Get}

Retrieves information about a resource preset.

**rpc Get ([GetResourcePresetRequest](#GetResourcePresetRequest)) returns ([ResourcePreset](#ResourcePreset))**

### GetResourcePresetRequest {#GetResourcePresetRequest}

Field | Description
--- | ---
resource_preset_id | **string**<br>Required. ID of the resource preset to return information about. <br>To get this ID, make a [ResourcePresetService.List](#List) request. 


### ResourcePreset {#ResourcePreset}

Field | Description
--- | ---
id | **string**<br>ID of the resource preset that defines available computational resources (vCPU, RAM, etc.) for a cluster host. 
zone_ids[] | **string**<br>IDs of availability zones where the resource preset is available. 
cores | **int64**<br>Number of CPU cores for a MySQL host created with the preset. 
memory | **int64**<br>RAM volume for a MySQL host created with the preset, in bytes. 


## List {#List}

Retrieves the list of available resource presets.

**rpc List ([ListResourcePresetsRequest](#ListResourcePresetsRequest)) returns ([ListResourcePresetsResponse](#ListResourcePresetsResponse))**

### ListResourcePresetsRequest {#ListResourcePresetsRequest}

Field | Description
--- | ---
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the API returns a [ListResourcePresetsResponse.next_page_token](#ListResourcePresetsResponse) that can be used to get the next page of results in the subsequent [ResourcePresetService.List](#List) requests. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token that can be used to iterate through multiple pages of results. <br>To get the next page of results, set `page_token` to the [ListResourcePresetsResponse.next_page_token](#ListResourcePresetsResponse) returned by the previous [ResourcePresetService.List](#List) request. The maximum string length in characters is 100.


### ListResourcePresetsResponse {#ListResourcePresetsResponse}

Field | Description
--- | ---
resource_presets[] | **[ResourcePreset](#ResourcePreset1)**<br>List of resource presets. 
next_page_token | **string**<br>The token that can be used to get the next page of results. <br>If the number of results is larger than [ListResourcePresetsRequest.page_size](#ListResourcePresetsRequest), use the `next_page_token` as the value for the [ListResourcePresetsRequest.page_token](#ListResourcePresetsRequest) in the subsequent [ResourcePresetService.List](#List) request to iterate through multiple pages of results. <br>Each of the subsequent [ResourcePresetService.List](#List) requests should use the `next_page_token` value returned by the previous request to continue paging through the results. The maximum string length in characters is 100.


### ResourcePreset {#ResourcePreset1}

Field | Description
--- | ---
id | **string**<br>ID of the resource preset that defines available computational resources (vCPU, RAM, etc.) for a cluster host. 
zone_ids[] | **string**<br>IDs of availability zones where the resource preset is available. 
cores | **int64**<br>Number of CPU cores for a MySQL host created with the preset. 
memory | **int64**<br>RAM volume for a MySQL host created with the preset, in bytes. 


