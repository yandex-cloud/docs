---
editable: false
apiPlayground:
  - url: https://compute.{{ api-host }}/compute/v1/instances
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. ID of the folder to create an instance in.
            To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.
            The maximum string length in characters is 50.
          type: string
        name:
          description: |-
            **string**
            Name of the instance.
            Value must match the regular expression ` |[a-z]([-_a-z0-9]{0,61}[a-z0-9])? `.
          pattern: '|[a-z]([-_a-z0-9]{0,61}[a-z0-9])?'
          type: string
        description:
          description: |-
            **string**
            Description of the instance.
            The maximum string length in characters is 256.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Resource labels as `key:value` pairs.
            No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\@0-9a-z]* `.
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
            The maximum string length in characters is 50.
          type: string
        platformId:
          description: |-
            **string**
            Required field. ID of the hardware platform configuration for the instance.
            This field affects the available values in `resourcesSpec` field.
            Platforms allows you to create various types of instances: with a large amount of memory,
            with a large number of cores, with a burstable performance.
            For more information, see [Platforms](/docs/compute/concepts/vm-platforms).
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
        metadataOptions:
          description: |-
            **[MetadataOptions](#yandex.cloud.compute.v1.MetadataOptions)**
            Options allow user to configure access to instance's metadata
          $ref: '#/definitions/MetadataOptions'
        bootDiskSpec:
          description: |-
            **[AttachedDiskSpec](#yandex.cloud.compute.v1.AttachedDiskSpec)**
            Required field. Boot disk to attach to the instance.
          $ref: '#/definitions/AttachedDiskSpec'
        secondaryDiskSpecs:
          description: |-
            **[AttachedDiskSpec](#yandex.cloud.compute.v1.AttachedDiskSpec)**
            Array of secondary disks to attach to the instance.
            The maximum number of elements is 3.
          type: array
          items:
            $ref: '#/definitions/AttachedDiskSpec'
        localDiskSpecs:
          description: |-
            **[AttachedLocalDiskSpec](#yandex.cloud.compute.v1.AttachedLocalDiskSpec)**
            Array of local disks to attach to the instance.
          type: array
          items:
            $ref: '#/definitions/AttachedLocalDiskSpec'
        filesystemSpecs:
          description: |-
            **[AttachedFilesystemSpec](#yandex.cloud.compute.v1.AttachedFilesystemSpec)**
            Array of filesystems to attach to the instance.
            The filesystems must reside in the same availability zone as the instance.
            To use the instance with an attached filesystem, the latter must be mounted.
            For details, see [documentation](/docs/compute/operations/filesystem/attach-to-vm).
          type: array
          items:
            $ref: '#/definitions/AttachedFilesystemSpec'
        networkInterfaceSpecs:
          description: |-
            **[NetworkInterfaceSpec](#yandex.cloud.compute.v1.NetworkInterfaceSpec)**
            Required field. Network configuration for the instance. Specifies how the network interface is configured
            to interact with other services on the internal network and on the internet.
          type: array
          items:
            $ref: '#/definitions/NetworkInterfaceSpec'
        hostname:
          description: |-
            **string**
            Host name for the instance.
            This field is used to generate the [yandex.cloud.compute.v1.Instance.fqdn](#yandex.cloud.compute.v1.Instance) value.
            The host name must be unique within the network and region.
            If not specified, the host name will be equal to [yandex.cloud.compute.v1.Instance.id](#yandex.cloud.compute.v1.Instance) of the instance
            and FQDN will be `<id>.auto.internal`. Otherwise FQDN will be `<hostname>.<region_id>.internal`.
            Value must match the regular expression ` |[a-z]([-_a-z0-9]{0,61}[a-z0-9])? `.
          pattern: '|[a-z]([-_a-z0-9]{0,61}[a-z0-9])?'
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
        gpuSettings:
          description: |-
            **[GpuSettings](#yandex.cloud.compute.v1.GpuSettings)**
            GPU settings.
          $ref: '#/definitions/GpuSettings'
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
            Instance will be created using resources from the reserved instance pool.
            Reserved instance pool resource configuration must match the resource configuration of the instance.
            The maximum string length in characters is 50.
          type: string
        application:
          description: |-
            **[Application](#yandex.cloud.compute.v1.Application)**
            Instance application settings.
          $ref: '#/definitions/Application'
      required:
        - folderId
        - zoneId
        - platformId
        - resourcesSpec
        - bootDiskSpec
        - networkInterfaceSpecs
      additionalProperties: false
    definitions:
      ResourcesSpec:
        type: object
        properties:
          memory:
            description: |-
              **string** (int64)
              Required field. The amount of memory available to the instance, specified in bytes.
              The maximum value is 274877906944.
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
              Value must match the regular expression ` |[a-z]([-_a-z0-9]{0,61}[a-z0-9])? `.
            pattern: '|[a-z]([-_a-z0-9]{0,61}[a-z0-9])?'
            type: string
          description:
            description: |-
              **string**
              Description of the disk.
              The maximum string length in characters is 256.
            type: string
          typeId:
            description: |-
              **string**
              ID of the disk type.
              To get a list of available disk types, use the [yandex.cloud.compute.v1.DiskTypeService.List](/docs/compute/api-ref/DiskType/list#List) request.
              The maximum string length in characters is 50.
            type: string
          size:
            description: |-
              **string** (int64)
              Required field. Size of the disk, specified in bytes.
              Acceptable values are 4194304 to 4398046511104, inclusive.
            type: string
            format: int64
          imageId:
            description: |-
              **string**
              ID of the image to create the disk from.
              The maximum string length in characters is 50.
              Includes only one of the fields `imageId`, `snapshotId`.
            type: string
          snapshotId:
            description: |-
              **string**
              ID of the snapshot to restore the disk from.
              The maximum string length in characters is 50.
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
              The maximum string length in characters is 50.
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
              - `READ_ONLY`: Read-only access.
              - `READ_WRITE`: Read/Write access.
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
              Value must match the regular expression ` [a-z][a-z0-9-_]{,19} `.
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
              The maximum string length in characters is 50.
              Includes only one of the fields `diskSpec`, `diskId`.
            type: string
        oneOf:
          - required:
              - diskSpec
          - required:
              - diskId
      PhysicalLocalDiskSpec:
        type: object
        properties:
          kmsKeyId:
            description: |-
              **string**
              ID of KMS key for disk encryption
            type: string
      AttachedLocalDiskSpec:
        type: object
        properties:
          size:
            description: |-
              **string** (int64)
              Required field. Size of the disk, specified in bytes.
            type: string
            format: int64
          physicalLocalDisk:
            description: |-
              **[PhysicalLocalDiskSpec](#yandex.cloud.compute.v1.PhysicalLocalDiskSpec)**
              Local disk configuration
              Includes only one of the fields `physicalLocalDisk`.
            $ref: '#/definitions/PhysicalLocalDiskSpec'
        required:
          - size
        oneOf:
          - required:
              - physicalLocalDisk
      AttachedFilesystemSpec:
        type: object
        properties:
          mode:
            description: |-
              **enum** (Mode)
              Mode of access to the filesystem that should be attached.
              - `READ_ONLY`: Read-only access.
              - `READ_WRITE`: Read/Write access.
            type: string
            enum:
              - MODE_UNSPECIFIED
              - READ_ONLY
              - READ_WRITE
          deviceName:
            description: |-
              **string**
              Name of the device representing the filesystem on the instance.
              The name should be used for referencing the filesystem from within the instance
              when it's being mounted, resized etc.
              If not specified, a random value will be generated.
              Value must match the regular expression ` [a-z][a-z0-9-_]{,19} `.
            pattern: '[a-z][a-z0-9-_]{,19}'
            type: string
          filesystemId:
            description: |-
              **string**
              ID of the filesystem that should be attached.
              The maximum string length in characters is 50.
            type: string
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
              Acceptable values are 0 to 86400, inclusive.
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
              The maximum string length in characters is 50.
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
      GpuSettings:
        type: object
        properties:
          gpuClusterId:
            description: |-
              **string**
              Attach instance to specified GPU cluster.
            type: string
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
              Required field. ID of the secret.
              The maximum string length in characters is 50.
            type: string
          key:
            description: |-
              **string**
              Required field. Name of the key.
              The maximum string length in characters is 256.
            type: string
          versionId:
            description: |-
              **string**
              Version of the secret.
              The maximum string length in characters is 50.
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
              The maximum string length in characters is 50.
            type: string
          secrets:
            description: |-
              **object** (map<**string**, **[Secret](#yandex.cloud.compute.v1.Secret)**>)
              A list of the secrets.
              No more than 100 per resource. The maximum string length in characters for each key is 100.
            type: object
            additionalProperties:
              $ref: '#/definitions/Secret'
            maxProperties: 100
          environment:
            description: |-
              **object** (map<**string**, **string**>)
              A list of the environmets.
              No more than 100 per resource. The maximum string length in characters for each key is 100. The maximum string length in characters for each value is 10000.
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
              The maximum number of elements is 50. The string length in characters for each value must be 1-50.
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
              The maximum string length in characters is 100.
            type: string
          instanceRegistrationId:
            description: |-
              **string**
              ID of the instance registration for cloud backup agent installation.
              The maximum string length in characters is 100.
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
sourcePath: en/_api-ref/compute/v1/api-ref/Instance/create.md
---

# Compute Cloud API, REST: Instance.Create

Creates an instance in the specified folder.
Method starts an asynchronous operation that can be cancelled while it is in progress.

## HTTP request

```
POST https://compute.{{ api-host }}/compute/v1/instances
```

## Body parameters {#yandex.cloud.compute.v1.CreateInstanceRequest}

```json
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "zoneId": "string",
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
  "secondaryDiskSpecs": [
    {
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
    }
  ],
  "localDiskSpecs": [
    {
      "size": "string",
      // Includes only one of the fields `physicalLocalDisk`
      "physicalLocalDisk": {
        "kmsKeyId": "string"
      }
      // end of the list of possible fields
    }
  ],
  "filesystemSpecs": [
    {
      "mode": "string",
      "deviceName": "string",
      "filesystemId": "string"
    }
  ],
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
  "hostname": "string",
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
  "gpuSettings": {
    "gpuClusterId": "string"
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
|| folderId | **string**

Required field. ID of the folder to create an instance in.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.

The maximum string length in characters is 50. ||
|| name | **string**

Name of the instance.

Value must match the regular expression ``` |[a-z]([-_a-z0-9]{0,61}[a-z0-9])? ```. ||
|| description | **string**

Description of the instance.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.

No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\@0-9a-z]* `. ||
|| zoneId | **string**

Required field. ID of the availability zone where the instance resides.
To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/Zone/list#List) request

The maximum string length in characters is 50. ||
|| platformId | **string**

Required field. ID of the hardware platform configuration for the instance.
This field affects the available values in `resourcesSpec` field.

Platforms allows you to create various types of instances: with a large amount of memory,
with a large number of cores, with a burstable performance.
For more information, see [Platforms](/docs/compute/concepts/vm-platforms). ||
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
|| metadataOptions | **[MetadataOptions](#yandex.cloud.compute.v1.MetadataOptions)**

Options allow user to configure access to instance's metadata ||
|| bootDiskSpec | **[AttachedDiskSpec](#yandex.cloud.compute.v1.AttachedDiskSpec)**

Required field. Boot disk to attach to the instance. ||
|| secondaryDiskSpecs[] | **[AttachedDiskSpec](#yandex.cloud.compute.v1.AttachedDiskSpec)**

Array of secondary disks to attach to the instance.

The maximum number of elements is 3. ||
|| localDiskSpecs[] | **[AttachedLocalDiskSpec](#yandex.cloud.compute.v1.AttachedLocalDiskSpec)**

Array of local disks to attach to the instance. ||
|| filesystemSpecs[] | **[AttachedFilesystemSpec](#yandex.cloud.compute.v1.AttachedFilesystemSpec)**

Array of filesystems to attach to the instance.

The filesystems must reside in the same availability zone as the instance.

To use the instance with an attached filesystem, the latter must be mounted.
For details, see [documentation](/docs/compute/operations/filesystem/attach-to-vm). ||
|| networkInterfaceSpecs[] | **[NetworkInterfaceSpec](#yandex.cloud.compute.v1.NetworkInterfaceSpec)**

Required field. Network configuration for the instance. Specifies how the network interface is configured
to interact with other services on the internal network and on the internet. ||
|| hostname | **string**

Host name for the instance.
This field is used to generate the [yandex.cloud.compute.v1.Instance.fqdn](#yandex.cloud.compute.v1.Instance) value.
The host name must be unique within the network and region.
If not specified, the host name will be equal to [yandex.cloud.compute.v1.Instance.id](#yandex.cloud.compute.v1.Instance) of the instance
and FQDN will be `<id>.auto.internal`. Otherwise FQDN will be `<hostname>.<region_id>.internal`.

Value must match the regular expression ``` |[a-z]([-_a-z0-9]{0,61}[a-z0-9])? ```. ||
|| schedulingPolicy | **[SchedulingPolicy](#yandex.cloud.compute.v1.SchedulingPolicy)**

Scheduling policy configuration. ||
|| serviceAccountId | **string**

ID of the service account to use for [authentication inside the instance](/docs/compute/operations/vm-connect/auth-inside-vm).
To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/ServiceAccount/list#List) request. ||
|| networkSettings | **[NetworkSettings](#yandex.cloud.compute.v1.NetworkSettings)**

Network settings. ||
|| placementPolicy | **[PlacementPolicy](#yandex.cloud.compute.v1.PlacementPolicy)**

Placement policy configuration. ||
|| gpuSettings | **[GpuSettings](#yandex.cloud.compute.v1.GpuSettings)**

GPU settings. ||
|| maintenancePolicy | **enum** (MaintenancePolicy)

Behaviour on maintenance events

- `RESTART`: Restart instance to move it to another host during maintenance
- `MIGRATE`: Use live migration to move instance to another host during maintenance ||
|| maintenanceGracePeriod | **string** (duration)

Time between notification via metadata service and maintenance ||
|| serialPortSettings | **[SerialPortSettings](#yandex.cloud.compute.v1.SerialPortSettings)**

Serial port settings ||
|| reservedInstancePoolId | **string**

ID of the reserved instance pool that the instance should belong to.
Instance will be created using resources from the reserved instance pool.
Reserved instance pool resource configuration must match the resource configuration of the instance.

The maximum string length in characters is 50. ||
|| application | **[Application](#yandex.cloud.compute.v1.Application)**

Instance application settings. ||
|#

## ResourcesSpec {#yandex.cloud.compute.v1.ResourcesSpec}

#|
||Field | Description ||
|| memory | **string** (int64)

Required field. The amount of memory available to the instance, specified in bytes.

The maximum value is 274877906944. ||
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
|#

## AttachedDiskSpec {#yandex.cloud.compute.v1.AttachedDiskSpec}

#|
||Field | Description ||
|| mode | **enum** (Mode)

The mode in which to attach this disk.

- `READ_ONLY`: Read-only access.
- `READ_WRITE`: Read/Write access. Default value. ||
|| deviceName | **string**

Specifies a unique serial number of your choice that is reflected into the /dev/disk/by-id/ tree
of a Linux operating system running within the instance.

This value can be used to reference the device for mounting, resizing, and so on, from within the instance.
If not specified, a random value will be generated.

Value must match the regular expression ` [a-z][a-z0-9-_]{,19} `. ||
|| autoDelete | **boolean**

Specifies whether the disk will be auto-deleted when the instance is deleted. ||
|| diskSpec | **[DiskSpec](#yandex.cloud.compute.v1.AttachedDiskSpec.DiskSpec)**

Disk specification.

Includes only one of the fields `diskSpec`, `diskId`. ||
|| diskId | **string**

ID of the disk that should be attached.

The maximum string length in characters is 50.

Includes only one of the fields `diskSpec`, `diskId`. ||
|#

## DiskSpec {#yandex.cloud.compute.v1.AttachedDiskSpec.DiskSpec}

#|
||Field | Description ||
|| name | **string**

Name of the disk.

Value must match the regular expression ``` |[a-z]([-_a-z0-9]{0,61}[a-z0-9])? ```. ||
|| description | **string**

Description of the disk.

The maximum string length in characters is 256. ||
|| typeId | **string**

ID of the disk type.
To get a list of available disk types, use the [yandex.cloud.compute.v1.DiskTypeService.List](/docs/compute/api-ref/DiskType/list#List) request.

The maximum string length in characters is 50. ||
|| size | **string** (int64)

Required field. Size of the disk, specified in bytes.

Acceptable values are 4194304 to 4398046511104, inclusive. ||
|| imageId | **string**

ID of the image to create the disk from.

The maximum string length in characters is 50.

Includes only one of the fields `imageId`, `snapshotId`. ||
|| snapshotId | **string**

ID of the snapshot to restore the disk from.

The maximum string length in characters is 50.

Includes only one of the fields `imageId`, `snapshotId`. ||
|| diskPlacementPolicy | **[DiskPlacementPolicy](#yandex.cloud.compute.v1.DiskPlacementPolicy)**

Placement policy configuration. ||
|| blockSize | **string** (int64)

Block size of the disk, specified in bytes. The default is 4096. ||
|| kmsKeyId | **string**

ID of KMS key for disk encryption

The maximum string length in characters is 50. ||
|#

## DiskPlacementPolicy {#yandex.cloud.compute.v1.DiskPlacementPolicy}

#|
||Field | Description ||
|| placementGroupId | **string**

Placement group ID. ||
|| placementGroupPartition | **string** (int64) ||
|#

## AttachedLocalDiskSpec {#yandex.cloud.compute.v1.AttachedLocalDiskSpec}

#|
||Field | Description ||
|| size | **string** (int64)

Required field. Size of the disk, specified in bytes. ||
|| physicalLocalDisk | **[PhysicalLocalDiskSpec](#yandex.cloud.compute.v1.PhysicalLocalDiskSpec)**

Local disk configuration

Includes only one of the fields `physicalLocalDisk`. ||
|#

## PhysicalLocalDiskSpec {#yandex.cloud.compute.v1.PhysicalLocalDiskSpec}

#|
||Field | Description ||
|| kmsKeyId | **string**

ID of KMS key for disk encryption ||
|#

## AttachedFilesystemSpec {#yandex.cloud.compute.v1.AttachedFilesystemSpec}

#|
||Field | Description ||
|| mode | **enum** (Mode)

Mode of access to the filesystem that should be attached.

- `READ_ONLY`: Read-only access.
- `READ_WRITE`: Read/Write access. Default value. ||
|| deviceName | **string**

Name of the device representing the filesystem on the instance.

The name should be used for referencing the filesystem from within the instance
when it's being mounted, resized etc.

If not specified, a random value will be generated.

Value must match the regular expression ` [a-z][a-z0-9-_]{,19} `. ||
|| filesystemId | **string**

ID of the filesystem that should be attached.

The maximum string length in characters is 50. ||
|#

## NetworkInterfaceSpec {#yandex.cloud.compute.v1.NetworkInterfaceSpec}

#|
||Field | Description ||
|| subnetId | **string**

Required field. ID of the subnet.

The maximum string length in characters is 50. ||
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

DNS record ttl, values in 0-86400 (optional)

Acceptable values are 0 to 86400, inclusive. ||
|| ptr | **boolean**

When set to true, also create PTR DNS record (optional) ||
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

- `IN`
- `NOT_IN` ||
|| values[] | **string**

Affinity value or host ID or host group ID ||
|#

## GpuSettings {#yandex.cloud.compute.v1.GpuSettings}

#|
||Field | Description ||
|| gpuClusterId | **string**

Attach instance to specified GPU cluster. ||
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

Required field. ID of the product.

The maximum string length in characters is 50. ||
|| secrets | **object** (map<**string**, **[Secret](#yandex.cloud.compute.v1.Secret)**>)

A list of the secrets.

No more than 100 per resource. The maximum string length in characters for each key is 100. ||
|| environment | **object** (map<**string**, **string**>)

A list of the environmets.

No more than 100 per resource. The maximum string length in characters for each key is 100. The maximum string length in characters for each value is 10000. ||
|#

## Secret {#yandex.cloud.compute.v1.Secret}

#|
||Field | Description ||
|| id | **string**

Required field. ID of the secret.

The maximum string length in characters is 50. ||
|| key | **string**

Required field. Name of the key.

The maximum string length in characters is 256. ||
|| versionId | **string**

Version of the secret.

The maximum string length in characters is 50. ||
|#

## BackupSpec {#yandex.cloud.compute.v1.BackupSpec}

#|
||Field | Description ||
|| enabled | **boolean**

If true, backup is enabled. ||
|| initialPolicyIds[] | **string**

A list of policy IDs to apply after resource registration.

The maximum number of elements is 50. The string length in characters for each value must be 1-50. ||
|| recoveryFromBackup | **boolean**

If true, recovery from backup starts on instance. ||
|| backupId | **string**

ID of the backup to recover from.

The maximum string length in characters is 100. ||
|| instanceRegistrationId | **string**

ID of the instance registration for cloud backup agent installation.

The maximum string length in characters is 100. ||
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
        "deviceName": "string",
        // Includes only one of the fields `physicalLocalDisk`
        "physicalLocalDisk": {
          "kmsKey": {
            "keyId": "string",
            "versionId": "string"
          }
        }
        // end of the list of possible fields
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
|| metadata | **[CreateInstanceMetadata](#yandex.cloud.compute.v1.CreateInstanceMetadata)**

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

## CreateInstanceMetadata {#yandex.cloud.compute.v1.CreateInstanceMetadata}

#|
||Field | Description ||
|| instanceId | **string**

ID of the instance that is being created.

The maximum string length in characters is 50. ||
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
|| gpuSettings | **[GpuSettings](#yandex.cloud.compute.v1.GpuSettings2)**

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
|#

## AttachedDisk {#yandex.cloud.compute.v1.AttachedDisk}

#|
||Field | Description ||
|| mode | **enum** (Mode)

Access mode to the Disk resource.

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
|| physicalLocalDisk | **[PhysicalLocalDisk](#yandex.cloud.compute.v1.PhysicalLocalDisk)**

Local disk configuration

Includes only one of the fields `physicalLocalDisk`. ||
|#

## PhysicalLocalDisk {#yandex.cloud.compute.v1.PhysicalLocalDisk}

#|
||Field | Description ||
|| kmsKey | **[KMSKey](#yandex.cloud.compute.v1.KMSKey)**

Key encryption key info. ||
|#

## KMSKey {#yandex.cloud.compute.v1.KMSKey}

#|
||Field | Description ||
|| keyId | **string**

ID of KMS symmetric key ||
|| versionId | **string**

Version of KMS symmetric key ||
|#

## AttachedFilesystem {#yandex.cloud.compute.v1.AttachedFilesystem}

#|
||Field | Description ||
|| mode | **enum** (Mode)

Access mode to the filesystem.

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

- `INSTANCE_METADATA`: Authentication and authorization using SSH keys in instance metadata
- `OS_LOGIN`: Authentication and authorization using Oslogin service ||
|#

## GpuSettings {#yandex.cloud.compute.v1.GpuSettings2}

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

Required field. ID of the product.

The maximum string length in characters is 50. ||
|| secrets | **object** (map<**string**, **[Secret](#yandex.cloud.compute.v1.Secret2)**>)

A list of the secrets.

No more than 100 per resource. The maximum string length in characters for each key is 100. ||
|| environment | **object** (map<**string**, **string**>)

A list of the environmets.

No more than 100 per resource. The maximum string length in characters for each key is 100. The maximum string length in characters for each value is 10000. ||
|#

## Secret {#yandex.cloud.compute.v1.Secret2}

#|
||Field | Description ||
|| id | **string**

Required field. ID of the secret.

The maximum string length in characters is 50. ||
|| key | **string**

Required field. Name of the key.

The maximum string length in characters is 256. ||
|| versionId | **string**

Version of the secret.

The maximum string length in characters is 50. ||
|#

## BackupSpec {#yandex.cloud.compute.v1.BackupSpec2}

#|
||Field | Description ||
|| enabled | **boolean**

If true, backup is enabled. ||
|| initialPolicyIds[] | **string**

A list of policy IDs to apply after resource registration.

The maximum number of elements is 50. The string length in characters for each value must be 1-50. ||
|| recoveryFromBackup | **boolean**

If true, recovery from backup starts on instance. ||
|| backupId | **string**

ID of the backup to recover from.

The maximum string length in characters is 100. ||
|| instanceRegistrationId | **string**

ID of the instance registration for cloud backup agent installation.

The maximum string length in characters is 100. ||
|#