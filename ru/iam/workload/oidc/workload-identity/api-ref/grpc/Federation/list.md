---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/workload/oidc/workload-identity/api-ref/grpc/Federation/list.md
---

# Federation, gRPC: FederationService.List

Retrieves the list of OIDC workload identity federations in the specified folder.

## gRPC request

**rpc List ([ListFederationsRequest](#yandex.cloud.iam.v1.workload.oidc.ListFederationsRequest)) returns ([ListFederationsResponse](#yandex.cloud.iam.v1.workload.oidc.ListFederationsResponse))**

## ListFederationsRequest {#yandex.cloud.iam.v1.workload.oidc.ListFederationsRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to list OIDC workload identity federations in.
To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListFederationsResponse.next_page_token](#yandex.cloud.iam.v1.workload.oidc.ListFederationsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100 ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token`
to the [ListFederationsResponse.next_page_token](#yandex.cloud.iam.v1.workload.oidc.ListFederationsResponse)
returned by a previous list request. ||
|#

## ListFederationsResponse {#yandex.cloud.iam.v1.workload.oidc.ListFederationsResponse}

```json
{
  "federations": [
    {
      "id": "string",
      "name": "string",
      "folder_id": "string",
      "description": "string",
      "enabled": "bool",
      "audiences": [
        "string"
      ],
      "issuer": "string",
      "jwks_url": "string",
      "labels": "string",
      "created_at": "google.protobuf.Timestamp"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| federations[] | **[Federation](#yandex.cloud.iam.v1.workload.oidc.Federation)**

List of OIDC workload identity federations. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListFederationsRequest.page_size](#yandex.cloud.iam.v1.workload.oidc.ListFederationsRequest), use
the `next_page_token` as the value
for the [ListFederationsRequest.page_token](#yandex.cloud.iam.v1.workload.oidc.ListFederationsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
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
|| folder_id | **string**

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
|| jwks_url | **string**

URL reference to trusted keys in format of JSON Web Key Set. ||
|| labels | **string**

Resource labels as `` key:value `` pairs ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|#