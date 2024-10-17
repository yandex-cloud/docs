---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/api-ref/grpc/ServiceAccount/list.md
---

# Identity and Access Management API, gRPC: ServiceAccountService.List {#List}

Retrieves the list of ServiceAccount resources in the specified folder.

## gRPC request

**rpc List ([ListServiceAccountsRequest](#yandex.cloud.iam.v1.ListServiceAccountsRequest)) returns ([ListServiceAccountsResponse](#yandex.cloud.iam.v1.ListServiceAccountsResponse))**

## ListServiceAccountsRequest {#yandex.cloud.iam.v1.ListServiceAccountsRequest}

```json
{
  "folderId": "string",
  "pageSize": "int64",
  "pageToken": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list service accounts in.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListServiceAccountsResponse.nextPageToken](#yandex.cloud.iam.v1.ListServiceAccountsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100 ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken`
to the [ListServiceAccountsResponse.nextPageToken](#yandex.cloud.iam.v1.ListServiceAccountsResponse)
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
  "serviceAccounts": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "google.protobuf.Timestamp",
      "name": "string",
      "description": "string",
      "labels": "string",
      "lastAuthenticatedAt": "google.protobuf.Timestamp"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| serviceAccounts[] | **[ServiceAccount](#yandex.cloud.iam.v1.ServiceAccount)**

List of ServiceAccount resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListServiceAccountsRequest.pageSize](#yandex.cloud.iam.v1.ListServiceAccountsRequest), use
the `nextPageToken` as the value
for the [ListServiceAccountsRequest.pageToken](#yandex.cloud.iam.v1.ListServiceAccountsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## ServiceAccount {#yandex.cloud.iam.v1.ServiceAccount}

A ServiceAccount resource. For more information, see [Service accounts](/docs/iam/concepts/users/service-accounts).

#|
||Field | Description ||
|| id | **string**

ID of the service account. ||
|| folderId | **string**

ID of the folder that the service account belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the service account.
The name is unique within the cloud. 3-63 characters long. ||
|| description | **string**

Description of the service account. 0-256 characters long. ||
|| labels | **string**

Resource labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|| lastAuthenticatedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp for the last authentication of this service account. ||
|#