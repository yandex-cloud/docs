[Документация Yandex Cloud](../../../../index.md) > [Yandex Compute Cloud](../../../index.md) > Справочник API > REST (англ.) > [Compute Cloud Instance Groups API](../index.md) > [InstanceGroup](index.md) > Get

# Compute Cloud Instance Groups API, REST: InstanceGroup.Get

Returns the specified InstanceGroup resource.
To get the list of available InstanceGroup resources, make a [List](list.md#List) request.

## HTTP request

```
GET https://compute.api.cloud.yandex.net/compute/v1/instanceGroups/{instanceGroupId}
```

## Path parameters

#|
||Field | Description ||
|| instanceGroupId | **string**

Required field. ID of the InstanceGroup resource to return.
To get the instance group ID, use a [InstanceGroupService.List](list.md#List) request.
The length must be less than or equal to 50.
This field is required. ||
|#

## Query parameters {#yandex.cloud.compute.v1.instancegroup.GetInstanceGroupRequest}

#|
||Field | Description ||
|| view | **enum** (InstanceGroupView)

Defines which information about the Instance template should be returned in the server response.

- `BASIC`: Doesn't include the metadata of the instance template in the server response.
- `FULL`: Returns the metadata of the instance template in the server response. ||
|#

## Response {#yandex.cloud.compute.v1.instancegroup.InstanceGroup}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
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
        "securityGroupIds": [
          "string"
        ]
      }
    ],
    "schedulingPolicy": {
      "preemptible": "boolean"
    },
    "serviceAccountId": "string",
    "name": "string",
    "hostname": "string",
    "networkSettings": {
      "type": "string"
    },
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
    "reservedInstancePoolId": "string",
    "metadataOptions": {
      "gceHttpEndpoint": "string",
      "awsV1HttpEndpoint": "string",
      "gceHttpToken": "string",
      "awsV1HttpToken": "string",
      "awsV2HttpEndpoint": "string",
      "awsV2HttpToken": "string"
    }
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
  "loadBalancerState": {
    "targetGroupId": "string",
    "statusMessage": "string"
  },
  "managedInstancesState": {
    "targetSize": "string",
    "runningActualCount": "string",
    "runningOutdatedCount": "string",
    "processingCount": "string"
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
  "applicationLoadBalancerState": {
    "targetGroupId": "string",
    "statusMessage": "string"
  },
  "autoHealingPolicy": {
    "autoHealingAction": "string"
  },
  "disableZoneStatuses": [
    {
      "zoneId": "string",
      "disabledUntil": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| id | **string**

ID of the instance group. ||
|| folderId | **string**

ID of the folder that the instance group belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the instance group.
The name is unique within the folder. ||
|| description | **string**

Description of the instance group. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|| instanceTemplate | **[InstanceTemplate](#yandex.cloud.compute.v1.instancegroup.InstanceTemplate)**

Instance template for creating the instance group.
For more information, see [Instance Templates](../../../concepts/instance-groups/instance-template.md). ||
|| scalePolicy | **[ScalePolicy](#yandex.cloud.compute.v1.instancegroup.ScalePolicy)**

[Scaling policy](../../../concepts/instance-groups/scale.md) of the instance group. ||
|| deployPolicy | **[DeployPolicy](#yandex.cloud.compute.v1.instancegroup.DeployPolicy)**

Deployment policy of the instance group. ||
|| allocationPolicy | **[AllocationPolicy](#yandex.cloud.compute.v1.instancegroup.AllocationPolicy)**

Allocation policy of the instance group by zones and regions. ||
|| loadBalancerState | **[LoadBalancerState](#yandex.cloud.compute.v1.instancegroup.LoadBalancerState)**

Status of the Network Load Balancer target group attributed to the instance group. ||
|| managedInstancesState | **[ManagedInstancesState](#yandex.cloud.compute.v1.instancegroup.ManagedInstancesState)**

States of instances for this instance group. ||
|| loadBalancerSpec | **[LoadBalancerSpec](#yandex.cloud.compute.v1.instancegroup.LoadBalancerSpec)**

Settings for balancing load between instances via [Network Load Balancer](../../../../network-load-balancer/concepts/index.md)
(OSI model layer 3). ||
|| healthChecksSpec | **[HealthChecksSpec](#yandex.cloud.compute.v1.instancegroup.HealthChecksSpec)**

Health checking specification. For more information, see [Health check](../../../../network-load-balancer/concepts/health-check.md). ||
|| serviceAccountId | **string**

ID of the service account. The service account will be used for all API calls
made by the Instance Groups component on behalf of the user (for example, creating instances, adding them to load balancer target group, etc.). For more information, see [Service accounts](../../../../iam/concepts/users/service-accounts.md).
To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](../../../../iam/api-ref/ServiceAccount/list.md#List) request. ||
|| status | **enum** (Status)

Status of the instance group.

- `STARTING`: Instance group is being started and will become active soon.
- `ACTIVE`: Instance group is active.
In this state the group manages its instances and monitors their health,
creating, deleting, stopping, updating and starting instances as needed.
To stop the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Stop](stop.md#Stop).
To pause the processes in the instance group, i.e. scaling, checking instances' health,
auto-healing and updating them, without stopping the instances,
call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.PauseProcesses](pauseProcesses.md#PauseProcesses).
- `STOPPING`: Instance group is being stopped.
Group's instances stop receiving traffic from the load balancer (if any) and are then stopped.
- `STOPPED`: Instance group is stopped.
In this state the group cannot be updated and does not react to any changes made to its instances.
To start the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Start](start.md#Start).
- `DELETING`: Instance group is being deleted.
- `PAUSED`: Instance group is paused.
In this state all the processes regarding the group management, i.e. scaling, checking instances' health,
auto-healing and updating them, are paused. The instances that were running prior to pausing the group, however,
may still be running.
To resume the processes in the instance group,
call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.ResumeProcesses](resumeProcesses.md#ResumeProcesses).
The group status will change to `ACTIVE`. ||
|| variables[] | **[Variable](#yandex.cloud.compute.v1.instancegroup.Variable)**

User-defined [variables](docs/compute/concepts/instance-groups/variables-in-the-template) for instance template rendering. ||
|| deletionProtection | **boolean**

Flag prohibiting deletion of the instance group.
Allowed values:</br>- `false`: The instance group can be deleted.</br>- `true`: The instance group cannot be deleted.
The default is `false`. ||
|| applicationLoadBalancerSpec | **[ApplicationLoadBalancerSpec](#yandex.cloud.compute.v1.instancegroup.ApplicationLoadBalancerSpec)**

Settings for balancing load between instances via [Application Load Balancer](../../../../application-load-balancer/concepts/index.md)
(OSI model layer 7). ||
|| applicationLoadBalancerState | **[ApplicationLoadBalancerState](#yandex.cloud.compute.v1.instancegroup.ApplicationLoadBalancerState)**

Status of the Application Load Balancer target group attributed to the instance group.
Returned if there is a working load balancer that the target group is connected to. ||
|| autoHealingPolicy | **[AutoHealingPolicy](#yandex.cloud.compute.v1.instancegroup.AutoHealingPolicy)**

AutoHealingPolicy policy of the instance group. ||
|| disableZoneStatuses[] | **[DisableZoneStatus](#yandex.cloud.compute.v1.instancegroup.DisableZoneStatus)**

List of disabled zones for the instance group. ||
|#

## InstanceTemplate {#yandex.cloud.compute.v1.instancegroup.InstanceTemplate}

#|
||Field | Description ||
|| description | **string**

Description of the instance template.
The length must be less than or equal to 256. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.
Each map key must match the regular expression: `[a-z][-_./\\@0-9a-z]*`.
The length of each map key must be between 1 and 63.
The length of each map value must be less than or equal to 128.
The number of elements must be less than or equal to 64. ||
|| platformId | **string**

Required field. ID of the hardware platform configuration for the instance.
Platforms allows you to create various types of instances: with a large amount of memory,
with a large number of cores, with a burstable performance.
For more information, see [Platforms](../../../concepts/vm-platforms.md).
This field is required. ||
|| resourcesSpec | **[ResourcesSpec](#yandex.cloud.compute.v1.instancegroup.ResourcesSpec)**

Required field. Computing resources of the instance such as the amount of memory and number of cores.
This field is required. ||
|| metadata | **object** (map<**string**, **string**>)

The metadata `key:value` pairs assigned to this instance template. This includes custom metadata and predefined keys.
Metadata values may contain one of the supported placeholders:
{instance_group.id}
{instance.short_id}
{instance.index}
{instance.index_in_zone}
{instance.zone_id}
InstanceGroup and Instance labels may be copied to metadata following way:
{instance_group.labels.some_label_key}
{instance.labels.another_label_key}
These placeholders will be substituted for each created instance anywhere in the value text.
In the rare case the value requires to contain this placeholder explicitly,
it must be escaped with double brackets, in example {instance.index}.
For example, you may use the metadata in order to provide your public SSH key to the instance.
For more information, see [Metadata](../../../concepts/vm-metadata.md).
Each map key must match the regular expression: `[a-z][-_0-9a-z]*`.
The length of each map key must be between 1 and 63.
The length of each map value must be less than or equal to 262144.
The number of elements must be less than or equal to 128. ||
|| bootDiskSpec | **[AttachedDiskSpec](#yandex.cloud.compute.v1.instancegroup.AttachedDiskSpec)**

Boot disk specification that will be attached to the instance.
This field is required. ||
|| secondaryDiskSpecs[] | **[AttachedDiskSpec](#yandex.cloud.compute.v1.instancegroup.AttachedDiskSpec)**

Array of secondary disks that will be attached to the instance.
The number of elements must be less than or equal to 3. ||
|| networkInterfaceSpecs[] | **[NetworkInterfaceSpec](#yandex.cloud.compute.v1.instancegroup.NetworkInterfaceSpec)**

Array of network interfaces that will be attached to the instance.
This field is required. ||
|| schedulingPolicy | **[SchedulingPolicy](#yandex.cloud.compute.v1.instancegroup.SchedulingPolicy)**

Scheduling policy for the instance. ||
|| serviceAccountId | **string**

Service account ID for the instance. ||
|| name | **string**

Name of the instance.
In order to be unique it must contain at least on of instance unique placeholders:
{instance.short_id}
{instance.index}
combination of {instance.zone_id} and {instance.index_in_zone}
Example: my-instance-{instance.index}
If not set, default is used: {instance_group.id}-{instance.short_id}
It may also contain another placeholders, see metadata doc for full list.
The length must be less than or equal to 128. ||
|| hostname | **string**

Host name for the instance.
This field is used to generate the [yandex.cloud.compute.v1.Instance.fqdn](../../../api-ref/GpuCluster/listInstances.md#yandex.cloud.compute.v1.Instance) value.
The host name must be unique within the network and region.
If not specified, the host name will be equal to [yandex.cloud.compute.v1.Instance.id](../../../api-ref/GpuCluster/listInstances.md#yandex.cloud.compute.v1.Instance) of the instance
and FQDN will be `<id>.auto.internal`. Otherwise FQDN will be `<hostname>.<region_id>.internal`.
In order to be unique it must contain at least on of instance unique placeholders:
{instance.short_id}
{instance.index}
combination of {instance.zone_id} and {instance.index_in_zone}
Example: my-instance-{instance.index}
If not set, `name` value will be used
It may also contain another placeholders, see metadata doc for full list.
The length must be less than or equal to 128. ||
|| networkSettings | **[NetworkSettings](#yandex.cloud.compute.v1.instancegroup.NetworkSettings)**

Network settings for the instance. ||
|| placementPolicy | **[PlacementPolicy](#yandex.cloud.compute.v1.instancegroup.PlacementPolicy)**

Placement Group ||
|| filesystemSpecs[] | **[AttachedFilesystemSpec](#yandex.cloud.compute.v1.instancegroup.AttachedFilesystemSpec)**

Array of filesystems to attach to the instance.
The filesystems must reside in the same availability zone as the instance.
To use the instance with an attached filesystem, the latter must be mounted.
For details, see [documentation](../../../operations/filesystem/attach-to-vm.md). ||
|| reservedInstancePoolId | **string**

ID of the reserved instance pool that the instance should belong to.
Attaching/detaching running instance will increase/decrease the size of the reserved instance pool.
Attaching/detaching stopped instance will leave the size of the reserved instance pool unchanged. Starting such attached instance will use resources from the reserved instance pool.
Reserved instance pool resource configuration must match the resource configuration of the instance. ||
|| metadataOptions | **[MetadataOptions](#yandex.cloud.compute.v1.instancegroup.MetadataOptions)**

Metadata options for the instance ||
|#

## ResourcesSpec {#yandex.cloud.compute.v1.instancegroup.ResourcesSpec}

#|
||Field | Description ||
|| memory | **string** (int64)

The amount of memory available to the instance, specified in bytes.
The value must be less than or equal to 824633720832. ||
|| cores | **string** (int64)

The number of cores available to the instance.
The value must satisfy: 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,40,44,48,52,56,60,64,68,72,76,80. ||
|| coreFraction | **string** (int64)

Baseline level of CPU performance with the ability to burst performance above that baseline level.
This field sets baseline performance for each core.
The value must satisfy: 0,5,20,50,100. ||
|| gpus | **string** (int64)

The number of GPUs available to the instance.
The value must satisfy: 0,1,2,4. ||
|#

## AttachedDiskSpec {#yandex.cloud.compute.v1.instancegroup.AttachedDiskSpec}

#|
||Field | Description ||
|| mode | **enum** (Mode)

Required field. Access mode to the Disk resource.
This field is required.

- `READ_ONLY`: Read-only access.
- `READ_WRITE`: Read/Write access. ||
|| deviceName | **string**

Serial number that is reflected in the /dev/disk/by-id/ tree
of a Linux operating system running within the instance.
This value can be used to reference the device for mounting, resizing, and so on, from within the instance.
The value must match the regular expression: ```|[a-z][-_0-9a-z]{0,19}```.

Value must match the regular expression ``` |[a-z][-_0-9a-z]{0,19} ```. ||
|| diskSpec | **[DiskSpec](#yandex.cloud.compute.v1.instancegroup.AttachedDiskSpec.DiskSpec)**

oneof disk_spec or disk_id
Disk specification that is attached to the instance. For more information, see [Disks](../../../concepts/disk.md).
This field is required. ||
|| diskId | **string**

Set to use an existing disk. To set use variables.
The length must be less than or equal to 128.
The value must match the regular expression: `[-a-zA-Z0-9._{}]*`.

Value must match the regular expression ` [-a-zA-Z0-9._{}]* `. ||
|| name | **string**

When set can be later used to change DiskSpec of actual disk.
The length must be less than or equal to 128. ||
|#

## DiskSpec {#yandex.cloud.compute.v1.instancegroup.AttachedDiskSpec.DiskSpec}

#|
||Field | Description ||
|| description | **string**

Description of the disk.
The length must be less than or equal to 256. ||
|| typeId | **string**

Required field. ID of the disk type.
This field is required. ||
|| size | **string** (int64)

Size of the disk, specified in bytes.
The value must be between 4194304 and 28587302322176. ||
|| imageId | **string**

ID of the image that will be used for disk creation.
The length must be less than or equal to 50.

Includes only one of the fields `imageId`, `snapshotId`. ||
|| snapshotId | **string**

ID of the snapshot that will be used for disk creation.
The length must be less than or equal to 50.

Includes only one of the fields `imageId`, `snapshotId`. ||
|| preserveAfterInstanceDelete | **boolean**

When set to true, disk will not be deleted even after managed instance is deleted.
It will be a user's responsibility to delete such disks. ||
|#

## NetworkInterfaceSpec {#yandex.cloud.compute.v1.instancegroup.NetworkInterfaceSpec}

#|
||Field | Description ||
|| networkId | **string**

ID of the network. ||
|| subnetIds[] | **string**

IDs of the subnets. ||
|| primaryV4AddressSpec | **[PrimaryAddressSpec](#yandex.cloud.compute.v1.instancegroup.PrimaryAddressSpec)**

Primary IPv4 address that is assigned to the instance for this network interface. ||
|| primaryV6AddressSpec | **[PrimaryAddressSpec](#yandex.cloud.compute.v1.instancegroup.PrimaryAddressSpec)**

Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet. ||
|| securityGroupIds[] | **string**

IDs of security groups. ||
|#

## PrimaryAddressSpec {#yandex.cloud.compute.v1.instancegroup.PrimaryAddressSpec}

#|
||Field | Description ||
|| oneToOneNatSpec | **[OneToOneNatSpec](#yandex.cloud.compute.v1.instancegroup.OneToOneNatSpec)**

An external IP address configuration.
If not specified, then this managed instance will have no external internet access. ||
|| address | **string**

Optional. Manual set static internal IP. To set use variables.

Value must match the regular expression ` [-a-zA-Z0-9._{}:]* `. ||
|| dnsRecordSpecs[] | **[DnsRecordSpec](#yandex.cloud.compute.v1.instancegroup.DnsRecordSpec)**

Internal DNS configuration ||
|#

## OneToOneNatSpec {#yandex.cloud.compute.v1.instancegroup.OneToOneNatSpec}

#|
||Field | Description ||
|| ipVersion | **enum** (IpVersion)

IP version for the public IP address.

- `IPV4`: IPv4 address, for example 192.168.0.0.
- `IPV6`: IPv6 address, not available yet. ||
|| address | **string**

Manual set static public IP. To set use variables. (optional)

Value must match the regular expression ` [-a-zA-Z0-9._{}]* `. ||
|| dnsRecordSpecs[] | **[DnsRecordSpec](#yandex.cloud.compute.v1.instancegroup.DnsRecordSpec)**

External DNS configuration ||
|#

## DnsRecordSpec {#yandex.cloud.compute.v1.instancegroup.DnsRecordSpec}

#|
||Field | Description ||
|| fqdn | **string**

FQDN (required)
This field is required. ||
|| dnsZoneId | **string**

DNS zone id (optional, if not set, private zone used) ||
|| ttl | **string** (int64)

DNS record ttl, values in 0-86400 (optional)
The value must be between 0 and 86400. ||
|| ptr | **boolean**

When set to true, also create PTR DNS record (optional) ||
|#

## SchedulingPolicy {#yandex.cloud.compute.v1.instancegroup.SchedulingPolicy}

#|
||Field | Description ||
|| preemptible | **boolean**

Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time
if their resources are needed by Compute.
For more information, see [Preemptible Virtual Machines](../../../concepts/preemptible-vm.md). ||
|#

## NetworkSettings {#yandex.cloud.compute.v1.instancegroup.NetworkSettings}

#|
||Field | Description ||
|| type | **enum** (Type)

Required field. Type of instance network.

- `STANDARD`: Standard network.
- `SOFTWARE_ACCELERATED`: Software accelerated network.
- `HARDWARE_ACCELERATED`: Hardware accelerated network. ||
|#

## PlacementPolicy {#yandex.cloud.compute.v1.instancegroup.PlacementPolicy}

#|
||Field | Description ||
|| placementGroupId | **string**

Identifier of placement group ||
|| hostAffinityRules[] | **[HostAffinityRule](#yandex.cloud.compute.v1.instancegroup.PlacementPolicy.HostAffinityRule)**

List of affinity rules. Scheduler will attempt to allocate instances according to order of rules. ||
|#

## HostAffinityRule {#yandex.cloud.compute.v1.instancegroup.PlacementPolicy.HostAffinityRule}

Affinity definition

#|
||Field | Description ||
|| key | **string**

Required field. Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId' ||
|| op | **enum** (Operator)

Include or exclude action

- `IN`: Include action
- `NOT_IN`: Exclude action ||
|| values[] | **string**

Affinity value or host ID or host group ID ||
|#

## AttachedFilesystemSpec {#yandex.cloud.compute.v1.instancegroup.AttachedFilesystemSpec}

#|
||Field | Description ||
|| mode | **enum** (Mode)

Mode of access to the filesystem that should be attached.

- `READ_ONLY`: Read-only access.
- `READ_WRITE`: Read/Write access. Default value. ||
|| deviceName | **string**

Name of the device representing the filesystem on the instance.
The name should be used for referencing the filesystem from within the instance
when it's being mounted, resized etc.
If not specified, a random value will be generated.
The value must match the regular expression: ```|[a-z][-_0-9a-z]{0,19}```.

Value must match the regular expression ``` |[a-z][-_0-9a-z]{0,19} ```. ||
|| filesystemId | **string**

ID of the filesystem that should be attached.
The length must be less than or equal to 128.
The value must match the regular expression: `[-a-zA-Z0-9._{}]*`.

Value must match the regular expression ` [-a-zA-Z0-9._{}]* `. ||
|#

## MetadataOptions {#yandex.cloud.compute.v1.instancegroup.MetadataOptions}

#|
||Field | Description ||
|| gceHttpEndpoint | **enum** (MetadataOption)

Enabled access to GCE flavored metadata

- `ENABLED`: Option is enabled
- `DISABLED`: Option is disabled ||
|| awsV1HttpEndpoint | **enum** (MetadataOption)

Enabled access to AWS flavored metadata (IMDSv1)

- `ENABLED`: Option is enabled
- `DISABLED`: Option is disabled ||
|| gceHttpToken | **enum** (MetadataOption)

Enabled access to IAM credentials with GCE flavored metadata

- `ENABLED`: Option is enabled
- `DISABLED`: Option is disabled ||
|| awsV1HttpToken | **enum** (MetadataOption)

Enabled access to IAM credentials with AWS flavored metadata (IMDSv1)

- `ENABLED`: Option is enabled
- `DISABLED`: Option is disabled ||
|| awsV2HttpEndpoint | **enum** (MetadataOption)

Enabled access to AWS flavored metadata with session token (IMDSv2)

- `ENABLED`: Option is enabled
- `DISABLED`: Option is disabled ||
|| awsV2HttpToken | **enum** (MetadataOption)

Enabled access to STS credentials with AWS flavored metadata with session token (IMDSv2)

- `ENABLED`: Option is enabled
- `DISABLED`: Option is disabled ||
|#

## ScalePolicy {#yandex.cloud.compute.v1.instancegroup.ScalePolicy}

#|
||Field | Description ||
|| fixedScale | **[FixedScale](#yandex.cloud.compute.v1.instancegroup.ScalePolicy.FixedScale)**

[Manual scaling policy](../../../concepts/instance-groups/scale.md#fixed-policy) of the instance group.

Includes only one of the fields `fixedScale`, `autoScale`. ||
|| autoScale | **[AutoScale](#yandex.cloud.compute.v1.instancegroup.ScalePolicy.AutoScale)**

[Automatic scaling policy](../../../concepts/instance-groups/scale.md#auto-scale) of the instance group.

Includes only one of the fields `fixedScale`, `autoScale`. ||
|| testAutoScale | **[AutoScale](#yandex.cloud.compute.v1.instancegroup.ScalePolicy.AutoScale)**

Test spec for [automatic scaling policy](../../../concepts/instance-groups/scale.md#auto-scale) of the instance group. ||
|#

## FixedScale {#yandex.cloud.compute.v1.instancegroup.ScalePolicy.FixedScale}

#|
||Field | Description ||
|| size | **string** (int64)

Number of instances in the instance group.
The value must be between 1 and 100. ||
|#

## AutoScale {#yandex.cloud.compute.v1.instancegroup.ScalePolicy.AutoScale}

#|
||Field | Description ||
|| minZoneSize | **string** (int64)

Lower limit for instance count in each zone.
The value must be between 0 and 100. ||
|| maxSize | **string** (int64)

Upper limit for total instance count (across all zones).
0 means maximum limit = 100.
The value must be between 0 and 100. ||
|| measurementDuration | **string** (duration)

Time in seconds allotted for averaging metrics.
1 minute by default.
The value must satisfy: 1m-10m. ||
|| warmupDuration | **string** (duration)

The warmup time of the instance in seconds. During this time,
traffic is sent to the instance, but instance metrics are not collected.
The value must satisfy: <=10m. ||
|| stabilizationDuration | **string** (duration)

Minimum amount of time in seconds allotted for monitoring before
Instance Groups can reduce the number of instances in the group.
During this time, the group size doesn't decrease, even if the new metric values
indicate that it should.
The value must satisfy: 1m-30m. ||
|| initialSize | **string** (int64)

Target group size.
The value must be greater than or equal to 1. ||
|| cpuUtilizationRule | **[CpuUtilizationRule](#yandex.cloud.compute.v1.instancegroup.ScalePolicy.CpuUtilizationRule)**

Defines an autoscaling rule based on the average CPU utilization of the instance group.
If more than one rule is specified, e.g. CPU utilization and one or more Monitoring metrics (`customRules`),
the size of the instance group will be equal to the maximum of sizes calculated according to each metric. ||
|| customRules[] | **[CustomRule](#yandex.cloud.compute.v1.instancegroup.ScalePolicy.CustomRule)**

Defines an autoscaling rule based on a [custom metric](../../../../monitoring/operations/metric/add.md) from Monitoring.
If more than one rule is specified, e.g. CPU utilization (`cpuUtilizationRule`) and one or more Monitoring
metrics, the size of the instance group will be equal to the maximum of sizes calculated according to each metric.
The number of elements must be less than or equal to 3. ||
|| autoScaleType | **enum** (AutoScaleType)

Autoscaling type.

- `ZONAL`: Scale each zone independently. This is the default.
- `REGIONAL`: Scale group as a whole. ||
|#

## CpuUtilizationRule {#yandex.cloud.compute.v1.instancegroup.ScalePolicy.CpuUtilizationRule}

#|
||Field | Description ||
|| utilizationTarget | **string**

Target CPU utilization level. Instance Groups maintains this level for each availability zone.
The value must be between 10 and 100. ||
|#

## CustomRule {#yandex.cloud.compute.v1.instancegroup.ScalePolicy.CustomRule}

#|
||Field | Description ||
|| ruleType | **enum** (RuleType)

Required field. Custom metric rule type. This field affects which label from
the custom metric should be used: `zone_id` or `instance_id`.
This field is required.

- `UTILIZATION`: This type means that the metric applies to one instance.
First, Instance Groups calculates the average metric value for each instance,
then averages the values for instances in one availability zone or in whole group depends on autoscaling type.
This type of metric must have the `instance_id` label.
- `WORKLOAD`: This type means that the metric applies to instances in one availability zone or to whole group depends on autoscaling type.
This type of metric must have the `zone_id` label if ZONAL autoscaling type is chosen. ||
|| metricType | **enum** (MetricType)

Required field. Type of custom metric. This field affects how Instance Groups calculates the average metric value.
This field is required.

- `GAUGE`: This type is used for metrics that show the metric value at a certain point in time,
such as requests per second to the server on an instance.
Instance Groups calculates the average metric value for the period
specified in the [AutoScale.measurementDuration](#yandex.cloud.compute.v1.instancegroup.ScalePolicy.AutoScale) field.
- `COUNTER`: This type is used for metrics that monotonically increase over time,
such as the total number of requests to the server on an instance.
Instance Groups calculates the average value increase for the period
specified in the [AutoScale.measurementDuration](#yandex.cloud.compute.v1.instancegroup.ScalePolicy.AutoScale) field. ||
|| metricName | **string**

Required field. Name of custom metric in Monitoring that should be used for scaling.
The value must match the regular expression: `[a-zA-Z0-9./@_][ 0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198}`.
This field is required.

Value must match the regular expression ` [a-zA-Z0-9./@_][ 0-9a-zA-Z./@_,:;()\[\]<>-]{0,198} `. ||
|| labels | **object** (map<**string**, **string**>)

Labels of custom metric in Monitoring that should be used for scaling.
Each map key must match the regular expression: `^[a-zA-Z][0-9a-zA-Z_]{0,31}$`.
Each map value must match the regular expression: `[a-zA-Z0-9./@_][ 0-9a-zA-Z./@_,:;()\\[\\]<>-]{0,198}`.

Each value must match the regular expression ` [a-zA-Z0-9./@_][ 0-9a-zA-Z./@_,:;()\[\]<>-]{0,198} `. ||
|| target | **string**

Target value for the custom metric. Instance Groups maintains this level for each availability zone.
The value must be greater than 0. ||
|| folderId | **string**

Folder id of custom metric in Monitoring that should be used for scaling.
The length must be less than or equal to 50. ||
|| service | **string**

Service of custom metric in Monitoring that should be used for scaling.
The length must be less than or equal to 200. ||
|#

## DeployPolicy {#yandex.cloud.compute.v1.instancegroup.DeployPolicy}

#|
||Field | Description ||
|| maxUnavailable | **string** (int64)

The maximum number of running instances that can be taken offline (i.e., stopped or deleted) at the same time
during the update process.
If `maxExpansion` is not specified or set to zero, `maxUnavailable` must be set to a non-zero value.
The value must be between 0 and 100. ||
|| maxDeleting | **string** (int64)

The maximum number of instances that can be deleted at the same time.
The value 0 is any number of virtual machines within the allowed values.
The value must be between 0 and 100. ||
|| maxCreating | **string** (int64)

The maximum number of instances that can be created at the same time.
The value 0 is any number of virtual machines within the allowed values.
The value must be between 0 and 100. ||
|| maxExpansion | **string** (int64)

The maximum number of instances that can be temporarily allocated above the group's target size
during the update process.
If `maxUnavailable` is not specified or set to zero, `maxExpansion` must be set to a non-zero value.
The value must be between 0 and 100. ||
|| startupDuration | **string** (duration)

Instance startup duration.
Instance will be considered up and running (and start receiving traffic) only after startup_duration
has elapsed and all health checks are passed.
See [ManagedInstance.Status](listInstances.md#yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status) for more information.
The value must satisfy: 0m-1h. ||
|| strategy | **enum** (Strategy)

Affects the lifecycle of the instance during deployment.

- `PROACTIVE`: Instance Groups can forcefully stop a running instance. This is the default.
- `OPPORTUNISTIC`: Instance Groups does not stop a running instance.
Instead, it will wait until the instance stops itself or becomes unhealthy. ||
|| minimalAction | **enum** (MinimalAction)

If instance update requires a less disruptive action than `minimalAction`,
Instance Groups performs `minimalAction` to execute the update

- `LIVE_UPDATE`: Updating an instance without stopping. This is the default.
- `RESTART`: Updating an instance with restart: stopping and then starting the instance.
- `RECREATE`: Re-creating an instance: deleting an instance and creating a new one. ||
|#

## AllocationPolicy {#yandex.cloud.compute.v1.instancegroup.AllocationPolicy}

#|
||Field | Description ||
|| zones[] | **[Zone](#yandex.cloud.compute.v1.instancegroup.AllocationPolicy.Zone)**

List of availability zones.
The number of elements must be greater than or equal to 1. ||
|#

## Zone {#yandex.cloud.compute.v1.instancegroup.AllocationPolicy.Zone}

#|
||Field | Description ||
|| zoneId | **string**

Required field. ID of the availability zone where the instance resides.
This field is required. ||
|| instanceTagsPool[] | **string**

Each instance in a zone will be associated with exactly one of a tag from a pool below.
All specified tags must be unique across the whole group not only the zone.
It is guaranteed that during whole deploy only tags from prefix of the specified list will be used.
It is possible to use tag associated with instance in templating via {instance.tag}.
The elements must be unique.
The length of each element must be between 3 and 50. ||
|#

## LoadBalancerState {#yandex.cloud.compute.v1.instancegroup.LoadBalancerState}

#|
||Field | Description ||
|| targetGroupId | **string**

ID of the Network Load Balancer target group attributed to the instance group. ||
|| statusMessage | **string**

Status message of the target group. ||
|#

## ManagedInstancesState {#yandex.cloud.compute.v1.instancegroup.ManagedInstancesState}

#|
||Field | Description ||
|| targetSize | **string** (int64)

Target number of instances for this instance group. ||
|| runningActualCount | **string** (int64)

The number of running instances that match the current instance template. For more information, see [ManagedInstance.Status.RUNNING_ACTUAL](listInstances.md#yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status). ||
|| runningOutdatedCount | **string** (int64)

The number of running instances that does not match the current instance template. For more information, see [ManagedInstance.Status.RUNNING_OUTDATED](listInstances.md#yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status). ||
|| processingCount | **string** (int64)

The number of instances in flight (for example, updating, starting, deleting). For more information, see [ManagedInstance.Status](listInstances.md#yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status). ||
|#

## LoadBalancerSpec {#yandex.cloud.compute.v1.instancegroup.LoadBalancerSpec}

#|
||Field | Description ||
|| targetGroupSpec | **[TargetGroupSpec](#yandex.cloud.compute.v1.instancegroup.TargetGroupSpec)**

Required field. Specification of the target group that the instance group will be added to. For more information, see [Target groups and resources](../../../../network-load-balancer/concepts/target-resources.md). ||
|| maxOpeningTrafficDuration | **string** (duration)

Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded,
the VM will be turned off based on the deployment policy. Specified in seconds.
The value must satisfy: >=1s. ||
|| ignoreHealthChecks | **boolean**

Do not wait load balancer health checks. ||
|#

## TargetGroupSpec {#yandex.cloud.compute.v1.instancegroup.TargetGroupSpec}

#|
||Field | Description ||
|| name | **string**

Name of the target group.
The value must match the regular expression: ```|[a-z]([-a-z0-9]{0,61}[a-z0-9])?```.

Value must match the regular expression ``` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? ```. ||
|| description | **string**

Description of the target group.
The length must be less than or equal to 256. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.
Each map key must match the regular expression: `[a-z][-_./\\@0-9a-z]*`.
Each map value must match the regular expression: `[-_./\\@0-9a-z]*`.
The length of each map key must be between 1 and 63.
The length of each map value must be less than or equal to 63.
The number of elements must be less than or equal to 64.

Each value must match the regular expression ` [-_./\@0-9a-z]* `. ||
|#

## HealthChecksSpec {#yandex.cloud.compute.v1.instancegroup.HealthChecksSpec}

#|
||Field | Description ||
|| healthCheckSpecs[] | **[HealthCheckSpec](#yandex.cloud.compute.v1.instancegroup.HealthCheckSpec)**

Health checking specification. For more information, see [Health check](../../../../network-load-balancer/concepts/health-check.md).
The number of elements must be greater than or equal to 1. ||
|| maxCheckingHealthDuration | **string** (duration)

Timeout for waiting for the VM to become healthy. If the timeout is exceeded,
the VM will be turned off based on the deployment policy. Specified in seconds.
The value must satisfy: >=1s. ||
|#

## HealthCheckSpec {#yandex.cloud.compute.v1.instancegroup.HealthCheckSpec}

#|
||Field | Description ||
|| interval | **string** (duration)

The interval between health checks. The default is 2 seconds.
The value must satisfy: 1s-300s. ||
|| timeout | **string** (duration)

Timeout for the managed instance to return a response for the health check. The default is 1 second.
The value must satisfy: 1s-60s. ||
|| unhealthyThreshold | **string** (int64)

The number of failed health checks for the managed instance to be considered unhealthy. The default (0) is 2.
The value must satisfy: 0,2,3,4,5,6,7,8,9,10. ||
|| healthyThreshold | **string** (int64)

The number of successful health checks required in order for the managed instance to be considered healthy. The default (0) is 2.
The value must satisfy: 0,2,3,4,5,6,7,8,9,10. ||
|| tcpOptions | **[TcpOptions](#yandex.cloud.compute.v1.instancegroup.HealthCheckSpec.TcpOptions)**

Configuration options for a TCP health check.

Includes only one of the fields `tcpOptions`, `httpOptions`. ||
|| httpOptions | **[HttpOptions](#yandex.cloud.compute.v1.instancegroup.HealthCheckSpec.HttpOptions)**

Configuration options for an HTTP health check.

Includes only one of the fields `tcpOptions`, `httpOptions`. ||
|#

## TcpOptions {#yandex.cloud.compute.v1.instancegroup.HealthCheckSpec.TcpOptions}

#|
||Field | Description ||
|| port | **string** (int64)

Port to use for TCP health checks.
The value must be between 1 and 65535. ||
|#

## HttpOptions {#yandex.cloud.compute.v1.instancegroup.HealthCheckSpec.HttpOptions}

#|
||Field | Description ||
|| port | **string** (int64)

Port to use for HTTP health checks.
The value must be between 1 and 65535. ||
|| path | **string**

URL path to set for health checking requests. ||
|#

## Variable {#yandex.cloud.compute.v1.instancegroup.Variable}

#|
||Field | Description ||
|| key | **string**

Name of the variable.
The length must be between 1 and 128.
The value must match the regular expression: `[a-zA-Z0-9._-]*`.

Value must match the regular expression ` [a-zA-Z0-9._-]* `. ||
|| value | **string**

Value of the variable.
The length must be less than or equal to 128. ||
|#

## ApplicationLoadBalancerSpec {#yandex.cloud.compute.v1.instancegroup.ApplicationLoadBalancerSpec}

#|
||Field | Description ||
|| targetGroupSpec | **[ApplicationTargetGroupSpec](#yandex.cloud.compute.v1.instancegroup.ApplicationTargetGroupSpec)**

Required field. Basic properties of the Application Load Balancer target group attributed to the instance group.
This field is required. ||
|| maxOpeningTrafficDuration | **string** (duration)

Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded,
the VM will be turned off based on the deployment policy. Specified in seconds.
The value must satisfy: >=1s. ||
|| ignoreHealthChecks | **boolean**

Do not wait load balancer health checks. ||
|#

## ApplicationTargetGroupSpec {#yandex.cloud.compute.v1.instancegroup.ApplicationTargetGroupSpec}

#|
||Field | Description ||
|| name | **string**

Name of the target group.

Value must match the regular expression ``` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? ```. ||
|| description | **string**

Description of the target group. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.

Each value must match the regular expression ` [-_./\@0-9a-z]* `. ||
|#

## ApplicationLoadBalancerState {#yandex.cloud.compute.v1.instancegroup.ApplicationLoadBalancerState}

#|
||Field | Description ||
|| targetGroupId | **string**

ID of the Application Load Balancer target group attributed to the instance group. ||
|| statusMessage | **string**

Status message of the target group. ||
|#

## AutoHealingPolicy {#yandex.cloud.compute.v1.instancegroup.AutoHealingPolicy}

#|
||Field | Description ||
|| autoHealingAction | **enum** (AutoHealingAction)

Instance Groups performs `autoHealingAction` when instance becomes unhealthy.

- `NONE`: No action
- `RESTART`: Re-starting an instance with restart: stopping and then starting the instance.
- `RECREATE`: Re-creating an instance: deleting an instance and creating a new one. ||
|#

## DisableZoneStatus {#yandex.cloud.compute.v1.instancegroup.DisableZoneStatus}

Status of the disabled zone.

#|
||Field | Description ||
|| zoneId | **string**

ID of zone. ||
|| disabledUntil | **string** (date-time)

Timestamp until which the zone will be disabled.
If not present then zone will be disabled until it is removed through a separate call.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#