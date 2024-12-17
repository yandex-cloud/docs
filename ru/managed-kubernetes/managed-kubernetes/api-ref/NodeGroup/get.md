---
editable: false
sourcePath: en/_api-ref/k8s/v1/managed-kubernetes/api-ref/NodeGroup/get.md
---

# Managed Services for Kubernetes API, REST: NodeGroup.Get

Returns the specified node group.

To get the list of available node group, make a [List](/docs/managed-kubernetes/managed-kubernetes/api-ref/NodeGroup/list#List) request.

## HTTP request

```
GET https://mks.{{ api-host }}/managed-kubernetes/v1/nodeGroups/{nodeGroupId}
```

## Path parameters

#|
||Field | Description ||
|| nodeGroupId | **string**

Required field. ID of the node group to return.
To get the node group ID use a [NodeGroupService.List](/docs/managed-kubernetes/managed-kubernetes/api-ref/NodeGroup/list#List) request. ||
|#

## Response {#yandex.cloud.k8s.v1.NodeGroup}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "clusterId": "string",
  "createdAt": "string",
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
}
```

#|
||Field | Description ||
|| id | **string**

ID of the node group. ||
|| clusterId | **string**

ID of the cluster that the node group belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the node group.
The name is unique within the folder. ||
|| description | **string**

Description of the node group. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. Maximum of 64 per resource. ||
|| status | **enum** (Status)

Status of the node group.

- `STATUS_UNSPECIFIED`
- `PROVISIONING`: Node group is waiting for resources to be allocated.
- `RUNNING`: Node group is running.
- `RECONCILING`: Node group is waiting for some work to be done, such as upgrading node software.
- `STOPPING`: Node group is being stopped.
- `STOPPED`: Node group stopped.
- `DELETING`: Node group is being deleted.
- `STARTING`: Node group is being started. ||
|| nodeTemplate | **[NodeTemplate](#yandex.cloud.k8s.v1.NodeTemplate)**

Node template that specifies parameters of the compute instances for the node group. ||
|| scalePolicy | **[ScalePolicy](#yandex.cloud.k8s.v1.ScalePolicy)**

Scale policy of the node group.  For more information, see [Scaling policy](/docs/compute/concepts/instance-groups/policies#scale-policy). ||
|| allocationPolicy | **[NodeGroupAllocationPolicy](#yandex.cloud.k8s.v1.NodeGroupAllocationPolicy)**

Allocation policy by which resources for node group are allocated to zones and regions. ||
|| deployPolicy | **[DeployPolicy](#yandex.cloud.k8s.v1.DeployPolicy)**

Deploy policy according to which the updates are rolled out. ||
|| instanceGroupId | **string**

ID of the managed instance group associated with this node group. ||
|| nodeVersion | **string**

Version of Kubernetes components that runs on the nodes.
Deprecated. Use version_info.current_version. ||
|| versionInfo | **[VersionInfo](#yandex.cloud.k8s.v1.VersionInfo)**

Detailed information about the Kubernetes version that is running on the node. ||
|| maintenancePolicy | **[NodeGroupMaintenancePolicy](#yandex.cloud.k8s.v1.NodeGroupMaintenancePolicy)**

Maintenance policy of the node group. ||
|| allowedUnsafeSysctls[] | **string**

Support for unsafe sysctl parameters. For more details see [documentation](https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/). ||
|| nodeTaints[] | **[Taint](#yandex.cloud.k8s.v1.Taint)**

Taints that are applied to the nodes of the node group at creation time. ||
|| nodeLabels | **object** (map<**string**, **string**>)

Labels that are assigned to the nodes of the node group at creation time. ||
|#

## NodeTemplate {#yandex.cloud.k8s.v1.NodeTemplate}

#|
||Field | Description ||
|| name | **string**

Name of the instance.
In order to be unique it must contain at least on of instance unique placeholders:
{instance.short_id}
{instance.index}
combination of {instance.zone_id} and {instance.index_in_zone}
Example: my-instance-{instance.index}
If not set, default is used: {instance_group.id}-{instance.short_id}
It may also contain another placeholders, see metadata doc for full list. ||
|| labels | **object** (map<**string**, **string**>)

these labels will be assigned to compute nodes (instances), created by the nodegroup ||
|| platformId | **string**

ID of the hardware platform configuration for the node. ||
|| resourcesSpec | **[ResourcesSpec](#yandex.cloud.k8s.v1.ResourcesSpec)**

Computing resources of the node such as the amount of memory and number of cores. ||
|| bootDiskSpec | **[DiskSpec](#yandex.cloud.k8s.v1.DiskSpec)**

Specification for the boot disk that will be attached to the node. ||
|| metadata | **object** (map<**string**, **string**>)

The metadata as `key:value` pairs assigned to this instance template. Only SSH keys are supported as metadata.

For more information, see [Connecting to a node over SSH](/docs/managed-kubernetes/operations/node-connect-ssh). ||
|| v4AddressSpec | **[NodeAddressSpec](#yandex.cloud.k8s.v1.NodeAddressSpec)**

Specification for the create network interfaces for the node group compute instances.
Deprecated, please use network_interface_specs. ||
|| schedulingPolicy | **[SchedulingPolicy](#yandex.cloud.k8s.v1.SchedulingPolicy)**

Scheduling policy configuration. ||
|| networkInterfaceSpecs[] | **[NetworkInterfaceSpec](#yandex.cloud.k8s.v1.NetworkInterfaceSpec)**

New api, to specify network interfaces for the node group compute instances.
Can not be used together with 'v4_address_spec' ||
|| placementPolicy | **[PlacementPolicy](#yandex.cloud.k8s.v1.PlacementPolicy)** ||
|| networkSettings | **[NetworkSettings](#yandex.cloud.k8s.v1.NodeTemplate.NetworkSettings)**

this parameter allows to specify type of network acceleration used on nodes (instances) ||
|| containerRuntimeSettings | **[ContainerRuntimeSettings](#yandex.cloud.k8s.v1.NodeTemplate.ContainerRuntimeSettings)** ||
|| containerNetworkSettings | **[ContainerNetworkSettings](#yandex.cloud.k8s.v1.NodeTemplate.ContainerNetworkSettings)** ||
|| gpuSettings | **[GpuSettings](#yandex.cloud.k8s.v1.GpuSettings)**

GPU settings ||
|#

## ResourcesSpec {#yandex.cloud.k8s.v1.ResourcesSpec}

#|
||Field | Description ||
|| memory | **string** (int64)

Amount of memory available to the node, specified in bytes. ||
|| cores | **string** (int64)

Number of cores available to the node. ||
|| coreFraction | **string** (int64)

Baseline level of CPU performance with the possibility to burst performance above that baseline level.
This field sets baseline performance for each core. ||
|| gpus | **string** (int64)

Number of GPUs available to the node. ||
|#

## DiskSpec {#yandex.cloud.k8s.v1.DiskSpec}

#|
||Field | Description ||
|| diskTypeId | **string**

ID of the disk type. ||
|| diskSize | **string** (int64)

Size of the disk, specified in bytes. ||
|#

## NodeAddressSpec {#yandex.cloud.k8s.v1.NodeAddressSpec}

#|
||Field | Description ||
|| oneToOneNatSpec | **[OneToOneNatSpec](#yandex.cloud.k8s.v1.OneToOneNatSpec)**

One-to-one NAT configuration. Setting up one-to-one NAT ensures that public IP addresses are assigned to nodes, and therefore internet is accessible for all nodes of the node group. If the field is not set, NAT will not be set up. ||
|| dnsRecordSpecs[] | **[DnsRecordSpec](#yandex.cloud.k8s.v1.DnsRecordSpec)**

Internal DNS configuration. ||
|#

## OneToOneNatSpec {#yandex.cloud.k8s.v1.OneToOneNatSpec}

#|
||Field | Description ||
|| ipVersion | **enum** (IpVersion)

IP version for the public IP address.

- `IP_VERSION_UNSPECIFIED`
- `IPV4`: IPv4 address, for example 192.168.0.0.
- `IPV6`: IPv6 address, not available yet. ||
|#

## DnsRecordSpec {#yandex.cloud.k8s.v1.DnsRecordSpec}

#|
||Field | Description ||
|| fqdn | **string**

Required field. FQDN (required). ||
|| dnsZoneId | **string**

DNS zone id (optional, if not set, private zone is used). ||
|| ttl | **string** (int64)

DNS record ttl, values in 0-86400 (optional). ||
|| ptr | **boolean**

When set to true, also create PTR DNS record (optional). ||
|#

## SchedulingPolicy {#yandex.cloud.k8s.v1.SchedulingPolicy}

#|
||Field | Description ||
|| preemptible | **boolean**

True for preemptible compute instances. Default value is false. Preemptible compute instances are stopped at least once every 24 hours, and can be stopped at any time
if their resources are needed by Compute.
For more information, see [Preemptible Virtual Machines](/docs/compute/concepts/preemptible-vm). ||
|#

## NetworkInterfaceSpec {#yandex.cloud.k8s.v1.NetworkInterfaceSpec}

#|
||Field | Description ||
|| subnetIds[] | **string**

IDs of the subnets. ||
|| primaryV4AddressSpec | **[NodeAddressSpec](#yandex.cloud.k8s.v1.NodeAddressSpec)**

Primary IPv4 address that is assigned to the instance for this network interface. ||
|| primaryV6AddressSpec | **[NodeAddressSpec](#yandex.cloud.k8s.v1.NodeAddressSpec)**

Primary IPv6 address that is assigned to the instance for this network interface. ||
|| securityGroupIds[] | **string**

IDs of security groups. ||
|#

## PlacementPolicy {#yandex.cloud.k8s.v1.PlacementPolicy}

#|
||Field | Description ||
|| placementGroupId | **string**

Identifier of placement group ||
|#

## NetworkSettings {#yandex.cloud.k8s.v1.NodeTemplate.NetworkSettings}

#|
||Field | Description ||
|| type | **enum** (Type)

Required field. 

- `TYPE_UNSPECIFIED`
- `STANDARD`
- `SOFTWARE_ACCELERATED` ||
|#

## ContainerRuntimeSettings {#yandex.cloud.k8s.v1.NodeTemplate.ContainerRuntimeSettings}

#|
||Field | Description ||
|| type | **enum** (Type)

Required field. 

- `TYPE_UNSPECIFIED`
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
|| gpuClusterId | **string**

GPU cluster id, that mk8s node will join. ||
|| gpuEnvironment | **enum** (GpuEnvironment)

GPU environment configured on node.

- `GPU_ENVIRONMENT_UNSPECIFIED`: Use one of the values below, depending on the default for the specific Cloud installation.
- `RUNC_DRIVERS_CUDA`: Use a node image with the pre-installed GPU toolkit, drivers and CUDA.
- `RUNC`: Use a node image with the pre-installed GPU toolkit but without drivers.
You should install drivers on a node yourself in that case.
There are tools to help you to do that, for example gpu-operator. ||
|#

## ScalePolicy {#yandex.cloud.k8s.v1.ScalePolicy}

#|
||Field | Description ||
|| fixedScale | **[FixedScale](#yandex.cloud.k8s.v1.ScalePolicy.FixedScale)**

Fixed scale policy of the node group.

Includes only one of the fields `fixedScale`, `autoScale`. ||
|| autoScale | **[AutoScale](#yandex.cloud.k8s.v1.ScalePolicy.AutoScale)**

Auto scale policy of the node group.

Includes only one of the fields `fixedScale`, `autoScale`. ||
|#

## FixedScale {#yandex.cloud.k8s.v1.ScalePolicy.FixedScale}

#|
||Field | Description ||
|| size | **string** (int64)

Number of nodes in the node group. ||
|#

## AutoScale {#yandex.cloud.k8s.v1.ScalePolicy.AutoScale}

#|
||Field | Description ||
|| minSize | **string** (int64)

Minimum number of nodes in the node group. ||
|| maxSize | **string** (int64)

Maximum number of nodes in the node group. ||
|| initialSize | **string** (int64)

Initial number of nodes in the node group. ||
|#

## NodeGroupAllocationPolicy {#yandex.cloud.k8s.v1.NodeGroupAllocationPolicy}

#|
||Field | Description ||
|| locations[] | **[NodeGroupLocation](#yandex.cloud.k8s.v1.NodeGroupLocation)**

List of locations where resources for the node group will be allocated. ||
|#

## NodeGroupLocation {#yandex.cloud.k8s.v1.NodeGroupLocation}

#|
||Field | Description ||
|| zoneId | **string**

Required field. ID of the availability zone where the nodes may reside. ||
|| subnetId | **string**

ID of the subnet. If a network chosen for the Kubernetes cluster has only one subnet in the specified zone, subnet ID may be omitted. ||
|#

## DeployPolicy {#yandex.cloud.k8s.v1.DeployPolicy}

#|
||Field | Description ||
|| maxUnavailable | **string** (int64)

The maximum number of running instances that can be taken offline (i.e.,
stopped or deleted) at the same time during the update process.
If `maxExpansion` is not specified or set to zero, `maxUnavailable` must
be set to a non-zero value. ||
|| maxExpansion | **string** (int64)

The maximum number of instances that can be temporarily allocated above
the group's target size during the update process.
If `maxUnavailable` is not specified or set to zero, `maxExpansion` must
be set to a non-zero value. ||
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

## NodeGroupMaintenancePolicy {#yandex.cloud.k8s.v1.NodeGroupMaintenancePolicy}

#|
||Field | Description ||
|| autoUpgrade | **boolean**

If set to true, automatic updates are installed in the specified period of time with no interaction from the user.
If set to false, automatic upgrades are disabled. ||
|| autoRepair | **boolean**

If set to true, automatic repairs are enabled. Default value is false. ||
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

## Taint {#yandex.cloud.k8s.v1.Taint}

#|
||Field | Description ||
|| key | **string**

The taint key to be applied to a node. ||
|| value | **string**

The taint value corresponding to the taint key. ||
|| effect | **enum** (Effect)

The effect of the taint on pods that do not tolerate the taint.

- `EFFECT_UNSPECIFIED`
- `NO_SCHEDULE`: Do not allow new pods to schedule onto the node unless they tolerate the taint,
but allow all pods submitted to Kubelet without going through the scheduler
to start, and allow all already-running pods to continue running.
- `PREFER_NO_SCHEDULE`: Like NO_SCHEDULE, but the scheduler tries not to schedule
new pods onto the node, rather than prohibiting new pods from scheduling
onto the node entirely. Enforced by the scheduler.
- `NO_EXECUTE`: Evict any already-running pods that do not tolerate the taint. ||
|#