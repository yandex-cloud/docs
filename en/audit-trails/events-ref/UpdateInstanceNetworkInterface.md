---
editable: false
sourcePath: en/_events-ref/audit/compute/events-ref/UpdateInstanceNetworkInterface.md
---

# Compute Audit Trails Events: UpdateInstanceNetworkInterface

## Event JSON schema {#yandex.cloud.audit.compute.UpdateInstanceNetworkInterface2-schema}

```json
{
  "eventId": "string",
  "eventSource": "string",
  "eventType": "string",
  "eventTime": "string",
  "authentication": {
    "authenticated": "boolean",
    "subjectType": "string",
    "subjectId": "string",
    "subjectName": "string",
    "federationId": "string",
    "federationName": "string",
    "federationType": "string",
    "tokenInfo": {
      "maskedIamToken": "string",
      "iamTokenId": "string",
      "impersonatorId": "string",
      "impersonatorType": "string",
      "impersonatorName": "string",
      "impersonatorFederationId": "string",
      "impersonatorFederationName": "string",
      "impersonatorFederationType": "string"
    }
  },
  "authorization": {
    "authorized": "boolean"
  },
  "resourceMetadata": {
    "path": [
      {
        "resourceType": "string",
        "resourceId": "string",
        "resourceName": "string"
      }
    ]
  },
  "requestMetadata": {
    "remoteAddress": "string",
    "userAgent": "string",
    "requestId": "string",
    "remotePort": "string"
  },
  "eventStatus": "string",
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "details": {
    "securityGroups": [
      {
        "securityGroupId": "string",
        "securityGroupName": "string"
      }
    ],
    "instanceId": "string",
    "instanceName": "string",
    "networkInterfaceIndex": "string",
    "updateMask": "string",
    "subnetId": "string",
    "primaryV4AddressSpec": {
      "address": "string",
      "oneToOneNatSpec": {
        "ipVersion": "string",
        "address": "string",
        "dnsRecordSpecs": [
          {
            "fqdn": "string",
            "dnsZoneId": "string",
            "ttl": "string",
            "ptr": "boolean"
          }
        ]
      },
      "dnsRecordSpecs": [
        {
          "fqdn": "string",
          "dnsZoneId": "string",
          "ttl": "string",
          "ptr": "boolean"
        }
      ]
    },
    "primaryV6AddressSpec": {
      "address": "string",
      "oneToOneNatSpec": {
        "ipVersion": "string",
        "address": "string",
        "dnsRecordSpecs": [
          {
            "fqdn": "string",
            "dnsZoneId": "string",
            "ttl": "string",
            "ptr": "boolean"
          }
        ]
      },
      "dnsRecordSpecs": [
        {
          "fqdn": "string",
          "dnsZoneId": "string",
          "ttl": "string",
          "ptr": "boolean"
        }
      ]
    },
    "securityGroupIds": [
      "string"
    ],
    "networkInterfaces": [
      {
        "index": "string",
        "macAddress": "string",
        "subnetId": "string",
        "primaryV4Address": {
          "address": "string",
          "oneToOneNat": {
            "address": "string",
            "ipVersion": "string",
            "dnsRecords": [
              {
                "fqdn": "string",
                "dnsZoneId": "string",
                "ttl": "string",
                "ptr": "boolean"
              }
            ]
          },
          "dnsRecords": [
            {
              "fqdn": "string",
              "dnsZoneId": "string",
              "ttl": "string",
              "ptr": "boolean"
            }
          ]
        },
        "primaryV6Address": {
          "address": "string",
          "oneToOneNat": {
            "address": "string",
            "ipVersion": "string",
            "dnsRecords": [
              {
                "fqdn": "string",
                "dnsZoneId": "string",
                "ttl": "string",
                "ptr": "boolean"
              }
            ]
          },
          "dnsRecords": [
            {
              "fqdn": "string",
              "dnsZoneId": "string",
              "ttl": "string",
              "ptr": "boolean"
            }
          ]
        },
        "securityGroupIds": [
          "string"
        ]
      }
    ]
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.compute.UpdateInstanceNetworkInterface2}

#|
||Field | Description ||
|| eventId | **string** ||
|| eventSource | **string** ||
|| eventType | **string** ||
|| eventTime | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| authentication | **[IamAuthentication](#yandex.cloud.audit.IamAuthentication)** ||
|| authorization | **[Authorization](#yandex.cloud.audit.Authorization)** ||
|| resourceMetadata | **[ResourceMetadata](#yandex.cloud.audit.ResourceMetadata)** ||
|| requestMetadata | **[RequestMetadata](#yandex.cloud.audit.RequestMetadata)** ||
|| eventStatus | **enum** (EventStatus)

- `STARTED`
- `ERROR`
- `DONE`
- `CANCELLED`
- `RUNNING` ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation. ||
|| details | **[EventDetails](#yandex.cloud.audit.compute.UpdateInstanceNetworkInterface.EventDetails)** ||
|| requestParameters | **object** ||
|| response | **object** ||
|#

## IamAuthentication {#yandex.cloud.audit.IamAuthentication}

#|
||Field | Description ||
|| authenticated | **boolean** ||
|| subjectType | **enum** (IamSubjectType)

- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `SSH_USER`
- `KUBERNETES_USER` ||
|| subjectId | **string** ||
|| subjectName | **string** ||
|| federationId | **string** ||
|| federationName | **string** ||
|| federationType | **enum** (FederationType)

- `GLOBAL_FEDERATION`
- `PRIVATE_FEDERATION` ||
|| tokenInfo | **[IamTokenInfo](#yandex.cloud.audit.IamAuthentication.IamTokenInfo)** ||
|#

## IamTokenInfo {#yandex.cloud.audit.IamAuthentication.IamTokenInfo}

#|
||Field | Description ||
|| maskedIamToken | **string** ||
|| iamTokenId | **string** ||
|| impersonatorId | **string** ||
|| impersonatorType | **enum** (IamSubjectType)

- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `SSH_USER`
- `KUBERNETES_USER` ||
|| impersonatorName | **string** ||
|| impersonatorFederationId | **string** ||
|| impersonatorFederationName | **string** ||
|| impersonatorFederationType | **enum** (FederationType)

- `GLOBAL_FEDERATION`
- `PRIVATE_FEDERATION` ||
|#

## Authorization {#yandex.cloud.audit.Authorization}

#|
||Field | Description ||
|| authorized | **boolean** ||
|#

## ResourceMetadata {#yandex.cloud.audit.ResourceMetadata}

#|
||Field | Description ||
|| path[] | **[Resource](#yandex.cloud.audit.Resource)** ||
|#

## Resource {#yandex.cloud.audit.Resource}

#|
||Field | Description ||
|| resourceType | **string** ||
|| resourceId | **string** ||
|| resourceName | **string** ||
|#

## RequestMetadata {#yandex.cloud.audit.RequestMetadata}

#|
||Field | Description ||
|| remoteAddress | **string** ||
|| userAgent | **string** ||
|| requestId | **string** ||
|| remotePort | **string** (int64) ||
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

## EventDetails {#yandex.cloud.audit.compute.UpdateInstanceNetworkInterface.EventDetails}

#|
||Field | Description ||
|| securityGroups[] | **[SecurityGroupInfo](#yandex.cloud.audit.SecurityGroupInfo)** ||
|| instanceId | **string** ||
|| instanceName | **string** ||
|| networkInterfaceIndex | **string** ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| subnetId | **string** ||
|| primaryV4AddressSpec | **[PrimaryAddressSpec](#yandex.cloud.compute.v1.PrimaryAddressSpec)** ||
|| primaryV6AddressSpec | **[PrimaryAddressSpec](#yandex.cloud.compute.v1.PrimaryAddressSpec)** ||
|| securityGroupIds[] | **string** ||
|| networkInterfaces[] | **[NetworkInterface](#yandex.cloud.compute.v1.NetworkInterface)** ||
|#

## SecurityGroupInfo {#yandex.cloud.audit.SecurityGroupInfo}

#|
||Field | Description ||
|| securityGroupId | **string** ||
|| securityGroupName | **string** ||
|#

## PrimaryAddressSpec {#yandex.cloud.compute.v1.PrimaryAddressSpec}

#|
||Field | Description ||
|| address | **string** ||
|| oneToOneNatSpec | **[OneToOneNatSpec](#yandex.cloud.compute.v1.OneToOneNatSpec)** ||
|| dnsRecordSpecs[] | **[DnsRecordSpec](#yandex.cloud.compute.v1.DnsRecordSpec)** ||
|#

## OneToOneNatSpec {#yandex.cloud.compute.v1.OneToOneNatSpec}

#|
||Field | Description ||
|| ipVersion | **enum** (IpVersion)

- `IPV4`
- `IPV6` ||
|| address | **string** ||
|| dnsRecordSpecs[] | **[DnsRecordSpec](#yandex.cloud.compute.v1.DnsRecordSpec)** ||
|#

## DnsRecordSpec {#yandex.cloud.compute.v1.DnsRecordSpec}

#|
||Field | Description ||
|| fqdn | **string** ||
|| dnsZoneId | **string** ||
|| ttl | **string** (int64)

Acceptable values are 0 to 86400, inclusive. ||
|| ptr | **boolean** ||
|#

## NetworkInterface {#yandex.cloud.compute.v1.NetworkInterface}

#|
||Field | Description ||
|| index | **string** ||
|| macAddress | **string** ||
|| subnetId | **string** ||
|| primaryV4Address | **[PrimaryAddress](#yandex.cloud.compute.v1.PrimaryAddress)** ||
|| primaryV6Address | **[PrimaryAddress](#yandex.cloud.compute.v1.PrimaryAddress)** ||
|| securityGroupIds[] | **string** ||
|#

## PrimaryAddress {#yandex.cloud.compute.v1.PrimaryAddress}

#|
||Field | Description ||
|| address | **string** ||
|| oneToOneNat | **[OneToOneNat](#yandex.cloud.compute.v1.OneToOneNat)** ||
|| dnsRecords[] | **[DnsRecord](#yandex.cloud.compute.v1.DnsRecord)** ||
|#

## OneToOneNat {#yandex.cloud.compute.v1.OneToOneNat}

#|
||Field | Description ||
|| address | **string** ||
|| ipVersion | **enum** (IpVersion)

- `IPV4`
- `IPV6` ||
|| dnsRecords[] | **[DnsRecord](#yandex.cloud.compute.v1.DnsRecord)** ||
|#

## DnsRecord {#yandex.cloud.compute.v1.DnsRecord}

#|
||Field | Description ||
|| fqdn | **string** ||
|| dnsZoneId | **string** ||
|| ttl | **string** (int64) ||
|| ptr | **boolean** ||
|#