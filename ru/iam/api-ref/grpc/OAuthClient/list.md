---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/api-ref/grpc/OAuthClient/list.md
---

# Identity and Access Management API, gRPC: OAuthClientService.List

Retrieves the list of OAuthClient resources views in the specified folder

## gRPC request

**rpc List ([ListOAuthClientsRequest](#yandex.cloud.iam.v1.ListOAuthClientsRequest)) returns ([ListOAuthClientsResponse](#yandex.cloud.iam.v1.ListOAuthClientsResponse))**

## ListOAuthClientsRequest {#yandex.cloud.iam.v1.ListOAuthClientsRequest}

```json
{
  "page_size": "int64",
  "page_token": "string",
  "folder_id": "string"
}
```

#|
||Field | Description ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListOAuthClientsResponse.next_page_token](#yandex.cloud.iam.v1.ListOAuthClientsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListOAuthClientsResponse.next_page_token](#yandex.cloud.iam.v1.ListOAuthClientsResponse) returned by a previous list request. ||
|| folder_id | **string**

Required field. ID of the folder to list oauth clients for
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|#

## ListOAuthClientsResponse {#yandex.cloud.iam.v1.ListOAuthClientsResponse}

```json
{
  "oauth_clients": [
    {
      "id": "string",
      "name": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| oauth_clients[] | **[OAuthClientListView](#yandex.cloud.iam.v1.OAuthClientListView)**

List of OAuthClient resource views ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListOAuthClientsRequest.page_size](#yandex.cloud.iam.v1.ListOAuthClientsRequest), use
the `next_page_token` as the value
for the [ListOAuthClientsRequest.page_token](#yandex.cloud.iam.v1.ListOAuthClientsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## OAuthClientListView {#yandex.cloud.iam.v1.OAuthClientListView}

#|
||Field | Description ||
|| id | **string**

ID of the OAuthClient resource. ||
|| name | **string**

Name of the OAuthClient resource. ||
|#