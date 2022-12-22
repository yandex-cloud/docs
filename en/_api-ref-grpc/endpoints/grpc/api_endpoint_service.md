---
editable: false
---

# Endpoints, gRPC: ApiEndpointService



| Call | Description |
| --- | --- |
| [Get](#Get) |  |
| [List](#List) |  |

## Calls ApiEndpointService {#calls}

## Get {#Get}



**rpc Get ([GetApiEndpointRequest](#GetApiEndpointRequest)) returns ([ApiEndpoint](#ApiEndpoint))**

### GetApiEndpointRequest {#GetApiEndpointRequest}

Field | Description
--- | ---
api_endpoint_id | **string**<br> 


### ApiEndpoint {#ApiEndpoint}

Field | Description
--- | ---
id | **string**<br> 
address | **string**<br> 


## List {#List}



**rpc List ([ListApiEndpointsRequest](#ListApiEndpointsRequest)) returns ([ListApiEndpointsResponse](#ListApiEndpointsResponse))**

### ListApiEndpointsRequest {#ListApiEndpointsRequest}

Field | Description
--- | ---
page_size | **int64**<br> 
page_token | **string**<br> 


### ListApiEndpointsResponse {#ListApiEndpointsResponse}

Field | Description
--- | ---
endpoints[] | **[ApiEndpoint](#ApiEndpoint1)**<br> 
next_page_token | **string**<br> 


### ApiEndpoint {#ApiEndpoint1}

Field | Description
--- | ---
id | **string**<br> 
address | **string**<br> 


