---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/idp/userpools
    method: get
    path: null
    query:
      type: object
      properties:
        organizationId:
          description: |-
            **string**
            Required field. ID of the organization to list userpools in.
            The maximum string length in characters is 50.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return.
            If the number of available results is larger than `pageSize`,
            the service returns a [ListUserpoolsResponse.nextPageToken](#yandex.cloud.organizationmanager.v1.idp.ListUserpoolsResponse)
            that can be used to get the next page of results in subsequent list requests.
            Default value: 100.
            Acceptable values are 0 to 1000, inclusive.
          default: '100'
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `pageToken`
            to the [ListUserpoolsResponse.nextPageToken](#yandex.cloud.organizationmanager.v1.idp.ListUserpoolsResponse)
            returned by a previous list request.
            The maximum string length in characters is 2000.
          type: string
        filter:
          description: |-
            **string**
            A filter expression that filters resources listed in the response.
            The maximum string length in characters is 1000.
          type: string
      required:
        - organizationId
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/organizationmanager/v1/idp/api-ref/Userpool/list.md
---

# Identity Provider API, REST: Userpool.List

Retrieves the list of userpools in the specified organization.

## HTTP request

```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/idp/userpools
```

## Query parameters {#yandex.cloud.organizationmanager.v1.idp.ListUserpoolsRequest}

Request to list userpools.

#|
||Field | Description ||
|| organizationId | **string**

Required field. ID of the organization to list userpools in.

The maximum string length in characters is 50. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return.
If the number of available results is larger than `pageSize`,
the service returns a [ListUserpoolsResponse.nextPageToken](#yandex.cloud.organizationmanager.v1.idp.ListUserpoolsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100.

Acceptable values are 0 to 1000, inclusive. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken`
to the [ListUserpoolsResponse.nextPageToken](#yandex.cloud.organizationmanager.v1.idp.ListUserpoolsResponse)
returned by a previous list request.

The maximum string length in characters is 2000. ||
|| filter | **string**

A filter expression that filters resources listed in the response.

The maximum string length in characters is 1000. ||
|#

## Response {#yandex.cloud.organizationmanager.v1.idp.ListUserpoolsResponse}

**HTTP Code: 200 - OK**

```json
{
  "userpools": [
    {
      "id": "string",
      "organizationId": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "createdAt": "string",
      "updatedAt": "string",
      "domains": [
        "string"
      ],
      "status": "string",
      "userSettings": {
        "allowEditSelfPassword": "boolean",
        "allowEditSelfInfo": "boolean",
        "allowEditSelfContacts": "boolean",
        "allowEditSelfLogin": "boolean"
      },
      "passwordQualityPolicy": {
        "allowSimilar": "boolean",
        "maxLength": "string",
        "minLength": "string",
        "matchLength": "string",
        "requiredClasses": {
          "lowers": "boolean",
          "uppers": "boolean",
          "digits": "boolean",
          "specials": "boolean"
        },
        "minLengthByClassSettings": {
          "one": "string",
          "two": "string",
          "three": "string"
        },
        // Includes only one of the fields `fixed`, `smart`
        "fixed": {
          "lowersRequired": "boolean",
          "uppersRequired": "boolean",
          "digitsRequired": "boolean",
          "specialsRequired": "boolean",
          "minLength": "string"
        },
        "smart": {
          "oneClass": "string",
          "twoClasses": "string",
          "threeClasses": "string",
          "fourClasses": "string"
        }
        // end of the list of possible fields
      },
      "passwordLifetimePolicy": {
        "minDaysCount": "string",
        "maxDaysCount": "string"
      },
      "bruteforceProtectionPolicy": {
        "window": "string",
        "block": "string",
        "attempts": "string"
      }
    }
  ],
  "nextPageToken": "string"
}
```

Response message for [UserpoolService.List](#List).

#|
||Field | Description ||
|| userpools[] | **[Userpool](#yandex.cloud.organizationmanager.v1.idp.Userpool)**

List of userpools. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests.
If the number of results is larger than [ListUserpoolsRequest.pageSize](#yandex.cloud.organizationmanager.v1.idp.ListUserpoolsRequest),
use the `nextPageToken` as the value for the [ListUserpoolsRequest.pageToken](#yandex.cloud.organizationmanager.v1.idp.ListUserpoolsRequest)
query parameter in the next list request. ||
|#

## Userpool {#yandex.cloud.organizationmanager.v1.idp.Userpool}

A userpool is a container for users in the Identity Provider system.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the userpool. ||
|| organizationId | **string**

ID of the organization this userpool belongs to. ||
|| name | **string**

Name of the userpool. ||
|| description | **string**

Description of the userpool. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as key:value pairs. ||
|| createdAt | **string** (date-time)

Timestamp when the userpool was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Timestamp when the userpool was last updated.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| domains[] | **string**

List of domains associated with this userpool. ||
|| status | **enum** (Status)

Current status of the userpool.

- `CREATING`: The userpool is in the process of being created.
- `ACTIVE`: The userpool is active and operational.
- `DELETING`: The userpool is in the process of being deleted. ||
|| userSettings | **[UserSettings](#yandex.cloud.organizationmanager.v1.idp.UserSettings)**

User settings for this userpool. ||
|| passwordQualityPolicy | **[PasswordQualityPolicy](#yandex.cloud.organizationmanager.v1.idp.PasswordQualityPolicy)**

Password quality policy for this userpool. ||
|| passwordLifetimePolicy | **[PasswordLifetimePolicy](#yandex.cloud.organizationmanager.v1.idp.PasswordLifetimePolicy)**

Password lifetime policy for this userpool. ||
|| bruteforceProtectionPolicy | **[BruteforceProtectionPolicy](#yandex.cloud.organizationmanager.v1.idp.BruteforceProtectionPolicy)**

Bruteforce protection policy for this userpool. ||
|#

## UserSettings {#yandex.cloud.organizationmanager.v1.idp.UserSettings}

Settings that control user capabilities within a userpool.

#|
||Field | Description ||
|| allowEditSelfPassword | **boolean**

Whether users can change their own passwords. ||
|| allowEditSelfInfo | **boolean**

Whether users can edit their own profile information. ||
|| allowEditSelfContacts | **boolean**

Whether users can edit their own contact information. ||
|| allowEditSelfLogin | **boolean**

Whether users can edit their own login information. ||
|#

## PasswordQualityPolicy {#yandex.cloud.organizationmanager.v1.idp.PasswordQualityPolicy}

Policy that defines password quality requirements.

#|
||Field | Description ||
|| allowSimilar | **boolean**

Whether passwords similar to previous ones are allowed. ||
|| maxLength | **string** (int64)

Maximum password length. Zero means no maximum length is enforced.

The minimum value is 0. ||
|| minLength | **string** (int64)

Minimum password length.

The minimum value is 0. ||
|| matchLength | **string** (int64)

Minimum length of substrings to check for similarity to vulnerable sequences.

The minimum value is 0. ||
|| requiredClasses | **[RequiredClasses](#yandex.cloud.organizationmanager.v1.idp.PasswordQualityPolicy.RequiredClasses)**

Character classes required in passwords. ||
|| minLengthByClassSettings | **[MinLengthByClassSettings](#yandex.cloud.organizationmanager.v1.idp.PasswordQualityPolicy.MinLengthByClassSettings)**

Minimum length requirements based on character class diversity.
If not specified, these checks are disabled. ||
|| fixed | **[Fixed](#yandex.cloud.organizationmanager.v1.idp.PasswordQualityPolicy.Fixed)**

Fixed complexity requirements. Exactly one of complexity requirements must be specified.

Includes only one of the fields `fixed`, `smart`.

Defines password complexity policy. ||
|| smart | **[Smart](#yandex.cloud.organizationmanager.v1.idp.PasswordQualityPolicy.Smart)**

Smart complexity requirements. Exactly one of complexity requirements must be specified.

Includes only one of the fields `fixed`, `smart`.

Defines password complexity policy. ||
|#

## RequiredClasses {#yandex.cloud.organizationmanager.v1.idp.PasswordQualityPolicy.RequiredClasses}

Character classes that can be required in passwords.

#|
||Field | Description ||
|| lowers | **boolean**

Whether lowercase letters are required. ||
|| uppers | **boolean**

Whether uppercase letters are required. ||
|| digits | **boolean**

Whether digits are required. ||
|| specials | **boolean**

Whether special characters are required. ||
|#

## MinLengthByClassSettings {#yandex.cloud.organizationmanager.v1.idp.PasswordQualityPolicy.MinLengthByClassSettings}

Minimum password length requirements based on character class diversity.

#|
||Field | Description ||
|| one | **string** (int64)

Minimum length for passwords with one character class.

The minimum value is 0. ||
|| two | **string** (int64)

Minimum length for passwords with two character classes.

The minimum value is 0. ||
|| three | **string** (int64)

Minimum length for passwords with three character classes.

The minimum value is 0. ||
|#

## Fixed {#yandex.cloud.organizationmanager.v1.idp.PasswordQualityPolicy.Fixed}

Fixed complexity policy enforces uniform password rules with required character classes and minimum length.

#|
||Field | Description ||
|| lowersRequired | **boolean**

Whether lowercase letters are required in the password. ||
|| uppersRequired | **boolean**

Whether uppercase letters are required in the password. ||
|| digitsRequired | **boolean**

Whether digits are required in the password. ||
|| specialsRequired | **boolean**

Whether special characters are required in the password. ||
|| minLength | **string** (int64)

Minimum length required for all passwords.

The minimum value is 0. ||
|#

## Smart {#yandex.cloud.organizationmanager.v1.idp.PasswordQualityPolicy.Smart}

Smart complexity policy applies adaptive requirements based on character class diversity.
Zero value means passwords with this number of classes are forbidden.

#|
||Field | Description ||
|| oneClass | **string** (int64)

For passwords with one class of characters

The minimum value is 0. ||
|| twoClasses | **string** (int64)

For passwords with two classes of characters

The minimum value is 0. ||
|| threeClasses | **string** (int64)

For passwords with three classes of characters

The minimum value is 0. ||
|| fourClasses | **string** (int64)

For passwords with all four classes of characters

The minimum value is 0. ||
|#

## PasswordLifetimePolicy {#yandex.cloud.organizationmanager.v1.idp.PasswordLifetimePolicy}

Policy that defines password lifetime requirements.

#|
||Field | Description ||
|| minDaysCount | **string** (int64)

Minimum number of days before a password can be changed.

The minimum value is 0. ||
|| maxDaysCount | **string** (int64)

Maximum number of days a password remains valid.
Zero means passwords never expire.

The minimum value is 0. ||
|#

## BruteforceProtectionPolicy {#yandex.cloud.organizationmanager.v1.idp.BruteforceProtectionPolicy}

Policy that defines protection against brute force attacks.
Zero or empty values disable bruteforce protection.

#|
||Field | Description ||
|| window | **string** (duration)

Time window for counting failed authentication attempts. ||
|| block | **string** (duration)

Duration of the block after too many failed attempts. ||
|| attempts | **string** (int64)

Number of failed attempts allowed within the window before blocking.

Value must be greater than 0. ||
|#