---
editable: false
---

# BareMetal Audit Trails Events: BatchCreateServer

## Event JSON schema {#yandex.cloud.audit.baremetal.BatchCreateServer2-schema}

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
    "servers": [
      {
        "serverId": "string",
        "serverName": "string",
        "hardwarePoolId": "string",
        "configurationId": "string",
        "rentalPeriodId": "string",
        "networkInterfaces": [
          {
            "networkId": "string",
            "ipAddress": "string",
            // Includes only one of the fields `privateSubnet`, `publicSubnet`
            "privateSubnet": {
              "subnetId": "string"
            },
            "publicSubnet": {
              "subnetId": "string"
            }
            // end of the list of possible fields
          }
        ],
        "disks": [
          {
            "diskId": "string",
            "type": "string",
            "diskSizeGb": "string"
          }
        ],
        "imageId": "string",
        "labels": "object"
      }
    ]
  }
}
```

## Field description {#yandex.cloud.audit.baremetal.BatchCreateServer2}

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
|| details | **[EventDetails](#yandex.cloud.audit.baremetal.BatchCreateServer.EventDetails)** ||
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

## EventDetails {#yandex.cloud.audit.baremetal.BatchCreateServer.EventDetails}

#|
||Field | Description ||
|| servers[] | **[Server](#yandex.cloud.audit.baremetal.Server)** ||
|#

## Server {#yandex.cloud.audit.baremetal.Server}

#|
||Field | Description ||
|| serverId | **string** ||
|| serverName | **string** ||
|| hardwarePoolId | **string** ||
|| configurationId | **string** ||
|| rentalPeriodId | **string** ||
|| networkInterfaces[] | **[NetworkInterface](#yandex.cloud.audit.baremetal.Server.NetworkInterface)** ||
|| disks[] | **[Disk](#yandex.cloud.audit.baremetal.Server.Disk)** ||
|| imageId | **string** ||
|| labels | **object** (map<**string**, **string**>) ||
|#

## NetworkInterface {#yandex.cloud.audit.baremetal.Server.NetworkInterface}

#|
||Field | Description ||
|| networkId | **string** ||
|| ipAddress | **string** ||
|| privateSubnet | **[PrivateSubnet](#yandex.cloud.audit.baremetal.Server.NetworkInterface.PrivateSubnet)**

Private subnet.

Includes only one of the fields `privateSubnet`, `publicSubnet`. ||
|| publicSubnet | **[PublicSubnet](#yandex.cloud.audit.baremetal.Server.NetworkInterface.PublicSubnet)**

Public subnet.

Includes only one of the fields `privateSubnet`, `publicSubnet`. ||
|#

## PrivateSubnet {#yandex.cloud.audit.baremetal.Server.NetworkInterface.PrivateSubnet}

#|
||Field | Description ||
|| subnetId | **string** ||
|#

## PublicSubnet {#yandex.cloud.audit.baremetal.Server.NetworkInterface.PublicSubnet}

#|
||Field | Description ||
|| subnetId | **string** ||
|#

## Disk {#yandex.cloud.audit.baremetal.Server.Disk}

#|
||Field | Description ||
|| diskId | **string** ||
|| type | **enum** (DiskDriveType)

- `DISK_DRIVE_TYPE_UNSPECIFIED`
- `HDD`
- `SSD` ||
|| diskSizeGb | **string** (int64) ||
|#