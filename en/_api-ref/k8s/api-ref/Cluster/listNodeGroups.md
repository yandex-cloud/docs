---
editable: false
---

# Method listNodeGroups
Lists nodegroup for the specified Kubernetes cluster.
 

 
## HTTP request {#https-request}
```
GET https://mks.{{ api-host }}/managed-kubernetes/v1/clusters/{clusterId}/nodeGroups
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the Kubernetes cluster to list node groups in. To get the Kubernetes cluster ID use a <a href="/docs/managed-kubernetes/api-ref/Cluster/list">list</a> request.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/managed-kubernetes/api-ref/Cluster/listNodeGroups#query_params">pageSize</a>, the service returns a <a href="/docs/managed-kubernetes/api-ref/Cluster/listNodeGroups#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token. To get the next page of results, set ``page_token`` to the <a href="/docs/managed-kubernetes/api-ref/Cluster/listNodeGroups#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters resources listed in the response. Currently you can use filtering only on <a href="/docs/managed-kubernetes/api-ref/Cluster#representation">Cluster.name</a> field.</p> <p>The maximum string length in characters is 1000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "nodeGroups": [
    {
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

        // `nodeGroups[].scalePolicy` includes only one of the fields `fixedScale`, `autoScale`
        "fixedScale": {
          "size": "string"
        },
        "autoScale": {
          "minSize": "string",
          "maxSize": "string",
          "initialSize": "string"
        },
        // end of the list of possible fields`nodeGroups[].scalePolicy`

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
        "newRevisionAvailable": true,
        "newRevisionSummary": "string",
        "versionDeprecated": true
      },
      "maintenancePolicy": {
        "autoUpgrade": true,
        "autoRepair": true,
        "maintenanceWindow": {

          // `nodeGroups[].maintenancePolicy.maintenanceWindow` includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`
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
          // end of the list of possible fields`nodeGroups[].maintenancePolicy.maintenanceWindow`

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
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
nodeGroups[] | **object**<br><p>List of node groups for the specified Kubernetes cluster.</p> 
nodeGroups[].<br>id | **string**<br><p>ID of the node group.</p> 
nodeGroups[].<br>clusterId | **string**<br><p>ID of the cluster that the node group belongs to.</p> 
nodeGroups[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
nodeGroups[].<br>name | **string**<br><p>Name of the node group. The name is unique within the folder.</p> 
nodeGroups[].<br>description | **string**<br><p>Description of the node group. 0-256 characters long.</p> 
nodeGroups[].<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
nodeGroups[].<br>status | **string**<br><p>Status of the node group.</p> <ul> <li>PROVISIONING: Node group is waiting for resources to be allocated.</li> <li>RUNNING: Node group is running.</li> <li>RECONCILING: Node group is waiting for some work to be done, such as upgrading node software.</li> <li>STOPPING: Node group is being stopped.</li> <li>STOPPED: Node group stopped.</li> <li>DELETING: Node group is being deleted.</li> <li>STARTING: Node group is being started.</li> </ul> 
nodeGroups[].<br>nodeTemplate | **object**<br><p>Node template that specifies parameters of the compute instances for the node group.</p> 
nodeGroups[].<br>nodeTemplate.<br>name | **string**<br><p>Name of the instance. In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, default is used: {instance_group.id}-{instance.short_id} It may also contain another placeholders, see metadata doc for full list.</p> <p>The maximum string length in characters is 128.</p> 
nodeGroups[].<br>nodeTemplate.<br>labels | **object**<br><p>these labels will be assigned to compute nodes (instances), created by the nodegroup</p> <p>No more than 32 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_./\@0-9a-z]*``. The maximum string length in characters for each value is 128.</p> 
nodeGroups[].<br>nodeTemplate.<br>platformId | **string**<br><p>ID of the hardware platform configuration for the node.</p> 
nodeGroups[].<br>nodeTemplate.<br>resourcesSpec | **object**<br><p>Computing resources of the node such as the amount of memory and number of cores.</p> 
nodeGroups[].<br>nodeTemplate.<br>resourcesSpec.<br>memory | **string** (int64)<br><p>Amount of memory available to the node, specified in bytes.</p> <p>The minimum value is 0.</p> 
nodeGroups[].<br>nodeTemplate.<br>resourcesSpec.<br>cores | **string** (int64)<br><p>Number of cores available to the node.</p> <p>The minimum value is 0.</p> 
nodeGroups[].<br>nodeTemplate.<br>resourcesSpec.<br>coreFraction | **string** (int64)<br><p>Baseline level of CPU performance with the possibility to burst performance above that baseline level. This field sets baseline performance for each core.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
nodeGroups[].<br>nodeTemplate.<br>resourcesSpec.<br>gpus | **string** (int64)<br><p>Number of GPUs available to the node.</p> <p>The minimum value is 0.</p> 
nodeGroups[].<br>nodeTemplate.<br>bootDiskSpec | **object**<br><p>Specification for the boot disk that will be attached to the node.</p> 
nodeGroups[].<br>nodeTemplate.<br>bootDiskSpec.<br>diskTypeId | **string**<br><p>ID of the disk type.</p> <p>Value must match the regular expression ``\|network-ssd\|network-hdd\|network-ssd-nonreplicated``.</p> 
nodeGroups[].<br>nodeTemplate.<br>bootDiskSpec.<br>diskSize | **string** (int64)<br><p>Size of the disk, specified in bytes.</p> <p>Acceptable values are 0 to 4398046511104, inclusive.</p> 
nodeGroups[].<br>nodeTemplate.<br>metadata | **object**<br><p>The metadata as ``key:value`` pairs assigned to this instance template. This includes custom metadata and predefined keys.</p> <p>For example, you may use the metadata in order to provide your public SSH key to the node. For more information, see <a href="/docs/compute/concepts/vm-metadata">Metadata</a>.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 131072.</p> 
nodeGroups[].<br>nodeTemplate.<br>v4AddressSpec | **object**<br><p>Specification for the create network interfaces for the node group compute instances. Deprecated, please use network_interface_specs.</p> 
nodeGroups[].<br>nodeTemplate.<br>v4AddressSpec.<br>oneToOneNatSpec | **object**<br><p>One-to-one NAT configuration. Setting up one-to-one NAT ensures that public IP addresses are assigned to nodes, and therefore internet is accessible for all nodes of the node group. If the field is not set, NAT will not be set up.</p> 
nodeGroups[].<br>nodeTemplate.<br>v4AddressSpec.<br>oneToOneNatSpec.<br>ipVersion | **string**<br><p>IP version for the public IP address.</p> <ul> <li>IPV4: IPv4 address, for example 192.168.0.0.</li> <li>IPV6: IPv6 address, not available yet.</li> </ul> 
nodeGroups[].<br>nodeTemplate.<br>v4AddressSpec.<br>dnsRecordSpecs[] | **object**<br><p>Internal DNS configuration.</p> 
nodeGroups[].<br>nodeTemplate.<br>v4AddressSpec.<br>dnsRecordSpecs[].<br>fqdn | **string**<br><p>Required. FQDN (required).</p> 
nodeGroups[].<br>nodeTemplate.<br>v4AddressSpec.<br>dnsRecordSpecs[].<br>dnsZoneId | **string**<br><p>DNS zone id (optional, if not set, private zone is used).</p> 
nodeGroups[].<br>nodeTemplate.<br>v4AddressSpec.<br>dnsRecordSpecs[].<br>ttl | **string** (int64)<br><p>DNS record ttl, values in 0-86400 (optional).</p> <p>Acceptable values are 0 to 86400, inclusive.</p> 
nodeGroups[].<br>nodeTemplate.<br>v4AddressSpec.<br>dnsRecordSpecs[].<br>ptr | **boolean** (boolean)<br><p>When set to true, also create PTR DNS record (optional).</p> 
nodeGroups[].<br>nodeTemplate.<br>schedulingPolicy | **object**<br><p>Scheduling policy configuration.</p> 
nodeGroups[].<br>nodeTemplate.<br>schedulingPolicy.<br>preemptible | **boolean** (boolean)<br><p>True for preemptible compute instances. Default value is false. Preemptible compute instances are stopped at least once every 24 hours, and can be stopped at any time if their resources are needed by Compute. For more information, see <a href="/docs/compute/concepts/preemptible-vm">Preemptible Virtual Machines</a>.</p> 
nodeGroups[].<br>nodeTemplate.<br>networkInterfaceSpecs[] | **object**<br><p>New api, to specify network interfaces for the node group compute instances. Can not be used together with 'v4_address_spec'</p> 
nodeGroups[].<br>nodeTemplate.<br>networkInterfaceSpecs[].<br>subnetIds[] | **string**<br><p>IDs of the subnets.</p> 
nodeGroups[].<br>nodeTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec | **object**<br><p>Primary IPv4 address that is assigned to the instance for this network interface.</p> 
nodeGroups[].<br>nodeTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec | **object**<br><p>One-to-one NAT configuration. Setting up one-to-one NAT ensures that public IP addresses are assigned to nodes, and therefore internet is accessible for all nodes of the node group. If the field is not set, NAT will not be set up.</p> 
nodeGroups[].<br>nodeTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec.<br>ipVersion | **string**<br><p>IP version for the public IP address.</p> <ul> <li>IPV4: IPv4 address, for example 192.168.0.0.</li> <li>IPV6: IPv6 address, not available yet.</li> </ul> 
nodeGroups[].<br>nodeTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>dnsRecordSpecs[] | **object**<br><p>Internal DNS configuration.</p> 
nodeGroups[].<br>nodeTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>dnsRecordSpecs[].<br>fqdn | **string**<br><p>Required. FQDN (required).</p> 
nodeGroups[].<br>nodeTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>dnsRecordSpecs[].<br>dnsZoneId | **string**<br><p>DNS zone id (optional, if not set, private zone is used).</p> 
nodeGroups[].<br>nodeTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>dnsRecordSpecs[].<br>ttl | **string** (int64)<br><p>DNS record ttl, values in 0-86400 (optional).</p> <p>Acceptable values are 0 to 86400, inclusive.</p> 
nodeGroups[].<br>nodeTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>dnsRecordSpecs[].<br>ptr | **boolean** (boolean)<br><p>When set to true, also create PTR DNS record (optional).</p> 
nodeGroups[].<br>nodeTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec | **object**<br><p>Primary IPv6 address that is assigned to the instance for this network interface.</p> 
nodeGroups[].<br>nodeTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec | **object**<br><p>One-to-one NAT configuration. Setting up one-to-one NAT ensures that public IP addresses are assigned to nodes, and therefore internet is accessible for all nodes of the node group. If the field is not set, NAT will not be set up.</p> 
nodeGroups[].<br>nodeTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec.<br>ipVersion | **string**<br><p>IP version for the public IP address.</p> <ul> <li>IPV4: IPv4 address, for example 192.168.0.0.</li> <li>IPV6: IPv6 address, not available yet.</li> </ul> 
nodeGroups[].<br>nodeTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>dnsRecordSpecs[] | **object**<br><p>Internal DNS configuration.</p> 
nodeGroups[].<br>nodeTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>dnsRecordSpecs[].<br>fqdn | **string**<br><p>Required. FQDN (required).</p> 
nodeGroups[].<br>nodeTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>dnsRecordSpecs[].<br>dnsZoneId | **string**<br><p>DNS zone id (optional, if not set, private zone is used).</p> 
nodeGroups[].<br>nodeTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>dnsRecordSpecs[].<br>ttl | **string** (int64)<br><p>DNS record ttl, values in 0-86400 (optional).</p> <p>Acceptable values are 0 to 86400, inclusive.</p> 
nodeGroups[].<br>nodeTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>dnsRecordSpecs[].<br>ptr | **boolean** (boolean)<br><p>When set to true, also create PTR DNS record (optional).</p> 
nodeGroups[].<br>nodeTemplate.<br>networkInterfaceSpecs[].<br>securityGroupIds[] | **string**<br><p>IDs of security groups.</p> 
nodeGroups[].<br>nodeTemplate.<br>placementPolicy | **object**
nodeGroups[].<br>nodeTemplate.<br>placementPolicy.<br>placementGroupId | **string**<br><p>Identifier of placement group</p> 
nodeGroups[].<br>nodeTemplate.<br>networkSettings | **object**<br><p>this parameter allows to specify type of network acceleration used on nodes (instances)</p> 
nodeGroups[].<br>nodeTemplate.<br>networkSettings.<br>type | **string**<br><p>Required.</p> 
nodeGroups[].<br>nodeTemplate.<br>containerRuntimeSettings | **object**
nodeGroups[].<br>nodeTemplate.<br>containerRuntimeSettings.<br>type | **string**<br><p>Required.</p> 
nodeGroups[].<br>scalePolicy | **object**<br><p>Scale policy of the node group.  For more information, see <a href="/docs/compute/concepts/instance-groups/policies#scale-policy">Scaling policy</a>.</p> 
nodeGroups[].<br>scalePolicy.<br>fixedScale | **object**<br>Fixed scale policy of the node group. <br>`nodeGroups[].scalePolicy` includes only one of the fields `fixedScale`, `autoScale`<br>
nodeGroups[].<br>scalePolicy.<br>fixedScale.<br>size | **string** (int64)<br><p>Number of nodes in the node group.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
nodeGroups[].<br>scalePolicy.<br>autoScale | **object**<br>Auto scale policy of the node group. <br>`nodeGroups[].scalePolicy` includes only one of the fields `fixedScale`, `autoScale`<br>
nodeGroups[].<br>scalePolicy.<br>autoScale.<br>minSize | **string** (int64)<br><p>Minimum number of nodes in the node group.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
nodeGroups[].<br>scalePolicy.<br>autoScale.<br>maxSize | **string** (int64)<br><p>Maximum number of nodes in the node group.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
nodeGroups[].<br>scalePolicy.<br>autoScale.<br>initialSize | **string** (int64)<br><p>Initial number of nodes in the node group.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
nodeGroups[].<br>allocationPolicy | **object**<br><p>Allocation policy by which resources for node group are allocated to zones and regions.</p> 
nodeGroups[].<br>allocationPolicy.<br>locations[] | **object**<br><p>List of locations where resources for the node group will be allocated.</p> 
nodeGroups[].<br>allocationPolicy.<br>locations[].<br>zoneId | **string**<br><p>Required. ID of the availability zone where the nodes may reside.</p> 
nodeGroups[].<br>allocationPolicy.<br>locations[].<br>subnetId | **string**<br><p>ID of the subnet. If a network chosen for the Kubernetes cluster has only one subnet in the specified zone, subnet ID may be omitted.</p> 
nodeGroups[].<br>deployPolicy | **object**<br><p>Deploy policy according to which the updates are rolled out.</p> 
nodeGroups[].<br>deployPolicy.<br>maxUnavailable | **string** (int64)<br><p>The maximum number of running instances that can be taken offline (i.e., stopped or deleted) at the same time during the update process. If ``maxExpansion`` is not specified or set to zero, ``maxUnavailable`` must be set to a non-zero value.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
nodeGroups[].<br>deployPolicy.<br>maxExpansion | **string** (int64)<br><p>The maximum number of instances that can be temporarily allocated above the group's target size during the update process. If ``maxUnavailable`` is not specified or set to zero, ``maxExpansion`` must be set to a non-zero value.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
nodeGroups[].<br>instanceGroupId | **string**<br><p>ID of the managed instance group associated with this node group.</p> 
nodeGroups[].<br>nodeVersion | **string**<br><p>Version of Kubernetes components that runs on the nodes. Deprecated. Use version_info.current_version.</p> 
nodeGroups[].<br>versionInfo | **object**<br><p>Detailed information about the Kubernetes version that is running on the node.</p> 
nodeGroups[].<br>versionInfo.<br>currentVersion | **string**<br><p>Current Kubernetes version, format: major.minor (e.g. 1.15).</p> 
nodeGroups[].<br>versionInfo.<br>newRevisionAvailable | **boolean** (boolean)<br><p>Newer revisions may include Kubernetes patches (e.g 1.15.1 -&gt; 1.15.2) as well as some internal component updates - new features or bug fixes in platform specific components either on the master or nodes.</p> 
nodeGroups[].<br>versionInfo.<br>newRevisionSummary | **string**<br><p>Description of the changes to be applied when updating to the latest revision. Empty if new_revision_available is false.</p> 
nodeGroups[].<br>versionInfo.<br>versionDeprecated | **boolean** (boolean)<br><p>The current version is on the deprecation schedule, component (master or node group) should be upgraded.</p> 
nodeGroups[].<br>maintenancePolicy | **object**<br><p>Maintenance policy of the node group.</p> 
nodeGroups[].<br>maintenancePolicy.<br>autoUpgrade | **boolean** (boolean)<br><p>If set to true, automatic updates are installed in the specified period of time with no interaction from the user. If set to false, automatic upgrades are disabled.</p> 
nodeGroups[].<br>maintenancePolicy.<br>autoRepair | **boolean** (boolean)<br><p>If set to true, automatic repairs are enabled. Default value is false.</p> 
nodeGroups[].<br>maintenancePolicy.<br>maintenanceWindow | **object**<br><p>Maintenance window settings. Update will start at the specified time and last no more than the specified duration. The time is set in UTC.</p> 
nodeGroups[].<br>maintenancePolicy.<br>maintenanceWindow.<br>anytime | **object**<br>Updating the master at any time. <br>`nodeGroups[].maintenancePolicy.maintenanceWindow` includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`<br>
nodeGroups[].<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow | **object**<br>Updating the master on any day during the specified time window. <br>`nodeGroups[].maintenancePolicy.maintenanceWindow` includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`<br>
nodeGroups[].<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime | **object**<br><p>Required. Window start time, in the UTC timezone.</p> <p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
nodeGroups[].<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value "24:00:00" for scenarios like business closing time.</p> 
nodeGroups[].<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
nodeGroups[].<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
nodeGroups[].<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
nodeGroups[].<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>duration | **string**<br><p>Window duration.</p> <p>Acceptable values are 3600 seconds to 86400 seconds, inclusive.</p> 
nodeGroups[].<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow | **object**<br>Updating the master on selected days during the specified time window. <br>`nodeGroups[].maintenancePolicy.maintenanceWindow` includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`<br>
nodeGroups[].<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[] | **object**<br><p>Required. Days of the week and the maintenance window for these days when automatic updates are allowed.</p> <p>The number of elements must be in the range 1-7.</p> 
nodeGroups[].<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>days[] | **string**<br><p>Required. Days of the week when automatic updates are allowed.</p> <p>The number of elements must be in the range 1-7.</p> <ul> <li>MONDAY: The day-of-week of Monday.</li> <li>TUESDAY: The day-of-week of Tuesday.</li> <li>WEDNESDAY: The day-of-week of Wednesday.</li> <li>THURSDAY: The day-of-week of Thursday.</li> <li>FRIDAY: The day-of-week of Friday.</li> <li>SATURDAY: The day-of-week of Saturday.</li> <li>SUNDAY: The day-of-week of Sunday.</li> </ul> 
nodeGroups[].<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime | **object**<br><p>Required. Window start time, in the UTC timezone.</p> <p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
nodeGroups[].<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value "24:00:00" for scenarios like business closing time.</p> 
nodeGroups[].<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
nodeGroups[].<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
nodeGroups[].<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
nodeGroups[].<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>duration | **string**<br><p>Window duration.</p> <p>Acceptable values are 3600 seconds to 86400 seconds, inclusive.</p> 
nodeGroups[].<br>allowedUnsafeSysctls[] | **string**<br><p>Support for unsafe sysctl parameters. For more details see <a href="https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/">documentation</a>.</p> 
nodeGroups[].<br>nodeTaints[] | **object**<br><p>Taints that are applied to the nodes of the node group at creation time.</p> 
nodeGroups[].<br>nodeTaints[].<br>key | **string**<br><p>The taint key to be applied to a node.</p> 
nodeGroups[].<br>nodeTaints[].<br>value | **string**<br><p>The taint value corresponding to the taint key.</p> 
nodeGroups[].<br>nodeTaints[].<br>effect | **string**<br><p>The effect of the taint on pods that do not tolerate the taint.</p> <ul> <li>NO_SCHEDULE: Do not allow new pods to schedule onto the node unless they tolerate the taint, but allow all pods submitted to Kubelet without going through the scheduler to start, and allow all already-running pods to continue running.</li> <li>PREFER_NO_SCHEDULE: Like NO_SCHEDULE, but the scheduler tries not to schedule new pods onto the node, rather than prohibiting new pods from scheduling onto the node entirely. Enforced by the scheduler.</li> <li>NO_EXECUTE: Evict any already-running pods that do not tolerate the taint.</li> </ul> 
nodeGroups[].<br>nodeLabels | **object**<br><p>Labels that are assigned to the nodes of the node group at creation time.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-kubernetes/api-ref/Cluster/listNodeGroups#query_params">pageSize</a>, use the ``next_page_token`` as the value for the <a href="/docs/managed-kubernetes/api-ref/Cluster/listNodeGroups#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own ``next_page_token`` to continue paging through the results.</p> 