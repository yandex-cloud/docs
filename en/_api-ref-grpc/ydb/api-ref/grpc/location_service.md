---
editable: false
---

# Managed Service for YDB API, gRPC: LocationService



| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified location. |
| [List](#List) | Returns the list of available locations. |

## Calls LocationService {#calls}

## Get {#Get}

Returns the specified location.

**rpc Get ([GetLocationRequest](#GetLocationRequest)) returns ([Location](#Location))**

### GetLocationRequest {#GetLocationRequest}

Field | Description
--- | ---
location_id | **string**<br>Required. Required. ID of the location to return. 


### Location {#Location}

Field | Description
--- | ---
id | **string**<br> 
description | **string**<br> 


## List {#List}

Returns the list of available locations.

**rpc List ([ListLocationsRequest](#ListLocationsRequest)) returns ([ListLocationsResponse](#ListLocationsResponse))**

### ListLocationsRequest {#ListLocationsRequest}

Field | Description
--- | ---
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a `next_page_token` that can be used to get the next page of results in subsequent ListLocations requests. Acceptable values are 0 to 1000, inclusive. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. Set `page_token` to the `next_page_token` returned by a previous ListLocations request to get the next page of results. The maximum string length in characters is 100.


### ListLocationsResponse {#ListLocationsResponse}

Field | Description
--- | ---
locations[] | **[Location](#Location1)**<br>Requested list of locations. 
next_page_token | **string**<br>This token allows you to get the next page of results for ListLocations requests, if the number of results is larger than `page_size` specified in the request. To get the next page, specify the value of `next_page_token` as a value for the `page_token` parameter in the next ListLocations request. Subsequent ListLocations requests will have their own `next_page_token` to continue paging through the results. 


### Location {#Location1}

Field | Description
--- | ---
id | **string**<br> 
description | **string**<br> 


