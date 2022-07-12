---
editable: false
---

# Method create
Creates a node group in the specified Kubernetes cluster.
 

 
## HTTP request {#https-request}
```
POST https://mks.{{ api-host }}/managed-kubernetes/v1/nodeGroups
```
 
## Body parameters {#body_params}
 
```json 
{
  "clusterId": "string",
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
          "ptr": true
        }
      ]
    },
    "schedulingPolicy": {
      "preemptible": true
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
              "ptr": true
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
              "ptr": true
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
    }
  },
  "scalePolicy": {

    // `scalePolicy` includes only one of the fields `fixedScale`, `autoScale`
    "fixedScale": {
      "size": "string"
    },
    "autoScale": {
      "minSize": "string",
      "maxSize": "string",
      "initialSize": "string"
    },
    // end of the list of possible fields`scalePolicy`

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
  "version": "string",
  "maintenancePolicy": {
    "autoUpgrade": true,
    "autoRepair": true,
    "maintenanceWindow": {

      // `maintenancePolicy.maintenanceWindow` includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`
      "anytime": {},
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
      },
      // end of the list of possible fields`maintenancePolicy.maintenanceWindow`

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

 
Field | Description
--- | ---
clusterId | **string**<br><p>Required. ID of the Kubernetes cluster to create a node group in. To get the Kubernetes cluster ID, use a <a href="/docs/managed-kubernetes/api-ref/Cluster/list">list</a> request.</p> 
name | **string**<br><p>Name of the node group. The name must be unique within the folder.</p> <p>Value must match the regular expression ``\|[a-z]([-a-z0-9]{0,61}[a-z0-9])?``.</p> 
description | **string**<br><p>Description of the node group.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_./\@0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_./\@0-9a-z]*``.</p> 
nodeTemplate | **object**<br><p>Required. Node template for creating the node group.</p> 
nodeTemplate.<br>name | **string**<br><p>Name of the instance. In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, default is used: {instance_group.id}-{instance.short_id} It may also contain another placeholders, see metadata doc for full list.</p> <p>The maximum string length in characters is 128.</p> 
nodeTemplate.<br>labels | **object**<br><p>these labels will be assigned to compute nodes (instances), created by the nodegroup</p> <p>No more than 32 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_./\@0-9a-z]*``. The maximum string length in characters for each value is 128.</p> 
nodeTemplate.<br>platformId | **string**<br><p>ID of the hardware platform configuration for the node.</p> 
nodeTemplate.<br>resourcesSpec | **object**<br><p>Computing resources of the node such as the amount of memory and number of cores.</p> 
nodeTemplate.<br>resourcesSpec.<br>memory | **string** (int64)<br><p>Amount of memory available to the node, specified in bytes.</p> <p>The minimum value is 0.</p> 
nodeTemplate.<br>resourcesSpec.<br>cores | **string** (int64)<br><p>Number of cores available to the node.</p> <p>The minimum value is 0.</p> 
nodeTemplate.<br>resourcesSpec.<br>coreFraction | **string** (int64)<br><p>Baseline level of CPU performance with the possibility to burst performance above that baseline level. This field sets baseline performance for each core.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
nodeTemplate.<br>resourcesSpec.<br>gpus | **string** (int64)<br><p>Number of GPUs available to the node.</p> <p>The minimum value is 0.</p> 
nodeTemplate.<br>bootDiskSpec | **object**<br><p>Specification for the boot disk that will be attached to the node.</p> 
nodeTemplate.<br>bootDiskSpec.<br>diskTypeId | **string**<br><p>ID of the disk type.</p> <p>Value must match the regular expression ``\|network-ssd\|network-hdd\|network-ssd-nonreplicated``.</p> 
nodeTemplate.<br>bootDiskSpec.<br>diskSize | **string** (int64)<br><p>Size of the disk, specified in bytes.</p> <p>Acceptable values are 0 to 4398046511104, inclusive.</p> 
nodeTemplate.<br>metadata | **object**<br><p>The metadata as ``key:value`` pairs assigned to this instance template. This includes custom metadata and predefined keys.</p> <p>For example, you may use the metadata in order to provide your public SSH key to the node. For more information, see <a href="/docs/compute/concepts/vm-metadata">Metadata</a>.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 131072.</p> 
nodeTemplate.<br>v4AddressSpec | **object**<br><p>Specification for the create network interfaces for the node group compute instances. Deprecated, please use network_interface_specs.</p> 
nodeTemplate.<br>v4AddressSpec.<br>oneToOneNatSpec | **object**<br><p>One-to-one NAT configuration. Setting up one-to-one NAT ensures that public IP addresses are assigned to nodes, and therefore internet is accessible for all nodes of the node group. If the field is not set, NAT will not be set up.</p> 
nodeTemplate.<br>v4AddressSpec.<br>oneToOneNatSpec.<br>ipVersion | **string**<br><p>IP version for the public IP address.</p> <ul> <li>IPV4: IPv4 address, for example 192.168.0.0.</li> <li>IPV6: IPv6 address, not available yet.</li> </ul> 
nodeTemplate.<br>v4AddressSpec.<br>dnsRecordSpecs[] | **object**<br><p>Internal DNS configuration.</p> 
nodeTemplate.<br>v4AddressSpec.<br>dnsRecordSpecs[].<br>fqdn | **string**<br><p>Required. FQDN (required).</p> 
nodeTemplate.<br>v4AddressSpec.<br>dnsRecordSpecs[].<br>dnsZoneId | **string**<br><p>DNS zone id (optional, if not set, private zone is used).</p> 
nodeTemplate.<br>v4AddressSpec.<br>dnsRecordSpecs[].<br>ttl | **string** (int64)<br><p>DNS record ttl, values in 0-86400 (optional).</p> <p>Acceptable values are 0 to 86400, inclusive.</p> 
nodeTemplate.<br>v4AddressSpec.<br>dnsRecordSpecs[].<br>ptr | **boolean** (boolean)<br><p>When set to true, also create PTR DNS record (optional).</p> 
nodeTemplate.<br>schedulingPolicy | **object**<br><p>Scheduling policy configuration.</p> 
nodeTemplate.<br>schedulingPolicy.<br>preemptible | **boolean** (boolean)<br><p>True for preemptible compute instances. Default value is false. Preemptible compute instances are stopped at least once every 24 hours, and can be stopped at any time if their resources are needed by Compute. For more information, see <a href="/docs/compute/concepts/preemptible-vm">Preemptible Virtual Machines</a>.</p> 
nodeTemplate.<br>networkInterfaceSpecs[] | **object**<br><p>New api, to specify network interfaces for the node group compute instances. Can not be used together with 'v4_address_spec'</p> 
nodeTemplate.<br>networkInterfaceSpecs[].<br>subnetIds[] | **string**<br><p>IDs of the subnets.</p> 
nodeTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec | **object**<br><p>Primary IPv4 address that is assigned to the instance for this network interface.</p> 
nodeTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec | **object**<br><p>One-to-one NAT configuration. Setting up one-to-one NAT ensures that public IP addresses are assigned to nodes, and therefore internet is accessible for all nodes of the node group. If the field is not set, NAT will not be set up.</p> 
nodeTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec.<br>ipVersion | **string**<br><p>IP version for the public IP address.</p> <ul> <li>IPV4: IPv4 address, for example 192.168.0.0.</li> <li>IPV6: IPv6 address, not available yet.</li> </ul> 
nodeTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>dnsRecordSpecs[] | **object**<br><p>Internal DNS configuration.</p> 
nodeTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>dnsRecordSpecs[].<br>fqdn | **string**<br><p>Required. FQDN (required).</p> 
nodeTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>dnsRecordSpecs[].<br>dnsZoneId | **string**<br><p>DNS zone id (optional, if not set, private zone is used).</p> 
nodeTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>dnsRecordSpecs[].<br>ttl | **string** (int64)<br><p>DNS record ttl, values in 0-86400 (optional).</p> <p>Acceptable values are 0 to 86400, inclusive.</p> 
nodeTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>dnsRecordSpecs[].<br>ptr | **boolean** (boolean)<br><p>When set to true, also create PTR DNS record (optional).</p> 
nodeTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec | **object**<br><p>Primary IPv6 address that is assigned to the instance for this network interface.</p> 
nodeTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec | **object**<br><p>One-to-one NAT configuration. Setting up one-to-one NAT ensures that public IP addresses are assigned to nodes, and therefore internet is accessible for all nodes of the node group. If the field is not set, NAT will not be set up.</p> 
nodeTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec.<br>ipVersion | **string**<br><p>IP version for the public IP address.</p> <ul> <li>IPV4: IPv4 address, for example 192.168.0.0.</li> <li>IPV6: IPv6 address, not available yet.</li> </ul> 
nodeTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>dnsRecordSpecs[] | **object**<br><p>Internal DNS configuration.</p> 
nodeTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>dnsRecordSpecs[].<br>fqdn | **string**<br><p>Required. FQDN (required).</p> 
nodeTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>dnsRecordSpecs[].<br>dnsZoneId | **string**<br><p>DNS zone id (optional, if not set, private zone is used).</p> 
nodeTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>dnsRecordSpecs[].<br>ttl | **string** (int64)<br><p>DNS record ttl, values in 0-86400 (optional).</p> <p>Acceptable values are 0 to 86400, inclusive.</p> 
nodeTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>dnsRecordSpecs[].<br>ptr | **boolean** (boolean)<br><p>When set to true, also create PTR DNS record (optional).</p> 
nodeTemplate.<br>networkInterfaceSpecs[].<br>securityGroupIds[] | **string**<br><p>IDs of security groups.</p> 
nodeTemplate.<br>placementPolicy | **object**<br>
nodeTemplate.<br>placementPolicy.<br>placementGroupId | **string**<br><p>Identifier of placement group</p> 
nodeTemplate.<br>networkSettings | **object**<br><p>this parameter allows to specify type of network acceleration used on nodes (instances)</p> 
nodeTemplate.<br>networkSettings.<br>type | **string**<br><p>Required.</p> 
nodeTemplate.<br>containerRuntimeSettings | **object**<br>
nodeTemplate.<br>containerRuntimeSettings.<br>type | **string**<br><p>Required.</p> 
scalePolicy | **object**<br><p>Required. Scale policy of the node group.</p> 
scalePolicy.<br>fixedScale | **object**<br>Fixed scale policy of the node group. <br>`scalePolicy` includes only one of the fields `fixedScale`, `autoScale`<br><br>
scalePolicy.<br>fixedScale.<br>size | **string** (int64)<br><p>Number of nodes in the node group.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
scalePolicy.<br>autoScale | **object**<br>Auto scale policy of the node group. <br>`scalePolicy` includes only one of the fields `fixedScale`, `autoScale`<br><br>
scalePolicy.<br>autoScale.<br>minSize | **string** (int64)<br><p>Minimum number of nodes in the node group.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
scalePolicy.<br>autoScale.<br>maxSize | **string** (int64)<br><p>Maximum number of nodes in the node group.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
scalePolicy.<br>autoScale.<br>initialSize | **string** (int64)<br><p>Initial number of nodes in the node group.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
allocationPolicy | **object**<br><p>Allocation policy of the node group by the zones and regions.</p> 
allocationPolicy.<br>locations[] | **object**<br><p>List of locations where resources for the node group will be allocated.</p> 
allocationPolicy.<br>locations[].<br>zoneId | **string**<br><p>Required. ID of the availability zone where the nodes may reside.</p> 
allocationPolicy.<br>locations[].<br>subnetId | **string**<br><p>ID of the subnet. If a network chosen for the Kubernetes cluster has only one subnet in the specified zone, subnet ID may be omitted.</p> 
deployPolicy | **object**<br><p>Deploy policy according to which the updates are rolled out. If not specified, the default is used.</p> 
deployPolicy.<br>maxUnavailable | **string** (int64)<br><p>The maximum number of running instances that can be taken offline (i.e., stopped or deleted) at the same time during the update process. If ``maxExpansion`` is not specified or set to zero, ``maxUnavailable`` must be set to a non-zero value.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
deployPolicy.<br>maxExpansion | **string** (int64)<br><p>The maximum number of instances that can be temporarily allocated above the group's target size during the update process. If ``maxUnavailable`` is not specified or set to zero, ``maxExpansion`` must be set to a non-zero value.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
version | **string**<br><p>Version of Kubernetes components that runs on the nodes.</p> 
maintenancePolicy | **object**<br><p>Maintenance policy of the node group.</p> 
maintenancePolicy.<br>autoUpgrade | **boolean** (boolean)<br><p>If set to true, automatic updates are installed in the specified period of time with no interaction from the user. If set to false, automatic upgrades are disabled.</p> 
maintenancePolicy.<br>autoRepair | **boolean** (boolean)<br><p>If set to true, automatic repairs are enabled. Default value is false.</p> 
maintenancePolicy.<br>maintenanceWindow | **object**<br><p>Maintenance window settings. Update will start at the specified time and last no more than the specified duration. The time is set in UTC.</p> 
maintenancePolicy.<br>maintenanceWindow.<br>anytime | **object**<br>Updating the master at any time. <br>`maintenancePolicy.maintenanceWindow` includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`<br><br>
maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow | **object**<br>Updating the master on any day during the specified time window. <br>`maintenancePolicy.maintenanceWindow` includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`<br><br>
maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime | **object**<br><p>Required. Window start time, in the UTC timezone.</p> <p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value "24:00:00" for scenarios like business closing time.</p> 
maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>duration | **string**<br><p>Window duration.</p> <p>Acceptable values are 3600 seconds to 86400 seconds, inclusive.</p> 
maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow | **object**<br>Updating the master on selected days during the specified time window. <br>`maintenancePolicy.maintenanceWindow` includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`<br><br>
maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[] | **object**<br><p>Required. Days of the week and the maintenance window for these days when automatic updates are allowed.</p> <p>The number of elements must be in the range 1-7.</p> 
maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>days[] | **string**<br><p>Required. Days of the week when automatic updates are allowed.</p> <p>The number of elements must be in the range 1-7.</p> <ul> <li>MONDAY: The day-of-week of Monday.</li> <li>TUESDAY: The day-of-week of Tuesday.</li> <li>WEDNESDAY: The day-of-week of Wednesday.</li> <li>THURSDAY: The day-of-week of Thursday.</li> <li>FRIDAY: The day-of-week of Friday.</li> <li>SATURDAY: The day-of-week of Saturday.</li> <li>SUNDAY: The day-of-week of Sunday.</li> </ul> 
maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime | **object**<br><p>Required. Window start time, in the UTC timezone.</p> <p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value "24:00:00" for scenarios like business closing time.</p> 
maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>duration | **string**<br><p>Window duration.</p> <p>Acceptable values are 3600 seconds to 86400 seconds, inclusive.</p> 
allowedUnsafeSysctls[] | **string**<br><p>Support for unsafe sysctl parameters. For more details see <a href="https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/">documentation</a>.</p> <p>The maximum string length in characters for each value is 253. Each value must match the regular expression ``([a-z0-9]([-_a-z0-9]*[a-z0-9])?\.)*([a-z0-9][-_a-z0-9]*)?[a-z0-9*]``.</p> 
nodeTaints[] | **object**<br><p>Taints that are applied to the nodes of the node group at creation time.</p> 
nodeTaints[].<br>key | **string**<br><p>The taint key to be applied to a node.</p> 
nodeTaints[].<br>value | **string**<br><p>The taint value corresponding to the taint key.</p> 
nodeTaints[].<br>effect | **string**<br><p>The effect of the taint on pods that do not tolerate the taint.</p> <ul> <li>NO_SCHEDULE: Do not allow new pods to schedule onto the node unless they tolerate the taint, but allow all pods submitted to Kubelet without going through the scheduler to start, and allow all already-running pods to continue running.</li> <li>PREFER_NO_SCHEDULE: Like NO_SCHEDULE, but the scheduler tries not to schedule new pods onto the node, rather than prohibiting new pods from scheduling onto the node entirely. Enforced by the scheduler.</li> <li>NO_EXECUTE: Evict any already-running pods that do not tolerate the taint.</li> </ul> 
nodeLabels | **object**<br><p>Labels that are assigned to the nodes of the node group at creation time.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": true,
  "metadata": "object",

  //  includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object",
  // end of the list of possible fields

}
```
An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the operation.</p> 
description | **string**<br><p>Description of the operation. 0-256 characters long.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br><br><p>The error result of the operation in case of failure or cancellation.</p> 
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 