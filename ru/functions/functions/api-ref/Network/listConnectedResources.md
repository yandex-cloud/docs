---
editable: false
sourcePath: en/_api-ref/serverless/functions/v1/functions/api-ref/Network/listConnectedResources.md
---

# Cloud Functions Service, REST: Network.ListConnectedResources {#ListConnectedResources}

Retrieves the list of serverless resources connected to any network from the specified scope.

## HTTP request

```
GET https://serverless-functions.{{ api-host }}/functions/v1/networks/connections
```

## Query parameters {#yandex.cloud.serverless.functions.v1.ListConnectedResourcesRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListConnectedResourcesResponse.nextPageToken](#yandex.cloud.serverless.functions.v1.ListConnectedResourcesResponse)
that can be used to get the next page of results in subsequent list requests.

Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListConnectedResourcesResponse.nextPageToken](#yandex.cloud.serverless.functions.v1.ListConnectedResourcesResponse) returned by a previous list request. ||
|| networkId | **string**

ID of the network to list serverless resources connected to it.

Includes only one of the fields `networkId`, `cloudId`, `folderId`. ||
|| cloudId | **string**

ID of the cloud to list serverless resources connected to any network from it.

Includes only one of the fields `networkId`, `cloudId`, `folderId`. ||
|| folderId | **string**

ID of the folder to list serverless resources connected to any network from it.

Includes only one of the fields `networkId`, `cloudId`, `folderId`. ||
|#

## Response {#yandex.cloud.serverless.functions.v1.ListConnectedResourcesResponse}

**HTTP Code: 200 - OK**

```json
{
  "resources": [
    {
      "networkId": "string",
      "resourceType": "string",
      "resourceId": "string",
      "subresourceType": "string",
      "subresourceId": "string",
      "resourceCloudId": "string",
      "resourceFolderId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| resources[] | **[ConnectedResource](#yandex.cloud.serverless.functions.v1.ListConnectedResourcesResponse.ConnectedResource)**

List of serverless resources connected to any network from the specified scope. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListConnectedResourcesRequest.pageSize](#yandex.cloud.serverless.functions.v1.ListConnectedResourcesRequest), use `nextPageToken` as the value
for the [ListConnectedResourcesRequest.pageToken](#yandex.cloud.serverless.functions.v1.ListConnectedResourcesRequest) parameter in the next list request.

Each subsequent page will have its own `nextPageToken` to continue paging through the results. ||
|#

## ConnectedResource {#yandex.cloud.serverless.functions.v1.ListConnectedResourcesResponse.ConnectedResource}

Serverless resource connected to VPC network.

#|
||Field | Description ||
|| networkId | **string**

ID of the network to which the resource is connected. ||
|| resourceType | **string**

Type of the serverless resource. ||
|| resourceId | **string**

ID of the serverless resource. ||
|| subresourceType | **string**

Type of the serverless subresource. ||
|| subresourceId | **string**

ID of the serverless subresource. ||
|| resourceCloudId | **string**

ID of the cloud that the resource belongs to. ||
|| resourceFolderId | **string**

ID of the folder thar the resource belongs to. ||
|#