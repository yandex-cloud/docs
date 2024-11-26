---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/awscompatibility/api-ref/grpc/AccessKey/list.md
---

# Access Key, gRPC: AccessKeyService.List

Retrieves the list of access keys for the specified service account.

## gRPC request

**rpc List ([ListAccessKeysRequest](#yandex.cloud.iam.v1.awscompatibility.ListAccessKeysRequest)) returns ([ListAccessKeysResponse](#yandex.cloud.iam.v1.awscompatibility.ListAccessKeysResponse))**

## ListAccessKeysRequest {#yandex.cloud.iam.v1.awscompatibility.ListAccessKeysRequest}

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

ID of the service account to list access keys for.
To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/ServiceAccount/list#List) request.
If not specified, it defaults to the subject that made the request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListAccessKeysResponse.next_page_token](#yandex.cloud.iam.v1.awscompatibility.ListAccessKeysResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token`
to the [ListAccessKeysResponse.next_page_token](#yandex.cloud.iam.v1.awscompatibility.ListAccessKeysResponse)
returned by a previous list request. ||
|#

## ListAccessKeysResponse {#yandex.cloud.iam.v1.awscompatibility.ListAccessKeysResponse}

```json
{
  "access_keys": [
    {
      "id": "string",
      "service_account_id": "string",
      "created_at": "google.protobuf.Timestamp",
      "description": "string",
      "key_id": "string",
      "last_used_at": "google.protobuf.Timestamp"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| access_keys[] | **[AccessKey](#yandex.cloud.iam.v1.awscompatibility.AccessKey)**

List of access keys. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListAccessKeysRequest.page_size](#yandex.cloud.iam.v1.awscompatibility.ListAccessKeysRequest), use
the `next_page_token` as the value
for the [ListAccessKeysRequest.page_token](#yandex.cloud.iam.v1.awscompatibility.ListAccessKeysRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## AccessKey {#yandex.cloud.iam.v1.awscompatibility.AccessKey}

An access key.
For more information, see [AWS-compatible access keys](/docs/iam/concepts/authorization/access-key).

#|
||Field | Description ||
|| id | **string**

ID of the AccessKey resource.
It is used to manage secret credentials: an access key ID and a secret access key. ||
|| service_account_id | **string**

ID of the service account that the access key belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| description | **string**

Description of the access key. 0-256 characters long. ||
|| key_id | **string**

ID of the access key.
The key is AWS compatible. ||
|| last_used_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp for the last authentication using this Access key. ||
|#