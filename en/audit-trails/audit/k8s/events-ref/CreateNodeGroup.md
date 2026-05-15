---
editable: false
---

# Managed Services for Kubernetes Audit Trails Events: CreateNodeGroup

## Event JSON schema {#yandex.cloud.audit.k8s.CreateNodeGroup2-schema}

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
  "authorization": {
    "authorized": "boolean"
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
  "requestMetadata": {
    "remoteAddress": "string",
    "userAgent": "string",
    "requestId": "string",
    // Includes only one of the fields `remotePort`
    "remotePort": "string"
    // end of the list of possible fields
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
    "clusterId": "string",
    "nodeGroupId": "string",
    "name": "string",
    "description": "string",
    "labels": "object",
    "status": "string",
    "nodeTemplate": {
      "name": "string",
      "labels": "object",
      "platformId": "string",
      "resourcesSpec": {
        "memory": "string",
        "cores": "string",
        "coreFraction": "string",
        "gpus": "string"
      },
      "bootDiskSpec": {
        "diskTypeId": "string",
        "diskSize": "string"
      },
      "reservedInstancePoolId": "string",
      "metadata": "object",
      "v4AddressSpec": {
        "oneToOneNatSpec": {
          "ipVersion": "string"
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
      "schedulingPolicy": {
        "preemptible": "boolean"
      },
      "networkInterfaceSpecs": [
        {
          "subnetIds": [
            "string"
          ],
          "primaryV4AddressSpec": {
            "oneToOneNatSpec": {
              "ipVersion": "string"
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
            "oneToOneNatSpec": {
              "ipVersion": "string"
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
          ]
        }
      ],
      "placementPolicy": {
        "placementGroupId": "string"
      },
      "networkSettings": {
        "type": "string"
      },
      "containerRuntimeSettings": {
        "type": "string"
      },
      "containerNetworkSettings": {
        "podMtu": "string"
      },
      "gpuSettings": {
        "gpuClusterId": "string",
        "gpuEnvironment": "string"
      }
    },
    "scalePolicy": {
      // Includes only one of the fields `fixedScale`, `autoScale`
      "fixedScale": {
        "size": "string"
      },
      "autoScale": {
        "minSize": "string",
        "maxSize": "string",
        "initialSize": "string"
      }
      // end of the list of possible fields
    },
    "allocationPolicy": {
      "locations": [
        {
          "zoneId": "string",
          "subnetId": "string"
        }
      ]
    },
    "deployPolicy": {
      "maxUnavailable": "string",
      "maxExpansion": "string"
    },
    "instanceGroupId": "string",
    "nodeVersion": "string",
    "versionInfo": {
      "currentVersion": "string",
      "newRevisionAvailable": "boolean",
      "newRevisionSummary": "string",
      "versionDeprecated": "boolean"
    },
    "maintenancePolicy": {
      "autoUpgrade": "boolean",
      "autoRepair": "boolean",
      "maintenanceWindow": {
        // Includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`
        "anytime": "object",
        "dailyMaintenanceWindow": {
          "startTime": {
            "hours": "integer",
            "minutes": "integer",
            "seconds": "integer",
            "nanos": "integer"
          },
          "duration": "string"
        },
        "weeklyMaintenanceWindow": {
          "daysOfWeek": [
            {
              "days": [
                "string"
              ],
              "startTime": {
                "hours": "integer",
                "minutes": "integer",
                "seconds": "integer",
                "nanos": "integer"
              },
              "duration": "string"
            }
          ]
        }
        // end of the list of possible fields
      }
    },
    "allowedUnsafeSysctls": [
      "string"
    ],
    "nodeTaints": [
      {
        "key": "string",
        "value": "string",
        "effect": "string"
      }
    ],
    "nodeLabels": "object"
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.k8s.CreateNodeGroup2}

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
|| details | **[NodeGroupDetails](#yandex.cloud.audit.k8s.NodeGroupDetails)** ||
|| requestParameters | **object** ||
|| response | **object** ||
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
|| resourceName | **string**

Includes only one of the fields `resourceName`. ||
|#

## RequestMetadata {#yandex.cloud.audit.RequestMetadata}

#|
||Field | Description ||
|| remoteAddress | **string** ||
|| userAgent | **string** ||
|| requestId | **string** ||
|| remotePort | **string** (int64)

Includes only one of the fields `remotePort`. ||
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

## NodeGroupDetails {#yandex.cloud.audit.k8s.NodeGroupDetails}

#|
||Field | Description ||
|| clusterId | **string** ||
|| nodeGroupId | **string** ||
|| name | **string** ||
|| description | **string** ||
|| labels | **object** (map<**string**, **string**>) ||
|| status | **enum** (Status)

- `PROVISIONING`
- `RUNNING`
- `RECONCILING`
- `STOPPING`
- `STOPPED`
- `DELETING`
- `STARTING` ||
|| nodeTemplate | **[NodeTemplate](#yandex.cloud.k8s.v1.NodeTemplate)** ||
|| scalePolicy | **[ScalePolicy](#yandex.cloud.k8s.v1.ScalePolicy)** ||
|| allocationPolicy | **[NodeGroupAllocationPolicy](#yandex.cloud.k8s.v1.NodeGroupAllocationPolicy)** ||
|| deployPolicy | **[DeployPolicy](#yandex.cloud.k8s.v1.DeployPolicy)** ||
|| instanceGroupId | **string** ||
|| nodeVersion | **string** ||
|| versionInfo | **[VersionInfo](#yandex.cloud.k8s.v1.VersionInfo)** ||
|| maintenancePolicy | **[NodeGroupMaintenancePolicy](#yandex.cloud.k8s.v1.NodeGroupMaintenancePolicy)** ||
|| allowedUnsafeSysctls[] | **string** ||
|| nodeTaints[] | **[Taint](#yandex.cloud.k8s.v1.Taint)** ||
|| nodeLabels | **object** (map<**string**, **string**>) ||
|#

## NodeTemplate {#yandex.cloud.k8s.v1.NodeTemplate}

#|
||Field | Description ||
|| name | **string**

The maximum string length in characters is 128. ||
|| labels | **object** (map<**string**, **string**>)

No more than 32 per resource. The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\@0-9a-z]* `. ||
|| platformId | **string** ||
|| resourcesSpec | **[ResourcesSpec](#yandex.cloud.k8s.v1.ResourcesSpec)** ||
|| bootDiskSpec | **[DiskSpec](#yandex.cloud.k8s.v1.DiskSpec)** ||
|| reservedInstancePoolId | **string** ||
|| metadata | **object** (map<**string**, **string**>)

No more than 64 per resource. The maximum string length in characters for each value is 131072. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. ||
|| v4AddressSpec | **[NodeAddressSpec](#yandex.cloud.k8s.v1.NodeAddressSpec)** ||
|| schedulingPolicy | **[SchedulingPolicy](#yandex.cloud.k8s.v1.SchedulingPolicy)** ||
|| networkInterfaceSpecs[] | **[NetworkInterfaceSpec](#yandex.cloud.k8s.v1.NetworkInterfaceSpec)** ||
|| placementPolicy | **[PlacementPolicy](#yandex.cloud.k8s.v1.PlacementPolicy)** ||
|| networkSettings | **[NetworkSettings](#yandex.cloud.k8s.v1.NodeTemplate.NetworkSettings)** ||
|| containerRuntimeSettings | **[ContainerRuntimeSettings](#yandex.cloud.k8s.v1.NodeTemplate.ContainerRuntimeSettings)** ||
|| containerNetworkSettings | **[ContainerNetworkSettings](#yandex.cloud.k8s.v1.NodeTemplate.ContainerNetworkSettings)** ||
|| gpuSettings | **[GpuSettings](#yandex.cloud.k8s.v1.GpuSettings)** ||
|#

## ResourcesSpec {#yandex.cloud.k8s.v1.ResourcesSpec}

#|
||Field | Description ||
|| memory | **string** (int64)

The minimum value is 0. ||
|| cores | **string** (int64)

The minimum value is 0. ||
|| coreFraction | **string** (int64)

Acceptable values are 0 to 100, inclusive. ||
|| gpus | **string** (int64)

The minimum value is 0. ||
|#

## DiskSpec {#yandex.cloud.k8s.v1.DiskSpec}

#|
||Field | Description ||
|| diskTypeId | **string**

Value must match the regular expression ``` |network-ssd|network-hdd|network-ssd-nonreplicated|network-ssd-io-m3 ```. ||
|| diskSize | **string** (int64)

Acceptable values are 0 to 4398046511104, inclusive. ||
|#

## NodeAddressSpec {#yandex.cloud.k8s.v1.NodeAddressSpec}

#|
||Field | Description ||
|| oneToOneNatSpec | **[OneToOneNatSpec](#yandex.cloud.k8s.v1.OneToOneNatSpec)** ||
|| dnsRecordSpecs[] | **[DnsRecordSpec](#yandex.cloud.k8s.v1.DnsRecordSpec)** ||
|#

## OneToOneNatSpec {#yandex.cloud.k8s.v1.OneToOneNatSpec}

#|
||Field | Description ||
|| ipVersion | **enum** (IpVersion)

- `IPV4`
- `IPV6` ||
|#

## DnsRecordSpec {#yandex.cloud.k8s.v1.DnsRecordSpec}

#|
||Field | Description ||
|| fqdn | **string** ||
|| dnsZoneId | **string** ||
|| ttl | **string** (int64)

Acceptable values are 0 to 86400, inclusive. ||
|| ptr | **boolean** ||
|#

## SchedulingPolicy {#yandex.cloud.k8s.v1.SchedulingPolicy}

#|
||Field | Description ||
|| preemptible | **boolean** ||
|#

## NetworkInterfaceSpec {#yandex.cloud.k8s.v1.NetworkInterfaceSpec}

#|
||Field | Description ||
|| subnetIds[] | **string** ||
|| primaryV4AddressSpec | **[NodeAddressSpec](#yandex.cloud.k8s.v1.NodeAddressSpec)** ||
|| primaryV6AddressSpec | **[NodeAddressSpec](#yandex.cloud.k8s.v1.NodeAddressSpec)** ||
|| securityGroupIds[] | **string** ||
|#

## PlacementPolicy {#yandex.cloud.k8s.v1.PlacementPolicy}

#|
||Field | Description ||
|| placementGroupId | **string** ||
|#

## NetworkSettings {#yandex.cloud.k8s.v1.NodeTemplate.NetworkSettings}

#|
||Field | Description ||
|| type | **enum** (Type)

- `STANDARD`
- `SOFTWARE_ACCELERATED` ||
|#

## ContainerRuntimeSettings {#yandex.cloud.k8s.v1.NodeTemplate.ContainerRuntimeSettings}

#|
||Field | Description ||
|| type | **enum** (Type)

- `DOCKER`
- `CONTAINERD` ||
|#

## ContainerNetworkSettings {#yandex.cloud.k8s.v1.NodeTemplate.ContainerNetworkSettings}

#|
||Field | Description ||
|| podMtu | **string** (int64) ||
|#

## GpuSettings {#yandex.cloud.k8s.v1.GpuSettings}

#|
||Field | Description ||
|| gpuClusterId | **string** ||
|| gpuEnvironment | **enum** (GpuEnvironment)

- `RUNC_DRIVERS_CUDA`
- `RUNC` ||
|#

## ScalePolicy {#yandex.cloud.k8s.v1.ScalePolicy}

#|
||Field | Description ||
|| fixedScale | **[FixedScale](#yandex.cloud.k8s.v1.ScalePolicy.FixedScale)**

Includes only one of the fields `fixedScale`, `autoScale`. ||
|| autoScale | **[AutoScale](#yandex.cloud.k8s.v1.ScalePolicy.AutoScale)**

Includes only one of the fields `fixedScale`, `autoScale`. ||
|#

## FixedScale {#yandex.cloud.k8s.v1.ScalePolicy.FixedScale}

#|
||Field | Description ||
|| size | **string** (int64)

Acceptable values are 0 to 100, inclusive. ||
|#

## AutoScale {#yandex.cloud.k8s.v1.ScalePolicy.AutoScale}

#|
||Field | Description ||
|| minSize | **string** (int64)

Acceptable values are 0 to 100, inclusive. ||
|| maxSize | **string** (int64)

Acceptable values are 0 to 100, inclusive. ||
|| initialSize | **string** (int64)

Acceptable values are 0 to 100, inclusive. ||
|#

## NodeGroupAllocationPolicy {#yandex.cloud.k8s.v1.NodeGroupAllocationPolicy}

#|
||Field | Description ||
|| locations[] | **[NodeGroupLocation](#yandex.cloud.k8s.v1.NodeGroupLocation)** ||
|#

## NodeGroupLocation {#yandex.cloud.k8s.v1.NodeGroupLocation}

#|
||Field | Description ||
|| zoneId | **string** ||
|| subnetId | **string** ||
|#

## DeployPolicy {#yandex.cloud.k8s.v1.DeployPolicy}

#|
||Field | Description ||
|| maxUnavailable | **string** (int64)

Acceptable values are 0 to 100, inclusive. ||
|| maxExpansion | **string** (int64)

Acceptable values are 0 to 100, inclusive. ||
|#

## VersionInfo {#yandex.cloud.k8s.v1.VersionInfo}

#|
||Field | Description ||
|| currentVersion | **string** ||
|| newRevisionAvailable | **boolean** ||
|| newRevisionSummary | **string** ||
|| versionDeprecated | **boolean** ||
|#

## NodeGroupMaintenancePolicy {#yandex.cloud.k8s.v1.NodeGroupMaintenancePolicy}

#|
||Field | Description ||
|| autoUpgrade | **boolean** ||
|| autoRepair | **boolean** ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.k8s.v1.MaintenanceWindow)** ||
|#

## MaintenanceWindow {#yandex.cloud.k8s.v1.MaintenanceWindow}

#|
||Field | Description ||
|| anytime | **object**

Includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`. ||
|| dailyMaintenanceWindow | **[DailyMaintenanceWindow](#yandex.cloud.k8s.v1.DailyMaintenanceWindow)**

Includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.k8s.v1.WeeklyMaintenanceWindow)**

Includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`. ||
|#

## DailyMaintenanceWindow {#yandex.cloud.k8s.v1.DailyMaintenanceWindow}

#|
||Field | Description ||
|| startTime | **[TimeOfDay](#google.type.TimeOfDay)** ||
|| duration | **string** (duration) ||
|#

## TimeOfDay {#google.type.TimeOfDay}

#|
||Field | Description ||
|| hours | **integer** (int32) ||
|| minutes | **integer** (int32) ||
|| seconds | **integer** (int32) ||
|| nanos | **integer** (int32) ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.k8s.v1.WeeklyMaintenanceWindow}

#|
||Field | Description ||
|| daysOfWeek[] | **[DaysOfWeekMaintenanceWindow](#yandex.cloud.k8s.v1.DaysOfWeekMaintenanceWindow)**

The number of elements must be in the range 1-7. ||
|#

## DaysOfWeekMaintenanceWindow {#yandex.cloud.k8s.v1.DaysOfWeekMaintenanceWindow}

#|
||Field | Description ||
|| days[] | **enum** (DayOfWeek)

The number of elements must be in the range 1-7.

- `MONDAY`
- `TUESDAY`
- `WEDNESDAY`
- `THURSDAY`
- `FRIDAY`
- `SATURDAY`
- `SUNDAY` ||
|| startTime | **[TimeOfDay](#google.type.TimeOfDay)** ||
|| duration | **string** (duration) ||
|#

## Taint {#yandex.cloud.k8s.v1.Taint}

#|
||Field | Description ||
|| key | **string** ||
|| value | **string** ||
|| effect | **enum** (Effect)

- `NO_SCHEDULE`
- `PREFER_NO_SCHEDULE`
- `NO_EXECUTE` ||
|#