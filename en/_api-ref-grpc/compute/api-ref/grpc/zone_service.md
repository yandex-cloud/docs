---
editable: false
---

# Compute Cloud API, gRPC: ZoneService

A set of methods to retrieve information about availability zones.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the information about the specified availability zone. |
| [List](#List) | Retrieves the list of availability zones. |

## Calls ZoneService {#calls}

## Get {#Get}

Returns the information about the specified availability zone. <br>To get the list of availability zones, make a [List](#List) request.

**rpc Get ([GetZoneRequest](#GetZoneRequest)) returns ([Zone](#Zone))**

### GetZoneRequest {#GetZoneRequest}

Field | Description
--- | ---
zone_id | **string**<br>Required. ID of the availability zone to return information about. The maximum string length in characters is 50.


### Zone {#Zone}

Field | Description
--- | ---
id | **string**<br>ID of the zone. 
region_id | **string**<br>ID of the region. 
status | enum **Status**<br>Status of the zone. <ul><li>`UP`: Zone is available. You can access the resources allocated in this zone.</li><li>`DOWN`: Zone is not available.</li></ul>


## List {#List}

Retrieves the list of availability zones.

**rpc List ([ListZonesRequest](#ListZonesRequest)) returns ([ListZonesResponse](#ListZonesResponse))**

### ListZonesRequest {#ListZonesRequest}

Field | Description
--- | ---
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListZonesResponse.next_page_token](#ListZonesResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListZonesResponse.next_page_token](#ListZonesResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListZonesResponse {#ListZonesResponse}

Field | Description
--- | ---
zones[] | **[Zone](#Zone1)**<br>List of availability zones. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListZonesRequest.page_size](#ListZonesRequest), use the [ListZonesRequest.page_token](#ListZonesRequest) as the value for the [ListZonesRequest.page_token](#ListZonesRequest) query parameter in the next list request. Subsequent list requests will have their own [ListZonesRequest.page_token](#ListZonesRequest) to continue paging through the results. 


### Zone {#Zone1}

Field | Description
--- | ---
id | **string**<br>ID of the zone. 
region_id | **string**<br>ID of the region. 
status | enum **Status**<br>Status of the zone. <ul><li>`UP`: Zone is available. You can access the resources allocated in this zone.</li><li>`DOWN`: Zone is not available.</li></ul>


