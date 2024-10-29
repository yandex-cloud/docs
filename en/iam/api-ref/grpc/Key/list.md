---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/api-ref/grpc/Key/list.md
---

# Identity and Access Management API, gRPC: KeyService.List {#List}

Retrieves the list of Key resources for the specified service account.

## gRPC request

**rpc List ([ListKeysRequest](#yandex.cloud.iam.v1.ListKeysRequest)) returns ([ListKeysResponse](#yandex.cloud.iam.v1.ListKeysResponse))**

## ListKeysRequest {#yandex.cloud.iam.v1.ListKeysRequest}

```json
{
  "format": "KeyFormat",
  "serviceAccountId": "string",
  "pageSize": "int64",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| format | enum **KeyFormat**

Output format of the key.

- `PEM_FILE`: Privacy-Enhanced Mail (PEM) format. Default value. ||
|| serviceAccountId | **string**

ID of the service account to list key pairs for.
To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/ServiceAccount/list#List) request.
If not specified, it defaults to the subject that made the request. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListKeysResponse.nextPageToken](#yandex.cloud.iam.v1.ListKeysResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListKeysResponse.nextPageToken](#yandex.cloud.iam.v1.ListKeysResponse) returned by a previous list request. ||
|#

## ListKeysResponse {#yandex.cloud.iam.v1.ListKeysResponse}

```json
{
  "keys": [
    {
      "id": "string",
      // Includes only one of the fields `userAccountId`, `serviceAccountId`
      "userAccountId": "string",
      "serviceAccountId": "string",
      // end of the list of possible fields
      "createdAt": "google.protobuf.Timestamp",
      "description": "string",
      "keyAlgorithm": "Algorithm",
      "publicKey": "string",
      "lastUsedAt": "google.protobuf.Timestamp"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| keys[] | **[Key](#yandex.cloud.iam.v1.Key)**

List of Key resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListKeysRequest.pageSize](#yandex.cloud.iam.v1.ListKeysRequest), use
the `nextPageToken` as the value
for the [ListKeysRequest.pageToken](#yandex.cloud.iam.v1.ListKeysRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## Key {#yandex.cloud.iam.v1.Key}

A Key resource. For more information, see [Authorized keys](/docs/iam/concepts/authorization/key).

#|
||Field | Description ||
|| id | **string**

ID of the Key resource. ||
|| userAccountId | **string**

ID of the user account that the Key resource belongs to.

Includes only one of the fields `userAccountId`, `serviceAccountId`. ||
|| serviceAccountId | **string**

ID of the service account that the Key resource belongs to.

Includes only one of the fields `userAccountId`, `serviceAccountId`. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| description | **string**

Description of the Key resource. 0-256 characters long. ||
|| keyAlgorithm | enum **Algorithm**

An algorithm used to generate a key pair of the Key resource.

- `ALGORITHM_UNSPECIFIED`
- `RSA_2048`: RSA with a 2048-bit key size. Default value.
- `RSA_4096`: RSA with a 4096-bit key size. ||
|| publicKey | **string**

A public key of the Key resource. ||
|| lastUsedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp for the last use of this key. ||
|#