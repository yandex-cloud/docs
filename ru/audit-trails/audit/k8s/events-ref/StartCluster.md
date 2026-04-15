---
editable: false
---

# Managed Services for Kubernetes Audit Trails Events: StartCluster

## Event JSON schema {#yandex.cloud.audit.k8s.StartCluster2-schema}

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
    "folderId": "string",
    "name": "string",
    "description": "string",
    "labels": "object",
    "status": "string",
    "health": "string",
    "networkId": "string",
    "master": {
      // Includes only one of the fields `zonalMaster`, `regionalMaster`
      "zonalMaster": {
        "zoneId": "string",
        "internalV4Address": "string",
        "externalV4Address": "string"
      },
      "regionalMaster": {
        "regionId": "string",
        "internalV4Address": "string",
        "externalV4Address": "string",
        "externalV6Address": "string"
      },
      // end of the list of possible fields
      "locations": [
        {
          "zoneId": "string",
          "subnetId": "string"
        }
      ],
      "etcdClusterSize": "string",
      "version": "string",
      "endpoints": {
        "internalV4Endpoint": "string",
        "externalV4Endpoint": "string",
        "externalV6Endpoint": "string"
      },
      "masterAuth": {
        "clusterCaCertificate": "string"
      },
      "versionInfo": {
        "currentVersion": "string",
        "newRevisionAvailable": "boolean",
        "newRevisionSummary": "string",
        "versionDeprecated": "boolean"
      },
      "maintenancePolicy": {
        "autoUpgrade": "boolean",
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
      "securityGroupIds": [
        "string"
      ],
      "masterLogging": {
        "enabled": "boolean",
        // Includes only one of the fields `logGroupId`, `folderId`
        "logGroupId": "string",
        "folderId": "string",
        // end of the list of possible fields
        "auditEnabled": "boolean",
        "clusterAutoscalerEnabled": "boolean",
        "kubeApiserverEnabled": "boolean",
        "eventsEnabled": "boolean"
      },
      "resources": {
        "cores": "string",
        "coreFraction": "string",
        "memory": "string"
      },
      "scalePolicy": {
        // Includes only one of the fields `fixedScale`, `autoScale`
        "fixedScale": {
          "resourcePresetId": "string"
        },
        "autoScale": {
          "minResourcePresetId": "string"
        }
        // end of the list of possible fields
      }
    },
    "ipAllocationPolicy": {
      "clusterIpv4CidrBlock": "string",
      "nodeIpv4CidrMaskSize": "string",
      "serviceIpv4CidrBlock": "string",
      "clusterIpv6CidrBlock": "string",
      "serviceIpv6CidrBlock": "string"
    },
    "serviceAccountId": "string",
    "nodeServiceAccountId": "string",
    "releaseChannel": "string",
    "networkPolicy": {
      "provider": "string"
    },
    "kmsProvider": {
      "keyId": "string"
    },
    // Includes only one of the fields `cilium`
    "cilium": {
      "routingMode": "string"
    },
    // end of the list of possible fields
    "scheduledMaintenance": {
      "delayedUntil": "string",
      "availableFrom": "string",
      "noLaterThan": "string",
      "description": "string"
    },
    "workloadIdentityFederation": {
      "enabled": "boolean",
      "issuer": "string",
      "jwksUri": "string"
    }
  },
  "requestParameters": "object",
  "response": "object"
}
```

## Field description {#yandex.cloud.audit.k8s.StartCluster2}

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
|| details | **[ClusterDetails](#yandex.cloud.audit.k8s.ClusterDetails)** ||
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

## ClusterDetails {#yandex.cloud.audit.k8s.ClusterDetails}

#|
||Field | Description ||
|| clusterId | **string** ||
|| folderId | **string** ||
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
|| health | **enum** (Health)

- `HEALTHY`
- `UNHEALTHY` ||
|| networkId | **string** ||
|| master | **[Master](#yandex.cloud.k8s.v1.Master)** ||
|| ipAllocationPolicy | **[IPAllocationPolicy](#yandex.cloud.k8s.v1.IPAllocationPolicy)** ||
|| serviceAccountId | **string** ||
|| nodeServiceAccountId | **string** ||
|| releaseChannel | **enum** (ReleaseChannel)

- `RAPID`
- `REGULAR`
- `STABLE` ||
|| networkPolicy | **[NetworkPolicy](#yandex.cloud.k8s.v1.NetworkPolicy)** ||
|| kmsProvider | **[KMSProvider](#yandex.cloud.k8s.v1.KMSProvider)** ||
|| cilium | **[Cilium](#yandex.cloud.k8s.v1.Cilium)**

Includes only one of the fields `cilium`. ||
|| scheduledMaintenance | **[ScheduledMaintenance](#yandex.cloud.k8s.v1.ScheduledMaintenance)** ||
|| workloadIdentityFederation | **[WorkloadIdentityFederation](#yandex.cloud.k8s.v1.WorkloadIdentityFederation)** ||
|#

## Master {#yandex.cloud.k8s.v1.Master}

#|
||Field | Description ||
|| zonalMaster | **[ZonalMaster](#yandex.cloud.k8s.v1.ZonalMaster)**

Includes only one of the fields `zonalMaster`, `regionalMaster`. ||
|| regionalMaster | **[RegionalMaster](#yandex.cloud.k8s.v1.RegionalMaster)**

Includes only one of the fields `zonalMaster`, `regionalMaster`. ||
|| locations[] | **[Location](#yandex.cloud.k8s.v1.Location)** ||
|| etcdClusterSize | **string** (int64) ||
|| version | **string** ||
|| endpoints | **[MasterEndpoints](#yandex.cloud.k8s.v1.MasterEndpoints)** ||
|| masterAuth | **[MasterAuth](#yandex.cloud.k8s.v1.MasterAuth)** ||
|| versionInfo | **[VersionInfo](#yandex.cloud.k8s.v1.VersionInfo)** ||
|| maintenancePolicy | **[MasterMaintenancePolicy](#yandex.cloud.k8s.v1.MasterMaintenancePolicy)** ||
|| securityGroupIds[] | **string** ||
|| masterLogging | **[MasterLogging](#yandex.cloud.k8s.v1.MasterLogging)** ||
|| resources | **[MasterResources](#yandex.cloud.k8s.v1.MasterResources)** ||
|| scalePolicy | **[MasterScalePolicy](#yandex.cloud.k8s.v1.MasterScalePolicy)** ||
|#

## ZonalMaster {#yandex.cloud.k8s.v1.ZonalMaster}

#|
||Field | Description ||
|| zoneId | **string** ||
|| internalV4Address | **string** ||
|| externalV4Address | **string** ||
|#

## RegionalMaster {#yandex.cloud.k8s.v1.RegionalMaster}

#|
||Field | Description ||
|| regionId | **string** ||
|| internalV4Address | **string** ||
|| externalV4Address | **string** ||
|| externalV6Address | **string** ||
|#

## Location {#yandex.cloud.k8s.v1.Location}

#|
||Field | Description ||
|| zoneId | **string** ||
|| subnetId | **string** ||
|#

## MasterEndpoints {#yandex.cloud.k8s.v1.MasterEndpoints}

#|
||Field | Description ||
|| internalV4Endpoint | **string** ||
|| externalV4Endpoint | **string** ||
|| externalV6Endpoint | **string** ||
|#

## MasterAuth {#yandex.cloud.k8s.v1.MasterAuth}

#|
||Field | Description ||
|| clusterCaCertificate | **string** ||
|#

## VersionInfo {#yandex.cloud.k8s.v1.VersionInfo}

#|
||Field | Description ||
|| currentVersion | **string** ||
|| newRevisionAvailable | **boolean** ||
|| newRevisionSummary | **string** ||
|| versionDeprecated | **boolean** ||
|#

## MasterMaintenancePolicy {#yandex.cloud.k8s.v1.MasterMaintenancePolicy}

#|
||Field | Description ||
|| autoUpgrade | **boolean** ||
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

## MasterLogging {#yandex.cloud.k8s.v1.MasterLogging}

#|
||Field | Description ||
|| enabled | **boolean** ||
|| logGroupId | **string**

Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.

Includes only one of the fields `logGroupId`, `folderId`. ||
|| folderId | **string**

Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.

Includes only one of the fields `logGroupId`, `folderId`. ||
|| auditEnabled | **boolean** ||
|| clusterAutoscalerEnabled | **boolean** ||
|| kubeApiserverEnabled | **boolean** ||
|| eventsEnabled | **boolean** ||
|#

## MasterResources {#yandex.cloud.k8s.v1.MasterResources}

#|
||Field | Description ||
|| cores | **string** (int64) ||
|| coreFraction | **string** (int64) ||
|| memory | **string** (int64) ||
|#

## MasterScalePolicy {#yandex.cloud.k8s.v1.MasterScalePolicy}

#|
||Field | Description ||
|| fixedScale | **[FixedScale](#yandex.cloud.k8s.v1.MasterScalePolicy.FixedScale)**

Includes only one of the fields `fixedScale`, `autoScale`. ||
|| autoScale | **[AutoScale](#yandex.cloud.k8s.v1.MasterScalePolicy.AutoScale)**

Includes only one of the fields `fixedScale`, `autoScale`. ||
|#

## FixedScale {#yandex.cloud.k8s.v1.MasterScalePolicy.FixedScale}

#|
||Field | Description ||
|| resourcePresetId | **string** ||
|#

## AutoScale {#yandex.cloud.k8s.v1.MasterScalePolicy.AutoScale}

#|
||Field | Description ||
|| minResourcePresetId | **string** ||
|#

## IPAllocationPolicy {#yandex.cloud.k8s.v1.IPAllocationPolicy}

#|
||Field | Description ||
|| clusterIpv4CidrBlock | **string** ||
|| nodeIpv4CidrMaskSize | **string** (int64) ||
|| serviceIpv4CidrBlock | **string** ||
|| clusterIpv6CidrBlock | **string** ||
|| serviceIpv6CidrBlock | **string** ||
|#

## NetworkPolicy {#yandex.cloud.k8s.v1.NetworkPolicy}

#|
||Field | Description ||
|| provider | **enum** (Provider)

- `CALICO` ||
|#

## KMSProvider {#yandex.cloud.k8s.v1.KMSProvider}

#|
||Field | Description ||
|| keyId | **string** ||
|#

## Cilium {#yandex.cloud.k8s.v1.Cilium}

#|
||Field | Description ||
|| routingMode | **enum** (RoutingMode)

- `TUNNEL` ||
|#

## ScheduledMaintenance {#yandex.cloud.k8s.v1.ScheduledMaintenance}

#|
||Field | Description ||
|| delayedUntil | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| availableFrom | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| noLaterThan | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| description | **string** ||
|#

## WorkloadIdentityFederation {#yandex.cloud.k8s.v1.WorkloadIdentityFederation}

#|
||Field | Description ||
|| enabled | **boolean** ||
|| issuer | **string** ||
|| jwksUri | **string** ||
|#