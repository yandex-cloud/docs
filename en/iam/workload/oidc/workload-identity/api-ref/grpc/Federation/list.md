---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/workload/oidc/workload-identity/api-ref/grpc/Federation/list.md
---

# Identity and Access Management Workload Identity API, gRPC: FederationService.List {#List}

Retrieves the list of OIDC workload identity federations in the specified folder.

## gRPC request

**rpc List ([ListFederationsRequest](#yandex.cloud.iam.v1.workload.oidc.ListFederationsRequest)) returns ([ListFederationsResponse](#yandex.cloud.iam.v1.workload.oidc.ListFederationsResponse))**

## ListFederationsRequest {#yandex.cloud.iam.v1.workload.oidc.ListFederationsRequest}

```json
{
  "folderId": "string",
  "pageSize": "int64",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list OIDC workload identity federations in.
To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListFederationsResponse.nextPageToken](#yandex.cloud.iam.v1.workload.oidc.ListFederationsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100 ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken`
to the [ListFederationsResponse.nextPageToken](#yandex.cloud.iam.v1.workload.oidc.ListFederationsResponse)
returned by a previous list request. ||
|#

## ListFederationsResponse {#yandex.cloud.iam.v1.workload.oidc.ListFederationsResponse}

```json
{
  "federations": [
    {
      "id": "string",
      "name": "string",
      "folderId": "string",
      "description": "string",
      "enabled": "bool",
      "audiences": [
        "string"
      ],
      "issuer": "string",
      "jwksUrl": "string",
      "labels": "string",
      "createdAt": "google.protobuf.Timestamp"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| federations[] | **[Federation](#yandex.cloud.iam.v1.workload.oidc.Federation)**

List of OIDC workload identity federations. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListFederationsRequest.pageSize](#yandex.cloud.iam.v1.workload.oidc.ListFederationsRequest), use
the `nextPageToken` as the value
for the [ListFederationsRequest.pageToken](#yandex.cloud.iam.v1.workload.oidc.ListFederationsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## Federation {#yandex.cloud.iam.v1.workload.oidc.Federation}

A OIDC workload identity federation.

#|
||Field | Description ||
|| id | **string**

Id of the OIDC workload identity federation. ||
|| name | **string**

Name of the OIDC workload identity federation
The name is unique within the folder. 3-63 characters long. ||
|| folderId | **string**

ID of the folder that the OIDC workload identity federation belongs to. ||
|| description | **string**

Description of the service account. 0-256 characters long. ||
|| enabled | **bool**

True - the OIDC workload identity federation is enabled and can be used for authentication.
False - the OIDC workload identity federation is disabled and cannot be used for authentication. ||
|| audiences[] | **string**

List of trusted values for aud claim. ||
|| issuer | **string**

URL of the external IdP server to be used for authentication. ||
|| jwksUrl | **string**

URL reference to trusted keys in format of JSON Web Key Set. ||
|| labels | **string**

Resource labels as `` key:value `` pairs ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|#