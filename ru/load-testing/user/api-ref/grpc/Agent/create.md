---
editable: false
sourcePath: en/_api-ref-grpc/loadtesting/api/v1/user/api-ref/grpc/Agent/create.md
---

# Load Testing API, gRPC: AgentService.Create

Creates an agent in the specified folder.

Also creates a corresponding compute instance.

## gRPC request

**rpc Create ([CreateAgentRequest](#yandex.cloud.loadtesting.api.v1.CreateAgentRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateAgentRequest {#yandex.cloud.loadtesting.api.v1.CreateAgentRequest}

```json
{
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "compute_instance_params": {
    "labels": "map<string, string>",
    "zone_id": "string",
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
    "service_account_id": "string",
    "platform_id": "string"
  },
  "agent_version": "string",
  "labels": "map<string, string>",
  "log_settings": {
    "cloud_log_group_id": "string"
  }
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to create an agent in. ||
|| name | **string**

Name of the agent.

A created compute instance will have the same name. ||
|| description | **string**

Description of the agent.

A created compute instance will have the same description. ||
|| compute_instance_params | **[CreateComputeInstance](#yandex.cloud.loadtesting.api.v1.agent.CreateComputeInstance)**

Parameters for compute instance to be created. ||
|| agent_version | **string**

Version of the agent.

If not provided, the most recent agent version will be used. ||
|| labels | **object** (map<**string**, **string**>)

Agent labels as `key:value` pairs. ||
|| log_settings | **[LogSettings](#yandex.cloud.loadtesting.api.v1.agent.LogSettings)**

Agent log settings ||
|#

## CreateComputeInstance {#yandex.cloud.loadtesting.api.v1.agent.CreateComputeInstance}

#|
||Field | Description ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|| zone_id | **string**

Required field. ID of the availability zone where the instance resides.
To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/Zone/list#List) request ||
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
|| boot_disk_spec | **[AttachedDiskSpec](#yandex.cloud.compute.v1.AttachedDiskSpec)**

Required field. Boot disk to attach to the instance. ||
|| network_interface_specs[] | **[NetworkInterfaceSpec](#yandex.cloud.compute.v1.NetworkInterfaceSpec)**

Network configuration for the instance. Specifies how the network interface is configured
to interact with other services on the internal network and on the internet.
Currently only one network interface is supported per instance. ||
|| service_account_id | **string**

ID of the service account to use for [authentication inside the instance](/docs/compute/operations/vm-connect/auth-inside-vm).
To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/ServiceAccount/list#List) request. ||
|| platform_id | **string**

ID of the [Compute VM platform](/docs/compute/concepts/vm-platforms) on which the agent will be created.
Default value: "standard-v2" ||
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

## LogSettings {#yandex.cloud.loadtesting.api.v1.agent.LogSettings}

#|
||Field | Description ||
|| cloud_log_group_id | **string**

Id of Yandex Cloud log group to upload agent logs to ||
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
    "agent_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folder_id": "string",
    "name": "string",
    "description": "string",
    "compute_instance_id": "string",
    "status": "Status",
    "errors": [
      "string"
    ],
    "current_job_id": "string",
    "agent_version_id": "string",
    "labels": "map<string, string>",
    "log_settings": {
      "cloud_log_group_id": "string"
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
|| metadata | **[CreateAgentMetadata](#yandex.cloud.loadtesting.api.v1.CreateAgentMetadata)**

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
|| response | **[Agent](#yandex.cloud.loadtesting.api.v1.agent.Agent)**

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

## CreateAgentMetadata {#yandex.cloud.loadtesting.api.v1.CreateAgentMetadata}

#|
||Field | Description ||
|| agent_id | **string**

ID of the agent that is being created. ||
|#

## Agent {#yandex.cloud.loadtesting.api.v1.agent.Agent}

Load testing agent on which tests are executed.

#|
||Field | Description ||
|| id | **string**

ID of the agent. Generated at creation time. ||
|| folder_id | **string**

ID of the folder that the agent belongs to. ||
|| name | **string**

Name of the agent. ||
|| description | **string**

Description of the agent. ||
|| compute_instance_id | **string**

ID of the compute instance managed by the agent.

Empty if there is no such instance (i.e. the case of external agent). ||
|| status | enum **Status**

Status of the agent.

- `STATUS_UNSPECIFIED`: Status is not specified.
- `PREPARING_TEST`: Agent is preparing a test to be executed.
- `READY_FOR_TEST`: Agent is ready to take a test.
- `TESTING`: Agent is executing a test.
- `TANK_FAILED`: Agent application encountered an error and cannot operate normally.
- `PROVISIONING`: Agent is waiting for resources to be allocated.
- `STOPPING`: Agent is being stopped.
- `STOPPED`: Agent is stopped.
- `STARTING`: Agent is being started.
- `RESTARTING`: Agent is being restarted.
- `UPDATING`: Agent is being updated.
- `ERROR`: Agent encountered an error and cannot operate.
- `CRASHED`: Agent is crashed and will be restarted automatically.
- `DELETING`: Agent is being deleted.
- `INITIALIZING_CONNECTION`: Service is waiting for connection with agent to be established.
- `LOST_CONNECTION_WITH_AGENT`: Service has lost connection with agent.
- `UPLOADING_ARTIFACTS`: Agent is uploading test artifacts. ||
|| errors[] | **string**

List of errors reported by the agent. ||
|| current_job_id | **string**

ID of the test that is currently being executed by the agent. ||
|| agent_version_id | **string**

Version of the agent. ||
|| labels | **object** (map<**string**, **string**>)

Agent labels as `key:value` pairs. ||
|| log_settings | **[LogSettings](#yandex.cloud.loadtesting.api.v1.agent.LogSettings2)**

Agent log settings ||
|#

## LogSettings {#yandex.cloud.loadtesting.api.v1.agent.LogSettings2}

#|
||Field | Description ||
|| cloud_log_group_id | **string**

Id of Yandex Cloud log group to upload agent logs to ||
|#