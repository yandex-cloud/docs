---
editable: false
apiPlayground:
  - url: https://compute.{{ api-host }}/compute/v1/instances/{instanceId}
    method: patch
    path:
      type: object
      properties:
        instanceId:
          description: |-
            **string**
            ID of the Instance resource to update.
            To get the instance ID, use a [InstanceService.List](/docs/compute/api-ref/Instance/list#List) request.
            The length must be less than or equal to 50.
            This field is required.
          type: string
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        updateMask:
          description: |-
            **string** (field-mask)
            A comma-separated names off ALL fields to be updated.
            Only the specified fields will be changed. The others will be left untouched.
            If the field is specified in `` updateMask `` and no value for that field was sent in the request,
            the field's value will be reset to the default. The default value for most fields is null or 0.
            If `` updateMask `` is not sent in the request, all fields' values will be updated.
            Fields specified in the request will be updated to provided values.
            The rest of the fields will be reset to the default.
          type: string
          format: field-mask
        name:
          description: |-
            **string**
            Name of the instance.
            The value must match the regular expression: `|[a-z]([-_a-z0-9]{0,61}[a-z0-9])?`.
          type: string
        description:
          description: |-
            **string**
            Description of the instance.
            The length must be less than or equal to 256.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Resource labels as `key:value` pairs.
            Existing set of `labels` is completely replaced by the provided set.
            Each map key must match the regular expression: `[a-z][-_./\\@0-9a-z]*`.
            Each map value must match the regular expression: `[-_./\\@0-9a-z]*`.
            The length of each map key must be between 1 and 63.
            The length of each map value must be less than or equal to 63.
            The number of elements must be less than or equal to 64.
          type: object
          additionalProperties:
            type: string
        platformId:
          description: |-
            **string**
            ID of the hardware platform configuration for the instance.
            This field affects the available values in `resourcesSpec` field.
            Platforms allows you to create various types of instances: with a large amount of memory,
            with a large number of cores, with a burstable performance.
            For more information, see [Platforms](/docs/compute/concepts/vm-platforms).
          type: string
        resourcesSpec:
          description: |-
            **[ResourcesSpec](#yandex.cloud.compute.v1.ResourcesSpec)**
            Computing resources of the instance, such as the amount of memory and number of cores.
            To get a list of available values, see [Levels of core performance](/docs/compute/concepts/performance-levels).
          $ref: '#/definitions/ResourcesSpec'
        metadata:
          description: |-
            **object** (map<**string**, **string**>)
            The metadata `key:value` pairs that will be assigned to this instance. This includes custom metadata and predefined keys.
            The total size of all keys and values must be less than 512 KB.
            Existing set of `metadata` is completely replaced by the provided set.
            Values are free-form strings, and only have meaning as interpreted by the programs which configure the instance.
            The values must be 256 KB or less.
            For example, you may use the metadata in order to provide your public SSH key to the instance.
            For more information, see [Metadata](/docs/compute/concepts/vm-metadata).
          type: object
          additionalProperties:
            type: string
        schedulingPolicy:
          description: |-
            **[SchedulingPolicy](#yandex.cloud.compute.v1.SchedulingPolicy)**
            Scheduling policy configuration.
          $ref: '#/definitions/SchedulingPolicy'
        serviceAccountId:
          description: |-
            **string**
            ID of the service account to use for [authentication inside the instance](/docs/compute/operations/vm-connect/auth-inside-vm).
            To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/ServiceAccount/list#List) request.
          type: string
        networkSettings:
          description: |-
            **[NetworkSettings](#yandex.cloud.compute.v1.NetworkSettings)**
            Network settings.
          $ref: '#/definitions/NetworkSettings'
        placementPolicy:
          description: |-
            **[PlacementPolicy](#yandex.cloud.compute.v1.PlacementPolicy)**
            Placement policy configuration.
          $ref: '#/definitions/PlacementPolicy'
        maintenancePolicy:
          description: |-
            **enum** (MaintenancePolicy)
            Behaviour on maintenance events
            - `RESTART`: Restart instance to move it to another host during maintenance
            - `MIGRATE`: Use live migration to move instance to another host during maintenance
          type: string
          enum:
            - MAINTENANCE_POLICY_UNSPECIFIED
            - RESTART
            - MIGRATE
        maintenanceGracePeriod:
          description: |-
            **string** (duration)
            Time between notification via metadata service and maintenance
            The value must satisfy: 1s-24h.
          type: string
          format: duration
        metadataOptions:
          description: |-
            **[MetadataOptions](#yandex.cloud.compute.v1.MetadataOptions)**
            Options allow user to configure access to instance's metadata
          $ref: '#/definitions/MetadataOptions'
        serialPortSettings:
          description: |-
            **[SerialPortSettings](#yandex.cloud.compute.v1.SerialPortSettings)**
            Serial port settings
          $ref: '#/definitions/SerialPortSettings'
        application:
          description: |-
            **[Application](#yandex.cloud.compute.v1.Application)**
            Instance application settings.
          $ref: '#/definitions/Application'
        reservedInstancePoolId:
          description: |-
            **string**
            ID of the reserved instance pool that the instance should belong to.
            Attaching/detaching running instance will increase/decrease the size of the reserved instance pool.
            Attaching/detaching stopped instance will leave the size of the reserved instance pool unchanged. Starting such attached instance will use resources from the reserved instance pool.
            Reserved instance pool resource configuration must match the resource configuration of the instance.
            The length must be less than or equal to 50.
          type: string
      additionalProperties: false
    definitions:
      ResourcesSpec:
        type: object
        properties:
          memory:
            description: |-
              **string** (int64)
              The amount of memory available to the instance, specified in bytes.
              The value must be less than or equal to 274877906944.
              This field is required.
            type: string
            format: int64
          cores:
            description: |-
              **string** (int64)
              The number of cores available to the instance.
              The value must satisfy: 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,40,44,48,52,56,60,64,68,72,76,80.
              This field is required.
            type: string
            format: int64
          coreFraction:
            description: |-
              **string** (int64)
              Baseline level of CPU performance with the ability to burst performance above that baseline level.
              This field sets baseline performance for each core.
              For example, if you need only 5% of the CPU performance, you can set core_fraction=5.
              For more information, see [Levels of core performance](/docs/compute/concepts/performance-levels).
              The value must satisfy: 0,5,20,50,100.
            type: string
            format: int64
          gpus:
            description: |-
              **string** (int64)
              The number of GPUs available to the instance.
              The value must satisfy: 0,1,2,4.
            type: string
            format: int64
      SchedulingPolicy:
        type: object
        properties:
          preemptible:
            description: |-
              **boolean**
              True for short-lived compute instances. For more information, see [Preemptible VMs](/docs/compute/concepts/preemptible-vm).
            type: boolean
      NetworkSettings:
        type: object
        properties:
          type:
            description: |-
              **enum** (Type)
              Network Type
              - `STANDARD`: Standard network.
              - `SOFTWARE_ACCELERATED`: Software accelerated network.
              - `HARDWARE_ACCELERATED`: Hardware accelerated network (not available yet, reserved for future use).
            type: string
            enum:
              - TYPE_UNSPECIFIED
              - STANDARD
              - SOFTWARE_ACCELERATED
              - HARDWARE_ACCELERATED
      HostAffinityRule:
        type: object
        properties:
          key:
            description: |-
              **string**
              Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId'
            type: string
          op:
            description: |-
              **enum** (Operator)
              Include or exclude action
              - `IN`: Include action
              - `NOT_IN`: Exclude action
            type: string
            enum:
              - OPERATOR_UNSPECIFIED
              - IN
              - NOT_IN
          values:
            description: |-
              **string**
              Affinity value or host ID or host group ID
            type: array
            items:
              type: string
      PlacementPolicy:
        type: object
        properties:
          placementGroupId:
            description: |-
              **string**
              Placement group ID.
            type: string
          placementGroupPartition:
            description: |-
              **string** (int64)
              Placement group partition
            type: string
            format: int64
          hostAffinityRules:
            description: |-
              **[HostAffinityRule](#yandex.cloud.compute.v1.PlacementPolicy.HostAffinityRule)**
              List of affinity rules. Scheduler will attempt to allocate instances according to order of rules.
            type: array
            items:
              $ref: '#/definitions/HostAffinityRule'
      MetadataOptions:
        type: object
        properties:
          gceHttpEndpoint:
            description: |-
              **enum** (MetadataOption)
              Enabled access to GCE flavored metadata
              - `ENABLED`: Option is enabled
              - `DISABLED`: Option is disabled
            type: string
            enum:
              - METADATA_OPTION_UNSPECIFIED
              - ENABLED
              - DISABLED
          awsV1HttpEndpoint:
            description: |-
              **enum** (MetadataOption)
              Enabled access to AWS flavored metadata (IMDSv1)
              - `ENABLED`: Option is enabled
              - `DISABLED`: Option is disabled
            type: string
            enum:
              - METADATA_OPTION_UNSPECIFIED
              - ENABLED
              - DISABLED
          gceHttpToken:
            description: |-
              **enum** (MetadataOption)
              Enabled access to IAM credentials with GCE flavored metadata
              - `ENABLED`: Option is enabled
              - `DISABLED`: Option is disabled
            type: string
            enum:
              - METADATA_OPTION_UNSPECIFIED
              - ENABLED
              - DISABLED
          awsV1HttpToken:
            description: |-
              **enum** (MetadataOption)
              Enabled access to IAM credentials with AWS flavored metadata (IMDSv1)
              - `ENABLED`: Option is enabled
              - `DISABLED`: Option is disabled
            type: string
            enum:
              - METADATA_OPTION_UNSPECIFIED
              - ENABLED
              - DISABLED
          awsV2HttpEndpoint:
            description: |-
              **enum** (MetadataOption)
              Enabled access to AWS flavored metadata with session token (IMDSv2)
              - `ENABLED`: Option is enabled
              - `DISABLED`: Option is disabled
            type: string
            enum:
              - METADATA_OPTION_UNSPECIFIED
              - ENABLED
              - DISABLED
          awsV2HttpToken:
            description: |-
              **enum** (MetadataOption)
              Enabled access to STS credentials with AWS flavored metadata with session token (IMDSv2)
              - `ENABLED`: Option is enabled
              - `DISABLED`: Option is disabled
            type: string
            enum:
              - METADATA_OPTION_UNSPECIFIED
              - ENABLED
              - DISABLED
      SerialPortSettings:
        type: object
        properties:
          sshAuthorization:
            description: |-
              **enum** (SSHAuthorization)
              Authentication and authorization in serial console when using SSH protocol
              - `INSTANCE_METADATA`: Authentication and authorization using SSH keys in instance metadata
              - `OS_LOGIN`: Authentication and authorization using Oslogin service
            type: string
            enum:
              - SSH_AUTHORIZATION_UNSPECIFIED
              - INSTANCE_METADATA
              - OS_LOGIN
      Secret:
        type: object
        properties:
          id:
            description: |-
              **string**
              ID of the secret.
              The length must be less than or equal to 50.
              This field is required.
            type: string
          key:
            description: |-
              **string**
              Name of the key.
              The length must be less than or equal to 256.
              This field is required.
            type: string
          versionId:
            description: |-
              **string**
              Version of the secret.
              The length must be less than or equal to 50.
            type: string
      ContainerSolutionSpec:
        type: object
        properties:
          productId:
            description: |-
              **string**
              ID of the product.
              The length must be less than or equal to 50.
              This field is required.
            type: string
          secrets:
            description: |-
              **object** (map<**string**, **[Secret](#yandex.cloud.compute.v1.Secret)**>)
              A list of the secrets.
              The length of each map key must be less than or equal to 100.
              The number of elements must be less than or equal to 100.
            type: object
            additionalProperties:
              $ref: '#/definitions/Secret'
          environment:
            description: |-
              **object** (map<**string**, **string**>)
              A list of the environmets.
              The length of each map key must be less than or equal to 100.
              The length of each map value must be less than or equal to 10000.
              The number of elements must be less than or equal to 100.
            type: object
            additionalProperties:
              type: string
      BackupSpec:
        type: object
        properties:
          enabled:
            description: |-
              **boolean**
              If true, backup is enabled.
            type: boolean
          initialPolicyIds:
            description: |-
              **string**
              A list of policy IDs to apply after resource registration.
              The length of each element must be between 1 and 50.
              The number of elements must be less than or equal to 50.
            type: array
            items:
              type: string
          recoveryFromBackup:
            description: |-
              **boolean**
              If true, recovery from backup starts on instance.
            type: boolean
          backupId:
            description: |-
              **string**
              ID of the backup to recover from.
              The length must be less than or equal to 100.
            type: string
          instanceRegistrationId:
            description: |-
              **string**
              ID of the instance registration for cloud backup agent installation.
              The length must be less than or equal to 100.
            type: string
      Application:
        type: object
        properties:
          containerSolution:
            description: |-
              **[ContainerSolutionSpec](#yandex.cloud.compute.v1.ContainerSolutionSpec)**
              Container specification.
              Includes only one of the fields `containerSolution`.
            $ref: '#/definitions/ContainerSolutionSpec'
          cloudbackup:
            description: |-
              **[BackupSpec](#yandex.cloud.compute.v1.BackupSpec)**
              Backup settings.
            $ref: '#/definitions/BackupSpec'
        oneOf:
          - required:
              - containerSolution
---

# Compute Cloud API, REST: Instance.Update

Updates the specified instance.

## HTTP request

```
PATCH https://compute.{{ api-host }}/compute/v1/instances/{instanceId}
```

## Path parameters

#|
||Field | Description ||
|| instanceId | **string**

Required field. ID of the Instance resource to update.
To get the instance ID, use a [InstanceService.List](/docs/compute/api-ref/Instance/list#List) request.
The length must be less than or equal to 50.
This field is required. ||
|#

## Body parameters {#yandex.cloud.compute.v1.UpdateInstanceRequest}

```json
{
  "updateMask": "string",
  "name": "string",
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
  "schedulingPolicy": {
    "preemptible": "boolean"
  },
  "serviceAccountId": "string",
  "networkSettings": {
    "type": "string"
  },
  "placementPolicy": {
    "placementGroupId": "string",
    "placementGroupPartition": "string",
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
  "maintenancePolicy": "string",
  "maintenanceGracePeriod": "string",
  "metadataOptions": {
    "gceHttpEndpoint": "string",
    "awsV1HttpEndpoint": "string",
    "gceHttpToken": "string",
    "awsV1HttpToken": "string",
    "awsV2HttpEndpoint": "string",
    "awsV2HttpToken": "string"
  },
  "serialPortSettings": {
    "sshAuthorization": "string"
  },
  "application": {
    // Includes only one of the fields `containerSolution`
    "containerSolution": {
      "productId": "string",
      "secrets": "object",
      "environment": "object"
    },
    // end of the list of possible fields
    "cloudbackup": {
      "enabled": "boolean",
      "initialPolicyIds": [
        "string"
      ],
      "recoveryFromBackup": "boolean",
      "backupId": "string",
      "instanceRegistrationId": "string"
    }
  },
  "reservedInstancePoolId": "string"
}
```

#|
||Field | Description ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
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
|| platformId | **string**

ID of the hardware platform configuration for the instance.
This field affects the available values in `resourcesSpec` field.
Platforms allows you to create various types of instances: with a large amount of memory,
with a large number of cores, with a burstable performance.
For more information, see [Platforms](/docs/compute/concepts/vm-platforms). ||
|| resourcesSpec | **[ResourcesSpec](#yandex.cloud.compute.v1.ResourcesSpec)**

Computing resources of the instance, such as the amount of memory and number of cores.
To get a list of available values, see [Levels of core performance](/docs/compute/concepts/performance-levels). ||
|| metadata | **object** (map<**string**, **string**>)

The metadata `key:value` pairs that will be assigned to this instance. This includes custom metadata and predefined keys.
The total size of all keys and values must be less than 512 KB.
Existing set of `metadata` is completely replaced by the provided set.
Values are free-form strings, and only have meaning as interpreted by the programs which configure the instance.
The values must be 256 KB or less.
For example, you may use the metadata in order to provide your public SSH key to the instance.
For more information, see [Metadata](/docs/compute/concepts/vm-metadata). ||
|| schedulingPolicy | **[SchedulingPolicy](#yandex.cloud.compute.v1.SchedulingPolicy)**

Scheduling policy configuration. ||
|| serviceAccountId | **string**

ID of the service account to use for [authentication inside the instance](/docs/compute/operations/vm-connect/auth-inside-vm).
To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/ServiceAccount/list#List) request. ||
|| networkSettings | **[NetworkSettings](#yandex.cloud.compute.v1.NetworkSettings)**

Network settings. ||
|| placementPolicy | **[PlacementPolicy](#yandex.cloud.compute.v1.PlacementPolicy)**

Placement policy configuration. ||
|| maintenancePolicy | **enum** (MaintenancePolicy)

Behaviour on maintenance events

- `RESTART`: Restart instance to move it to another host during maintenance
- `MIGRATE`: Use live migration to move instance to another host during maintenance ||
|| maintenanceGracePeriod | **string** (duration)

Time between notification via metadata service and maintenance
The value must satisfy: 1s-24h. ||
|| metadataOptions | **[MetadataOptions](#yandex.cloud.compute.v1.MetadataOptions)**

Options allow user to configure access to instance's metadata ||
|| serialPortSettings | **[SerialPortSettings](#yandex.cloud.compute.v1.SerialPortSettings)**

Serial port settings ||
|| application | **[Application](#yandex.cloud.compute.v1.Application)**

Instance application settings. ||
|| reservedInstancePoolId | **string**

ID of the reserved instance pool that the instance should belong to.
Attaching/detaching running instance will increase/decrease the size of the reserved instance pool.
Attaching/detaching stopped instance will leave the size of the reserved instance pool unchanged. Starting such attached instance will use resources from the reserved instance pool.
Reserved instance pool resource configuration must match the resource configuration of the instance.
The length must be less than or equal to 50. ||
|#

## ResourcesSpec {#yandex.cloud.compute.v1.ResourcesSpec}

#|
||Field | Description ||
|| memory | **string** (int64)

The amount of memory available to the instance, specified in bytes.
The value must be less than or equal to 274877906944.
This field is required. ||
|| cores | **string** (int64)

The number of cores available to the instance.
The value must satisfy: 2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,40,44,48,52,56,60,64,68,72,76,80.
This field is required. ||
|| coreFraction | **string** (int64)

Baseline level of CPU performance with the ability to burst performance above that baseline level.
This field sets baseline performance for each core.
For example, if you need only 5% of the CPU performance, you can set core_fraction=5.
For more information, see [Levels of core performance](/docs/compute/concepts/performance-levels).
The value must satisfy: 0,5,20,50,100. ||
|| gpus | **string** (int64)

The number of GPUs available to the instance.
The value must satisfy: 0,1,2,4. ||
|#

## SchedulingPolicy {#yandex.cloud.compute.v1.SchedulingPolicy}

#|
||Field | Description ||
|| preemptible | **boolean**

True for short-lived compute instances. For more information, see [Preemptible VMs](/docs/compute/concepts/preemptible-vm). ||
|#

## NetworkSettings {#yandex.cloud.compute.v1.NetworkSettings}

#|
||Field | Description ||
|| type | **enum** (Type)

Network Type

- `STANDARD`: Standard network.
- `SOFTWARE_ACCELERATED`: Software accelerated network.
- `HARDWARE_ACCELERATED`: Hardware accelerated network (not available yet, reserved for future use). ||
|#

## PlacementPolicy {#yandex.cloud.compute.v1.PlacementPolicy}

#|
||Field | Description ||
|| placementGroupId | **string**

Placement group ID. ||
|| placementGroupPartition | **string** (int64)

Placement group partition ||
|| hostAffinityRules[] | **[HostAffinityRule](#yandex.cloud.compute.v1.PlacementPolicy.HostAffinityRule)**

List of affinity rules. Scheduler will attempt to allocate instances according to order of rules. ||
|#

## HostAffinityRule {#yandex.cloud.compute.v1.PlacementPolicy.HostAffinityRule}

Affinity definition

#|
||Field | Description ||
|| key | **string**

Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId' ||
|| op | **enum** (Operator)

Include or exclude action

- `IN`: Include action
- `NOT_IN`: Exclude action ||
|| values[] | **string**

Affinity value or host ID or host group ID ||
|#

## MetadataOptions {#yandex.cloud.compute.v1.MetadataOptions}

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

## SerialPortSettings {#yandex.cloud.compute.v1.SerialPortSettings}

#|
||Field | Description ||
|| sshAuthorization | **enum** (SSHAuthorization)

Authentication and authorization in serial console when using SSH protocol

- `INSTANCE_METADATA`: Authentication and authorization using SSH keys in instance metadata
- `OS_LOGIN`: Authentication and authorization using Oslogin service ||
|#

## Application {#yandex.cloud.compute.v1.Application}

#|
||Field | Description ||
|| containerSolution | **[ContainerSolutionSpec](#yandex.cloud.compute.v1.ContainerSolutionSpec)**

Container specification.

Includes only one of the fields `containerSolution`. ||
|| cloudbackup | **[BackupSpec](#yandex.cloud.compute.v1.BackupSpec)**

Backup settings. ||
|#

## ContainerSolutionSpec {#yandex.cloud.compute.v1.ContainerSolutionSpec}

#|
||Field | Description ||
|| productId | **string**

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
|| versionId | **string**

Version of the secret.
The length must be less than or equal to 50. ||
|#

## BackupSpec {#yandex.cloud.compute.v1.BackupSpec}

#|
||Field | Description ||
|| enabled | **boolean**

If true, backup is enabled. ||
|| initialPolicyIds[] | **string**

A list of policy IDs to apply after resource registration.
The length of each element must be between 1 and 50.
The number of elements must be less than or equal to 50. ||
|| recoveryFromBackup | **boolean**

If true, recovery from backup starts on instance. ||
|| backupId | **string**

ID of the backup to recover from.
The length must be less than or equal to 100. ||
|| instanceRegistrationId | **string**

ID of the instance registration for cloud backup agent installation.
The length must be less than or equal to 100. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **object**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **object**

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

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#