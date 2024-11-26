---
editable: false
sourcePath: en/_api-ref-grpc/serverless/functions/v1/functions/api-ref/grpc/Network/listConnectedResources.md
---

# Cloud Functions Service, gRPC: NetworkService.ListConnectedResources

Retrieves the list of serverless resources connected to any network from the specified scope.

## gRPC request

**rpc ListConnectedResources ([ListConnectedResourcesRequest](#yandex.cloud.serverless.functions.v1.ListConnectedResourcesRequest)) returns ([ListConnectedResourcesResponse](#yandex.cloud.serverless.functions.v1.ListConnectedResourcesResponse))**

## ListConnectedResourcesRequest {#yandex.cloud.serverless.functions.v1.ListConnectedResourcesRequest}

```json
{
  "page_size": "int64",
  "page_token": "string",
  // Includes only one of the fields `network_id`, `cloud_id`, `folder_id`
  "network_id": "string",
  "cloud_id": "string",
  "folder_id": "string"
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListConnectedResourcesResponse.next_page_token](#yandex.cloud.serverless.functions.v1.ListConnectedResourcesResponse)
that can be used to get the next page of results in subsequent list requests.

Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListConnectedResourcesResponse.next_page_token](#yandex.cloud.serverless.functions.v1.ListConnectedResourcesResponse) returned by a previous list request. ||
|| network_id | **string**

ID of the network to list serverless resources connected to it.

Includes only one of the fields `network_id`, `cloud_id`, `folder_id`. ||
|| cloud_id | **string**

ID of the cloud to list serverless resources connected to any network from it.

Includes only one of the fields `network_id`, `cloud_id`, `folder_id`. ||
|| folder_id | **string**

ID of the folder to list serverless resources connected to any network from it.

Includes only one of the fields `network_id`, `cloud_id`, `folder_id`. ||
|#

## ListConnectedResourcesResponse {#yandex.cloud.serverless.functions.v1.ListConnectedResourcesResponse}

```json
{
  "resources": [
    {
      "network_id": "string",
      "resource_type": "string",
      "resource_id": "string",
      "subresource_type": "string",
      "subresource_id": "string",
      "resource_cloud_id": "string",
      "resource_folder_id": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| resources[] | **[ConnectedResource](#yandex.cloud.serverless.functions.v1.ListConnectedResourcesResponse.ConnectedResource)**

List of serverless resources connected to any network from the specified scope. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListConnectedResourcesRequest.page_size](#yandex.cloud.serverless.functions.v1.ListConnectedResourcesRequest), use `nextPageToken` as the value
for the [ListConnectedResourcesRequest.page_token](#yandex.cloud.serverless.functions.v1.ListConnectedResourcesRequest) parameter in the next list request.

Each subsequent page will have its own `nextPageToken` to continue paging through the results. ||
|#

## ConnectedResource {#yandex.cloud.serverless.functions.v1.ListConnectedResourcesResponse.ConnectedResource}

Serverless resource connected to VPC network.

#|
||Field | Description ||
|| network_id | **string**

ID of the network to which the resource is connected. ||
|| resource_type | **string**

Type of the serverless resource. ||
|| resource_id | **string**

ID of the serverless resource. ||
|| subresource_type | **string**

Type of the serverless subresource. ||
|| subresource_id | **string**

ID of the serverless subresource. ||
|| resource_cloud_id | **string**

ID of the cloud that the resource belongs to. ||
|| resource_folder_id | **string**

ID of the folder thar the resource belongs to. ||
|#