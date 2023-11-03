---
editable: false
sourcePath: en/_api-ref-grpc/functions/functions/functions/api-ref/grpc/network_service.md
---

# Cloud Functions Service, gRPC: NetworkService

A set of methods for managing VPC networks connected to serverless resources.

| Call | Description |
| --- | --- |
| [GetUsed](#GetUsed) | Returns the specified network used in serverless resources. |
| [ListUsed](#ListUsed) | Retrieves the list of networks in the specified scope that are used in serverless resources. |
| [ListConnectedResources](#ListConnectedResources) | Retrieves the list of serverless resources connected to any network from the specified scope. |
| [TriggerUsedCleanup](#TriggerUsedCleanup) | Forces obsolete used network to start cleanup process as soon as possible. |

## Calls NetworkService {#calls}

## GetUsed {#GetUsed}

Returns the specified network used in serverless resources.

**rpc GetUsed ([GetUsedNetworkRequest](#GetUsedNetworkRequest)) returns ([UsedNetwork](#UsedNetwork))**

### GetUsedNetworkRequest {#GetUsedNetworkRequest}

Field | Description
--- | ---
network_id | **string**<br>Required. ID of the network to return. 


### UsedNetwork {#UsedNetwork}

Field | Description
--- | ---
network_id | **string**<br>ID of the VPC network. 
cloud_id | **string**<br>ID of the cloud that the network belongs to. 
folder_id | **string**<br>ID of the folder that the network belongs to. 
status | enum **Status**<br>Status of the network. <ul><li>`CREATING`: Network is connecting to its first serverless resource.</li><li>`ACTIVE`: Network is already being used by some serverless resources.</li><li>`OBSOLETE`: Network is no longer used by any serverless resources. It will be cleaned-up after a while.</li></ul>
will_be_cleaned_up_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Clean-up timestamp of the obsolete network. 
connections_count | **int64**<br>Number of serverless resources connected to the network. 


## ListUsed {#ListUsed}

Retrieves the list of networks in the specified scope that are used in serverless resources.

**rpc ListUsed ([ListUsedNetworksRequest](#ListUsedNetworksRequest)) returns ([ListUsedNetworksResponse](#ListUsedNetworksResponse))**

### ListUsedNetworksRequest {#ListUsedNetworksRequest}

Field | Description
--- | ---
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `pageSize`, the service returns a [ListUsedNetworksResponse.next_page_token](#ListUsedNetworksResponse) that can be used to get the next page of results in subsequent list requests. <br>Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `pageToken` to the [ListUsedNetworksResponse.next_page_token](#ListUsedNetworksResponse) returned by a previous list request. The maximum string length in characters is 100.
scope | **oneof:** `cloud_id` or `folder_id`<br>
&nbsp;&nbsp;cloud_id | **string**<br>ID of the cloud to list used networks in. 
&nbsp;&nbsp;folder_id | **string**<br>ID of the folder to list used networks in. 


### ListUsedNetworksResponse {#ListUsedNetworksResponse}

Field | Description
--- | ---
networks[] | **[UsedNetwork](#UsedNetwork)**<br>List of used networks in the specified scope. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListUsedNetworksRequest.page_size](#ListUsedNetworksRequest), use `nextPageToken` as the value for the [ListUsedNetworksRequest.page_token](#ListUsedNetworksRequest) parameter in the next list request. <br>Each subsequent page will have its own `nextPageToken` to continue paging through the results. 


### UsedNetwork {#UsedNetwork1}

Field | Description
--- | ---
network_id | **string**<br>ID of the VPC network. 
cloud_id | **string**<br>ID of the cloud that the network belongs to. 
folder_id | **string**<br>ID of the folder that the network belongs to. 
status | enum **Status**<br>Status of the network. <ul><li>`CREATING`: Network is connecting to its first serverless resource.</li><li>`ACTIVE`: Network is already being used by some serverless resources.</li><li>`OBSOLETE`: Network is no longer used by any serverless resources. It will be cleaned-up after a while.</li></ul>
will_be_cleaned_up_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Clean-up timestamp of the obsolete network. 
connections_count | **int64**<br>Number of serverless resources connected to the network. 


## ListConnectedResources {#ListConnectedResources}

Retrieves the list of serverless resources connected to any network from the specified scope.

**rpc ListConnectedResources ([ListConnectedResourcesRequest](#ListConnectedResourcesRequest)) returns ([ListConnectedResourcesResponse](#ListConnectedResourcesResponse))**

### ListConnectedResourcesRequest {#ListConnectedResourcesRequest}

Field | Description
--- | ---
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `pageSize`, the service returns a [ListConnectedResourcesResponse.next_page_token](#ListConnectedResourcesResponse) that can be used to get the next page of results in subsequent list requests. <br>Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `pageToken` to the [ListConnectedResourcesResponse.next_page_token](#ListConnectedResourcesResponse) returned by a previous list request. The maximum string length in characters is 100.
network_scope | **oneof:** `network_id`, `cloud_id` or `folder_id`<br>
&nbsp;&nbsp;network_id | **string**<br>ID of the network to list serverless resources connected to it. 
&nbsp;&nbsp;cloud_id | **string**<br>ID of the cloud to list serverless resources connected to any network from it. 
&nbsp;&nbsp;folder_id | **string**<br>ID of the folder to list serverless resources connected to any network from it. 


### ListConnectedResourcesResponse {#ListConnectedResourcesResponse}

Field | Description
--- | ---
resources[] | **ConnectedResource**<br>List of serverless resources connected to any network from the specified scope. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListConnectedResourcesRequest.page_size](#ListConnectedResourcesRequest), use `nextPageToken` as the value for the [ListConnectedResourcesRequest.page_token](#ListConnectedResourcesRequest) parameter in the next list request. <br>Each subsequent page will have its own `nextPageToken` to continue paging through the results. 


### ConnectedResource {#ConnectedResource}

Field | Description
--- | ---
network_id | **string**<br>ID of the network to which the resource is connected. 
resource_type | **string**<br>Type of the serverless resource. 
resource_id | **string**<br>ID of the serverless resource. 
subresource_type | **string**<br>Type of the serverless subresource. 
subresource_id | **string**<br>ID of the serverless subresource. 
resource_cloud_id | **string**<br>ID of the cloud that the resource belongs to. 
resource_folder_id | **string**<br>ID of the folder thar the resource belongs to. 


## TriggerUsedCleanup {#TriggerUsedCleanup}

Forces obsolete used network to start cleanup process as soon as possible. Invocation does not wait for start or end of the cleanup process. Second invocation with the same network does nothing until network is completely cleaned-up.

**rpc TriggerUsedCleanup ([TriggerUsedNetworkCleanupRequest](#TriggerUsedNetworkCleanupRequest)) returns ([TriggerUsedNetworkCleanupResponse](#TriggerUsedNetworkCleanupResponse))**

### TriggerUsedNetworkCleanupRequest {#TriggerUsedNetworkCleanupRequest}

Field | Description
--- | ---
network_id | **string**<br>Required. ID of the obsolete network to start the cleanup process for. 


### TriggerUsedNetworkCleanupResponse {#TriggerUsedNetworkCleanupResponse}

Field | Description
--- | ---
network_cleanup_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Timestamp when cleanup of the specified network will be started. 


