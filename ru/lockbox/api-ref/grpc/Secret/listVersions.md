---
editable: false
sourcePath: en/_api-ref-grpc/lockbox/v1/api-ref/grpc/Secret/listVersions.md
---

# Lockbox API, gRPC: SecretService.ListVersions

Retrieves the list of versions of the specified secret.

## gRPC request

**rpc ListVersions ([ListVersionsRequest](#yandex.cloud.lockbox.v1.ListVersionsRequest)) returns ([ListVersionsResponse](#yandex.cloud.lockbox.v1.ListVersionsResponse))**

## ListVersionsRequest {#yandex.cloud.lockbox.v1.ListVersionsRequest}

```json
{
  "secret_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| secret_id | **string**

Required field. ID of the secret to list versions for. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListVersionsRequest.next_page_token]
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListVersionsRequest.next_page_token] returned by a previous list request. ||
|#

## ListVersionsResponse {#yandex.cloud.lockbox.v1.ListVersionsResponse}

```json
{
  "versions": [
    {
      "id": "string",
      "secret_id": "string",
      "created_at": "google.protobuf.Timestamp",
      "destroy_at": "google.protobuf.Timestamp",
      "description": "string",
      "status": "Status",
      "payload_entry_keys": [
        "string"
      ],
      // Includes only one of the fields `password_payload_specification`
      "password_payload_specification": {
        "password_key": "string",
        "length": "int64",
        "include_uppercase": "google.protobuf.BoolValue",
        "include_lowercase": "google.protobuf.BoolValue",
        "include_digits": "google.protobuf.BoolValue",
        "include_punctuation": "google.protobuf.BoolValue",
        "included_punctuation": "string",
        "excluded_punctuation": "string"
      }
      // end of the list of possible fields
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| versions[] | **[Version](#yandex.cloud.lockbox.v1.Version)**

List of versions for the specified secret. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number
of results is greater than the specified [ListVersionsRequest.page_size](#yandex.cloud.lockbox.v1.ListVersionsRequest), use
the `next_page_token` as the value for the [ListVersionsRequest.page_token](#yandex.cloud.lockbox.v1.ListVersionsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## Version {#yandex.cloud.lockbox.v1.Version}

#|
||Field | Description ||
|| id | **string**

ID of the version. ||
|| secret_id | **string**

ID of the secret that the version belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the version was created. ||
|| destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the version is going to be destroyed. Empty unless the status
is `SCHEDULED_FOR_DESTRUCTION`. ||
|| description | **string**

Description of the version. ||
|| status | enum **Status**

Status of the secret.

- `STATUS_UNSPECIFIED`
- `ACTIVE`: The version is active and the secret payload can be accessed.
- `SCHEDULED_FOR_DESTRUCTION`: The version is scheduled for destruction, the time when it will be destroyed
is specified in the `Version.destroy_at` field.
- `DESTROYED`: The version is destroyed and cannot be recovered. ||
|| payload_entry_keys[] | **string**

Keys of the entries contained in the version payload. ||
|| password_payload_specification | **[PasswordPayloadSpecification](#yandex.cloud.lockbox.v1.PasswordPayloadSpecification)**

Includes only one of the fields `password_payload_specification`. ||
|#

## PasswordPayloadSpecification {#yandex.cloud.lockbox.v1.PasswordPayloadSpecification}

#|
||Field | Description ||
|| password_key | **string**

Required field. key of the entry to store generated password value ||
|| length | **int64**

password length; by default, a reasonable length will be decided ||
|| include_uppercase | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

whether at least one A..Z character is included in the password, true by default ||
|| include_lowercase | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

whether at least one a..z character is included in the password, true by default ||
|| include_digits | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

whether at least one 0..9 character is included in the password, true by default ||
|| include_punctuation | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

whether at least one punctuation character is included in the password, true by default
punctuation characters by default (there are 32): !"#$%&'()*+,-./:;<=>?@[\]^_`{\|}~
to customize the punctuation characters, see included_punctuation and excluded_punctuation below ||
|| included_punctuation | **string**

If include_punctuation is true, one of these two fields (not both) may be used optionally to customize the punctuation:
a string of specific punctuation characters to use (at most, all the 32) ||
|| excluded_punctuation | **string**

a string of punctuation characters to exclude from the default (at most 31, it's not allowed to exclude all the 32) ||
|#