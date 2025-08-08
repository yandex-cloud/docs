---
editable: false
apiPlayground:
  - url: https://compute.{{ api-host }}/compute/v1/instanceGroups
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. ID of the folder to create an instance group in.
            To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.
          type: string
        name:
          description: |-
            **string**
            Name of the instance group.
          pattern: '|[a-z]([-a-z0-9]{0,61}[a-z0-9])?'
          type: string
        description:
          description: |-
            **string**
            Description of the instance group.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Resource labels as `key:value` pairs.
          pattern: '[a-z][-_./\@0-9a-z]*'
          type: string
        instanceTemplate:
          description: |-
            **[InstanceTemplate](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.InstanceTemplate)**
            Required field. Instance template that the instance group belongs to.
          $ref: '#/definitions/InstanceTemplate'
        scalePolicy:
          description: |-
            **[ScalePolicy](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.ScalePolicy)**
            Required field. [Scaling policy](/docs/compute/concepts/instance-groups/scale) of the instance group.
          oneOf:
            - type: object
              properties:
                fixedScale:
                  description: |-
                    **[FixedScale](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.ScalePolicy.FixedScale)**
                    [Manual scaling policy](/docs/compute/concepts/instance-groups/scale#fixed-policy) of the instance group.
                    Includes only one of the fields `fixedScale`, `autoScale`.
                  $ref: '#/definitions/FixedScale'
                autoScale:
                  description: |-
                    **[AutoScale](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.ScalePolicy.AutoScale)**
                    [Automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group.
                    Includes only one of the fields `fixedScale`, `autoScale`.
                  $ref: '#/definitions/AutoScale'
        deployPolicy:
          description: |-
            **[DeployPolicy](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.DeployPolicy)**
            Required field. Deployment policy of the instance group.
          $ref: '#/definitions/DeployPolicy'
        allocationPolicy:
          description: |-
            **[AllocationPolicy](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.AllocationPolicy)**
            Required field. Allocation policy of the instance group by zones and regions.
          $ref: '#/definitions/AllocationPolicy'
        loadBalancerSpec:
          description: |-
            **[LoadBalancerSpec](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.LoadBalancerSpec)**
            Settings for balancing load between instances via [Network Load Balancer](/docs/network-load-balancer/concepts)
            (OSI model layer 3).
            If specified, a Network Load Balancer target group containing all instances from the instance group will be created
            and attributed to the instance group.
          $ref: '#/definitions/LoadBalancerSpec'
        healthChecksSpec:
          description: |-
            **[HealthChecksSpec](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.HealthChecksSpec)**
            Health checking specification. For more information, see [Health check](/docs/network-load-balancer/concepts/health-check).
          $ref: '#/definitions/HealthChecksSpec'
        serviceAccountId:
          description: |-
            **string**
            ID of the service account. The service account will be used for all API calls
            made by the Instance Groups component on behalf of the user (for example, creating instances, adding them to load balancer target group, etc.). For more information, see [Service accounts](/docs/iam/concepts/users/service-accounts).
            To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/ServiceAccount/list#List) request.
          type: string
        variables:
          description: '**[Variable](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.Variable)**'
          type: array
          items:
            $ref: '#/definitions/Variable'
        deletionProtection:
          description: |-
            **boolean**
            Flag prohibiting deletion of the instance group.
            Allowed values:</br>- `false`: The instance group can be deleted.</br>- `true`: The instance group cannot be deleted.
            The default is `false`.
          type: boolean
        applicationLoadBalancerSpec:
          description: |-
            **[ApplicationLoadBalancerSpec](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.ApplicationLoadBalancerSpec)**
            Settings for balancing load between instances via [Application Load Balancer](/docs/application-load-balancer/concepts)
            (OSI model layer 7).
            If specified, an Application Load Balancer target group containing all instances from the instance group will be created
            and attributed to the instance group.
          $ref: '#/definitions/ApplicationLoadBalancerSpec'
        autoHealingPolicy:
          description: |-
            **[AutoHealingPolicy](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.AutoHealingPolicy)**
            AutoHealingPolicy policy of the instance group.
          $ref: '#/definitions/AutoHealingPolicy'
      required:
        - folderId
        - instanceTemplate
        - scalePolicy
        - deployPolicy
        - allocationPolicy
      additionalProperties: false
    definitions:
      ResourcesSpec:
        type: object
        properties:
          memory:
            description: |-
              **string** (int64)
              The amount of memory available to the instance, specified in bytes.
            type: string
            format: int64
          cores:
            description: |-
              **string** (int64)
              The number of cores available to the instance.
            type: string
            format: int64
          coreFraction:
            description: |-
              **string** (int64)
              Baseline level of CPU performance with the ability to burst performance above that baseline level.
              This field sets baseline performance for each core.
            type: string
            format: int64
          gpus:
            description: |-
              **string** (int64)
              The number of GPUs available to the instance.
            type: string
            format: int64
      AttachedDiskSpec:
        type: object
        properties:
          mode:
            description: |-
              **enum** (Mode)
              Required field. Access mode to the Disk resource.
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
              Serial number that is reflected in the /dev/disk/by-id/ tree
              of a Linux operating system running within the instance.
              This value can be used to reference the device for mounting, resizing, and so on, from within the instance.
            pattern: '|[a-z][-_0-9a-z]{0,19}'
            type: string
          diskSpec:
            description: |-
              **[DiskSpec](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.AttachedDiskSpec.DiskSpec)**
              Required field. oneof disk_spec or disk_id
              Disk specification that is attached to the instance. For more information, see [Disks](/docs/compute/concepts/disk).
            oneOf:
              - type: object
                properties:
                  imageId:
                    description: |-
                      **string**
                      ID of the image that will be used for disk creation.
                      Includes only one of the fields `imageId`, `snapshotId`.
                    type: string
                  snapshotId:
                    description: |-
                      **string**
                      ID of the snapshot that will be used for disk creation.
                      Includes only one of the fields `imageId`, `snapshotId`.
                    type: string
          diskId:
            description: |-
              **string**
              Set to use an existing disk. To set use variables.
            pattern: '[-a-zA-Z0-9._{}]*'
            type: string
          name:
            description: |-
              **string**
              When set can be later used to change DiskSpec of actual disk.
            type: string
        required:
          - mode
          - diskSpec
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
              IP version for the public IP address.
              - `IP_VERSION_UNSPECIFIED`
              - `IPV4`: IPv4 address, for example 192.168.0.0.
              - `IPV6`: IPv6 address, not available yet.
            type: string
            enum:
              - IP_VERSION_UNSPECIFIED
              - IPV4
              - IPV6
          address:
            description: |-
              **string**
              Manual set static public IP. To set use variables. (optional)
            type: string
          dnsRecordSpecs:
            description: |-
              **[DnsRecordSpec](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.DnsRecordSpec)**
              External DNS configuration
            type: array
            items:
              $ref: '#/definitions/DnsRecordSpec'
      PrimaryAddressSpec:
        type: object
        properties:
          oneToOneNatSpec:
            description: |-
              **[OneToOneNatSpec](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.OneToOneNatSpec)**
              An external IP address configuration.
              If not specified, then this managed instance will have no external internet access.
            $ref: '#/definitions/OneToOneNatSpec'
          dnsRecordSpecs:
            description: |-
              **[DnsRecordSpec](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.DnsRecordSpec)**
              Internal DNS configuration
            type: array
            items:
              $ref: '#/definitions/DnsRecordSpec'
          address:
            description: |-
              **string**
              Optional. Manual set static internal IP. To set use variables.
            type: string
      NetworkInterfaceSpec:
        type: object
        properties:
          networkId:
            description: |-
              **string**
              ID of the network.
            type: string
          subnetIds:
            description: |-
              **string**
              IDs of the subnets.
            type: array
            items:
              type: string
          primaryV4AddressSpec:
            description: |-
              **[PrimaryAddressSpec](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.PrimaryAddressSpec)**
              Primary IPv4 address that is assigned to the instance for this network interface.
            $ref: '#/definitions/PrimaryAddressSpec'
          primaryV6AddressSpec:
            description: |-
              **[PrimaryAddressSpec](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.PrimaryAddressSpec)**
              Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet.
            $ref: '#/definitions/PrimaryAddressSpec'
          securityGroupIds:
            description: |-
              **string**
              IDs of security groups.
            type: array
            items:
              type: string
      SchedulingPolicy:
        type: object
        properties:
          preemptible:
            description: |-
              **boolean**
              Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time
              if their resources are needed by Compute.
              For more information, see [Preemptible Virtual Machines](/docs/compute/concepts/preemptible-vm).
            type: boolean
      NetworkSettings:
        type: object
        properties:
          type:
            description: |-
              **enum** (Type)
              Type of instance network.
              - `TYPE_UNSPECIFIED`
              - `STANDARD`
              - `SOFTWARE_ACCELERATED`
              - `HARDWARE_ACCELERATED`
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
              Identifier of placement group
            type: string
          hostAffinityRules:
            description: |-
              **[HostAffinityRule](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.PlacementPolicy.HostAffinityRule)**
              List of affinity rules. Scheduler will attempt to allocate instances according to order of rules.
            type: array
            items:
              $ref: '#/definitions/HostAffinityRule'
      AttachedFilesystemSpec:
        type: object
        properties:
          mode:
            description: |-
              **enum** (Mode)
              Mode of access to the filesystem that should be attached.
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
              Name of the device representing the filesystem on the instance.
              The name should be used for referencing the filesystem from within the instance
              when it's being mounted, resized etc.
              If not specified, a random value will be generated.
            pattern: '|[a-z][-_0-9a-z]{0,19}'
            type: string
          filesystemId:
            description: |-
              **string**
              ID of the filesystem that should be attached.
            pattern: '[-a-zA-Z0-9._{}]*'
            type: string
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
      InstanceTemplate:
        type: object
        properties:
          description:
            description: |-
              **string**
              Description of the instance template.
            type: string
          labels:
            description: |-
              **object** (map<**string**, **string**>)
              Resource labels as `key:value` pairs.
            pattern: '[a-z][-_./\@0-9a-z]*'
            type: string
          platformId:
            description: |-
              **string**
              Required field. ID of the hardware platform configuration for the instance.
              Platforms allows you to create various types of instances: with a large amount of memory,
              with a large number of cores, with a burstable performance.
              For more information, see [Platforms](/docs/compute/concepts/vm-platforms).
            type: string
          resourcesSpec:
            description: |-
              **[ResourcesSpec](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.ResourcesSpec)**
              Required field. Computing resources of the instance such as the amount of memory and number of cores.
            $ref: '#/definitions/ResourcesSpec'
          metadata:
            description: |-
              **object** (map<**string**, **string**>)
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
              For more information, see [Metadata](/docs/compute/concepts/vm-metadata).
            pattern: '[a-z][-_0-9a-z]*'
            type: string
          bootDiskSpec:
            description: |-
              **[AttachedDiskSpec](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.AttachedDiskSpec)**
              Required field. Boot disk specification that will be attached to the instance.
            $ref: '#/definitions/AttachedDiskSpec'
          secondaryDiskSpecs:
            description: |-
              **[AttachedDiskSpec](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.AttachedDiskSpec)**
              Array of secondary disks that will be attached to the instance.
            type: array
            items:
              $ref: '#/definitions/AttachedDiskSpec'
          networkInterfaceSpecs:
            description: |-
              **[NetworkInterfaceSpec](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.NetworkInterfaceSpec)**
              Required field. Array of network interfaces that will be attached to the instance.
            type: array
            items:
              $ref: '#/definitions/NetworkInterfaceSpec'
          schedulingPolicy:
            description: |-
              **[SchedulingPolicy](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.SchedulingPolicy)**
              Scheduling policy for the instance.
            $ref: '#/definitions/SchedulingPolicy'
          serviceAccountId:
            description: |-
              **string**
              Service account ID for the instance.
            type: string
          networkSettings:
            description: |-
              **[NetworkSettings](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.NetworkSettings)**
              Network settings for the instance.
            $ref: '#/definitions/NetworkSettings'
          name:
            description: |-
              **string**
              Name of the instance.
              In order to be unique it must contain at least on of instance unique placeholders:
              {instance.short_id}
              {instance.index}
              combination of {instance.zone_id} and {instance.index_in_zone}
              Example: my-instance-{instance.index}
              If not set, default is used: {instance_group.id}-{instance.short_id}
              It may also contain another placeholders, see metadata doc for full list.
            type: string
          hostname:
            description: |-
              **string**
              Host name for the instance.
              This field is used to generate the [yandex.cloud.compute.v1.Instance.fqdn](/docs/compute/api-ref/GpuCluster/listInstances#yandex.cloud.compute.v1.Instance) value.
              The host name must be unique within the network and region.
              If not specified, the host name will be equal to [yandex.cloud.compute.v1.Instance.id](/docs/compute/api-ref/GpuCluster/listInstances#yandex.cloud.compute.v1.Instance) of the instance
              and FQDN will be `<id>.auto.internal`. Otherwise FQDN will be `<hostname>.<region_id>.internal`.
              In order to be unique it must contain at least on of instance unique placeholders:
              {instance.short_id}
              {instance.index}
              combination of {instance.zone_id} and {instance.index_in_zone}
              Example: my-instance-{instance.index}
              If not set, `name` value will be used
              It may also contain another placeholders, see metadata doc for full list.
            type: string
          placementPolicy:
            description: |-
              **[PlacementPolicy](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.PlacementPolicy)**
              Placement Group
            $ref: '#/definitions/PlacementPolicy'
          filesystemSpecs:
            description: |-
              **[AttachedFilesystemSpec](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.AttachedFilesystemSpec)**
              Array of filesystems to attach to the instance.
              The filesystems must reside in the same availability zone as the instance.
              To use the instance with an attached filesystem, the latter must be mounted.
              For details, see [documentation](/docs/compute/operations/filesystem/attach-to-vm).
            type: array
            items:
              $ref: '#/definitions/AttachedFilesystemSpec'
          metadataOptions:
            description: |-
              **[MetadataOptions](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.MetadataOptions)**
              Metadata options for the instance
            $ref: '#/definitions/MetadataOptions'
        required:
          - platformId
          - resourcesSpec
          - bootDiskSpec
          - networkInterfaceSpecs
      FixedScale:
        type: object
        properties:
          size:
            description: |-
              **string** (int64)
              Number of instances in the instance group.
            type: string
            format: int64
      CpuUtilizationRule:
        type: object
        properties:
          utilizationTarget:
            description: |-
              **string**
              Target CPU utilization level. Instance Groups maintains this level for each availability zone.
            type: string
      CustomRule:
        type: object
        properties:
          ruleType:
            description: |-
              **enum** (RuleType)
              Required field. Custom metric rule type. This field affects which label from
              the custom metric should be used: `zone_id` or `instance_id`.
              - `RULE_TYPE_UNSPECIFIED`
              - `UTILIZATION`: This type means that the metric applies to one instance.
              First, Instance Groups calculates the average metric value for each instance,
              then averages the values for instances in one availability zone or in whole group depends on autoscaling type.
              This type of metric must have the `instance_id` label.
              - `WORKLOAD`: This type means that the metric applies to instances in one availability zone or to whole group depends on autoscaling type.
              This type of metric must have the `zone_id` label if ZONAL autoscaling type is chosen.
            type: string
            enum:
              - RULE_TYPE_UNSPECIFIED
              - UTILIZATION
              - WORKLOAD
          metricType:
            description: |-
              **enum** (MetricType)
              Required field. Type of custom metric. This field affects how Instance Groups calculates the average metric value.
              - `METRIC_TYPE_UNSPECIFIED`
              - `GAUGE`: This type is used for metrics that show the metric value at a certain point in time,
              such as requests per second to the server on an instance.
                Instance Groups calculates the average metric value for the period
              specified in the [AutoScale.measurementDuration](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.ScalePolicy.AutoScale) field.
              - `COUNTER`: This type is used for metrics that monotonically increase over time,
              such as the total number of requests to the server on an instance.
                Instance Groups calculates the average value increase for the period
              specified in the [AutoScale.measurementDuration](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.ScalePolicy.AutoScale) field.
            type: string
            enum:
              - METRIC_TYPE_UNSPECIFIED
              - GAUGE
              - COUNTER
          metricName:
            description: |-
              **string**
              Required field. Name of custom metric in Monitoring that should be used for scaling.
            pattern: '[a-zA-Z0-9./@_][ 0-9a-zA-Z./@_,:;()\[\]<>-]{0,198}'
            type: string
          labels:
            description: |-
              **object** (map<**string**, **string**>)
              Labels of custom metric in Monitoring that should be used for scaling.
            pattern: ^[a-zA-Z][0-9a-zA-Z_]{0,31}$
            type: string
          target:
            description: |-
              **string**
              Target value for the custom metric. Instance Groups maintains this level for each availability zone.
            type: string
          folderId:
            description: |-
              **string**
              Folder id of custom metric in Monitoring that should be used for scaling.
            type: string
          service:
            description: |-
              **string**
              Service of custom metric in Monitoring that should be used for scaling.
            type: string
        required:
          - ruleType
          - metricType
          - metricName
      AutoScale:
        type: object
        properties:
          minZoneSize:
            description: |-
              **string** (int64)
              Lower limit for instance count in each zone.
            type: string
            format: int64
          maxSize:
            description: |-
              **string** (int64)
              Upper limit for total instance count (across all zones).
              0 means maximum limit = 100.
            type: string
            format: int64
          measurementDuration:
            description: |-
              **string** (duration)
              Time in seconds allotted for averaging metrics.
              1 minute by default.
            type: string
            format: duration
          warmupDuration:
            description: |-
              **string** (duration)
              The warmup time of the instance in seconds. During this time,
              traffic is sent to the instance, but instance metrics are not collected.
            type: string
            format: duration
          stabilizationDuration:
            description: |-
              **string** (duration)
              Minimum amount of time in seconds allotted for monitoring before
              Instance Groups can reduce the number of instances in the group.
              During this time, the group size doesn't decrease, even if the new metric values
              indicate that it should.
            type: string
            format: duration
          initialSize:
            description: |-
              **string** (int64)
              Target group size.
            type: string
            format: int64
          cpuUtilizationRule:
            description: |-
              **[CpuUtilizationRule](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.ScalePolicy.CpuUtilizationRule)**
              Defines an autoscaling rule based on the average CPU utilization of the instance group.
              If more than one rule is specified, e.g. CPU utilization and one or more Monitoring metrics ([customRules](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.ScalePolicy.AutoScale)),
              the size of the instance group will be equal to the maximum of sizes calculated according to each metric.
            $ref: '#/definitions/CpuUtilizationRule'
          customRules:
            description: |-
              **[CustomRule](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.ScalePolicy.CustomRule)**
              Defines an autoscaling rule based on a [custom metric](/docs/monitoring/operations/metric/add) from Monitoring.
              If more than one rule is specified, e.g. CPU utilization ([cpuUtilizationRule](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.ScalePolicy.AutoScale)) and one or more Monitoring
              metrics, the size of the instance group will be equal to the maximum of sizes calculated according to each metric.
            type: array
            items:
              $ref: '#/definitions/CustomRule'
          autoScaleType:
            description: |-
              **enum** (AutoScaleType)
              Autoscaling type.
              - `AUTO_SCALE_TYPE_UNSPECIFIED`
              - `ZONAL`: Scale each zone independently. This is the default.
              - `REGIONAL`: Scale group as a whole.
            type: string
            enum:
              - AUTO_SCALE_TYPE_UNSPECIFIED
              - ZONAL
              - REGIONAL
      DeployPolicy:
        type: object
        properties:
          maxUnavailable:
            description: |-
              **string** (int64)
              The maximum number of running instances that can be taken offline (i.e., stopped or deleted) at the same time
              during the update process.
              If [maxExpansion](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.DeployPolicy) is not specified or set to zero, [maxUnavailable](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.DeployPolicy) must be set to a non-zero value.
            type: string
            format: int64
          maxDeleting:
            description: |-
              **string** (int64)
              The maximum number of instances that can be deleted at the same time.
              The value 0 is any number of virtual machines within the allowed values.
            type: string
            format: int64
          maxCreating:
            description: |-
              **string** (int64)
              The maximum number of instances that can be created at the same time.
              The value 0 is any number of virtual machines within the allowed values.
            type: string
            format: int64
          maxExpansion:
            description: |-
              **string** (int64)
              The maximum number of instances that can be temporarily allocated above the group's target size
              during the update process.
              If [maxUnavailable](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.DeployPolicy) is not specified or set to zero, [maxExpansion](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.DeployPolicy) must be set to a non-zero value.
            type: string
            format: int64
          startupDuration:
            description: |-
              **string** (duration)
              Instance startup duration.
              Instance will be considered up and running (and start receiving traffic) only after startup_duration
              has elapsed and all health checks are passed.
              See [ManagedInstance.Status](/docs/compute/instancegroup/api-ref/InstanceGroup/listInstances#yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status) for more information.
            type: string
            format: duration
          strategy:
            description: |-
              **enum** (Strategy)
              Affects the lifecycle of the instance during deployment.
              - `STRATEGY_UNSPECIFIED`
              - `PROACTIVE`: Instance Groups can forcefully stop a running instance. This is the default.
              - `OPPORTUNISTIC`: Instance Groups does not stop a running instance.
              Instead, it will wait until the instance stops itself or becomes unhealthy.
            type: string
            enum:
              - STRATEGY_UNSPECIFIED
              - PROACTIVE
              - OPPORTUNISTIC
          minimalAction:
            description: |-
              **enum** (MinimalAction)
              If instance update requires a less disruptive action than [minimalAction](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.DeployPolicy),
              Instance Groups performs [minimalAction](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.DeployPolicy) to execute the update
              - `MINIMAL_ACTION_UNSPECIFIED`
              - `LIVE_UPDATE`: Updating an instance without stopping. This is the default.
              - `RESTART`: Updating an instance with restart: stopping and then starting the instance.
              - `RECREATE`: Re-creating an instance: deleting an instance and creating a new one.
            type: string
            enum:
              - MINIMAL_ACTION_UNSPECIFIED
              - LIVE_UPDATE
              - RESTART
              - RECREATE
      Zone:
        type: object
        properties:
          zoneId:
            description: |-
              **string**
              Required field. ID of the availability zone where the instance resides.
            type: string
          instanceTagsPool:
            description: |-
              **string**
              Each instance in a zone will be associated with exactly one of a tag from a pool below.
              All specified tags must be unique across the whole group not only the zone.
              It is guaranteed that during whole deploy only tags from prefix of the specified list will be used.
              It is possible to use tag associated with instance in templating via {instance.tag}.
            uniqueItems: true
            type: array
            items:
              type: string
        required:
          - zoneId
      AllocationPolicy:
        type: object
        properties:
          zones:
            description: |-
              **[Zone](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.AllocationPolicy.Zone)**
              List of availability zones.
            type: array
            items:
              $ref: '#/definitions/Zone'
      TargetGroupSpec:
        type: object
        properties:
          name:
            description: |-
              **string**
              Name of the target group.
            pattern: '|[a-z]([-a-z0-9]{0,61}[a-z0-9])?'
            type: string
          description:
            description: |-
              **string**
              Description of the target group.
            type: string
          labels:
            description: |-
              **object** (map<**string**, **string**>)
              Resource labels as `key:value` pairs.
            pattern: '[a-z][-_./\@0-9a-z]*'
            type: string
      LoadBalancerSpec:
        type: object
        properties:
          targetGroupSpec:
            description: |-
              **[TargetGroupSpec](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.TargetGroupSpec)**
              Specification of the target group that the instance group will be added to. For more information, see [Target groups and resources](/docs/network-load-balancer/concepts/target-resources).
            $ref: '#/definitions/TargetGroupSpec'
          maxOpeningTrafficDuration:
            description: |-
              **string** (duration)
              Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded,
              the VM will be turned off based on the deployment policy. Specified in seconds.
            type: string
            format: duration
          ignoreHealthChecks:
            description: |-
              **boolean**
              Do not wait load balancer health checks.
            type: boolean
      TcpOptions:
        type: object
        properties:
          port:
            description: |-
              **string** (int64)
              Port to use for TCP health checks.
            type: string
            format: int64
      HttpOptions:
        type: object
        properties:
          port:
            description: |-
              **string** (int64)
              Port to use for HTTP health checks.
            type: string
            format: int64
          path:
            description: |-
              **string**
              URL path to set for health checking requests.
            type: string
      HealthChecksSpec:
        type: object
        properties:
          healthCheckSpecs:
            description: |-
              **[HealthCheckSpec](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.HealthCheckSpec)**
              Health checking specification. For more information, see [Health check](/docs/network-load-balancer/concepts/health-check).
            type: array
            items:
              oneOf:
                - type: object
                  properties:
                    tcpOptions:
                      description: |-
                        **[TcpOptions](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.HealthCheckSpec.TcpOptions)**
                        Configuration options for a TCP health check.
                        Includes only one of the fields `tcpOptions`, `httpOptions`.
                      $ref: '#/definitions/TcpOptions'
                    httpOptions:
                      description: |-
                        **[HttpOptions](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.HealthCheckSpec.HttpOptions)**
                        Configuration options for an HTTP health check.
                        Includes only one of the fields `tcpOptions`, `httpOptions`.
                      $ref: '#/definitions/HttpOptions'
          maxCheckingHealthDuration:
            description: |-
              **string** (duration)
              Timeout for waiting for the VM to become healthy. If the timeout is exceeded,
              the VM will be turned off based on the deployment policy. Specified in seconds.
            type: string
            format: duration
      Variable:
        type: object
        properties:
          key:
            description: '**string**'
            pattern: '[a-zA-Z0-9._-]*'
            type: string
          value:
            description: '**string**'
            type: string
      ApplicationTargetGroupSpec:
        type: object
        properties:
          name:
            description: |-
              **string**
              Name of the target group.
            type: string
          description:
            description: |-
              **string**
              Description of the target group.
            type: string
          labels:
            description: |-
              **object** (map<**string**, **string**>)
              Resource labels as `key:value` pairs.
            type: string
      ApplicationLoadBalancerSpec:
        type: object
        properties:
          targetGroupSpec:
            description: |-
              **[ApplicationTargetGroupSpec](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.ApplicationTargetGroupSpec)**
              Required field. Basic properties of the Application Load Balancer target group attributed to the instance group.
            $ref: '#/definitions/ApplicationTargetGroupSpec'
          maxOpeningTrafficDuration:
            description: |-
              **string** (duration)
              Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded,
              the VM will be turned off based on the deployment policy. Specified in seconds.
            type: string
            format: duration
          ignoreHealthChecks:
            description: |-
              **boolean**
              Do not wait load balancer health checks.
            type: boolean
        required:
          - targetGroupSpec
      AutoHealingPolicy:
        type: object
        properties:
          autoHealingAction:
            description: |-
              **enum** (AutoHealingAction)
              Instance Groups performs [autoHealingAction](/docs/compute/instancegroup/api-ref/InstanceGroup/get#yandex.cloud.compute.v1.instancegroup.AutoHealingPolicy) when instance becomes unhealthy.
              - `AUTO_HEALING_ACTION_UNSPECIFIED`
              - `RESTART`: Re-starting an instance with restart: stopping and then starting the instance.
              - `RECREATE`: Re-creating an instance: deleting an instance and creating a new one.
              - `NONE`: No action
            type: string
            enum:
              - AUTO_HEALING_ACTION_UNSPECIFIED
              - RESTART
              - RECREATE
              - NONE
sourcePath: en/_api-ref/compute/v1/instancegroup/api-ref/InstanceGroup/create.md
---

# Compute Cloud Instance Groups API, REST: InstanceGroup.Create

Creates an instance group in the specified folder.
This method starts an operation that can be cancelled by another operation.

## HTTP request

```
POST https://compute.{{ api-host }}/compute/v1/instanceGroups
```

## Body parameters {#yandex.cloud.compute.v1.instancegroup.CreateInstanceGroupRequest}

```json
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "instanceTemplate": {
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
    "bootDiskSpec": {
      "mode": "string",
      "deviceName": "string",
      "diskSpec": {
        "description": "string",
        "typeId": "string",
        "size": "string",
        // Includes only one of the fields `imageId`, `snapshotId`
        "imageId": "string",
        "snapshotId": "string",
        // end of the list of possible fields
        "preserveAfterInstanceDelete": "boolean"
      },
      "diskId": "string",
      "name": "string"
    },
    "secondaryDiskSpecs": [
      {
        "mode": "string",
        "deviceName": "string",
        "diskSpec": {
          "description": "string",
          "typeId": "string",
          "size": "string",
          // Includes only one of the fields `imageId`, `snapshotId`
          "imageId": "string",
          "snapshotId": "string",
          // end of the list of possible fields
          "preserveAfterInstanceDelete": "boolean"
        },
        "diskId": "string",
        "name": "string"
      }
    ],
    "networkInterfaceSpecs": [
      {
        "networkId": "string",
        "subnetIds": [
          "string"
        ],
        "primaryV4AddressSpec": {
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
          ],
          "address": "string"
        },
        "primaryV6AddressSpec": {
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
          ],
          "address": "string"
        },
        "securityGroupIds": [
          "string"
        ]
      }
    ],
    "schedulingPolicy": {
      "preemptible": "boolean"
    },
    "serviceAccountId": "string",
    "networkSettings": {
      "type": "string"
    },
    "name": "string",
    "hostname": "string",
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
      ]
    },
    "filesystemSpecs": [
      {
        "mode": "string",
        "deviceName": "string",
        "filesystemId": "string"
      }
    ],
    "metadataOptions": {
      "gceHttpEndpoint": "string",
      "awsV1HttpEndpoint": "string",
      "gceHttpToken": "string",
      "awsV1HttpToken": "string"
    }
  },
  "scalePolicy": {
    // Includes only one of the fields `fixedScale`, `autoScale`
    "fixedScale": {
      "size": "string"
    },
    "autoScale": {
      "minZoneSize": "string",
      "maxSize": "string",
      "measurementDuration": "string",
      "warmupDuration": "string",
      "stabilizationDuration": "string",
      "initialSize": "string",
      "cpuUtilizationRule": {
        "utilizationTarget": "string"
      },
      "customRules": [
        {
          "ruleType": "string",
          "metricType": "string",
          "metricName": "string",
          "labels": "object",
          "target": "string",
          "folderId": "string",
          "service": "string"
        }
      ],
      "autoScaleType": "string"
    },
    // end of the list of possible fields
    "testAutoScale": {
      "minZoneSize": "string",
      "maxSize": "string",
      "measurementDuration": "string",
      "warmupDuration": "string",
      "stabilizationDuration": "string",
      "initialSize": "string",
      "cpuUtilizationRule": {
        "utilizationTarget": "string"
      },
      "customRules": [
        {
          "ruleType": "string",
          "metricType": "string",
          "metricName": "string",
          "labels": "object",
          "target": "string",
          "folderId": "string",
          "service": "string"
        }
      ],
      "autoScaleType": "string"
    }
  },
  "deployPolicy": {
    "maxUnavailable": "string",
    "maxDeleting": "string",
    "maxCreating": "string",
    "maxExpansion": "string",
    "startupDuration": "string",
    "strategy": "string",
    "minimalAction": "string"
  },
  "allocationPolicy": {
    "zones": [
      {
        "zoneId": "string",
        "instanceTagsPool": [
          "string"
        ]
      }
    ]
  },
  "loadBalancerSpec": {
    "targetGroupSpec": {
      "name": "string",
      "description": "string",
      "labels": "object"
    },
    "maxOpeningTrafficDuration": "string",
    "ignoreHealthChecks": "boolean"
  },
  "healthChecksSpec": {
    "healthCheckSpecs": [
      {
        "interval": "string",
        "timeout": "string",
        "unhealthyThreshold": "string",
        "healthyThreshold": "string",
        // Includes only one of the fields `tcpOptions`, `httpOptions`
        "tcpOptions": {
          "port": "string"
        },
        "httpOptions": {
          "port": "string",
          "path": "string"
        }
        // end of the list of possible fields
      }
    ],
    "maxCheckingHealthDuration": "string"
  },
  "serviceAccountId": "string",
  "variables": [
    {
      "key": "string",
      "value": "string"
    }
  ],
  "deletionProtection": "boolean",
  "applicationLoadBalancerSpec": {
    "targetGroupSpec": {
      "name": "string",
      "description": "string",
      "labels": "object"
    },
    "maxOpeningTrafficDuration": "string",
    "ignoreHealthChecks": "boolean"
  },
  "autoHealingPolicy": {
    "autoHealingAction": "string"
  }
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to create an instance group in.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| name | **string**

Name of the instance group. ||
|| description | **string**

Description of the instance group. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|| instanceTemplate | **[InstanceTemplate](#yandex.cloud.compute.v1.instancegroup.InstanceTemplate)**

Required field. Instance template that the instance group belongs to. ||
|| scalePolicy | **[ScalePolicy](#yandex.cloud.compute.v1.instancegroup.ScalePolicy)**

Required field. [Scaling policy](/docs/compute/concepts/instance-groups/scale) of the instance group. ||
|| deployPolicy | **[DeployPolicy](#yandex.cloud.compute.v1.instancegroup.DeployPolicy)**

Required field. Deployment policy of the instance group. ||
|| allocationPolicy | **[AllocationPolicy](#yandex.cloud.compute.v1.instancegroup.AllocationPolicy)**

Required field. Allocation policy of the instance group by zones and regions. ||
|| loadBalancerSpec | **[LoadBalancerSpec](#yandex.cloud.compute.v1.instancegroup.LoadBalancerSpec)**

Settings for balancing load between instances via [Network Load Balancer](/docs/network-load-balancer/concepts)
(OSI model layer 3).

If specified, a Network Load Balancer target group containing all instances from the instance group will be created
and attributed to the instance group. ||
|| healthChecksSpec | **[HealthChecksSpec](#yandex.cloud.compute.v1.instancegroup.HealthChecksSpec)**

Health checking specification. For more information, see [Health check](/docs/network-load-balancer/concepts/health-check). ||
|| serviceAccountId | **string**

ID of the service account. The service account will be used for all API calls
made by the Instance Groups component on behalf of the user (for example, creating instances, adding them to load balancer target group, etc.). For more information, see [Service accounts](/docs/iam/concepts/users/service-accounts).
To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/ServiceAccount/list#List) request. ||
|| variables[] | **[Variable](#yandex.cloud.compute.v1.instancegroup.Variable)** ||
|| deletionProtection | **boolean**

Flag prohibiting deletion of the instance group.

Allowed values:</br>- `false`: The instance group can be deleted.</br>- `true`: The instance group cannot be deleted.

The default is `false`. ||
|| applicationLoadBalancerSpec | **[ApplicationLoadBalancerSpec](#yandex.cloud.compute.v1.instancegroup.ApplicationLoadBalancerSpec)**

Settings for balancing load between instances via [Application Load Balancer](/docs/application-load-balancer/concepts)
(OSI model layer 7).

If specified, an Application Load Balancer target group containing all instances from the instance group will be created
and attributed to the instance group. ||
|| autoHealingPolicy | **[AutoHealingPolicy](#yandex.cloud.compute.v1.instancegroup.AutoHealingPolicy)**

AutoHealingPolicy policy of the instance group. ||
|#

## InstanceTemplate {#yandex.cloud.compute.v1.instancegroup.InstanceTemplate}

#|
||Field | Description ||
|| description | **string**

Description of the instance template. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|| platformId | **string**

Required field. ID of the hardware platform configuration for the instance.
Platforms allows you to create various types of instances: with a large amount of memory,
with a large number of cores, with a burstable performance.
For more information, see [Platforms](/docs/compute/concepts/vm-platforms). ||
|| resourcesSpec | **[ResourcesSpec](#yandex.cloud.compute.v1.instancegroup.ResourcesSpec)**

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
|| bootDiskSpec | **[AttachedDiskSpec](#yandex.cloud.compute.v1.instancegroup.AttachedDiskSpec)**

Required field. Boot disk specification that will be attached to the instance. ||
|| secondaryDiskSpecs[] | **[AttachedDiskSpec](#yandex.cloud.compute.v1.instancegroup.AttachedDiskSpec)**

Array of secondary disks that will be attached to the instance. ||
|| networkInterfaceSpecs[] | **[NetworkInterfaceSpec](#yandex.cloud.compute.v1.instancegroup.NetworkInterfaceSpec)**

Required field. Array of network interfaces that will be attached to the instance. ||
|| schedulingPolicy | **[SchedulingPolicy](#yandex.cloud.compute.v1.instancegroup.SchedulingPolicy)**

Scheduling policy for the instance. ||
|| serviceAccountId | **string**

Service account ID for the instance. ||
|| networkSettings | **[NetworkSettings](#yandex.cloud.compute.v1.instancegroup.NetworkSettings)**

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
This field is used to generate the [yandex.cloud.compute.v1.Instance.fqdn](/docs/compute/api-ref/GpuCluster/listInstances#yandex.cloud.compute.v1.Instance) value.
The host name must be unique within the network and region.
If not specified, the host name will be equal to [yandex.cloud.compute.v1.Instance.id](/docs/compute/api-ref/GpuCluster/listInstances#yandex.cloud.compute.v1.Instance) of the instance
and FQDN will be `<id>.auto.internal`. Otherwise FQDN will be `<hostname>.<region_id>.internal`.

In order to be unique it must contain at least on of instance unique placeholders:
{instance.short_id}
{instance.index}
combination of {instance.zone_id} and {instance.index_in_zone}
Example: my-instance-{instance.index}
If not set, `name` value will be used
It may also contain another placeholders, see metadata doc for full list. ||
|| placementPolicy | **[PlacementPolicy](#yandex.cloud.compute.v1.instancegroup.PlacementPolicy)**

Placement Group ||
|| filesystemSpecs[] | **[AttachedFilesystemSpec](#yandex.cloud.compute.v1.instancegroup.AttachedFilesystemSpec)**

Array of filesystems to attach to the instance.

The filesystems must reside in the same availability zone as the instance.

To use the instance with an attached filesystem, the latter must be mounted.
For details, see [documentation](/docs/compute/operations/filesystem/attach-to-vm). ||
|| metadataOptions | **[MetadataOptions](#yandex.cloud.compute.v1.instancegroup.MetadataOptions)**

Metadata options for the instance ||
|#

## ResourcesSpec {#yandex.cloud.compute.v1.instancegroup.ResourcesSpec}

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

## AttachedDiskSpec {#yandex.cloud.compute.v1.instancegroup.AttachedDiskSpec}

#|
||Field | Description ||
|| mode | **enum** (Mode)

Required field. Access mode to the Disk resource.

- `MODE_UNSPECIFIED`
- `READ_ONLY`: Read-only access.
- `READ_WRITE`: Read/Write access. ||
|| deviceName | **string**

Serial number that is reflected in the /dev/disk/by-id/ tree
of a Linux operating system running within the instance.

This value can be used to reference the device for mounting, resizing, and so on, from within the instance. ||
|| diskSpec | **[DiskSpec](#yandex.cloud.compute.v1.instancegroup.AttachedDiskSpec.DiskSpec)**

Required field. oneof disk_spec or disk_id
Disk specification that is attached to the instance. For more information, see [Disks](/docs/compute/concepts/disk). ||
|| diskId | **string**

Set to use an existing disk. To set use variables. ||
|| name | **string**

When set can be later used to change DiskSpec of actual disk. ||
|#

## DiskSpec {#yandex.cloud.compute.v1.instancegroup.AttachedDiskSpec.DiskSpec}

#|
||Field | Description ||
|| description | **string**

Description of the disk. ||
|| typeId | **string**

Required field. ID of the disk type. ||
|| size | **string** (int64)

Size of the disk, specified in bytes. ||
|| imageId | **string**

ID of the image that will be used for disk creation.

Includes only one of the fields `imageId`, `snapshotId`. ||
|| snapshotId | **string**

ID of the snapshot that will be used for disk creation.

Includes only one of the fields `imageId`, `snapshotId`. ||
|| preserveAfterInstanceDelete | **boolean**

When set to true, disk will not be deleted even after managed instance is deleted.
It will be a user's responsibility to delete such disks. ||
|#

## NetworkInterfaceSpec {#yandex.cloud.compute.v1.instancegroup.NetworkInterfaceSpec}

#|
||Field | Description ||
|| networkId | **string**

ID of the network. ||
|| subnetIds[] | **string**

IDs of the subnets. ||
|| primaryV4AddressSpec | **[PrimaryAddressSpec](#yandex.cloud.compute.v1.instancegroup.PrimaryAddressSpec)**

Primary IPv4 address that is assigned to the instance for this network interface. ||
|| primaryV6AddressSpec | **[PrimaryAddressSpec](#yandex.cloud.compute.v1.instancegroup.PrimaryAddressSpec)**

Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet. ||
|| securityGroupIds[] | **string**

IDs of security groups. ||
|#

## PrimaryAddressSpec {#yandex.cloud.compute.v1.instancegroup.PrimaryAddressSpec}

#|
||Field | Description ||
|| oneToOneNatSpec | **[OneToOneNatSpec](#yandex.cloud.compute.v1.instancegroup.OneToOneNatSpec)**

An external IP address configuration.
If not specified, then this managed instance will have no external internet access. ||
|| dnsRecordSpecs[] | **[DnsRecordSpec](#yandex.cloud.compute.v1.instancegroup.DnsRecordSpec)**

Internal DNS configuration ||
|| address | **string**

Optional. Manual set static internal IP. To set use variables. ||
|#

## OneToOneNatSpec {#yandex.cloud.compute.v1.instancegroup.OneToOneNatSpec}

#|
||Field | Description ||
|| ipVersion | **enum** (IpVersion)

IP version for the public IP address.

- `IP_VERSION_UNSPECIFIED`
- `IPV4`: IPv4 address, for example 192.168.0.0.
- `IPV6`: IPv6 address, not available yet. ||
|| address | **string**

Manual set static public IP. To set use variables. (optional) ||
|| dnsRecordSpecs[] | **[DnsRecordSpec](#yandex.cloud.compute.v1.instancegroup.DnsRecordSpec)**

External DNS configuration ||
|#

## DnsRecordSpec {#yandex.cloud.compute.v1.instancegroup.DnsRecordSpec}

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

## SchedulingPolicy {#yandex.cloud.compute.v1.instancegroup.SchedulingPolicy}

#|
||Field | Description ||
|| preemptible | **boolean**

Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time
if their resources are needed by Compute.
For more information, see [Preemptible Virtual Machines](/docs/compute/concepts/preemptible-vm). ||
|#

## NetworkSettings {#yandex.cloud.compute.v1.instancegroup.NetworkSettings}

#|
||Field | Description ||
|| type | **enum** (Type)

Type of instance network.

- `TYPE_UNSPECIFIED`
- `STANDARD`
- `SOFTWARE_ACCELERATED`
- `HARDWARE_ACCELERATED` ||
|#

## PlacementPolicy {#yandex.cloud.compute.v1.instancegroup.PlacementPolicy}

#|
||Field | Description ||
|| placementGroupId | **string**

Identifier of placement group ||
|| hostAffinityRules[] | **[HostAffinityRule](#yandex.cloud.compute.v1.instancegroup.PlacementPolicy.HostAffinityRule)**

List of affinity rules. Scheduler will attempt to allocate instances according to order of rules. ||
|#

## HostAffinityRule {#yandex.cloud.compute.v1.instancegroup.PlacementPolicy.HostAffinityRule}

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

## AttachedFilesystemSpec {#yandex.cloud.compute.v1.instancegroup.AttachedFilesystemSpec}

#|
||Field | Description ||
|| mode | **enum** (Mode)

Mode of access to the filesystem that should be attached.

- `MODE_UNSPECIFIED`
- `READ_ONLY`: Read-only access.
- `READ_WRITE`: Read/Write access. Default value. ||
|| deviceName | **string**

Name of the device representing the filesystem on the instance.

The name should be used for referencing the filesystem from within the instance
when it's being mounted, resized etc.

If not specified, a random value will be generated. ||
|| filesystemId | **string**

ID of the filesystem that should be attached. ||
|#

## MetadataOptions {#yandex.cloud.compute.v1.instancegroup.MetadataOptions}

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

## ScalePolicy {#yandex.cloud.compute.v1.instancegroup.ScalePolicy}

#|
||Field | Description ||
|| fixedScale | **[FixedScale](#yandex.cloud.compute.v1.instancegroup.ScalePolicy.FixedScale)**

[Manual scaling policy](/docs/compute/concepts/instance-groups/scale#fixed-policy) of the instance group.

Includes only one of the fields `fixedScale`, `autoScale`. ||
|| autoScale | **[AutoScale](#yandex.cloud.compute.v1.instancegroup.ScalePolicy.AutoScale)**

[Automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group.

Includes only one of the fields `fixedScale`, `autoScale`. ||
|| testAutoScale | **[AutoScale](#yandex.cloud.compute.v1.instancegroup.ScalePolicy.AutoScale)**

Test spec for [automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group. ||
|#

## FixedScale {#yandex.cloud.compute.v1.instancegroup.ScalePolicy.FixedScale}

#|
||Field | Description ||
|| size | **string** (int64)

Number of instances in the instance group. ||
|#

## AutoScale {#yandex.cloud.compute.v1.instancegroup.ScalePolicy.AutoScale}

#|
||Field | Description ||
|| minZoneSize | **string** (int64)

Lower limit for instance count in each zone. ||
|| maxSize | **string** (int64)

Upper limit for total instance count (across all zones).
0 means maximum limit = 100. ||
|| measurementDuration | **string** (duration)

Time in seconds allotted for averaging metrics.
1 minute by default. ||
|| warmupDuration | **string** (duration)

The warmup time of the instance in seconds. During this time,
traffic is sent to the instance, but instance metrics are not collected. ||
|| stabilizationDuration | **string** (duration)

Minimum amount of time in seconds allotted for monitoring before
Instance Groups can reduce the number of instances in the group.
During this time, the group size doesn't decrease, even if the new metric values
indicate that it should. ||
|| initialSize | **string** (int64)

Target group size. ||
|| cpuUtilizationRule | **[CpuUtilizationRule](#yandex.cloud.compute.v1.instancegroup.ScalePolicy.CpuUtilizationRule)**

Defines an autoscaling rule based on the average CPU utilization of the instance group.

If more than one rule is specified, e.g. CPU utilization and one or more Monitoring metrics (`customRules`),
the size of the instance group will be equal to the maximum of sizes calculated according to each metric. ||
|| customRules[] | **[CustomRule](#yandex.cloud.compute.v1.instancegroup.ScalePolicy.CustomRule)**

Defines an autoscaling rule based on a [custom metric](/docs/monitoring/operations/metric/add) from Monitoring.

If more than one rule is specified, e.g. CPU utilization (`cpuUtilizationRule`) and one or more Monitoring
metrics, the size of the instance group will be equal to the maximum of sizes calculated according to each metric. ||
|| autoScaleType | **enum** (AutoScaleType)

Autoscaling type.

- `AUTO_SCALE_TYPE_UNSPECIFIED`
- `ZONAL`: Scale each zone independently. This is the default.
- `REGIONAL`: Scale group as a whole. ||
|#

## CpuUtilizationRule {#yandex.cloud.compute.v1.instancegroup.ScalePolicy.CpuUtilizationRule}

#|
||Field | Description ||
|| utilizationTarget | **string**

Target CPU utilization level. Instance Groups maintains this level for each availability zone. ||
|#

## CustomRule {#yandex.cloud.compute.v1.instancegroup.ScalePolicy.CustomRule}

#|
||Field | Description ||
|| ruleType | **enum** (RuleType)

Required field. Custom metric rule type. This field affects which label from
the custom metric should be used: `zone_id` or `instance_id`.

- `RULE_TYPE_UNSPECIFIED`
- `UTILIZATION`: This type means that the metric applies to one instance.
First, Instance Groups calculates the average metric value for each instance,
then averages the values for instances in one availability zone or in whole group depends on autoscaling type.
This type of metric must have the `instance_id` label.
- `WORKLOAD`: This type means that the metric applies to instances in one availability zone or to whole group depends on autoscaling type.
This type of metric must have the `zone_id` label if ZONAL autoscaling type is chosen. ||
|| metricType | **enum** (MetricType)

Required field. Type of custom metric. This field affects how Instance Groups calculates the average metric value.

- `METRIC_TYPE_UNSPECIFIED`
- `GAUGE`: This type is used for metrics that show the metric value at a certain point in time,
such as requests per second to the server on an instance.

  Instance Groups calculates the average metric value for the period
specified in the [AutoScale.measurementDuration](#yandex.cloud.compute.v1.instancegroup.ScalePolicy.AutoScale) field.
- `COUNTER`: This type is used for metrics that monotonically increase over time,
such as the total number of requests to the server on an instance.

  Instance Groups calculates the average value increase for the period
specified in the [AutoScale.measurementDuration](#yandex.cloud.compute.v1.instancegroup.ScalePolicy.AutoScale) field. ||
|| metricName | **string**

Required field. Name of custom metric in Monitoring that should be used for scaling. ||
|| labels | **object** (map<**string**, **string**>)

Labels of custom metric in Monitoring that should be used for scaling. ||
|| target | **string**

Target value for the custom metric. Instance Groups maintains this level for each availability zone. ||
|| folderId | **string**

Folder id of custom metric in Monitoring that should be used for scaling. ||
|| service | **string**

Service of custom metric in Monitoring that should be used for scaling. ||
|#

## DeployPolicy {#yandex.cloud.compute.v1.instancegroup.DeployPolicy}

#|
||Field | Description ||
|| maxUnavailable | **string** (int64)

The maximum number of running instances that can be taken offline (i.e., stopped or deleted) at the same time
during the update process.
If `maxExpansion` is not specified or set to zero, `maxUnavailable` must be set to a non-zero value. ||
|| maxDeleting | **string** (int64)

The maximum number of instances that can be deleted at the same time.

The value 0 is any number of virtual machines within the allowed values. ||
|| maxCreating | **string** (int64)

The maximum number of instances that can be created at the same time.

The value 0 is any number of virtual machines within the allowed values. ||
|| maxExpansion | **string** (int64)

The maximum number of instances that can be temporarily allocated above the group's target size
during the update process.
If `maxUnavailable` is not specified or set to zero, `maxExpansion` must be set to a non-zero value. ||
|| startupDuration | **string** (duration)

Instance startup duration.
Instance will be considered up and running (and start receiving traffic) only after startup_duration
has elapsed and all health checks are passed.
See [ManagedInstance.Status](/docs/compute/instancegroup/api-ref/InstanceGroup/listInstances#yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status) for more information. ||
|| strategy | **enum** (Strategy)

Affects the lifecycle of the instance during deployment.

- `STRATEGY_UNSPECIFIED`
- `PROACTIVE`: Instance Groups can forcefully stop a running instance. This is the default.
- `OPPORTUNISTIC`: Instance Groups does not stop a running instance.
Instead, it will wait until the instance stops itself or becomes unhealthy. ||
|| minimalAction | **enum** (MinimalAction)

If instance update requires a less disruptive action than `minimalAction`,
Instance Groups performs `minimalAction` to execute the update

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
|| zoneId | **string**

Required field. ID of the availability zone where the instance resides. ||
|| instanceTagsPool[] | **string**

Each instance in a zone will be associated with exactly one of a tag from a pool below.
All specified tags must be unique across the whole group not only the zone.
It is guaranteed that during whole deploy only tags from prefix of the specified list will be used.
It is possible to use tag associated with instance in templating via {instance.tag}. ||
|#

## LoadBalancerSpec {#yandex.cloud.compute.v1.instancegroup.LoadBalancerSpec}

#|
||Field | Description ||
|| targetGroupSpec | **[TargetGroupSpec](#yandex.cloud.compute.v1.instancegroup.TargetGroupSpec)**

Specification of the target group that the instance group will be added to. For more information, see [Target groups and resources](/docs/network-load-balancer/concepts/target-resources). ||
|| maxOpeningTrafficDuration | **string** (duration)

Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded,
the VM will be turned off based on the deployment policy. Specified in seconds. ||
|| ignoreHealthChecks | **boolean**

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
|| healthCheckSpecs[] | **[HealthCheckSpec](#yandex.cloud.compute.v1.instancegroup.HealthCheckSpec)**

Health checking specification. For more information, see [Health check](/docs/network-load-balancer/concepts/health-check). ||
|| maxCheckingHealthDuration | **string** (duration)

Timeout for waiting for the VM to become healthy. If the timeout is exceeded,
the VM will be turned off based on the deployment policy. Specified in seconds. ||
|#

## HealthCheckSpec {#yandex.cloud.compute.v1.instancegroup.HealthCheckSpec}

#|
||Field | Description ||
|| interval | **string** (duration)

The interval between health checks. The default is 2 seconds. ||
|| timeout | **string** (duration)

Timeout for the managed instance to return a response for the health check. The default is 1 second. ||
|| unhealthyThreshold | **string** (int64)

The number of failed health checks for the managed instance to be considered unhealthy. The default (0) is 2. ||
|| healthyThreshold | **string** (int64)

The number of successful health checks required in order for the managed instance to be considered healthy. The default (0) is 2. ||
|| tcpOptions | **[TcpOptions](#yandex.cloud.compute.v1.instancegroup.HealthCheckSpec.TcpOptions)**

Configuration options for a TCP health check.

Includes only one of the fields `tcpOptions`, `httpOptions`. ||
|| httpOptions | **[HttpOptions](#yandex.cloud.compute.v1.instancegroup.HealthCheckSpec.HttpOptions)**

Configuration options for an HTTP health check.

Includes only one of the fields `tcpOptions`, `httpOptions`. ||
|#

## TcpOptions {#yandex.cloud.compute.v1.instancegroup.HealthCheckSpec.TcpOptions}

#|
||Field | Description ||
|| port | **string** (int64)

Port to use for TCP health checks. ||
|#

## HttpOptions {#yandex.cloud.compute.v1.instancegroup.HealthCheckSpec.HttpOptions}

#|
||Field | Description ||
|| port | **string** (int64)

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
|| targetGroupSpec | **[ApplicationTargetGroupSpec](#yandex.cloud.compute.v1.instancegroup.ApplicationTargetGroupSpec)**

Required field. Basic properties of the Application Load Balancer target group attributed to the instance group. ||
|| maxOpeningTrafficDuration | **string** (duration)

Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded,
the VM will be turned off based on the deployment policy. Specified in seconds. ||
|| ignoreHealthChecks | **boolean**

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

## AutoHealingPolicy {#yandex.cloud.compute.v1.instancegroup.AutoHealingPolicy}

#|
||Field | Description ||
|| autoHealingAction | **enum** (AutoHealingAction)

Instance Groups performs `autoHealingAction` when instance becomes unhealthy.

- `AUTO_HEALING_ACTION_UNSPECIFIED`
- `RESTART`: Re-starting an instance with restart: stopping and then starting the instance.
- `RECREATE`: Re-creating an instance: deleting an instance and creating a new one.
- `NONE`: No action ||
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
    "instanceGroupId": "string"
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
    "instanceTemplate": {
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
      "bootDiskSpec": {
        "mode": "string",
        "deviceName": "string",
        "diskSpec": {
          "description": "string",
          "typeId": "string",
          "size": "string",
          // Includes only one of the fields `imageId`, `snapshotId`
          "imageId": "string",
          "snapshotId": "string",
          // end of the list of possible fields
          "preserveAfterInstanceDelete": "boolean"
        },
        "diskId": "string",
        "name": "string"
      },
      "secondaryDiskSpecs": [
        {
          "mode": "string",
          "deviceName": "string",
          "diskSpec": {
            "description": "string",
            "typeId": "string",
            "size": "string",
            // Includes only one of the fields `imageId`, `snapshotId`
            "imageId": "string",
            "snapshotId": "string",
            // end of the list of possible fields
            "preserveAfterInstanceDelete": "boolean"
          },
          "diskId": "string",
          "name": "string"
        }
      ],
      "networkInterfaceSpecs": [
        {
          "networkId": "string",
          "subnetIds": [
            "string"
          ],
          "primaryV4AddressSpec": {
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
            ],
            "address": "string"
          },
          "primaryV6AddressSpec": {
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
            ],
            "address": "string"
          },
          "securityGroupIds": [
            "string"
          ]
        }
      ],
      "schedulingPolicy": {
        "preemptible": "boolean"
      },
      "serviceAccountId": "string",
      "networkSettings": {
        "type": "string"
      },
      "name": "string",
      "hostname": "string",
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
        ]
      },
      "filesystemSpecs": [
        {
          "mode": "string",
          "deviceName": "string",
          "filesystemId": "string"
        }
      ],
      "metadataOptions": {
        "gceHttpEndpoint": "string",
        "awsV1HttpEndpoint": "string",
        "gceHttpToken": "string",
        "awsV1HttpToken": "string"
      }
    },
    "scalePolicy": {
      // Includes only one of the fields `fixedScale`, `autoScale`
      "fixedScale": {
        "size": "string"
      },
      "autoScale": {
        "minZoneSize": "string",
        "maxSize": "string",
        "measurementDuration": "string",
        "warmupDuration": "string",
        "stabilizationDuration": "string",
        "initialSize": "string",
        "cpuUtilizationRule": {
          "utilizationTarget": "string"
        },
        "customRules": [
          {
            "ruleType": "string",
            "metricType": "string",
            "metricName": "string",
            "labels": "object",
            "target": "string",
            "folderId": "string",
            "service": "string"
          }
        ],
        "autoScaleType": "string"
      },
      // end of the list of possible fields
      "testAutoScale": {
        "minZoneSize": "string",
        "maxSize": "string",
        "measurementDuration": "string",
        "warmupDuration": "string",
        "stabilizationDuration": "string",
        "initialSize": "string",
        "cpuUtilizationRule": {
          "utilizationTarget": "string"
        },
        "customRules": [
          {
            "ruleType": "string",
            "metricType": "string",
            "metricName": "string",
            "labels": "object",
            "target": "string",
            "folderId": "string",
            "service": "string"
          }
        ],
        "autoScaleType": "string"
      }
    },
    "deployPolicy": {
      "maxUnavailable": "string",
      "maxDeleting": "string",
      "maxCreating": "string",
      "maxExpansion": "string",
      "startupDuration": "string",
      "strategy": "string",
      "minimalAction": "string"
    },
    "allocationPolicy": {
      "zones": [
        {
          "zoneId": "string",
          "instanceTagsPool": [
            "string"
          ]
        }
      ]
    },
    "loadBalancerState": {
      "targetGroupId": "string",
      "statusMessage": "string"
    },
    "managedInstancesState": {
      "targetSize": "string",
      "runningActualCount": "string",
      "runningOutdatedCount": "string",
      "processingCount": "string"
    },
    "loadBalancerSpec": {
      "targetGroupSpec": {
        "name": "string",
        "description": "string",
        "labels": "object"
      },
      "maxOpeningTrafficDuration": "string",
      "ignoreHealthChecks": "boolean"
    },
    "healthChecksSpec": {
      "healthCheckSpecs": [
        {
          "interval": "string",
          "timeout": "string",
          "unhealthyThreshold": "string",
          "healthyThreshold": "string",
          // Includes only one of the fields `tcpOptions`, `httpOptions`
          "tcpOptions": {
            "port": "string"
          },
          "httpOptions": {
            "port": "string",
            "path": "string"
          }
          // end of the list of possible fields
        }
      ],
      "maxCheckingHealthDuration": "string"
    },
    "serviceAccountId": "string",
    "status": "string",
    "variables": [
      {
        "key": "string",
        "value": "string"
      }
    ],
    "deletionProtection": "boolean",
    "applicationLoadBalancerSpec": {
      "targetGroupSpec": {
        "name": "string",
        "description": "string",
        "labels": "object"
      },
      "maxOpeningTrafficDuration": "string",
      "ignoreHealthChecks": "boolean"
    },
    "applicationLoadBalancerState": {
      "targetGroupId": "string",
      "statusMessage": "string"
    },
    "autoHealingPolicy": {
      "autoHealingAction": "string"
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
|| metadata | **[CreateInstanceGroupMetadata](#yandex.cloud.compute.v1.instancegroup.CreateInstanceGroupMetadata)**

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
|| response | **[InstanceGroup](#yandex.cloud.compute.v1.instancegroup.InstanceGroup)**

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

## CreateInstanceGroupMetadata {#yandex.cloud.compute.v1.instancegroup.CreateInstanceGroupMetadata}

#|
||Field | Description ||
|| instanceGroupId | **string**

ID of the instance group that is being created. ||
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

## InstanceGroup {#yandex.cloud.compute.v1.instancegroup.InstanceGroup}

#|
||Field | Description ||
|| id | **string**

ID of the instance group. ||
|| folderId | **string**

ID of the folder that the instance group belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the instance group.
The name is unique within the folder. ||
|| description | **string**

Description of the instance group. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|| instanceTemplate | **[InstanceTemplate](#yandex.cloud.compute.v1.instancegroup.InstanceTemplate2)**

Instance template for creating the instance group.
For more information, see [Instance Templates](/docs/compute/concepts/instance-groups/instance-template). ||
|| scalePolicy | **[ScalePolicy](#yandex.cloud.compute.v1.instancegroup.ScalePolicy2)**

[Scaling policy](/docs/compute/concepts/instance-groups/scale) of the instance group. ||
|| deployPolicy | **[DeployPolicy](#yandex.cloud.compute.v1.instancegroup.DeployPolicy2)**

Deployment policy of the instance group. ||
|| allocationPolicy | **[AllocationPolicy](#yandex.cloud.compute.v1.instancegroup.AllocationPolicy2)**

Allocation policy of the instance group by zones and regions. ||
|| loadBalancerState | **[LoadBalancerState](#yandex.cloud.compute.v1.instancegroup.LoadBalancerState)**

Status of the Network Load Balancer target group attributed to the instance group. ||
|| managedInstancesState | **[ManagedInstancesState](#yandex.cloud.compute.v1.instancegroup.ManagedInstancesState)**

States of instances for this instance group. ||
|| loadBalancerSpec | **[LoadBalancerSpec](#yandex.cloud.compute.v1.instancegroup.LoadBalancerSpec2)**

Settings for balancing load between instances via [Network Load Balancer](/docs/network-load-balancer/concepts)
(OSI model layer 3). ||
|| healthChecksSpec | **[HealthChecksSpec](#yandex.cloud.compute.v1.instancegroup.HealthChecksSpec2)**

Health checking specification. For more information, see [Health check](/docs/network-load-balancer/concepts/health-check). ||
|| serviceAccountId | **string**

ID of the service account. The service account will be used for all API calls
made by the Instance Groups component on behalf of the user (for example, creating instances, adding them to load balancer target group, etc.). For more information, see [Service accounts](/docs/iam/concepts/users/service-accounts).
To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/ServiceAccount/list#List) request. ||
|| status | **enum** (Status)

Status of the instance group.

- `STATUS_UNSPECIFIED`
- `STARTING`: Instance group is being started and will become active soon.
- `ACTIVE`: Instance group is active.
In this state the group manages its instances and monitors their health,
creating, deleting, stopping, updating and starting instances as needed.

  To stop the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Stop](/docs/compute/instancegroup/api-ref/InstanceGroup/stop#Stop).
To pause the processes in the instance group, i.e. scaling, checking instances' health,
auto-healing and updating them, without stopping the instances,
call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.PauseProcesses](/docs/compute/instancegroup/api-ref/InstanceGroup/pauseProcesses#PauseProcesses).
- `STOPPING`: Instance group is being stopped.
Group's instances stop receiving traffic from the load balancer (if any) and are then stopped.
- `STOPPED`: Instance group is stopped.
In this state the group cannot be updated and does not react to any changes made to its instances.
To start the instance group, call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.Start](/docs/compute/instancegroup/api-ref/InstanceGroup/start#Start).
- `DELETING`: Instance group is being deleted.
- `PAUSED`: Instance group is paused.
In this state all the processes regarding the group management, i.e. scaling, checking instances' health,
auto-healing and updating them, are paused. The instances that were running prior to pausing the group, however,
may still be running.

  To resume the processes in the instance group,
call [yandex.cloud.compute.v1.instancegroup.InstanceGroupService.ResumeProcesses](/docs/compute/instancegroup/api-ref/InstanceGroup/resumeProcesses#ResumeProcesses).
The group status will change to `ACTIVE`. ||
|| variables[] | **[Variable](#yandex.cloud.compute.v1.instancegroup.Variable2)** ||
|| deletionProtection | **boolean**

Flag prohibiting deletion of the instance group.

Allowed values:</br>- `false`: The instance group can be deleted.</br>- `true`: The instance group cannot be deleted.

The default is `false`. ||
|| applicationLoadBalancerSpec | **[ApplicationLoadBalancerSpec](#yandex.cloud.compute.v1.instancegroup.ApplicationLoadBalancerSpec2)**

Settings for balancing load between instances via [Application Load Balancer](/docs/application-load-balancer/concepts)
(OSI model layer 7). ||
|| applicationLoadBalancerState | **[ApplicationLoadBalancerState](#yandex.cloud.compute.v1.instancegroup.ApplicationLoadBalancerState)**

Status of the Application Load Balancer target group attributed to the instance group.

Returned if there is a working load balancer that the target group is connected to. ||
|| autoHealingPolicy | **[AutoHealingPolicy](#yandex.cloud.compute.v1.instancegroup.AutoHealingPolicy2)**

AutoHealingPolicy policy of the instance group. ||
|#

## InstanceTemplate {#yandex.cloud.compute.v1.instancegroup.InstanceTemplate2}

#|
||Field | Description ||
|| description | **string**

Description of the instance template. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|| platformId | **string**

Required field. ID of the hardware platform configuration for the instance.
Platforms allows you to create various types of instances: with a large amount of memory,
with a large number of cores, with a burstable performance.
For more information, see [Platforms](/docs/compute/concepts/vm-platforms). ||
|| resourcesSpec | **[ResourcesSpec](#yandex.cloud.compute.v1.instancegroup.ResourcesSpec2)**

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
|| bootDiskSpec | **[AttachedDiskSpec](#yandex.cloud.compute.v1.instancegroup.AttachedDiskSpec2)**

Required field. Boot disk specification that will be attached to the instance. ||
|| secondaryDiskSpecs[] | **[AttachedDiskSpec](#yandex.cloud.compute.v1.instancegroup.AttachedDiskSpec2)**

Array of secondary disks that will be attached to the instance. ||
|| networkInterfaceSpecs[] | **[NetworkInterfaceSpec](#yandex.cloud.compute.v1.instancegroup.NetworkInterfaceSpec2)**

Required field. Array of network interfaces that will be attached to the instance. ||
|| schedulingPolicy | **[SchedulingPolicy](#yandex.cloud.compute.v1.instancegroup.SchedulingPolicy2)**

Scheduling policy for the instance. ||
|| serviceAccountId | **string**

Service account ID for the instance. ||
|| networkSettings | **[NetworkSettings](#yandex.cloud.compute.v1.instancegroup.NetworkSettings2)**

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
This field is used to generate the [yandex.cloud.compute.v1.Instance.fqdn](/docs/compute/api-ref/GpuCluster/listInstances#yandex.cloud.compute.v1.Instance) value.
The host name must be unique within the network and region.
If not specified, the host name will be equal to [yandex.cloud.compute.v1.Instance.id](/docs/compute/api-ref/GpuCluster/listInstances#yandex.cloud.compute.v1.Instance) of the instance
and FQDN will be `<id>.auto.internal`. Otherwise FQDN will be `<hostname>.<region_id>.internal`.

In order to be unique it must contain at least on of instance unique placeholders:
{instance.short_id}
{instance.index}
combination of {instance.zone_id} and {instance.index_in_zone}
Example: my-instance-{instance.index}
If not set, `name` value will be used
It may also contain another placeholders, see metadata doc for full list. ||
|| placementPolicy | **[PlacementPolicy](#yandex.cloud.compute.v1.instancegroup.PlacementPolicy2)**

Placement Group ||
|| filesystemSpecs[] | **[AttachedFilesystemSpec](#yandex.cloud.compute.v1.instancegroup.AttachedFilesystemSpec2)**

Array of filesystems to attach to the instance.

The filesystems must reside in the same availability zone as the instance.

To use the instance with an attached filesystem, the latter must be mounted.
For details, see [documentation](/docs/compute/operations/filesystem/attach-to-vm). ||
|| metadataOptions | **[MetadataOptions](#yandex.cloud.compute.v1.instancegroup.MetadataOptions2)**

Metadata options for the instance ||
|#

## ResourcesSpec {#yandex.cloud.compute.v1.instancegroup.ResourcesSpec2}

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

## AttachedDiskSpec {#yandex.cloud.compute.v1.instancegroup.AttachedDiskSpec2}

#|
||Field | Description ||
|| mode | **enum** (Mode)

Required field. Access mode to the Disk resource.

- `MODE_UNSPECIFIED`
- `READ_ONLY`: Read-only access.
- `READ_WRITE`: Read/Write access. ||
|| deviceName | **string**

Serial number that is reflected in the /dev/disk/by-id/ tree
of a Linux operating system running within the instance.

This value can be used to reference the device for mounting, resizing, and so on, from within the instance. ||
|| diskSpec | **[DiskSpec](#yandex.cloud.compute.v1.instancegroup.AttachedDiskSpec.DiskSpec2)**

Required field. oneof disk_spec or disk_id
Disk specification that is attached to the instance. For more information, see [Disks](/docs/compute/concepts/disk). ||
|| diskId | **string**

Set to use an existing disk. To set use variables. ||
|| name | **string**

When set can be later used to change DiskSpec of actual disk. ||
|#

## DiskSpec {#yandex.cloud.compute.v1.instancegroup.AttachedDiskSpec.DiskSpec2}

#|
||Field | Description ||
|| description | **string**

Description of the disk. ||
|| typeId | **string**

Required field. ID of the disk type. ||
|| size | **string** (int64)

Size of the disk, specified in bytes. ||
|| imageId | **string**

ID of the image that will be used for disk creation.

Includes only one of the fields `imageId`, `snapshotId`. ||
|| snapshotId | **string**

ID of the snapshot that will be used for disk creation.

Includes only one of the fields `imageId`, `snapshotId`. ||
|| preserveAfterInstanceDelete | **boolean**

When set to true, disk will not be deleted even after managed instance is deleted.
It will be a user's responsibility to delete such disks. ||
|#

## NetworkInterfaceSpec {#yandex.cloud.compute.v1.instancegroup.NetworkInterfaceSpec2}

#|
||Field | Description ||
|| networkId | **string**

ID of the network. ||
|| subnetIds[] | **string**

IDs of the subnets. ||
|| primaryV4AddressSpec | **[PrimaryAddressSpec](#yandex.cloud.compute.v1.instancegroup.PrimaryAddressSpec2)**

Primary IPv4 address that is assigned to the instance for this network interface. ||
|| primaryV6AddressSpec | **[PrimaryAddressSpec](#yandex.cloud.compute.v1.instancegroup.PrimaryAddressSpec2)**

Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet. ||
|| securityGroupIds[] | **string**

IDs of security groups. ||
|#

## PrimaryAddressSpec {#yandex.cloud.compute.v1.instancegroup.PrimaryAddressSpec2}

#|
||Field | Description ||
|| oneToOneNatSpec | **[OneToOneNatSpec](#yandex.cloud.compute.v1.instancegroup.OneToOneNatSpec2)**

An external IP address configuration.
If not specified, then this managed instance will have no external internet access. ||
|| dnsRecordSpecs[] | **[DnsRecordSpec](#yandex.cloud.compute.v1.instancegroup.DnsRecordSpec2)**

Internal DNS configuration ||
|| address | **string**

Optional. Manual set static internal IP. To set use variables. ||
|#

## OneToOneNatSpec {#yandex.cloud.compute.v1.instancegroup.OneToOneNatSpec2}

#|
||Field | Description ||
|| ipVersion | **enum** (IpVersion)

IP version for the public IP address.

- `IP_VERSION_UNSPECIFIED`
- `IPV4`: IPv4 address, for example 192.168.0.0.
- `IPV6`: IPv6 address, not available yet. ||
|| address | **string**

Manual set static public IP. To set use variables. (optional) ||
|| dnsRecordSpecs[] | **[DnsRecordSpec](#yandex.cloud.compute.v1.instancegroup.DnsRecordSpec2)**

External DNS configuration ||
|#

## DnsRecordSpec {#yandex.cloud.compute.v1.instancegroup.DnsRecordSpec2}

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

## SchedulingPolicy {#yandex.cloud.compute.v1.instancegroup.SchedulingPolicy2}

#|
||Field | Description ||
|| preemptible | **boolean**

Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time
if their resources are needed by Compute.
For more information, see [Preemptible Virtual Machines](/docs/compute/concepts/preemptible-vm). ||
|#

## NetworkSettings {#yandex.cloud.compute.v1.instancegroup.NetworkSettings2}

#|
||Field | Description ||
|| type | **enum** (Type)

Type of instance network.

- `TYPE_UNSPECIFIED`
- `STANDARD`
- `SOFTWARE_ACCELERATED`
- `HARDWARE_ACCELERATED` ||
|#

## PlacementPolicy {#yandex.cloud.compute.v1.instancegroup.PlacementPolicy2}

#|
||Field | Description ||
|| placementGroupId | **string**

Identifier of placement group ||
|| hostAffinityRules[] | **[HostAffinityRule](#yandex.cloud.compute.v1.instancegroup.PlacementPolicy.HostAffinityRule2)**

List of affinity rules. Scheduler will attempt to allocate instances according to order of rules. ||
|#

## HostAffinityRule {#yandex.cloud.compute.v1.instancegroup.PlacementPolicy.HostAffinityRule2}

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

## AttachedFilesystemSpec {#yandex.cloud.compute.v1.instancegroup.AttachedFilesystemSpec2}

#|
||Field | Description ||
|| mode | **enum** (Mode)

Mode of access to the filesystem that should be attached.

- `MODE_UNSPECIFIED`
- `READ_ONLY`: Read-only access.
- `READ_WRITE`: Read/Write access. Default value. ||
|| deviceName | **string**

Name of the device representing the filesystem on the instance.

The name should be used for referencing the filesystem from within the instance
when it's being mounted, resized etc.

If not specified, a random value will be generated. ||
|| filesystemId | **string**

ID of the filesystem that should be attached. ||
|#

## MetadataOptions {#yandex.cloud.compute.v1.instancegroup.MetadataOptions2}

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

## ScalePolicy {#yandex.cloud.compute.v1.instancegroup.ScalePolicy2}

#|
||Field | Description ||
|| fixedScale | **[FixedScale](#yandex.cloud.compute.v1.instancegroup.ScalePolicy.FixedScale2)**

[Manual scaling policy](/docs/compute/concepts/instance-groups/scale#fixed-policy) of the instance group.

Includes only one of the fields `fixedScale`, `autoScale`. ||
|| autoScale | **[AutoScale](#yandex.cloud.compute.v1.instancegroup.ScalePolicy.AutoScale2)**

[Automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group.

Includes only one of the fields `fixedScale`, `autoScale`. ||
|| testAutoScale | **[AutoScale](#yandex.cloud.compute.v1.instancegroup.ScalePolicy.AutoScale2)**

Test spec for [automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group. ||
|#

## FixedScale {#yandex.cloud.compute.v1.instancegroup.ScalePolicy.FixedScale2}

#|
||Field | Description ||
|| size | **string** (int64)

Number of instances in the instance group. ||
|#

## AutoScale {#yandex.cloud.compute.v1.instancegroup.ScalePolicy.AutoScale2}

#|
||Field | Description ||
|| minZoneSize | **string** (int64)

Lower limit for instance count in each zone. ||
|| maxSize | **string** (int64)

Upper limit for total instance count (across all zones).
0 means maximum limit = 100. ||
|| measurementDuration | **string** (duration)

Time in seconds allotted for averaging metrics.
1 minute by default. ||
|| warmupDuration | **string** (duration)

The warmup time of the instance in seconds. During this time,
traffic is sent to the instance, but instance metrics are not collected. ||
|| stabilizationDuration | **string** (duration)

Minimum amount of time in seconds allotted for monitoring before
Instance Groups can reduce the number of instances in the group.
During this time, the group size doesn't decrease, even if the new metric values
indicate that it should. ||
|| initialSize | **string** (int64)

Target group size. ||
|| cpuUtilizationRule | **[CpuUtilizationRule](#yandex.cloud.compute.v1.instancegroup.ScalePolicy.CpuUtilizationRule2)**

Defines an autoscaling rule based on the average CPU utilization of the instance group.

If more than one rule is specified, e.g. CPU utilization and one or more Monitoring metrics (`customRules`),
the size of the instance group will be equal to the maximum of sizes calculated according to each metric. ||
|| customRules[] | **[CustomRule](#yandex.cloud.compute.v1.instancegroup.ScalePolicy.CustomRule2)**

Defines an autoscaling rule based on a [custom metric](/docs/monitoring/operations/metric/add) from Monitoring.

If more than one rule is specified, e.g. CPU utilization (`cpuUtilizationRule`) and one or more Monitoring
metrics, the size of the instance group will be equal to the maximum of sizes calculated according to each metric. ||
|| autoScaleType | **enum** (AutoScaleType)

Autoscaling type.

- `AUTO_SCALE_TYPE_UNSPECIFIED`
- `ZONAL`: Scale each zone independently. This is the default.
- `REGIONAL`: Scale group as a whole. ||
|#

## CpuUtilizationRule {#yandex.cloud.compute.v1.instancegroup.ScalePolicy.CpuUtilizationRule2}

#|
||Field | Description ||
|| utilizationTarget | **string**

Target CPU utilization level. Instance Groups maintains this level for each availability zone. ||
|#

## CustomRule {#yandex.cloud.compute.v1.instancegroup.ScalePolicy.CustomRule2}

#|
||Field | Description ||
|| ruleType | **enum** (RuleType)

Required field. Custom metric rule type. This field affects which label from
the custom metric should be used: `zone_id` or `instance_id`.

- `RULE_TYPE_UNSPECIFIED`
- `UTILIZATION`: This type means that the metric applies to one instance.
First, Instance Groups calculates the average metric value for each instance,
then averages the values for instances in one availability zone or in whole group depends on autoscaling type.
This type of metric must have the `instance_id` label.
- `WORKLOAD`: This type means that the metric applies to instances in one availability zone or to whole group depends on autoscaling type.
This type of metric must have the `zone_id` label if ZONAL autoscaling type is chosen. ||
|| metricType | **enum** (MetricType)

Required field. Type of custom metric. This field affects how Instance Groups calculates the average metric value.

- `METRIC_TYPE_UNSPECIFIED`
- `GAUGE`: This type is used for metrics that show the metric value at a certain point in time,
such as requests per second to the server on an instance.

  Instance Groups calculates the average metric value for the period
specified in the [AutoScale.measurementDuration](#yandex.cloud.compute.v1.instancegroup.ScalePolicy.AutoScale2) field.
- `COUNTER`: This type is used for metrics that monotonically increase over time,
such as the total number of requests to the server on an instance.

  Instance Groups calculates the average value increase for the period
specified in the [AutoScale.measurementDuration](#yandex.cloud.compute.v1.instancegroup.ScalePolicy.AutoScale2) field. ||
|| metricName | **string**

Required field. Name of custom metric in Monitoring that should be used for scaling. ||
|| labels | **object** (map<**string**, **string**>)

Labels of custom metric in Monitoring that should be used for scaling. ||
|| target | **string**

Target value for the custom metric. Instance Groups maintains this level for each availability zone. ||
|| folderId | **string**

Folder id of custom metric in Monitoring that should be used for scaling. ||
|| service | **string**

Service of custom metric in Monitoring that should be used for scaling. ||
|#

## DeployPolicy {#yandex.cloud.compute.v1.instancegroup.DeployPolicy2}

#|
||Field | Description ||
|| maxUnavailable | **string** (int64)

The maximum number of running instances that can be taken offline (i.e., stopped or deleted) at the same time
during the update process.
If `maxExpansion` is not specified or set to zero, `maxUnavailable` must be set to a non-zero value. ||
|| maxDeleting | **string** (int64)

The maximum number of instances that can be deleted at the same time.

The value 0 is any number of virtual machines within the allowed values. ||
|| maxCreating | **string** (int64)

The maximum number of instances that can be created at the same time.

The value 0 is any number of virtual machines within the allowed values. ||
|| maxExpansion | **string** (int64)

The maximum number of instances that can be temporarily allocated above the group's target size
during the update process.
If `maxUnavailable` is not specified or set to zero, `maxExpansion` must be set to a non-zero value. ||
|| startupDuration | **string** (duration)

Instance startup duration.
Instance will be considered up and running (and start receiving traffic) only after startup_duration
has elapsed and all health checks are passed.
See [ManagedInstance.Status](/docs/compute/instancegroup/api-ref/InstanceGroup/listInstances#yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status) for more information. ||
|| strategy | **enum** (Strategy)

Affects the lifecycle of the instance during deployment.

- `STRATEGY_UNSPECIFIED`
- `PROACTIVE`: Instance Groups can forcefully stop a running instance. This is the default.
- `OPPORTUNISTIC`: Instance Groups does not stop a running instance.
Instead, it will wait until the instance stops itself or becomes unhealthy. ||
|| minimalAction | **enum** (MinimalAction)

If instance update requires a less disruptive action than `minimalAction`,
Instance Groups performs `minimalAction` to execute the update

- `MINIMAL_ACTION_UNSPECIFIED`
- `LIVE_UPDATE`: Updating an instance without stopping. This is the default.
- `RESTART`: Updating an instance with restart: stopping and then starting the instance.
- `RECREATE`: Re-creating an instance: deleting an instance and creating a new one. ||
|#

## AllocationPolicy {#yandex.cloud.compute.v1.instancegroup.AllocationPolicy2}

#|
||Field | Description ||
|| zones[] | **[Zone](#yandex.cloud.compute.v1.instancegroup.AllocationPolicy.Zone2)**

List of availability zones. ||
|#

## Zone {#yandex.cloud.compute.v1.instancegroup.AllocationPolicy.Zone2}

#|
||Field | Description ||
|| zoneId | **string**

Required field. ID of the availability zone where the instance resides. ||
|| instanceTagsPool[] | **string**

Each instance in a zone will be associated with exactly one of a tag from a pool below.
All specified tags must be unique across the whole group not only the zone.
It is guaranteed that during whole deploy only tags from prefix of the specified list will be used.
It is possible to use tag associated with instance in templating via {instance.tag}. ||
|#

## LoadBalancerState {#yandex.cloud.compute.v1.instancegroup.LoadBalancerState}

#|
||Field | Description ||
|| targetGroupId | **string**

ID of the Network Load Balancer target group attributed to the instance group. ||
|| statusMessage | **string**

Status message of the target group. ||
|#

## ManagedInstancesState {#yandex.cloud.compute.v1.instancegroup.ManagedInstancesState}

#|
||Field | Description ||
|| targetSize | **string** (int64)

Target number of instances for this instance group. ||
|| runningActualCount | **string** (int64)

The number of running instances that match the current instance template. For more information, see [ManagedInstance.Status.RUNNING_ACTUAL](/docs/compute/instancegroup/api-ref/InstanceGroup/listInstances#yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status). ||
|| runningOutdatedCount | **string** (int64)

The number of running instances that does not match the current instance template. For more information, see [ManagedInstance.Status.RUNNING_OUTDATED](/docs/compute/instancegroup/api-ref/InstanceGroup/listInstances#yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status). ||
|| processingCount | **string** (int64)

The number of instances in flight (for example, updating, starting, deleting). For more information, see [ManagedInstance.Status](/docs/compute/instancegroup/api-ref/InstanceGroup/listInstances#yandex.cloud.compute.v1.instancegroup.ManagedInstance.Status). ||
|#

## LoadBalancerSpec {#yandex.cloud.compute.v1.instancegroup.LoadBalancerSpec2}

#|
||Field | Description ||
|| targetGroupSpec | **[TargetGroupSpec](#yandex.cloud.compute.v1.instancegroup.TargetGroupSpec2)**

Specification of the target group that the instance group will be added to. For more information, see [Target groups and resources](/docs/network-load-balancer/concepts/target-resources). ||
|| maxOpeningTrafficDuration | **string** (duration)

Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded,
the VM will be turned off based on the deployment policy. Specified in seconds. ||
|| ignoreHealthChecks | **boolean**

Do not wait load balancer health checks. ||
|#

## TargetGroupSpec {#yandex.cloud.compute.v1.instancegroup.TargetGroupSpec2}

#|
||Field | Description ||
|| name | **string**

Name of the target group. ||
|| description | **string**

Description of the target group. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|#

## HealthChecksSpec {#yandex.cloud.compute.v1.instancegroup.HealthChecksSpec2}

#|
||Field | Description ||
|| healthCheckSpecs[] | **[HealthCheckSpec](#yandex.cloud.compute.v1.instancegroup.HealthCheckSpec2)**

Health checking specification. For more information, see [Health check](/docs/network-load-balancer/concepts/health-check). ||
|| maxCheckingHealthDuration | **string** (duration)

Timeout for waiting for the VM to become healthy. If the timeout is exceeded,
the VM will be turned off based on the deployment policy. Specified in seconds. ||
|#

## HealthCheckSpec {#yandex.cloud.compute.v1.instancegroup.HealthCheckSpec2}

#|
||Field | Description ||
|| interval | **string** (duration)

The interval between health checks. The default is 2 seconds. ||
|| timeout | **string** (duration)

Timeout for the managed instance to return a response for the health check. The default is 1 second. ||
|| unhealthyThreshold | **string** (int64)

The number of failed health checks for the managed instance to be considered unhealthy. The default (0) is 2. ||
|| healthyThreshold | **string** (int64)

The number of successful health checks required in order for the managed instance to be considered healthy. The default (0) is 2. ||
|| tcpOptions | **[TcpOptions](#yandex.cloud.compute.v1.instancegroup.HealthCheckSpec.TcpOptions2)**

Configuration options for a TCP health check.

Includes only one of the fields `tcpOptions`, `httpOptions`. ||
|| httpOptions | **[HttpOptions](#yandex.cloud.compute.v1.instancegroup.HealthCheckSpec.HttpOptions2)**

Configuration options for an HTTP health check.

Includes only one of the fields `tcpOptions`, `httpOptions`. ||
|#

## TcpOptions {#yandex.cloud.compute.v1.instancegroup.HealthCheckSpec.TcpOptions2}

#|
||Field | Description ||
|| port | **string** (int64)

Port to use for TCP health checks. ||
|#

## HttpOptions {#yandex.cloud.compute.v1.instancegroup.HealthCheckSpec.HttpOptions2}

#|
||Field | Description ||
|| port | **string** (int64)

Port to use for HTTP health checks. ||
|| path | **string**

URL path to set for health checking requests. ||
|#

## Variable {#yandex.cloud.compute.v1.instancegroup.Variable2}

#|
||Field | Description ||
|| key | **string** ||
|| value | **string** ||
|#

## ApplicationLoadBalancerSpec {#yandex.cloud.compute.v1.instancegroup.ApplicationLoadBalancerSpec2}

#|
||Field | Description ||
|| targetGroupSpec | **[ApplicationTargetGroupSpec](#yandex.cloud.compute.v1.instancegroup.ApplicationTargetGroupSpec2)**

Required field. Basic properties of the Application Load Balancer target group attributed to the instance group. ||
|| maxOpeningTrafficDuration | **string** (duration)

Timeout for waiting for the VM to be checked by the load balancer. If the timeout is exceeded,
the VM will be turned off based on the deployment policy. Specified in seconds. ||
|| ignoreHealthChecks | **boolean**

Do not wait load balancer health checks. ||
|#

## ApplicationTargetGroupSpec {#yandex.cloud.compute.v1.instancegroup.ApplicationTargetGroupSpec2}

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
|| targetGroupId | **string**

ID of the Application Load Balancer target group attributed to the instance group. ||
|| statusMessage | **string**

Status message of the target group. ||
|#

## AutoHealingPolicy {#yandex.cloud.compute.v1.instancegroup.AutoHealingPolicy2}

#|
||Field | Description ||
|| autoHealingAction | **enum** (AutoHealingAction)

Instance Groups performs `autoHealingAction` when instance becomes unhealthy.

- `AUTO_HEALING_ACTION_UNSPECIFIED`
- `RESTART`: Re-starting an instance with restart: stopping and then starting the instance.
- `RECREATE`: Re-creating an instance: deleting an instance and creating a new one.
- `NONE`: No action ||
|#