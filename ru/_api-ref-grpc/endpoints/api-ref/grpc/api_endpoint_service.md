---
editable: false
---

# ApiEndpointService



| Вызов | Описание |
| --- | --- |
| [Get](#Get) |  |
| [List](#List) |  |

## Вызовы ApiEndpointService {#calls}

## Get {#Get}



**rpc Get ([GetApiEndpointRequest](#GetApiEndpointRequest)) returns ([ApiEndpoint](#ApiEndpoint))**

### GetApiEndpointRequest {#GetApiEndpointRequest}

Поле | Описание
--- | ---
api_endpoint_id | **string**<br> 


### ApiEndpoint {#ApiEndpoint}

Поле | Описание
--- | ---
id | **string**<br> 
address | **string**<br> 


## List {#List}



**rpc List ([ListApiEndpointsRequest](#ListApiEndpointsRequest)) returns ([ListApiEndpointsResponse](#ListApiEndpointsResponse))**

### ListApiEndpointsRequest {#ListApiEndpointsRequest}

Поле | Описание
--- | ---
page_size | **int64**<br> 
page_token | **string**<br> 


### ListApiEndpointsResponse {#ListApiEndpointsResponse}

Поле | Описание
--- | ---
endpoints[] | **[ApiEndpoint](#ApiEndpoint1)**<br> 
next_page_token | **string**<br> 


### ApiEndpoint {#ApiEndpoint1}

Поле | Описание
--- | ---
id | **string**<br> 
address | **string**<br> 


