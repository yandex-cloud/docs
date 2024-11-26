---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/workload/workload-identity/api-ref/grpc/FederatedCredential/list.md
---

# Workload Identity, gRPC: FederatedCredentialService.List

Retrieves the list of federated credentials for the specified service account.

## gRPC request

**rpc List ([ListFederatedCredentialsRequest](#yandex.cloud.iam.v1.workload.ListFederatedCredentialsRequest)) returns ([ListFederatedCredentialsResponse](#yandex.cloud.iam.v1.workload.ListFederatedCredentialsResponse))**

## ListFederatedCredentialsRequest {#yandex.cloud.iam.v1.workload.ListFederatedCredentialsRequest}

```json
{
  "service_account_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| service_account_id | **string**

Required field. ID of the service account to list federated credentials for.
To get the the service account ID make a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/ServiceAccount/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListFederatedCredentialsResponse.next_page_token](#yandex.cloud.iam.v1.workload.ListFederatedCredentialsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token`
to the [ListFederatedCredentialsResponse.next_page_token](#yandex.cloud.iam.v1.workload.ListFederatedCredentialsResponse)
returned by a previous list request. ||
|#

## ListFederatedCredentialsResponse {#yandex.cloud.iam.v1.workload.ListFederatedCredentialsResponse}

```json
{
  "federated_credentials": [
    {
      "id": "string",
      "service_account_id": "string",
      "federation_id": "string",
      "external_subject_id": "string",
      "created_at": "google.protobuf.Timestamp"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| federated_credentials[] | **[FederatedCredential](#yandex.cloud.iam.v1.workload.FederatedCredential)**

List of federated credentials. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListFederatedCredentialsRequest.page_size](#yandex.cloud.iam.v1.workload.ListFederatedCredentialsRequest), use
the `next_page_token` as the value
for the [ListFederatedCredentialsRequest.page_token](#yandex.cloud.iam.v1.workload.ListFederatedCredentialsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## FederatedCredential {#yandex.cloud.iam.v1.workload.FederatedCredential}

A federated credential.

#|
||Field | Description ||
|| id | **string**

Id of the federated credential. ||
|| service_account_id | **string**

Id of the service account that the federated credential belongs to. ||
|| federation_id | **string**

ID of the workload identity federation which is used for authentication. ||
|| external_subject_id | **string**

Id of the external subject. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|#