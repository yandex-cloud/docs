---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/idp/api-ref/grpc/Userpool/update.md
---

# Identity Provider API, gRPC: UserpoolService.Update

Updates the specified userpool.

## gRPC request

**rpc Update ([UpdateUserpoolRequest](#yandex.cloud.organizationmanager.v1.idp.UpdateUserpoolRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateUserpoolRequest {#yandex.cloud.organizationmanager.v1.idp.UpdateUserpoolRequest}

```json
{
  "userpool_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
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
```

Request to update a userpool.

#|
||Field | Description ||
|| userpool_id | **string**

Required field. ID of the userpool to update.
To get the userpool ID, make a [UserpoolService.List](/docs/organization/idp/api-ref/grpc/Userpool/list#List) request. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the userpool are going to be updated. ||
|| name | **string**

Name of the userpool.
The name must be unique within the organization. ||
|| description | **string**

Description of the userpool. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as key:value pairs. ||
|| user_settings | **[UserSettings](#yandex.cloud.organizationmanager.v1.idp.UserSettings)**

User settings for the userpool. ||
|| password_quality_policy | **[PasswordQualityPolicy](#yandex.cloud.organizationmanager.v1.idp.PasswordQualityPolicy)**

Password quality policy for the userpool. ||
|| password_lifetime_policy | **[PasswordLifetimePolicy](#yandex.cloud.organizationmanager.v1.idp.PasswordLifetimePolicy)**

Password lifetime policy for the userpool. ||
|| bruteforce_protection_policy | **[BruteforceProtectionPolicy](#yandex.cloud.organizationmanager.v1.idp.BruteforceProtectionPolicy)**

Bruteforce protection policy for the userpool. ||
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

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "userpool_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
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
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateUserpoolMetadata](#yandex.cloud.organizationmanager.v1.idp.UpdateUserpoolMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[Userpool](#yandex.cloud.organizationmanager.v1.idp.Userpool)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## UpdateUserpoolMetadata {#yandex.cloud.organizationmanager.v1.idp.UpdateUserpoolMetadata}

Metadata for the [UserpoolService.Update](#Update) operation.

#|
||Field | Description ||
|| userpool_id | **string**

ID of the userpool that is being updated. ||
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
|| user_settings | **[UserSettings](#yandex.cloud.organizationmanager.v1.idp.UserSettings2)**

User settings for this userpool. ||
|| password_quality_policy | **[PasswordQualityPolicy](#yandex.cloud.organizationmanager.v1.idp.PasswordQualityPolicy2)**

Password quality policy for this userpool. ||
|| password_lifetime_policy | **[PasswordLifetimePolicy](#yandex.cloud.organizationmanager.v1.idp.PasswordLifetimePolicy2)**

Password lifetime policy for this userpool. ||
|| bruteforce_protection_policy | **[BruteforceProtectionPolicy](#yandex.cloud.organizationmanager.v1.idp.BruteforceProtectionPolicy2)**

Bruteforce protection policy for this userpool. ||
|#

## UserSettings {#yandex.cloud.organizationmanager.v1.idp.UserSettings2}

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

## PasswordQualityPolicy {#yandex.cloud.organizationmanager.v1.idp.PasswordQualityPolicy2}

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
|| required_classes | **[RequiredClasses](#yandex.cloud.organizationmanager.v1.idp.PasswordQualityPolicy.RequiredClasses2)**

Character classes required in passwords. ||
|| min_length_by_class_settings | **[MinLengthByClassSettings](#yandex.cloud.organizationmanager.v1.idp.PasswordQualityPolicy.MinLengthByClassSettings2)**

Minimum length requirements based on character class diversity.
If not specified, these checks are disabled. ||
|#

## RequiredClasses {#yandex.cloud.organizationmanager.v1.idp.PasswordQualityPolicy.RequiredClasses2}

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

## MinLengthByClassSettings {#yandex.cloud.organizationmanager.v1.idp.PasswordQualityPolicy.MinLengthByClassSettings2}

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

## PasswordLifetimePolicy {#yandex.cloud.organizationmanager.v1.idp.PasswordLifetimePolicy2}

Policy that defines password lifetime requirements.

#|
||Field | Description ||
|| min_days_count | **int64**

Minimum number of days before a password can be changed. ||
|| max_days_count | **int64**

Maximum number of days a password remains valid.
Zero means passwords never expire. ||
|#

## BruteforceProtectionPolicy {#yandex.cloud.organizationmanager.v1.idp.BruteforceProtectionPolicy2}

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