---
editable: false
---

# Cloud DNS Audit Trails Events: ProcessDnsQuery

## Event JSON schema {#yandex.cloud.audit.dns.ProcessDnsQuery2-schema}

```json
{
  "eventId": "string",
  "eventSource": "string",
  "eventType": "string",
  "eventTime": "string",
  "authentication": {
    "authenticated": "boolean",
    // Includes only one of the fields `subjectType`
    "subjectType": "string",
    // end of the list of possible fields
    // Includes only one of the fields `subjectId`
    "subjectId": "string",
    // end of the list of possible fields
    // Includes only one of the fields `subjectName`
    "subjectName": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationId`
    "federationId": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationName`
    "federationName": "string",
    // end of the list of possible fields
    // Includes only one of the fields `federationType`
    "federationType": "string",
    // end of the list of possible fields
    "tokenInfo": {
      "maskedIamToken": "string",
      // Includes only one of the fields `iamTokenId`
      "iamTokenId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorId`
      "impersonatorId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorType`
      "impersonatorType": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorName`
      "impersonatorName": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationId`
      "impersonatorFederationId": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationName`
      "impersonatorFederationName": "string",
      // end of the list of possible fields
      // Includes only one of the fields `impersonatorFederationType`
      "impersonatorFederationType": "string"
      // end of the list of possible fields
    }
  },
  "resourceMetadata": {
    "path": [
      {
        "resourceType": "string",
        "resourceId": "string",
        // Includes only one of the fields `resourceName`
        "resourceName": "string"
        // end of the list of possible fields
      }
    ]
  },
  "eventStatus": "string",
  "details": {
    "query": "string",
    "queryType": "string",
    "queryTime": "string",
    "responseTime": "string",
    "serverIp": "string",
    "serverCluster": "string",
    "clientIp": "string",
    "tag": "string",
    "networkId": "string",
    "vmInstanceId": "string",
    "forwardingQuery": "string",
    "rcode": "string",
    "answer": [
      {
        "name": "string",
        "recordType": "string",
        "ttl": "string"
      }
    ],
    "extra": [
      {
        "name": "string",
        "recordType": "string",
        "ttl": "string"
      }
    ],
    "ns": [
      {
        "name": "string",
        "recordType": "string",
        "ttl": "string"
      }
    ],
    "firewallResult": {
      "status": "string",
      "firewallId": "string"
    }
  }
}
```

