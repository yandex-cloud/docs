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
            Required field. ID of the Instance resource to update.
            To get the instance ID, use a [InstanceService.List](/docs/compute/api-ref/Instance/list#List) request.
          type: string
      required:
        - instanceId
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
          pattern: '|[a-z]([-_a-z0-9]{0,61}[a-z0-9])?'
          type: string
        description:
          description: |-
            **string**
            Description of the instance.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Resource labels as `key:value` pairs.
            Existing set of `labels` is completely replaced by the provided set.
          type: object
          additionalProperties:
            type: string
            pattern: '[-_./\@0-9a-z]*'
            maxLength: 63
          propertyNames:
            type: string
            pattern: '[a-z][-_./\@0-9a-z]*'
            maxLength: 63
            minLength: 1
          maxProperties: 64
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
        metadataOptions:
          description: |-
            **[MetadataOptions](#yandex.cloud.compute.v1.MetadataOptions)**
            Options allow user to configure access to instance's metadata
          $ref: '#/definitions/MetadataOptions'
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
        schedulingPolicy:
          description: |-
            **[SchedulingPolicy](#yandex.cloud.compute.v1.SchedulingPolicy)**
            Scheduling policy configuration.
          $ref: '#/definitions/SchedulingPolicy'
        maintenancePolicy:
          description: |-
            **enum** (MaintenancePolicy)
            Behaviour on maintenance events
            - `MAINTENANCE_POLICY_UNSPECIFIED`
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
          type: string
          format: duration
        serialPortSettings:
          description: |-
            **[SerialPortSettings](#yandex.cloud.compute.v1.SerialPortSettings)**
            Serial port settings
          $ref: '#/definitions/SerialPortSettings'
        reservedInstancePoolId:
          description: |-
            **string**
            ID of the reserved instance pool that the instance should belong to.
            Attaching/detaching running instance will increase/decrease the size of the reserved instance pool.
            Attaching/detaching stopped instance will leave the size of the reserved instance pool unchanged. Starting such attached instance will use resources from the reserved instance pool.
            Reserved instance pool resource configuration must match the resource configuration of the instance.
          type: string
        application:
          description: |-
            **[Application](#yandex.cloud.compute.v1.Application)**
            Instance application settings.
          $ref: '#/definitions/Application'
      additionalProperties: false
    definitions:
      ResourcesSpec:
        type: object
        properties:
          memory:
            description: |-
              **string** (int64)
              Required field. The amount of memory available to the instance, specified in bytes.
            type: string
            format: int64
          cores:
            description: |-
              **string** (int64)
              Required field. The number of cores available to the instance.
            type: string
            format: int64
          coreFraction:
            description: |-
              **string** (int64)
              Baseline level of CPU performance with the ability to burst performance above that baseline level.
              This field sets baseline performance for each core.
              For example, if you need only 5% of the CPU performance, you can set core_fraction=5.
              For more information, see [Levels of core performance](/docs/compute/concepts/performance-levels).
            type: string
            format: int64
          gpus:
            description: |-
              **string** (int64)
              The number of GPUs available to the instance.
            type: string
            format: int64
        required:
          - memory
          - cores
      MetadataOptions:
        type: object
        properties:
          gceHttpEndpoint:
            description: |-
              **enum** (MetadataOption)
              Enabled access to GCE flavored metadata
              - `METADATA_OPTION_UNSPECIFIED`
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
              - `METADATA_OPTION_UNSPECIFIED`
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
              - `METADATA_OPTION_UNSPECIFIED`
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
              - `METADATA_OPTION_UNSPECIFIED`
              - `ENABLED`: Option is enabled
              - `DISABLED`: Option is disabled
            type: string
            enum:
              - METADATA_OPTION_UNSPECIFIED
              - ENABLED
              - DISABLED
      NetworkSettings:
        type: object
        properties:
          type:
            description: |-
              **enum** (Type)
              Network Type
              - `TYPE_UNSPECIFIED`
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
              - `OPERATOR_UNSPECIFIED`
              - `IN`
              - `NOT_IN`
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
          hostAffinityRules:
            description: |-
              **[HostAffinityRule](#yandex.cloud.compute.v1.PlacementPolicy.HostAffinityRule)**
              List of affinity rules. Scheduler will attempt to allocate instances according to order of rules.
            type: array
            items:
              $ref: '#/definitions/HostAffinityRule'
          placementGroupPartition:
            description: |-
              **string** (int64)
              Placement group partition
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
      SerialPortSettings:
        type: object
        properties:
          sshAuthorization:
            description: |-
              **enum** (SSHAuthorization)
              Authentication and authorization in serial console when using SSH protocol
              - `SSH_AUTHORIZATION_UNSPECIFIED`
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
              Required field. ID of the secret.
            type: string
          key:
            description: |-
              **string**
              Required field. Name of the key.
            type: string
          versionId:
            description: |-
              **string**
              Version of the secret.
            type: string
        required:
          - id
          - key
      ContainerSolutionSpec:
        type: object
        properties:
          productId:
            description: |-
              **string**
              Required field. ID of the product.
            type: string
          secrets:
            description: |-
              **object** (map<**string**, **[Secret](#yandex.cloud.compute.v1.Secret)**>)
              A list of the secrets.
            type: object
            additionalProperties:
              $ref: '#/definitions/Secret'
            maxProperties: 100
          environment:
            description: |-
              **object** (map<**string**, **string**>)
              A list of the environmets.
            type: object
            additionalProperties:
              type: string
              maxLength: 10000
            maxProperties: 100
        required:
          - productId
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
            type: string
          instanceRegistrationId:
            description: |-
              **string**
              ID of the instance registration for cloud backup agent installation.
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
sourcePath: en/_api-ref/compute/v1/api-ref/Instance/update.md
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
To get the instance ID, use a [InstanceService.List](/docs/compute/api-ref/Instance/list#List) request. ||
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
  "metadataOptions": {
    "gceHttpEndpoint": "string",
    "awsV1HttpEndpoint": "string",
    "gceHttpToken": "string",
    "awsV1HttpToken": "string"
  },
  "serviceAccountId": "string",
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
    ],
    "placementGroupPartition": "string"
  },
  "schedulingPolicy": {
    "preemptible": "boolean"
  },
  "maintenancePolicy": "string",
  "maintenanceGracePeriod": "string",
  "serialPortSettings": {
    "sshAuthorization": "string"
  },
  "reservedInstancePoolId": "string",
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
  }
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

Name of the instance. ||
|| description | **string**

Description of the instance. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.

Existing set of `labels` is completely replaced by the provided set. ||
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
|| metadataOptions | **[MetadataOptions](#yandex.cloud.compute.v1.MetadataOptions)**

Options allow user to configure access to instance's metadata ||
|| serviceAccountId | **string**

ID of the service account to use for [authentication inside the instance](/docs/compute/operations/vm-connect/auth-inside-vm).
To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/ServiceAccount/list#List) request. ||
|| networkSettings | **[NetworkSettings](#yandex.cloud.compute.v1.NetworkSettings)**

Network settings. ||
|| placementPolicy | **[PlacementPolicy](#yandex.cloud.compute.v1.PlacementPolicy)**

Placement policy configuration. ||
|| schedulingPolicy | **[SchedulingPolicy](#yandex.cloud.compute.v1.SchedulingPolicy)**

Scheduling policy configuration. ||
|| maintenancePolicy | **enum** (MaintenancePolicy)

Behaviour on maintenance events

- `MAINTENANCE_POLICY_UNSPECIFIED`
- `RESTART`: Restart instance to move it to another host during maintenance
- `MIGRATE`: Use live migration to move instance to another host during maintenance ||
|| maintenanceGracePeriod | **string** (duration)

Time between notification via metadata service and maintenance ||
|| serialPortSettings | **[SerialPortSettings](#yandex.cloud.compute.v1.SerialPortSettings)**

Serial port settings ||
|| reservedInstancePoolId | **string**

ID of the reserved instance pool that the instance should belong to.
Attaching/detaching running instance will increase/decrease the size of the reserved instance pool.
Attaching/detaching stopped instance will leave the size of the reserved instance pool unchanged. Starting such attached instance will use resources from the reserved instance pool.
Reserved instance pool resource configuration must match the resource configuration of the instance. ||
|| application | **[Application](#yandex.cloud.compute.v1.Application)**

Instance application settings. ||
|#

## ResourcesSpec {#yandex.cloud.compute.v1.ResourcesSpec}

#|
||Field | Description ||
|| memory | **string** (int64)

Required field. The amount of memory available to the instance, specified in bytes. ||
|| cores | **string** (int64)

Required field. The number of cores available to the instance. ||
|| coreFraction | **string** (int64)

Baseline level of CPU performance with the ability to burst performance above that baseline level.
This field sets baseline performance for each core.

For example, if you need only 5% of the CPU performance, you can set core_fraction=5.
For more information, see [Levels of core performance](/docs/compute/concepts/performance-levels). ||
|| gpus | **string** (int64)

The number of GPUs available to the instance. ||
|#

## MetadataOptions {#yandex.cloud.compute.v1.MetadataOptions}

#|
||Field | Description ||
|| gceHttpEndpoint | **enum** (MetadataOption)

Enabled access to GCE flavored metadata

- `METADATA_OPTION_UNSPECIFIED`
- `ENABLED`: Option is enabled
- `DISABLED`: Option is disabled ||
|| awsV1HttpEndpoint | **enum** (MetadataOption)

Enabled access to AWS flavored metadata (IMDSv1)

- `METADATA_OPTION_UNSPECIFIED`
- `ENABLED`: Option is enabled
- `DISABLED`: Option is disabled ||
|| gceHttpToken | **enum** (MetadataOption)

Enabled access to IAM credentials with GCE flavored metadata

- `METADATA_OPTION_UNSPECIFIED`
- `ENABLED`: Option is enabled
- `DISABLED`: Option is disabled ||
|| awsV1HttpToken | **enum** (MetadataOption)

Enabled access to IAM credentials with AWS flavored metadata (IMDSv1)

- `METADATA_OPTION_UNSPECIFIED`
- `ENABLED`: Option is enabled
- `DISABLED`: Option is disabled ||
|#

## NetworkSettings {#yandex.cloud.compute.v1.NetworkSettings}

#|
||Field | Description ||
|| type | **enum** (Type)

Network Type

- `TYPE_UNSPECIFIED`
- `STANDARD`: Standard network.
- `SOFTWARE_ACCELERATED`: Software accelerated network.
- `HARDWARE_ACCELERATED`: Hardware accelerated network (not available yet, reserved for future use). ||
|#

## PlacementPolicy {#yandex.cloud.compute.v1.PlacementPolicy}

#|
||Field | Description ||
|| placementGroupId | **string**

Placement group ID. ||
|| hostAffinityRules[] | **[HostAffinityRule](#yandex.cloud.compute.v1.PlacementPolicy.HostAffinityRule)**

List of affinity rules. Scheduler will attempt to allocate instances according to order of rules. ||
|| placementGroupPartition | **string** (int64)

Placement group partition ||
|#

## HostAffinityRule {#yandex.cloud.compute.v1.PlacementPolicy.HostAffinityRule}

Affinity definition

#|
||Field | Description ||
|| key | **string**

Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId' ||
|| op | **enum** (Operator)

Include or exclude action

- `OPERATOR_UNSPECIFIED`
- `IN`
- `NOT_IN` ||
|| values[] | **string**

Affinity value or host ID or host group ID ||
|#

## SchedulingPolicy {#yandex.cloud.compute.v1.SchedulingPolicy}

#|
||Field | Description ||
|| preemptible | **boolean**

True for short-lived compute instances. For more information, see [Preemptible VMs](/docs/compute/concepts/preemptible-vm). ||
|#

## SerialPortSettings {#yandex.cloud.compute.v1.SerialPortSettings}

#|
||Field | Description ||
|| sshAuthorization | **enum** (SSHAuthorization)

Authentication and authorization in serial console when using SSH protocol

- `SSH_AUTHORIZATION_UNSPECIFIED`
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

Required field. ID of the product. ||
|| secrets | **object** (map<**string**, **[Secret](#yandex.cloud.compute.v1.Secret)**>)

A list of the secrets. ||
|| environment | **object** (map<**string**, **string**>)

A list of the environmets. ||
|#

## Secret {#yandex.cloud.compute.v1.Secret}

#|
||Field | Description ||
|| id | **string**

Required field. ID of the secret. ||
|| key | **string**

Required field. Name of the key. ||
|| versionId | **string**

Version of the secret. ||
|#

## BackupSpec {#yandex.cloud.compute.v1.BackupSpec}

#|
||Field | Description ||
|| enabled | **boolean**

If true, backup is enabled. ||
|| initialPolicyIds[] | **string**

A list of policy IDs to apply after resource registration. ||
|| recoveryFromBackup | **boolean**

If true, recovery from backup starts on instance. ||
|| backupId | **string**

ID of the backup to recover from. ||
|| instanceRegistrationId | **string**

ID of the instance registration for cloud backup agent installation. ||
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
  "metadata": {
    "instanceId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "id": "string",
    "folderId": "string",
    "createdAt": "string",
    "name": "string",
    "description": "string",
    "labels": "object",
    "zoneId": "string",
    "platformId": "string",
    "resources": {
      "memory": "string",
      "cores": "string",
      "coreFraction": "string",
      "gpus": "string"
    },
    "status": "string",
    "metadata": "object",
    "metadataOptions": {
      "gceHttpEndpoint": "string",
      "awsV1HttpEndpoint": "string",
      "gceHttpToken": "string",
      "awsV1HttpToken": "string"
    },
    "bootDisk": {
      "mode": "string",
      "deviceName": "string",
      "autoDelete": "boolean",
      "diskId": "string"
    },
    "secondaryDisks": [
      {
        "mode": "string",
        "deviceName": "string",
        "autoDelete": "boolean",
        "diskId": "string"
      }
    ],
    "localDisks": [
      {
        "size": "string",
        "deviceName": "string"
      }
    ],
    "filesystems": [
      {
        "mode": "string",
        "deviceName": "string",
        "filesystemId": "string"
      }
    ],
    "networkInterfaces": [
      {
        "index": "string",
        "macAddress": "string",
        "subnetId": "string",
        "primaryV4Address": {
          "address": "string",
          "oneToOneNat": {
            "address": "string",
            "ipVersion": "string",
            "dnsRecords": [
              {
                "fqdn": "string",
                "dnsZoneId": "string",
                "ttl": "string",
                "ptr": "boolean"
              }
            ]
          },
          "dnsRecords": [
            {
              "fqdn": "string",
              "dnsZoneId": "string",
              "ttl": "string",
              "ptr": "boolean"
            }
          ]
        },
        "primaryV6Address": {
          "address": "string",
          "oneToOneNat": {
            "address": "string",
            "ipVersion": "string",
            "dnsRecords": [
              {
                "fqdn": "string",
                "dnsZoneId": "string",
                "ttl": "string",
                "ptr": "boolean"
              }
            ]
          },
          "dnsRecords": [
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
    "serialPortSettings": {
      "sshAuthorization": "string"
    },
    "gpuSettings": {
      "gpuClusterId": "string"
    },
    "fqdn": "string",
    "schedulingPolicy": {
      "preemptible": "boolean"
    },
    "serviceAccountId": "string",
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
      ],
      "placementGroupPartition": "string"
    },
    "hostGroupId": "string",
    "hostId": "string",
    "maintenancePolicy": "string",
    "maintenanceGracePeriod": "string",
    "hardwareGeneration": {
      // Includes only one of the fields `legacyFeatures`, `generation2Features`
      "legacyFeatures": {
        "pciTopology": "string"
      },
      "generation2Features": "object"
      // end of the list of possible fields
    },
    "reservedInstancePoolId": "string",
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
|| metadata | **[UpdateInstanceMetadata](#yandex.cloud.compute.v1.UpdateInstanceMetadata)**

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

## UpdateInstanceMetadata {#yandex.cloud.compute.v1.UpdateInstanceMetadata}

#|
||Field | Description ||
|| instanceId | **string**

ID of the Instance resource that is being updated. ||
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

## Instance {#yandex.cloud.compute.v1.Instance}

An Instance resource. For more information, see [Instances](/docs/compute/concepts/vm).

#|
||Field | Description ||
|| id | **string**

ID of the instance. ||
|| folderId | **string**

ID of the folder that the instance belongs to. ||
|| createdAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the instance. 1-63 characters long. ||
|| description | **string**

Description of the instance. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. Maximum of 64 per resource. ||
|| zoneId | **string**

ID of the availability zone where the instance resides. ||
|| platformId | **string**

ID of the hardware platform configuration for the instance. ||
|| resources | **[Resources](#yandex.cloud.compute.v1.Resources)**

Computing resources of the instance such as the amount of memory and number of cores. ||
|| status | **enum** (Status)

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
|| metadataOptions | **[MetadataOptions](#yandex.cloud.compute.v1.MetadataOptions2)**

Options allow user to configure access to instance's metadata ||
|| bootDisk | **[AttachedDisk](#yandex.cloud.compute.v1.AttachedDisk)**

Boot disk that is attached to the instance. ||
|| secondaryDisks[] | **[AttachedDisk](#yandex.cloud.compute.v1.AttachedDisk)**

Array of secondary disks that are attached to the instance. ||
|| localDisks[] | **[AttachedLocalDisk](#yandex.cloud.compute.v1.AttachedLocalDisk)**

Array of local disks that are attached to the instance. ||
|| filesystems[] | **[AttachedFilesystem](#yandex.cloud.compute.v1.AttachedFilesystem)**

Array of filesystems that are attached to the instance. ||
|| networkInterfaces[] | **[NetworkInterface](#yandex.cloud.compute.v1.NetworkInterface)**

Array of network interfaces that are attached to the instance. ||
|| serialPortSettings | **[SerialPortSettings](#yandex.cloud.compute.v1.SerialPortSettings2)**

Serial port settings ||
|| gpuSettings | **[GpuSettings](#yandex.cloud.compute.v1.GpuSettings)**

GPU settings ||
|| fqdn | **string**

A domain name of the instance. FQDN is defined by the server
in the format `<hostname>.<region_id>.internal` when the instance is created.
If the hostname were not specified when the instance was created, FQDN would be `<id>.auto.internal`. ||
|| schedulingPolicy | **[SchedulingPolicy](#yandex.cloud.compute.v1.SchedulingPolicy2)**

Scheduling policy configuration. ||
|| serviceAccountId | **string**

ID of the service account to use for [authentication inside the instance](/docs/compute/operations/vm-connect/auth-inside-vm).
To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/ServiceAccount/list#List) request. ||
|| networkSettings | **[NetworkSettings](#yandex.cloud.compute.v1.NetworkSettings2)**

Network Settings ||
|| placementPolicy | **[PlacementPolicy](#yandex.cloud.compute.v1.PlacementPolicy2)**

Placement policy configuration. ||
|| hostGroupId | **string**

ID of the dedicated host group that the instance belongs to. ||
|| hostId | **string**

ID of the dedicated host that the instance belongs to. ||
|| maintenancePolicy | **enum** (MaintenancePolicy)

Behaviour on maintenance events

- `MAINTENANCE_POLICY_UNSPECIFIED`
- `RESTART`: Restart instance to move it to another host during maintenance
- `MIGRATE`: Use live migration to move instance to another host during maintenance ||
|| maintenanceGracePeriod | **string** (duration)

Time between notification via metadata service and maintenance ||
|| hardwareGeneration | **[HardwareGeneration](#yandex.cloud.compute.v1.HardwareGeneration)**

This feature set is inherited from the image/disk used as a boot one at the creation of the instance. ||
|| reservedInstancePoolId | **string**

ID of the reserved instance pool that the instance belongs to. ||
|| application | **[Application](#yandex.cloud.compute.v1.Application2)**

Instance application settings. ||
|#

## Resources {#yandex.cloud.compute.v1.Resources}

#|
||Field | Description ||
|| memory | **string** (int64)

The amount of memory available to the instance, specified in bytes. ||
|| cores | **string** (int64)

The number of cores available to the instance. ||
|| coreFraction | **string** (int64)

Baseline level of CPU performance with the ability to burst performance above that baseline level.
This field sets baseline performance for each core. ||
|| gpus | **string** (int64)

The number of GPUs available to the instance. ||
|#

## MetadataOptions {#yandex.cloud.compute.v1.MetadataOptions2}

#|
||Field | Description ||
|| gceHttpEndpoint | **enum** (MetadataOption)

Enabled access to GCE flavored metadata

- `METADATA_OPTION_UNSPECIFIED`
- `ENABLED`: Option is enabled
- `DISABLED`: Option is disabled ||
|| awsV1HttpEndpoint | **enum** (MetadataOption)

Enabled access to AWS flavored metadata (IMDSv1)

- `METADATA_OPTION_UNSPECIFIED`
- `ENABLED`: Option is enabled
- `DISABLED`: Option is disabled ||
|| gceHttpToken | **enum** (MetadataOption)

Enabled access to IAM credentials with GCE flavored metadata

- `METADATA_OPTION_UNSPECIFIED`
- `ENABLED`: Option is enabled
- `DISABLED`: Option is disabled ||
|| awsV1HttpToken | **enum** (MetadataOption)

Enabled access to IAM credentials with AWS flavored metadata (IMDSv1)

- `METADATA_OPTION_UNSPECIFIED`
- `ENABLED`: Option is enabled
- `DISABLED`: Option is disabled ||
|#

## AttachedDisk {#yandex.cloud.compute.v1.AttachedDisk}

#|
||Field | Description ||
|| mode | **enum** (Mode)

Access mode to the Disk resource.

- `MODE_UNSPECIFIED`
- `READ_ONLY`: Read-only access.
- `READ_WRITE`: Read/Write access. ||
|| deviceName | **string**

Serial number that is reflected into the /dev/disk/by-id/ tree
of a Linux operating system running within the instance.

This value can be used to reference the device for mounting, resizing, and so on, from within the instance. ||
|| autoDelete | **boolean**

Specifies whether the disk will be auto-deleted when the instance is deleted. ||
|| diskId | **string**

ID of the disk that is attached to the instance. ||
|#

## AttachedLocalDisk {#yandex.cloud.compute.v1.AttachedLocalDisk}

#|
||Field | Description ||
|| size | **string** (int64)

Size of the disk, specified in bytes. ||
|| deviceName | **string**

Serial number that is reflected into the /dev/disk/by-id/ tree
of a Linux operating system running within the instance.

This value can be used to reference the device for mounting, resizing, and so on, from within the instance. ||
|#

## AttachedFilesystem {#yandex.cloud.compute.v1.AttachedFilesystem}

#|
||Field | Description ||
|| mode | **enum** (Mode)

Access mode to the filesystem.

- `MODE_UNSPECIFIED`
- `READ_ONLY`: Read-only access.
- `READ_WRITE`: Read/Write access. ||
|| deviceName | **string**

Name of the device representing the filesystem on the instance.

The name should be used for referencing the filesystem from within the instance
when it's being mounted, resized etc. ||
|| filesystemId | **string**

ID of the filesystem that is attached to the instance. ||
|#

## NetworkInterface {#yandex.cloud.compute.v1.NetworkInterface}

#|
||Field | Description ||
|| index | **string**

The index of the network interface, will be generated by the server, 0,1,2... etc if not specified. ||
|| macAddress | **string**

MAC address that is assigned to the network interface. ||
|| subnetId | **string**

ID of the subnet. ||
|| primaryV4Address | **[PrimaryAddress](#yandex.cloud.compute.v1.PrimaryAddress)**

Primary IPv4 address that is assigned to the instance for this network interface. ||
|| primaryV6Address | **[PrimaryAddress](#yandex.cloud.compute.v1.PrimaryAddress)**

Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet. ||
|| securityGroupIds[] | **string**

ID's of security groups attached to the interface ||
|#

## PrimaryAddress {#yandex.cloud.compute.v1.PrimaryAddress}

#|
||Field | Description ||
|| address | **string**

An IPv4 internal network address that is assigned to the instance for this network interface. ||
|| oneToOneNat | **[OneToOneNat](#yandex.cloud.compute.v1.OneToOneNat)**

One-to-one NAT configuration. If missing, NAT has not been set up. ||
|| dnsRecords[] | **[DnsRecord](#yandex.cloud.compute.v1.DnsRecord)**

Internal DNS configuration ||
|#

## OneToOneNat {#yandex.cloud.compute.v1.OneToOneNat}

#|
||Field | Description ||
|| address | **string**

An external IP address associated with this instance. ||
|| ipVersion | **enum** (IpVersion)

IP version for the external IP address.

- `IP_VERSION_UNSPECIFIED`
- `IPV4`: IPv4 address, for example 192.0.2.235.
- `IPV6`: IPv6 address. Not available yet. ||
|| dnsRecords[] | **[DnsRecord](#yandex.cloud.compute.v1.DnsRecord)**

External DNS configuration ||
|#

## DnsRecord {#yandex.cloud.compute.v1.DnsRecord}

#|
||Field | Description ||
|| fqdn | **string**

Name of the A/AAAA record as specified when creating the instance.
Note that if `fqdn' has no trailing '.', it is specified relative to the zone (@see dns_zone_id). ||
|| dnsZoneId | **string**

DNS zone id for the record (optional, if not set, some private zone is used). ||
|| ttl | **string** (int64)

DNS record ttl (optional, if not set, a reasonable default is used.) ||
|| ptr | **boolean**

When true, indicates there is a corresponding auto-created PTR DNS record. ||
|#

## SerialPortSettings {#yandex.cloud.compute.v1.SerialPortSettings2}

#|
||Field | Description ||
|| sshAuthorization | **enum** (SSHAuthorization)

Authentication and authorization in serial console when using SSH protocol

- `SSH_AUTHORIZATION_UNSPECIFIED`
- `INSTANCE_METADATA`: Authentication and authorization using SSH keys in instance metadata
- `OS_LOGIN`: Authentication and authorization using Oslogin service ||
|#

## GpuSettings {#yandex.cloud.compute.v1.GpuSettings}

#|
||Field | Description ||
|| gpuClusterId | **string**

Attach instance to specified GPU cluster. ||
|#

## SchedulingPolicy {#yandex.cloud.compute.v1.SchedulingPolicy2}

#|
||Field | Description ||
|| preemptible | **boolean**

True for short-lived compute instances. For more information, see [Preemptible VMs](/docs/compute/concepts/preemptible-vm). ||
|#

## NetworkSettings {#yandex.cloud.compute.v1.NetworkSettings2}

#|
||Field | Description ||
|| type | **enum** (Type)

Network Type

- `TYPE_UNSPECIFIED`
- `STANDARD`: Standard network.
- `SOFTWARE_ACCELERATED`: Software accelerated network.
- `HARDWARE_ACCELERATED`: Hardware accelerated network (not available yet, reserved for future use). ||
|#

## PlacementPolicy {#yandex.cloud.compute.v1.PlacementPolicy2}

#|
||Field | Description ||
|| placementGroupId | **string**

Placement group ID. ||
|| hostAffinityRules[] | **[HostAffinityRule](#yandex.cloud.compute.v1.PlacementPolicy.HostAffinityRule2)**

List of affinity rules. Scheduler will attempt to allocate instances according to order of rules. ||
|| placementGroupPartition | **string** (int64)

Placement group partition ||
|#

## HostAffinityRule {#yandex.cloud.compute.v1.PlacementPolicy.HostAffinityRule2}

Affinity definition

#|
||Field | Description ||
|| key | **string**

Affinity label or one of reserved values - 'yc.hostId', 'yc.hostGroupId' ||
|| op | **enum** (Operator)

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
|| legacyFeatures | **[LegacyHardwareFeatures](#yandex.cloud.compute.v1.LegacyHardwareFeatures)**

Includes only one of the fields `legacyFeatures`, `generation2Features`. ||
|| generation2Features | **object**

Includes only one of the fields `legacyFeatures`, `generation2Features`. ||
|#

## LegacyHardwareFeatures {#yandex.cloud.compute.v1.LegacyHardwareFeatures}

A first hardware generation, by default compatible with all legacy images.
Allows switching to PCI_TOPOLOGY_V2 and back.

#|
||Field | Description ||
|| pciTopology | **enum** (PCITopology)

- `PCI_TOPOLOGY_UNSPECIFIED`
- `PCI_TOPOLOGY_V1`
- `PCI_TOPOLOGY_V2` ||
|#

## Application {#yandex.cloud.compute.v1.Application2}

#|
||Field | Description ||
|| containerSolution | **[ContainerSolutionSpec](#yandex.cloud.compute.v1.ContainerSolutionSpec2)**

Container specification.

Includes only one of the fields `containerSolution`. ||
|| cloudbackup | **[BackupSpec](#yandex.cloud.compute.v1.BackupSpec2)**

Backup settings. ||
|#

## ContainerSolutionSpec {#yandex.cloud.compute.v1.ContainerSolutionSpec2}

#|
||Field | Description ||
|| productId | **string**

Required field. ID of the product. ||
|| secrets | **object** (map<**string**, **[Secret](#yandex.cloud.compute.v1.Secret2)**>)

A list of the secrets. ||
|| environment | **object** (map<**string**, **string**>)

A list of the environmets. ||
|#

## Secret {#yandex.cloud.compute.v1.Secret2}

#|
||Field | Description ||
|| id | **string**

Required field. ID of the secret. ||
|| key | **string**

Required field. Name of the key. ||
|| versionId | **string**

Version of the secret. ||
|#

## BackupSpec {#yandex.cloud.compute.v1.BackupSpec2}

#|
||Field | Description ||
|| enabled | **boolean**

If true, backup is enabled. ||
|| initialPolicyIds[] | **string**

A list of policy IDs to apply after resource registration. ||
|| recoveryFromBackup | **boolean**

If true, recovery from backup starts on instance. ||
|| backupId | **string**

ID of the backup to recover from. ||
|| instanceRegistrationId | **string**

ID of the instance registration for cloud backup agent installation. ||
|#