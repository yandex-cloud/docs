---
editable: false
apiPlayground:
  - url: https://mks.{{ api-host }}/managed-kubernetes/v1/clusters/{clusterId}
    method: get
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the Kubernetes cluster to return.
          type: string
      required:
        - clusterId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/k8s/v1/managed-kubernetes/api-ref/Cluster/get.md
---

# Managed Services for Kubernetes API, REST: Cluster.Get

Returns the specified Kubernetes cluster.

To get the list of available Kubernetes cluster, make a [List](/docs/managed-kubernetes/managed-kubernetes/api-ref/Cluster/list#List) request.

## HTTP request

```
GET https://mks.{{ api-host }}/managed-kubernetes/v1/clusters/{clusterId}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Kubernetes cluster to return. ||
|#

## Response {#yandex.cloud.k8s.v1.Cluster}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
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
  // Includes only one of the fields `gatewayIpv4Address`
  "gatewayIpv4Address": "string",
  // end of the list of possible fields
  "serviceAccountId": "string",
  "nodeServiceAccountId": "string",
  "releaseChannel": "string",
  "networkPolicy": {
    "provider": "string"
  },
  "kmsProvider": {
    "keyId": "string"
  },
  "logGroupId": "string",
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
  }
}
```

A Kubernetes cluster.

#|
||Field | Description ||
|| id | **string**

ID of the Kubernetes cluster. ||
|| folderId | **string**

ID of the folder that the Kubernetes cluster belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the Kubernetes cluster. ||
|| description | **string**

Description of the Kubernetes cluster. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. Maximum of 64 per resource. ||
|| status | **enum** (Status)

Status of the Kubernetes cluster.

- `STATUS_UNSPECIFIED`
- `PROVISIONING`: Kubernetes cluster is waiting for resources to be allocated.
- `RUNNING`: Kubernetes cluster is running.
- `RECONCILING`: Kubernetes cluster is being reconciled.
- `STOPPING`: Kubernetes cluster is being stopped.
- `STOPPED`: Kubernetes cluster stopped.
- `DELETING`: Kubernetes cluster is being deleted.
- `STARTING`: Kubernetes cluster is being started. ||
|| health | **enum** (Health)

Health of the Kubernetes cluster.

- `HEALTH_UNSPECIFIED`
- `HEALTHY`: Kubernetes cluster is alive and well.
- `UNHEALTHY`: Kubernetes cluster is inoperable. ||
|| networkId | **string**

ID of the network the Kubernetes cluster belongs to. ||
|| master | **[Master](#yandex.cloud.k8s.v1.Master)**

Properties of the master for the Kubernetes cluster. ||
|| ipAllocationPolicy | **[IPAllocationPolicy](#yandex.cloud.k8s.v1.IPAllocationPolicy)**

Allocation policy for IP addresses of services and pods inside the Kubernetes cluster in different availability zones. ||
|| gatewayIpv4Address | **string**

Gateway IPv4 address.

Includes only one of the fields `gatewayIpv4Address`. ||
|| serviceAccountId | **string**

Service account to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster. ||
|| nodeServiceAccountId | **string**

Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics. ||
|| releaseChannel | **enum** (ReleaseChannel)

When creating a Kubernetes cluster, you should specify one of three release channels. The release channel contains several Kubernetes versions.
Channels differ in the set of available versions, the management of auto-updates, and the updates received.
You can't change the channel once the Kubernetes cluster is created, you can only recreate the Kubernetes cluster and specify a new release channel.
For more details see [documentation](/docs/managed-kubernetes/concepts/release-channels-and-updates).

- `RELEASE_CHANNEL_UNSPECIFIED`
- `RAPID`: Minor updates with new functions and improvements are often added.
You can't disable automatic updates in this channel, but you can specify a time period for automatic updates.
- `REGULAR`: New functions and improvements are added in chunks shortly after they appear on `RAPID`.
- `STABLE`: Only updates related to bug fixes or security improvements are added. ||
|| networkPolicy | **[NetworkPolicy](#yandex.cloud.k8s.v1.NetworkPolicy)** ||
|| kmsProvider | **[KMSProvider](#yandex.cloud.k8s.v1.KMSProvider)**

KMS provider configuration. ||
|| logGroupId | **string**

Log group where cluster stores cluster system logs, like audit, events, or controlplane logs. ||
|| cilium | **[Cilium](#yandex.cloud.k8s.v1.Cilium)**

Includes only one of the fields `cilium`. ||
|| scheduledMaintenance | **[ScheduledMaintenance](#yandex.cloud.k8s.v1.ScheduledMaintenance)** ||
|#

## Master {#yandex.cloud.k8s.v1.Master}

#|
||Field | Description ||
|| zonalMaster | **[ZonalMaster](#yandex.cloud.k8s.v1.ZonalMaster)**

Parameters of the availability zone for the master.

Includes only one of the fields `zonalMaster`, `regionalMaster`. ||
|| regionalMaster | **[RegionalMaster](#yandex.cloud.k8s.v1.RegionalMaster)**

Parameters of the region for the master.

Includes only one of the fields `zonalMaster`, `regionalMaster`. ||
|| locations[] | **[Location](#yandex.cloud.k8s.v1.Location)**

Locations specification for Kubernetes control-plane (master) instances. ||
|| etcdClusterSize | **string** (int64)

Number of etcd nodes in cluster. ||
|| version | **string**

Version of Kubernetes components that runs on the master. ||
|| endpoints | **[MasterEndpoints](#yandex.cloud.k8s.v1.MasterEndpoints)**

Endpoints of the master. Endpoints constitute of scheme and port (i.e. `https://ip-address:port`)
and can be used by the clients to communicate with the Kubernetes API of the Kubernetes cluster. ||
|| masterAuth | **[MasterAuth](#yandex.cloud.k8s.v1.MasterAuth)**

Master authentication parameters are used to establish trust between the master and a client. ||
|| versionInfo | **[VersionInfo](#yandex.cloud.k8s.v1.VersionInfo)**

Detailed information about the Kubernetes version that is running on the master. ||
|| maintenancePolicy | **[MasterMaintenancePolicy](#yandex.cloud.k8s.v1.MasterMaintenancePolicy)**

Maintenance policy of the master. ||
|| securityGroupIds[] | **string**

Master security groups. ||
|| masterLogging | **[MasterLogging](#yandex.cloud.k8s.v1.MasterLogging)**

Cloud Logging for master components. ||
|| resources | **[MasterResources](#yandex.cloud.k8s.v1.MasterResources)**

Computing resources of each master instance such as the amount of memory and number of cores. ||
|| scalePolicy | **[MasterScalePolicy](#yandex.cloud.k8s.v1.MasterScalePolicy)**

Scale policy of the master. ||
|#

## ZonalMaster {#yandex.cloud.k8s.v1.ZonalMaster}

#|
||Field | Description ||
|| zoneId | **string**

ID of the availability zone where the master resides. ||
|| internalV4Address | **string**

IPv4 internal network address that is assigned to the master. ||
|| externalV4Address | **string**

IPv4 external network address that is assigned to the master. ||
|#

## RegionalMaster {#yandex.cloud.k8s.v1.RegionalMaster}

#|
||Field | Description ||
|| regionId | **string**

ID of the region where the master resides. ||
|| internalV4Address | **string**

IPv4 internal network address that is assigned to the master. ||
|| externalV4Address | **string**

IPv4 external network address that is assigned to the master. ||
|| externalV6Address | **string**

IPv6 external network address that is assigned to the master. ||
|#

## Location {#yandex.cloud.k8s.v1.Location}

#|
||Field | Description ||
|| zoneId | **string**

ID of the availability zone where the master resides. ||
|| subnetId | **string**

ID of the VPC network's subnet where the master resides. ||
|#

## MasterEndpoints {#yandex.cloud.k8s.v1.MasterEndpoints}

#|
||Field | Description ||
|| internalV4Endpoint | **string**

Internal endpoint that can be used to connect to the master from cloud networks. ||
|| externalV4Endpoint | **string**

External endpoint that can be used to access Kubernetes cluster API from the internet (outside of the cloud). ||
|| externalV6Endpoint | **string**

External IPv6 endpoint that can be used to access Kubernetes cluster API from the internet (outside of the cloud). ||
|#

## MasterAuth {#yandex.cloud.k8s.v1.MasterAuth}

#|
||Field | Description ||
|| clusterCaCertificate | **string**

PEM-encoded public certificate that is the root of trust for the Kubernetes cluster. ||
|#

## VersionInfo {#yandex.cloud.k8s.v1.VersionInfo}

#|
||Field | Description ||
|| currentVersion | **string**

Current Kubernetes version, format: major.minor (e.g. 1.15). ||
|| newRevisionAvailable | **boolean**

Newer revisions may include Kubernetes patches (e.g 1.15.1 -> 1.15.2) as well
as some internal component updates - new features or bug fixes in platform specific
components either on the master or nodes. ||
|| newRevisionSummary | **string**

Description of the changes to be applied when updating to the latest
revision. Empty if new_revision_available is false. ||
|| versionDeprecated | **boolean**

The current version is on the deprecation schedule, component (master or node group)
should be upgraded. ||
|#

## MasterMaintenancePolicy {#yandex.cloud.k8s.v1.MasterMaintenancePolicy}

#|
||Field | Description ||
|| autoUpgrade | **boolean**

If set to true, automatic updates are installed in the specified period of time with no interaction from the user.
If set to false, automatic upgrades are disabled. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.k8s.v1.MaintenanceWindow)**

Maintenance window settings. Update will start at the specified time and last no more than the specified duration.
The time is set in UTC. ||
|#

## MaintenanceWindow {#yandex.cloud.k8s.v1.MaintenanceWindow}

#|
||Field | Description ||
|| anytime | **object**

Updating the master at any time.

Includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`.

Maintenance policy. ||
|| dailyMaintenanceWindow | **[DailyMaintenanceWindow](#yandex.cloud.k8s.v1.DailyMaintenanceWindow)**

Updating the master on any day during the specified time window.

Includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`.

Maintenance policy. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.k8s.v1.WeeklyMaintenanceWindow)**

Updating the master on selected days during the specified time window.

Includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`.

Maintenance policy. ||
|#

## DailyMaintenanceWindow {#yandex.cloud.k8s.v1.DailyMaintenanceWindow}

#|
||Field | Description ||
|| startTime | **[TimeOfDay](#google.type.TimeOfDay)**

Required field. Window start time, in the UTC timezone. ||
|| duration | **string** (duration)

Window duration. ||
|#

## TimeOfDay {#google.type.TimeOfDay}

Represents a time of day. The date and time zone are either not significant
or are specified elsewhere. An API may choose to allow leap seconds. Related
types are [google.type.Date](https://github.com/googleapis/googleapis/blob/master/google/type/date.proto) and [google.protobuf.Timestamp](https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto).

#|
||Field | Description ||
|| hours | **integer** (int32)

Hours of day in 24 hour format. Should be from 0 to 23. An API may choose
to allow the value "24:00:00" for scenarios like business closing time. ||
|| minutes | **integer** (int32)

Minutes of hour of day. Must be from 0 to 59. ||
|| seconds | **integer** (int32)

Seconds of minutes of the time. Must normally be from 0 to 59. An API may
allow the value 60 if it allows leap-seconds. ||
|| nanos | **integer** (int32)

Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.k8s.v1.WeeklyMaintenanceWindow}

#|
||Field | Description ||
|| daysOfWeek[] | **[DaysOfWeekMaintenanceWindow](#yandex.cloud.k8s.v1.DaysOfWeekMaintenanceWindow)**

Days of the week and the maintenance window for these days when automatic updates are allowed. ||
|#

## DaysOfWeekMaintenanceWindow {#yandex.cloud.k8s.v1.DaysOfWeekMaintenanceWindow}

#|
||Field | Description ||
|| days[] | **enum** (DayOfWeek)

Days of the week when automatic updates are allowed.

- `DAY_OF_WEEK_UNSPECIFIED`: The unspecified day-of-week.
- `MONDAY`: The day-of-week of Monday.
- `TUESDAY`: The day-of-week of Tuesday.
- `WEDNESDAY`: The day-of-week of Wednesday.
- `THURSDAY`: The day-of-week of Thursday.
- `FRIDAY`: The day-of-week of Friday.
- `SATURDAY`: The day-of-week of Saturday.
- `SUNDAY`: The day-of-week of Sunday. ||
|| startTime | **[TimeOfDay](#google.type.TimeOfDay)**

Required field. Window start time, in the UTC timezone. ||
|| duration | **string** (duration)

Window duration. ||
|#

## MasterLogging {#yandex.cloud.k8s.v1.MasterLogging}

#|
||Field | Description ||
|| enabled | **boolean**

Identifies whether Cloud Logging is enabled for master components. ||
|| logGroupId | **string**

ID of the log group where logs of master components should be stored.

Includes only one of the fields `logGroupId`, `folderId`.

The destination of master components' logs. ||
|| folderId | **string**

ID of the folder where logs should be stored (in default group).

Includes only one of the fields `logGroupId`, `folderId`.

The destination of master components' logs. ||
|| auditEnabled | **boolean**

Identifies whether Cloud Logging is enabled for audit logs. ||
|| clusterAutoscalerEnabled | **boolean**

Identifies whether Cloud Logging is enabled for cluster-autoscaler. ||
|| kubeApiserverEnabled | **boolean**

Identifies whether Cloud Logging is enabled for kube-apiserver. ||
|| eventsEnabled | **boolean**

Identifies whether Cloud Logging is enabled for events. ||
|#

## MasterResources {#yandex.cloud.k8s.v1.MasterResources}

#|
||Field | Description ||
|| cores | **string** (int64)

The number of cores available to each master instance. ||
|| coreFraction | **string** (int64)

Baseline level of CPU performance with the ability to burst performance above that baseline level.
This field sets baseline performance for each core. ||
|| memory | **string** (int64)

The amount of memory available to each master instance, specified in bytes. ||
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

Fixed master instance resources.

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of computing resources preset to be used by master. ||
|#

## AutoScale {#yandex.cloud.k8s.v1.MasterScalePolicy.AutoScale}

Autoscaled master instance resources.

#|
||Field | Description ||
|| minResourcePresetId | **string**

ID of computing resources preset to be used as lower boundary for scaling. ||
|#

## IPAllocationPolicy {#yandex.cloud.k8s.v1.IPAllocationPolicy}

#|
||Field | Description ||
|| clusterIpv4CidrBlock | **string**

CIDR block. IP range for allocating pod addresses.

It should not overlap with any subnet in the network the Kubernetes cluster located in. Static routes will be
set up for this CIDR blocks in node subnets. ||
|| nodeIpv4CidrMaskSize | **string** (int64)

Size of the masks that are assigned for each node in the cluster.

If not specified, 24 is used. ||
|| serviceIpv4CidrBlock | **string**

CIDR block. IP range Kubernetes service Kubernetes cluster IP addresses will be allocated from.

It should not overlap with any subnet in the network the Kubernetes cluster located in. ||
|| clusterIpv6CidrBlock | **string**

IPv6 range for allocating pod IP addresses. ||
|| serviceIpv6CidrBlock | **string**

IPv6 range for allocating Kubernetes service IP addresses ||
|#

## NetworkPolicy {#yandex.cloud.k8s.v1.NetworkPolicy}

#|
||Field | Description ||
|| provider | **enum** (Provider)

- `PROVIDER_UNSPECIFIED`
- `CALICO` ||
|#

## KMSProvider {#yandex.cloud.k8s.v1.KMSProvider}

#|
||Field | Description ||
|| keyId | **string**

KMS key ID for secrets encryption.
To obtain a KMS key ID use a [yandex.cloud.kms.v1.SymmetricKeyService.List](/docs/kms/api-ref/SymmetricKey/list#List) request. ||
|#

## Cilium {#yandex.cloud.k8s.v1.Cilium}

#|
||Field | Description ||
|| routingMode | **enum** (RoutingMode)

- `ROUTING_MODE_UNSPECIFIED`
- `TUNNEL` ||
|#

## ScheduledMaintenance {#yandex.cloud.k8s.v1.ScheduledMaintenance}

#|
||Field | Description ||
|| delayedUntil | **string** (date-time)

Time until which the update should be postponed.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| availableFrom | **string** (date-time)

Time when the update became available.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| noLaterThan | **string** (date-time)

The latest possible date by which a mandatory update must be applied.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| description | **string**

Description of the planned operation, for example, "Infrastructure planned update". ||
|#