## Field description {#yandex.cloud.audit.dns.ProcessDnsQuery2}

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
|| resourceMetadata | **[ResourceMetadata](#yandex.cloud.audit.ResourceMetadata)** ||
|| eventStatus | **enum** (EventStatus)

- `STARTED`
- `ERROR`
- `DONE`
- `CANCELLED`
- `RUNNING` ||
|| details | **[EventDetails](#yandex.cloud.audit.dns.ProcessDnsQuery.EventDetails)** ||
|#

## IamAuthentication {#yandex.cloud.audit.IamAuthentication}

#|
||Field | Description ||
|| authenticated | **boolean** ||
|| subjectType | **enum** (IamSubjectType)

Includes only one of the fields `subjectType`.

- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `SSH_USER`
- `KUBERNETES_USER` ||
|| subjectId | **string**

Includes only one of the fields `subjectId`. ||
|| subjectName | **string**

Includes only one of the fields `subjectName`. ||
|| federationId | **string**

Includes only one of the fields `federationId`. ||
|| federationName | **string**

Includes only one of the fields `federationName`. ||
|| federationType | **enum** (FederationType)

Includes only one of the fields `federationType`.

- `GLOBAL_FEDERATION`
- `PRIVATE_FEDERATION` ||
|| tokenInfo | **[IamTokenInfo](#yandex.cloud.audit.IamAuthentication.IamTokenInfo)** ||
|#

## IamTokenInfo {#yandex.cloud.audit.IamAuthentication.IamTokenInfo}

#|
||Field | Description ||
|| maskedIamToken | **string** ||
|| iamTokenId | **string**

Includes only one of the fields `iamTokenId`. ||
|| impersonatorId | **string**

Includes only one of the fields `impersonatorId`. ||
|| impersonatorType | **enum** (IamSubjectType)

Includes only one of the fields `impersonatorType`.

- `YANDEX_PASSPORT_USER_ACCOUNT`
- `SERVICE_ACCOUNT`
- `FEDERATED_USER_ACCOUNT`
- `SSH_USER`
- `KUBERNETES_USER` ||
|| impersonatorName | **string**

Includes only one of the fields `impersonatorName`. ||
|| impersonatorFederationId | **string**

Includes only one of the fields `impersonatorFederationId`. ||
|| impersonatorFederationName | **string**

Includes only one of the fields `impersonatorFederationName`. ||
|| impersonatorFederationType | **enum** (FederationType)

Includes only one of the fields `impersonatorFederationType`.

- `GLOBAL_FEDERATION`
- `PRIVATE_FEDERATION` ||
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
|| resourceName | **string**

Includes only one of the fields `resourceName`. ||
|#

## EventDetails {#yandex.cloud.audit.dns.ProcessDnsQuery.EventDetails}

#|
||Field | Description ||
|| query | **string** ||
|| queryType | **enum** (RecordType)

- `A`
- `NS`
- `MD`
- `MF`
- `CNAME`
- `SOA`
- `MB`
- `MG`
- `MR`
- `NULL`
- `PTR`
- `HINFO`
- `MINFO`
- `MX`
- `TXT`
- `RP`
- `AFSDB`
- `X25`
- `ISDN`
- `RT`
- `NSAPPTR`
- `SIG`
- `KEY`
- `PX`
- `GPOS`
- `AAAA`
- `LOC`
- `NXT`
- `EID`
- `NIMLOC`
- `SRV`
- `ATMA`
- `NAPTR`
- `KX`
- `CERT`
- `DNAME`
- `OPT`
- `APL`
- `DS`
- `SSHFP`
- `RRSIG`
- `NSEC`
- `DNSKEY`
- `DHCID`
- `NSEC3`
- `NSEC3PARAM`
- `TLSA`
- `SMIMEA`
- `HIP`
- `NINFO`
- `RKEY`
- `TALINK`
- `CDS`
- `CDNSKEY`
- `OPENPGPKEY`
- `CSYNC`
- `SVCB`
- `HTTPS`
- `SPF`
- `UINFO`
- `UID`
- `GID`
- `UNSPEC`
- `NID`
- `L32`
- `L64`
- `LP`
- `EUI48`
- `EUI64`
- `ANAME`
- `URI`
- `CAA`
- `AVC`
- `TKEY`
- `TSIG`
- `IXFR`
- `AXFR`
- `MAILB`
- `MAILA`
- `ANY` ||
|| queryTime | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| responseTime | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| serverIp | **string** ||
|| serverCluster | **string** ||
|| clientIp | **string** ||
|| tag | **string** ||
|| networkId | **string** ||
|| vmInstanceId | **string** ||
|| forwardingQuery | **string** ||
|| rcode | **enum** (Rcode)

- `FORMAT_ERROR`
- `NAME_ERROR`
- `NOT_IMPLEMENTED`
- `SERVER_FAILURE`
- `REFUSED`
- `YXDOMAIN`
- `YXRRSET`
- `NXRRSET`
- `NOT_AUTH`
- `NOT_ZONE`
- `BAD_SIG`
- `BAD_KEY`
- `BAD_TIME`
- `BAD_MODE`
- `BAD_NAME`
- `BAD_ALG`
- `BAD_TRUNC`
- `BAD_COOKIE`
- `SUCCESS` ||
|| answer[] | **[RR](#yandex.cloud.audit.dns.ProcessDnsQuery.RR)** ||
|| extra[] | **[RR](#yandex.cloud.audit.dns.ProcessDnsQuery.RR)** ||
|| ns[] | **[RR](#yandex.cloud.audit.dns.ProcessDnsQuery.RR)** ||
|| firewallResult | **[FirewallResult](#yandex.cloud.audit.dns.ProcessDnsQuery.FirewallResult)** ||
|#

## RR {#yandex.cloud.audit.dns.ProcessDnsQuery.RR}

#|
||Field | Description ||
|| name | **string** ||
|| recordType | **enum** (RecordType)

- `A`
- `NS`
- `MD`
- `MF`
- `CNAME`
- `SOA`
- `MB`
- `MG`
- `MR`
- `NULL`
- `PTR`
- `HINFO`
- `MINFO`
- `MX`
- `TXT`
- `RP`
- `AFSDB`
- `X25`
- `ISDN`
- `RT`
- `NSAPPTR`
- `SIG`
- `KEY`
- `PX`
- `GPOS`
- `AAAA`
- `LOC`
- `NXT`
- `EID`
- `NIMLOC`
- `SRV`
- `ATMA`
- `NAPTR`
- `KX`
- `CERT`
- `DNAME`
- `OPT`
- `APL`
- `DS`
- `SSHFP`
- `RRSIG`
- `NSEC`
- `DNSKEY`
- `DHCID`
- `NSEC3`
- `NSEC3PARAM`
- `TLSA`
- `SMIMEA`
- `HIP`
- `NINFO`
- `RKEY`
- `TALINK`
- `CDS`
- `CDNSKEY`
- `OPENPGPKEY`
- `CSYNC`
- `SVCB`
- `HTTPS`
- `SPF`
- `UINFO`
- `UID`
- `GID`
- `UNSPEC`
- `NID`
- `L32`
- `L64`
- `LP`
- `EUI48`
- `EUI64`
- `ANAME`
- `URI`
- `CAA`
- `AVC`
- `TKEY`
- `TSIG`
- `IXFR`
- `AXFR`
- `MAILB`
- `MAILA`
- `ANY` ||
|| ttl | **string** (int64) ||
|#

## FirewallResult {#yandex.cloud.audit.dns.ProcessDnsQuery.FirewallResult}

#|
||Field | Description ||
|| status | **enum** (FirewallStatus)

- `FW_NONE`
- `FW_PASS`
- `FW_BLOCKED` ||
|| firewallId | **string** ||
|#