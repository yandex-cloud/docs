# Compute Cloud API, gRPC: InstanceService.Update

Updates the specified instance.

## gRPC request

**rpc Update ([UpdateInstanceRequest](#yandex.cloud.compute.v1.UpdateInstanceRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateInstanceRequest {#yandex.cloud.compute.v1.UpdateInstanceRequest}

```json
{
  "instance_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "name": "string",
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
|| instance_id | **string**

ID of the Instance resource to update.
To get the instance ID, use a [InstanceService.List](list.md#List) request.
The length must be less than or equal to 50.
This field is required. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the Instance resource are going to be updated. ||
|| name | **string**

Name of the instance.
The value must match the regular expression: ```|[a-z]([-_a-z0-9]{0,61}[a-z0-9])?```. ||
|| description | **string**

Description of the instance.
The length must be less than or equal to 256. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.
Existing set of `labels` is completely replaced by the provided set.
Each map key must match the regular expression: `[a-z][-_./\\@0-9a-z]*`.
Each map value must match the regular expression: `[-_./\\@0-9a-z]*`.
The length of each map key must be between 1 and 63.
The length of each map value must be less than or equal to 63.
The number of elements must be less than or equal to 64. ||
|| platform_id | **string**

ID of the hardware platform configuration for the instance.
This field affects the available values in `resources_spec` field.
Platforms allows you to create various types of instances: with a large amount of memory,
with a large number of cores, with a burstable performance.
For more information, see [Platforms](../../../concepts/vm-platforms.md). ||
|| resources_spec | **[ResourcesSpec](#yandex.cloud.compute.v1.ResourcesSpec)**

Computing resources of the instance, such as the amount of memory and number of cores.
To get a list of available values, see [Levels of core performance](../../../concepts/performance-levels.md). ||
|| metadata | **object** (map<**string**, **string**>)

The metadata `key:value` pairs that will be assigned to this instance. This includes custom metadata and predefined keys.
The total size of all keys and values must be less than 512 KB.
Existing set of `metadata` is completely replaced by the provided set.
Values are free-form strings, and only have meaning as interpreted by the programs which configure the instance.
The values must be 256 KB or less.
For example, you may use the metadata in order to provide your public SSH key to the instance.
For more information, see [Metadata](../../../concepts/vm-metadata.md). ||
|| scheduling_policy | **[SchedulingPolicy](#yandex.cloud.compute.v1.SchedulingPolicy)**

Scheduling policy configuration. ||
|| service_account_id | **string**

ID of the service account to use for [authentication inside the instance](../../../operations/vm-connect/auth-inside-vm.md).
To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](../../../../iam/api-ref/grpc/ServiceAccount/list.md#List) request. ||
|| network_settings | **[NetworkSettings](#yandex.cloud.compute.v1.NetworkSettings)**

Network settings. ||
|| placement_policy | **[PlacementPolicy](#yandex.cloud.compute.v1.PlacementPolicy)**

Placement policy configuration. ||
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
Attaching/detaching running instance will increase/decrease the size of the reserved instance pool.
Attaching/detaching stopped instance will leave the size of the reserved instance pool unchanged. Starting such attached instance will use resources from the reserved instance pool.
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