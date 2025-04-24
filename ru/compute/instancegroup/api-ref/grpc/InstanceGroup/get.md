---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/instancegroup/api-ref/grpc/InstanceGroup/get.md
---

# Compute Cloud Instance Groups API, gRPC: InstanceGroupService.Get

Returns the specified InstanceGroup resource.

To get the list of available InstanceGroup resources, make a [List](/docs/compute/instancegroup/api-ref/grpc/InstanceGroup/list#List) request.

## gRPC request

**rpc Get ([GetInstanceGroupRequest](#yandex.cloud.compute.v1.instancegroup.GetInstanceGroupRequest)) returns ([InstanceGroup](#yandex.cloud.compute.v1.instancegroup.InstanceGroup))**

## GetInstanceGroupRequest {#yandex.cloud.compute.v1.instancegroup.GetInstanceGroupRequest}

```json
{
  "instance_group_id": "string",
  "view": "InstanceGroupView"
}
```

#|
||Field | Description ||
|| instance_group_id | **string**

Required field. ID of the InstanceGroup resource to return.
To get the instance group ID, use a [InstanceGroupService.List](/docs/compute/instancegroup/api-ref/grpc/InstanceGroup/list#List) request. ||
|| view | enum **InstanceGroupView**

Defines which information about the Instance template should be returned in the server response.

- `BASIC`: Doesn't include the metadata of the instance template in the server response.
- `FULL`: Returns the metadata of the instance template in the server response. ||
|#

## InstanceGroup {#yandex.cloud.compute.v1.instancegroup.InstanceGroup}

```json
{
  "id": "string",
  "folder_id": "string",
  "created_at": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "instance_template": {
    "description": "string",
    "labels": "map<string, string>",
    "platform_id": "string",
    "resources_spec": {
      "memory": "int64",
      "cores": "int64",
      "core_fraction": "int64",
      "gpus": "int64"
    },
    "metadata": "map<string, string>",
    "boot_disk_spec": {
      "mode": "Mode",
      "device_name": "string",
      "disk_spec": {
        "description": "string",
        "type_id": "string",
        "size": "int64",
        // Includes only one of the fields `image_id`, `snapshot_id`
        "image_id": "string",
        "snapshot_id": "string",
        // end of the list of possible fields
        "preserve_after_instance_delete": "bool"
      },
      "disk_id": "string",
      "name": "string"
    },
    "secondary_disk_specs": [
      {
        "mode": "Mode",
        "device_name": "string",
        "disk_spec": {
          "description": "string",
          "type_id": "string",
          "size": "int64",
          // Includes only one of the fields `image_id`, `snapshot_id`
          "image_id": "string",
          "snapshot_id": "string",
          // end of the list of possible fields
          "preserve_after_instance_delete": "bool"
        },
        "disk_id": "string",
        "name": "string"
      }
    ],
    "network_interface_specs": [
      {
        "network_id": "string",
        "subnet_ids": [
          "string"
        ],
        "primary_v4_address_spec": {
          "one_to_one_nat_spec": {
            "ip_version": "IpVersion",
            "address": "string",
            "dns_record_specs": [
              {
                "fqdn": "string",
                "dns_zone_id": "string",
                "ttl": "int64",
                "ptr": "bool"
              }
            ]
          },
          "dns_record_specs": [
            {
              "fqdn": "string",
              "dns_zone_id": "string",
              "ttl": "int64",
              "ptr": "bool"
            }
          ],
          "address": "string"
        },
        "primary_v6_address_spec": {
          "one_to_one_nat_spec": {
            "ip_version": "IpVersion",
            "address": "string",
            "dns_record_specs": [
              {
                "fqdn": "string",
                "dns_zone_id": "string",
                "ttl": "int64",
                "ptr": "bool"
              }
            ]
          },
          "dns_record_specs": [
            {
              "fqdn": "string",
              "dns_zone_id": "string",
              "ttl": "int64",
              "ptr": "bool"
            }
          ],
          "address": "string"
        },
        "security_group_ids": [
          "string"
        ]
      }
    ],
    "scheduling_policy": {
      "preemptible": "bool"
    },
    "service_account_id": "string",
    "network_settings": {
      "type": "Type"
    },
    "name": "string",
    "hostname": "string",
    "placement_policy": {
      "placement_group_id": "string",
      "host_affinity_rules": [
        {
          "key": "string",
          "op": "Operator",
          "values": [
            "string"
          ]
        }
      ]
    },
    "filesystem_specs": [
      {
        "mode": "Mode",
        "device_name": "string",
        "filesystem_id": "string"
      }
    ],
    "metadata_options": {
      "gce_http_endpoint": "MetadataOption",
      "aws_v1_http_endpoint": "MetadataOption",
      "gce_http_token": "MetadataOption",
      "aws_v1_http_token": "MetadataOption"
    }
  },
  "scale_policy": {
    // Includes only one of the fields `fixed_scale`, `auto_scale`
    "fixed_scale": {
      "size": "int64"
    },
    "auto_scale": {
      "min_zone_size": "int64",
      "max_size": "int64",
      "measurement_duration": "google.protobuf.Duration",
      "warmup_duration": "google.protobuf.Duration",
      "stabilization_duration": "google.protobuf.Duration",
      "initial_size": "int64",
      "cpu_utilization_rule": {
        "utilization_target": "double"
      },
      "custom_rules": [
        {
          "rule_type": "RuleType",
          "metric_type": "MetricType",
          "metric_name": "string",
          "labels": "map<string, string>",
          "target": "double",
          "folder_id": "string",
          "service": "string"
        }
      ],
      "auto_scale_type": "AutoScaleType"
    },
    // end of the list of possible fields
    "test_auto_scale": {
      "min_zone_size": "int64",
      "max_size": "int64",
      "measurement_duration": "google.protobuf.Duration",
      "warmup_duration": "google.protobuf.Duration",
      "stabilization_duration": "google.protobuf.Duration",
      "initial_size": "int64",
      "cpu_utilization_rule": {
        "utilization_target": "double"
      },
      "custom_rules": [
        {
          "rule_type": "RuleType",
          "metric_type": "MetricType",
          "metric_name": "string",
          "labels": "map<string, string>",
          "target": "double",
          "folder_id": "string",
          "service": "string"
        }
      ],
      "auto_scale_type": "AutoScaleType"
    }
  },
  "deploy_policy": {
    "max_unavailable": "int64",
    "max_deleting": "int64",
    "max_creating": "int64",
    "max_expansion": "int64",
    "startup_duration": "google.protobuf.Duration",
    "strategy": "Strategy",
    "minimal_action": "MinimalAction"
  },
  "allocation_policy": {
    "zones": [
      {
        "zone_id": "string",
        "instance_tags_pool": [
          "string"
        ]
      }
    ]
  },
  "load_balancer_state": {
    "target_group_id": "string",
    "status_message": "string"
  },
  "managed_instances_state": {
    "target_size": "int64",
    "running_actual_count": "int64",
    "running_outdated_count": "int64",
    "processing_count": "int64"
  },
  "load_balancer_spec": {
    "target_group_spec": {
      "name": "string",
      "description": "string",
      "labels": "map<string, string>"
    },
    "max_opening_traffic_duration": "google.protobuf.Duration",
    "ignore_health_checks": "bool"
  },
  "health_checks_spec": {
    "health_check_specs": [
      {
        "interval": "google.protobuf.Duration",
        "timeout": "google.protobuf.Duration",
        "unhealthy_threshold": "int64",
        "healthy_threshold": "int64",
        // Includes only one of the fields `tcp_options`, `http_options`
        "tcp_options": {
          "port": "int64"
        },
        "http_options": {
          "port": "int64",
          "path": "string"
        }
        // end of the list of possible fields
      }
    ],
    "max_checking_health_duration": "google.protobuf.Duration"
  },
  "service_account_id": "string",
  "status": "Status",
  "variables": [
    {
      "key": "string",
      "value": "string"
    }
  ],
  "deletion_protection": "bool",
  "application_load_balancer_spec": {
    "target_group_spec": {
      "name": "string",
      "description": "string",
      "labels": "map<string, string>"
    },
    "max_opening_traffic_duration": "google.protobuf.Duration",
    "ignore_health_checks": "bool"
  },
  "application_load_balancer_state": {
    "target_group_id": "string",
    "status_message": "string"
  },
  "auto_healing_policy": {
    "auto_healing_action": "AutoHealingAction"
  }
}
```

#|
||Field | Description ||
|| id | **string**

ID of the instance group. ||
|| folder_id | **string**

ID of the folder that the instance group belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| name | **string**

Name of the instance group.
The name is unique within the folder. ||
|| description | **string**

Description of the instance group. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|| instance_template | **[InstanceTemplate](#yandex.cloud.compute.v1.instancegroup.InstanceTemplate)**

Instance template for creating the instance group.
For more information, see [Instance Templates](/docs/compute/concepts/instance-groups/instance-template). ||
|| scale_policy | **[ScalePolicy](#yandex.cloud.compute.v1.instancegroup.ScalePolicy)**

[Scaling policy](/docs/compute/concepts/instance-groups/scale) of the instance group. ||
|| deploy_policy | **[DeployPolicy](#yandex.cloud.compute.v1.instancegroup.DeployPolicy)**

Deployment policy of the instance group. ||
|| allocation_policy | **[AllocationPolicy](#yandex.cloud.compute.v1.instancegroup.AllocationPolicy)**

Allocation policy of the instance group by zones and regions. ||
|| load_balancer_state | **[LoadBalancerState](#yandex.cloud.compute.v1.instancegroup.LoadBalancerState)**

Status of the Network Load Balancer target group attributed to the instance group. ||
|| managed_instances_state | **[ManagedInstancesState](#yandex.cloud.compute.v1.instancegroup.ManagedInstancesState)**

States of instances for this instance group. ||
|| load_balancer_spec | **[LoadBalancerSpec](#yandex.cloud.compute.v1.instancegroup.LoadBalancerSpec)**

Settings for balancing load between instances via [Network Load Balancer](/docs/network-load-balancer/concepts)
(OSI model layer 3). ||
|| health_checks_spec | **[HealthChecksSpec](#yandex.cloud.compute.v1.instancegroup.HealthChecksSpec)**

Health checking specification. For more information, see [Health check](/docs/network-load-balancer/concepts/health-check). ||
|| service_account_id | **string**

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

  To stop the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Stop](/docs/compute/instancegroup/api-ref/grpc/InstanceGroup/stop#Stop).
To pause the processes in the instance group, i.e. scaling, checking instances' health,
auto-healing and updating them, without stopping the instances,
call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.PauseProcesses](/docs/compute/instancegroup/api-ref/grpc/InstanceGroup/pauseProcesses#PauseProcesses).
- `STOPPING`: Instance group is being stopped.
Group's instances stop receiving traffic from the load balancer (if any) and are then stopped.
- `STOPPED`: Instance group is stopped.
In this state the group cannot be updated and does not react to any changes made to its instances.
To start the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Start](/docs/compute/instancegroup/api-ref/grpc/InstanceGroup/start#Start).
- `DELETING`: Instance group is being deleted.
- `PAUSED`: Instance group is paused.
In this state all the processes regarding the group management, i.e. scaling, checking instances' health,
auto-healing and updating them, are paused. The instances that were running prior to pausing the group, however,
may still be running.

  To resume the processes in the instance group,
call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.ResumeProcesses](/docs/compute/instancegroup/api-ref/grpc/InstanceGroup/resumeProcesses#ResumeProcesses).
The group status will change to `ACTIVE`. ||
|| variables[] | **[Variable](#yandex.cloud.compute.v1.instancegroup.Variable)** ||
|| deletion_protection | **bool**

Flag prohibiting deletion of the instance group.

Allowed values:</br>- `false`: The instance group can be deleted.</br>- `true`: The instance group cannot be deleted.

The default is `false`. ||
|| application_load_balancer_spec | **[ApplicationLoadBalancerSpec](#yandex.cloud.compute.v1.instancegroup.ApplicationLoadBalancerSpec)**

Settings for balancing load between instances via [Application Load Balancer](/docs/application-load-balancer/concepts)
(OSI model layer 7). ||
|| application_load_balancer_state | **[ApplicationLoadBalancerState](#yandex.cloud.compute.v1.instancegroup.ApplicationLoadBalancerState)**

Status of the Application Load Balancer target group attributed to the instance group.

Returned if there is a working load balancer that the target group is connected to. ||
|| auto_healing_policy | **[AutoHealingPolicy](#yandex.cloud.compute.v1.instancegroup.AutoHealingPolicy)**

AutoHealingPolicy policy of the instance group. ||
|#

## InstanceTemplate {#yandex.cloud.compute.v1.instancegroup.InstanceTemplate}

#|
||Field | Description ||
|| description | **string**

Description of the instance template. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|| platform_id | **string**

Required field. ID of the hardware platform configuration for the instance.
Platforms allows you to create various types of instances: with a large amount of memory,
with a large number of cores, with a burstable performance.
For more information, see [Platforms](/docs/compute/concepts/vm-platforms). ||
|| resources_spec | **[ResourcesSpec](#yandex.cloud.compute.v1.instancegroup.ResourcesSpec)**

Required field. Computing resources of the instance such as the amount of memory and number of cores. ||
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
For more information, see [Metadata](/docs/compute/concepts/vm-metadata). ||
|| boot_disk_spec | **[AttachedDiskSpec](#yandex.cloud.compute.v1.instancegroup.AttachedDiskSpec)**

Required field. Boot disk specification that will be attached to the instance. ||
|| secondary_disk_specs[] | **[AttachedDiskSpec](#yandex.cloud.compute.v1.instancegroup.AttachedDiskSpec)**

Array of secondary disks that will be attached to the instance. ||
|| network_interface_specs[] | **[NetworkInterfaceSpec](#yandex.cloud.compute.v1.instancegroup.NetworkInterfaceSpec)**

Required field. Array of network interfaces that will be attached to the instance. ||
|| scheduling_policy | **[SchedulingPolicy](#yandex.cloud.compute.v1.instancegroup.SchedulingPolicy)**

Scheduling policy for the instance. ||
|| service_account_id | **string**

Service account ID for the instance. ||
|| network_settings | **[NetworkSettings](#yandex.cloud.compute.v1.instancegroup.NetworkSettings)**

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
|| placement_policy | **[PlacementPolicy](#yandex.cloud.compute.v1.instancegroup.PlacementPolicy)**

Placement Group ||
|| filesystem_specs[] | **[AttachedFilesystemSpec](#yandex.cloud.compute.v1.instancegroup.AttachedFilesystemSpec)**

Array of filesystems to attach to the instance.

The filesystems must reside in the same availability zone as the instance.

To use the instance with an attached filesystem, the latter must be mounted.
For details, see [documentation](/docs/compute/operations/filesystem/attach-to-vm). ||
|| metadata_options | **[MetadataOptions](#yandex.cloud.compute.v1.instancegroup.MetadataOptions)**

Metadata options for the instance ||
|#

## ResourcesSpec {#yandex.cloud.compute.v1.instancegroup.ResourcesSpec}

#|
||Field | Description ||
|| memory | **int64**

The amount of memory available to the instance, specified in bytes. ||
|| cores | **int64**

The number of cores available to the instance. ||
|| core_fraction | **int64**

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
|| device_name | **string**

Serial number that is reflected in the /dev/disk/by-id/ tree
of a Linux operating system running within the instance.

This value can be used to reference the device for mounting, resizing, and so on, from within the instance. ||
|| disk_spec | **[DiskSpec](#yandex.cloud.compute.v1.instancegroup.AttachedDiskSpec.DiskSpec)**

Required field. oneof disk_spec or disk_id
Disk specification that is attached to the instance. For more information, see [Disks](/docs/compute/concepts/disk). ||
|| disk_id | **string**

Set to use an existing disk. To set use variables. ||
|| name | **string**

When set can be later used to change DiskSpec of actual disk. ||
|#

## DiskSpec {#yandex.cloud.compute.v1.instancegroup.AttachedDiskSpec.DiskSpec}

#|
||Field | Description ||
|| description | **string**

Description of the disk. ||
|| type_id | **string**

Required field. ID of the disk type. ||
|| size | **int64**

Size of the disk, specified in bytes. ||
|| image_id | **string**

ID of the image that will be used for disk creation.

Includes only one of the fields `image_id`, `snapshot_id`. ||
|| snapshot_id | **string**

ID of the snapshot that will be used for disk creation.

Includes only one of the fields `image_id`, `snapshot_id`. ||
|| preserve_after_instance_delete | **bool**

When set to true, disk will not be deleted even after managed instance is deleted.
It will be a user's responsibility to delete such disks. ||
|#

## NetworkInterfaceSpec {#yandex.cloud.compute.v1.instancegroup.NetworkInterfaceSpec}

#|
||Field | Description ||
|| network_id | **string**

ID of the network. ||
|| subnet_ids[] | **string**

IDs of the subnets. ||
|| primary_v4_address_spec | **[PrimaryAddressSpec](#yandex.cloud.compute.v1.instancegroup.PrimaryAddressSpec)**

Primary IPv4 address that is assigned to the instance for this network interface. ||
|| primary_v6_address_spec | **[PrimaryAddressSpec](#yandex.cloud.compute.v1.instancegroup.PrimaryAddressSpec)**

Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet. ||
|| security_group_ids[] | **string**

IDs of security groups. ||
|#

## PrimaryAddressSpec {#yandex.cloud.compute.v1.instancegroup.PrimaryAddressSpec}

#|
||Field | Description ||
|| one_to_one_nat_spec | **[OneToOneNatSpec](#yandex.cloud.compute.v1.instancegroup.OneToOneNatSpec)**

An external IP address configuration.
If not specified, then this managed instance will have no external internet access. ||
|| dns_record_specs[] | **[DnsRecordSpec](#yandex.cloud.compute.v1.instancegroup.DnsRecordSpec)**

Internal DNS configuration ||
|| address | **string**

Optional. Manual set static internal IP. To set use variables. ||
|#

## OneToOneNatSpec {#yandex.cloud.compute.v1.instancegroup.OneToOneNatSpec}

#|
||Field | Description ||
|| ip_version | enum **IpVersion**

IP version for the public IP address.

- `IP_VERSION_UNSPECIFIED`
- `IPV4`: IPv4 address, for example 192.168.0.0.
- `IPV6`: IPv6 address, not available yet. ||
|| address | **string**

Manual set static public IP. To set use variables. (optional) ||
|| dns_record_specs[] | **[DnsRecordSpec](#yandex.cloud.compute.v1.instancegroup.DnsRecordSpec)**

External DNS configuration ||
|#

## DnsRecordSpec {#yandex.cloud.compute.v1.instancegroup.DnsRecordSpec}

#|
||Field | Description ||
|| fqdn | **string**

Required field. FQDN (required) ||
|| dns_zone_id | **string**

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
|| placement_group_id | **string**

Identifier of placement group ||
|| host_affinity_rules[] | **[HostAffinityRule](#yandex.cloud.compute.v1.instancegroup.PlacementPolicy.HostAffinityRule)**

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
|| device_name | **string**

Name of the device representing the filesystem on the instance.

The name should be used for referencing the filesystem from within the instance
when it's being mounted, resized etc.

If not specified, a random value will be generated. ||
|| filesystem_id | **string**

ID of the filesystem that should be attached. ||
|#

## MetadataOptions {#yandex.cloud.compute.v1.instancegroup.MetadataOptions}

#|
||Field | Description ||
|| gce_http_endpoint | enum **MetadataOption**

Enabled access to GCE flavored metadata

- `METADATA_OPTION_UNSPECIFIED`
- `ENABLED`: Option is enabled
- `DISABLED`: Option is disabled ||
|| aws_v1_http_endpoint | enum **MetadataOption**

Enabled access to AWS flavored metadata (IMDSv1)

- `METADATA_OPTION_UNSPECIFIED`
- `ENABLED`: Option is enabled
- `DISABLED`: Option is disabled ||
|| gce_http_token | enum **MetadataOption**

Enabled access to IAM credentials with GCE flavored metadata

- `METADATA_OPTION_UNSPECIFIED`
- `ENABLED`: Option is enabled
- `DISABLED`: Option is disabled ||
|| aws_v1_http_token | enum **MetadataOption**

Enabled access to IAM credentials with AWS flavored metadata (IMDSv1)

- `METADATA_OPTION_UNSPECIFIED`
- `ENABLED`: Option is enabled
- `DISABLED`: Option is disabled ||
|#

## ScalePolicy {#yandex.cloud.compute.v1.instancegroup.ScalePolicy}

#|
||Field | Description ||
|| fixed_scale | **[FixedScale](#yandex.cloud.compute.v1.instancegroup.ScalePolicy.FixedScale)**

[Manual scaling policy](/docs/compute/concepts/instance-groups/scale#fixed-policy) of the instance group.

Includes only one of the fields `fixed_scale`, `auto_scale`. ||
|| auto_scale | **[AutoScale](#yandex.cloud.compute.v1.instancegroup.ScalePolicy.AutoScale)**

[Automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group.

Includes only one of the fields `fixed_scale`, `auto_scale`. ||
|| test_auto_scale | **[AutoScale](#yandex.cloud.compute.v1.instancegroup.ScalePolicy.AutoScale)**

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
|| min_zone_size | **int64**

Lower limit for instance count in each zone. ||
|| max_size | **int64**

Upper limit for total instance count (across all zones).
0 means maximum limit = 100. ||
|| measurement_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Time in seconds allotted for averaging metrics.
1 minute by default. ||
|| warmup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

The warmup time of the instance in seconds. During this time,
traffic is sent to the instance, but instance metrics are not collected. ||
|| stabilization_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Minimum amount of time in seconds allotted for monitoring before
Instance Groups can reduce the number of instances in the group.
During this time, the group size doesn't decrease, even if the new metric values
indicate that it should. ||
|| initial_size | **int64**

Target group size. ||
|| cpu_utilization_rule | **[CpuUtilizationRule](#yandex.cloud.compute.v1.instancegroup.ScalePolicy.CpuUtilizationRule)**

Defines an autoscaling rule based on the average CPU utilization of the instance group.

If more than one rule is specified, e.g. CPU utilization and one or more Monitoring metrics (`custom_rules`),
the size of the instance group will be equal to the maximum of sizes calculated according to each metric. ||
|| custom_rules[] | **[CustomRule](#yandex.cloud.compute.v1.instancegroup.ScalePolicy.CustomRule)**

Defines an autoscaling rule based on a [custom metric](/docs/monitoring/operations/metric/add) from Monitoring.

If more than one rule is specified, e.g. CPU utilization (`cpu_utilization_rule`) and one or more Monitoring
metrics, the size of the instance group will be equal to the maximum of sizes calculated according to each metric. ||
|| auto_scale_type | enum **AutoScaleType**

Autoscaling type.

- `AUTO_SCALE_TYPE_UNSPECIFIED`
- `ZONAL`: Scale each zone independently. This is the default.
- `REGIONAL`: Scale group as a whole. ||
|#

## CpuUtilizationRule {#yandex.cloud.compute.v1.instancegroup.ScalePolicy.CpuUtilizationRule}

#|
||Field | Description ||
|| utilization_target | **double**

Target CPU utilization level. Instance Groups maintains this level for each availability zone. ||
|#

## CustomRule {#yandex.cloud.compute.v1.instancegroup.ScalePolicy.CustomRule}

#|
||Field | Description ||
|| rule_type | enum **RuleType**

Required field. Custom metric rule type. This field affects which label from
the custom metric should be used: `zone_id` or `instance_id`.

- `RULE_TYPE_UNSPECIFIED`
- `UTILIZATION`: This type means that the metric applies to one instance.
First, Instance Groups calculates the average metric value for each instance,
then averages the values for instances in one availability zone or in whole group depends on autoscaling type.
This type of metric must have the `instance_id` label.
- `WORKLOAD`: This type means that the metric applies to instances in one availability zone or to whole group depends on autoscaling type.
This type of metric must have the `zone_id` label if ZONAL autoscaling type is chosen. ||
|| metric_type | enum **MetricType**

Required field. Type of custom metric. This field affects how Instance Groups calculates the average metric value.

- `METRIC_TYPE_UNSPECIFIED`
- `GAUGE`: This type is used for metrics that show the metric value at a certain point in time,
such as requests per second to the server on an instance.

  Instance Groups calculates the average metric value for the period
specified in the [AutoScale.measurement_duration](#yandex.cloud.compute.v1.instancegroup.ScalePolicy.AutoScale) field.
- `COUNTER`: This type is used for metrics that monotonically increase over time,
such as the total number of requests to the server on an instance.

  Instance Groups calculates the average value increase for the period
specified in the [AutoScale.measurement_duration](#yandex.cloud.compute.v1.instancegroup.ScalePolicy.AutoScale) field. ||
|| metric_name | **string**

Required field. Name of custom metric in Monitoring that should be used for scaling. ||
|| labels | **object** (map<**string**, **string**>)

Labels of custom metric in Monitoring that should be used for scaling. ||
|| target | **double**

Target value for the custom metric. Instance Groups maintains this level for each availability zone. ||
|| folder_id | **string**

Folder id of custom metric in Monitoring that should be used for scaling. ||
|| service | **string**

Service of custom metric in Monitoring that should be used for scaling. ||
|#

## DeployPolicy {#yandex.cloud.compute.v1.instancegroup.DeployPolicy}

#|
||Field | Description ||
|| max_unavailable | **int64**

The maximum number of running instances that can be taken offline (i.e., stopped or deleted) at the same time
during the update process.
If `max_expansion` is not specified or set to zero, `max_unavailable` must be set to a non-zero value. ||
|| max_deleting | **int64**

The maximum number of instances that can be deleted at the same time.

The value 0 is any number of virtual machines within the allowed values. ||
|| max_creating | **int64**

The maximum number of instances that can be created at the same time.

The value 0 is any number of virtual machines within the allowed values. ||
|| max_expansion | **int64**

The maximum number of instances that can be temporarily allocated above the group's target size
during the update process.
If `max_unavailable` is not specified or set to zero, `max_expansion` must be set to a non-zero value. ||
|| startup_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Instance startup duration.
Instance will be considered up and running (and start receiving traffic) only after startup_duration
has elapsed and all health checks are passed.
See [ManagedInstance.Status](/docs/compute/instancegroup/api-ref/grpc/InstanceGroup/listInstances#yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status) for more information. ||
|| strategy | enum **Strategy**

Affects the lifecycle of the instance during deployment.

- `STRATEGY_UNSPECIFIED`
- `PROACTIVE`: Instance Groups can forcefully stop a running instance. This is the default.
- `OPPORTUNISTIC`: Instance Groups does not stop a running instance.
Instead, it will wait until the instance stops itself or becomes unhealthy. ||
|| minimal_action | enum **MinimalAction**

If instance update requires a less disruptive action than `minimal_action`,
Instance Groups performs `minimal_action` to execute the update

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
|| zone_id | **string**

Required field. ID of the availability zone where the instance resides. ||
|| instance_tags_pool[] | **string**

Each instance in a zone will be associated with exactly one of a tag from a pool below.
All specified tags must be unique across the whole group not only the zone.
It is guaranteed that during whole deploy only tags from prefix of the specified list will be used.
It is possible to use tag associated with instance in templating via {instance.tag}. ||
|#

## LoadBalancerState {#yandex.cloud.compute.v1.instancegroup.LoadBalancerState}

#|
||Field | Description ||
|| target_group_id | **string**

ID of the Network Load Balancer target group attributed to the instance group. ||
|| status_message | **string**

Status message of the target group. ||
|#

## ManagedInstancesState {#yandex.cloud.compute.v1.instancegroup.ManagedInstancesState}

#|
||Field | Description ||
|| target_size | **int64**

Target number of instances for this instance group. ||
|| running_actual_count | **int64**

The number of running instances that match the current instance template. For more information, see [ManagedInstance.Status.RUNNING_ACTUAL](/docs/compute/instancegroup/api-ref/grpc/InstanceGroup/listInstances#yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status). ||
|| running_outdated_count | **int64**

The number of running instances that does not match the current instance template. For more information, see [ManagedInstance.Status.RUNNING_OUTDATED](/docs/compute/instancegroup/api-ref/grpc/InstanceGroup/listInstances#yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status). ||
|| processing_count | **int64**

The number of instances in flight (for example, updating, starting, deleting). For more information, see [ManagedInstance.Status](/docs/compute/instancegroup/api-ref/grpc/InstanceGroup/listInstances#yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status). ||
|#

## LoadBalancerSpec {#yandex.cloud.compute.v1.instancegroup.LoadBalancerSpec}

#|
||Field | Description ||
|| target_group_spec | **[TargetGroupSpec](#yandex.cloud.compute.v1.instancegroup.TargetGroupSpec)**

Specification of the target group that the instance group will be added to. For more information, see [Target groups and resources](/docs/network-load-balancer/concepts/target-resources). ||
|| max_opening_traffic_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded,
the VM will be turned off based on the deployment policy. Specified in seconds. ||
|| ignore_health_checks | **bool**

Do not wait load balancer health checks. ||
|#

## TargetGroupSpec {#yandex.cloud.compute.v1.instancegroup.TargetGroupSpec}

#|
||Field | Description ||
|| name | **string**

Name of the target group. ||
|| description | **string**

Description of the target group. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|#

## HealthChecksSpec {#yandex.cloud.compute.v1.instancegroup.HealthChecksSpec}

#|
||Field | Description ||
|| health_check_specs[] | **[HealthCheckSpec](#yandex.cloud.compute.v1.instancegroup.HealthCheckSpec)**

Health checking specification. For more information, see [Health check](/docs/network-load-balancer/concepts/health-check). ||
|| max_checking_health_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

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
|| unhealthy_threshold | **int64**

The number of failed health checks for the managed instance to be considered unhealthy. The default (0) is 2. ||
|| healthy_threshold | **int64**

The number of successful health checks required in order for the managed instance to be considered healthy. The default (0) is 2. ||
|| tcp_options | **[TcpOptions](#yandex.cloud.compute.v1.instancegroup.HealthCheckSpec.TcpOptions)**

Configuration options for a TCP health check.

Includes only one of the fields `tcp_options`, `http_options`. ||
|| http_options | **[HttpOptions](#yandex.cloud.compute.v1.instancegroup.HealthCheckSpec.HttpOptions)**

Configuration options for an HTTP health check.

Includes only one of the fields `tcp_options`, `http_options`. ||
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
|| target_group_spec | **[ApplicationTargetGroupSpec](#yandex.cloud.compute.v1.instancegroup.ApplicationTargetGroupSpec)**

Required field. Basic properties of the Application Load Balancer target group attributed to the instance group. ||
|| max_opening_traffic_duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded,
the VM will be turned off based on the deployment policy. Specified in seconds. ||
|| ignore_health_checks | **bool**

Do not wait load balancer health checks. ||
|#

## ApplicationTargetGroupSpec {#yandex.cloud.compute.v1.instancegroup.ApplicationTargetGroupSpec}

#|
||Field | Description ||
|| name | **string**

Name of the target group. ||
|| description | **string**

Description of the target group. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|#

## ApplicationLoadBalancerState {#yandex.cloud.compute.v1.instancegroup.ApplicationLoadBalancerState}

#|
||Field | Description ||
|| target_group_id | **string**

ID of the Application Load Balancer target group attributed to the instance group. ||
|| status_message | **string**

Status message of the target group. ||
|#

## AutoHealingPolicy {#yandex.cloud.compute.v1.instancegroup.AutoHealingPolicy}

#|
||Field | Description ||
|| auto_healing_action | enum **AutoHealingAction**

Instance Groups performs `auto_healing_action` when instance becomes unhealthy.

- `AUTO_HEALING_ACTION_UNSPECIFIED`
- `RESTART`: Re-starting an instance with restart: stopping and then starting the instance.
- `RECREATE`: Re-creating an instance: deleting an instance and creating a new one.
- `NONE`: No action ||
|#