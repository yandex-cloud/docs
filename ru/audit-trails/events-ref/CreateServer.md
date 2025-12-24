---
editable: false
sourcePath: en/_events-ref/audit/baremetal/events-ref/CreateServer.md
---

# BareMetal Audit Trails Events: CreateServer

## Event JSON schema {#yandex.cloud.audit.baremetal.CreateServer2-schema}

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
    "server": {
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
          },
          // end of the list of possible fields
          // Includes only one of the fields `privateInterface`, `publicInterface`
          "privateInterface": {
            "nativeSubnetId": "string",
            "vlanSubinterfaces": [
              {
                "taggedSubnetId": "string"
              }
            ]
          },
          "publicInterface": {
            "nativeSubnetId": "string",
            "internetTrafficPlan": "string"
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
  }
}
```

## Field description {#yandex.cloud.audit.baremetal.CreateServer2}

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
|| details | **[EventDetails](#yandex.cloud.audit.baremetal.CreateServer.EventDetails)** ||
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

## EventDetails {#yandex.cloud.audit.baremetal.CreateServer.EventDetails}

#|
||Field | Description ||
|| server | **[Server](#yandex.cloud.audit.baremetal.Server)** ||
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

Includes only one of the fields `privateSubnet`, `publicSubnet`. ||
|| publicSubnet | **[PublicSubnet](#yandex.cloud.audit.baremetal.Server.NetworkInterface.PublicSubnet)**

Includes only one of the fields `privateSubnet`, `publicSubnet`. ||
|| privateInterface | **[PrivateInterface](#yandex.cloud.audit.baremetal.Server.NetworkInterface.PrivateInterface)**

Includes only one of the fields `privateInterface`, `publicInterface`. ||
|| publicInterface | **[PublicInterface](#yandex.cloud.audit.baremetal.Server.NetworkInterface.PublicInterface)**

Includes only one of the fields `privateInterface`, `publicInterface`. ||
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

## PrivateInterface {#yandex.cloud.audit.baremetal.Server.NetworkInterface.PrivateInterface}

#|
||Field | Description ||
|| nativeSubnetId | **string** ||
|| vlanSubinterfaces[] | **[VLANSubinterface](#yandex.cloud.audit.baremetal.Server.NetworkInterface.PrivateInterface.VLANSubinterface)** ||
|#

## VLANSubinterface {#yandex.cloud.audit.baremetal.Server.NetworkInterface.PrivateInterface.VLANSubinterface}

#|
||Field | Description ||
|| taggedSubnetId | **string** ||
|#

## PublicInterface {#yandex.cloud.audit.baremetal.Server.NetworkInterface.PublicInterface}

#|
||Field | Description ||
|| nativeSubnetId | **string** ||
|| internetTrafficPlan | **enum** (InternetTrafficPlan)

- `PLAN_10TB`
- `PLAN_100TB` ||
|#

## Disk {#yandex.cloud.audit.baremetal.Server.Disk}

#|
||Field | Description ||
|| diskId | **string** ||
|| type | **enum** (DiskDriveType)

- `HDD`
- `SSD` ||
|| diskSizeGb | **string** (int64) ||
|#