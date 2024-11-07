---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/workload/workload-identity/api-ref/grpc/FederatedCredential/list.md
---

# Workload Identity, gRPC: FederatedCredentialService.List {#List}

Retrieves the list of federated credentials for the specified service account.

## gRPC request

**rpc List ([ListFederatedCredentialsRequest](#yandex.cloud.iam.v1.workload.ListFederatedCredentialsRequest)) returns ([ListFederatedCredentialsResponse](#yandex.cloud.iam.v1.workload.ListFederatedCredentialsResponse))**

## ListFederatedCredentialsRequest {#yandex.cloud.iam.v1.workload.ListFederatedCredentialsRequest}

```json
{
  "serviceAccountId": "string",
  "pageSize": "int64",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| serviceAccountId | **string**

Required field. ID of the service account to list federated credentials for.
To get the the service account ID make a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/ServiceAccount/list#List) request. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListFederatedCredentialsResponse.nextPageToken](#yandex.cloud.iam.v1.workload.ListFederatedCredentialsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken`
to the [ListFederatedCredentialsResponse.nextPageToken](#yandex.cloud.iam.v1.workload.ListFederatedCredentialsResponse)
returned by a previous list request. ||
|#

## ListFederatedCredentialsResponse {#yandex.cloud.iam.v1.workload.ListFederatedCredentialsResponse}

```json
{
  "federatedCredentials": [
    {
      "id": "string",
      "serviceAccountId": "string",
      "federationId": "string",
      "externalSubjectId": "string",
      "createdAt": "google.protobuf.Timestamp"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| federatedCredentials[] | **[FederatedCredential](#yandex.cloud.iam.v1.workload.FederatedCredential)**

List of federated credentials. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListFederatedCredentialsRequest.pageSize](#yandex.cloud.iam.v1.workload.ListFederatedCredentialsRequest), use
the `nextPageToken` as the value
for the [ListFederatedCredentialsRequest.pageToken](#yandex.cloud.iam.v1.workload.ListFederatedCredentialsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## FederatedCredential {#yandex.cloud.iam.v1.workload.FederatedCredential}

A federated credential.

#|
||Field | Description ||
|| id | **string**

Id of the federated credential. ||
|| serviceAccountId | **string**

Id of the service account that the federated credential belongs to. ||
|| federationId | **string**

ID of the workload identity federation which is used for authentication. ||
|| externalSubjectId | **string**

Id of the external subject. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|#