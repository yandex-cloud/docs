---
editable: false
apiPlayground:
  - url: https://loadtesting.{{ api-host }}/loadtesting/api/v1/agent
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. ID of the folder to create an agent in.
          type: string
        name:
          description: |-
            **string**
            Name of the agent.
            A created compute instance will have the same name.
          pattern: '|[a-z][-a-z0-9]{1,61}[a-z0-9]'
          type: string
        description:
          description: |-
            **string**
            Description of the agent.
            A created compute instance will have the same description.
          type: string
        computeInstanceParams:
          description: |-
            **[CreateComputeInstance](#yandex.cloud.loadtesting.api.v1.agent.CreateComputeInstance)**
            Parameters for compute instance to be created.
          $ref: '#/definitions/CreateComputeInstance'
        agentVersion:
          description: |-
            **string**
            Version of the agent.
            If not provided, the most recent agent version will be used.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Agent labels as `key:value` pairs.
          type: object
          additionalProperties:
            type: string
            pattern: '[-_0-9a-z]*'
            maxLength: 63
          propertyNames:
            type: string
            pattern: '[a-z][-_0-9a-z]*'
            maxLength: 63
            minLength: 1
          maxProperties: 64
        logSettings:
          description: |-
            **[LogSettings](#yandex.cloud.loadtesting.api.v1.agent.LogSettings)**
            Agent log settings
          $ref: '#/definitions/LogSettings'
      required:
        - folderId
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
      DiskPlacementPolicy:
        type: object
        properties:
          placementGroupId:
            description: |-
              **string**
              Placement group ID.
            type: string
          placementGroupPartition:
            description: '**string** (int64)'
            type: string
            format: int64
      DiskSpec:
        type: object
        properties:
          name:
            description: |-
              **string**
              Name of the disk.
            pattern: '|[a-z]([-_a-z0-9]{0,61}[a-z0-9])?'
            type: string
          description:
            description: |-
              **string**
              Description of the disk.
            type: string
          typeId:
            description: |-
              **string**
              ID of the disk type.
              To get a list of available disk types, use the [yandex.cloud.compute.v1.DiskTypeService.List](/docs/compute/api-ref/DiskType/list#List) request.
            type: string
          size:
            description: |-
              **string** (int64)
              Required field. Size of the disk, specified in bytes.
            type: string
            format: int64
          imageId:
            description: |-
              **string**
              ID of the image to create the disk from.
              Includes only one of the fields `imageId`, `snapshotId`.
            type: string
          snapshotId:
            description: |-
              **string**
              ID of the snapshot to restore the disk from.
              Includes only one of the fields `imageId`, `snapshotId`.
            type: string
          diskPlacementPolicy:
            description: |-
              **[DiskPlacementPolicy](#yandex.cloud.compute.v1.DiskPlacementPolicy)**
              Placement policy configuration.
            $ref: '#/definitions/DiskPlacementPolicy'
          blockSize:
            description: |-
              **string** (int64)
              Block size of the disk, specified in bytes. The default is 4096.
            type: string
            format: int64
          kmsKeyId:
            description: |-
              **string**
              ID of KMS key for disk encryption
            type: string
        required:
          - size
        oneOf:
          - required:
              - imageId
          - required:
              - snapshotId
      AttachedDiskSpec:
        type: object
        properties:
          mode:
            description: |-
              **enum** (Mode)
              The mode in which to attach this disk.
              - `MODE_UNSPECIFIED`
              - `READ_ONLY`: Read-only access.
              - `READ_WRITE`: Read/Write access. Default value.
            type: string
            enum:
              - MODE_UNSPECIFIED
              - READ_ONLY
              - READ_WRITE
          deviceName:
            description: |-
              **string**
              Specifies a unique serial number of your choice that is reflected into the /dev/disk/by-id/ tree
              of a Linux operating system running within the instance.
              This value can be used to reference the device for mounting, resizing, and so on, from within the instance.
              If not specified, a random value will be generated.
            pattern: '[a-z][a-z0-9-_]{,19}'
            type: string
          autoDelete:
            description: |-
              **boolean**
              Specifies whether the disk will be auto-deleted when the instance is deleted.
            type: boolean
          diskSpec:
            description: |-
              **[DiskSpec](#yandex.cloud.compute.v1.AttachedDiskSpec.DiskSpec)**
              Disk specification.
              Includes only one of the fields `diskSpec`, `diskId`.
            $ref: '#/definitions/DiskSpec'
          diskId:
            description: |-
              **string**
              ID of the disk that should be attached.
              Includes only one of the fields `diskSpec`, `diskId`.
            type: string
        oneOf:
          - required:
              - diskSpec
          - required:
              - diskId
      DnsRecordSpec:
        type: object
        properties:
          fqdn:
            description: |-
              **string**
              Required field. FQDN (required)
            type: string
          dnsZoneId:
            description: |-
              **string**
              DNS zone id (optional, if not set, private zone used)
            type: string
          ttl:
            description: |-
              **string** (int64)
              DNS record ttl, values in 0-86400 (optional)
            type: string
            format: int64
          ptr:
            description: |-
              **boolean**
              When set to true, also create PTR DNS record (optional)
            type: boolean
        required:
          - fqdn
      OneToOneNatSpec:
        type: object
        properties:
          ipVersion:
            description: |-
              **enum** (IpVersion)
              External IP address version.
              - `IP_VERSION_UNSPECIFIED`
              - `IPV4`: IPv4 address, for example 192.0.2.235.
              - `IPV6`: IPv6 address. Not available yet.
            type: string
            enum:
              - IP_VERSION_UNSPECIFIED
              - IPV4
              - IPV6
          address:
            description: |-
              **string**
              set static IP by value
            type: string
          dnsRecordSpecs:
            description: |-
              **[DnsRecordSpec](#yandex.cloud.compute.v1.DnsRecordSpec)**
              External DNS configuration
            type: array
            items:
              $ref: '#/definitions/DnsRecordSpec'
      PrimaryAddressSpec:
        type: object
        properties:
          address:
            description: |-
              **string**
              An IPv4 internal network address that is assigned to the instance for this network interface.
              If not specified by the user, an unused internal IP is assigned by the system.
            type: string
          oneToOneNatSpec:
            description: |-
              **[OneToOneNatSpec](#yandex.cloud.compute.v1.OneToOneNatSpec)**
              An external IP address configuration.
              If not specified, then this instance will have no external internet access.
            $ref: '#/definitions/OneToOneNatSpec'
          dnsRecordSpecs:
            description: |-
              **[DnsRecordSpec](#yandex.cloud.compute.v1.DnsRecordSpec)**
              Internal DNS configuration
            type: array
            items:
              $ref: '#/definitions/DnsRecordSpec'
      NetworkInterfaceSpec:
        type: object
        properties:
          subnetId:
            description: |-
              **string**
              Required field. ID of the subnet.
            type: string
          primaryV4AddressSpec:
            description: |-
              **[PrimaryAddressSpec](#yandex.cloud.compute.v1.PrimaryAddressSpec)**
              Primary IPv4 address that will be assigned to the instance for this network interface.
            $ref: '#/definitions/PrimaryAddressSpec'
          primaryV6AddressSpec:
            description: |-
              **[PrimaryAddressSpec](#yandex.cloud.compute.v1.PrimaryAddressSpec)**
              Primary IPv6 address that will be assigned to the instance for this network interface. IPv6 not available yet.
            $ref: '#/definitions/PrimaryAddressSpec'
          securityGroupIds:
            description: |-
              **string**
              ID's of security groups attached to the interface
            type: array
            items:
              type: string
          index:
            description: |-
              **string**
              The index of the network interface, will be generated by the server, 0,1,2... etc if not specified.
            type: string
        required:
          - subnetId
      CreateComputeInstance:
        type: object
        properties:
          labels:
            description: |-
              **object** (map<**string**, **string**>)
              Resource labels as `key:value` pairs.
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
          zoneId:
            description: |-
              **string**
              Required field. ID of the availability zone where the instance resides.
              To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/Zone/list#List) request
            type: string
          resourcesSpec:
            description: |-
              **[ResourcesSpec](#yandex.cloud.compute.v1.ResourcesSpec)**
              Required field. Computing resources of the instance, such as the amount of memory and number of cores.
              To get a list of available values, see [Levels of core performance](/docs/compute/concepts/performance-levels).
            $ref: '#/definitions/ResourcesSpec'
          metadata:
            description: |-
              **object** (map<**string**, **string**>)
              The metadata `key:value` pairs that will be assigned to this instance. This includes custom metadata and predefined keys.
              The total size of all keys and values must be less than 512 KB.
              Values are free-form strings, and only have meaning as interpreted by the programs which configure the instance.
              The values must be 256 KB or less.
              For example, you may use the metadata in order to provide your public SSH key to the instance.
              For more information, see [Metadata](/docs/compute/concepts/vm-metadata).
            type: object
            additionalProperties:
              type: string
          bootDiskSpec:
            description: |-
              **[AttachedDiskSpec](#yandex.cloud.compute.v1.AttachedDiskSpec)**
              Required field. Boot disk to attach to the instance.
            $ref: '#/definitions/AttachedDiskSpec'
          networkInterfaceSpecs:
            description: |-
              **[NetworkInterfaceSpec](#yandex.cloud.compute.v1.NetworkInterfaceSpec)**
              Network configuration for the instance. Specifies how the network interface is configured
              to interact with other services on the internal network and on the internet.
              Currently only one network interface is supported per instance.
            type: array
            items:
              $ref: '#/definitions/NetworkInterfaceSpec'
          serviceAccountId:
            description: |-
              **string**
              ID of the service account to use for [authentication inside the instance](/docs/compute/operations/vm-connect/auth-inside-vm).
              To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/ServiceAccount/list#List) request.
            type: string
          platformId:
            description: |-
              **string**
              ID of the [Compute VM platform](/docs/compute/concepts/vm-platforms) on which the agent will be created.
              Default value: "standard-v2"
            default: standard-v2
            type: string
        required:
          - zoneId
          - resourcesSpec
          - bootDiskSpec
      LogSettings:
        type: object
        properties:
          cloudLogGroupId:
            description: |-
              **string**
              Id of Yandex Cloud log group to upload agent logs to
            type: string
sourcePath: en/_api-ref/loadtesting/api/v1/user/api-ref/Agent/create.md
---

# Load Testing API, REST: Agent.Create

Creates an agent in the specified folder.

Also creates a corresponding compute instance.

## HTTP request

```
POST https://loadtesting.{{ api-host }}/loadtesting/api/v1/agent
```

## Body parameters {#yandex.cloud.loadtesting.api.v1.CreateAgentRequest}

```json
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "computeInstanceParams": {
    "labels": "object",
    "zoneId": "string",
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
      "autoDelete": "boolean",
      // Includes only one of the fields `diskSpec`, `diskId`
      "diskSpec": {
        "name": "string",
        "description": "string",
        "typeId": "string",
        "size": "string",
        // Includes only one of the fields `imageId`, `snapshotId`
        "imageId": "string",
        "snapshotId": "string",
        // end of the list of possible fields
        "diskPlacementPolicy": {
          "placementGroupId": "string",
          "placementGroupPartition": "string"
        },
        "blockSize": "string",
        "kmsKeyId": "string"
      },
      "diskId": "string"
      // end of the list of possible fields
    },
    "networkInterfaceSpecs": [
      {
        "subnetId": "string",
        "primaryV4AddressSpec": {
          "address": "string",
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
          "address": "string",
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
        ],
        "index": "string"
      }
    ],
    "serviceAccountId": "string",
    "platformId": "string"
  },
  "agentVersion": "string",
  "labels": "object",
  "logSettings": {
    "cloudLogGroupId": "string"
  }
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to create an agent in. ||
|| name | **string**

Name of the agent.

A created compute instance will have the same name. ||
|| description | **string**

Description of the agent.

A created compute instance will have the same description. ||
|| computeInstanceParams | **[CreateComputeInstance](#yandex.cloud.loadtesting.api.v1.agent.CreateComputeInstance)**

Parameters for compute instance to be created. ||
|| agentVersion | **string**

Version of the agent.

If not provided, the most recent agent version will be used. ||
|| labels | **object** (map<**string**, **string**>)

Agent labels as `key:value` pairs. ||
|| logSettings | **[LogSettings](#yandex.cloud.loadtesting.api.v1.agent.LogSettings)**

Agent log settings ||
|#

## CreateComputeInstance {#yandex.cloud.loadtesting.api.v1.agent.CreateComputeInstance}

#|
||Field | Description ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|| zoneId | **string**

Required field. ID of the availability zone where the instance resides.
To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/Zone/list#List) request ||
|| resourcesSpec | **[ResourcesSpec](#yandex.cloud.compute.v1.ResourcesSpec)**

Required field. Computing resources of the instance, such as the amount of memory and number of cores.
To get a list of available values, see [Levels of core performance](/docs/compute/concepts/performance-levels). ||
|| metadata | **object** (map<**string**, **string**>)

The metadata `key:value` pairs that will be assigned to this instance. This includes custom metadata and predefined keys.
The total size of all keys and values must be less than 512 KB.

Values are free-form strings, and only have meaning as interpreted by the programs which configure the instance.
The values must be 256 KB or less.

For example, you may use the metadata in order to provide your public SSH key to the instance.
For more information, see [Metadata](/docs/compute/concepts/vm-metadata). ||
|| bootDiskSpec | **[AttachedDiskSpec](#yandex.cloud.compute.v1.AttachedDiskSpec)**

Required field. Boot disk to attach to the instance. ||
|| networkInterfaceSpecs[] | **[NetworkInterfaceSpec](#yandex.cloud.compute.v1.NetworkInterfaceSpec)**

Network configuration for the instance. Specifies how the network interface is configured
to interact with other services on the internal network and on the internet.
Currently only one network interface is supported per instance. ||
|| serviceAccountId | **string**

ID of the service account to use for [authentication inside the instance](/docs/compute/operations/vm-connect/auth-inside-vm).
To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/ServiceAccount/list#List) request. ||
|| platformId | **string**

ID of the [Compute VM platform](/docs/compute/concepts/vm-platforms) on which the agent will be created.
Default value: "standard-v2" ||
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

## AttachedDiskSpec {#yandex.cloud.compute.v1.AttachedDiskSpec}

#|
||Field | Description ||
|| mode | **enum** (Mode)

The mode in which to attach this disk.

- `MODE_UNSPECIFIED`
- `READ_ONLY`: Read-only access.
- `READ_WRITE`: Read/Write access. Default value. ||
|| deviceName | **string**

Specifies a unique serial number of your choice that is reflected into the /dev/disk/by-id/ tree
of a Linux operating system running within the instance.

This value can be used to reference the device for mounting, resizing, and so on, from within the instance.
If not specified, a random value will be generated. ||
|| autoDelete | **boolean**

Specifies whether the disk will be auto-deleted when the instance is deleted. ||
|| diskSpec | **[DiskSpec](#yandex.cloud.compute.v1.AttachedDiskSpec.DiskSpec)**

Disk specification.

Includes only one of the fields `diskSpec`, `diskId`. ||
|| diskId | **string**

ID of the disk that should be attached.

Includes only one of the fields `diskSpec`, `diskId`. ||
|#

## DiskSpec {#yandex.cloud.compute.v1.AttachedDiskSpec.DiskSpec}

#|
||Field | Description ||
|| name | **string**

Name of the disk. ||
|| description | **string**

Description of the disk. ||
|| typeId | **string**

ID of the disk type.
To get a list of available disk types, use the [yandex.cloud.compute.v1.DiskTypeService.List](/docs/compute/api-ref/DiskType/list#List) request. ||
|| size | **string** (int64)

Required field. Size of the disk, specified in bytes. ||
|| imageId | **string**

ID of the image to create the disk from.

Includes only one of the fields `imageId`, `snapshotId`. ||
|| snapshotId | **string**

ID of the snapshot to restore the disk from.

Includes only one of the fields `imageId`, `snapshotId`. ||
|| diskPlacementPolicy | **[DiskPlacementPolicy](#yandex.cloud.compute.v1.DiskPlacementPolicy)**

Placement policy configuration. ||
|| blockSize | **string** (int64)

Block size of the disk, specified in bytes. The default is 4096. ||
|| kmsKeyId | **string**

ID of KMS key for disk encryption ||
|#

## DiskPlacementPolicy {#yandex.cloud.compute.v1.DiskPlacementPolicy}

#|
||Field | Description ||
|| placementGroupId | **string**

Placement group ID. ||
|| placementGroupPartition | **string** (int64) ||
|#

## NetworkInterfaceSpec {#yandex.cloud.compute.v1.NetworkInterfaceSpec}

#|
||Field | Description ||
|| subnetId | **string**

Required field. ID of the subnet. ||
|| primaryV4AddressSpec | **[PrimaryAddressSpec](#yandex.cloud.compute.v1.PrimaryAddressSpec)**

Primary IPv4 address that will be assigned to the instance for this network interface. ||
|| primaryV6AddressSpec | **[PrimaryAddressSpec](#yandex.cloud.compute.v1.PrimaryAddressSpec)**

Primary IPv6 address that will be assigned to the instance for this network interface. IPv6 not available yet. ||
|| securityGroupIds[] | **string**

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
|| oneToOneNatSpec | **[OneToOneNatSpec](#yandex.cloud.compute.v1.OneToOneNatSpec)**

An external IP address configuration.
If not specified, then this instance will have no external internet access. ||
|| dnsRecordSpecs[] | **[DnsRecordSpec](#yandex.cloud.compute.v1.DnsRecordSpec)**

Internal DNS configuration ||
|#

## OneToOneNatSpec {#yandex.cloud.compute.v1.OneToOneNatSpec}

#|
||Field | Description ||
|| ipVersion | **enum** (IpVersion)

External IP address version.

- `IP_VERSION_UNSPECIFIED`
- `IPV4`: IPv4 address, for example 192.0.2.235.
- `IPV6`: IPv6 address. Not available yet. ||
|| address | **string**

set static IP by value ||
|| dnsRecordSpecs[] | **[DnsRecordSpec](#yandex.cloud.compute.v1.DnsRecordSpec)**

External DNS configuration ||
|#

## DnsRecordSpec {#yandex.cloud.compute.v1.DnsRecordSpec}

#|
||Field | Description ||
|| fqdn | **string**

Required field. FQDN (required) ||
|| dnsZoneId | **string**

DNS zone id (optional, if not set, private zone used) ||
|| ttl | **string** (int64)

DNS record ttl, values in 0-86400 (optional) ||
|| ptr | **boolean**

When set to true, also create PTR DNS record (optional) ||
|#

## LogSettings {#yandex.cloud.loadtesting.api.v1.agent.LogSettings}

#|
||Field | Description ||
|| cloudLogGroupId | **string**

Id of Yandex Cloud log group to upload agent logs to ||
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
    "agentId": "string"
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
    "name": "string",
    "description": "string",
    "computeInstanceId": "string",
    "status": "string",
    "errors": [
      "string"
    ],
    "currentJobId": "string",
    "agentVersionId": "string",
    "labels": "object",
    "logSettings": {
      "cloudLogGroupId": "string"
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
|| metadata | **[CreateAgentMetadata](#yandex.cloud.loadtesting.api.v1.CreateAgentMetadata)**

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
|| agentId | **string**

ID of the agent that is being created. ||
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

## Agent {#yandex.cloud.loadtesting.api.v1.agent.Agent}

Load testing agent on which tests are executed.

#|
||Field | Description ||
|| id | **string**

ID of the agent. Generated at creation time. ||
|| folderId | **string**

ID of the folder that the agent belongs to. ||
|| name | **string**

Name of the agent. ||
|| description | **string**

Description of the agent. ||
|| computeInstanceId | **string**

ID of the compute instance managed by the agent.

Empty if there is no such instance (i.e. the case of external agent). ||
|| status | **enum** (Status)

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
|| currentJobId | **string**

ID of the test that is currently being executed by the agent. ||
|| agentVersionId | **string**

Version of the agent. ||
|| labels | **object** (map<**string**, **string**>)

Agent labels as `key:value` pairs. ||
|| logSettings | **[LogSettings](#yandex.cloud.loadtesting.api.v1.agent.LogSettings2)**

Agent log settings ||
|#

## LogSettings {#yandex.cloud.loadtesting.api.v1.agent.LogSettings2}

#|
||Field | Description ||
|| cloudLogGroupId | **string**

Id of Yandex Cloud log group to upload agent logs to ||
|#