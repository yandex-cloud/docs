---
editable: false
---

# Identity and Access Management API, gRPC: RoleService

A set of methods for managing Role resources.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified Role resource. |
| [List](#List) | Retrieves the list of Role resources. |

## Calls RoleService {#calls}

## Get {#Get}

Returns the specified Role resource. <br>To get the list of available Role resources, make a [List](#List) request.

**rpc Get ([GetRoleRequest](#GetRoleRequest)) returns ([Role](#Role))**

### GetRoleRequest {#GetRoleRequest}

Field | Description
--- | ---
role_id | **string**<br>Required. ID of the Role resource to return. To get the role ID, use a [RoleService.List](#List) request. The maximum string length in characters is 50.


### Role {#Role}

Field | Description
--- | ---
id | **string**<br>ID of the role. 
description | **string**<br>Description of the role. 0-256 characters long. 


## List {#List}

Retrieves the list of Role resources.

**rpc List ([ListRolesRequest](#ListRolesRequest)) returns ([ListRolesResponse](#ListRolesResponse))**

### ListRolesRequest {#ListRolesRequest}

Field | Description
--- | ---
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListRolesResponse.next_page_token](#ListRolesResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListRolesResponse.next_page_token](#ListRolesResponse) returned by a previous list request. The maximum string length in characters is 2000.
filter | **string**<br>A filter expression that filters resources listed in the response. The maximum string length in characters is 1000.


### ListRolesResponse {#ListRolesResponse}

Field | Description
--- | ---
roles[] | **[Role](#Role1)**<br>List of Role resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListRolesRequest.page_size](#ListRolesRequest), use the `next_page_token` as the value for the [ListRolesRequest.page_token](#ListRolesRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Role {#Role1}

Field | Description
--- | ---
id | **string**<br>ID of the role. 
description | **string**<br>Description of the role. 0-256 characters long. 


