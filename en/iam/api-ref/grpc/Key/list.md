---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/api-ref/grpc/Key/list.md
---

# Identity and Access Management API, gRPC: KeyService.List

Retrieves the list of Key resources for the specified service account.

## gRPC request

**rpc List ([ListKeysRequest](#yandex.cloud.iam.v1.ListKeysRequest)) returns ([ListKeysResponse](#yandex.cloud.iam.v1.ListKeysResponse))**

## ListKeysRequest {#yandex.cloud.iam.v1.ListKeysRequest}

```json
{
  "format": "KeyFormat",
  "service_account_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| format | enum **KeyFormat**

Output format of the key.

- `PEM_FILE`: Privacy-Enhanced Mail (PEM) format. Default value. ||
|| service_account_id | **string**

ID of the service account to list key pairs for.
To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/ServiceAccount/list#List) request.
If not specified, it defaults to the subject that made the request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListKeysResponse.next_page_token](#yandex.cloud.iam.v1.ListKeysResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListKeysResponse.next_page_token](#yandex.cloud.iam.v1.ListKeysResponse) returned by a previous list request. ||
|#

## ListKeysResponse {#yandex.cloud.iam.v1.ListKeysResponse}

```json
{
  "keys": [
    {
      "id": "string",
      // Includes only one of the fields `user_account_id`, `service_account_id`
      "user_account_id": "string",
      "service_account_id": "string",
      // end of the list of possible fields
      "created_at": "google.protobuf.Timestamp",
      "description": "string",
      "key_algorithm": "Algorithm",
      "public_key": "string",
      "last_used_at": "google.protobuf.Timestamp"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| keys[] | **[Key](#yandex.cloud.iam.v1.Key)**

List of Key resources. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListKeysRequest.page_size](#yandex.cloud.iam.v1.ListKeysRequest), use
the `next_page_token` as the value
for the [ListKeysRequest.page_token](#yandex.cloud.iam.v1.ListKeysRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## Key {#yandex.cloud.iam.v1.Key}

A Key resource. For more information, see [Authorized keys](/docs/iam/concepts/authorization/key).

#|
||Field | Description ||
|| id | **string**

ID of the Key resource. ||
|| user_account_id | **string**

ID of the user account that the Key resource belongs to.

Includes only one of the fields `user_account_id`, `service_account_id`. ||
|| service_account_id | **string**

ID of the service account that the Key resource belongs to.

Includes only one of the fields `user_account_id`, `service_account_id`. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| description | **string**

Description of the Key resource. 0-256 characters long. ||
|| key_algorithm | enum **Algorithm**

An algorithm used to generate a key pair of the Key resource.

- `ALGORITHM_UNSPECIFIED`
- `RSA_2048`: RSA with a 2048-bit key size. Default value.
- `RSA_4096`: RSA with a 4096-bit key size. ||
|| public_key | **string**

A public key of the Key resource. ||
|| last_used_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp for the last use of this key. ||
|#