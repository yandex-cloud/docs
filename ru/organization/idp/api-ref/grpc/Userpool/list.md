---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/idp/api-ref/grpc/Userpool/list.md
---

# Identity Provider API, gRPC: UserpoolService.List

Retrieves the list of userpools in the specified organization.

## gRPC request

**rpc List ([ListUserpoolsRequest](#yandex.cloud.organizationmanager.v1.idp.ListUserpoolsRequest)) returns ([ListUserpoolsResponse](#yandex.cloud.organizationmanager.v1.idp.ListUserpoolsResponse))**

## ListUserpoolsRequest {#yandex.cloud.organizationmanager.v1.idp.ListUserpoolsRequest}

```json
{
  "organization_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

Request to list userpools.

#|
||Field | Description ||
|| organization_id | **string**

Required field. ID of the organization to list userpools in. ||
|| page_size | **int64**

The maximum number of results per page to return.
If the number of available results is larger than `page_size`,
the service returns a [ListUserpoolsResponse.next_page_token](#yandex.cloud.organizationmanager.v1.idp.ListUserpoolsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token`
to the [ListUserpoolsResponse.next_page_token](#yandex.cloud.organizationmanager.v1.idp.ListUserpoolsResponse)
returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response. ||
|#

## ListUserpoolsResponse {#yandex.cloud.organizationmanager.v1.idp.ListUserpoolsResponse}

```json
{
  "userpools": [
    {
      "id": "string",
      "organization_id": "string",
      "name": "string",
      "description": "string",
      "labels": "map<string, string>",
      "created_at": "google.protobuf.Timestamp",
      "updated_at": "google.protobuf.Timestamp",
      "domains": [
        "string"
      ],
      "status": "Status",
      "user_settings": {
        "allow_edit_self_password": "bool",
        "allow_edit_self_info": "bool",
        "allow_edit_self_contacts": "bool",
        "allow_edit_self_login": "bool"
      },
      "password_quality_policy": {
        "allow_similar": "bool",
        "max_length": "int64",
        "min_length": "int64",
        "match_length": "int64",
        "required_classes": {
          "lowers": "bool",
          "uppers": "bool",
          "digits": "bool",
          "specials": "bool"
        },
        "min_length_by_class_settings": {
          "one": "int64",
          "two": "int64",
          "three": "int64"
        }
      },
      "password_lifetime_policy": {
        "min_days_count": "int64",
        "max_days_count": "int64"
      },
      "bruteforce_protection_policy": {
        "window": "google.protobuf.Duration",
        "block": "google.protobuf.Duration",
        "attempts": "int64"
      }
    }
  ],
  "next_page_token": "string"
}
```

Response message for [UserpoolService.List](#List).

#|
||Field | Description ||
|| userpools[] | **[Userpool](#yandex.cloud.organizationmanager.v1.idp.Userpool)**

List of userpools. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests.
If the number of results is larger than [ListUserpoolsRequest.page_size](#yandex.cloud.organizationmanager.v1.idp.ListUserpoolsRequest),
use the `next_page_token` as the value for the [ListUserpoolsRequest.page_token](#yandex.cloud.organizationmanager.v1.idp.ListUserpoolsRequest)
query parameter in the next list request. ||
|#

## Userpool {#yandex.cloud.organizationmanager.v1.idp.Userpool}

A userpool is a container for users in the Identity Provider system.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the userpool. ||
|| organization_id | **string**

ID of the organization this userpool belongs to. ||
|| name | **string**

Name of the userpool. ||
|| description | **string**

Description of the userpool. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as key:value pairs. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the userpool was created. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the userpool was last updated. ||
|| domains[] | **string**

List of domains associated with this userpool. ||
|| status | enum **Status**

Current status of the userpool.

- `STATUS_UNSPECIFIED`: The status is not specified.
- `CREATING`: The userpool is in the process of being created.
- `ACTIVE`: The userpool is active and operational.
- `DELETING`: The userpool is in the process of being deleted. ||
|| user_settings | **[UserSettings](#yandex.cloud.organizationmanager.v1.idp.UserSettings)**

User settings for this userpool. ||
|| password_quality_policy | **[PasswordQualityPolicy](#yandex.cloud.organizationmanager.v1.idp.PasswordQualityPolicy)**

Password quality policy for this userpool. ||
|| password_lifetime_policy | **[PasswordLifetimePolicy](#yandex.cloud.organizationmanager.v1.idp.PasswordLifetimePolicy)**

Password lifetime policy for this userpool. ||
|| bruteforce_protection_policy | **[BruteforceProtectionPolicy](#yandex.cloud.organizationmanager.v1.idp.BruteforceProtectionPolicy)**

Bruteforce protection policy for this userpool. ||
|#

## UserSettings {#yandex.cloud.organizationmanager.v1.idp.UserSettings}

Settings that control user capabilities within a userpool.

#|
||Field | Description ||
|| allow_edit_self_password | **bool**

Whether users can change their own passwords. ||
|| allow_edit_self_info | **bool**

Whether users can edit their own profile information. ||
|| allow_edit_self_contacts | **bool**

Whether users can edit their own contact information. ||
|| allow_edit_self_login | **bool**

Whether users can edit their own login information. ||
|#

## PasswordQualityPolicy {#yandex.cloud.organizationmanager.v1.idp.PasswordQualityPolicy}

Policy that defines password quality requirements.

#|
||Field | Description ||
|| allow_similar | **bool**

Whether passwords similar to previous ones are allowed. ||
|| max_length | **int64**

Maximum password length. Zero means no maximum length is enforced. ||
|| min_length | **int64**

Minimum password length. ||
|| match_length | **int64**

Minimum length of substrings to check for similarity to vulnerable sequences. ||
|| required_classes | **[RequiredClasses](#yandex.cloud.organizationmanager.v1.idp.PasswordQualityPolicy.RequiredClasses)**

Character classes required in passwords. ||
|| min_length_by_class_settings | **[MinLengthByClassSettings](#yandex.cloud.organizationmanager.v1.idp.PasswordQualityPolicy.MinLengthByClassSettings)**

Minimum length requirements based on character class diversity.
If not specified, these checks are disabled. ||
|#

## RequiredClasses {#yandex.cloud.organizationmanager.v1.idp.PasswordQualityPolicy.RequiredClasses}

Character classes that can be required in passwords.

#|
||Field | Description ||
|| lowers | **bool**

Whether lowercase letters are required. ||
|| uppers | **bool**

Whether uppercase letters are required. ||
|| digits | **bool**

Whether digits are required. ||
|| specials | **bool**

Whether special characters are required. ||
|#

## MinLengthByClassSettings {#yandex.cloud.organizationmanager.v1.idp.PasswordQualityPolicy.MinLengthByClassSettings}

Minimum password length requirements based on character class diversity.

#|
||Field | Description ||
|| one | **int64**

Minimum length for passwords with one character class. ||
|| two | **int64**

Minimum length for passwords with two character classes. ||
|| three | **int64**

Minimum length for passwords with three character classes. ||
|#

## PasswordLifetimePolicy {#yandex.cloud.organizationmanager.v1.idp.PasswordLifetimePolicy}

Policy that defines password lifetime requirements.

#|
||Field | Description ||
|| min_days_count | **int64**

Minimum number of days before a password can be changed. ||
|| max_days_count | **int64**

Maximum number of days a password remains valid.
Zero means passwords never expire. ||
|#

## BruteforceProtectionPolicy {#yandex.cloud.organizationmanager.v1.idp.BruteforceProtectionPolicy}

Policy that defines protection against brute force attacks.

#|
||Field | Description ||
|| window | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Time window for counting failed authentication attempts. ||
|| block | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Duration of the block after too many failed attempts. ||
|| attempts | **int64**

Number of failed attempts allowed within the window before blocking. ||
|#