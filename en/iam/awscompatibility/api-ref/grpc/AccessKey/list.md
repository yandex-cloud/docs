---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/awscompatibility/api-ref/grpc/AccessKey/list.md
---

# Identity and Access Management API, gRPC: AccessKeyService.List {#List}

Retrieves the list of access keys for the specified service account.

## gRPC request

**rpc List ([ListAccessKeysRequest](#yandex.cloud.iam.v1.awscompatibility.ListAccessKeysRequest)) returns ([ListAccessKeysResponse](#yandex.cloud.iam.v1.awscompatibility.ListAccessKeysResponse))**

## ListAccessKeysRequest {#yandex.cloud.iam.v1.awscompatibility.ListAccessKeysRequest}

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

ID of the service account to list access keys for.
To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/ServiceAccount/list#List) request.
If not specified, it defaults to the subject that made the request. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListAccessKeysResponse.nextPageToken](#yandex.cloud.iam.v1.awscompatibility.ListAccessKeysResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken`
to the [ListAccessKeysResponse.nextPageToken](#yandex.cloud.iam.v1.awscompatibility.ListAccessKeysResponse)
returned by a previous list request. ||
|#

## ListAccessKeysResponse {#yandex.cloud.iam.v1.awscompatibility.ListAccessKeysResponse}

```json
{
  "accessKeys": [
    {
      "id": "string",
      "serviceAccountId": "string",
      "createdAt": "google.protobuf.Timestamp",
      "description": "string",
      "keyId": "string",
      "lastUsedAt": "google.protobuf.Timestamp"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| accessKeys[] | **[AccessKey](#yandex.cloud.iam.v1.awscompatibility.AccessKey)**

List of access keys. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListAccessKeysRequest.pageSize](#yandex.cloud.iam.v1.awscompatibility.ListAccessKeysRequest), use
the `nextPageToken` as the value
for the [ListAccessKeysRequest.pageToken](#yandex.cloud.iam.v1.awscompatibility.ListAccessKeysRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## AccessKey {#yandex.cloud.iam.v1.awscompatibility.AccessKey}

An access key.
For more information, see [AWS-compatible access keys](/docs/iam/concepts/authorization/access-key).

#|
||Field | Description ||
|| id | **string**

ID of the AccessKey resource.
It is used to manage secret credentials: an access key ID and a secret access key. ||
|| serviceAccountId | **string**

ID of the service account that the access key belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| description | **string**

Description of the access key. 0-256 characters long. ||
|| keyId | **string**

ID of the access key.
The key is AWS compatible. ||
|| lastUsedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp for the last authentication using this Access key. ||
|#