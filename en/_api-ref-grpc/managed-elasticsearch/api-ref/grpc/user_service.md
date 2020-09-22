---
editable: false
---

# UserService

A set of methods for managing Elasticsearch users.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified Elasticsearch user. |
| [List](#List) | Retrieves the list of Elasticsearch users in the specified cluster. |

## Calls UserService {#calls}

## Get {#Get}

Returns the specified Elasticsearch user. <br>To get the list of available Elasticsearch users, make a [List](#List) request.

**rpc Get ([GetUserRequest](#GetUserRequest)) returns ([User](../user.proto#User))**

### GetUserRequest {#GetUserRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Elasticsearch cluster the user belongs to. <br>To get the cluster ID, make a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
user_name | **string**<br>Required. Name of the Elasticsearch user to return. <br>To get the name of the user, make a [UserService.List](#List) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.


### User {#User}

Field | Description
--- | ---
name | **string**<br>Name of the Elasticsearch user. 
cluster_id | **string**<br>ID of the Elasticsearch cluster the user belongs to. 


## List {#List}

Retrieves the list of Elasticsearch users in the specified cluster.

**rpc List ([ListUsersRequest](#ListUsersRequest)) returns ([ListUsersResponse](#ListUsersResponse))**

### ListUsersRequest {#ListUsersRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Elasticsearch cluster to list Elasticsearch users in. <br>To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the service returns a [ListUsersResponse.next_page_token](#ListUsersResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. <br>To get the next page of results, set `page_token` to the [ListUsersResponse.next_page_token](#ListUsersResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListUsersResponse {#ListUsersResponse}

Field | Description
--- | ---
users[] | **[User](../user.proto#User1)**<br>List of Elasticsearch users. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. <br>If the number of results is larger than [ListUsersRequest.page_size](#ListUsersRequest), use the `next_page_token` as the value for the [ListUsersRequest.page_token](#ListUsersRequest) parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### User {#User1}

Field | Description
--- | ---
name | **string**<br>Name of the Elasticsearch user. 
cluster_id | **string**<br>ID of the Elasticsearch cluster the user belongs to. 


