---
editable: false
apiPlayground:
  - url: https://iam.{{ api-host }}/iam/v1/oauthClients
    method: get
    path: null
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `pageSize`,
            the service returns a [ListOAuthClientsResponse.nextPageToken](/docs/iam/api-ref/OAuthClient/list#yandex.cloud.iam.v1.ListOAuthClientsResponse)
            that can be used to get the next page of results in subsequent list requests.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `pageToken` to the
            [ListOAuthClientsResponse.nextPageToken](/docs/iam/api-ref/OAuthClient/list#yandex.cloud.iam.v1.ListOAuthClientsResponse) returned by a previous list request.
          type: string
        folderId:
          description: |-
            **string**
            Required field. ID of the folder to list oauth clients for
            To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.
          type: string
      required:
        - folderId
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/iam/v1/api-ref/OAuthClient/list.md
---

# Identity and Access Management API, REST: OAuthClient.List

Retrieves the list of OAuthClient resources views in the specified folder

## HTTP request

```
GET https://iam.{{ api-host }}/iam/v1/oauthClients
```

## Query parameters {#yandex.cloud.iam.v1.ListOAuthClientsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListOAuthClientsResponse.nextPageToken](#yandex.cloud.iam.v1.ListOAuthClientsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListOAuthClientsResponse.nextPageToken](#yandex.cloud.iam.v1.ListOAuthClientsResponse) returned by a previous list request. ||
|| folderId | **string**

Required field. ID of the folder to list oauth clients for
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|#

## Response {#yandex.cloud.iam.v1.ListOAuthClientsResponse}

**HTTP Code: 200 - OK**

```json
{
  "oauthClients": [
    {
      "id": "string",
      "name": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| oauthClients[] | **[OAuthClientListView](#yandex.cloud.iam.v1.OAuthClientListView)**

List of OAuthClient resource views ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListOAuthClientsRequest.pageSize](#yandex.cloud.iam.v1.ListOAuthClientsRequest), use
the `nextPageToken` as the value
for the [ListOAuthClientsRequest.pageToken](#yandex.cloud.iam.v1.ListOAuthClientsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## OAuthClientListView {#yandex.cloud.iam.v1.OAuthClientListView}

#|
||Field | Description ||
|| id | **string**

ID of the OAuthClient resource. ||
|| name | **string**

Name of the OAuthClient resource. ||
|#