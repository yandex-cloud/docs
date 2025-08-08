---
editable: false
apiPlayground:
  - url: https://mks.{{ api-host }}/managed-kubernetes/v1/nodeGroups/{nodeGroupId}
    method: patch
    path:
      type: object
      properties:
        nodeGroupId:
          description: |-
            **string**
            Required field. ID of the node group to update.
            To get the node group ID use a [NodeGroupService.List](/docs/managed-kubernetes/managed-kubernetes/api-ref/NodeGroup/list#List) request.
          type: string
      required:
        - nodeGroupId
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
            Name of the node group.
            The name must be unique within the folder.
          pattern: '|[a-z]([-a-z0-9]{0,61}[a-z0-9])?'
          type: string
        description:
          description: |-
            **string**
            Description of the node group.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Resource labels as `key:value` pairs.
            Existing set of `labels` is completely replaced by the provided set.
          pattern: '[a-z][-_./\@0-9a-z]*'
          type: string
        nodeTemplate:
          description: |-
            **[NodeTemplate](/docs/managed-kubernetes/managed-kubernetes/api-ref/Cluster/listNodeGroups#yandex.cloud.k8s.v1.NodeTemplate)**
            Node template for the node group.
            Change may trigger nodes rolling reboot or recreate.
          $ref: '#/definitions/NodeTemplate'
        scalePolicy:
          description: |-
            **[ScalePolicy](/docs/managed-kubernetes/managed-kubernetes/api-ref/Cluster/listNodeGroups#yandex.cloud.k8s.v1.ScalePolicy)**
            Scale policy of the node group.
          oneOf:
            - type: object
              properties:
                fixedScale:
                  description: |-
                    **[FixedScale](/docs/managed-kubernetes/managed-kubernetes/api-ref/Cluster/get#yandex.cloud.k8s.v1.MasterScalePolicy.FixedScale)**
                    Fixed scale policy of the node group.
                    Includes only one of the fields `fixedScale`, `autoScale`.
                  $ref: '#/definitions/FixedScale'
                autoScale:
                  description: |-
                    **[AutoScale](/docs/managed-kubernetes/managed-kubernetes/api-ref/Cluster/create#yandex.cloud.k8s.v1.MasterScalePolicySpec.AutoScale)**
                    Auto scale policy of the node group.
                    Includes only one of the fields `fixedScale`, `autoScale`.
                  $ref: '#/definitions/AutoScale'
        allocationPolicy:
          description: |-
            **[NodeGroupAllocationPolicy](/docs/managed-kubernetes/managed-kubernetes/api-ref/Cluster/listNodeGroups#yandex.cloud.k8s.v1.NodeGroupAllocationPolicy)**
            Allocation policy of the node group by the zones and regions.
          $ref: '#/definitions/NodeGroupAllocationPolicy'
        deployPolicy:
          description: |-
            **[DeployPolicy](/docs/managed-kubernetes/managed-kubernetes/api-ref/Cluster/listNodeGroups#yandex.cloud.k8s.v1.DeployPolicy)**
            Deploy policy according to which the updates are rolled out. If not specified,
            the default is used.
          $ref: '#/definitions/DeployPolicy'
        version:
          description: |-
            **[UpdateVersionSpec](/docs/managed-kubernetes/managed-kubernetes/api-ref/Cluster/update#yandex.cloud.k8s.v1.UpdateVersionSpec)**
            Version of Kubernetes components that runs on the nodes.
          oneOf:
            - type: object
              properties:
                version:
                  description: |-
                    **string**
                    Request update to a newer version of Kubernetes (1.x -> 1.y).
                    Includes only one of the fields `version`, `latestRevision`.
                  type: string
                latestRevision:
                  description: |-
                    **boolean**
                    Request update to the latest revision for the current version.
                    Includes only one of the fields `version`, `latestRevision`.
                  type: boolean
        maintenancePolicy:
          description: |-
            **[NodeGroupMaintenancePolicy](/docs/managed-kubernetes/managed-kubernetes/api-ref/Cluster/listNodeGroups#yandex.cloud.k8s.v1.NodeGroupMaintenancePolicy)**
            Maintenance policy of the node group.
          $ref: '#/definitions/NodeGroupMaintenancePolicy'
        allowedUnsafeSysctls:
          description: |-
            **string**
            Support for unsafe sysctl parameters. For more details see [documentation](https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/).
          pattern: ([a-z0-9]([-_a-z0-9]*[a-z0-9])?\.)*([a-z0-9][-_a-z0-9]*)?[a-z0-9*]
          type: array
          items:
            type: string
        nodeTaints:
          description: |-
            **[Taint](/docs/managed-kubernetes/managed-kubernetes/api-ref/Cluster/listNodeGroups#yandex.cloud.k8s.v1.Taint)**
            Taints that are applied to the nodes of the node group at creation time.
          type: array
          items:
            $ref: '#/definitions/Taint'
        nodeLabels:
          description: |-
            **object** (map<**string**, **string**>)
            Labels that are assigned to the nodes of the node group at creation time.
          type: string
      additionalProperties: false
    definitions:
      ResourcesSpec:
        type: object
        properties:
          memory:
            description: |-
              **string** (int64)
              Amount of memory available to the node, specified in bytes.
            type: string
            format: int64
          cores:
            description: |-
              **string** (int64)
              Number of cores available to the node.
            type: string
            format: int64
          coreFraction:
            description: |-
              **string** (int64)
              Baseline level of CPU performance with the possibility to burst performance above that baseline level.
              This field sets baseline performance for each core.
            type: string
            format: int64
          gpus:
            description: |-
              **string** (int64)
              Number of GPUs available to the node.
            type: string
            format: int64
      DiskSpec:
        type: object
        properties:
          diskTypeId:
            description: |-
              **string**
              ID of the disk type.
            pattern: '|network-ssd|network-hdd|network-ssd-nonreplicated|network-ssd-io-m3'
            type: string
          diskSize:
            description: |-
              **string** (int64)
              Size of the disk, specified in bytes.
            type: string
            format: int64
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
      DnsRecordSpec:
        type: object
        properties:
          fqdn:
            description: |-
              **string**
              Required field. FQDN (required).
            type: string
          dnsZoneId:
            description: |-
              **string**
              DNS zone id (optional, if not set, private zone is used).
            type: string
          ttl:
            description: |-
              **string** (int64)
              DNS record ttl, values in 0-86400 (optional).
            type: string
            format: int64
          ptr:
            description: |-
              **boolean**
              When set to true, also create PTR DNS record (optional).
            type: boolean
        required:
          - fqdn
      NodeAddressSpec:
        type: object
        properties:
          oneToOneNatSpec:
            description: |-
              **[OneToOneNatSpec](/docs/managed-kubernetes/managed-kubernetes/api-ref/Cluster/listNodeGroups#yandex.cloud.k8s.v1.OneToOneNatSpec)**
              One-to-one NAT configuration. Setting up one-to-one NAT ensures that public IP addresses are assigned to nodes, and therefore internet is accessible for all nodes of the node group. If the field is not set, NAT will not be set up.
            $ref: '#/definitions/OneToOneNatSpec'
          dnsRecordSpecs:
            description: |-
              **[DnsRecordSpec](/docs/managed-kubernetes/managed-kubernetes/api-ref/Cluster/listNodeGroups#yandex.cloud.k8s.v1.DnsRecordSpec)**
              Internal DNS configuration.
            type: array
            items:
              $ref: '#/definitions/DnsRecordSpec'
      SchedulingPolicy:
        type: object
        properties:
          preemptible:
            description: |-
              **boolean**
              True for preemptible compute instances. Default value is false. Preemptible compute instances are stopped at least once every 24 hours, and can be stopped at any time
              if their resources are needed by Compute.
              For more information, see [Preemptible Virtual Machines](/docs/compute/concepts/preemptible-vm).
            type: boolean
      NetworkInterfaceSpec:
        type: object
        properties:
          subnetIds:
            description: |-
              **string**
              IDs of the subnets.
            type: array
            items:
              type: string
          primaryV4AddressSpec:
            description: |-
              **[NodeAddressSpec](/docs/managed-kubernetes/managed-kubernetes/api-ref/Cluster/listNodeGroups#yandex.cloud.k8s.v1.NodeAddressSpec)**
              Primary IPv4 address that is assigned to the instance for this network interface.
            $ref: '#/definitions/NodeAddressSpec'
          primaryV6AddressSpec:
            description: |-
              **[NodeAddressSpec](/docs/managed-kubernetes/managed-kubernetes/api-ref/Cluster/listNodeGroups#yandex.cloud.k8s.v1.NodeAddressSpec)**
              Primary IPv6 address that is assigned to the instance for this network interface.
            $ref: '#/definitions/NodeAddressSpec'
          securityGroupIds:
            description: |-
              **string**
              IDs of security groups.
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
      NetworkSettings:
        type: object
        properties:
          type:
            description: |-
              **enum** (Type)
              Required field. 
              - `TYPE_UNSPECIFIED`
              - `STANDARD`
              - `SOFTWARE_ACCELERATED`
            type: string
            enum:
              - TYPE_UNSPECIFIED
              - STANDARD
              - SOFTWARE_ACCELERATED
        required:
          - type
      ContainerRuntimeSettings:
        type: object
        properties:
          type:
            description: |-
              **enum** (Type)
              Required field. 
              - `TYPE_UNSPECIFIED`
              - `STANDARD`
              - `SOFTWARE_ACCELERATED`
            type: string
            enum:
              - TYPE_UNSPECIFIED
              - STANDARD
              - SOFTWARE_ACCELERATED
        required:
          - type
      ContainerNetworkSettings:
        type: object
        properties:
          podMtu:
            description: '**string** (int64)'
            type: string
            format: int64
      GpuSettings:
        type: object
        properties:
          gpuClusterId:
            description: |-
              **string**
              GPU cluster id, that mk8s node will join.
            type: string
          gpuEnvironment:
            description: |-
              **enum** (GpuEnvironment)
              GPU environment configured on node.
              - `GPU_ENVIRONMENT_UNSPECIFIED`: Use one of the values below, depending on the default for the specific Cloud installation.
              - `RUNC_DRIVERS_CUDA`: Use a node image with the pre-installed GPU toolkit, drivers and CUDA.
              - `RUNC`: Use a node image with the pre-installed GPU toolkit but without drivers.
              You should install drivers on a node yourself in that case.
              There are tools to help you to do that, for example gpu-operator.
            type: string
            enum:
              - GPU_ENVIRONMENT_UNSPECIFIED
              - RUNC_DRIVERS_CUDA
              - RUNC
      NodeTemplate:
        type: object
        properties:
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
          labels:
            description: |-
              **object** (map<**string**, **string**>)
              these labels will be assigned to compute nodes (instances), created by the nodegroup
            pattern: '[a-z][-_./\@0-9a-z]*'
            type: string
          platformId:
            description: |-
              **string**
              ID of the hardware platform configuration for the node.
            type: string
          resourcesSpec:
            description: |-
              **[ResourcesSpec](/docs/managed-kubernetes/managed-kubernetes/api-ref/Cluster/listNodeGroups#yandex.cloud.k8s.v1.ResourcesSpec)**
              Computing resources of the node such as the amount of memory and number of cores.
            $ref: '#/definitions/ResourcesSpec'
          bootDiskSpec:
            description: |-
              **[DiskSpec](/docs/managed-kubernetes/managed-kubernetes/api-ref/Cluster/listNodeGroups#yandex.cloud.k8s.v1.DiskSpec)**
              Specification for the boot disk that will be attached to the node.
            $ref: '#/definitions/DiskSpec'
          metadata:
            description: |-
              **object** (map<**string**, **string**>)
              The metadata as `key:value` pairs assigned to this instance template. Only SSH keys are supported as metadata.
              For more information, see [Connecting to a node over SSH](/docs/managed-kubernetes/operations/node-connect-ssh).
            pattern: '[a-z][-_0-9a-z]*'
            type: string
          v4AddressSpec:
            description: |-
              **[NodeAddressSpec](/docs/managed-kubernetes/managed-kubernetes/api-ref/Cluster/listNodeGroups#yandex.cloud.k8s.v1.NodeAddressSpec)**
              Specification for the create network interfaces for the node group compute instances.
              Deprecated, please use network_interface_specs.
            deprecated: true
            $ref: '#/definitions/NodeAddressSpec'
          schedulingPolicy:
            description: |-
              **[SchedulingPolicy](/docs/managed-kubernetes/managed-kubernetes/api-ref/Cluster/listNodeGroups#yandex.cloud.k8s.v1.SchedulingPolicy)**
              Scheduling policy configuration.
            $ref: '#/definitions/SchedulingPolicy'
          networkInterfaceSpecs:
            description: |-
              **[NetworkInterfaceSpec](/docs/managed-kubernetes/managed-kubernetes/api-ref/Cluster/listNodeGroups#yandex.cloud.k8s.v1.NetworkInterfaceSpec)**
              New api, to specify network interfaces for the node group compute instances.
              Can not be used together with 'v4_address_spec'
            type: array
            items:
              $ref: '#/definitions/NetworkInterfaceSpec'
          placementPolicy:
            description: '**[PlacementPolicy](/docs/managed-kubernetes/managed-kubernetes/api-ref/Cluster/listNodeGroups#yandex.cloud.k8s.v1.PlacementPolicy)**'
            $ref: '#/definitions/PlacementPolicy'
          networkSettings:
            description: |-
              **[NetworkSettings](/docs/managed-kubernetes/managed-kubernetes/api-ref/Cluster/listNodeGroups#yandex.cloud.k8s.v1.NodeTemplate.NetworkSettings)**
              this parameter allows to specify type of network acceleration used on nodes (instances)
            $ref: '#/definitions/NetworkSettings'
          containerRuntimeSettings:
            description: '**[ContainerRuntimeSettings](/docs/managed-kubernetes/managed-kubernetes/api-ref/Cluster/listNodeGroups#yandex.cloud.k8s.v1.NodeTemplate.ContainerRuntimeSettings)**'
            $ref: '#/definitions/ContainerRuntimeSettings'
          containerNetworkSettings:
            description: '**[ContainerNetworkSettings](/docs/managed-kubernetes/managed-kubernetes/api-ref/Cluster/listNodeGroups#yandex.cloud.k8s.v1.NodeTemplate.ContainerNetworkSettings)**'
            $ref: '#/definitions/ContainerNetworkSettings'
          gpuSettings:
            description: |-
              **[GpuSettings](/docs/managed-kubernetes/managed-kubernetes/api-ref/Cluster/listNodeGroups#yandex.cloud.k8s.v1.GpuSettings)**
              GPU settings
            $ref: '#/definitions/GpuSettings'
      FixedScale:
        type: object
        properties:
          resourcePresetId:
            description: |-
              **string**
              ID of computing resources preset to be used by master.
            type: string
      AutoScale:
        type: object
        properties:
          minResourcePresetId:
            description: |-
              **string**
              Required field. Preset of computing resources to be used as lower boundary for scaling.
            type: string
        required:
          - minResourcePresetId
      NodeGroupLocation:
        type: object
        properties:
          zoneId:
            description: |-
              **string**
              Required field. ID of the availability zone where the nodes may reside.
            type: string
          subnetId:
            description: |-
              **string**
              ID of the subnet. If a network chosen for the Kubernetes cluster has only one subnet in the specified zone, subnet ID may be omitted.
            type: string
        required:
          - zoneId
      NodeGroupAllocationPolicy:
        type: object
        properties:
          locations:
            description: |-
              **[NodeGroupLocation](/docs/managed-kubernetes/managed-kubernetes/api-ref/Cluster/listNodeGroups#yandex.cloud.k8s.v1.NodeGroupLocation)**
              List of locations where resources for the node group will be allocated.
            type: array
            items:
              $ref: '#/definitions/NodeGroupLocation'
      DeployPolicy:
        type: object
        properties:
          maxUnavailable:
            description: |-
              **string** (int64)
              The maximum number of running instances that can be taken offline (i.e.,
              stopped or deleted) at the same time during the update process.
              If [maxExpansion](/docs/managed-kubernetes/managed-kubernetes/api-ref/Cluster/listNodeGroups#yandex.cloud.k8s.v1.DeployPolicy) is not specified or set to zero, [maxUnavailable](/docs/managed-kubernetes/managed-kubernetes/api-ref/Cluster/listNodeGroups#yandex.cloud.k8s.v1.DeployPolicy) must
              be set to a non-zero value.
            type: string
            format: int64
          maxExpansion:
            description: |-
              **string** (int64)
              The maximum number of instances that can be temporarily allocated above
              the group's target size during the update process.
              If [maxUnavailable](/docs/managed-kubernetes/managed-kubernetes/api-ref/Cluster/listNodeGroups#yandex.cloud.k8s.v1.DeployPolicy) is not specified or set to zero, [maxExpansion](/docs/managed-kubernetes/managed-kubernetes/api-ref/Cluster/listNodeGroups#yandex.cloud.k8s.v1.DeployPolicy) must
              be set to a non-zero value.
            type: string
            format: int64
      AnytimeMaintenanceWindow:
        type: object
        properties: {}
      TimeOfDay:
        type: object
        properties:
          hours:
            description: |-
              **integer** (int32)
              Hours of day in 24 hour format. Should be from 0 to 23. An API may choose
              to allow the value "24:00:00" for scenarios like business closing time.
            type: integer
            format: int32
          minutes:
            description: |-
              **integer** (int32)
              Minutes of hour of day. Must be from 0 to 59.
            type: integer
            format: int32
          seconds:
            description: |-
              **integer** (int32)
              Seconds of minutes of the time. Must normally be from 0 to 59. An API may
              allow the value 60 if it allows leap-seconds.
            type: integer
            format: int32
          nanos:
            description: |-
              **integer** (int32)
              Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.
            type: integer
            format: int32
      DailyMaintenanceWindow:
        type: object
        properties:
          startTime:
            description: |-
              **`TimeOfDay`**
              Required field. Window start time, in the UTC timezone.
            $ref: '#/definitions/TimeOfDay'
          duration:
            description: |-
              **string** (duration)
              Window duration.
            type: string
            format: duration
        required:
          - startTime
      DaysOfWeekMaintenanceWindow:
        type: object
        properties:
          days:
            description: |-
              **enum** (DayOfWeek)
              Days of the week when automatic updates are allowed.
              - `DAY_OF_WEEK_UNSPECIFIED`: The unspecified day-of-week.
              - `MONDAY`: The day-of-week of Monday.
              - `TUESDAY`: The day-of-week of Tuesday.
              - `WEDNESDAY`: The day-of-week of Wednesday.
              - `THURSDAY`: The day-of-week of Thursday.
              - `FRIDAY`: The day-of-week of Friday.
              - `SATURDAY`: The day-of-week of Saturday.
              - `SUNDAY`: The day-of-week of Sunday.
            type: array
            items:
              type: string
              enum:
                - DAY_OF_WEEK_UNSPECIFIED
                - MONDAY
                - TUESDAY
                - WEDNESDAY
                - THURSDAY
                - FRIDAY
                - SATURDAY
                - SUNDAY
          startTime:
            description: |-
              **`TimeOfDay`**
              Required field. Window start time, in the UTC timezone.
            $ref: '#/definitions/TimeOfDay'
          duration:
            description: |-
              **string** (duration)
              Window duration.
            type: string
            format: duration
        required:
          - startTime
      WeeklyMaintenanceWindow:
        type: object
        properties:
          daysOfWeek:
            description: |-
              **[DaysOfWeekMaintenanceWindow](/docs/managed-kubernetes/managed-kubernetes/api-ref/Cluster/get#yandex.cloud.k8s.v1.DaysOfWeekMaintenanceWindow)**
              Days of the week and the maintenance window for these days when automatic updates are allowed.
            type: array
            items:
              $ref: '#/definitions/DaysOfWeekMaintenanceWindow'
      NodeGroupMaintenancePolicy:
        type: object
        properties:
          autoUpgrade:
            description: |-
              **boolean**
              If set to true, automatic updates are installed in the specified period of time with no interaction from the user.
              If set to false, automatic upgrades are disabled.
            type: boolean
          autoRepair:
            description: |-
              **boolean**
              If set to true, automatic repairs are enabled. Default value is false.
            type: boolean
          maintenanceWindow:
            description: |-
              **[MaintenanceWindow](/docs/managed-kubernetes/managed-kubernetes/api-ref/Cluster/get#yandex.cloud.k8s.v1.MaintenanceWindow)**
              Maintenance window settings. Update will start at the specified time and last no more than the specified duration.
              The time is set in UTC.
            oneOf:
              - type: object
                properties:
                  anytime:
                    description: |-
                      **object**
                      Updating the master at any time.
                      Includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`.
                      Maintenance policy.
                    $ref: '#/definitions/AnytimeMaintenanceWindow'
                  dailyMaintenanceWindow:
                    description: |-
                      **[DailyMaintenanceWindow](/docs/managed-kubernetes/managed-kubernetes/api-ref/Cluster/get#yandex.cloud.k8s.v1.DailyMaintenanceWindow)**
                      Updating the master on any day during the specified time window.
                      Includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`.
                      Maintenance policy.
                    $ref: '#/definitions/DailyMaintenanceWindow'
                  weeklyMaintenanceWindow:
                    description: |-
                      **[WeeklyMaintenanceWindow](/docs/managed-kubernetes/managed-kubernetes/api-ref/Cluster/get#yandex.cloud.k8s.v1.WeeklyMaintenanceWindow)**
                      Updating the master on selected days during the specified time window.
                      Includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`.
                      Maintenance policy.
                    $ref: '#/definitions/WeeklyMaintenanceWindow'
      Taint:
        type: object
        properties:
          key:
            description: |-
              **string**
              The taint key to be applied to a node.
            type: string
          value:
            description: |-
              **string**
              The taint value corresponding to the taint key.
            type: string
          effect:
            description: |-
              **enum** (Effect)
              The effect of the taint on pods that do not tolerate the taint.
              - `EFFECT_UNSPECIFIED`
              - `NO_SCHEDULE`: Do not allow new pods to schedule onto the node unless they tolerate the taint,
              but allow all pods submitted to Kubelet without going through the scheduler
              to start, and allow all already-running pods to continue running.
              - `PREFER_NO_SCHEDULE`: Like NO_SCHEDULE, but the scheduler tries not to schedule
              new pods onto the node, rather than prohibiting new pods from scheduling
              onto the node entirely. Enforced by the scheduler.
              - `NO_EXECUTE`: Evict any already-running pods that do not tolerate the taint.
            type: string
            enum:
              - EFFECT_UNSPECIFIED
              - NO_SCHEDULE
              - PREFER_NO_SCHEDULE
              - NO_EXECUTE
sourcePath: en/_api-ref/k8s/v1/managed-kubernetes/api-ref/NodeGroup/update.md
---

# Managed Services for Kubernetes API, REST: NodeGroup.Update

Updates the specified node group.

## HTTP request

```
PATCH https://mks.{{ api-host }}/managed-kubernetes/v1/nodeGroups/{nodeGroupId}
```

## Path parameters

#|
||Field | Description ||
|| nodeGroupId | **string**

Required field. ID of the node group to update.
To get the node group ID use a [NodeGroupService.List](/docs/managed-kubernetes/managed-kubernetes/api-ref/NodeGroup/list#List) request. ||
|#

## Body parameters {#yandex.cloud.k8s.v1.UpdateNodeGroupRequest}

```json
{
  "updateMask": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "nodeTemplate": {
    "name": "string",
    "labels": "object",
    "platformId": "string",
    "resourcesSpec": {
      "memory": "string",
      "cores": "string",
      "coreFraction": "string",
      "gpus": "string"
    },
    "bootDiskSpec": {
      "diskTypeId": "string",
      "diskSize": "string"
    },
    "metadata": "object",
    "v4AddressSpec": {
      "oneToOneNatSpec": {
        "ipVersion": "string"
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
    "schedulingPolicy": {
      "preemptible": "boolean"
    },
    "networkInterfaceSpecs": [
      {
        "subnetIds": [
          "string"
        ],
        "primaryV4AddressSpec": {
          "oneToOneNatSpec": {
            "ipVersion": "string"
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
          "oneToOneNatSpec": {
            "ipVersion": "string"
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
        ]
      }
    ],
    "placementPolicy": {
      "placementGroupId": "string"
    },
    "networkSettings": {
      "type": "string"
    },
    "containerRuntimeSettings": {
      "type": "string"
    },
    "containerNetworkSettings": {
      "podMtu": "string"
    },
    "gpuSettings": {
      "gpuClusterId": "string",
      "gpuEnvironment": "string"
    }
  },
  "scalePolicy": {
    // Includes only one of the fields `fixedScale`, `autoScale`
    "fixedScale": {
      "size": "string"
    },
    "autoScale": {
      "minSize": "string",
      "maxSize": "string",
      "initialSize": "string"
    }
    // end of the list of possible fields
  },
  "allocationPolicy": {
    "locations": [
      {
        "zoneId": "string",
        "subnetId": "string"
      }
    ]
  },
  "deployPolicy": {
    "maxUnavailable": "string",
    "maxExpansion": "string"
  },
  "version": {
    // Includes only one of the fields `version`, `latestRevision`
    "version": "string",
    "latestRevision": "boolean"
    // end of the list of possible fields
  },
  "maintenancePolicy": {
    "autoUpgrade": "boolean",
    "autoRepair": "boolean",
    "maintenanceWindow": {
      // Includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`
      "anytime": "object",
      "dailyMaintenanceWindow": {
        "startTime": {
          "hours": "integer",
          "minutes": "integer",
          "seconds": "integer",
          "nanos": "integer"
        },
        "duration": "string"
      },
      "weeklyMaintenanceWindow": {
        "daysOfWeek": [
          {
            "days": [
              "string"
            ],
            "startTime": {
              "hours": "integer",
              "minutes": "integer",
              "seconds": "integer",
              "nanos": "integer"
            },
            "duration": "string"
          }
        ]
      }
      // end of the list of possible fields
    }
  },
  "allowedUnsafeSysctls": [
    "string"
  ],
  "nodeTaints": [
    {
      "key": "string",
      "value": "string",
      "effect": "string"
    }
  ],
  "nodeLabels": "object"
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

Name of the node group.
The name must be unique within the folder. ||
|| description | **string**

Description of the node group. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.

Existing set of `labels` is completely replaced by the provided set. ||
|| nodeTemplate | **[NodeTemplate](#yandex.cloud.k8s.v1.NodeTemplate)**

Node template for the node group.
Change may trigger nodes rolling reboot or recreate. ||
|| scalePolicy | **[ScalePolicy](#yandex.cloud.k8s.v1.ScalePolicy)**

Scale policy of the node group. ||
|| allocationPolicy | **[NodeGroupAllocationPolicy](#yandex.cloud.k8s.v1.NodeGroupAllocationPolicy)**

Allocation policy of the node group by the zones and regions. ||
|| deployPolicy | **[DeployPolicy](#yandex.cloud.k8s.v1.DeployPolicy)**

Deploy policy according to which the updates are rolled out. If not specified,
the default is used. ||
|| version | **[UpdateVersionSpec](#yandex.cloud.k8s.v1.UpdateVersionSpec)**

Version of Kubernetes components that runs on the nodes. ||
|| maintenancePolicy | **[NodeGroupMaintenancePolicy](#yandex.cloud.k8s.v1.NodeGroupMaintenancePolicy)**

Maintenance policy of the node group. ||
|| allowedUnsafeSysctls[] | **string**

Support for unsafe sysctl parameters. For more details see [documentation](https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/). ||
|| nodeTaints[] | **[Taint](#yandex.cloud.k8s.v1.Taint)**

Taints that are applied to the nodes of the node group at creation time. ||
|| nodeLabels | **object** (map<**string**, **string**>)

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
|| labels | **object** (map<**string**, **string**>)

these labels will be assigned to compute nodes (instances), created by the nodegroup ||
|| platformId | **string**

ID of the hardware platform configuration for the node. ||
|| resourcesSpec | **[ResourcesSpec](#yandex.cloud.k8s.v1.ResourcesSpec)**

Computing resources of the node such as the amount of memory and number of cores. ||
|| bootDiskSpec | **[DiskSpec](#yandex.cloud.k8s.v1.DiskSpec)**

Specification for the boot disk that will be attached to the node. ||
|| metadata | **object** (map<**string**, **string**>)

The metadata as `key:value` pairs assigned to this instance template. Only SSH keys are supported as metadata.

For more information, see [Connecting to a node over SSH](/docs/managed-kubernetes/operations/node-connect-ssh). ||
|| v4AddressSpec | **[NodeAddressSpec](#yandex.cloud.k8s.v1.NodeAddressSpec)**

Specification for the create network interfaces for the node group compute instances.
Deprecated, please use network_interface_specs. ||
|| schedulingPolicy | **[SchedulingPolicy](#yandex.cloud.k8s.v1.SchedulingPolicy)**

Scheduling policy configuration. ||
|| networkInterfaceSpecs[] | **[NetworkInterfaceSpec](#yandex.cloud.k8s.v1.NetworkInterfaceSpec)**

New api, to specify network interfaces for the node group compute instances.
Can not be used together with 'v4_address_spec' ||
|| placementPolicy | **[PlacementPolicy](#yandex.cloud.k8s.v1.PlacementPolicy)** ||
|| networkSettings | **[NetworkSettings](#yandex.cloud.k8s.v1.NodeTemplate.NetworkSettings)**

this parameter allows to specify type of network acceleration used on nodes (instances) ||
|| containerRuntimeSettings | **[ContainerRuntimeSettings](#yandex.cloud.k8s.v1.NodeTemplate.ContainerRuntimeSettings)** ||
|| containerNetworkSettings | **[ContainerNetworkSettings](#yandex.cloud.k8s.v1.NodeTemplate.ContainerNetworkSettings)** ||
|| gpuSettings | **[GpuSettings](#yandex.cloud.k8s.v1.GpuSettings)**

GPU settings ||
|#

## ResourcesSpec {#yandex.cloud.k8s.v1.ResourcesSpec}

#|
||Field | Description ||
|| memory | **string** (int64)

Amount of memory available to the node, specified in bytes. ||
|| cores | **string** (int64)

Number of cores available to the node. ||
|| coreFraction | **string** (int64)

Baseline level of CPU performance with the possibility to burst performance above that baseline level.
This field sets baseline performance for each core. ||
|| gpus | **string** (int64)

Number of GPUs available to the node. ||
|#

## DiskSpec {#yandex.cloud.k8s.v1.DiskSpec}

#|
||Field | Description ||
|| diskTypeId | **string**

ID of the disk type. ||
|| diskSize | **string** (int64)

Size of the disk, specified in bytes. ||
|#

## NodeAddressSpec {#yandex.cloud.k8s.v1.NodeAddressSpec}

#|
||Field | Description ||
|| oneToOneNatSpec | **[OneToOneNatSpec](#yandex.cloud.k8s.v1.OneToOneNatSpec)**

One-to-one NAT configuration. Setting up one-to-one NAT ensures that public IP addresses are assigned to nodes, and therefore internet is accessible for all nodes of the node group. If the field is not set, NAT will not be set up. ||
|| dnsRecordSpecs[] | **[DnsRecordSpec](#yandex.cloud.k8s.v1.DnsRecordSpec)**

Internal DNS configuration. ||
|#

## OneToOneNatSpec {#yandex.cloud.k8s.v1.OneToOneNatSpec}

#|
||Field | Description ||
|| ipVersion | **enum** (IpVersion)

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
|| dnsZoneId | **string**

DNS zone id (optional, if not set, private zone is used). ||
|| ttl | **string** (int64)

DNS record ttl, values in 0-86400 (optional). ||
|| ptr | **boolean**

When set to true, also create PTR DNS record (optional). ||
|#

## SchedulingPolicy {#yandex.cloud.k8s.v1.SchedulingPolicy}

#|
||Field | Description ||
|| preemptible | **boolean**

True for preemptible compute instances. Default value is false. Preemptible compute instances are stopped at least once every 24 hours, and can be stopped at any time
if their resources are needed by Compute.
For more information, see [Preemptible Virtual Machines](/docs/compute/concepts/preemptible-vm). ||
|#

## NetworkInterfaceSpec {#yandex.cloud.k8s.v1.NetworkInterfaceSpec}

#|
||Field | Description ||
|| subnetIds[] | **string**

IDs of the subnets. ||
|| primaryV4AddressSpec | **[NodeAddressSpec](#yandex.cloud.k8s.v1.NodeAddressSpec)**

Primary IPv4 address that is assigned to the instance for this network interface. ||
|| primaryV6AddressSpec | **[NodeAddressSpec](#yandex.cloud.k8s.v1.NodeAddressSpec)**

Primary IPv6 address that is assigned to the instance for this network interface. ||
|| securityGroupIds[] | **string**

IDs of security groups. ||
|#

## PlacementPolicy {#yandex.cloud.k8s.v1.PlacementPolicy}

#|
||Field | Description ||
|| placementGroupId | **string**

Identifier of placement group ||
|#

## NetworkSettings {#yandex.cloud.k8s.v1.NodeTemplate.NetworkSettings}

#|
||Field | Description ||
|| type | **enum** (Type)

Required field. 

- `TYPE_UNSPECIFIED`
- `STANDARD`
- `SOFTWARE_ACCELERATED` ||
|#

## ContainerRuntimeSettings {#yandex.cloud.k8s.v1.NodeTemplate.ContainerRuntimeSettings}

#|
||Field | Description ||
|| type | **enum** (Type)

Required field. 

- `TYPE_UNSPECIFIED`
- `DOCKER`
- `CONTAINERD` ||
|#

## ContainerNetworkSettings {#yandex.cloud.k8s.v1.NodeTemplate.ContainerNetworkSettings}

#|
||Field | Description ||
|| podMtu | **string** (int64) ||
|#

## GpuSettings {#yandex.cloud.k8s.v1.GpuSettings}

#|
||Field | Description ||
|| gpuClusterId | **string**

GPU cluster id, that mk8s node will join. ||
|| gpuEnvironment | **enum** (GpuEnvironment)

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
|| fixedScale | **[FixedScale](#yandex.cloud.k8s.v1.ScalePolicy.FixedScale)**

Fixed scale policy of the node group.

Includes only one of the fields `fixedScale`, `autoScale`. ||
|| autoScale | **[AutoScale](#yandex.cloud.k8s.v1.ScalePolicy.AutoScale)**

Auto scale policy of the node group.

Includes only one of the fields `fixedScale`, `autoScale`. ||
|#

## FixedScale {#yandex.cloud.k8s.v1.ScalePolicy.FixedScale}

#|
||Field | Description ||
|| size | **string** (int64)

Number of nodes in the node group. ||
|#

## AutoScale {#yandex.cloud.k8s.v1.ScalePolicy.AutoScale}

#|
||Field | Description ||
|| minSize | **string** (int64)

Minimum number of nodes in the node group. ||
|| maxSize | **string** (int64)

Maximum number of nodes in the node group. ||
|| initialSize | **string** (int64)

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
|| zoneId | **string**

Required field. ID of the availability zone where the nodes may reside. ||
|| subnetId | **string**

ID of the subnet. If a network chosen for the Kubernetes cluster has only one subnet in the specified zone, subnet ID may be omitted. ||
|#

## DeployPolicy {#yandex.cloud.k8s.v1.DeployPolicy}

#|
||Field | Description ||
|| maxUnavailable | **string** (int64)

The maximum number of running instances that can be taken offline (i.e.,
stopped or deleted) at the same time during the update process.
If `maxExpansion` is not specified or set to zero, `maxUnavailable` must
be set to a non-zero value. ||
|| maxExpansion | **string** (int64)

The maximum number of instances that can be temporarily allocated above
the group's target size during the update process.
If `maxUnavailable` is not specified or set to zero, `maxExpansion` must
be set to a non-zero value. ||
|#

## UpdateVersionSpec {#yandex.cloud.k8s.v1.UpdateVersionSpec}

#|
||Field | Description ||
|| version | **string**

Request update to a newer version of Kubernetes (1.x -> 1.y).

Includes only one of the fields `version`, `latestRevision`. ||
|| latestRevision | **boolean**

Request update to the latest revision for the current version.

Includes only one of the fields `version`, `latestRevision`. ||
|#

## NodeGroupMaintenancePolicy {#yandex.cloud.k8s.v1.NodeGroupMaintenancePolicy}

#|
||Field | Description ||
|| autoUpgrade | **boolean**

If set to true, automatic updates are installed in the specified period of time with no interaction from the user.
If set to false, automatic upgrades are disabled. ||
|| autoRepair | **boolean**

If set to true, automatic repairs are enabled. Default value is false. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.k8s.v1.MaintenanceWindow)**

Maintenance window settings. Update will start at the specified time and last no more than the specified duration.
The time is set in UTC. ||
|#

## MaintenanceWindow {#yandex.cloud.k8s.v1.MaintenanceWindow}

#|
||Field | Description ||
|| anytime | **object**

Updating the master at any time.

Includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`.

Maintenance policy. ||
|| dailyMaintenanceWindow | **[DailyMaintenanceWindow](#yandex.cloud.k8s.v1.DailyMaintenanceWindow)**

Updating the master on any day during the specified time window.

Includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`.

Maintenance policy. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.k8s.v1.WeeklyMaintenanceWindow)**

Updating the master on selected days during the specified time window.

Includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`.

Maintenance policy. ||
|#

## DailyMaintenanceWindow {#yandex.cloud.k8s.v1.DailyMaintenanceWindow}

#|
||Field | Description ||
|| startTime | **[TimeOfDay](#google.type.TimeOfDay)**

Required field. Window start time, in the UTC timezone. ||
|| duration | **string** (duration)

Window duration. ||
|#

## TimeOfDay {#google.type.TimeOfDay}

Represents a time of day. The date and time zone are either not significant
or are specified elsewhere. An API may choose to allow leap seconds. Related
types are [google.type.Date](https://github.com/googleapis/googleapis/blob/master/google/type/date.proto) and [google.protobuf.Timestamp](https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto).

#|
||Field | Description ||
|| hours | **integer** (int32)

Hours of day in 24 hour format. Should be from 0 to 23. An API may choose
to allow the value "24:00:00" for scenarios like business closing time. ||
|| minutes | **integer** (int32)

Minutes of hour of day. Must be from 0 to 59. ||
|| seconds | **integer** (int32)

Seconds of minutes of the time. Must normally be from 0 to 59. An API may
allow the value 60 if it allows leap-seconds. ||
|| nanos | **integer** (int32)

Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.k8s.v1.WeeklyMaintenanceWindow}

#|
||Field | Description ||
|| daysOfWeek[] | **[DaysOfWeekMaintenanceWindow](#yandex.cloud.k8s.v1.DaysOfWeekMaintenanceWindow)**

Days of the week and the maintenance window for these days when automatic updates are allowed. ||
|#

## DaysOfWeekMaintenanceWindow {#yandex.cloud.k8s.v1.DaysOfWeekMaintenanceWindow}

#|
||Field | Description ||
|| days[] | **enum** (DayOfWeek)

Days of the week when automatic updates are allowed.

- `DAY_OF_WEEK_UNSPECIFIED`: The unspecified day-of-week.
- `MONDAY`: The day-of-week of Monday.
- `TUESDAY`: The day-of-week of Tuesday.
- `WEDNESDAY`: The day-of-week of Wednesday.
- `THURSDAY`: The day-of-week of Thursday.
- `FRIDAY`: The day-of-week of Friday.
- `SATURDAY`: The day-of-week of Saturday.
- `SUNDAY`: The day-of-week of Sunday. ||
|| startTime | **[TimeOfDay](#google.type.TimeOfDay)**

Required field. Window start time, in the UTC timezone. ||
|| duration | **string** (duration)

Window duration. ||
|#

## Taint {#yandex.cloud.k8s.v1.Taint}

#|
||Field | Description ||
|| key | **string**

The taint key to be applied to a node. ||
|| value | **string**

The taint value corresponding to the taint key. ||
|| effect | **enum** (Effect)

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
    "nodeGroupId": "string"
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
    "clusterId": "string",
    "createdAt": "string",
    "name": "string",
    "description": "string",
    "labels": "object",
    "status": "string",
    "nodeTemplate": {
      "name": "string",
      "labels": "object",
      "platformId": "string",
      "resourcesSpec": {
        "memory": "string",
        "cores": "string",
        "coreFraction": "string",
        "gpus": "string"
      },
      "bootDiskSpec": {
        "diskTypeId": "string",
        "diskSize": "string"
      },
      "metadata": "object",
      "v4AddressSpec": {
        "oneToOneNatSpec": {
          "ipVersion": "string"
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
      "schedulingPolicy": {
        "preemptible": "boolean"
      },
      "networkInterfaceSpecs": [
        {
          "subnetIds": [
            "string"
          ],
          "primaryV4AddressSpec": {
            "oneToOneNatSpec": {
              "ipVersion": "string"
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
            "oneToOneNatSpec": {
              "ipVersion": "string"
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
          ]
        }
      ],
      "placementPolicy": {
        "placementGroupId": "string"
      },
      "networkSettings": {
        "type": "string"
      },
      "containerRuntimeSettings": {
        "type": "string"
      },
      "containerNetworkSettings": {
        "podMtu": "string"
      },
      "gpuSettings": {
        "gpuClusterId": "string",
        "gpuEnvironment": "string"
      }
    },
    "scalePolicy": {
      // Includes only one of the fields `fixedScale`, `autoScale`
      "fixedScale": {
        "size": "string"
      },
      "autoScale": {
        "minSize": "string",
        "maxSize": "string",
        "initialSize": "string"
      }
      // end of the list of possible fields
    },
    "allocationPolicy": {
      "locations": [
        {
          "zoneId": "string",
          "subnetId": "string"
        }
      ]
    },
    "deployPolicy": {
      "maxUnavailable": "string",
      "maxExpansion": "string"
    },
    "instanceGroupId": "string",
    "nodeVersion": "string",
    "versionInfo": {
      "currentVersion": "string",
      "newRevisionAvailable": "boolean",
      "newRevisionSummary": "string",
      "versionDeprecated": "boolean"
    },
    "maintenancePolicy": {
      "autoUpgrade": "boolean",
      "autoRepair": "boolean",
      "maintenanceWindow": {
        // Includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`
        "anytime": "object",
        "dailyMaintenanceWindow": {
          "startTime": {
            "hours": "integer",
            "minutes": "integer",
            "seconds": "integer",
            "nanos": "integer"
          },
          "duration": "string"
        },
        "weeklyMaintenanceWindow": {
          "daysOfWeek": [
            {
              "days": [
                "string"
              ],
              "startTime": {
                "hours": "integer",
                "minutes": "integer",
                "seconds": "integer",
                "nanos": "integer"
              },
              "duration": "string"
            }
          ]
        }
        // end of the list of possible fields
      }
    },
    "allowedUnsafeSysctls": [
      "string"
    ],
    "nodeTaints": [
      {
        "key": "string",
        "value": "string",
        "effect": "string"
      }
    ],
    "nodeLabels": "object"
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
|| metadata | **[UpdateNodeGroupMetadata](#yandex.cloud.k8s.v1.UpdateNodeGroupMetadata)**

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
|| nodeGroupId | **string**

Required field. ID of the Node group that is being updated. ||
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

## NodeGroup {#yandex.cloud.k8s.v1.NodeGroup}

#|
||Field | Description ||
|| id | **string**

ID of the node group. ||
|| clusterId | **string**

ID of the cluster that the node group belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the node group.
The name is unique within the folder. ||
|| description | **string**

Description of the node group. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. Maximum of 64 per resource. ||
|| status | **enum** (Status)

Status of the node group.

- `STATUS_UNSPECIFIED`
- `PROVISIONING`: Node group is waiting for resources to be allocated.
- `RUNNING`: Node group is running.
- `RECONCILING`: Node group is waiting for some work to be done, such as upgrading node software.
- `STOPPING`: Node group is being stopped.
- `STOPPED`: Node group stopped.
- `DELETING`: Node group is being deleted.
- `STARTING`: Node group is being started. ||
|| nodeTemplate | **[NodeTemplate](#yandex.cloud.k8s.v1.NodeTemplate2)**

Node template that specifies parameters of the compute instances for the node group. ||
|| scalePolicy | **[ScalePolicy](#yandex.cloud.k8s.v1.ScalePolicy2)**

Scale policy of the node group.  For more information, see [Scaling policy](/docs/compute/concepts/instance-groups/policies#scale-policy). ||
|| allocationPolicy | **[NodeGroupAllocationPolicy](#yandex.cloud.k8s.v1.NodeGroupAllocationPolicy2)**

Allocation policy by which resources for node group are allocated to zones and regions. ||
|| deployPolicy | **[DeployPolicy](#yandex.cloud.k8s.v1.DeployPolicy2)**

Deploy policy according to which the updates are rolled out. ||
|| instanceGroupId | **string**

ID of the managed instance group associated with this node group. ||
|| nodeVersion | **string**

Version of Kubernetes components that runs on the nodes.
Deprecated. Use version_info.current_version. ||
|| versionInfo | **[VersionInfo](#yandex.cloud.k8s.v1.VersionInfo)**

Detailed information about the Kubernetes version that is running on the node. ||
|| maintenancePolicy | **[NodeGroupMaintenancePolicy](#yandex.cloud.k8s.v1.NodeGroupMaintenancePolicy2)**

Maintenance policy of the node group. ||
|| allowedUnsafeSysctls[] | **string**

Support for unsafe sysctl parameters. For more details see [documentation](https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/). ||
|| nodeTaints[] | **[Taint](#yandex.cloud.k8s.v1.Taint2)**

Taints that are applied to the nodes of the node group at creation time. ||
|| nodeLabels | **object** (map<**string**, **string**>)

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
|| labels | **object** (map<**string**, **string**>)

these labels will be assigned to compute nodes (instances), created by the nodegroup ||
|| platformId | **string**

ID of the hardware platform configuration for the node. ||
|| resourcesSpec | **[ResourcesSpec](#yandex.cloud.k8s.v1.ResourcesSpec2)**

Computing resources of the node such as the amount of memory and number of cores. ||
|| bootDiskSpec | **[DiskSpec](#yandex.cloud.k8s.v1.DiskSpec2)**

Specification for the boot disk that will be attached to the node. ||
|| metadata | **object** (map<**string**, **string**>)

The metadata as `key:value` pairs assigned to this instance template. Only SSH keys are supported as metadata.

For more information, see [Connecting to a node over SSH](/docs/managed-kubernetes/operations/node-connect-ssh). ||
|| v4AddressSpec | **[NodeAddressSpec](#yandex.cloud.k8s.v1.NodeAddressSpec2)**

Specification for the create network interfaces for the node group compute instances.
Deprecated, please use network_interface_specs. ||
|| schedulingPolicy | **[SchedulingPolicy](#yandex.cloud.k8s.v1.SchedulingPolicy2)**

Scheduling policy configuration. ||
|| networkInterfaceSpecs[] | **[NetworkInterfaceSpec](#yandex.cloud.k8s.v1.NetworkInterfaceSpec2)**

New api, to specify network interfaces for the node group compute instances.
Can not be used together with 'v4_address_spec' ||
|| placementPolicy | **[PlacementPolicy](#yandex.cloud.k8s.v1.PlacementPolicy2)** ||
|| networkSettings | **[NetworkSettings](#yandex.cloud.k8s.v1.NodeTemplate.NetworkSettings2)**

this parameter allows to specify type of network acceleration used on nodes (instances) ||
|| containerRuntimeSettings | **[ContainerRuntimeSettings](#yandex.cloud.k8s.v1.NodeTemplate.ContainerRuntimeSettings2)** ||
|| containerNetworkSettings | **[ContainerNetworkSettings](#yandex.cloud.k8s.v1.NodeTemplate.ContainerNetworkSettings2)** ||
|| gpuSettings | **[GpuSettings](#yandex.cloud.k8s.v1.GpuSettings2)**

GPU settings ||
|#

## ResourcesSpec {#yandex.cloud.k8s.v1.ResourcesSpec2}

#|
||Field | Description ||
|| memory | **string** (int64)

Amount of memory available to the node, specified in bytes. ||
|| cores | **string** (int64)

Number of cores available to the node. ||
|| coreFraction | **string** (int64)

Baseline level of CPU performance with the possibility to burst performance above that baseline level.
This field sets baseline performance for each core. ||
|| gpus | **string** (int64)

Number of GPUs available to the node. ||
|#

## DiskSpec {#yandex.cloud.k8s.v1.DiskSpec2}

#|
||Field | Description ||
|| diskTypeId | **string**

ID of the disk type. ||
|| diskSize | **string** (int64)

Size of the disk, specified in bytes. ||
|#

## NodeAddressSpec {#yandex.cloud.k8s.v1.NodeAddressSpec2}

#|
||Field | Description ||
|| oneToOneNatSpec | **[OneToOneNatSpec](#yandex.cloud.k8s.v1.OneToOneNatSpec2)**

One-to-one NAT configuration. Setting up one-to-one NAT ensures that public IP addresses are assigned to nodes, and therefore internet is accessible for all nodes of the node group. If the field is not set, NAT will not be set up. ||
|| dnsRecordSpecs[] | **[DnsRecordSpec](#yandex.cloud.k8s.v1.DnsRecordSpec2)**

Internal DNS configuration. ||
|#

## OneToOneNatSpec {#yandex.cloud.k8s.v1.OneToOneNatSpec2}

#|
||Field | Description ||
|| ipVersion | **enum** (IpVersion)

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
|| dnsZoneId | **string**

DNS zone id (optional, if not set, private zone is used). ||
|| ttl | **string** (int64)

DNS record ttl, values in 0-86400 (optional). ||
|| ptr | **boolean**

When set to true, also create PTR DNS record (optional). ||
|#

## SchedulingPolicy {#yandex.cloud.k8s.v1.SchedulingPolicy2}

#|
||Field | Description ||
|| preemptible | **boolean**

True for preemptible compute instances. Default value is false. Preemptible compute instances are stopped at least once every 24 hours, and can be stopped at any time
if their resources are needed by Compute.
For more information, see [Preemptible Virtual Machines](/docs/compute/concepts/preemptible-vm). ||
|#

## NetworkInterfaceSpec {#yandex.cloud.k8s.v1.NetworkInterfaceSpec2}

#|
||Field | Description ||
|| subnetIds[] | **string**

IDs of the subnets. ||
|| primaryV4AddressSpec | **[NodeAddressSpec](#yandex.cloud.k8s.v1.NodeAddressSpec2)**

Primary IPv4 address that is assigned to the instance for this network interface. ||
|| primaryV6AddressSpec | **[NodeAddressSpec](#yandex.cloud.k8s.v1.NodeAddressSpec2)**

Primary IPv6 address that is assigned to the instance for this network interface. ||
|| securityGroupIds[] | **string**

IDs of security groups. ||
|#

## PlacementPolicy {#yandex.cloud.k8s.v1.PlacementPolicy2}

#|
||Field | Description ||
|| placementGroupId | **string**

Identifier of placement group ||
|#

## NetworkSettings {#yandex.cloud.k8s.v1.NodeTemplate.NetworkSettings2}

#|
||Field | Description ||
|| type | **enum** (Type)

Required field. 

- `TYPE_UNSPECIFIED`
- `STANDARD`
- `SOFTWARE_ACCELERATED` ||
|#

## ContainerRuntimeSettings {#yandex.cloud.k8s.v1.NodeTemplate.ContainerRuntimeSettings2}

#|
||Field | Description ||
|| type | **enum** (Type)

Required field. 

- `TYPE_UNSPECIFIED`
- `DOCKER`
- `CONTAINERD` ||
|#

## ContainerNetworkSettings {#yandex.cloud.k8s.v1.NodeTemplate.ContainerNetworkSettings2}

#|
||Field | Description ||
|| podMtu | **string** (int64) ||
|#

## GpuSettings {#yandex.cloud.k8s.v1.GpuSettings2}

#|
||Field | Description ||
|| gpuClusterId | **string**

GPU cluster id, that mk8s node will join. ||
|| gpuEnvironment | **enum** (GpuEnvironment)

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
|| fixedScale | **[FixedScale](#yandex.cloud.k8s.v1.ScalePolicy.FixedScale2)**

Fixed scale policy of the node group.

Includes only one of the fields `fixedScale`, `autoScale`. ||
|| autoScale | **[AutoScale](#yandex.cloud.k8s.v1.ScalePolicy.AutoScale2)**

Auto scale policy of the node group.

Includes only one of the fields `fixedScale`, `autoScale`. ||
|#

## FixedScale {#yandex.cloud.k8s.v1.ScalePolicy.FixedScale2}

#|
||Field | Description ||
|| size | **string** (int64)

Number of nodes in the node group. ||
|#

## AutoScale {#yandex.cloud.k8s.v1.ScalePolicy.AutoScale2}

#|
||Field | Description ||
|| minSize | **string** (int64)

Minimum number of nodes in the node group. ||
|| maxSize | **string** (int64)

Maximum number of nodes in the node group. ||
|| initialSize | **string** (int64)

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
|| zoneId | **string**

Required field. ID of the availability zone where the nodes may reside. ||
|| subnetId | **string**

ID of the subnet. If a network chosen for the Kubernetes cluster has only one subnet in the specified zone, subnet ID may be omitted. ||
|#

## DeployPolicy {#yandex.cloud.k8s.v1.DeployPolicy2}

#|
||Field | Description ||
|| maxUnavailable | **string** (int64)

The maximum number of running instances that can be taken offline (i.e.,
stopped or deleted) at the same time during the update process.
If `maxExpansion` is not specified or set to zero, `maxUnavailable` must
be set to a non-zero value. ||
|| maxExpansion | **string** (int64)

The maximum number of instances that can be temporarily allocated above
the group's target size during the update process.
If `maxUnavailable` is not specified or set to zero, `maxExpansion` must
be set to a non-zero value. ||
|#

## VersionInfo {#yandex.cloud.k8s.v1.VersionInfo}

#|
||Field | Description ||
|| currentVersion | **string**

Current Kubernetes version, format: major.minor (e.g. 1.15). ||
|| newRevisionAvailable | **boolean**

Newer revisions may include Kubernetes patches (e.g 1.15.1 -> 1.15.2) as well
as some internal component updates - new features or bug fixes in platform specific
components either on the master or nodes. ||
|| newRevisionSummary | **string**

Description of the changes to be applied when updating to the latest
revision. Empty if new_revision_available is false. ||
|| versionDeprecated | **boolean**

The current version is on the deprecation schedule, component (master or node group)
should be upgraded. ||
|#

## NodeGroupMaintenancePolicy {#yandex.cloud.k8s.v1.NodeGroupMaintenancePolicy2}

#|
||Field | Description ||
|| autoUpgrade | **boolean**

If set to true, automatic updates are installed in the specified period of time with no interaction from the user.
If set to false, automatic upgrades are disabled. ||
|| autoRepair | **boolean**

If set to true, automatic repairs are enabled. Default value is false. ||
|| maintenanceWindow | **[MaintenanceWindow](#yandex.cloud.k8s.v1.MaintenanceWindow2)**

Maintenance window settings. Update will start at the specified time and last no more than the specified duration.
The time is set in UTC. ||
|#

## MaintenanceWindow {#yandex.cloud.k8s.v1.MaintenanceWindow2}

#|
||Field | Description ||
|| anytime | **object**

Updating the master at any time.

Includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`.

Maintenance policy. ||
|| dailyMaintenanceWindow | **[DailyMaintenanceWindow](#yandex.cloud.k8s.v1.DailyMaintenanceWindow2)**

Updating the master on any day during the specified time window.

Includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`.

Maintenance policy. ||
|| weeklyMaintenanceWindow | **[WeeklyMaintenanceWindow](#yandex.cloud.k8s.v1.WeeklyMaintenanceWindow2)**

Updating the master on selected days during the specified time window.

Includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`.

Maintenance policy. ||
|#

## DailyMaintenanceWindow {#yandex.cloud.k8s.v1.DailyMaintenanceWindow2}

#|
||Field | Description ||
|| startTime | **[TimeOfDay](#google.type.TimeOfDay2)**

Required field. Window start time, in the UTC timezone. ||
|| duration | **string** (duration)

Window duration. ||
|#

## TimeOfDay {#google.type.TimeOfDay2}

Represents a time of day. The date and time zone are either not significant
or are specified elsewhere. An API may choose to allow leap seconds. Related
types are [google.type.Date](https://github.com/googleapis/googleapis/blob/master/google/type/date.proto) and [google.protobuf.Timestamp](https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto).

#|
||Field | Description ||
|| hours | **integer** (int32)

Hours of day in 24 hour format. Should be from 0 to 23. An API may choose
to allow the value "24:00:00" for scenarios like business closing time. ||
|| minutes | **integer** (int32)

Minutes of hour of day. Must be from 0 to 59. ||
|| seconds | **integer** (int32)

Seconds of minutes of the time. Must normally be from 0 to 59. An API may
allow the value 60 if it allows leap-seconds. ||
|| nanos | **integer** (int32)

Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.k8s.v1.WeeklyMaintenanceWindow2}

#|
||Field | Description ||
|| daysOfWeek[] | **[DaysOfWeekMaintenanceWindow](#yandex.cloud.k8s.v1.DaysOfWeekMaintenanceWindow2)**

Days of the week and the maintenance window for these days when automatic updates are allowed. ||
|#

## DaysOfWeekMaintenanceWindow {#yandex.cloud.k8s.v1.DaysOfWeekMaintenanceWindow2}

#|
||Field | Description ||
|| days[] | **enum** (DayOfWeek)

Days of the week when automatic updates are allowed.

- `DAY_OF_WEEK_UNSPECIFIED`: The unspecified day-of-week.
- `MONDAY`: The day-of-week of Monday.
- `TUESDAY`: The day-of-week of Tuesday.
- `WEDNESDAY`: The day-of-week of Wednesday.
- `THURSDAY`: The day-of-week of Thursday.
- `FRIDAY`: The day-of-week of Friday.
- `SATURDAY`: The day-of-week of Saturday.
- `SUNDAY`: The day-of-week of Sunday. ||
|| startTime | **[TimeOfDay](#google.type.TimeOfDay2)**

Required field. Window start time, in the UTC timezone. ||
|| duration | **string** (duration)

Window duration. ||
|#

## Taint {#yandex.cloud.k8s.v1.Taint2}

#|
||Field | Description ||
|| key | **string**

The taint key to be applied to a node. ||
|| value | **string**

The taint value corresponding to the taint key. ||
|| effect | **enum** (Effect)

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