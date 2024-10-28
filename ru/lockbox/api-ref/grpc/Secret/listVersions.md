---
editable: false
sourcePath: en/_api-ref-grpc/lockbox/v1/api-ref/grpc/Secret/listVersions.md
---

# Lockbox API, gRPC: SecretService.ListVersions {#ListVersions}

Retrieves the list of versions of the specified secret.

## gRPC request

**rpc ListVersions ([ListVersionsRequest](#yandex.cloud.lockbox.v1.ListVersionsRequest)) returns ([ListVersionsResponse](#yandex.cloud.lockbox.v1.ListVersionsResponse))**

## ListVersionsRequest {#yandex.cloud.lockbox.v1.ListVersionsRequest}

```json
{
  "secretId": "string",
  "pageSize": "int64",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| secretId | **string**

Required field. ID of the secret to list versions for. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListVersionsRequest.next_page_token]
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListVersionsRequest.next_page_token] returned by a previous list request. ||
|#

## ListVersionsResponse {#yandex.cloud.lockbox.v1.ListVersionsResponse}

```json
{
  "versions": [
    {
      "id": "string",
      "secretId": "string",
      "createdAt": "google.protobuf.Timestamp",
      "destroyAt": "google.protobuf.Timestamp",
      "description": "string",
      "status": "Status",
      "payloadEntryKeys": [
        "string"
      ],
      // Includes only one of the fields `passwordPayloadSpecification`
      "passwordPayloadSpecification": {
        "passwordKey": "string",
        "length": "int64",
        "includeUppercase": "google.protobuf.BoolValue",
        "includeLowercase": "google.protobuf.BoolValue",
        "includeDigits": "google.protobuf.BoolValue",
        "includePunctuation": "google.protobuf.BoolValue",
        "includedPunctuation": "string",
        "excludedPunctuation": "string"
      }
      // end of the list of possible fields
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| versions[] | **[Version](#yandex.cloud.lockbox.v1.Version)**

List of versions for the specified secret. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number
of results is greater than the specified [ListVersionsRequest.pageSize](#yandex.cloud.lockbox.v1.ListVersionsRequest), use
the `next_page_token` as the value for the [ListVersionsRequest.pageToken](#yandex.cloud.lockbox.v1.ListVersionsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## Version {#yandex.cloud.lockbox.v1.Version}

#|
||Field | Description ||
|| id | **string**

ID of the version. ||
|| secretId | **string**

ID of the secret that the version belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the version was created. ||
|| destroyAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the version is going to be destroyed. Empty unless the status
is `SCHEDULED_FOR_DESTRUCTION`. ||
|| description | **string**

Description of the version. ||
|| status | enum **Status**

Status of the secret.

- `STATUS_UNSPECIFIED`
- `ACTIVE`: The version is active and the secret payload can be accessed.
- `SCHEDULED_FOR_DESTRUCTION`: The version is scheduled for destruction, the time when it will be destroyed
is specified in the `Version.destroyAt` field.
- `DESTROYED`: The version is destroyed and cannot be recovered. ||
|| payloadEntryKeys[] | **string**

Keys of the entries contained in the version payload. ||
|| passwordPayloadSpecification | **[PasswordPayloadSpecification](#yandex.cloud.lockbox.v1.PasswordPayloadSpecification)**

Includes only one of the fields `passwordPayloadSpecification`. ||
|#

## PasswordPayloadSpecification {#yandex.cloud.lockbox.v1.PasswordPayloadSpecification}

#|
||Field | Description ||
|| passwordKey | **string**

Required field. key of the entry to store generated password value ||
|| length | **int64**

password length; by default, a reasonable length will be decided ||
|| includeUppercase | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

whether at least one A..Z character is included in the password, true by default ||
|| includeLowercase | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

whether at least one a..z character is included in the password, true by default ||
|| includeDigits | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

whether at least one 0..9 character is included in the password, true by default ||
|| includePunctuation | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

whether at least one punctuation character is included in the password, true by default
punctuation characters by default (there are 32): !"#$%&'()*+,-./:;<=>?@[\]^_`{\|}~
to customize the punctuation characters, see included_punctuation and excluded_punctuation below ||
|| includedPunctuation | **string**

If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation:
a string of specific punctuation characters to use (at most, all the 32) ||
|| excludedPunctuation | **string**

a string of punctuation characters to exclude from the default (at most 31, it's not allowed to exclude all the 32) ||
|#