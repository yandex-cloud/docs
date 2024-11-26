---
editable: false
sourcePath: en/_api-ref-grpc/k8s/v1/managed-kubernetes/api-ref/grpc/NodeGroup/update.md
---

# Managed Services for Kubernetes API, gRPC: NodeGroupService.Update

Updates the specified node group.

## gRPC request

**rpc Update ([UpdateNodeGroupRequest](#yandex.cloud.k8s.v1.UpdateNodeGroupRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateNodeGroupRequest {#yandex.cloud.k8s.v1.UpdateNodeGroupRequest}

```json
{
  "node_group_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "labels": "string",
  "node_template": {
    "name": "string",
    "labels": "string",
    "platform_id": "string",
    "resources_spec": {
      "memory": "int64",
      "cores": "int64",
      "core_fraction": "int64",
      "gpus": "int64"
    },
    "boot_disk_spec": {
      "disk_type_id": "string",
      "disk_size": "int64"
    },
    "metadata": "string",
    "v4_address_spec": {
      "one_to_one_nat_spec": {
        "ip_version": "IpVersion"
      },
      "dns_record_specs": [
        {
          "fqdn": "string",
          "dns_zone_id": "string",
          "ttl": "int64",
          "ptr": "bool"
        }
      ]
    },
    "scheduling_policy": {
      "preemptible": "bool"
    },
    "network_interface_specs": [
      {
        "subnet_ids": [
          "string"
        ],
        "primary_v4_address_spec": {
          "one_to_one_nat_spec": {
            "ip_version": "IpVersion"
          },
          "dns_record_specs": [
            {
              "fqdn": "string",
              "dns_zone_id": "string",
              "ttl": "int64",
              "ptr": "bool"
            }
          ]
        },
        "primary_v6_address_spec": {
          "one_to_one_nat_spec": {
            "ip_version": "IpVersion"
          },
          "dns_record_specs": [
            {
              "fqdn": "string",
              "dns_zone_id": "string",
              "ttl": "int64",
              "ptr": "bool"
            }
          ]
        },
        "security_group_ids": [
          "string"
        ]
      }
    ],
    "placement_policy": {
      "placement_group_id": "string"
    },
    "network_settings": {
      "type": "Type"
    },
    "container_runtime_settings": {
      "type": "Type"
    },
    "container_network_settings": {
      "pod_mtu": "int64"
    },
    "gpu_settings": {
      "gpu_cluster_id": "string",
      "gpu_environment": "GpuEnvironment"
    }
  },
  "scale_policy": {
    // Includes only one of the fields `fixed_scale`, `auto_scale`
    "fixed_scale": {
      "size": "int64"
    },
    "auto_scale": {
      "min_size": "int64",
      "max_size": "int64",
      "initial_size": "int64"
    }
    // end of the list of possible fields
  },
  "allocation_policy": {
    "locations": [
      {
        "zone_id": "string",
        "subnet_id": "string"
      }
    ]
  },
  "deploy_policy": {
    "max_unavailable": "int64",
    "max_expansion": "int64"
  },
  "version": {
    // Includes only one of the fields `version`, `latest_revision`
    "version": "string",
    "latest_revision": "bool"
    // end of the list of possible fields
  },
  "maintenance_policy": {
    "auto_upgrade": "bool",
    "auto_repair": "bool",
    "maintenance_window": {
      // Includes only one of the fields `anytime`, `daily_maintenance_window`, `weekly_maintenance_window`
      "anytime": "AnytimeMaintenanceWindow",
      "daily_maintenance_window": {
        "start_time": "google.type.TimeOfDay",
        "duration": "google.protobuf.Duration"
      },
      "weekly_maintenance_window": {
        "days_of_week": [
          {
            "days": [
              "DayOfWeek"
            ],
            "start_time": "google.type.TimeOfDay",
            "duration": "google.protobuf.Duration"
          }
        ]
      }
      // end of the list of possible fields
    }
  },
  "allowed_unsafe_sysctls": [
    "string"
  ],
  "node_taints": [
    {
      "key": "string",
      "value": "string",
      "effect": "Effect"
    }
  ],
  "node_labels": "string"
}
```

#|
||Field | Description ||
|| node_group_id | **string**

Required field. ID of the node group to update.
To get the node group ID use a [NodeGroupService.List](/docs/managed-kubernetes/managed-kubernetes/api-ref/grpc/NodeGroup/list#List) request. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the node group are going to be updated. ||
|| name | **string**

Name of the node group.
The name must be unique within the folder. ||
|| description | **string**

Description of the node group. ||
|| labels | **string**

Resource labels as `key:value` pairs.

Existing set of `labels` is completely replaced by the provided set. ||
|| node_template | **[NodeTemplate](#yandex.cloud.k8s.v1.NodeTemplate)**

Node template for the node group.
Change may trigger nodes rolling reboot or recreate. ||
|| scale_policy | **[ScalePolicy](#yandex.cloud.k8s.v1.ScalePolicy)**

Scale policy of the node group. ||
|| allocation_policy | **[NodeGroupAllocationPolicy](#yandex.cloud.k8s.v1.NodeGroupAllocationPolicy)**

Allocation policy of the node group by the zones and regions. ||
|| deploy_policy | **[DeployPolicy](#yandex.cloud.k8s.v1.DeployPolicy)**

Deploy policy according to which the updates are rolled out. If not specified,
the default is used. ||
|| version | **[UpdateVersionSpec](#yandex.cloud.k8s.v1.UpdateVersionSpec)**

Version of Kubernetes components that runs on the nodes. ||
|| maintenance_policy | **[NodeGroupMaintenancePolicy](#yandex.cloud.k8s.v1.NodeGroupMaintenancePolicy)**

Maintenance policy of the node group. ||
|| allowed_unsafe_sysctls[] | **string**

Support for unsafe sysctl parameters. For more details see [documentation](https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/). ||
|| node_taints[] | **[Taint](#yandex.cloud.k8s.v1.Taint)**

Taints that are applied to the nodes of the node group at creation time. ||
|| node_labels | **string**

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
|| labels | **string**

these labels will be assigned to compute nodes (instances), created by the nodegroup ||
|| platform_id | **string**

ID of the hardware platform configuration for the node. ||
|| resources_spec | **[ResourcesSpec](#yandex.cloud.k8s.v1.ResourcesSpec)**

Computing resources of the node such as the amount of memory and number of cores. ||
|| boot_disk_spec | **[DiskSpec](#yandex.cloud.k8s.v1.DiskSpec)**

Specification for the boot disk that will be attached to the node. ||
|| metadata | **string**

The metadata as `key:value` pairs assigned to this instance template. Only SSH keys are supported as metadata.

For more information, see [Connecting to a node over SSH](/docs/managed-kubernetes/operations/node-connect-ssh). ||
|| v4_address_spec | **[NodeAddressSpec](#yandex.cloud.k8s.v1.NodeAddressSpec)**

Specification for the create network interfaces for the node group compute instances.
Deprecated, please use network_interface_specs. ||
|| scheduling_policy | **[SchedulingPolicy](#yandex.cloud.k8s.v1.SchedulingPolicy)**

Scheduling policy configuration. ||
|| network_interface_specs[] | **[NetworkInterfaceSpec](#yandex.cloud.k8s.v1.NetworkInterfaceSpec)**

New api, to specify network interfaces for the node group compute instances.
Can not be used together with 'v4_address_spec' ||
|| placement_policy | **[PlacementPolicy](#yandex.cloud.k8s.v1.PlacementPolicy)** ||
|| network_settings | **[NetworkSettings](#yandex.cloud.k8s.v1.NodeTemplate.NetworkSettings)**

this parameter allows to specify type of network acceleration used on nodes (instances) ||
|| container_runtime_settings | **[ContainerRuntimeSettings](#yandex.cloud.k8s.v1.NodeTemplate.ContainerRuntimeSettings)** ||
|| container_network_settings | **[ContainerNetworkSettings](#yandex.cloud.k8s.v1.NodeTemplate.ContainerNetworkSettings)** ||
|| gpu_settings | **[GpuSettings](#yandex.cloud.k8s.v1.GpuSettings)**

GPU settings ||
|#

## ResourcesSpec {#yandex.cloud.k8s.v1.ResourcesSpec}

#|
||Field | Description ||
|| memory | **int64**

Amount of memory available to the node, specified in bytes. ||
|| cores | **int64**

Number of cores available to the node. ||
|| core_fraction | **int64**

Baseline level of CPU performance with the possibility to burst performance above that baseline level.
This field sets baseline performance for each core. ||
|| gpus | **int64**

Number of GPUs available to the node. ||
|#

## DiskSpec {#yandex.cloud.k8s.v1.DiskSpec}

#|
||Field | Description ||
|| disk_type_id | **string**

ID of the disk type. ||
|| disk_size | **int64**

Size of the disk, specified in bytes. ||
|#

## NodeAddressSpec {#yandex.cloud.k8s.v1.NodeAddressSpec}

#|
||Field | Description ||
|| one_to_one_nat_spec | **[OneToOneNatSpec](#yandex.cloud.k8s.v1.OneToOneNatSpec)**

One-to-one NAT configuration. Setting up one-to-one NAT ensures that public IP addresses are assigned to nodes, and therefore internet is accessible for all nodes of the node group. If the field is not set, NAT will not be set up. ||
|| dns_record_specs[] | **[DnsRecordSpec](#yandex.cloud.k8s.v1.DnsRecordSpec)**

Internal DNS configuration. ||
|#

## OneToOneNatSpec {#yandex.cloud.k8s.v1.OneToOneNatSpec}

#|
||Field | Description ||
|| ip_version | enum **IpVersion**

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
|| dns_zone_id | **string**

DNS zone id (optional, if not set, private zone is used). ||
|| ttl | **int64**

DNS record ttl, values in 0-86400 (optional). ||
|| ptr | **bool**

When set to true, also create PTR DNS record (optional). ||
|#

## SchedulingPolicy {#yandex.cloud.k8s.v1.SchedulingPolicy}

#|
||Field | Description ||
|| preemptible | **bool**

True for preemptible compute instances. Default value is false. Preemptible compute instances are stopped at least once every 24 hours, and can be stopped at any time
if their resources are needed by Compute.
For more information, see [Preemptible Virtual Machines](/docs/compute/concepts/preemptible-vm). ||
|#

## NetworkInterfaceSpec {#yandex.cloud.k8s.v1.NetworkInterfaceSpec}

#|
||Field | Description ||
|| subnet_ids[] | **string**

IDs of the subnets. ||
|| primary_v4_address_spec | **[NodeAddressSpec](#yandex.cloud.k8s.v1.NodeAddressSpec)**

Primary IPv4 address that is assigned to the instance for this network interface. ||
|| primary_v6_address_spec | **[NodeAddressSpec](#yandex.cloud.k8s.v1.NodeAddressSpec)**

Primary IPv6 address that is assigned to the instance for this network interface. ||
|| security_group_ids[] | **string**

IDs of security groups. ||
|#

## PlacementPolicy {#yandex.cloud.k8s.v1.PlacementPolicy}

#|
||Field | Description ||
|| placement_group_id | **string**

Identifier of placement group ||
|#

## NetworkSettings {#yandex.cloud.k8s.v1.NodeTemplate.NetworkSettings}

#|
||Field | Description ||
|| type | enum **Type**

Required field. 

- `TYPE_UNSPECIFIED`
- `STANDARD`
- `SOFTWARE_ACCELERATED` ||
|#

## ContainerRuntimeSettings {#yandex.cloud.k8s.v1.NodeTemplate.ContainerRuntimeSettings}

#|
||Field | Description ||
|| type | enum **Type**

Required field. 

- `TYPE_UNSPECIFIED`
- `DOCKER`
- `CONTAINERD` ||
|#

## ContainerNetworkSettings {#yandex.cloud.k8s.v1.NodeTemplate.ContainerNetworkSettings}

#|
||Field | Description ||
|| pod_mtu | **int64** ||
|#

## GpuSettings {#yandex.cloud.k8s.v1.GpuSettings}

#|
||Field | Description ||
|| gpu_cluster_id | **string**

GPU cluster id, that mk8s node will join. ||
|| gpu_environment | enum **GpuEnvironment**

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
|| fixed_scale | **[FixedScale](#yandex.cloud.k8s.v1.ScalePolicy.FixedScale)**

Fixed scale policy of the node group.

Includes only one of the fields `fixed_scale`, `auto_scale`. ||
|| auto_scale | **[AutoScale](#yandex.cloud.k8s.v1.ScalePolicy.AutoScale)**

Auto scale policy of the node group.

Includes only one of the fields `fixed_scale`, `auto_scale`. ||
|#

## FixedScale {#yandex.cloud.k8s.v1.ScalePolicy.FixedScale}

#|
||Field | Description ||
|| size | **int64**

Number of nodes in the node group. ||
|#

## AutoScale {#yandex.cloud.k8s.v1.ScalePolicy.AutoScale}

#|
||Field | Description ||
|| min_size | **int64**

Minimum number of nodes in the node group. ||
|| max_size | **int64**

Maximum number of nodes in the node group. ||
|| initial_size | **int64**

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
|| zone_id | **string**

Required field. ID of the availability zone where the nodes may reside. ||
|| subnet_id | **string**

ID of the subnet. If a network chosen for the Kubernetes cluster has only one subnet in the specified zone, subnet ID may be omitted. ||
|#

## DeployPolicy {#yandex.cloud.k8s.v1.DeployPolicy}

#|
||Field | Description ||
|| max_unavailable | **int64**

The maximum number of running instances that can be taken offline (i.e.,
stopped or deleted) at the same time during the update process.
If `max_expansion` is not specified or set to zero, `max_unavailable` must
be set to a non-zero value. ||
|| max_expansion | **int64**

The maximum number of instances that can be temporarily allocated above
the group's target size during the update process.
If `max_unavailable` is not specified or set to zero, `max_expansion` must
be set to a non-zero value. ||
|#

## UpdateVersionSpec {#yandex.cloud.k8s.v1.UpdateVersionSpec}

#|
||Field | Description ||
|| version | **string**

Request update to a newer version of Kubernetes (1.x -> 1.y).

Includes only one of the fields `version`, `latest_revision`. ||
|| latest_revision | **bool**

Request update to the latest revision for the current version.

Includes only one of the fields `version`, `latest_revision`. ||
|#

## NodeGroupMaintenancePolicy {#yandex.cloud.k8s.v1.NodeGroupMaintenancePolicy}

#|
||Field | Description ||
|| auto_upgrade | **bool**

If set to true, automatic updates are installed in the specified period of time with no interaction from the user.
If set to false, automatic upgrades are disabled. ||
|| auto_repair | **bool**

If set to true, automatic repairs are enabled. Default value is false. ||
|| maintenance_window | **[MaintenanceWindow](#yandex.cloud.k8s.v1.MaintenanceWindow)**

Maintenance window settings. Update will start at the specified time and last no more than the specified duration.
The time is set in UTC. ||
|#

## MaintenanceWindow {#yandex.cloud.k8s.v1.MaintenanceWindow}

#|
||Field | Description ||
|| anytime | **[AnytimeMaintenanceWindow](#yandex.cloud.k8s.v1.AnytimeMaintenanceWindow)**

Updating the master at any time.

Includes only one of the fields `anytime`, `daily_maintenance_window`, `weekly_maintenance_window`.

Maintenance policy. ||
|| daily_maintenance_window | **[DailyMaintenanceWindow](#yandex.cloud.k8s.v1.DailyMaintenanceWindow)**

Updating the master on any day during the specified time window.

Includes only one of the fields `anytime`, `daily_maintenance_window`, `weekly_maintenance_window`.

Maintenance policy. ||
|| weekly_maintenance_window | **[WeeklyMaintenanceWindow](#yandex.cloud.k8s.v1.WeeklyMaintenanceWindow)**

Updating the master on selected days during the specified time window.

Includes only one of the fields `anytime`, `daily_maintenance_window`, `weekly_maintenance_window`.

Maintenance policy. ||
|#

## AnytimeMaintenanceWindow {#yandex.cloud.k8s.v1.AnytimeMaintenanceWindow}

#|
||Field | Description ||
|| Empty | > ||
|#

## DailyMaintenanceWindow {#yandex.cloud.k8s.v1.DailyMaintenanceWindow}

#|
||Field | Description ||
|| start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**

Required field. Window start time, in the UTC timezone. ||
|| duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Window duration. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.k8s.v1.WeeklyMaintenanceWindow}

#|
||Field | Description ||
|| days_of_week[] | **[DaysOfWeekMaintenanceWindow](#yandex.cloud.k8s.v1.DaysOfWeekMaintenanceWindow)**

Days of the week and the maintenance window for these days when automatic updates are allowed. ||
|#

## DaysOfWeekMaintenanceWindow {#yandex.cloud.k8s.v1.DaysOfWeekMaintenanceWindow}

#|
||Field | Description ||
|| days[] | enum **DayOfWeek**

Days of the week when automatic updates are allowed.

- `DAY_OF_WEEK_UNSPECIFIED`: The unspecified day-of-week.
- `MONDAY`: The day-of-week of Monday.
- `TUESDAY`: The day-of-week of Tuesday.
- `WEDNESDAY`: The day-of-week of Wednesday.
- `THURSDAY`: The day-of-week of Thursday.
- `FRIDAY`: The day-of-week of Friday.
- `SATURDAY`: The day-of-week of Saturday.
- `SUNDAY`: The day-of-week of Sunday. ||
|| start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**

Required field. Window start time, in the UTC timezone. ||
|| duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Window duration. ||
|#

## Taint {#yandex.cloud.k8s.v1.Taint}

#|
||Field | Description ||
|| key | **string**

The taint key to be applied to a node. ||
|| value | **string**

The taint value corresponding to the taint key. ||
|| effect | enum **Effect**

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

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "node_group_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "cluster_id": "string",
    "created_at": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "string",
    "status": "Status",
    "node_template": {
      "name": "string",
      "labels": "string",
      "platform_id": "string",
      "resources_spec": {
        "memory": "int64",
        "cores": "int64",
        "core_fraction": "int64",
        "gpus": "int64"
      },
      "boot_disk_spec": {
        "disk_type_id": "string",
        "disk_size": "int64"
      },
      "metadata": "string",
      "v4_address_spec": {
        "one_to_one_nat_spec": {
          "ip_version": "IpVersion"
        },
        "dns_record_specs": [
          {
            "fqdn": "string",
            "dns_zone_id": "string",
            "ttl": "int64",
            "ptr": "bool"
          }
        ]
      },
      "scheduling_policy": {
        "preemptible": "bool"
      },
      "network_interface_specs": [
        {
          "subnet_ids": [
            "string"
          ],
          "primary_v4_address_spec": {
            "one_to_one_nat_spec": {
              "ip_version": "IpVersion"
            },
            "dns_record_specs": [
              {
                "fqdn": "string",
                "dns_zone_id": "string",
                "ttl": "int64",
                "ptr": "bool"
              }
            ]
          },
          "primary_v6_address_spec": {
            "one_to_one_nat_spec": {
              "ip_version": "IpVersion"
            },
            "dns_record_specs": [
              {
                "fqdn": "string",
                "dns_zone_id": "string",
                "ttl": "int64",
                "ptr": "bool"
              }
            ]
          },
          "security_group_ids": [
            "string"
          ]
        }
      ],
      "placement_policy": {
        "placement_group_id": "string"
      },
      "network_settings": {
        "type": "Type"
      },
      "container_runtime_settings": {
        "type": "Type"
      },
      "container_network_settings": {
        "pod_mtu": "int64"
      },
      "gpu_settings": {
        "gpu_cluster_id": "string",
        "gpu_environment": "GpuEnvironment"
      }
    },
    "scale_policy": {
      // Includes only one of the fields `fixed_scale`, `auto_scale`
      "fixed_scale": {
        "size": "int64"
      },
      "auto_scale": {
        "min_size": "int64",
        "max_size": "int64",
        "initial_size": "int64"
      }
      // end of the list of possible fields
    },
    "allocation_policy": {
      "locations": [
        {
          "zone_id": "string",
          "subnet_id": "string"
        }
      ]
    },
    "deploy_policy": {
      "max_unavailable": "int64",
      "max_expansion": "int64"
    },
    "instance_group_id": "string",
    "node_version": "string",
    "version_info": {
      "current_version": "string",
      "new_revision_available": "bool",
      "new_revision_summary": "string",
      "version_deprecated": "bool"
    },
    "maintenance_policy": {
      "auto_upgrade": "bool",
      "auto_repair": "bool",
      "maintenance_window": {
        // Includes only one of the fields `anytime`, `daily_maintenance_window`, `weekly_maintenance_window`
        "anytime": "AnytimeMaintenanceWindow",
        "daily_maintenance_window": {
          "start_time": "google.type.TimeOfDay",
          "duration": "google.protobuf.Duration"
        },
        "weekly_maintenance_window": {
          "days_of_week": [
            {
              "days": [
                "DayOfWeek"
              ],
              "start_time": "google.type.TimeOfDay",
              "duration": "google.protobuf.Duration"
            }
          ]
        }
        // end of the list of possible fields
      }
    },
    "allowed_unsafe_sysctls": [
      "string"
    ],
    "node_taints": [
      {
        "key": "string",
        "value": "string",
        "effect": "Effect"
      }
    ],
    "node_labels": "string"
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateNodeGroupMetadata](#yandex.cloud.k8s.v1.UpdateNodeGroupMetadata)**

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
|| response | **[NodeGroup](#yandex.cloud.k8s.v1.NodeGroup)**

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

## UpdateNodeGroupMetadata {#yandex.cloud.k8s.v1.UpdateNodeGroupMetadata}

#|
||Field | Description ||
|| node_group_id | **string**

Required field. ID of the Node group that is being updated. ||
|#

## NodeGroup {#yandex.cloud.k8s.v1.NodeGroup}

#|
||Field | Description ||
|| id | **string**

ID of the node group. ||
|| cluster_id | **string**

ID of the cluster that the node group belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the node group.
The name is unique within the folder. ||
|| description | **string**

Description of the node group. 0-256 characters long. ||
|| labels | **string**

Resource labels as `key:value` pairs. Maximum of 64 per resource. ||
|| status | enum **Status**

Status of the node group.

- `STATUS_UNSPECIFIED`
- `PROVISIONING`: Node group is waiting for resources to be allocated.
- `RUNNING`: Node group is running.
- `RECONCILING`: Node group is waiting for some work to be done, such as upgrading node software.
- `STOPPING`: Node group is being stopped.
- `STOPPED`: Node group stopped.
- `DELETING`: Node group is being deleted.
- `STARTING`: Node group is being started. ||
|| node_template | **[NodeTemplate](#yandex.cloud.k8s.v1.NodeTemplate2)**

Node template that specifies parameters of the compute instances for the node group. ||
|| scale_policy | **[ScalePolicy](#yandex.cloud.k8s.v1.ScalePolicy2)**

Scale policy of the node group.  For more information, see [Scaling policy](/docs/compute/concepts/instance-groups/policies#scale-policy). ||
|| allocation_policy | **[NodeGroupAllocationPolicy](#yandex.cloud.k8s.v1.NodeGroupAllocationPolicy2)**

Allocation policy by which resources for node group are allocated to zones and regions. ||
|| deploy_policy | **[DeployPolicy](#yandex.cloud.k8s.v1.DeployPolicy2)**

Deploy policy according to which the updates are rolled out. ||
|| instance_group_id | **string**

ID of the managed instance group associated with this node group. ||
|| node_version | **string**

Version of Kubernetes components that runs on the nodes.
Deprecated. Use version_info.current_version. ||
|| version_info | **[VersionInfo](#yandex.cloud.k8s.v1.VersionInfo)**

Detailed information about the Kubernetes version that is running on the node. ||
|| maintenance_policy | **[NodeGroupMaintenancePolicy](#yandex.cloud.k8s.v1.NodeGroupMaintenancePolicy2)**

Maintenance policy of the node group. ||
|| allowed_unsafe_sysctls[] | **string**

Support for unsafe sysctl parameters. For more details see [documentation](https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/). ||
|| node_taints[] | **[Taint](#yandex.cloud.k8s.v1.Taint2)**

Taints that are applied to the nodes of the node group at creation time. ||
|| node_labels | **string**

Labels that are assigned to the nodes of the node group at creation time. ||
|#

## NodeTemplate {#yandex.cloud.k8s.v1.NodeTemplate2}

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
|| labels | **string**

these labels will be assigned to compute nodes (instances), created by the nodegroup ||
|| platform_id | **string**

ID of the hardware platform configuration for the node. ||
|| resources_spec | **[ResourcesSpec](#yandex.cloud.k8s.v1.ResourcesSpec2)**

Computing resources of the node such as the amount of memory and number of cores. ||
|| boot_disk_spec | **[DiskSpec](#yandex.cloud.k8s.v1.DiskSpec2)**

Specification for the boot disk that will be attached to the node. ||
|| metadata | **string**

The metadata as `key:value` pairs assigned to this instance template. Only SSH keys are supported as metadata.

For more information, see [Connecting to a node over SSH](/docs/managed-kubernetes/operations/node-connect-ssh). ||
|| v4_address_spec | **[NodeAddressSpec](#yandex.cloud.k8s.v1.NodeAddressSpec2)**

Specification for the create network interfaces for the node group compute instances.
Deprecated, please use network_interface_specs. ||
|| scheduling_policy | **[SchedulingPolicy](#yandex.cloud.k8s.v1.SchedulingPolicy2)**

Scheduling policy configuration. ||
|| network_interface_specs[] | **[NetworkInterfaceSpec](#yandex.cloud.k8s.v1.NetworkInterfaceSpec2)**

New api, to specify network interfaces for the node group compute instances.
Can not be used together with 'v4_address_spec' ||
|| placement_policy | **[PlacementPolicy](#yandex.cloud.k8s.v1.PlacementPolicy2)** ||
|| network_settings | **[NetworkSettings](#yandex.cloud.k8s.v1.NodeTemplate.NetworkSettings2)**

this parameter allows to specify type of network acceleration used on nodes (instances) ||
|| container_runtime_settings | **[ContainerRuntimeSettings](#yandex.cloud.k8s.v1.NodeTemplate.ContainerRuntimeSettings2)** ||
|| container_network_settings | **[ContainerNetworkSettings](#yandex.cloud.k8s.v1.NodeTemplate.ContainerNetworkSettings2)** ||
|| gpu_settings | **[GpuSettings](#yandex.cloud.k8s.v1.GpuSettings2)**

GPU settings ||
|#

## ResourcesSpec {#yandex.cloud.k8s.v1.ResourcesSpec2}

#|
||Field | Description ||
|| memory | **int64**

Amount of memory available to the node, specified in bytes. ||
|| cores | **int64**

Number of cores available to the node. ||
|| core_fraction | **int64**

Baseline level of CPU performance with the possibility to burst performance above that baseline level.
This field sets baseline performance for each core. ||
|| gpus | **int64**

Number of GPUs available to the node. ||
|#

## DiskSpec {#yandex.cloud.k8s.v1.DiskSpec2}

#|
||Field | Description ||
|| disk_type_id | **string**

ID of the disk type. ||
|| disk_size | **int64**

Size of the disk, specified in bytes. ||
|#

## NodeAddressSpec {#yandex.cloud.k8s.v1.NodeAddressSpec2}

#|
||Field | Description ||
|| one_to_one_nat_spec | **[OneToOneNatSpec](#yandex.cloud.k8s.v1.OneToOneNatSpec2)**

One-to-one NAT configuration. Setting up one-to-one NAT ensures that public IP addresses are assigned to nodes, and therefore internet is accessible for all nodes of the node group. If the field is not set, NAT will not be set up. ||
|| dns_record_specs[] | **[DnsRecordSpec](#yandex.cloud.k8s.v1.DnsRecordSpec2)**

Internal DNS configuration. ||
|#

## OneToOneNatSpec {#yandex.cloud.k8s.v1.OneToOneNatSpec2}

#|
||Field | Description ||
|| ip_version | enum **IpVersion**

IP version for the public IP address.

- `IP_VERSION_UNSPECIFIED`
- `IPV4`: IPv4 address, for example 192.168.0.0.
- `IPV6`: IPv6 address, not available yet. ||
|#

## DnsRecordSpec {#yandex.cloud.k8s.v1.DnsRecordSpec2}

#|
||Field | Description ||
|| fqdn | **string**

Required field. FQDN (required). ||
|| dns_zone_id | **string**

DNS zone id (optional, if not set, private zone is used). ||
|| ttl | **int64**

DNS record ttl, values in 0-86400 (optional). ||
|| ptr | **bool**

When set to true, also create PTR DNS record (optional). ||
|#

## SchedulingPolicy {#yandex.cloud.k8s.v1.SchedulingPolicy2}

#|
||Field | Description ||
|| preemptible | **bool**

True for preemptible compute instances. Default value is false. Preemptible compute instances are stopped at least once every 24 hours, and can be stopped at any time
if their resources are needed by Compute.
For more information, see [Preemptible Virtual Machines](/docs/compute/concepts/preemptible-vm). ||
|#

## NetworkInterfaceSpec {#yandex.cloud.k8s.v1.NetworkInterfaceSpec2}

#|
||Field | Description ||
|| subnet_ids[] | **string**

IDs of the subnets. ||
|| primary_v4_address_spec | **[NodeAddressSpec](#yandex.cloud.k8s.v1.NodeAddressSpec2)**

Primary IPv4 address that is assigned to the instance for this network interface. ||
|| primary_v6_address_spec | **[NodeAddressSpec](#yandex.cloud.k8s.v1.NodeAddressSpec2)**

Primary IPv6 address that is assigned to the instance for this network interface. ||
|| security_group_ids[] | **string**

IDs of security groups. ||
|#

## PlacementPolicy {#yandex.cloud.k8s.v1.PlacementPolicy2}

#|
||Field | Description ||
|| placement_group_id | **string**

Identifier of placement group ||
|#

## NetworkSettings {#yandex.cloud.k8s.v1.NodeTemplate.NetworkSettings2}

#|
||Field | Description ||
|| type | enum **Type**

Required field. 

- `TYPE_UNSPECIFIED`
- `STANDARD`
- `SOFTWARE_ACCELERATED` ||
|#

## ContainerRuntimeSettings {#yandex.cloud.k8s.v1.NodeTemplate.ContainerRuntimeSettings2}

#|
||Field | Description ||
|| type | enum **Type**

Required field. 

- `TYPE_UNSPECIFIED`
- `DOCKER`
- `CONTAINERD` ||
|#

## ContainerNetworkSettings {#yandex.cloud.k8s.v1.NodeTemplate.ContainerNetworkSettings2}

#|
||Field | Description ||
|| pod_mtu | **int64** ||
|#

## GpuSettings {#yandex.cloud.k8s.v1.GpuSettings2}

#|
||Field | Description ||
|| gpu_cluster_id | **string**

GPU cluster id, that mk8s node will join. ||
|| gpu_environment | enum **GpuEnvironment**

GPU environment configured on node.

- `GPU_ENVIRONMENT_UNSPECIFIED`: Use one of the values below, depending on the default for the specific Cloud installation.
- `RUNC_DRIVERS_CUDA`: Use a node image with the pre-installed GPU toolkit, drivers and CUDA.
- `RUNC`: Use a node image with the pre-installed GPU toolkit but without drivers.
You should install drivers on a node yourself in that case.
There are tools to help you to do that, for example gpu-operator. ||
|#

## ScalePolicy {#yandex.cloud.k8s.v1.ScalePolicy2}

#|
||Field | Description ||
|| fixed_scale | **[FixedScale](#yandex.cloud.k8s.v1.ScalePolicy.FixedScale2)**

Fixed scale policy of the node group.

Includes only one of the fields `fixed_scale`, `auto_scale`. ||
|| auto_scale | **[AutoScale](#yandex.cloud.k8s.v1.ScalePolicy.AutoScale2)**

Auto scale policy of the node group.

Includes only one of the fields `fixed_scale`, `auto_scale`. ||
|#

## FixedScale {#yandex.cloud.k8s.v1.ScalePolicy.FixedScale2}

#|
||Field | Description ||
|| size | **int64**

Number of nodes in the node group. ||
|#

## AutoScale {#yandex.cloud.k8s.v1.ScalePolicy.AutoScale2}

#|
||Field | Description ||
|| min_size | **int64**

Minimum number of nodes in the node group. ||
|| max_size | **int64**

Maximum number of nodes in the node group. ||
|| initial_size | **int64**

Initial number of nodes in the node group. ||
|#

## NodeGroupAllocationPolicy {#yandex.cloud.k8s.v1.NodeGroupAllocationPolicy2}

#|
||Field | Description ||
|| locations[] | **[NodeGroupLocation](#yandex.cloud.k8s.v1.NodeGroupLocation2)**

List of locations where resources for the node group will be allocated. ||
|#

## NodeGroupLocation {#yandex.cloud.k8s.v1.NodeGroupLocation2}

#|
||Field | Description ||
|| zone_id | **string**

Required field. ID of the availability zone where the nodes may reside. ||
|| subnet_id | **string**

ID of the subnet. If a network chosen for the Kubernetes cluster has only one subnet in the specified zone, subnet ID may be omitted. ||
|#

## DeployPolicy {#yandex.cloud.k8s.v1.DeployPolicy2}

#|
||Field | Description ||
|| max_unavailable | **int64**

The maximum number of running instances that can be taken offline (i.e.,
stopped or deleted) at the same time during the update process.
If `max_expansion` is not specified or set to zero, `max_unavailable` must
be set to a non-zero value. ||
|| max_expansion | **int64**

The maximum number of instances that can be temporarily allocated above
the group's target size during the update process.
If `max_unavailable` is not specified or set to zero, `max_expansion` must
be set to a non-zero value. ||
|#

## VersionInfo {#yandex.cloud.k8s.v1.VersionInfo}

#|
||Field | Description ||
|| current_version | **string**

Current Kubernetes version, format: major.minor (e.g. 1.15). ||
|| new_revision_available | **bool**

Newer revisions may include Kubernetes patches (e.g 1.15.1 -> 1.15.2) as well
as some internal component updates - new features or bug fixes in platform specific
components either on the master or nodes. ||
|| new_revision_summary | **string**

Description of the changes to be applied when updating to the latest
revision. Empty if new_revision_available is false. ||
|| version_deprecated | **bool**

The current version is on the deprecation schedule, component (master or node group)
should be upgraded. ||
|#

## NodeGroupMaintenancePolicy {#yandex.cloud.k8s.v1.NodeGroupMaintenancePolicy2}

#|
||Field | Description ||
|| auto_upgrade | **bool**

If set to true, automatic updates are installed in the specified period of time with no interaction from the user.
If set to false, automatic upgrades are disabled. ||
|| auto_repair | **bool**

If set to true, automatic repairs are enabled. Default value is false. ||
|| maintenance_window | **[MaintenanceWindow](#yandex.cloud.k8s.v1.MaintenanceWindow2)**

Maintenance window settings. Update will start at the specified time and last no more than the specified duration.
The time is set in UTC. ||
|#

## MaintenanceWindow {#yandex.cloud.k8s.v1.MaintenanceWindow2}

#|
||Field | Description ||
|| anytime | **[AnytimeMaintenanceWindow](#yandex.cloud.k8s.v1.AnytimeMaintenanceWindow2)**

Updating the master at any time.

Includes only one of the fields `anytime`, `daily_maintenance_window`, `weekly_maintenance_window`.

Maintenance policy. ||
|| daily_maintenance_window | **[DailyMaintenanceWindow](#yandex.cloud.k8s.v1.DailyMaintenanceWindow2)**

Updating the master on any day during the specified time window.

Includes only one of the fields `anytime`, `daily_maintenance_window`, `weekly_maintenance_window`.

Maintenance policy. ||
|| weekly_maintenance_window | **[WeeklyMaintenanceWindow](#yandex.cloud.k8s.v1.WeeklyMaintenanceWindow2)**

Updating the master on selected days during the specified time window.

Includes only one of the fields `anytime`, `daily_maintenance_window`, `weekly_maintenance_window`.

Maintenance policy. ||
|#

## AnytimeMaintenanceWindow {#yandex.cloud.k8s.v1.AnytimeMaintenanceWindow2}

#|
||Field | Description ||
|| Empty | > ||
|#

## DailyMaintenanceWindow {#yandex.cloud.k8s.v1.DailyMaintenanceWindow2}

#|
||Field | Description ||
|| start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**

Required field. Window start time, in the UTC timezone. ||
|| duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Window duration. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.k8s.v1.WeeklyMaintenanceWindow2}

#|
||Field | Description ||
|| days_of_week[] | **[DaysOfWeekMaintenanceWindow](#yandex.cloud.k8s.v1.DaysOfWeekMaintenanceWindow2)**

Days of the week and the maintenance window for these days when automatic updates are allowed. ||
|#

## DaysOfWeekMaintenanceWindow {#yandex.cloud.k8s.v1.DaysOfWeekMaintenanceWindow2}

#|
||Field | Description ||
|| days[] | enum **DayOfWeek**

Days of the week when automatic updates are allowed.

- `DAY_OF_WEEK_UNSPECIFIED`: The unspecified day-of-week.
- `MONDAY`: The day-of-week of Monday.
- `TUESDAY`: The day-of-week of Tuesday.
- `WEDNESDAY`: The day-of-week of Wednesday.
- `THURSDAY`: The day-of-week of Thursday.
- `FRIDAY`: The day-of-week of Friday.
- `SATURDAY`: The day-of-week of Saturday.
- `SUNDAY`: The day-of-week of Sunday. ||
|| start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**

Required field. Window start time, in the UTC timezone. ||
|| duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Window duration. ||
|#

## Taint {#yandex.cloud.k8s.v1.Taint2}

#|
||Field | Description ||
|| key | **string**

The taint key to be applied to a node. ||
|| value | **string**

The taint value corresponding to the taint key. ||
|| effect | enum **Effect**

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