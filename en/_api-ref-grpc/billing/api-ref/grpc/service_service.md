---
editable: false
---

# Billing API, gRPC: ServiceService

A set of methods for managing Service resources.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified service. |
| [List](#List) | Retrieves the list of services. |

## Calls ServiceService {#calls}

## Get {#Get}

Returns the specified service.

**rpc Get ([GetServiceRequest](#GetServiceRequest)) returns ([Service](#Service))**

### GetServiceRequest {#GetServiceRequest}

Field | Description
--- | ---
id | **string**<br>Required. ID of the service to return. To get the service ID, use [ServiceService.List](#List) request. The maximum string length in characters is 50.


### Service {#Service}

Field | Description
--- | ---
id | **string**<br>ID of the service. 
name | **string**<br>Name of the service, e.g. `Compute Cloud`, `VPC`. 
description | **string**<br>Description of the service. 


## List {#List}

Retrieves the list of services.

**rpc List ([ListServicesRequest](#ListServicesRequest)) returns ([ListServicesResponse](#ListServicesResponse))**

### ListServicesRequest {#ListServicesRequest}

Field | Description
--- | ---
filter | **string**<br>A filter expression that filters resources listed in the response. The expression must specify: <ol><li>The field name. Currently you can use filtering only on the [yandex.cloud.billing.v1.Service.id](#Service) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.</li></ol> The maximum string length in characters is 1000.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListServicesResponse.next_page_token](#ListServicesResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListServicesResponse.next_page_token](#ListServicesResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListServicesResponse {#ListServicesResponse}

Field | Description
--- | ---
services[] | **[Service](#Service1)**<br>List of services. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListServicesRequest.page_size](#ListServicesRequest), use `next_page_token` as the value for the [ListServicesRequest.page_token](#ListServicesRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Service {#Service1}

Field | Description
--- | ---
id | **string**<br>ID of the service. 
name | **string**<br>Name of the service, e.g. `Compute Cloud`, `VPC`. 
description | **string**<br>Description of the service. 


