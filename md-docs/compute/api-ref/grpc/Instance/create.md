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
      "block_size": "int64",
      "disk_placement_policy": {
        "placement_group_id": "string",
        "placement_group_partition": "int64"
      },
      // Includes only one of the fields `image_id`, `snapshot_id`
      "image_id": "string",
      "snapshot_id": "string",
      // end of the list of possible fields
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
        "block_size": "int64",
        "disk_placement_policy": {
          "placement_group_id": "string",
          "placement_group_partition": "int64"
        },
        // Includes only one of the fields `image_id`, `snapshot_id`
        "image_id": "string",
        "snapshot_id": "string",
        // end of the list of possible fields
        "kms_key_id": "string"
      },
      "disk_id": "string"
      // end of the list of possible fields
    }
  ],
  "filesystem_specs": [
    {
      "mode": "Mode",
      "device_name": "string",
      "filesystem_id": "string"
    }
  ],
  "local_disk_specs": [
    {
      "size": "int64",
      // Includes only one of the fields `physical_local_disk`
      "physical_local_disk": {
        "kms_key_id": "string"
      }
      // end of the list of possible fields
    }
  ],
  "network_interface_specs": [
    {
      "index": "string",
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
      ]
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
    "placement_group_partition": "int64",
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
  "gpu_settings": {
    "gpu_cluster_id": "string"
  },
  "maintenance_policy": "MaintenancePolicy",
  "maintenance_grace_period": "google.protobuf.Duration",
  "metadata_options": {
    "gce_http_endpoint": "MetadataOption",
    "aws_v1_http_endpoint": "MetadataOption",
    "gce_http_token": "MetadataOption",
    "aws_v1_http_token": "MetadataOption",
    "aws_v2_http_endpoint": "MetadataOption",
    "aws_v2_http_token": "MetadataOption"
  },
  "serial_port_settings": {
    "ssh_authorization": "SSHAuthorization"
  },
  "application": {
    // Includes only one of the fields `container_solution`
    "container_solution": {
      "product_id": "string",
      "secrets": "map<string, Secret>",
      "environment": "map<string, string>"
    },
    // end of the list of possible fields
    "cloudbackup": {
      "enabled": "bool",
      "initial_policy_ids": [
        "string"
      ],
      "recovery_from_backup": "bool",
      "backup_id": "string",
      "instance_registration_id": "string"
    }
  },
  "reserved_instance_pool_id": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

ID of the folder to create an instance in.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](../../../../resource-manager/api-ref/grpc/Folder/list.md#List) request.
The length must be less than or equal to 50.
This field is required. ||
|| name | **string**

Name of the instance.
The value must match the regular expression: ```|[a-z]([-_a-z0-9]{0,61}[a-z0-9])?```. ||
|| description | **string**

Description of the instance.
The length must be less than or equal to 256. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.
Each map key must match the regular expression: `[a-z][-_./\\@0-9a-z]*`.
Each map value must match the regular expression: `[-_./\\@0-9a-z]*`.
The length of each map key must be between 1 and 63.
The length of each map value must be less than or equal to 63.
The number of elements must be less than or equal to 64. ||
|| zone_id | **string**

ID of the availability zone where the instance resides.
To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](../Zone/list.md#List) request
The length must be less than or equal to 50.
This field is required. ||
|| platform_id | **string**

ID of the hardware platform configuration for the instance.
This field affects the available values in `resources_spec` field.
Platforms allows you to create various types of instances: with a large amount of memory,
with a large number of cores, with a burstable performance.
For more information, see [Platforms](../../../concepts/vm-platforms.md).
This field is required. ||
|| resources_spec | **[ResourcesSpec](#yandex.cloud.compute.v1.ResourcesSpec)**

Computing resources of the instance, such as the amount of memory and number of cores.
To get a list of available values, see [Levels of core performance](../../../concepts/performance-levels.md).
This field is required. ||
|| metadata | **object** (map<**string**, **string**>)

The metadata `key:value` pairs that will be assigned to this instance. This includes custom metadata and predefined keys.
The total size of all keys and values must be less than 512 KB.
Values are free-form strings, and only have meaning as interpreted by the programs which configure the instance.
The values must be 256 KB or less.
For example, you may use the metadata in order to provide your public SSH key to the instance.
For more information, see [Metadata](../../../concepts/vm-metadata.md). ||
|| boot_disk_spec | **[AttachedDiskSpec](#yandex.cloud.compute.v1.AttachedDiskSpec)**

Boot disk to attach to the instance.
This field is required. ||
|| secondary_disk_specs[] | **[AttachedDiskSpec](#yandex.cloud.compute.v1.AttachedDiskSpec)**

Array of secondary disks to attach to the instance.
The number of elements must be less than or equal to 3. ||
|| filesystem_specs[] | **[AttachedFilesystemSpec](#yandex.cloud.compute.v1.AttachedFilesystemSpec)**

Array of filesystems to attach to the instance.
The filesystems must reside in the same availability zone as the instance.
To use the instance with an attached filesystem, the latter must be mounted.
For details, see [documentation](../../../operations/filesystem/attach-to-vm.md). ||
|| local_disk_specs[] | **[AttachedLocalDiskSpec](#yandex.cloud.compute.v1.AttachedLocalDiskSpec)**

Array of local disks to attach to the instance. ||
|| network_interface_specs[] | **[NetworkInterfaceSpec](#yandex.cloud.compute.v1.NetworkInterfaceSpec)**

Network configuration for the instance. Specifies how the network interface is configured
to interact with other services on the internal network and on the internet.
This field is required. ||
|| hostname | **string**

Host name for the instance.
This field is used to generate the [yandex.cloud.compute.v1.Instance.fqdn](../GpuCluster/listInstances.md#yandex.cloud.compute.v1.Instance) value.
The host name must be unique within the network and region.
If not specified, the host name will be equal to [yandex.cloud.compute.v1.Instance.id](../GpuCluster/listInstances.md#yandex.cloud.compute.v1.Instance) of the instance
and FQDN will be `<id>.auto.internal`. Otherwise FQDN will be `<hostname>.<region_id>.internal`.
The value must match the regular expression: ```|[a-z]([-_a-z0-9]{0,61}[a-z0-9])?```. ||
|| scheduling_policy | **[SchedulingPolicy](#yandex.cloud.compute.v1.SchedulingPolicy)**

Scheduling policy configuration. ||
|| service_account_id | **string**

ID of the service account to use for [authentication inside the instance](../../../operations/vm-connect/auth-inside-vm.md).
To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](../../../../iam/api-ref/grpc/ServiceAccount/list.md#List) request. ||
|| network_settings | **[NetworkSettings](#yandex.cloud.compute.v1.NetworkSettings)**

Network settings. ||
|| placement_policy | **[PlacementPolicy](#yandex.cloud.compute.v1.PlacementPolicy)**

Placement policy configuration. ||
|| gpu_settings | **[GpuSettings](#yandex.cloud.compute.v1.GpuSettings)**

GPU settings. ||
|| maintenance_policy | enum **MaintenancePolicy**

Behaviour on maintenance events

- `RESTART`: Restart instance to move it to another host during maintenance
- `MIGRATE`: Use live migration to move instance to another host during maintenance ||
|| maintenance_grace_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Time between notification via metadata service and maintenance
The value must satisfy: 1s-24h. ||
|| metadata_options | **[MetadataOptions](#yandex.cloud.compute.v1.MetadataOptions)**

Options allow user to configure access to instance's metadata ||
|| serial_port_settings | **[SerialPortSettings](#yandex.cloud.compute.v1.SerialPortSettings)**

Serial port settings ||
|| application | **[Application](#yandex.cloud.compute.v1.Application)**

Instance application settings. ||
|| reserved_instance_pool_id | **string**

ID of the reserved instance pool that the instance should belong to.
Instance will be created using resources from the reserved instance pool.
Reserved instance pool resource configuration must match the resource configuration of the instance.
The length must be less than or equal to 50. ||
|#

## ResourcesSpec {#yandex.cloud.compute.v1.ResourcesSpec}

#|
||Field | Description ||
|| memory | **int64**

The amount of memory available to the instance, specified in bytes.
The value must be less than or equal to 274877906944.
This field is required. ||
|| cores | **int64**

The number of cores available to the instance.
The value must satisfy: 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,40,44,48,52,56,60,64,68,72,76,80.
This field is required. ||
|| core_fraction | **int64**

Baseline level of CPU performance with the ability to burst performance above that baseline level.
This field sets baseline performance for each core.
For example, if you need only 5% of the CPU performance, you can set core_fraction=5.
For more information, see [Levels of core performance](../../../concepts/performance-levels.md).
The value must satisfy: 0,5,20,50,100. ||
|| gpus | **int64**

The number of GPUs available to the instance.
The value must satisfy: 0,1,2,4. ||
|#

## AttachedDiskSpec {#yandex.cloud.compute.v1.AttachedDiskSpec}

#|
||Field | Description ||
|| mode | enum **Mode**

The mode in which to attach this disk.

- `READ_ONLY`: Read-only access.
- `READ_WRITE`: Read/Write access. Default value. ||
|| device_name | **string**

Specifies a unique serial number of your choice that is reflected into the /dev/disk/by-id/ tree
of a Linux operating system running within the instance.
This value can be used to reference the device for mounting, resizing, and so on, from within the instance.
If not specified, a random value will be generated.
The value must match the regular expression: `[a-z][a-z0-9-_]{,19}`. ||
|| auto_delete | **bool**

Specifies whether the disk will be auto-deleted when the instance is deleted. ||
|| disk_spec | **[DiskSpec](#yandex.cloud.compute.v1.AttachedDiskSpec.DiskSpec)**

Disk specification.

Includes only one of the fields `disk_spec`, `disk_id`.

Only one field must by specified. ||
|| disk_id | **string**

ID of the disk that should be attached.
The length must be less than or equal to 50.

Includes only one of the fields `disk_spec`, `disk_id`.

Only one field must by specified. ||
|#

## DiskSpec {#yandex.cloud.compute.v1.AttachedDiskSpec.DiskSpec}

#|
||Field | Description ||
|| name | **string**

Name of the disk.
The value must match the regular expression: ```|[a-z]([-_a-z0-9]{0,61}[a-z0-9])?```. ||
|| description | **string**

Description of the disk.
The length must be less than or equal to 256. ||
|| type_id | **string**

ID of the disk type.
To get a list of available disk types, use the [yandex.cloud.compute.v1.DiskTypeService.List](../DiskType/list.md#List) request.
The length must be less than or equal to 50. ||
|| size | **int64**

Size of the disk, specified in bytes.
The value must be between 4194304 and 4398046511104.
This field is required. ||
|| block_size | **int64**

Block size of the disk, specified in bytes. The default is 4096. ||
|| disk_placement_policy | **[DiskPlacementPolicy](#yandex.cloud.compute.v1.DiskPlacementPolicy)**

Placement policy configuration. ||
|| image_id | **string**

ID of the image to create the disk from.
The length must be less than or equal to 50.

Includes only one of the fields `image_id`, `snapshot_id`. ||
|| snapshot_id | **string**

ID of the snapshot to restore the disk from.
The length must be less than or equal to 50.

Includes only one of the fields `image_id`, `snapshot_id`. ||
|| kms_key_id | **string**

ID of KMS key for disk encryption
The length must be less than or equal to 50. ||
|#

## DiskPlacementPolicy {#yandex.cloud.compute.v1.DiskPlacementPolicy}

#|
||Field | Description ||
|| placement_group_id | **string**

Placement group ID. ||
|| placement_group_partition | **int64** ||
|#

## AttachedFilesystemSpec {#yandex.cloud.compute.v1.AttachedFilesystemSpec}

#|
||Field | Description ||
|| mode | enum **Mode**

Mode of access to the filesystem that should be attached.

- `READ_ONLY`: Read-only access.
- `READ_WRITE`: Read/Write access. Default value. ||
|| device_name | **string**

Name of the device representing the filesystem on the instance.
The name should be used for referencing the filesystem from within the instance
when it's being mounted, resized etc.
If not specified, a random value will be generated.
The value must match the regular expression: `[a-z][a-z0-9-_]{,19}`. ||
|| filesystem_id | **string**

ID of the filesystem that should be attached.
The length must be less than or equal to 50. ||
|#

## AttachedLocalDiskSpec {#yandex.cloud.compute.v1.AttachedLocalDiskSpec}

#|
||Field | Description ||
|| size | **int64**

Size of the disk, specified in bytes.
This field is required. ||
|| physical_local_disk | **[PhysicalLocalDiskSpec](#yandex.cloud.compute.v1.PhysicalLocalDiskSpec)**

Local disk configuration

Includes only one of the fields `physical_local_disk`. ||
|#

## PhysicalLocalDiskSpec {#yandex.cloud.compute.v1.PhysicalLocalDiskSpec}

#|
||Field | Description ||
|| kms_key_id | **string**

ID of KMS key for disk encryption ||
|#

## NetworkInterfaceSpec {#yandex.cloud.compute.v1.NetworkInterfaceSpec}

#|
||Field | Description ||
|| index | **string**

The index of the network interface, will be generated by the server, 0,1,2... etc if not specified. ||
|| subnet_id | **string**

ID of the subnet.
The length must be less than or equal to 50.
This field is required. ||
|| primary_v4_address_spec | **[PrimaryAddressSpec](#yandex.cloud.compute.v1.PrimaryAddressSpec)**

Primary IPv4 address that will be assigned to the instance for this network interface. ||
|| primary_v6_address_spec | **[PrimaryAddressSpec](#yandex.cloud.compute.v1.PrimaryAddressSpec)**

Primary IPv6 address that will be assigned to the instance for this network interface. IPv6 not available yet. ||
|| security_group_ids[] | **string**

ID's of security groups attached to the interface ||
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

FQDN (required)
This field is required. ||
|| dns_zone_id | **string**

DNS zone id (optional, if not set, private zone used) ||
|| ttl | **int64**

DNS record ttl, values in 0-86400 (optional)
The value must be between 0 and 86400. ||
|| ptr | **bool**

When set to true, also create PTR DNS record (optional) ||
|#

## SchedulingPolicy {#yandex.cloud.compute.v1.SchedulingPolicy}

#|
||Field | Description ||
|| preemptible | **bool**

True for short-lived compute instances. For more information, see [Preemptible VMs](../../../concepts/preemptible-vm.md). ||
|#

## NetworkSettings {#yandex.cloud.compute.v1.NetworkSettings}

#|
||Field | Description ||
|| type | enum **Type**

Network Type

- `STANDARD`: Standard network.
- `SOFTWARE_ACCELERATED`: Software accelerated network.
- `HARDWARE_ACCELERATED`: Hardware accelerated network (not available yet, reserved for future use). ||
|#

## PlacementPolicy {#yandex.cloud.compute.v1.PlacementPolicy}

#|
||Field | Description ||
|| placement_group_id | **string**

Placement group ID. ||
|| placement_group_partition | **int64**

Placement group partition ||
|| host_affinity_rules[] | **[HostAffinityRule](#yandex.cloud.compute.v1.PlacementPolicy.HostAffinityRule)**

List of affinity rules. Scheduler will attempt to allocate instances according to order of rules. ||
|#

## HostAffinityRule {#yandex.cloud.compute.v1.PlacementPolicy.HostAffinityRule}

Affinity definition

#|
||Field | Description ||
|| key | **string**

Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId' ||
|| op | enum **Operator**

Include or exclude action

- `IN`: Include action
- `NOT_IN`: Exclude action ||
|| values[] | **string**

Affinity value or host ID or host group ID ||
|#

## GpuSettings {#yandex.cloud.compute.v1.GpuSettings}

#|
||Field | Description ||
|| gpu_cluster_id | **string**

Attach instance to specified GPU cluster. ||
|#

## MetadataOptions {#yandex.cloud.compute.v1.MetadataOptions}

#|
||Field | Description ||
|| gce_http_endpoint | enum **MetadataOption**

Enabled access to GCE flavored metadata

- `ENABLED`: Option is enabled
- `DISABLED`: Option is disabled ||
|| aws_v1_http_endpoint | enum **MetadataOption**

Enabled access to AWS flavored metadata (IMDSv1)

- `ENABLED`: Option is enabled
- `DISABLED`: Option is disabled ||
|| gce_http_token | enum **MetadataOption**

Enabled access to IAM credentials with GCE flavored metadata

- `ENABLED`: Option is enabled
- `DISABLED`: Option is disabled ||
|| aws_v1_http_token | enum **MetadataOption**

Enabled access to IAM credentials with AWS flavored metadata (IMDSv1)

- `ENABLED`: Option is enabled
- `DISABLED`: Option is disabled ||
|| aws_v2_http_endpoint | enum **MetadataOption**

Enabled access to AWS flavored metadata with session token (IMDSv2)

- `ENABLED`: Option is enabled
- `DISABLED`: Option is disabled ||
|| aws_v2_http_token | enum **MetadataOption**

Enabled access to STS credentials with AWS flavored metadata with session token (IMDSv2)

- `ENABLED`: Option is enabled
- `DISABLED`: Option is disabled ||
|#

## SerialPortSettings {#yandex.cloud.compute.v1.SerialPortSettings}

#|
||Field | Description ||
|| ssh_authorization | enum **SSHAuthorization**

Authentication and authorization in serial console when using SSH protocol

- `INSTANCE_METADATA`: Authentication and authorization using SSH keys in instance metadata
- `OS_LOGIN`: Authentication and authorization using Oslogin service ||
|#

## Application {#yandex.cloud.compute.v1.Application}

#|
||Field | Description ||
|| container_solution | **[ContainerSolutionSpec](#yandex.cloud.compute.v1.ContainerSolutionSpec)**

Container specification.

Includes only one of the fields `container_solution`. ||
|| cloudbackup | **[BackupSpec](#yandex.cloud.compute.v1.BackupSpec)**

Backup settings. ||
|#

## ContainerSolutionSpec {#yandex.cloud.compute.v1.ContainerSolutionSpec}

#|
||Field | Description ||
|| product_id | **string**

ID of the product.
The length must be less than or equal to 50.
This field is required. ||
|| secrets | **object** (map<**string**, **[Secret](#yandex.cloud.compute.v1.Secret)**>)

A list of the secrets.
The length of each map key must be less than or equal to 100.
The number of elements must be less than or equal to 100. ||
|| environment | **object** (map<**string**, **string**>)

A list of the environmets.
The length of each map key must be less than or equal to 100.
The length of each map value must be less than or equal to 10000.
The number of elements must be less than or equal to 100. ||
|#

## Secret {#yandex.cloud.compute.v1.Secret}

#|
||Field | Description ||
|| id | **string**

ID of the secret.
The length must be less than or equal to 50.
This field is required. ||
|| key | **string**

Name of the key.
The length must be less than or equal to 256.
This field is required. ||
|| version_id | **string**

Version of the secret.
The length must be less than or equal to 50. ||
|#

## BackupSpec {#yandex.cloud.compute.v1.BackupSpec}

#|
||Field | Description ||
|| enabled | **bool**

If true, backup is enabled. ||
|| initial_policy_ids[] | **string**

A list of policy IDs to apply after resource registration.
The length of each element must be between 1 and 50.
The number of elements must be less than or equal to 50. ||
|| recovery_from_backup | **bool**

If true, recovery from backup starts on instance. ||
|| backup_id | **string**

ID of the backup to recover from.
The length must be less than or equal to 100. ||
|| instance_registration_id | **string**

ID of the instance registration for cloud backup agent installation.
The length must be less than or equal to 100. ||
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
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Any"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../../api-design-guide/concepts/operation.md).

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
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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
|| response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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