---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/idp/userpools/{userpoolId}
    method: get
    path:
      type: object
      properties:
        userpoolId:
          description: |-
            **string**
            Required field. ID of the userpool to return.
            To get the userpool ID, make a [UserpoolService.List](/docs/organization/idp/api-ref/Userpool/list#List) request.
          type: string
      required:
        - userpoolId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/organizationmanager/v1/idp/api-ref/Userpool/get.md
---

# Identity Provider API, REST: Userpool.Get

Returns the specified userpool.

To get the list of available userpools, make a [List](/docs/organization/idp/api-ref/Userpool/list#List) request.

## HTTP request

```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/idp/userpools/{userpoolId}
```

## Path parameters

Request to get a userpool.

#|
||Field | Description ||
|| userpoolId | **string**

Required field. ID of the userpool to return.
To get the userpool ID, make a [UserpoolService.List](/docs/organization/idp/api-ref/Userpool/list#List) request. ||
|#

## Response {#yandex.cloud.organizationmanager.v1.idp.Userpool}

**HTTP Code: 200 - OK**

```json
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
    }
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
```

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

- `STATUS_UNSPECIFIED`: The status is not specified.
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

Maximum password length. Zero means no maximum length is enforced. ||
|| minLength | **string** (int64)

Minimum password length. ||
|| matchLength | **string** (int64)

Minimum length of substrings to check for similarity to vulnerable sequences. ||
|| requiredClasses | **[RequiredClasses](#yandex.cloud.organizationmanager.v1.idp.PasswordQualityPolicy.RequiredClasses)**

Character classes required in passwords. ||
|| minLengthByClassSettings | **[MinLengthByClassSettings](#yandex.cloud.organizationmanager.v1.idp.PasswordQualityPolicy.MinLengthByClassSettings)**

Minimum length requirements based on character class diversity.
If not specified, these checks are disabled. ||
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

Minimum length for passwords with one character class. ||
|| two | **string** (int64)

Minimum length for passwords with two character classes. ||
|| three | **string** (int64)

Minimum length for passwords with three character classes. ||
|#

## PasswordLifetimePolicy {#yandex.cloud.organizationmanager.v1.idp.PasswordLifetimePolicy}

Policy that defines password lifetime requirements.

#|
||Field | Description ||
|| minDaysCount | **string** (int64)

Minimum number of days before a password can be changed. ||
|| maxDaysCount | **string** (int64)

Maximum number of days a password remains valid.
Zero means passwords never expire. ||
|#

## BruteforceProtectionPolicy {#yandex.cloud.organizationmanager.v1.idp.BruteforceProtectionPolicy}

Policy that defines protection against brute force attacks.

#|
||Field | Description ||
|| window | **string** (duration)

Time window for counting failed authentication attempts. ||
|| block | **string** (duration)

Duration of the block after too many failed attempts. ||
|| attempts | **string** (int64)

Number of failed attempts allowed within the window before blocking. ||
|#