---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/api-ref/grpc/ServiceAccount/list.md
---

# Identity and Access Management API, gRPC: ServiceAccountService.List

Retrieves the list of ServiceAccount resources in the specified folder.

## gRPC request

**rpc List ([ListServiceAccountsRequest](#yandex.cloud.iam.v1.ListServiceAccountsRequest)) returns ([ListServiceAccountsResponse](#yandex.cloud.iam.v1.ListServiceAccountsResponse))**

## ListServiceAccountsRequest {#yandex.cloud.iam.v1.ListServiceAccountsRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to list service accounts in.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListServiceAccountsResponse.next_page_token](#yandex.cloud.iam.v1.ListServiceAccountsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100 ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token`
to the [ListServiceAccountsResponse.next_page_token](#yandex.cloud.iam.v1.ListServiceAccountsResponse)
returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on the [ServiceAccount.name](#yandex.cloud.iam.v1.ServiceAccount) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. ||
|#

## ListServiceAccountsResponse {#yandex.cloud.iam.v1.ListServiceAccountsResponse}

```json
{
  "service_accounts": [
    {
      "id": "string",
      "folder_id": "string",
      "created_at": "google.protobuf.Timestamp",
      "name": "string",
      "description": "string",
      "labels": "map<string, string>",
      "last_authenticated_at": "google.protobuf.Timestamp"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| service_accounts[] | **[ServiceAccount](#yandex.cloud.iam.v1.ServiceAccount)**

List of ServiceAccount resources. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListServiceAccountsRequest.page_size](#yandex.cloud.iam.v1.ListServiceAccountsRequest), use
the `next_page_token` as the value
for the [ListServiceAccountsRequest.page_token](#yandex.cloud.iam.v1.ListServiceAccountsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## ServiceAccount {#yandex.cloud.iam.v1.ServiceAccount}

A ServiceAccount resource. For more information, see [Service accounts](/docs/iam/concepts/users/service-accounts).

#|
||Field | Description ||
|| id | **string**

ID of the service account. ||
|| folder_id | **string**

ID of the folder that the service account belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the service account.
The name is unique within the cloud. 3-63 characters long. ||
|| description | **string**

Description of the service account. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|| last_authenticated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp for the last authentication of this service account. ||
|#