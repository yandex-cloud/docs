---
editable: false
apiPlayground:
  - url: https://container-registry.{{ api-host }}/container-registry/v1/scanPolicies/{registryId}:byRegistry
    method: get
    path:
      type: object
      properties:
        registryId:
          description: |-
            **string**
            Required field. ID of the registry with scan policy.
          type: string
      required:
        - registryId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/containerregistry/v1/api-ref/ScanPolicy/getByRegistry.md
---

# Container Registry API, REST: ScanPolicy.GetByRegistry

Returns scan policy for the registry if any exists.

## HTTP request

```
GET https://container-registry.{{ api-host }}/container-registry/v1/scanPolicies/{registryId}:byRegistry
```

## Path parameters

#|
||Field | Description ||
|| registryId | **string**

Required field. ID of the registry with scan policy. ||
|#

## Response {#yandex.cloud.containerregistry.v1.ScanPolicy}

**HTTP Code: 200 - OK**

```json
{
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
```

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
|| rules | **[ScanRules](#yandex.cloud.containerregistry.v1.ScanRules)**

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