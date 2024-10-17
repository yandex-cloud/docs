---
editable: false
sourcePath: en/_api-ref/containerregistry/v1/api-ref/ScanPolicy/create.md
---

# Container Registry API, REST: ScanPolicy.Create {#Create}

Creates a scan policy for the specified registry.

## HTTP request

```
POST https://container-registry.{{ api-host }}/container-registry/v1/scanPolicies
```

## Body parameters {#yandex.cloud.containerregistry.v1.CreateScanPolicyRequest}

```json
{
  "registryId": "string",
  "name": "string",
  "description": "string",
  "rules": {
    "pushRule": {
      "repositoryPrefixes": [
        "string"
      ],
      "disabled": "boolean"
    },
    "scheduleRules": [
      {
        "repositoryPrefixes": [
          "string"
        ],
        "rescanPeriod": "string",
        "disabled": "boolean"
      }
    ]
  }
}
```

#|
||Field | Description ||
|| registryId | **string**

Required field. ID of the scan policy registry. ||
|| name | **string**

Name of the scan policy. ||
|| description | **string**

Description of the scan policy. ||
|| rules | **[ScanRules](#yandex.cloud.containerregistry.v1.ScanRules)**

Rules of the scan policy. ||
|#

## ScanRules {#yandex.cloud.containerregistry.v1.ScanRules}

#|
||Field | Description ||
|| pushRule | **[PushRule](#yandex.cloud.containerregistry.v1.PushRule)**

Description of on-push scan rule. ||
|| scheduleRules[] | **[ScheduledRule](#yandex.cloud.containerregistry.v1.ScheduledRule)**

Description of time based rescan rule. ||
|#

## PushRule {#yandex.cloud.containerregistry.v1.PushRule}

#|
||Field | Description ||
|| repositoryPrefixes[] | **string**

List of repositories that are scanned with rule. Child repositories are included into parent node. "*" - means all repositories in registry ||
|| disabled | **boolean**

Turns off scan rule. ||
|#

## ScheduledRule {#yandex.cloud.containerregistry.v1.ScheduledRule}

#|
||Field | Description ||
|| repositoryPrefixes[] | **string**

List of repositories that are scanned with rule. Child repositories are included into parent node. "*" - means all repositories in registry ||
|| rescanPeriod | **string** (duration)

Required field. Period of time since last scan to trigger automatic rescan. ||
|| disabled | **boolean**

Turns off scan rule. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "scanPolicyId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "id": "string",
    "registryId": "string",
    "name": "string",
    "description": "string",
    "rules": {
      "pushRule": {
        "repositoryPrefixes": [
          "string"
        ],
        "disabled": "boolean"
      },
      "scheduleRules": [
        {
          "repositoryPrefixes": [
            "string"
          ],
          "rescanPeriod": "string",
          "disabled": "boolean"
        }
      ]
    },
    "createdAt": "string",
    "disabled": "boolean"
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateScanPolicyMetadata](#yandex.cloud.containerregistry.v1.CreateScanPolicyMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[ScanPolicy](#yandex.cloud.containerregistry.v1.ScanPolicy)**

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

## CreateScanPolicyMetadata {#yandex.cloud.containerregistry.v1.CreateScanPolicyMetadata}

#|
||Field | Description ||
|| scanPolicyId | **string**

ID of created scan policy resource. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## ScanPolicy {#yandex.cloud.containerregistry.v1.ScanPolicy}

#|
||Field | Description ||
|| id | **string**

Output only. ID of the scan policy. ||
|| registryId | **string**

ID of the registry that the scan policy belongs to.
Required. The maximum string length in characters is 50. ||
|| name | **string**

Name of the scan policy. ||
|| description | **string**

Description of the scan policy.
The maximum string length in characters is 256. ||
|| rules | **[ScanRules](#yandex.cloud.containerregistry.v1.ScanRules2)**

The rules of scan policy. ||
|| createdAt | **string** (date-time)

Output only. Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| disabled | **boolean**

Turns off scan policy. ||
|#

## ScanRules {#yandex.cloud.containerregistry.v1.ScanRules2}

#|
||Field | Description ||
|| pushRule | **[PushRule](#yandex.cloud.containerregistry.v1.PushRule2)**

Description of on-push scan rule. ||
|| scheduleRules[] | **[ScheduledRule](#yandex.cloud.containerregistry.v1.ScheduledRule2)**

Description of time based rescan rule. ||
|#

## PushRule {#yandex.cloud.containerregistry.v1.PushRule2}

#|
||Field | Description ||
|| repositoryPrefixes[] | **string**

List of repositories that are scanned with rule. Child repositories are included into parent node. "*" - means all repositories in registry ||
|| disabled | **boolean**

Turns off scan rule. ||
|#

## ScheduledRule {#yandex.cloud.containerregistry.v1.ScheduledRule2}

#|
||Field | Description ||
|| repositoryPrefixes[] | **string**

List of repositories that are scanned with rule. Child repositories are included into parent node. "*" - means all repositories in registry ||
|| rescanPeriod | **string** (duration)

Required field. Period of time since last scan to trigger automatic rescan. ||
|| disabled | **boolean**

Turns off scan rule. ||
|#