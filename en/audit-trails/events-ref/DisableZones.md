---
editable: false
sourcePath: en/_events-ref/audit/compute/events-ref/DisableZones.md
---

# Compute Audit Trails Events: DisableZones

## Event JSON schema {#yandex.cloud.audit.compute.instancegroup.DisableZones2-schema}

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
    "instanceGroupId": "string",
    "instanceGroupName": "string",
    "instanceTemplate": {
      "description": "string",
      "labels": "object",
      "platformId": "string",
      "resourcesSpec": {
        "memory": "string",
        "cores": "string",
        "coreFraction": "string",
        "gpus": "string"
      },
      "metadata": "object",
      "bootDiskSpec": {
        "mode": "string",
        "deviceName": "string",
        "diskSpec": {
          "description": "string",
          "typeId": "string",
          "size": "string",
          // Includes only one of the fields `imageId`, `snapshotId`
          "imageId": "string",
          "snapshotId": "string",
          // end of the list of possible fields
          "preserveAfterInstanceDelete": "boolean"
        },
        "diskId": "string",
        "name": "string"
      },
      "secondaryDiskSpecs": [
        {
          "mode": "string",
          "deviceName": "string",
          "diskSpec": {
            "description": "string",
            "typeId": "string",
            "size": "string",
            // Includes only one of the fields `imageId`, `snapshotId`
            "imageId": "string",
            "snapshotId": "string",
            // end of the list of possible fields
            "preserveAfterInstanceDelete": "boolean"
          },
          "diskId": "string",
          "name": "string"
        }
      ],
      "networkInterfaceSpecs": [
        {
          "networkId": "string",
          "subnetIds": [
            "string"
          ],
          "primaryV4AddressSpec": {
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
            ],
            "address": "string"
          },
          "primaryV6AddressSpec": {
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
            ],
            "address": "string"
          },
          "securityGroupIds": [
            "string"
          ]
        }
      ],
      "schedulingPolicy": {
        "preemptible": "boolean"
      },
      "serviceAccountId": "string",
      "networkSettings": {
        "type": "string"
      },
      "name": "string",
      "hostname": "string",
      "placementPolicy": {
        "placementGroupId": "string",
        "hostAffinityRules": [
          {
            "key": "string",
            "op": "string",
            "values": [
              "string"
            ]
          }
        ]
      },
      "filesystemSpecs": [
        {
          "mode": "string",
          "deviceName": "string",
          "filesystemId": "string"
        }
      ],
      "metadataOptions": {
        "gceHttpEndpoint": "string",
        "awsV1HttpEndpoint": "string",
        "gceHttpToken": "string",
        "awsV1HttpToken": "string"
      },
      "reservedInstancePoolId": "string"
    },
    "scalePolicy": {
      // Includes only one of the fields `fixedScale`, `autoScale`
      "fixedScale": {
        "size": "string"
      },
      "autoScale": {
        "minZoneSize": "string",
        "maxSize": "string",
        "measurementDuration": "string",
        "warmupDuration": "string",
        "stabilizationDuration": "string",
        "initialSize": "string",
        "cpuUtilizationRule": {
          "utilizationTarget": "string"
        },
        "customRules": [
          {
            "ruleType": "string",
            "metricType": "string",
            "metricName": "string",
            "labels": "object",
            "target": "string",
            "folderId": "string",
            "service": "string"
          }
        ],
        "autoScaleType": "string"
      },
      // end of the list of possible fields
      "testAutoScale": {
        "minZoneSize": "string",
        "maxSize": "string",
        "measurementDuration": "string",
        "warmupDuration": "string",
        "stabilizationDuration": "string",
        "initialSize": "string",
        "cpuUtilizationRule": {
          "utilizationTarget": "string"
        },
        "customRules": [
          {
            "ruleType": "string",
            "metricType": "string",
            "metricName": "string",
            "labels": "object",
            "target": "string",
            "folderId": "string",
            "service": "string"
          }
        ],
        "autoScaleType": "string"
      }
    },
    "deployPolicy": {
      "maxUnavailable": "string",
      "maxDeleting": "string",
      "maxCreating": "string",
      "maxExpansion": "string",
      "startupDuration": "string",
      "strategy": "string",
      "minimalAction": "string"
    },
    "allocationPolicy": {
      "zones": [
        {
          "zoneId": "string",
          "instanceTagsPool": [
            "string"
          ]
        }
      ]
    },
    "loadBalancerSpec": {
      "targetGroupSpec": {
        "name": "string",
        "description": "string",
        "labels": "object"
      },
      "maxOpeningTrafficDuration": "string",
      "ignoreHealthChecks": "boolean"
    },
    "healthChecksSpec": {
      "healthCheckSpecs": [
        {
          "interval": "string",
          "timeout": "string",
          "unhealthyThreshold": "string",
          "healthyThreshold": "string",
          // Includes only one of the fields `tcpOptions`, `httpOptions`
          "tcpOptions": {
            "port": "string"
          },
          "httpOptions": {
            "port": "string",
            "path": "string"
          }
          // end of the list of possible fields
        }
      ],
      "maxCheckingHealthDuration": "string"
    },
    "serviceAccountId": "string",
    "status": "string",
    "variables": [
      {
        "key": "string",
        "value": "string"
      }
    ],
    "deletionProtection": "boolean",
    "applicationLoadBalancerSpec": {
      "targetGroupSpec": {
        "name": "string",
        "description": "string",
        "labels": "object"
      },
      "maxOpeningTrafficDuration": "string",
      "ignoreHealthChecks": "boolean"
    },
    "loadBalancerState": {
      "targetGroupId": "string",
      "statusMessage": "string"
    },
    "applicationLoadBalancerState": {
      "targetGroupId": "string",
      "statusMessage": "string"
    },
    "disableZoneStatuses": [
      {
        "zoneId": "string",
        "disabledUntil": "string"
      }
    ]
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.compute.instancegroup.DisableZones2}

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
|| details | **[EventDetails](#yandex.cloud.audit.compute.instancegroup.DisableZones.EventDetails)** ||
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

## EventDetails {#yandex.cloud.audit.compute.instancegroup.DisableZones.EventDetails}

#|
||Field | Description ||
|| instanceGroupId | **string** ||
|| instanceGroupName | **string** ||
|| instanceTemplate | **[InstanceTemplate](#yandex.cloud.compute.v1.instancegroup.InstanceTemplate)** ||
|| scalePolicy | **[ScalePolicy](#yandex.cloud.compute.v1.instancegroup.ScalePolicy)** ||
|| deployPolicy | **[DeployPolicy](#yandex.cloud.compute.v1.instancegroup.DeployPolicy)** ||
|| allocationPolicy | **[AllocationPolicy](#yandex.cloud.compute.v1.instancegroup.AllocationPolicy)** ||
|| loadBalancerSpec | **[LoadBalancerSpec](#yandex.cloud.compute.v1.instancegroup.LoadBalancerSpec)** ||
|| healthChecksSpec | **[HealthChecksSpec](#yandex.cloud.compute.v1.instancegroup.HealthChecksSpec)** ||
|| serviceAccountId | **string** ||
|| status | **string** ||
|| variables[] | **[Variable](#yandex.cloud.compute.v1.instancegroup.Variable)** ||
|| deletionProtection | **boolean** ||
|| applicationLoadBalancerSpec | **[ApplicationLoadBalancerSpec](#yandex.cloud.compute.v1.instancegroup.ApplicationLoadBalancerSpec)** ||
|| loadBalancerState | **[LoadBalancerState](#yandex.cloud.compute.v1.instancegroup.LoadBalancerState)** ||
|| applicationLoadBalancerState | **[ApplicationLoadBalancerState](#yandex.cloud.compute.v1.instancegroup.ApplicationLoadBalancerState)** ||
|| disableZoneStatuses[] | **[DisableZoneStatus](#yandex.cloud.compute.v1.instancegroup.DisableZoneStatus)** ||
|#

## InstanceTemplate {#yandex.cloud.compute.v1.instancegroup.InstanceTemplate}

#|
||Field | Description ||
|| description | **string**

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

No more than 64 per resource. The maximum string length in characters for each value is 128. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\@0-9a-z]* `. ||
|| platformId | **string** ||
|| resourcesSpec | **[ResourcesSpec](#yandex.cloud.compute.v1.instancegroup.ResourcesSpec)** ||
|| metadata | **object** (map<**string**, **string**>)

No more than 128 per resource. The maximum string length in characters for each value is 262144. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. ||
|| bootDiskSpec | **[AttachedDiskSpec](#yandex.cloud.compute.v1.instancegroup.AttachedDiskSpec)** ||
|| secondaryDiskSpecs[] | **[AttachedDiskSpec](#yandex.cloud.compute.v1.instancegroup.AttachedDiskSpec)**

The maximum number of elements is 3. ||
|| networkInterfaceSpecs[] | **[NetworkInterfaceSpec](#yandex.cloud.compute.v1.instancegroup.NetworkInterfaceSpec)** ||
|| schedulingPolicy | **[SchedulingPolicy](#yandex.cloud.compute.v1.instancegroup.SchedulingPolicy)** ||
|| serviceAccountId | **string** ||
|| networkSettings | **[NetworkSettings](#yandex.cloud.compute.v1.instancegroup.NetworkSettings)** ||
|| name | **string**

The maximum string length in characters is 128. ||
|| hostname | **string**

The maximum string length in characters is 128. ||
|| placementPolicy | **[PlacementPolicy](#yandex.cloud.compute.v1.instancegroup.PlacementPolicy)** ||
|| filesystemSpecs[] | **[AttachedFilesystemSpec](#yandex.cloud.compute.v1.instancegroup.AttachedFilesystemSpec)** ||
|| metadataOptions | **[MetadataOptions](#yandex.cloud.compute.v1.instancegroup.MetadataOptions)** ||
|| reservedInstancePoolId | **string** ||
|#

## ResourcesSpec {#yandex.cloud.compute.v1.instancegroup.ResourcesSpec}

#|
||Field | Description ||
|| memory | **string** (int64)

The maximum value is 824633720832. ||
|| cores | **string** (int64) ||
|| coreFraction | **string** (int64) ||
|| gpus | **string** (int64) ||
|#

## AttachedDiskSpec {#yandex.cloud.compute.v1.instancegroup.AttachedDiskSpec}

#|
||Field | Description ||
|| mode | **enum** (Mode)

- `READ_ONLY`
- `READ_WRITE` ||
|| deviceName | **string**

Value must match the regular expression ` \|[a-z][-_0-9a-z]{0,19} `. ||
|| diskSpec | **[DiskSpec](#yandex.cloud.compute.v1.instancegroup.AttachedDiskSpec.DiskSpec)** ||
|| diskId | **string**

The maximum string length in characters is 128. Value must match the regular expression ` [-a-zA-Z0-9._{}]* `. ||
|| name | **string**

The maximum string length in characters is 128. ||
|#

## DiskSpec {#yandex.cloud.compute.v1.instancegroup.AttachedDiskSpec.DiskSpec}

#|
||Field | Description ||
|| description | **string**

The maximum string length in characters is 256. ||
|| typeId | **string** ||
|| size | **string** (int64)

Acceptable values are 4194304 to 28587302322176, inclusive. ||
|| imageId | **string**

The maximum string length in characters is 50.

Includes only one of the fields `imageId`, `snapshotId`. ||
|| snapshotId | **string**

The maximum string length in characters is 50.

Includes only one of the fields `imageId`, `snapshotId`. ||
|| preserveAfterInstanceDelete | **boolean** ||
|#

## NetworkInterfaceSpec {#yandex.cloud.compute.v1.instancegroup.NetworkInterfaceSpec}

#|
||Field | Description ||
|| networkId | **string** ||
|| subnetIds[] | **string** ||
|| primaryV4AddressSpec | **[PrimaryAddressSpec](#yandex.cloud.compute.v1.instancegroup.PrimaryAddressSpec)** ||
|| primaryV6AddressSpec | **[PrimaryAddressSpec](#yandex.cloud.compute.v1.instancegroup.PrimaryAddressSpec)** ||
|| securityGroupIds[] | **string** ||
|#

## PrimaryAddressSpec {#yandex.cloud.compute.v1.instancegroup.PrimaryAddressSpec}

#|
||Field | Description ||
|| oneToOneNatSpec | **[OneToOneNatSpec](#yandex.cloud.compute.v1.instancegroup.OneToOneNatSpec)** ||
|| dnsRecordSpecs[] | **[DnsRecordSpec](#yandex.cloud.compute.v1.instancegroup.DnsRecordSpec)** ||
|| address | **string** ||
|#

## OneToOneNatSpec {#yandex.cloud.compute.v1.instancegroup.OneToOneNatSpec}

#|
||Field | Description ||
|| ipVersion | **enum** (IpVersion)

- `IPV4`
- `IPV6` ||
|| address | **string** ||
|| dnsRecordSpecs[] | **[DnsRecordSpec](#yandex.cloud.compute.v1.instancegroup.DnsRecordSpec)** ||
|#

## DnsRecordSpec {#yandex.cloud.compute.v1.instancegroup.DnsRecordSpec}

#|
||Field | Description ||
|| fqdn | **string** ||
|| dnsZoneId | **string** ||
|| ttl | **string** (int64)

Acceptable values are 0 to 86400, inclusive. ||
|| ptr | **boolean** ||
|#

## SchedulingPolicy {#yandex.cloud.compute.v1.instancegroup.SchedulingPolicy}

#|
||Field | Description ||
|| preemptible | **boolean** ||
|#

## NetworkSettings {#yandex.cloud.compute.v1.instancegroup.NetworkSettings}

#|
||Field | Description ||
|| type | **enum** (Type)

- `STANDARD`
- `SOFTWARE_ACCELERATED`
- `HARDWARE_ACCELERATED` ||
|#

## PlacementPolicy {#yandex.cloud.compute.v1.instancegroup.PlacementPolicy}

#|
||Field | Description ||
|| placementGroupId | **string** ||
|| hostAffinityRules[] | **[HostAffinityRule](#yandex.cloud.compute.v1.instancegroup.PlacementPolicy.HostAffinityRule)** ||
|#

## HostAffinityRule {#yandex.cloud.compute.v1.instancegroup.PlacementPolicy.HostAffinityRule}

#|
||Field | Description ||
|| key | **string** ||
|| op | **enum** (Operator)

- `IN`
- `NOT_IN` ||
|| values[] | **string** ||
|#

## AttachedFilesystemSpec {#yandex.cloud.compute.v1.instancegroup.AttachedFilesystemSpec}

#|
||Field | Description ||
|| mode | **enum** (Mode)

- `READ_ONLY`
- `READ_WRITE` ||
|| deviceName | **string**

Value must match the regular expression ` \|[a-z][-_0-9a-z]{0,19} `. ||
|| filesystemId | **string**

The maximum string length in characters is 128. Value must match the regular expression ` [-a-zA-Z0-9._{}]* `. ||
|#

## MetadataOptions {#yandex.cloud.compute.v1.instancegroup.MetadataOptions}

#|
||Field | Description ||
|| gceHttpEndpoint | **enum** (MetadataOption)

- `ENABLED`
- `DISABLED` ||
|| awsV1HttpEndpoint | **enum** (MetadataOption)

- `ENABLED`
- `DISABLED` ||
|| gceHttpToken | **enum** (MetadataOption)

- `ENABLED`
- `DISABLED` ||
|| awsV1HttpToken | **enum** (MetadataOption)

- `ENABLED`
- `DISABLED` ||
|#

## ScalePolicy {#yandex.cloud.compute.v1.instancegroup.ScalePolicy}

#|
||Field | Description ||
|| fixedScale | **[FixedScale](#yandex.cloud.compute.v1.instancegroup.ScalePolicy.FixedScale)**

Includes only one of the fields `fixedScale`, `autoScale`. ||
|| autoScale | **[AutoScale](#yandex.cloud.compute.v1.instancegroup.ScalePolicy.AutoScale)**

Includes only one of the fields `fixedScale`, `autoScale`. ||
|| testAutoScale | **[AutoScale](#yandex.cloud.compute.v1.instancegroup.ScalePolicy.AutoScale)** ||
|#

## FixedScale {#yandex.cloud.compute.v1.instancegroup.ScalePolicy.FixedScale}

#|
||Field | Description ||
|| size | **string** (int64)

Acceptable values are 1 to 100, inclusive. ||
|#

## AutoScale {#yandex.cloud.compute.v1.instancegroup.ScalePolicy.AutoScale}

#|
||Field | Description ||
|| minZoneSize | **string** (int64)

Acceptable values are 0 to 100, inclusive. ||
|| maxSize | **string** (int64)

Acceptable values are 0 to 100, inclusive. ||
|| measurementDuration | **string** (duration) ||
|| warmupDuration | **string** (duration) ||
|| stabilizationDuration | **string** (duration) ||
|| initialSize | **string** (int64)

The minimum value is 1. ||
|| cpuUtilizationRule | **[CpuUtilizationRule](#yandex.cloud.compute.v1.instancegroup.ScalePolicy.CpuUtilizationRule)** ||
|| customRules[] | **[CustomRule](#yandex.cloud.compute.v1.instancegroup.ScalePolicy.CustomRule)**

The maximum number of elements is 3. ||
|| autoScaleType | **enum** (AutoScaleType)

- `ZONAL`
- `REGIONAL` ||
|#

## CpuUtilizationRule {#yandex.cloud.compute.v1.instancegroup.ScalePolicy.CpuUtilizationRule}

#|
||Field | Description ||
|| utilizationTarget | **string**

Acceptable values are 10 to 100, inclusive. ||
|#

## CustomRule {#yandex.cloud.compute.v1.instancegroup.ScalePolicy.CustomRule}

#|
||Field | Description ||
|| ruleType | **enum** (RuleType)

- `UTILIZATION`
- `WORKLOAD` ||
|| metricType | **enum** (MetricType)

- `GAUGE`
- `COUNTER` ||
|| metricName | **string**

Value must match the regular expression ` [a-zA-Z0-9./@_][ 0-9a-zA-Z./@_,:;()\[\]<>-]{0,198} `. ||
|| labels | **object** (map<**string**, **string**>)

Each value must match the regular expression ` [a-zA-Z0-9./@_][ 0-9a-zA-Z./@_,:;()\[\]<>-]{0,198} `. Each key must match the regular expression ` ^[a-zA-Z][0-9a-zA-Z_]{0,31}$ `. ||
|| target | **string**

Value must be greater than 0. ||
|| folderId | **string**

The maximum string length in characters is 50. ||
|| service | **string**

The maximum string length in characters is 200. ||
|#

## DeployPolicy {#yandex.cloud.compute.v1.instancegroup.DeployPolicy}

#|
||Field | Description ||
|| maxUnavailable | **string** (int64)

Acceptable values are 0 to 100, inclusive. ||
|| maxDeleting | **string** (int64)

Acceptable values are 0 to 100, inclusive. ||
|| maxCreating | **string** (int64)

Acceptable values are 0 to 100, inclusive. ||
|| maxExpansion | **string** (int64)

Acceptable values are 0 to 100, inclusive. ||
|| startupDuration | **string** (duration) ||
|| strategy | **enum** (Strategy)

- `PROACTIVE`
- `OPPORTUNISTIC` ||
|| minimalAction | **enum** (MinimalAction)

- `LIVE_UPDATE`
- `RESTART`
- `RECREATE` ||
|#

## AllocationPolicy {#yandex.cloud.compute.v1.instancegroup.AllocationPolicy}

#|
||Field | Description ||
|| zones[] | **[Zone](#yandex.cloud.compute.v1.instancegroup.AllocationPolicy.Zone)**

The minimum number of elements is 1. ||
|#

## Zone {#yandex.cloud.compute.v1.instancegroup.AllocationPolicy.Zone}

#|
||Field | Description ||
|| zoneId | **string** ||
|| instanceTagsPool[] | **string**

The string length in characters for each value must be 3-50. ||
|#

## LoadBalancerSpec {#yandex.cloud.compute.v1.instancegroup.LoadBalancerSpec}

#|
||Field | Description ||
|| targetGroupSpec | **[TargetGroupSpec](#yandex.cloud.compute.v1.instancegroup.TargetGroupSpec)** ||
|| maxOpeningTrafficDuration | **string** (duration) ||
|| ignoreHealthChecks | **boolean** ||
|#

## TargetGroupSpec {#yandex.cloud.compute.v1.instancegroup.TargetGroupSpec}

#|
||Field | Description ||
|| name | **string**

Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `. ||
|| description | **string**

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\@0-9a-z]* `. ||
|#

## HealthChecksSpec {#yandex.cloud.compute.v1.instancegroup.HealthChecksSpec}

#|
||Field | Description ||
|| healthCheckSpecs[] | **[HealthCheckSpec](#yandex.cloud.compute.v1.instancegroup.HealthCheckSpec)**

The minimum number of elements is 1. ||
|| maxCheckingHealthDuration | **string** (duration) ||
|#

## HealthCheckSpec {#yandex.cloud.compute.v1.instancegroup.HealthCheckSpec}

#|
||Field | Description ||
|| interval | **string** (duration) ||
|| timeout | **string** (duration) ||
|| unhealthyThreshold | **string** (int64) ||
|| healthyThreshold | **string** (int64) ||
|| tcpOptions | **[TcpOptions](#yandex.cloud.compute.v1.instancegroup.HealthCheckSpec.TcpOptions)**

Includes only one of the fields `tcpOptions`, `httpOptions`. ||
|| httpOptions | **[HttpOptions](#yandex.cloud.compute.v1.instancegroup.HealthCheckSpec.HttpOptions)**

Includes only one of the fields `tcpOptions`, `httpOptions`. ||
|#

## TcpOptions {#yandex.cloud.compute.v1.instancegroup.HealthCheckSpec.TcpOptions}

#|
||Field | Description ||
|| port | **string** (int64)

Acceptable values are 1 to 65535, inclusive. ||
|#

## HttpOptions {#yandex.cloud.compute.v1.instancegroup.HealthCheckSpec.HttpOptions}

#|
||Field | Description ||
|| port | **string** (int64)

Acceptable values are 1 to 65535, inclusive. ||
|| path | **string** ||
|#

## Variable {#yandex.cloud.compute.v1.instancegroup.Variable}

#|
||Field | Description ||
|| key | **string**

The string length in characters must be 1-128. Value must match the regular expression ` [a-zA-Z0-9._-]* `. ||
|| value | **string**

The maximum string length in characters is 128. ||
|#

## ApplicationLoadBalancerSpec {#yandex.cloud.compute.v1.instancegroup.ApplicationLoadBalancerSpec}

#|
||Field | Description ||
|| targetGroupSpec | **[ApplicationTargetGroupSpec](#yandex.cloud.compute.v1.instancegroup.ApplicationTargetGroupSpec)** ||
|| maxOpeningTrafficDuration | **string** (duration) ||
|| ignoreHealthChecks | **boolean** ||
|#

## ApplicationTargetGroupSpec {#yandex.cloud.compute.v1.instancegroup.ApplicationTargetGroupSpec}

#|
||Field | Description ||
|| name | **string** ||
|| description | **string** ||
|| labels | **object** (map<**string**, **string**>) ||
|#

## LoadBalancerState {#yandex.cloud.compute.v1.instancegroup.LoadBalancerState}

#|
||Field | Description ||
|| targetGroupId | **string** ||
|| statusMessage | **string** ||
|#

## ApplicationLoadBalancerState {#yandex.cloud.compute.v1.instancegroup.ApplicationLoadBalancerState}

#|
||Field | Description ||
|| targetGroupId | **string** ||
|| statusMessage | **string** ||
|#

## DisableZoneStatus {#yandex.cloud.compute.v1.instancegroup.DisableZoneStatus}

#|
||Field | Description ||
|| zoneId | **string** ||
|| disabledUntil | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#