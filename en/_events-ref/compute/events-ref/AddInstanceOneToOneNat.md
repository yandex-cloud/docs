---
editable: false
---

# Compute Audit Trails Events: AddInstanceOneToOneNat

## Event JSON schema {#yandex.cloud.audit.compute.AddInstanceOneToOneNat2-schema}

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
    "instanceId": "string",
    "instanceName": "string",
    "networkInterfaceIndex": "string",
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

## Field description {#yandex.cloud.audit.compute.AddInstanceOneToOneNat2}

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
|| authentication | **[Authentication](#yandex.cloud.audit.Authentication)** ||
|| authorization | **[Authorization](#yandex.cloud.audit.Authorization)** ||
|| resourceMetadata | **[ResourceMetadata](#yandex.cloud.audit.ResourceMetadata)** ||
|| requestMetadata | **[RequestMetadata](#yandex.cloud.audit.RequestMetadata)** ||
|| eventStatus | **enum** (EventStatus)

- `EVENT_STATUS_UNSPECIFIED`
- `STARTED`
- `ERROR`
- `DONE`
- `CANCELLED`
- `RUNNING` ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation. ||
|| details | **[EventDetails](#yandex.cloud.audit.compute.AddInstanceOneToOneNat.EventDetails)** ||
|| requestParameters | **object** ||
|| response | **object** ||
|#

## Authentication {#yandex.cloud.audit.Authentication}

#|
||Field | Description ||
|| authenticated | **boolean** ||
|| subjectType | **enum** (SubjectType)

- `SUBJECT_TYPE_UNSPECIFIED`
- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `GROUP`
- `SSH_USER`
- `DB_NATIVE_USER`
- `KUBERNETES_USER`
- `DATALENS_SYSTEM_USER`
- `INVITEE` ||
|| subjectId | **string** ||
|| subjectName | **string** ||
|| federationId | **string**

Federation block will be filled only when subject_type = FEDERATED_USER_ACCOUNT ||
|| federationName | **string** ||
|| federationType | **enum** (FederationType)

- `FEDERATION_TYPE_UNSPECIFIED`
- `GLOBAL_FEDERATION`
- `PRIVATE_FEDERATION` ||
|| tokenInfo | **[IamTokenInfo](#yandex.cloud.audit.Authentication.IamTokenInfo)** ||
|#

## IamTokenInfo {#yandex.cloud.audit.Authentication.IamTokenInfo}

#|
||Field | Description ||
|| maskedIamToken | **string** ||
|| iamTokenId | **string** ||
|| impersonatorId | **string** ||
|| impersonatorType | **enum** (SubjectType)

- `SUBJECT_TYPE_UNSPECIFIED`
- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `GROUP`
- `SSH_USER`
- `DB_NATIVE_USER`
- `KUBERNETES_USER`
- `DATALENS_SYSTEM_USER`
- `INVITEE` ||
|| impersonatorName | **string** ||
|| impersonatorFederationId | **string** ||
|| impersonatorFederationName | **string** ||
|| impersonatorFederationType | **enum** (FederationType)

- `FEDERATION_TYPE_UNSPECIFIED`
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

## EventDetails {#yandex.cloud.audit.compute.AddInstanceOneToOneNat.EventDetails}

#|
||Field | Description ||
|| instanceId | **string** ||
|| instanceName | **string** ||
|| networkInterfaceIndex | **string** ||
|| oneToOneNatSpec | **[OneToOneNatSpec](#yandex.cloud.compute.v1.OneToOneNatSpec)** ||
|| networkInterfaces[] | **[NetworkInterface](#yandex.cloud.compute.v1.NetworkInterface)** ||
|#

## OneToOneNatSpec {#yandex.cloud.compute.v1.OneToOneNatSpec}

#|
||Field | Description ||
|| ipVersion | **enum** (IpVersion)

External IP address version.

- `IP_VERSION_UNSPECIFIED`
- `IPV4`: IPv4 address, for example 192.0.2.235.
- `IPV6`: IPv6 address. Not available yet. ||
|| address | **string**

set static IP by value ||
|| dnsRecordSpecs[] | **[DnsRecordSpec](#yandex.cloud.compute.v1.DnsRecordSpec)**

External DNS configuration ||
|#

## DnsRecordSpec {#yandex.cloud.compute.v1.DnsRecordSpec}

#|
||Field | Description ||
|| fqdn | **string**

FQDN (required) ||
|| dnsZoneId | **string**

DNS zone id (optional, if not set, private zone used) ||
|| ttl | **string** (int64)

DNS record ttl, values in 0-86400 (optional) ||
|| ptr | **boolean**

When set to true, also create PTR DNS record (optional) ||
|#

## NetworkInterface {#yandex.cloud.compute.v1.NetworkInterface}

#|
||Field | Description ||
|| index | **string**

The index of the network interface, will be generated by the server, 0,1,2... etc if not specified. ||
|| macAddress | **string**

MAC address that is assigned to the network interface. ||
|| subnetId | **string**

ID of the subnet. ||
|| primaryV4Address | **[PrimaryAddress](#yandex.cloud.compute.v1.PrimaryAddress)**

Primary IPv4 address that is assigned to the instance for this network interface. ||
|| primaryV6Address | **[PrimaryAddress](#yandex.cloud.compute.v1.PrimaryAddress)**

Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet. ||
|| securityGroupIds[] | **string**

ID's of security groups attached to the interface ||
|#

## PrimaryAddress {#yandex.cloud.compute.v1.PrimaryAddress}

#|
||Field | Description ||
|| address | **string**

An IPv4 internal network address that is assigned to the instance for this network interface. ||
|| oneToOneNat | **[OneToOneNat](#yandex.cloud.compute.v1.OneToOneNat)**

One-to-one NAT configuration. If missing, NAT has not been set up. ||
|| dnsRecords[] | **[DnsRecord](#yandex.cloud.compute.v1.DnsRecord)**

Internal DNS configuration ||
|#

## OneToOneNat {#yandex.cloud.compute.v1.OneToOneNat}

#|
||Field | Description ||
|| address | **string**

An external IP address associated with this instance. ||
|| ipVersion | **enum** (IpVersion)

IP version for the external IP address.

- `IP_VERSION_UNSPECIFIED`
- `IPV4`: IPv4 address, for example 192.0.2.235.
- `IPV6`: IPv6 address. Not available yet. ||
|| dnsRecords[] | **[DnsRecord](#yandex.cloud.compute.v1.DnsRecord)**

External DNS configuration ||
|#

## DnsRecord {#yandex.cloud.compute.v1.DnsRecord}

#|
||Field | Description ||
|| fqdn | **string**

Name of the A/AAAA record as specified when creating the instance.
Note that if `fqdn' has no trailing '.', it is specified relative to the zone (@see dns_zone_id). ||
|| dnsZoneId | **string**

DNS zone id for the record (optional, if not set, some private zone is used). ||
|| ttl | **string** (int64)

DNS record ttl (optional, if not set, a reasonable default is used.) ||
|| ptr | **boolean**

When true, indicates there is a corresponding auto-created PTR DNS record. ||
|#