---
editable: false
apiPlayground:
  - url: https://mks.{{ api-host }}/managed-kubernetes/v1/clusters
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. ID of the folder to create a Kubernetes cluster in.
            To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.
          type: string
        name:
          description: |-
            **string**
            Name of the Kubernetes cluster.
            The name must be unique within the folder.
            Value must match the regular expression ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
          pattern: '|[a-z]([-a-z0-9]{0,61}[a-z0-9])?'
          type: string
        description:
          description: |-
            **string**
            Description of the Kubernetes cluster.
            The maximum string length in characters is 256.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Resource labels as `key:value` pairs.
            The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource.
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
        networkId:
          description: |-
            **string**
            ID of the network.
            This field is required.
          type: string
        masterSpec:
          description: |-
            **[MasterSpec](#yandex.cloud.k8s.v1.MasterSpec)**
            Required field. Master specification of the Kubernetes cluster.
          $ref: '#/definitions/MasterSpec'
        ipAllocationPolicy:
          description: |-
            **[IPAllocationPolicy](#yandex.cloud.k8s.v1.IPAllocationPolicy)**
            IP allocation policy of the Kubernetes cluster.
          $ref: '#/definitions/IPAllocationPolicy'
        gatewayIpv4Address:
          description: |-
            **string**
            Gateway IPv4 address.
            The maximum string length in characters is 15.
            Includes only one of the fields `gatewayIpv4Address`.
          type: string
        serviceAccountId:
          description: |-
            **string**
            Required field. Service account to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster.
            Selected service account should have `edit` role on the folder where the Kubernetes cluster will be
            located and on the folder where selected network resides.
          type: string
        nodeServiceAccountId:
          description: |-
            **string**
            Required field. Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics.
          type: string
        releaseChannel:
          description: |-
            **enum** (ReleaseChannel)
            Release channel for the master.
            - `RAPID`: Minor updates with new functions and improvements are often added.
            You can't disable automatic updates in this channel, but you can specify a time period for automatic updates.
            - `REGULAR`: New functions and improvements are added in chunks shortly after they appear on `RAPID`.
            - `STABLE`: Only updates related to bug fixes or security improvements are added.
          type: string
          enum:
            - RELEASE_CHANNEL_UNSPECIFIED
            - RAPID
            - REGULAR
            - STABLE
        networkPolicy:
          description: '**[NetworkPolicy](#yandex.cloud.k8s.v1.NetworkPolicy)**'
          $ref: '#/definitions/NetworkPolicy'
        kmsProvider:
          description: |-
            **[KMSProvider](#yandex.cloud.k8s.v1.KMSProvider)**
            KMS provider configuration.
          $ref: '#/definitions/KMSProvider'
        cilium:
          description: |-
            **[Cilium](#yandex.cloud.k8s.v1.Cilium)**
            Includes only one of the fields `cilium`.
          $ref: '#/definitions/Cilium'
        workloadIdentityFederation:
          description: '**[WorkloadIdentityFederationSpec](#yandex.cloud.k8s.v1.WorkloadIdentityFederationSpec)**'
          $ref: '#/definitions/WorkloadIdentityFederationSpec'
      required:
        - folderId
        - masterSpec
        - serviceAccountId
        - nodeServiceAccountId
      additionalProperties: false
    definitions:
      InternalAddressSpec:
        type: object
        properties:
          subnetId:
            description: |-
              **string**
              ID of the subnet. If no ID is specified, and there only one subnet in specified zone, an address in this subnet will be allocated.
            type: string
      ExternalAddressSpec:
        type: object
        properties:
          address:
            description: |-
              **string**
              IP address.
            type: string
      ZonalMasterSpec:
        type: object
        properties:
          zoneId:
            description: |-
              **string**
              Required field. ID of the availability zone.
            type: string
          internalV4AddressSpec:
            description: |-
              **[InternalAddressSpec](#yandex.cloud.k8s.v1.InternalAddressSpec)**
              Specification of parameters for internal IPv4 networking.
            $ref: '#/definitions/InternalAddressSpec'
          externalV4AddressSpec:
            description: |-
              **[ExternalAddressSpec](#yandex.cloud.k8s.v1.ExternalAddressSpec)**
              Specification of parameters for external IPv4 networking.
            $ref: '#/definitions/ExternalAddressSpec'
        required:
          - zoneId
      MasterLocation:
        type: object
        properties:
          zoneId:
            description: |-
              **string**
              Required field. ID of the availability zone.
            type: string
          internalV4AddressSpec:
            description: |-
              **[InternalAddressSpec](#yandex.cloud.k8s.v1.InternalAddressSpec)**
              If not specified and there is a single subnet in specified zone, address
              in this subnet will be allocated.
            $ref: '#/definitions/InternalAddressSpec'
        required:
          - zoneId
      RegionalMasterSpec:
        type: object
        properties:
          regionId:
            description: |-
              **string**
              Required field. ID of the availability zone where the master resides.
            type: string
          locations:
            description: |-
              **[MasterLocation](#yandex.cloud.k8s.v1.MasterLocation)**
              List of locations where the master will be allocated.
            type: array
            items:
              $ref: '#/definitions/MasterLocation'
          externalV4AddressSpec:
            description: |-
              **[ExternalAddressSpec](#yandex.cloud.k8s.v1.ExternalAddressSpec)**
              Specify to allocate a static public IP for the master.
            $ref: '#/definitions/ExternalAddressSpec'
          externalV6AddressSpec:
            description: |-
              **[ExternalAddressSpec](#yandex.cloud.k8s.v1.ExternalAddressSpec)**
              Specification of parameters for external IPv6 networking.
            $ref: '#/definitions/ExternalAddressSpec'
        required:
          - regionId
      LocationSpec:
        type: object
        properties:
          zoneId:
            description: |-
              **string**
              Required field. ID of the availability zone where the master resides.
            type: string
          subnetId:
            description: |-
              **string**
              ID of the VPC network's subnet where the master resides.
              If not specified and there is a single subnet in specified zone, address in this subnet will be allocated.
            type: string
        required:
          - zoneId
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
              **[TimeOfDay](#google.type.TimeOfDay)**
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
              The number of elements must be in the range 1-7.
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
              **[TimeOfDay](#google.type.TimeOfDay)**
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
              **[DaysOfWeekMaintenanceWindow](#yandex.cloud.k8s.v1.DaysOfWeekMaintenanceWindow)**
              Days of the week and the maintenance window for these days when automatic updates are allowed.
              The number of elements must be in the range 1-7.
            type: array
            items:
              $ref: '#/definitions/DaysOfWeekMaintenanceWindow'
      MaintenanceWindow:
        type: object
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
              **[DailyMaintenanceWindow](#yandex.cloud.k8s.v1.DailyMaintenanceWindow)**
              Updating the master on any day during the specified time window.
              Includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`.
              Maintenance policy.
            $ref: '#/definitions/DailyMaintenanceWindow'
          weeklyMaintenanceWindow:
            description: |-
              **[WeeklyMaintenanceWindow](#yandex.cloud.k8s.v1.WeeklyMaintenanceWindow)**
              Updating the master on selected days during the specified time window.
              Includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`.
              Maintenance policy.
            $ref: '#/definitions/WeeklyMaintenanceWindow'
        oneOf:
          - required:
              - anytime
          - required:
              - dailyMaintenanceWindow
          - required:
              - weeklyMaintenanceWindow
      MasterMaintenancePolicy:
        type: object
        properties:
          autoUpgrade:
            description: |-
              **boolean**
              If set to true, automatic updates are installed in the specified period of time with no interaction from the user.
              If set to false, automatic upgrades are disabled.
            type: boolean
          maintenanceWindow:
            description: |-
              **[MaintenanceWindow](#yandex.cloud.k8s.v1.MaintenanceWindow)**
              Maintenance window settings. Update will start at the specified time and last no more than the specified duration.
              The time is set in UTC.
            $ref: '#/definitions/MaintenanceWindow'
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
      MasterScalePolicySpec:
        type: object
        properties:
          autoScale:
            description: |-
              **[AutoScale](#yandex.cloud.k8s.v1.MasterScalePolicySpec.AutoScale)**
              Includes only one of the fields `autoScale`.
            $ref: '#/definitions/AutoScale'
        oneOf:
          - required:
              - autoScale
      MasterLogging:
        type: object
        properties:
          enabled:
            description: |-
              **boolean**
              Identifies whether Cloud Logging is enabled for master components.
            type: boolean
          logGroupId:
            description: |-
              **string**
              ID of the log group where logs of master components should be stored.
              Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
              Includes only one of the fields `logGroupId`, `folderId`.
              The destination of master components' logs.
            pattern: ([a-zA-Z][-a-zA-Z0-9_.]{0,63})?
            type: string
          folderId:
            description: |-
              **string**
              ID of the folder where logs should be stored (in default group).
              Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.
              Includes only one of the fields `logGroupId`, `folderId`.
              The destination of master components' logs.
            pattern: ([a-zA-Z][-a-zA-Z0-9_.]{0,63})?
            type: string
          auditEnabled:
            description: |-
              **boolean**
              Identifies whether Cloud Logging is enabled for audit logs.
            type: boolean
          clusterAutoscalerEnabled:
            description: |-
              **boolean**
              Identifies whether Cloud Logging is enabled for cluster-autoscaler.
            type: boolean
          kubeApiserverEnabled:
            description: |-
              **boolean**
              Identifies whether Cloud Logging is enabled for kube-apiserver.
            type: boolean
          eventsEnabled:
            description: |-
              **boolean**
              Identifies whether Cloud Logging is enabled for events.
            type: boolean
        oneOf:
          - required:
              - logGroupId
          - required:
              - folderId
      MasterSpec:
        type: object
        properties:
          zonalMasterSpec:
            description: |-
              **[ZonalMasterSpec](#yandex.cloud.k8s.v1.ZonalMasterSpec)**
              Specification of the zonal master.
              Includes only one of the fields `zonalMasterSpec`, `regionalMasterSpec`.
            $ref: '#/definitions/ZonalMasterSpec'
          regionalMasterSpec:
            description: |-
              **[RegionalMasterSpec](#yandex.cloud.k8s.v1.RegionalMasterSpec)**
              Specification of the regional master.
              Includes only one of the fields `zonalMasterSpec`, `regionalMasterSpec`.
            $ref: '#/definitions/RegionalMasterSpec'
          locations:
            description: |-
              **[LocationSpec](#yandex.cloud.k8s.v1.LocationSpec)**
              Locations specification for Kubernetes control-plane (master) instances.
              Works in conjunction with [etcdClusterSize](#yandex.cloud.k8s.v1.MasterSpec). See it's documentation for details.
              Possible combinations:
              - 1 location and etcd_cluster_size = 1 - a single node cluster whose availability is limited by the availability of a single Compute Instance; downtime is expected during cluster updates.
              - 1 location and etcd_cluster_size = 3 - a highly available cluster within a single availability zone; can survive the failure of a Compute Instance, a server, or an individual server rack.
              - 3 location and etcd_cluster_size = 3 - a highly available cluster with each etcd instance located within separate availability zone; can survive the failure of a single availability zone.
            type: array
            items:
              $ref: '#/definitions/LocationSpec'
          etcdClusterSize:
            description: |-
              **string** (int64)
              Number of etcd nodes in cluster.
              Works in conjunction with [locations](/docs/managed-kubernetes/managed-kubernetes/api-ref/Cluster/update#yandex.cloud.k8s.v1.MasterUpdateSpec). See it's documentation for details.
              Optional. If not set, will be assumed equal to the number of locations.
            type: string
            format: int64
          externalV4AddressSpec:
            description: |-
              **[ExternalAddressSpec](#yandex.cloud.k8s.v1.ExternalAddressSpec)**
              Specification of parameters for external IPv4 networking.
            $ref: '#/definitions/ExternalAddressSpec'
          externalV6AddressSpec:
            description: |-
              **[ExternalAddressSpec](#yandex.cloud.k8s.v1.ExternalAddressSpec)**
              Specification of parameters for external IPv6 networking.
            $ref: '#/definitions/ExternalAddressSpec'
          version:
            description: |-
              **string**
              Version of Kubernetes components that runs on the master.
            type: string
          maintenancePolicy:
            description: |-
              **[MasterMaintenancePolicy](#yandex.cloud.k8s.v1.MasterMaintenancePolicy)**
              Maintenance policy of the master.
            $ref: '#/definitions/MasterMaintenancePolicy'
          scalePolicy:
            description: |-
              **[MasterScalePolicySpec](#yandex.cloud.k8s.v1.MasterScalePolicySpec)**
              Scale policy of the master.
            $ref: '#/definitions/MasterScalePolicySpec'
          securityGroupIds:
            description: |-
              **string**
              Master security groups.
            type: array
            items:
              type: string
          masterLogging:
            description: |-
              **[MasterLogging](#yandex.cloud.k8s.v1.MasterLogging)**
              Cloud Logging for master components.
            $ref: '#/definitions/MasterLogging'
        oneOf:
          - required:
              - zonalMasterSpec
          - required:
              - regionalMasterSpec
      IPAllocationPolicy:
        type: object
        properties:
          clusterIpv4CidrBlock:
            description: |-
              **string**
              CIDR block. IP range for allocating pod addresses.
              It should not overlap with any subnet in the network the Kubernetes cluster located in. Static routes will be
              set up for this CIDR blocks in node subnets.
            type: string
          nodeIpv4CidrMaskSize:
            description: |-
              **string** (int64)
              Size of the masks that are assigned for each node in the cluster.
              If not specified, 24 is used.
            type: string
            format: int64
          serviceIpv4CidrBlock:
            description: |-
              **string**
              CIDR block. IP range Kubernetes service Kubernetes cluster IP addresses will be allocated from.
              It should not overlap with any subnet in the network the Kubernetes cluster located in.
            type: string
          clusterIpv6CidrBlock:
            description: |-
              **string**
              IPv6 range for allocating pod IP addresses.
            type: string
          serviceIpv6CidrBlock:
            description: |-
              **string**
              IPv6 range for allocating Kubernetes service IP addresses
            type: string
      NetworkPolicy:
        type: object
        properties:
          provider:
            description: |-
              **enum** (Provider)
              - `CALICO`
            type: string
            enum:
              - PROVIDER_UNSPECIFIED
              - CALICO
      KMSProvider:
        type: object
        properties:
          keyId:
            description: |-
              **string**
              KMS key ID for secrets encryption.
              To obtain a KMS key ID use a [yandex.cloud.kms.v1.SymmetricKeyService.List](/docs/kms/api-ref/SymmetricKey/list#List) request.
            type: string
      Cilium:
        type: object
        properties:
          routingMode:
            description: |-
              **enum** (RoutingMode)
              - `TUNNEL`
            type: string
            enum:
              - ROUTING_MODE_UNSPECIFIED
              - TUNNEL
      WorkloadIdentityFederationSpec:
        type: object
        properties:
          enabled:
            description: |-
              **boolean**
              Identifies whether Workload Identity Federation is enabled.
            type: boolean
---

# Managed Services for Kubernetes API, REST: Cluster.Create

Creates a Kubernetes cluster in the specified folder.

## HTTP request

```
POST https://mks.{{ api-host }}/managed-kubernetes/v1/clusters
```

## Body parameters {#yandex.cloud.k8s.v1.CreateClusterRequest}

```json
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "networkId": "string",
  "masterSpec": {
    // Includes only one of the fields `zonalMasterSpec`, `regionalMasterSpec`
    "zonalMasterSpec": {
      "zoneId": "string",
      "internalV4AddressSpec": {
        "subnetId": "string"
      },
      "externalV4AddressSpec": {
        "address": "string"
      }
    },
    "regionalMasterSpec": {
      "regionId": "string",
      "locations": [
        {
          "zoneId": "string",
          "internalV4AddressSpec": {
            "subnetId": "string"
          }
        }
      ],
      "externalV4AddressSpec": {
        "address": "string"
      },
      "externalV6AddressSpec": {
        "address": "string"
      }
    },
    // end of the list of possible fields
    "locations": [
      {
        "zoneId": "string",
        "subnetId": "string"
      }
    ],
    "etcdClusterSize": "string",
    "externalV4AddressSpec": {
      "address": "string"
    },
    "externalV6AddressSpec": {
      "address": "string"
    },
    "version": "string",
    "maintenancePolicy": {
      "autoUpgrade": "boolean",
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
    "scalePolicy": {
      // Includes only one of the fields `autoScale`
      "autoScale": {
        "minResourcePresetId": "string"
      }
      // end of the list of possible fields
    },
    "securityGroupIds": [
      "string"
    ],
    "masterLogging": {
      "enabled": "boolean",
      // Includes only one of the fields `logGroupId`, `folderId`
      "logGroupId": "string",
      "folderId": "string",
      // end of the list of possible fields
      "auditEnabled": "boolean",
      "clusterAutoscalerEnabled": "boolean",
      "kubeApiserverEnabled": "boolean",
      "eventsEnabled": "boolean"
    }
  },
  "ipAllocationPolicy": {
    "clusterIpv4CidrBlock": "string",
    "nodeIpv4CidrMaskSize": "string",
    "serviceIpv4CidrBlock": "string",
    "clusterIpv6CidrBlock": "string",
    "serviceIpv6CidrBlock": "string"
  },
  // Includes only one of the fields `gatewayIpv4Address`
  "gatewayIpv4Address": "string",
  // end of the list of possible fields
  "serviceAccountId": "string",
  "nodeServiceAccountId": "string",
  "releaseChannel": "string",
  "networkPolicy": {
    "provider": "string"
  },
  "kmsProvider": {
    "keyId": "string"
  },
  // Includes only one of the fields `cilium`
  "cilium": {
    "routingMode": "string"
  },
  // end of the list of possible fields
  "workloadIdentityFederation": {
    "enabled": "boolean"
  }
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to create a Kubernetes cluster in.
To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| name | **string**

Name of the Kubernetes cluster.
The name must be unique within the folder.

Value must match the regular expression ``` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? ```. ||
|| description | **string**

Description of the Kubernetes cluster.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|| networkId | **string**

ID of the network.
This field is required. ||
|| masterSpec | **[MasterSpec](#yandex.cloud.k8s.v1.MasterSpec)**

Required field. Master specification of the Kubernetes cluster. ||
|| ipAllocationPolicy | **[IPAllocationPolicy](#yandex.cloud.k8s.v1.IPAllocationPolicy)**

IP allocation policy of the Kubernetes cluster. ||
|| gatewayIpv4Address | **string**

Gateway IPv4 address.

The maximum string length in characters is 15.

Includes only one of the fields `gatewayIpv4Address`. ||
|| serviceAccountId | **string**

Required field. Service account to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster.
Selected service account should have `edit` role on the folder where the Kubernetes cluster will be
located and on the folder where selected network resides. ||
|| nodeServiceAccountId | **string**

Required field. Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics. ||
|| releaseChannel | **enum** (ReleaseChannel)

Release channel for the master.

- `RAPID`: Minor updates with new functions and improvements are often added.
You can't disable automatic updates in this channel, but you can specify a time period for automatic updates.
- `REGULAR`: New functions and improvements are added in chunks shortly after they appear on `RAPID`.
- `STABLE`: Only updates related to bug fixes or security improvements are added. ||
|| networkPolicy | **[NetworkPolicy](#yandex.cloud.k8s.v1.NetworkPolicy)** ||
|| kmsProvider | **[KMSProvider](#yandex.cloud.k8s.v1.KMSProvider)**

KMS provider configuration. ||
|| cilium | **[Cilium](#yandex.cloud.k8s.v1.Cilium)**

Includes only one of the fields `cilium`. ||
|| workloadIdentityFederation | **[WorkloadIdentityFederationSpec](#yandex.cloud.k8s.v1.WorkloadIdentityFederationSpec)** ||
|#

## MasterSpec {#yandex.cloud.k8s.v1.MasterSpec}

#|
||Field | Description ||
|| zonalMasterSpec | **[ZonalMasterSpec](#yandex.cloud.k8s.v1.ZonalMasterSpec)**

Specification of the zonal master.

Includes only one of the fields `zonalMasterSpec`, `regionalMasterSpec`. ||
|| regionalMasterSpec | **[RegionalMasterSpec](#yandex.cloud.k8s.v1.RegionalMasterSpec)**

Specification of the regional master.

Includes only one of the fields `zonalMasterSpec`, `regionalMasterSpec`. ||
|| locations[] | **[LocationSpec](#yandex.cloud.k8s.v1.LocationSpec)**

Locations specification for Kubernetes control-plane (master) instances.
Works in conjunction with `etcdClusterSize`. See it's documentation for details.
Possible combinations:
- 1 location and etcd_cluster_size = 1 - a single node cluster whose availability is limited by the availability of a single Compute Instance; downtime is expected during cluster updates.
- 1 location and etcd_cluster_size = 3 - a highly available cluster within a single availability zone; can survive the failure of a Compute Instance, a server, or an individual server rack.
- 3 location and etcd_cluster_size = 3 - a highly available cluster with each etcd instance located within separate availability zone; can survive the failure of a single availability zone. ||
|| etcdClusterSize | **string** (int64)

Number of etcd nodes in cluster.
Works in conjunction with `locations`. See it's documentation for details.
Optional. If not set, will be assumed equal to the number of locations. ||
|| externalV4AddressSpec | **[ExternalAddressSpec](#yandex.cloud.k8s.v1.ExternalAddressSpec)**

Specification of parameters for external IPv4 networking. ||
|| externalV6AddressSpec | **[ExternalAddressSpec](#yandex.cloud.k8s.v1.ExternalAddressSpec)**

Specification of parameters for external IPv6 networking. ||
|| version | **string**

Version of Kubernetes components that runs on the master. ||
|| maintenancePolicy | **[MasterMaintenancePolicy](#yandex.cloud.k8s.v1.MasterMaintenancePolicy)**

Maintenance policy of the master. ||
|| scalePolicy | **[MasterScalePolicySpec](#yandex.cloud.k8s.v1.MasterScalePolicySpec)**

Scale policy of the master. ||
|| securityGroupIds[] | **string**

Master security groups. ||
|| masterLogging | **[MasterLogging](#yandex.cloud.k8s.v1.MasterLogging)**

Cloud Logging for master components. ||
|#

## ZonalMasterSpec {#yandex.cloud.k8s.v1.ZonalMasterSpec}

#|
||Field | Description ||
|| zoneId | **string**

Required field. ID of the availability zone. ||
|| internalV4AddressSpec | **[InternalAddressSpec](#yandex.cloud.k8s.v1.InternalAddressSpec)**

Specification of parameters for internal IPv4 networking. ||
|| externalV4AddressSpec | **[ExternalAddressSpec](#yandex.cloud.k8s.v1.ExternalAddressSpec)**

Specification of parameters for external IPv4 networking. ||
|#

## InternalAddressSpec {#yandex.cloud.k8s.v1.InternalAddressSpec}

#|
||Field | Description ||
|| subnetId | **string**

ID of the subnet. If no ID is specified, and there only one subnet in specified zone, an address in this subnet will be allocated. ||
|#

## ExternalAddressSpec {#yandex.cloud.k8s.v1.ExternalAddressSpec}

#|
||Field | Description ||
|| address | **string**

IP address. ||
|#

## RegionalMasterSpec {#yandex.cloud.k8s.v1.RegionalMasterSpec}

#|
||Field | Description ||
|| regionId | **string**

Required field. ID of the availability zone where the master resides. ||
|| locations[] | **[MasterLocation](#yandex.cloud.k8s.v1.MasterLocation)**

List of locations where the master will be allocated. ||
|| externalV4AddressSpec | **[ExternalAddressSpec](#yandex.cloud.k8s.v1.ExternalAddressSpec)**

Specify to allocate a static public IP for the master. ||
|| externalV6AddressSpec | **[ExternalAddressSpec](#yandex.cloud.k8s.v1.ExternalAddressSpec)**

Specification of parameters for external IPv6 networking. ||
|#

## MasterLocation {#yandex.cloud.k8s.v1.MasterLocation}

#|
||Field | Description ||
|| zoneId | **string**

Required field. ID of the availability zone. ||
|| internalV4AddressSpec | **[InternalAddressSpec](#yandex.cloud.k8s.v1.InternalAddressSpec)**

If not specified and there is a single subnet in specified zone, address
in this subnet will be allocated. ||
|#

## LocationSpec {#yandex.cloud.k8s.v1.LocationSpec}

#|
||Field | Description ||
|| zoneId | **string**

Required field. ID of the availability zone where the master resides. ||
|| subnetId | **string**

ID of the VPC network's subnet where the master resides.
If not specified and there is a single subnet in specified zone, address in this subnet will be allocated. ||
|#

## MasterMaintenancePolicy {#yandex.cloud.k8s.v1.MasterMaintenancePolicy}

#|
||Field | Description ||
|| autoUpgrade | **boolean**

If set to true, automatic updates are installed in the specified period of time with no interaction from the user.
If set to false, automatic upgrades are disabled. ||
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

Days of the week and the maintenance window for these days when automatic updates are allowed.

The number of elements must be in the range 1-7. ||
|#

## DaysOfWeekMaintenanceWindow {#yandex.cloud.k8s.v1.DaysOfWeekMaintenanceWindow}

#|
||Field | Description ||
|| days[] | **enum** (DayOfWeek)

Days of the week when automatic updates are allowed.

The number of elements must be in the range 1-7.

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

## MasterScalePolicySpec {#yandex.cloud.k8s.v1.MasterScalePolicySpec}

#|
||Field | Description ||
|| autoScale | **[AutoScale](#yandex.cloud.k8s.v1.MasterScalePolicySpec.AutoScale)**

Includes only one of the fields `autoScale`. ||
|#

## AutoScale {#yandex.cloud.k8s.v1.MasterScalePolicySpec.AutoScale}

Scalable master instance resources.

#|
||Field | Description ||
|| minResourcePresetId | **string**

Required field. Preset of computing resources to be used as lower boundary for scaling. ||
|#

## MasterLogging {#yandex.cloud.k8s.v1.MasterLogging}

#|
||Field | Description ||
|| enabled | **boolean**

Identifies whether Cloud Logging is enabled for master components. ||
|| logGroupId | **string**

ID of the log group where logs of master components should be stored.

Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.

Includes only one of the fields `logGroupId`, `folderId`.

The destination of master components' logs. ||
|| folderId | **string**

ID of the folder where logs should be stored (in default group).

Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.

Includes only one of the fields `logGroupId`, `folderId`.

The destination of master components' logs. ||
|| auditEnabled | **boolean**

Identifies whether Cloud Logging is enabled for audit logs. ||
|| clusterAutoscalerEnabled | **boolean**

Identifies whether Cloud Logging is enabled for cluster-autoscaler. ||
|| kubeApiserverEnabled | **boolean**

Identifies whether Cloud Logging is enabled for kube-apiserver. ||
|| eventsEnabled | **boolean**

Identifies whether Cloud Logging is enabled for events. ||
|#

## IPAllocationPolicy {#yandex.cloud.k8s.v1.IPAllocationPolicy}

#|
||Field | Description ||
|| clusterIpv4CidrBlock | **string**

CIDR block. IP range for allocating pod addresses.
It should not overlap with any subnet in the network the Kubernetes cluster located in. Static routes will be
set up for this CIDR blocks in node subnets. ||
|| nodeIpv4CidrMaskSize | **string** (int64)

Size of the masks that are assigned for each node in the cluster.
If not specified, 24 is used. ||
|| serviceIpv4CidrBlock | **string**

CIDR block. IP range Kubernetes service Kubernetes cluster IP addresses will be allocated from.
It should not overlap with any subnet in the network the Kubernetes cluster located in. ||
|| clusterIpv6CidrBlock | **string**

IPv6 range for allocating pod IP addresses. ||
|| serviceIpv6CidrBlock | **string**

IPv6 range for allocating Kubernetes service IP addresses ||
|#

## NetworkPolicy {#yandex.cloud.k8s.v1.NetworkPolicy}

#|
||Field | Description ||
|| provider | **enum** (Provider)

- `CALICO` ||
|#

## KMSProvider {#yandex.cloud.k8s.v1.KMSProvider}

#|
||Field | Description ||
|| keyId | **string**

KMS key ID for secrets encryption.
To obtain a KMS key ID use a [yandex.cloud.kms.v1.SymmetricKeyService.List](/docs/kms/api-ref/SymmetricKey/list#List) request. ||
|#

## Cilium {#yandex.cloud.k8s.v1.Cilium}

#|
||Field | Description ||
|| routingMode | **enum** (RoutingMode)

- `TUNNEL` ||
|#

## WorkloadIdentityFederationSpec {#yandex.cloud.k8s.v1.WorkloadIdentityFederationSpec}

#|
||Field | Description ||
|| enabled | **boolean**

Identifies whether Workload Identity Federation is enabled. ||
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