---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/instancegroup/api-ref/grpc/InstanceGroup/pauseProcesses.md
---

# Compute Cloud Instance Groups API, gRPC: InstanceGroupService.PauseProcesses {#PauseProcesses}

Pauses all processes regarding management of the specified instance group,
i.e. scaling, checking instances' health, auto-healing and updating them. Running instances are not stopped.

## gRPC request

**rpc PauseProcesses ([PauseInstanceGroupProcessesRequest](#yandex.cloud.compute.v1.instancegroup.PauseInstanceGroupProcessesRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## PauseInstanceGroupProcessesRequest {#yandex.cloud.compute.v1.instancegroup.PauseInstanceGroupProcessesRequest}

```json
{
  "instanceGroupId": "string"
}
```

#|
||Field | Description ||
|| instanceGroupId | **string**

ID of the instance group to pause processes in.

The instance group must have an `ACTIVE` status ([InstanceGroup.status](#yandex.cloud.compute.v1.instancegroup.InstanceGroup)).

To get the instance group ID, make a [InstanceGroupService.List](/docs/compute/api-ref/grpc/InstanceGroup/list#List) request. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "createdBy": "string",
  "modifiedAt": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "instanceGroupId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folderId": "string",
    "createdAt": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "string",
    "instanceTemplate": {
      "description": "string",
      "labels": "string",
      "platformId": "string",
      "resourcesSpec": {
        "memory": "int64",
        "cores": "int64",
        "coreFraction": "int64",
        "gpus": "int64"
      },
      "metadata": "string",
      "bootDiskSpec": {
        "mode": "Mode",
        "deviceName": "string",
        "diskSpec": {
          "description": "string",
          "typeId": "string",
          "size": "int64",
          // Includes only one of the fields `imageId`, `snapshotId`
          "imageId": "string",
          "snapshotId": "string",
          // end of the list of possible fields
          "preserveAfterInstanceDelete": "bool"
        },
        "diskId": "string",
        "name": "string"
      },
      "secondaryDiskSpecs": [
        {
          "mode": "Mode",
          "deviceName": "string",
          "diskSpec": {
            "description": "string",
            "typeId": "string",
            "size": "int64",
            // Includes only one of the fields `imageId`, `snapshotId`
            "imageId": "string",
            "snapshotId": "string",
            // end of the list of possible fields
            "preserveAfterInstanceDelete": "bool"
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
              "ipVersion": "IpVersion",
              "address": "string",
              "dnsRecordSpecs": [
                {
                  "fqdn": "string",
                  "dnsZoneId": "string",
                  "ttl": "int64",
                  "ptr": "bool"
                }
              ]
            },
            "dnsRecordSpecs": [
              {
                "fqdn": "string",
                "dnsZoneId": "string",
                "ttl": "int64",
                "ptr": "bool"
              }
            ],
            "address": "string"
          },
          "primaryV6AddressSpec": {
            "oneToOneNatSpec": {
              "ipVersion": "IpVersion",
              "address": "string",
              "dnsRecordSpecs": [
                {
                  "fqdn": "string",
                  "dnsZoneId": "string",
                  "ttl": "int64",
                  "ptr": "bool"
                }
              ]
            },
            "dnsRecordSpecs": [
              {
                "fqdn": "string",
                "dnsZoneId": "string",
                "ttl": "int64",
                "ptr": "bool"
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
        "preemptible": "bool"
      },
      "serviceAccountId": "string",
      "networkSettings": {
        "type": "Type"
      },
      "name": "string",
      "hostname": "string",
      "placementPolicy": {
        "placementGroupId": "string",
        "hostAffinityRules": [
          {
            "key": "string",
            "op": "Operator",
            "values": [
              "string"
            ]
          }
        ]
      },
      "filesystemSpecs": [
        {
          "mode": "Mode",
          "deviceName": "string",
          "filesystemId": "string"
        }
      ],
      "metadataOptions": {
        "gceHttpEndpoint": "MetadataOption",
        "awsV1HttpEndpoint": "MetadataOption",
        "gceHttpToken": "MetadataOption",
        "awsV1HttpToken": "MetadataOption"
      }
    },
    "scalePolicy": {
      // Includes only one of the fields `fixedScale`, `autoScale`
      "fixedScale": {
        "size": "int64"
      },
      "autoScale": {
        "minZoneSize": "int64",
        "maxSize": "int64",
        "measurementDuration": "google.protobuf.Duration",
        "warmupDuration": "google.protobuf.Duration",
        "stabilizationDuration": "google.protobuf.Duration",
        "initialSize": "int64",
        "cpuUtilizationRule": {
          "utilizationTarget": "double"
        },
        "customRules": [
          {
            "ruleType": "RuleType",
            "metricType": "MetricType",
            "metricName": "string",
            "labels": "string",
            "target": "double",
            "folderId": "string",
            "service": "string"
          }
        ],
        "autoScaleType": "AutoScaleType"
      },
      // end of the list of possible fields
      "testAutoScale": {
        "minZoneSize": "int64",
        "maxSize": "int64",
        "measurementDuration": "google.protobuf.Duration",
        "warmupDuration": "google.protobuf.Duration",
        "stabilizationDuration": "google.protobuf.Duration",
        "initialSize": "int64",
        "cpuUtilizationRule": {
          "utilizationTarget": "double"
        },
        "customRules": [
          {
            "ruleType": "RuleType",
            "metricType": "MetricType",
            "metricName": "string",
            "labels": "string",
            "target": "double",
            "folderId": "string",
            "service": "string"
          }
        ],
        "autoScaleType": "AutoScaleType"
      }
    },
    "deployPolicy": {
      "maxUnavailable": "int64",
      "maxDeleting": "int64",
      "maxCreating": "int64",
      "maxExpansion": "int64",
      "startupDuration": "google.protobuf.Duration",
      "strategy": "Strategy",
      "minimalAction": "MinimalAction"
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
      "targetSize": "int64",
      "runningActualCount": "int64",
      "runningOutdatedCount": "int64",
      "processingCount": "int64"
    },
    "loadBalancerSpec": {
      "targetGroupSpec": {
        "name": "string",
        "description": "string",
        "labels": "string"
      },
      "maxOpeningTrafficDuration": "google.protobuf.Duration",
      "ignoreHealthChecks": "bool"
    },
    "healthChecksSpec": {
      "healthCheckSpecs": [
        {
          "interval": "google.protobuf.Duration",
          "timeout": "google.protobuf.Duration",
          "unhealthyThreshold": "int64",
          "healthyThreshold": "int64",
          // Includes only one of the fields `tcpOptions`, `httpOptions`
          "tcpOptions": {
            "port": "int64"
          },
          "httpOptions": {
            "port": "int64",
            "path": "string"
          }
          // end of the list of possible fields
        }
      ],
      "maxCheckingHealthDuration": "google.protobuf.Duration"
    },
    "serviceAccountId": "string",
    "status": "Status",
    "variables": [
      {
        "key": "string",
        "value": "string"
      }
    ],
    "deletionProtection": "bool",
    "applicationLoadBalancerSpec": {
      "targetGroupSpec": {
        "name": "string",
        "description": "string",
        "labels": "string"
      },
      "maxOpeningTrafficDuration": "google.protobuf.Duration",
      "ignoreHealthChecks": "bool"
    },
    "applicationLoadBalancerState": {
      "targetGroupId": "string",
      "statusMessage": "string"
    },
    "autoHealingPolicy": {
      "autoHealingAction": "AutoHealingAction"
    }
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[PauseInstanceGroupProcessMetadata](#yandex.cloud.compute.v1.instancegroup.PauseInstanceGroupProcessMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[InstanceGroup](#yandex.cloud.compute.v1.instancegroup.InstanceGroup)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## PauseInstanceGroupProcessMetadata {#yandex.cloud.compute.v1.instancegroup.PauseInstanceGroupProcessMetadata}

#|
||Field | Description ||
|| instanceGroupId | **string**

ID of the instance group that processes are being paused in. ||
|#

## InstanceGroup {#yandex.cloud.compute.v1.instancegroup.InstanceGroup}

#|
||Field | Description ||
|| id | **string**

ID of the instance group. ||
|| folderId | **string**

ID of the folder that the instance group belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| name | **string**

Name of the instance group.
The name is unique within the folder. ||
|| description | **string**

Description of the instance group. ||
|| labels | **string**

Resource labels as `key:value` pairs. ||
|| instanceTemplate | **[InstanceTemplate](#yandex.cloud.compute.v1.instancegroup.InstanceTemplate)**

Instance template for creating the instance group.
For more information, see [Instance Templates](/docs/compute/concepts/instance-groups/instance-template). ||
|| scalePolicy | **[ScalePolicy](#yandex.cloud.compute.v1.instancegroup.ScalePolicy)**

[Scaling policy](/docs/compute/concepts/instance-groups/scale) of the instance group. ||
|| deployPolicy | **[DeployPolicy](#yandex.cloud.compute.v1.instancegroup.DeployPolicy)**

Deployment policy of the instance group. ||
|| allocationPolicy | **[AllocationPolicy](#yandex.cloud.compute.v1.instancegroup.AllocationPolicy)**

Allocation policy of the instance group by zones and regions. ||
|| loadBalancerState | **[LoadBalancerState](#yandex.cloud.compute.v1.instancegroup.LoadBalancerState)**

Status of the Network Load Balancer target group attributed to the instance group. ||
|| managedInstancesState | **[ManagedInstancesState](#yandex.cloud.compute.v1.instancegroup.ManagedInstancesState)**

States of instances for this instance group. ||
|| loadBalancerSpec | **[LoadBalancerSpec](#yandex.cloud.compute.v1.instancegroup.LoadBalancerSpec)**

Settings for balancing load between instances via [Network Load Balancer](/docs/network-load-balancer/concepts)
(OSI model layer 3). ||
|| healthChecksSpec | **[HealthChecksSpec](#yandex.cloud.compute.v1.instancegroup.HealthChecksSpec)**

Health checking specification. For more information, see [Health check](/docs/network-load-balancer/concepts/health-check). ||
|| serviceAccountId | **string**

ID of the service account. The service account will be used for all API calls
made by the Instance Groups component on behalf of the user (for example, creating instances, adding them to load balancer target group, etc.). For more information, see [Service accounts](/docs/iam/concepts/users/service-accounts).
To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/ServiceAccount/list#List) request. ||
|| status | enum **Status**

Status of the instance group.

- `STATUS_UNSPECIFIED`
- `STARTING`: Instance group is being started and will become active soon.
- `ACTIVE`: Instance group is active.
In this state the group manages its instances and monitors their health,
creating, deleting, stopping, updating and starting instances as needed.

  To stop the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Stop](/docs/compute/api-ref/grpc/InstanceGroup/stop#Stop).
To pause the processes in the instance group, i.e. scaling, checking instances' health,
auto-healing and updating them, without stopping the instances,
call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.PauseProcesses](#PauseProcesses).
- `STOPPING`: Instance group is being stopped.
Group's instances stop receiving traffic from the load balancer (if any) and are then stopped.
- `STOPPED`: Instance group is stopped.
In this state the group cannot be updated and does not react to any changes made to its instances.
To start the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Start](/docs/compute/api-ref/grpc/InstanceGroup/start#Start).
- `DELETING`: Instance group is being deleted.
- `PAUSED`: Instance group is paused.
In this state all the processes regarding the group management, i.e. scaling, checking instances' health,
auto-healing and updating them, are paused. The instances that were running prior to pausing the group, however,
may still be running.

  To resume the processes in the instance group,
call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.ResumeProcesses](/docs/compute/api-ref/grpc/InstanceGroup/resumeProcesses#ResumeProcesses).
The group status will change to `ACTIVE`. ||
|| variables[] | **[Variable](#yandex.cloud.compute.v1.instancegroup.Variable)** ||
|| deletionProtection | **bool**

Flag prohibiting deletion of the instance group.

Allowed values:</br>- `false`: The instance group can be deleted.</br>- `true`: The instance group cannot be deleted.

The default is `false`. ||
|| applicationLoadBalancerSpec | **[ApplicationLoadBalancerSpec](#yandex.cloud.compute.v1.instancegroup.ApplicationLoadBalancerSpec)**

Settings for balancing load between instances via [Application Load Balancer](/docs/application-load-balancer/concepts)
(OSI model layer 7). ||
|| applicationLoadBalancerState | **[ApplicationLoadBalancerState](#yandex.cloud.compute.v1.instancegroup.ApplicationLoadBalancerState)**

Status of the Application Load Balancer target group attributed to the instance group.

Returned if there is a working load balancer that the target group is connected to. ||
|| autoHealingPolicy | **[AutoHealingPolicy](#yandex.cloud.compute.v1.instancegroup.AutoHealingPolicy)**

AutoHealingPolicy policy of the instance group. ||
|#

## InstanceTemplate {#yandex.cloud.compute.v1.instancegroup.InstanceTemplate}

#|
||Field | Description ||
|| description | **string**

Description of the instance template. ||
|| labels | **string**

Resource labels as `key:value` pairs. ||
|| platformId | **string**

Required field. ID of the hardware platform configuration for the instance.
Platforms allows you to create various types of instances: with a large amount of memory,
with a large number of cores, with a burstable performance.
For more information, see [Platforms](/docs/compute/concepts/vm-platforms). ||
|| resourcesSpec | **[ResourcesSpec](#yandex.cloud.compute.v1.instancegroup.ResourcesSpec)**

Required field. Computing resources of the instance such as the amount of memory and number of cores. ||
|| metadata | **string**

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
For more information, see [Metadata](/docs/compute/concepts/vm-metadata). ||
|| bootDiskSpec | **[AttachedDiskSpec](#yandex.cloud.compute.v1.instancegroup.AttachedDiskSpec)**

Required field. Boot disk specification that will be attached to the instance. ||
|| secondaryDiskSpecs[] | **[AttachedDiskSpec](#yandex.cloud.compute.v1.instancegroup.AttachedDiskSpec)**

Array of secondary disks that will be attached to the instance. ||
|| networkInterfaceSpecs[] | **[NetworkInterfaceSpec](#yandex.cloud.compute.v1.instancegroup.NetworkInterfaceSpec)**

Required field. Array of network interfaces that will be attached to the instance. ||
|| schedulingPolicy | **[SchedulingPolicy](#yandex.cloud.compute.v1.instancegroup.SchedulingPolicy)**

Scheduling policy for the instance. ||
|| serviceAccountId | **string**

Service account ID for the instance. ||
|| networkSettings | **[NetworkSettings](#yandex.cloud.compute.v1.instancegroup.NetworkSettings)**

Network settings for the instance. ||
|| name | **string**

Name of the instance.
In order to be unique it must contain at least on of instance unique placeholders:
{instance.short_id}
{instance.index}
combination of {instance.zone_id} and {instance.index_in_zone}
Example: my-instance-{instance.index}
If not set, default is used: {instance_group.id}-{instance.short_id}
It may also contain another placeholders, see metadata doc for full list. ||
|| hostname | **string**

Host name for the instance.
This field is used to generate the [yandex.cloud.compute.v1.Instance.fqdn](/docs/compute/api-ref/grpc/GpuCluster/listInstances#yandex.cloud.compute.v1.Instance) value.
The host name must be unique within the network and region.
If not specified, the host name will be equal to [yandex.cloud.compute.v1.Instance.id](/docs/compute/api-ref/grpc/GpuCluster/listInstances#yandex.cloud.compute.v1.Instance) of the instance
and FQDN will be `<id>.auto.internal`. Otherwise FQDN will be `<hostname>.<region_id>.internal`.

In order to be unique it must contain at least on of instance unique placeholders:
{instance.short_id}
{instance.index}
combination of {instance.zone_id} and {instance.index_in_zone}
Example: my-instance-{instance.index}
If not set, `name` value will be used
It may also contain another placeholders, see metadata doc for full list. ||
|| placementPolicy | **[PlacementPolicy](#yandex.cloud.compute.v1.instancegroup.PlacementPolicy)**

Placement Group ||
|| filesystemSpecs[] | **[AttachedFilesystemSpec](#yandex.cloud.compute.v1.instancegroup.AttachedFilesystemSpec)**

Array of filesystems to attach to the instance.

The filesystems must reside in the same availability zone as the instance.

To use the instance with an attached filesystem, the latter must be mounted.
For details, see [documentation](/docs/compute/operations/filesystem/attach-to-vm). ||
|| metadataOptions | **[MetadataOptions](#yandex.cloud.compute.v1.instancegroup.MetadataOptions)**

Metadata options for the instance ||
|#

## ResourcesSpec {#yandex.cloud.compute.v1.instancegroup.ResourcesSpec}

#|
||Field | Description ||
|| memory | **int64**

The amount of memory available to the instance, specified in bytes. ||
|| cores | **int64**

The number of cores available to the instance. ||
|| coreFraction | **int64**

Baseline level of CPU performance with the ability to burst performance above that baseline level.
This field sets baseline performance for each core. ||
|| gpus | **int64**

The number of GPUs available to the instance. ||
|#

## AttachedDiskSpec {#yandex.cloud.compute.v1.instancegroup.AttachedDiskSpec}

#|
||Field | Description ||
|| mode | enum **Mode**

Required field. Access mode to the Disk resource.

- `MODE_UNSPECIFIED`
- `READ_ONLY`: Read-only access.
- `READ_WRITE`: Read/Write access. ||
|| deviceName | **string**

Serial number that is reflected in the /dev/disk/by-id/ tree
of a Linux operating system running within the instance.

This value can be used to reference the device for mounting, resizing, and so on, from within the instance. ||
|| diskSpec | **[DiskSpec](#yandex.cloud.compute.v1.instancegroup.AttachedDiskSpec.DiskSpec)**

Required field. oneof disk_spec or disk_id
Disk specification that is attached to the instance. For more information, see [Disks](/docs/compute/concepts/disk). ||
|| diskId | **string**

Set to use an existing disk. To set use variables. ||
|| name | **string**

When set can be later used to change DiskSpec of actual disk. ||
|#

## DiskSpec {#yandex.cloud.compute.v1.instancegroup.AttachedDiskSpec.DiskSpec}

#|
||Field | Description ||
|| description | **string**

Description of the disk. ||
|| typeId | **string**

Required field. ID of the disk type. ||
|| size | **int64**

Size of the disk, specified in bytes. ||
|| imageId | **string**

ID of the image that will be used for disk creation.

Includes only one of the fields `imageId`, `snapshotId`. ||
|| snapshotId | **string**

ID of the snapshot that will be used for disk creation.

Includes only one of the fields `imageId`, `snapshotId`. ||
|| preserveAfterInstanceDelete | **bool**

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
|| dnsRecordSpecs[] | **[DnsRecordSpec](#yandex.cloud.compute.v1.instancegroup.DnsRecordSpec)**

Internal DNS configuration ||
|| address | **string**

Optional. Manual set static internal IP. To set use variables. ||
|#

## OneToOneNatSpec {#yandex.cloud.compute.v1.instancegroup.OneToOneNatSpec}

#|
||Field | Description ||
|| ipVersion | enum **IpVersion**

IP version for the public IP address.

- `IP_VERSION_UNSPECIFIED`
- `IPV4`: IPv4 address, for example 192.168.0.0.
- `IPV6`: IPv6 address, not available yet. ||
|| address | **string**

Manual set static public IP. To set use variables. (optional) ||
|| dnsRecordSpecs[] | **[DnsRecordSpec](#yandex.cloud.compute.v1.instancegroup.DnsRecordSpec)**

External DNS configuration ||
|#

## DnsRecordSpec {#yandex.cloud.compute.v1.instancegroup.DnsRecordSpec}

#|
||Field | Description ||
|| fqdn | **string**

Required field. FQDN (required) ||
|| dnsZoneId | **string**

DNS zone id (optional, if not set, private zone used) ||
|| ttl | **int64**

DNS record ttl, values in 0-86400 (optional) ||
|| ptr | **bool**

When set to true, also create PTR DNS record (optional) ||
|#

## SchedulingPolicy {#yandex.cloud.compute.v1.instancegroup.SchedulingPolicy}

#|
||Field | Description ||
|| preemptible | **bool**

Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time
if their resources are needed by Compute.
For more information, see [Preemptible Virtual Machines](/docs/compute/concepts/preemptible-vm). ||
|#

## NetworkSettings {#yandex.cloud.compute.v1.instancegroup.NetworkSettings}

#|
||Field | Description ||
|| type | enum **Type**

Type of instance network.

- `TYPE_UNSPECIFIED`
- `STANDARD`
- `SOFTWARE_ACCELERATED`
- `HARDWARE_ACCELERATED` ||
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

Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId' ||
|| op | enum **Operator**

Include or exclude action

- `OPERATOR_UNSPECIFIED`
- `IN`
- `NOT_IN` ||
|| values[] | **string**

Affinity value or host ID or host group ID ||
|#

## AttachedFilesystemSpec {#yandex.cloud.compute.v1.instancegroup.AttachedFilesystemSpec}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode of access to the filesystem that should be attached.

- `MODE_UNSPECIFIED`
- `READ_ONLY`: Read-only access.
- `READ_WRITE`: Read/Write access. Default value. ||
|| deviceName | **string**

Name of the device representing the filesystem on the instance.

The name should be used for referencing the filesystem from within the instance
when it's being mounted, resized etc.

If not specified, a random value will be generated. ||
|| filesystemId | **string**

ID of the filesystem that should be attached. ||
|#

## MetadataOptions {#yandex.cloud.compute.v1.instancegroup.MetadataOptions}

#|
||Field | Description ||
|| gceHttpEndpoint | enum **MetadataOption**

Enabled access to GCE flavored metadata

- `METADATA_OPTION_UNSPECIFIED`
- `ENABLED`: Option is enabled
- `DISABLED`: Option is disabled ||
|| awsV1HttpEndpoint | enum **MetadataOption**

Enabled access to AWS flavored metadata (IMDSv1)

- `METADATA_OPTION_UNSPECIFIED`
- `ENABLED`: Option is enabled
- `DISABLED`: Option is disabled ||
|| gceHttpToken | enum **MetadataOption**

Enabled access to IAM credentials with GCE flavored metadata

- `METADATA_OPTION_UNSPECIFIED`
- `ENABLED`: Option is enabled
- `DISABLED`: Option is disabled ||
|| awsV1HttpToken | enum **MetadataOption**

Enabled access to IAM credentials with AWS flavored metadata (IMDSv1)

- `METADATA_OPTION_UNSPECIFIED`
- `ENABLED`: Option is enabled
- `DISABLED`: Option is disabled ||
|#

## ScalePolicy {#yandex.cloud.compute.v1.instancegroup.ScalePolicy}

#|
||Field | Description ||
|| fixedScale | **[FixedScale](#yandex.cloud.compute.v1.instancegroup.ScalePolicy.FixedScale)**

[Manual scaling policy](/docs/compute/concepts/instance-groups/scale#fixed-policy) of the instance group.

Includes only one of the fields `fixedScale`, `autoScale`. ||
|| autoScale | **[AutoScale](#yandex.cloud.compute.v1.instancegroup.ScalePolicy.AutoScale)**

[Automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group.

Includes only one of the fields `fixedScale`, `autoScale`. ||
|| testAutoScale | **[AutoScale](#yandex.cloud.compute.v1.instancegroup.ScalePolicy.AutoScale)**

Test spec for [automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group. ||
|#

## FixedScale {#yandex.cloud.compute.v1.instancegroup.ScalePolicy.FixedScale}

#|
||Field | Description ||
|| size | **int64**

Number of instances in the instance group. ||
|#

## AutoScale {#yandex.cloud.compute.v1.instancegroup.ScalePolicy.AutoScale}

#|
||Field | Description ||
|| minZoneSize | **int64**

Lower limit for instance count in each zone. ||
|| maxSize | **int64**

Upper limit for total instance count (across all zones).
0 means maximum limit = 100. ||
|| measurementDuration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Time in seconds allotted for averaging metrics.
1 minute by default. ||
|| warmupDuration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

The warmup time of the instance in seconds. During this time,
traffic is sent to the instance, but instance metrics are not collected. ||
|| stabilizationDuration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Minimum amount of time in seconds allotted for monitoring before
Instance Groups can reduce the number of instances in the group.
During this time, the group size doesn't decrease, even if the new metric values
indicate that it should. ||
|| initialSize | **int64**

Target group size. ||
|| cpuUtilizationRule | **[CpuUtilizationRule](#yandex.cloud.compute.v1.instancegroup.ScalePolicy.CpuUtilizationRule)**

Defines an autoscaling rule based on the average CPU utilization of the instance group.

If more than one rule is specified, e.g. CPU utilization and one or more Monitoring metrics (`customRules`),
the size of the instance group will be equal to the maximum of sizes calculated according to each metric. ||
|| customRules[] | **[CustomRule](#yandex.cloud.compute.v1.instancegroup.ScalePolicy.CustomRule)**

Defines an autoscaling rule based on a [custom metric](/docs/monitoring/operations/metric/add) from Monitoring.

If more than one rule is specified, e.g. CPU utilization (`cpuUtilizationRule`) and one or more Monitoring
metrics, the size of the instance group will be equal to the maximum of sizes calculated according to each metric. ||
|| autoScaleType | enum **AutoScaleType**

Autoscaling type.

- `AUTO_SCALE_TYPE_UNSPECIFIED`
- `ZONAL`: Scale each zone independently. This is the default.
- `REGIONAL`: Scale group as a whole. ||
|#

## CpuUtilizationRule {#yandex.cloud.compute.v1.instancegroup.ScalePolicy.CpuUtilizationRule}

#|
||Field | Description ||
|| utilizationTarget | **double**

Target CPU utilization level. Instance Groups maintains this level for each availability zone. ||
|#

## CustomRule {#yandex.cloud.compute.v1.instancegroup.ScalePolicy.CustomRule}

#|
||Field | Description ||
|| ruleType | enum **RuleType**

Required field. Custom metric rule type. This field affects which label from
the custom metric should be used: `zone_id` or `instance_id`.

- `RULE_TYPE_UNSPECIFIED`
- `UTILIZATION`: This type means that the metric applies to one instance.
First, Instance Groups calculates the average metric value for each instance,
then averages the values for instances in one availability zone or in whole group depends on autoscaling type.
This type of metric must have the `instance_id` label.
- `WORKLOAD`: This type means that the metric applies to instances in one availability zone or to whole group depends on autoscaling type.
This type of metric must have the `zone_id` label if ZONAL autoscaling type is chosen. ||
|| metricType | enum **MetricType**

Required field. Type of custom metric. This field affects how Instance Groups calculates the average metric value.

- `METRIC_TYPE_UNSPECIFIED`
- `GAUGE`: This type is used for metrics that show the metric value at a certain point in time,
such as requests per second to the server on an instance.

  Instance Groups calculates the average metric value for the period
specified in the [AutoScale.measurementDuration](#yandex.cloud.compute.v1.instancegroup.ScalePolicy.AutoScale) field.
- `COUNTER`: This type is used for metrics that monotonically increase over time,
such as the total number of requests to the server on an instance.

  Instance Groups calculates the average value increase for the period
specified in the [AutoScale.measurementDuration](#yandex.cloud.compute.v1.instancegroup.ScalePolicy.AutoScale) field. ||
|| metricName | **string**

Required field. Name of custom metric in Monitoring that should be used for scaling. ||
|| labels | **string**

Labels of custom metric in Monitoring that should be used for scaling. ||
|| target | **double**

Target value for the custom metric. Instance Groups maintains this level for each availability zone. ||
|| folderId | **string**

Folder id of custom metric in Monitoring that should be used for scaling. ||
|| service | **string**

Service of custom metric in Monitoring that should be used for scaling. ||
|#

## DeployPolicy {#yandex.cloud.compute.v1.instancegroup.DeployPolicy}

#|
||Field | Description ||
|| maxUnavailable | **int64**

The maximum number of running instances that can be taken offline (i.e., stopped or deleted) at the same time
during the update process.
If `maxExpansion` is not specified or set to zero, `maxUnavailable` must be set to a non-zero value. ||
|| maxDeleting | **int64**

The maximum number of instances that can be deleted at the same time.

The value 0 is any number of virtual machines within the allowed values. ||
|| maxCreating | **int64**

The maximum number of instances that can be created at the same time.

The value 0 is any number of virtual machines within the allowed values. ||
|| maxExpansion | **int64**

The maximum number of instances that can be temporarily allocated above the group's target size
during the update process.
If `maxUnavailable` is not specified or set to zero, `maxExpansion` must be set to a non-zero value. ||
|| startupDuration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Instance startup duration.
Instance will be considered up and running (and start receiving traffic) only after startup_duration
has elapsed and all health checks are passed.
See [yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status](/docs/compute/api-ref/grpc/InstanceGroup/listInstances#yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status) for more information. ||
|| strategy | enum **Strategy**

Affects the lifecycle of the instance during deployment.

- `STRATEGY_UNSPECIFIED`
- `PROACTIVE`: Instance Groups can forcefully stop a running instance. This is the default.
- `OPPORTUNISTIC`: Instance Groups does not stop a running instance.
Instead, it will wait until the instance stops itself or becomes unhealthy. ||
|| minimalAction | enum **MinimalAction**

If instance update requires a less disruptive action than `minimalAction`,
Instance Groups performs `minimalAction` to execute the update

- `MINIMAL_ACTION_UNSPECIFIED`
- `LIVE_UPDATE`: Updating an instance without stopping. This is the default.
- `RESTART`: Updating an instance with restart: stopping and then starting the instance.
- `RECREATE`: Re-creating an instance: deleting an instance and creating a new one. ||
|#

## AllocationPolicy {#yandex.cloud.compute.v1.instancegroup.AllocationPolicy}

#|
||Field | Description ||
|| zones[] | **[Zone](#yandex.cloud.compute.v1.instancegroup.AllocationPolicy.Zone)**

List of availability zones. ||
|#

## Zone {#yandex.cloud.compute.v1.instancegroup.AllocationPolicy.Zone}

#|
||Field | Description ||
|| zoneId | **string**

Required field. ID of the availability zone where the instance resides. ||
|| instanceTagsPool[] | **string**

Each instance in a zone will be associated with exactly one of a tag from a pool below.
All specified tags must be unique across the whole group not only the zone.
It is guaranteed that during whole deploy only tags from prefix of the specified list will be used.
It is possible to use tag associated with instance in templating via {instance.tag}. ||
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
|| targetSize | **int64**

Target number of instances for this instance group. ||
|| runningActualCount | **int64**

The number of running instances that match the current instance template. For more information, see [ManagedInstance.Status.RUNNING_ACTUAL](/docs/compute/api-ref/grpc/InstanceGroup/listInstances#yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status). ||
|| runningOutdatedCount | **int64**

The number of running instances that does not match the current instance template. For more information, see [ManagedInstance.Status.RUNNING_OUTDATED](/docs/compute/api-ref/grpc/InstanceGroup/listInstances#yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status). ||
|| processingCount | **int64**

The number of instances in flight (for example, updating, starting, deleting). For more information, see [ManagedInstance.Status](/docs/compute/api-ref/grpc/InstanceGroup/listInstances#yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status). ||
|#

## LoadBalancerSpec {#yandex.cloud.compute.v1.instancegroup.LoadBalancerSpec}

#|
||Field | Description ||
|| targetGroupSpec | **[TargetGroupSpec](#yandex.cloud.compute.v1.instancegroup.TargetGroupSpec)**

Specification of the target group that the instance group will be added to. For more information, see [Target groups and resources](/docs/network-load-balancer/concepts/target-resources). ||
|| maxOpeningTrafficDuration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded,
the VM will be turned off based on the deployment policy. Specified in seconds. ||
|| ignoreHealthChecks | **bool**

Do not wait load balancer health checks. ||
|#

## TargetGroupSpec {#yandex.cloud.compute.v1.instancegroup.TargetGroupSpec}

#|
||Field | Description ||
|| name | **string**

Name of the target group. ||
|| description | **string**

Description of the target group. ||
|| labels | **string**

Resource labels as `key:value` pairs. ||
|#

## HealthChecksSpec {#yandex.cloud.compute.v1.instancegroup.HealthChecksSpec}

#|
||Field | Description ||
|| healthCheckSpecs[] | **[HealthCheckSpec](#yandex.cloud.compute.v1.instancegroup.HealthCheckSpec)**

Health checking specification. For more information, see [Health check](/docs/network-load-balancer/concepts/health-check). ||
|| maxCheckingHealthDuration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Timeout for waiting for the VM to become healthy. If the timeout is exceeded,
the VM will be turned off based on the deployment policy. Specified in seconds. ||
|#

## HealthCheckSpec {#yandex.cloud.compute.v1.instancegroup.HealthCheckSpec}

#|
||Field | Description ||
|| interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

The interval between health checks. The default is 2 seconds. ||
|| timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Timeout for the managed instance to return a response for the health check. The default is 1 second. ||
|| unhealthyThreshold | **int64**

The number of failed health checks for the managed instance to be considered unhealthy. The default (0) is 2. ||
|| healthyThreshold | **int64**

The number of successful health checks required in order for the managed instance to be considered healthy. The default (0) is 2. ||
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
|| port | **int64**

Port to use for TCP health checks. ||
|#

## HttpOptions {#yandex.cloud.compute.v1.instancegroup.HealthCheckSpec.HttpOptions}

#|
||Field | Description ||
|| port | **int64**

Port to use for HTTP health checks. ||
|| path | **string**

URL path to set for health checking requests. ||
|#

## Variable {#yandex.cloud.compute.v1.instancegroup.Variable}

#|
||Field | Description ||
|| key | **string** ||
|| value | **string** ||
|#

## ApplicationLoadBalancerSpec {#yandex.cloud.compute.v1.instancegroup.ApplicationLoadBalancerSpec}

#|
||Field | Description ||
|| targetGroupSpec | **[ApplicationTargetGroupSpec](#yandex.cloud.compute.v1.instancegroup.ApplicationTargetGroupSpec)**

Required field. Basic properties of the Application Load Balancer target group attributed to the instance group. ||
|| maxOpeningTrafficDuration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded,
the VM will be turned off based on the deployment policy. Specified in seconds. ||
|| ignoreHealthChecks | **bool**

Do not wait load balancer health checks. ||
|#

## ApplicationTargetGroupSpec {#yandex.cloud.compute.v1.instancegroup.ApplicationTargetGroupSpec}

#|
||Field | Description ||
|| name | **string**

Name of the target group. ||
|| description | **string**

Description of the target group. ||
|| labels | **string**

Resource labels as `key:value` pairs. ||
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
|| autoHealingAction | enum **AutoHealingAction**

Instance Groups performs `autoHealingAction` when instance becomes unhealthy.

- `AUTO_HEALING_ACTION_UNSPECIFIED`
- `RESTART`: Re-starting an instance with restart: stopping and then starting the instance.
- `RECREATE`: Re-creating an instance: deleting an instance and creating a new one.
- `NONE`: No action ||
|#