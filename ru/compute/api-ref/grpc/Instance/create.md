---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/Instance/create.md
---

# Compute Cloud API, gRPC: InstanceService.Create

Creates an instance in the specified folder.
Method starts an asynchronous operation that can be cancelled while it is in progress.

## gRPC request

**rpc Create ([CreateInstanceRequest](#yandex.cloud.compute.v1.CreateInstanceRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateInstanceRequest {#yandex.cloud.compute.v1.CreateInstanceRequest}

```json
{
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "zone_id": "string",
  "platform_id": "string",
  "resources_spec": {
    "memory": "int64",
    "cores": "int64",
    "core_fraction": "int64",
    "gpus": "int64"
  },
  "metadata": "map<string, string>",
  "metadata_options": {
    "gce_http_endpoint": "MetadataOption",
    "aws_v1_http_endpoint": "MetadataOption",
    "gce_http_token": "MetadataOption",
    "aws_v1_http_token": "MetadataOption"
  },
  "boot_disk_spec": {
    "mode": "Mode",
    "device_name": "string",
    "auto_delete": "bool",
    // Includes only one of the fields `disk_spec`, `disk_id`
    "disk_spec": {
      "name": "string",
      "description": "string",
      "type_id": "string",
      "size": "int64",
      // Includes only one of the fields `image_id`, `snapshot_id`
      "image_id": "string",
      "snapshot_id": "string",
      // end of the list of possible fields
      "disk_placement_policy": {
        "placement_group_id": "string",
        "placement_group_partition": "int64"
      },
      "block_size": "int64",
      "kms_key_id": "string"
    },
    "disk_id": "string"
    // end of the list of possible fields
  },
  "secondary_disk_specs": [
    {
      "mode": "Mode",
      "device_name": "string",
      "auto_delete": "bool",
      // Includes only one of the fields `disk_spec`, `disk_id`
      "disk_spec": {
        "name": "string",
        "description": "string",
        "type_id": "string",
        "size": "int64",
        // Includes only one of the fields `image_id`, `snapshot_id`
        "image_id": "string",
        "snapshot_id": "string",
        // end of the list of possible fields
        "disk_placement_policy": {
          "placement_group_id": "string",
          "placement_group_partition": "int64"
        },
        "block_size": "int64",
        "kms_key_id": "string"
      },
      "disk_id": "string"
      // end of the list of possible fields
    }
  ],
  "local_disk_specs": [
    {
      "size": "int64"
    }
  ],
  "filesystem_specs": [
    {
      "mode": "Mode",
      "device_name": "string",
      "filesystem_id": "string"
    }
  ],
  "network_interface_specs": [
    {
      "subnet_id": "string",
      "primary_v4_address_spec": {
        "address": "string",
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
        ]
      },
      "primary_v6_address_spec": {
        "address": "string",
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
        ]
      },
      "security_group_ids": [
        "string"
      ],
      "index": "string"
    }
  ],
  "hostname": "string",
  "scheduling_policy": {
    "preemptible": "bool"
  },
  "service_account_id": "string",
  "network_settings": {
    "type": "Type"
  },
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
    ],
    "placement_group_partition": "int64"
  },
  "gpu_settings": {
    "gpu_cluster_id": "string"
  },
  "maintenance_policy": "MaintenancePolicy",
  "maintenance_grace_period": "google.protobuf.Duration",
  "serial_port_settings": {
    "ssh_authorization": "SSHAuthorization"
  }
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to create an instance in.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| name | **string**

Name of the instance. ||
|| description | **string**

Description of the instance. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|| zone_id | **string**

Required field. ID of the availability zone where the instance resides.
To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/Zone/list#List) request ||
|| platform_id | **string**

Required field. ID of the hardware platform configuration for the instance.
This field affects the available values in `resources_spec` field.

Platforms allows you to create various types of instances: with a large amount of memory,
with a large number of cores, with a burstable performance.
For more information, see [Platforms](/docs/compute/concepts/vm-platforms). ||
|| resources_spec | **[ResourcesSpec](#yandex.cloud.compute.v1.ResourcesSpec)**

Required field. Computing resources of the instance, such as the amount of memory and number of cores.
To get a list of available values, see [Levels of core performance](/docs/compute/concepts/performance-levels). ||
|| metadata | **object** (map<**string**, **string**>)

The metadata `key:value` pairs that will be assigned to this instance. This includes custom metadata and predefined keys.
The total size of all keys and values must be less than 512 KB.

Values are free-form strings, and only have meaning as interpreted by the programs which configure the instance.
The values must be 256 KB or less.

For example, you may use the metadata in order to provide your public SSH key to the instance.
For more information, see [Metadata](/docs/compute/concepts/vm-metadata). ||
|| metadata_options | **[MetadataOptions](#yandex.cloud.compute.v1.MetadataOptions)**

Options allow user to configure access to instance's metadata ||
|| boot_disk_spec | **[AttachedDiskSpec](#yandex.cloud.compute.v1.AttachedDiskSpec)**

Required field. Boot disk to attach to the instance. ||
|| secondary_disk_specs[] | **[AttachedDiskSpec](#yandex.cloud.compute.v1.AttachedDiskSpec)**

Array of secondary disks to attach to the instance. ||
|| local_disk_specs[] | **[AttachedLocalDiskSpec](#yandex.cloud.compute.v1.AttachedLocalDiskSpec)**

Array of local disks to attach to the instance. ||
|| filesystem_specs[] | **[AttachedFilesystemSpec](#yandex.cloud.compute.v1.AttachedFilesystemSpec)**

Array of filesystems to attach to the instance.

The filesystems must reside in the same availability zone as the instance.

To use the instance with an attached filesystem, the latter must be mounted.
For details, see [documentation](/docs/compute/operations/filesystem/attach-to-vm). ||
|| network_interface_specs[] | **[NetworkInterfaceSpec](#yandex.cloud.compute.v1.NetworkInterfaceSpec)**

Required field. Network configuration for the instance. Specifies how the network interface is configured
to interact with other services on the internal network and on the internet. ||
|| hostname | **string**

Host name for the instance.
This field is used to generate the [yandex.cloud.compute.v1.Instance.fqdn](#yandex.cloud.compute.v1.Instance) value.
The host name must be unique within the network and region.
If not specified, the host name will be equal to [yandex.cloud.compute.v1.Instance.id](#yandex.cloud.compute.v1.Instance) of the instance
and FQDN will be `<id>.auto.internal`. Otherwise FQDN will be `<hostname>.<region_id>.internal`. ||
|| scheduling_policy | **[SchedulingPolicy](#yandex.cloud.compute.v1.SchedulingPolicy)**

Scheduling policy configuration. ||
|| service_account_id | **string**

ID of the service account to use for [authentication inside the instance](/docs/compute/operations/vm-connect/auth-inside-vm).
To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/ServiceAccount/list#List) request. ||
|| network_settings | **[NetworkSettings](#yandex.cloud.compute.v1.NetworkSettings)**

Network settings. ||
|| placement_policy | **[PlacementPolicy](#yandex.cloud.compute.v1.PlacementPolicy)**

Placement policy configuration. ||
|| gpu_settings | **[GpuSettings](#yandex.cloud.compute.v1.GpuSettings)**

GPU settings. ||
|| maintenance_policy | enum **MaintenancePolicy**

Behaviour on maintenance events

- `MAINTENANCE_POLICY_UNSPECIFIED`
- `RESTART`: Restart instance to move it to another host during maintenance
- `MIGRATE`: Use live migration to move instance to another host during maintenance ||
|| maintenance_grace_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Time between notification via metadata service and maintenance ||
|| serial_port_settings | **[SerialPortSettings](#yandex.cloud.compute.v1.SerialPortSettings)**

Serial port settings ||
|#

## ResourcesSpec {#yandex.cloud.compute.v1.ResourcesSpec}

#|
||Field | Description ||
|| memory | **int64**

Required field. The amount of memory available to the instance, specified in bytes. ||
|| cores | **int64**

Required field. The number of cores available to the instance. ||
|| core_fraction | **int64**

Baseline level of CPU performance with the ability to burst performance above that baseline level.
This field sets baseline performance for each core.

For example, if you need only 5% of the CPU performance, you can set core_fraction=5.
For more information, see [Levels of core performance](/docs/compute/concepts/performance-levels). ||
|| gpus | **int64**

The number of GPUs available to the instance. ||
|#

## MetadataOptions {#yandex.cloud.compute.v1.MetadataOptions}

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

## AttachedDiskSpec {#yandex.cloud.compute.v1.AttachedDiskSpec}

#|
||Field | Description ||
|| mode | enum **Mode**

The mode in which to attach this disk.

- `MODE_UNSPECIFIED`
- `READ_ONLY`: Read-only access.
- `READ_WRITE`: Read/Write access. Default value. ||
|| device_name | **string**

Specifies a unique serial number of your choice that is reflected into the /dev/disk/by-id/ tree
of a Linux operating system running within the instance.

This value can be used to reference the device for mounting, resizing, and so on, from within the instance.
If not specified, a random value will be generated. ||
|| auto_delete | **bool**

Specifies whether the disk will be auto-deleted when the instance is deleted. ||
|| disk_spec | **[DiskSpec](#yandex.cloud.compute.v1.AttachedDiskSpec.DiskSpec)**

Disk specification.

Includes only one of the fields `disk_spec`, `disk_id`. ||
|| disk_id | **string**

ID of the disk that should be attached.

Includes only one of the fields `disk_spec`, `disk_id`. ||
|#

## DiskSpec {#yandex.cloud.compute.v1.AttachedDiskSpec.DiskSpec}

#|
||Field | Description ||
|| name | **string**

Name of the disk. ||
|| description | **string**

Description of the disk. ||
|| type_id | **string**

ID of the disk type.
To get a list of available disk types, use the [yandex.cloud.compute.v1.DiskTypeService.List](/docs/compute/api-ref/grpc/DiskType/list#List) request. ||
|| size | **int64**

Required field. Size of the disk, specified in bytes. ||
|| image_id | **string**

ID of the image to create the disk from.

Includes only one of the fields `image_id`, `snapshot_id`. ||
|| snapshot_id | **string**

ID of the snapshot to restore the disk from.

Includes only one of the fields `image_id`, `snapshot_id`. ||
|| disk_placement_policy | **[DiskPlacementPolicy](#yandex.cloud.compute.v1.DiskPlacementPolicy)**

Placement policy configuration. ||
|| block_size | **int64**

Block size of the disk, specified in bytes. The default is 4096. ||
|| kms_key_id | **string**

ID of KMS key for disk encryption ||
|#

## DiskPlacementPolicy {#yandex.cloud.compute.v1.DiskPlacementPolicy}

#|
||Field | Description ||
|| placement_group_id | **string**

Placement group ID. ||
|| placement_group_partition | **int64** ||
|#

## AttachedLocalDiskSpec {#yandex.cloud.compute.v1.AttachedLocalDiskSpec}

#|
||Field | Description ||
|| size | **int64**

Required field. Size of the disk, specified in bytes. ||
|#

## AttachedFilesystemSpec {#yandex.cloud.compute.v1.AttachedFilesystemSpec}

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

## NetworkInterfaceSpec {#yandex.cloud.compute.v1.NetworkInterfaceSpec}

#|
||Field | Description ||
|| subnet_id | **string**

Required field. ID of the subnet. ||
|| primary_v4_address_spec | **[PrimaryAddressSpec](#yandex.cloud.compute.v1.PrimaryAddressSpec)**

Primary IPv4 address that will be assigned to the instance for this network interface. ||
|| primary_v6_address_spec | **[PrimaryAddressSpec](#yandex.cloud.compute.v1.PrimaryAddressSpec)**

Primary IPv6 address that will be assigned to the instance for this network interface. IPv6 not available yet. ||
|| security_group_ids[] | **string**

ID's of security groups attached to the interface ||
|| index | **string**

The index of the network interface, will be generated by the server, 0,1,2... etc if not specified. ||
|#

## PrimaryAddressSpec {#yandex.cloud.compute.v1.PrimaryAddressSpec}

#|
||Field | Description ||
|| address | **string**

An IPv4 internal network address that is assigned to the instance for this network interface.
If not specified by the user, an unused internal IP is assigned by the system. ||
|| one_to_one_nat_spec | **[OneToOneNatSpec](#yandex.cloud.compute.v1.OneToOneNatSpec)**

An external IP address configuration.
If not specified, then this instance will have no external internet access. ||
|| dns_record_specs[] | **[DnsRecordSpec](#yandex.cloud.compute.v1.DnsRecordSpec)**

Internal DNS configuration ||
|#

## OneToOneNatSpec {#yandex.cloud.compute.v1.OneToOneNatSpec}

#|
||Field | Description ||
|| ip_version | enum **IpVersion**

External IP address version.

- `IP_VERSION_UNSPECIFIED`
- `IPV4`: IPv4 address, for example 192.0.2.235.
- `IPV6`: IPv6 address. Not available yet. ||
|| address | **string**

set static IP by value ||
|| dns_record_specs[] | **[DnsRecordSpec](#yandex.cloud.compute.v1.DnsRecordSpec)**

External DNS configuration ||
|#

## DnsRecordSpec {#yandex.cloud.compute.v1.DnsRecordSpec}

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

## SchedulingPolicy {#yandex.cloud.compute.v1.SchedulingPolicy}

#|
||Field | Description ||
|| preemptible | **bool**

True for short-lived compute instances. For more information, see [Preemptible VMs](/docs/compute/concepts/preemptible-vm). ||
|#

## NetworkSettings {#yandex.cloud.compute.v1.NetworkSettings}

#|
||Field | Description ||
|| type | enum **Type**

Network Type

- `TYPE_UNSPECIFIED`
- `STANDARD`: Standard network.
- `SOFTWARE_ACCELERATED`: Software accelerated network.
- `HARDWARE_ACCELERATED`: Hardware accelerated network (not available yet, reserved for future use). ||
|#

## PlacementPolicy {#yandex.cloud.compute.v1.PlacementPolicy}

#|
||Field | Description ||
|| placement_group_id | **string**

Placement group ID. ||
|| host_affinity_rules[] | **[HostAffinityRule](#yandex.cloud.compute.v1.PlacementPolicy.HostAffinityRule)**

List of affinity rules. Scheduler will attempt to allocate instances according to order of rules. ||
|| placement_group_partition | **int64**

Placement group partition ||
|#

## HostAffinityRule {#yandex.cloud.compute.v1.PlacementPolicy.HostAffinityRule}

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

## GpuSettings {#yandex.cloud.compute.v1.GpuSettings}

#|
||Field | Description ||
|| gpu_cluster_id | **string**

Attach instance to specified GPU cluster. ||
|#

## SerialPortSettings {#yandex.cloud.compute.v1.SerialPortSettings}

#|
||Field | Description ||
|| ssh_authorization | enum **SSHAuthorization**

Authentication and authorization in serial console when using SSH protocol

- `SSH_AUTHORIZATION_UNSPECIFIED`
- `INSTANCE_METADATA`: Authentication and authorization using SSH keys in instance metadata
- `OS_LOGIN`: Authentication and authorization using Oslogin service ||
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
    "instance_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folder_id": "string",
    "created_at": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "map<string, string>",
    "zone_id": "string",
    "platform_id": "string",
    "resources": {
      "memory": "int64",
      "cores": "int64",
      "core_fraction": "int64",
      "gpus": "int64"
    },
    "status": "Status",
    "metadata": "map<string, string>",
    "metadata_options": {
      "gce_http_endpoint": "MetadataOption",
      "aws_v1_http_endpoint": "MetadataOption",
      "gce_http_token": "MetadataOption",
      "aws_v1_http_token": "MetadataOption"
    },
    "boot_disk": {
      "mode": "Mode",
      "device_name": "string",
      "auto_delete": "bool",
      "disk_id": "string"
    },
    "secondary_disks": [
      {
        "mode": "Mode",
        "device_name": "string",
        "auto_delete": "bool",
        "disk_id": "string"
      }
    ],
    "local_disks": [
      {
        "size": "int64",
        "device_name": "string"
      }
    ],
    "filesystems": [
      {
        "mode": "Mode",
        "device_name": "string",
        "filesystem_id": "string"
      }
    ],
    "network_interfaces": [
      {
        "index": "string",
        "mac_address": "string",
        "subnet_id": "string",
        "primary_v4_address": {
          "address": "string",
          "one_to_one_nat": {
            "address": "string",
            "ip_version": "IpVersion",
            "dns_records": [
              {
                "fqdn": "string",
                "dns_zone_id": "string",
                "ttl": "int64",
                "ptr": "bool"
              }
            ]
          },
          "dns_records": [
            {
              "fqdn": "string",
              "dns_zone_id": "string",
              "ttl": "int64",
              "ptr": "bool"
            }
          ]
        },
        "primary_v6_address": {
          "address": "string",
          "one_to_one_nat": {
            "address": "string",
            "ip_version": "IpVersion",
            "dns_records": [
              {
                "fqdn": "string",
                "dns_zone_id": "string",
                "ttl": "int64",
                "ptr": "bool"
              }
            ]
          },
          "dns_records": [
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
    "serial_port_settings": {
      "ssh_authorization": "SSHAuthorization"
    },
    "gpu_settings": {
      "gpu_cluster_id": "string"
    },
    "fqdn": "string",
    "scheduling_policy": {
      "preemptible": "bool"
    },
    "service_account_id": "string",
    "network_settings": {
      "type": "Type"
    },
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
      ],
      "placement_group_partition": "int64"
    },
    "host_group_id": "string",
    "host_id": "string",
    "maintenance_policy": "MaintenancePolicy",
    "maintenance_grace_period": "google.protobuf.Duration",
    "hardware_generation": {
      // Includes only one of the fields `legacy_features`, `generation2_features`
      "legacy_features": {
        "pci_topology": "PCITopology"
      },
      "generation2_features": "Generation2HardwareFeatures"
      // end of the list of possible fields
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateInstanceMetadata](#yandex.cloud.compute.v1.CreateInstanceMetadata)**

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
|| response | **[Instance](#yandex.cloud.compute.v1.Instance)**

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

## CreateInstanceMetadata {#yandex.cloud.compute.v1.CreateInstanceMetadata}

#|
||Field | Description ||
|| instance_id | **string**

ID of the instance that is being created. ||
|#

## Instance {#yandex.cloud.compute.v1.Instance}

An Instance resource. For more information, see [Instances](/docs/compute/concepts/vm).

#|
||Field | Description ||
|| id | **string**

ID of the instance. ||
|| folder_id | **string**

ID of the folder that the instance belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| name | **string**

Name of the instance. 1-63 characters long. ||
|| description | **string**

Description of the instance. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. Maximum of 64 per resource. ||
|| zone_id | **string**

ID of the availability zone where the instance resides. ||
|| platform_id | **string**

ID of the hardware platform configuration for the instance. ||
|| resources | **[Resources](#yandex.cloud.compute.v1.Resources)**

Computing resources of the instance such as the amount of memory and number of cores. ||
|| status | enum **Status**

Status of the instance.

- `STATUS_UNSPECIFIED`
- `PROVISIONING`: Instance is waiting for resources to be allocated.
- `RUNNING`: Instance is running normally.
- `STOPPING`: Instance is being stopped.
- `STOPPED`: Instance stopped.
- `STARTING`: Instance is being started.
- `RESTARTING`: Instance is being restarted.
- `UPDATING`: Instance is being updated.
- `ERROR`: Instance encountered a problem and cannot operate.
- `CRASHED`: Instance crashed and will be restarted automatically.
- `DELETING`: Instance is being deleted. ||
|| metadata | **object** (map<**string**, **string**>)

The metadata `key:value` pairs assigned to this instance. This includes custom metadata and predefined keys.

For example, you may use the metadata in order to provide your public SSH key to the instance.
For more information, see [Metadata](/docs/compute/concepts/vm-metadata). ||
|| metadata_options | **[MetadataOptions](#yandex.cloud.compute.v1.MetadataOptions2)**

Options allow user to configure access to instance's metadata ||
|| boot_disk | **[AttachedDisk](#yandex.cloud.compute.v1.AttachedDisk)**

Boot disk that is attached to the instance. ||
|| secondary_disks[] | **[AttachedDisk](#yandex.cloud.compute.v1.AttachedDisk)**

Array of secondary disks that are attached to the instance. ||
|| local_disks[] | **[AttachedLocalDisk](#yandex.cloud.compute.v1.AttachedLocalDisk)**

Array of local disks that are attached to the instance. ||
|| filesystems[] | **[AttachedFilesystem](#yandex.cloud.compute.v1.AttachedFilesystem)**

Array of filesystems that are attached to the instance. ||
|| network_interfaces[] | **[NetworkInterface](#yandex.cloud.compute.v1.NetworkInterface)**

Array of network interfaces that are attached to the instance. ||
|| serial_port_settings | **[SerialPortSettings](#yandex.cloud.compute.v1.SerialPortSettings2)**

Serial port settings ||
|| gpu_settings | **[GpuSettings](#yandex.cloud.compute.v1.GpuSettings2)**

GPU settings ||
|| fqdn | **string**

A domain name of the instance. FQDN is defined by the server
in the format `<hostname>.<region_id>.internal` when the instance is created.
If the hostname were not specified when the instance was created, FQDN would be `<id>.auto.internal`. ||
|| scheduling_policy | **[SchedulingPolicy](#yandex.cloud.compute.v1.SchedulingPolicy2)**

Scheduling policy configuration. ||
|| service_account_id | **string**

ID of the service account to use for [authentication inside the instance](/docs/compute/operations/vm-connect/auth-inside-vm).
To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/ServiceAccount/list#List) request. ||
|| network_settings | **[NetworkSettings](#yandex.cloud.compute.v1.NetworkSettings2)**

Network Settings ||
|| placement_policy | **[PlacementPolicy](#yandex.cloud.compute.v1.PlacementPolicy2)**

Placement policy configuration. ||
|| host_group_id | **string**

ID of the dedicated host group that the instance belongs to. ||
|| host_id | **string**

ID of the dedicated host that the instance belongs to. ||
|| maintenance_policy | enum **MaintenancePolicy**

Behaviour on maintenance events

- `MAINTENANCE_POLICY_UNSPECIFIED`
- `RESTART`: Restart instance to move it to another host during maintenance
- `MIGRATE`: Use live migration to move instance to another host during maintenance ||
|| maintenance_grace_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Time between notification via metadata service and maintenance ||
|| hardware_generation | **[HardwareGeneration](#yandex.cloud.compute.v1.HardwareGeneration)**

This feature set is inherited from the image/disk used as a boot one at the creation of the instance. ||
|#

## Resources {#yandex.cloud.compute.v1.Resources}

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

## MetadataOptions {#yandex.cloud.compute.v1.MetadataOptions2}

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

## AttachedDisk {#yandex.cloud.compute.v1.AttachedDisk}

#|
||Field | Description ||
|| mode | enum **Mode**

Access mode to the Disk resource.

- `MODE_UNSPECIFIED`
- `READ_ONLY`: Read-only access.
- `READ_WRITE`: Read/Write access. ||
|| device_name | **string**

Serial number that is reflected into the /dev/disk/by-id/ tree
of a Linux operating system running within the instance.

This value can be used to reference the device for mounting, resizing, and so on, from within the instance. ||
|| auto_delete | **bool**

Specifies whether the disk will be auto-deleted when the instance is deleted. ||
|| disk_id | **string**

ID of the disk that is attached to the instance. ||
|#

## AttachedLocalDisk {#yandex.cloud.compute.v1.AttachedLocalDisk}

#|
||Field | Description ||
|| size | **int64**

Size of the disk, specified in bytes. ||
|| device_name | **string**

Serial number that is reflected into the /dev/disk/by-id/ tree
of a Linux operating system running within the instance.

This value can be used to reference the device for mounting, resizing, and so on, from within the instance. ||
|#

## AttachedFilesystem {#yandex.cloud.compute.v1.AttachedFilesystem}

#|
||Field | Description ||
|| mode | enum **Mode**

Access mode to the filesystem.

- `MODE_UNSPECIFIED`
- `READ_ONLY`: Read-only access.
- `READ_WRITE`: Read/Write access. ||
|| device_name | **string**

Name of the device representing the filesystem on the instance.

The name should be used for referencing the filesystem from within the instance
when it's being mounted, resized etc. ||
|| filesystem_id | **string**

ID of the filesystem that is attached to the instance. ||
|#

## NetworkInterface {#yandex.cloud.compute.v1.NetworkInterface}

#|
||Field | Description ||
|| index | **string**

The index of the network interface, will be generated by the server, 0,1,2... etc if not specified. ||
|| mac_address | **string**

MAC address that is assigned to the network interface. ||
|| subnet_id | **string**

ID of the subnet. ||
|| primary_v4_address | **[PrimaryAddress](#yandex.cloud.compute.v1.PrimaryAddress)**

Primary IPv4 address that is assigned to the instance for this network interface. ||
|| primary_v6_address | **[PrimaryAddress](#yandex.cloud.compute.v1.PrimaryAddress)**

Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet. ||
|| security_group_ids[] | **string**

ID's of security groups attached to the interface ||
|#

## PrimaryAddress {#yandex.cloud.compute.v1.PrimaryAddress}

#|
||Field | Description ||
|| address | **string**

An IPv4 internal network address that is assigned to the instance for this network interface. ||
|| one_to_one_nat | **[OneToOneNat](#yandex.cloud.compute.v1.OneToOneNat)**

One-to-one NAT configuration. If missing, NAT has not been set up. ||
|| dns_records[] | **[DnsRecord](#yandex.cloud.compute.v1.DnsRecord)**

Internal DNS configuration ||
|#

## OneToOneNat {#yandex.cloud.compute.v1.OneToOneNat}

#|
||Field | Description ||
|| address | **string**

An external IP address associated with this instance. ||
|| ip_version | enum **IpVersion**

IP version for the external IP address.

- `IP_VERSION_UNSPECIFIED`
- `IPV4`: IPv4 address, for example 192.0.2.235.
- `IPV6`: IPv6 address. Not available yet. ||
|| dns_records[] | **[DnsRecord](#yandex.cloud.compute.v1.DnsRecord)**

External DNS configuration ||
|#

## DnsRecord {#yandex.cloud.compute.v1.DnsRecord}

#|
||Field | Description ||
|| fqdn | **string**

Name of the A/AAAA record as specified when creating the instance.
Note that if `fqdn' has no trailing '.', it is specified relative to the zone (@see dns_zone_id). ||
|| dns_zone_id | **string**

DNS zone id for the record (optional, if not set, some private zone is used). ||
|| ttl | **int64**

DNS record ttl (optional, if not set, a reasonable default is used.) ||
|| ptr | **bool**

When true, indicates there is a corresponding auto-created PTR DNS record. ||
|#

## SerialPortSettings {#yandex.cloud.compute.v1.SerialPortSettings2}

#|
||Field | Description ||
|| ssh_authorization | enum **SSHAuthorization**

Authentication and authorization in serial console when using SSH protocol

- `SSH_AUTHORIZATION_UNSPECIFIED`
- `INSTANCE_METADATA`: Authentication and authorization using SSH keys in instance metadata
- `OS_LOGIN`: Authentication and authorization using Oslogin service ||
|#

## GpuSettings {#yandex.cloud.compute.v1.GpuSettings2}

#|
||Field | Description ||
|| gpu_cluster_id | **string**

Attach instance to specified GPU cluster. ||
|#

## SchedulingPolicy {#yandex.cloud.compute.v1.SchedulingPolicy2}

#|
||Field | Description ||
|| preemptible | **bool**

True for short-lived compute instances. For more information, see [Preemptible VMs](/docs/compute/concepts/preemptible-vm). ||
|#

## NetworkSettings {#yandex.cloud.compute.v1.NetworkSettings2}

#|
||Field | Description ||
|| type | enum **Type**

Network Type

- `TYPE_UNSPECIFIED`
- `STANDARD`: Standard network.
- `SOFTWARE_ACCELERATED`: Software accelerated network.
- `HARDWARE_ACCELERATED`: Hardware accelerated network (not available yet, reserved for future use). ||
|#

## PlacementPolicy {#yandex.cloud.compute.v1.PlacementPolicy2}

#|
||Field | Description ||
|| placement_group_id | **string**

Placement group ID. ||
|| host_affinity_rules[] | **[HostAffinityRule](#yandex.cloud.compute.v1.PlacementPolicy.HostAffinityRule2)**

List of affinity rules. Scheduler will attempt to allocate instances according to order of rules. ||
|| placement_group_partition | **int64**

Placement group partition ||
|#

## HostAffinityRule {#yandex.cloud.compute.v1.PlacementPolicy.HostAffinityRule2}

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

## HardwareGeneration {#yandex.cloud.compute.v1.HardwareGeneration}

A set of features, specific to a particular Compute hardware generation.
They are not necessary supported by every host OS or distro, thus they are fixed to an image
and are applied to all instances created with it as their boot disk image.
These features significantly determine how the instance is created, thus cannot be changed after the fact.

#|
||Field | Description ||
|| legacy_features | **[LegacyHardwareFeatures](#yandex.cloud.compute.v1.LegacyHardwareFeatures)**

Includes only one of the fields `legacy_features`, `generation2_features`. ||
|| generation2_features | **[Generation2HardwareFeatures](#yandex.cloud.compute.v1.Generation2HardwareFeatures)**

Includes only one of the fields `legacy_features`, `generation2_features`. ||
|#

## LegacyHardwareFeatures {#yandex.cloud.compute.v1.LegacyHardwareFeatures}

A first hardware generation, by default compatible with all legacy images.
Allows switching to PCI_TOPOLOGY_V2 and back.

#|
||Field | Description ||
|| pci_topology | enum **PCITopology**

- `PCI_TOPOLOGY_UNSPECIFIED`
- `PCI_TOPOLOGY_V1`
- `PCI_TOPOLOGY_V2` ||
|#

## Generation2HardwareFeatures {#yandex.cloud.compute.v1.Generation2HardwareFeatures}

A second hardware generation, which by default assumes PCI_TOPOLOGY_V2
and UEFI boot (with UEFI related features).

#|
||Field | Description ||
|| Empty | > ||
|#