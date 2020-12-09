---
editable: false
---

# Method list
Retrieves the list of InstanceGroup resources in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://compute.api.cloud.yandex.net/compute/v1/instanceGroups
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | Required. ID of the folder to list instance groups in. To get the folder ID, use a [list](/docs/resource-manager/api-ref/Folder/list) request.
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/compute/api-ref/InstanceGroup/list#query_params), the service returns a [nextPageToken](/docs/compute/api-ref/InstanceGroup/list#responses) that can be used to get the next page of results in subsequent list requests.  The maximum value is 1000.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/compute/api-ref/InstanceGroup/list#query_params) to the [nextPageToken](/docs/compute/api-ref/InstanceGroup/list#responses) returned by a previous list request.  The maximum string length in characters is 100.
filter | A filter expression that filters resources listed in the response. Currently you can use filtering only on the [InstanceGroup.name](/docs/compute/api-ref/InstanceGroup#representation) field.  The maximum string length in characters is 1000.
view | Defines which information about the Instance template should be returned in the server response.<ul> <li>BASIC: Doesn't include the metadata of the instance template in the server response.</li> <li>FULL: Returns the metadata of the instance template in the server response.</li> </ul> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "instanceGroups": [
    {
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
            "preserveAfterInstanceDelete": true,

            // `instanceGroups[].instanceTemplate.bootDiskSpec.diskSpec` includes only one of the fields `imageId`, `snapshotId`
            "imageId": "string",
            "snapshotId": "string",
            // end of the list of possible fields`instanceGroups[].instanceTemplate.bootDiskSpec.diskSpec`

          },
          "diskId": "string"
        },
        "secondaryDiskSpecs": [
          {
            "mode": "string",
            "deviceName": "string",
            "diskSpec": {
              "description": "string",
              "typeId": "string",
              "size": "string",
              "preserveAfterInstanceDelete": true,

              // `instanceGroups[].instanceTemplate.secondaryDiskSpecs[].diskSpec` includes only one of the fields `imageId`, `snapshotId`
              "imageId": "string",
              "snapshotId": "string",
              // end of the list of possible fields`instanceGroups[].instanceTemplate.secondaryDiskSpecs[].diskSpec`

            },
            "diskId": "string"
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
                "address": "string"
              }
            },
            "primaryV6AddressSpec": {
              "oneToOneNatSpec": {
                "ipVersion": "string",
                "address": "string"
              }
            },
            "securityGroupIds": [
              "string"
            ]
          }
        ],
        "schedulingPolicy": {
          "preemptible": true
        },
        "serviceAccountId": "string",
        "networkSettings": {
          "type": "string"
        },
        "name": "string",
        "hostname": "string",
        "placementPolicy": {
          "placementGroupId": "string"
        }
      },
      "scalePolicy": {
        "testAutoScale": {
          "minZoneSize": "string",
          "maxSize": "string",
          "measurementDuration": "string",
          "warmupDuration": "string",
          "stabilizationDuration": "string",
          "initialSize": "string",
          "cpuUtilizationRule": {
            "utilizationTarget": "number"
          },
          "customRules": [
            {
              "ruleType": "string",
              "metricType": "string",
              "metricName": "string",
              "labels": "object",
              "target": "number",
              "folderId": "string",
              "service": "string"
            }
          ]
        },

        // `instanceGroups[].scalePolicy` includes only one of the fields `fixedScale`, `autoScale`
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
            "utilizationTarget": "number"
          },
          "customRules": [
            {
              "ruleType": "string",
              "metricType": "string",
              "metricName": "string",
              "labels": "object",
              "target": "number",
              "folderId": "string",
              "service": "string"
            }
          ]
        },
        // end of the list of possible fields`instanceGroups[].scalePolicy`

      },
      "deployPolicy": {
        "maxUnavailable": "string",
        "maxDeleting": "string",
        "maxCreating": "string",
        "maxExpansion": "string",
        "startupDuration": "string",
        "strategy": "string"
      },
      "allocationPolicy": {
        "zones": [
          {
            "zoneId": "string"
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
        }
      },
      "healthChecksSpec": {
        "healthCheckSpecs": [
          {
            "interval": "string",
            "timeout": "string",
            "unhealthyThreshold": "string",
            "healthyThreshold": "string",

            // `instanceGroups[].healthChecksSpec.healthCheckSpecs[]` includes only one of the fields `tcpOptions`, `httpOptions`
            "tcpOptions": {
              "port": "string"
            },
            "httpOptions": {
              "port": "string",
              "path": "string"
            },
            // end of the list of possible fields`instanceGroups[].healthChecksSpec.healthCheckSpecs[]`

          }
        ]
      },
      "serviceAccountId": "string",
      "status": "string",
      "variables": [
        {
          "key": "string",
          "value": "string"
        }
      ],
      "deletionProtection": true
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
instanceGroups[] | **object**<br><p>Lists instance groups for the specified folder.</p> 
instanceGroups[].<br>id | **string**<br><p>ID of the instance group.</p> 
instanceGroups[].<br>folderId | **string**<br><p>ID of the folder that the instance group belongs to.</p> 
instanceGroups[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
instanceGroups[].<br>name | **string**<br><p>Name of the instance group. The name is unique within the folder.</p> 
instanceGroups[].<br>description | **string**<br><p>Description of the instance group.</p> 
instanceGroups[].<br>labels | **object**<br><p>Resource labels as `key:value` pairs.</p> 
instanceGroups[].<br>instanceTemplate | **object**<br><p>Instance template for creating the instance group. For more information, see <a href="/docs/compute/concepts/instance-groups/instance-template">Instance Templates</a>.</p> 
instanceGroups[].<br>instanceTemplate.<br>description | **string**<br><p>Description of the instance template.</p> <p>The maximum string length in characters is 256.</p> 
instanceGroups[].<br>instanceTemplate.<br>labels | **object**<br><p>Resource labels as `key:value` pairs.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression `` [a-z][-_./@0-9a-z]* ``. The maximum string length in characters for each value is 128.</p> 
instanceGroups[].<br>instanceTemplate.<br>platformId | **string**<br><p>Required. ID of the hardware platform configuration for the instance. Platforms allows you to create various types of instances: with a large amount of memory, with a large number of cores, with a burstable performance. For more information, see <a href="/docs/compute/concepts/vm-platforms">Platforms</a>.</p> 
instanceGroups[].<br>instanceTemplate.<br>resourcesSpec | **object**<br><p>Required. Computing resources of the instance such as the amount of memory and number of cores.</p> 
instanceGroups[].<br>instanceTemplate.<br>resourcesSpec.<br>memory | **string** (int64)<br><p>The amount of memory available to the instance, specified in bytes.</p> <p>The maximum value is 824633720832.</p> 
instanceGroups[].<br>instanceTemplate.<br>resourcesSpec.<br>cores | **string** (int64)<br><p>The number of cores available to the instance.</p> <p>Value must be one of 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 40, 44, 48, 52, 56, 60, 64, 68, 72, 76 or 80.</p> 
instanceGroups[].<br>instanceTemplate.<br>resourcesSpec.<br>coreFraction | **string** (int64)<br><p>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core.</p> <p>Value must be one of 0, 5, 20, 50 or 100.</p> 
instanceGroups[].<br>instanceTemplate.<br>resourcesSpec.<br>gpus | **string** (int64)<br><p>The number of GPUs available to the instance.</p> <p>Value must be one of 0, 1, 2 or 4.</p> 
instanceGroups[].<br>instanceTemplate.<br>metadata | **object**<br><p>The metadata `key:value` pairs assigned to this instance template. This includes custom metadata and predefined keys.</p> <p>Metadata values may contain one of the supported placeholders: {instance_group.id} {instance.short_id} {instance.index} {instance.index_in_zone} {instance.zone_id} InstanceGroup and Instance labels may be copied to metadata following way: {instance_group.labels.some_label_key} {instance.labels.another_label_key} These placeholders will be substituted for each created instance anywhere in the value text. In the rare case the value requires to contain this placeholder explicitly, it must be escaped with double brackets, in example {instance.index}.</p> <p>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see <a href="/docs/compute/concepts/vm-metadata">Metadata</a>.</p> <p>No more than 128 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression `` [a-z][-_0-9a-z]* ``. The maximum string length in characters for each value is 262144.</p> 
instanceGroups[].<br>instanceTemplate.<br>bootDiskSpec | **object**<br><p>Required. Boot disk specification that will be attached to the instance.</p> 
instanceGroups[].<br>instanceTemplate.<br>bootDiskSpec.<br>mode | **string**<br><p>Required. Access mode to the Disk resource.</p> <ul> <li>READ_ONLY: Read-only access.</li> <li>READ_WRITE: Read/Write access.</li> </ul> 
instanceGroups[].<br>instanceTemplate.<br>bootDiskSpec.<br>deviceName | **string**<br><p>Serial number that is reflected in the /dev/disk/by-id/ tree of a Linux operating system running within the instance.</p> <p>This value can be used to reference the device for mounting, resizing, and so on, from within the instance.</p> <p>Value must match the regular expression `` \|[a-z][-_0-9a-z]{0,19} ``.</p> 
instanceGroups[].<br>instanceTemplate.<br>bootDiskSpec.<br>diskSpec | **object**<br><p>Required. oneof disk_spec or disk_id Disk specification that is attached to the instance. For more information, see <a href="/docs/compute/concepts/disk">Disks</a>.</p> 
instanceGroups[].<br>instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>description | **string**<br><p>Description of the disk.</p> <p>The maximum string length in characters is 256.</p> 
instanceGroups[].<br>instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>typeId | **string**<br><p>Required. ID of the disk type.</p> 
instanceGroups[].<br>instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>size | **string** (int64)<br><p>Size of the disk, specified in bytes.</p> <p>Acceptable values are 4194304 to 4398046511104, inclusive.</p> 
instanceGroups[].<br>instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>preserveAfterInstanceDelete | **boolean** (boolean)<br><p>When set to true, disk will not be deleted even after managed instance is deleted. It will be a user's responsibility to delete such disks.</p> 
instanceGroups[].<br>instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>imageId | **string** <br>`instanceGroups[].instanceTemplate.bootDiskSpec.diskSpec` includes only one of the fields `imageId`, `snapshotId`<br><br><p>ID of the image that will be used for disk creation.</p> <p>The maximum string length in characters is 50.</p> 
instanceGroups[].<br>instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>snapshotId | **string** <br>`instanceGroups[].instanceTemplate.bootDiskSpec.diskSpec` includes only one of the fields `imageId`, `snapshotId`<br><br><p>ID of the snapshot that will be used for disk creation.</p> <p>The maximum string length in characters is 50.</p> 
instanceGroups[].<br>instanceTemplate.<br>bootDiskSpec.<br>diskId | **string**<br><p>Set to use an existing disk. To set use variables.</p> <p>The maximum string length in characters is 128. Value must match the regular expression `` [-a-zA-Z0-9._{}]* ``.</p> 
instanceGroups[].<br>instanceTemplate.<br>secondaryDiskSpecs[] | **object**<br><p>Array of secondary disks that will be attached to the instance.</p> <p>The maximum number of elements is 3.</p> 
instanceGroups[].<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>mode | **string**<br><p>Required. Access mode to the Disk resource.</p> <ul> <li>READ_ONLY: Read-only access.</li> <li>READ_WRITE: Read/Write access.</li> </ul> 
instanceGroups[].<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>deviceName | **string**<br><p>Serial number that is reflected in the /dev/disk/by-id/ tree of a Linux operating system running within the instance.</p> <p>This value can be used to reference the device for mounting, resizing, and so on, from within the instance.</p> <p>Value must match the regular expression `` \|[a-z][-_0-9a-z]{0,19} ``.</p> 
instanceGroups[].<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec | **object**<br><p>Required. oneof disk_spec or disk_id Disk specification that is attached to the instance. For more information, see <a href="/docs/compute/concepts/disk">Disks</a>.</p> 
instanceGroups[].<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>description | **string**<br><p>Description of the disk.</p> <p>The maximum string length in characters is 256.</p> 
instanceGroups[].<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>typeId | **string**<br><p>Required. ID of the disk type.</p> 
instanceGroups[].<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>size | **string** (int64)<br><p>Size of the disk, specified in bytes.</p> <p>Acceptable values are 4194304 to 4398046511104, inclusive.</p> 
instanceGroups[].<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>preserveAfterInstanceDelete | **boolean** (boolean)<br><p>When set to true, disk will not be deleted even after managed instance is deleted. It will be a user's responsibility to delete such disks.</p> 
instanceGroups[].<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>imageId | **string** <br>`instanceGroups[].instanceTemplate.secondaryDiskSpecs[].diskSpec` includes only one of the fields `imageId`, `snapshotId`<br><br><p>ID of the image that will be used for disk creation.</p> <p>The maximum string length in characters is 50.</p> 
instanceGroups[].<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>snapshotId | **string** <br>`instanceGroups[].instanceTemplate.secondaryDiskSpecs[].diskSpec` includes only one of the fields `imageId`, `snapshotId`<br><br><p>ID of the snapshot that will be used for disk creation.</p> <p>The maximum string length in characters is 50.</p> 
instanceGroups[].<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>diskId | **string**<br><p>Set to use an existing disk. To set use variables.</p> <p>The maximum string length in characters is 128. Value must match the regular expression `` [-a-zA-Z0-9._{}]* ``.</p> 
instanceGroups[].<br>instanceTemplate.<br>networkInterfaceSpecs[] | **object**<br><p>Required. Array of network interfaces that will be attached to the instance.</p> <p>Must contain exactly 1 element.</p> 
instanceGroups[].<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>networkId | **string**<br><p>ID of the network.</p> 
instanceGroups[].<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>subnetIds[] | **string**<br><p>IDs of the subnets.</p> 
instanceGroups[].<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec | **object**<br><p>Primary IPv4 address that is assigned to the instance for this network interface.</p> 
instanceGroups[].<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec | **object**<br><p>An external IP address configuration. If not specified, then this managed instance will have no external internet access.</p> 
instanceGroups[].<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec.<br>ipVersion | **string**<br><p>IP version for the public IP address.</p> <ul> <li>IPV4: IPv4 address, for example 192.168.0.0.</li> <li>IPV6: IPv6 address, not available yet.</li> </ul> 
instanceGroups[].<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec.<br>address | **string**<br><p>Manual set static public IP. To set use variables. (optional)</p> 
instanceGroups[].<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec | **object**<br><p>Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet.</p> 
instanceGroups[].<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec | **object**<br><p>An external IP address configuration. If not specified, then this managed instance will have no external internet access.</p> 
instanceGroups[].<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec.<br>ipVersion | **string**<br><p>IP version for the public IP address.</p> <ul> <li>IPV4: IPv4 address, for example 192.168.0.0.</li> <li>IPV6: IPv6 address, not available yet.</li> </ul> 
instanceGroups[].<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec.<br>address | **string**<br><p>Manual set static public IP. To set use variables. (optional)</p> 
instanceGroups[].<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>securityGroupIds[] | **string**<br><p>IDs of security groups.</p> 
instanceGroups[].<br>instanceTemplate.<br>schedulingPolicy | **object**<br><p>Scheduling policy for the instance.</p> 
instanceGroups[].<br>instanceTemplate.<br>schedulingPolicy.<br>preemptible | **boolean** (boolean)<br><p>Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time if their resources are needed by Compute. For more information, see <a href="/docs/compute/concepts/preemptible-vm">Preemptible Virtual Machines</a>.</p> 
instanceGroups[].<br>instanceTemplate.<br>serviceAccountId | **string**<br><p>Service account ID for the instance.</p> 
instanceGroups[].<br>instanceTemplate.<br>networkSettings | **object**<br><p>Network settings for the instance.</p> 
instanceGroups[].<br>instanceTemplate.<br>networkSettings.<br>type | **string**<br><p>Type of instance network.</p> 
instanceGroups[].<br>instanceTemplate.<br>name | **string**<br><p>Name of the instance. In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, default is used: {instance_group.id}-{instance.short_id} It may also contain another placeholders, see metadata doc for full list.</p> <p>The maximum string length in characters is 128.</p> 
instanceGroups[].<br>instanceTemplate.<br>hostname | **string**<br><p>Host name for the instance. This field is used to generate the <a href="/docs/compute/api-ref/Instance#representation">Instance.fqdn</a> value. The host name must be unique within the network and region. If not specified, the host name will be equal to <a href="/docs/compute/api-ref/Instance#representation">Instance.id</a> of the instance and FQDN will be `<id>.auto.internal`. Otherwise FQDN will be `<hostname>.&lt;region_id&gt;.internal`.</p> <p>In order to be unique it must contain at least on of instance unique placeholders: {instance.short_id} {instance.index} combination of {instance.zone_id} and {instance.index_in_zone} Example: my-instance-{instance.index} If not set, `name` value will be used It may also contain another placeholders, see metadata doc for full list.</p> <p>The maximum string length in characters is 128.</p> 
instanceGroups[].<br>instanceTemplate.<br>placementPolicy | **object**<br><p>Placement Group</p> 
instanceGroups[].<br>instanceTemplate.<br>placementPolicy.<br>placementGroupId | **string**<br><p>Identifier of placement group</p> 
instanceGroups[].<br>scalePolicy | **object**<br><p><a href="/docs/compute/concepts/instance-groups/scale">Scaling policy</a> of the instance group.</p> 
instanceGroups[].<br>scalePolicy.<br>testAutoScale | **object**<br>[Automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group.<br>
instanceGroups[].<br>scalePolicy.<br>testAutoScale.<br>minZoneSize | **string** (int64)<br><p>Lower limit for instance count in each zone.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
instanceGroups[].<br>scalePolicy.<br>testAutoScale.<br>maxSize | **string** (int64)<br><p>Upper limit for total instance count (across all zones). 0 means maximum limit = 100.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
instanceGroups[].<br>scalePolicy.<br>testAutoScale.<br>measurementDuration | **string**<br><p>Required. Time in seconds allotted for averaging metrics.</p> <p>Acceptable values are 60 seconds to 600 seconds, inclusive.</p> 
instanceGroups[].<br>scalePolicy.<br>testAutoScale.<br>warmupDuration | **string**<br><p>The warmup time of the instance in seconds. During this time, traffic is sent to the instance, but instance metrics are not collected.</p> <p>The maximum value is 600 seconds.</p> 
instanceGroups[].<br>scalePolicy.<br>testAutoScale.<br>stabilizationDuration | **string**<br><p>Minimum amount of time in seconds allotted for monitoring before Instance Groups can reduce the number of instances in the group. During this time, the group size doesn't decrease, even if the new metric values indicate that it should.</p> <p>Acceptable values are 60 seconds to 1800 seconds, inclusive.</p> 
instanceGroups[].<br>scalePolicy.<br>testAutoScale.<br>initialSize | **string** (int64)<br><p>Target group size.</p> <p>The minimum value is 1.</p> 
instanceGroups[].<br>scalePolicy.<br>testAutoScale.<br>cpuUtilizationRule | **object**<br><p>Defines an autoscaling rule based on the average CPU utilization of the instance group.</p> 
instanceGroups[].<br>scalePolicy.<br>testAutoScale.<br>cpuUtilizationRule.<br>utilizationTarget | **number** (double)<br><p>Target CPU utilization level. Instance Groups maintains this level for each availability zone.</p> <p>Acceptable values are 10 to 100, inclusive.</p> 
instanceGroups[].<br>scalePolicy.<br>testAutoScale.<br>customRules[] | **object**<br><p>Defines an autoscaling rule based on a <a href="/docs/monitoring/operations/metric/add">custom metric</a> from Yandex Monitoring.</p> <p>The maximum number of elements is 1.</p> 
instanceGroups[].<br>scalePolicy.<br>testAutoScale.<br>customRules[].<br>ruleType | **string**<br><p>Required. Custom metric rule type. This field affects which label from the custom metric should be used: `zone_id` or `instance_id`.</p> <ul> <li>UTILIZATION: This type means that the metric applies to one instance. First, Instance Groups calculates the average metric value for each instance, then averages the values for instances in one availability zone. This type of metric must have the `instance_id` label.</li> <li>WORKLOAD: This type means that the metric applies to instances in one availability zone. This type of metric must have the `zone_id` label.</li> </ul> 
instanceGroups[].<br>scalePolicy.<br>testAutoScale.<br>customRules[].<br>metricType | **string**<br><p>Required. Type of custom metric. This field affects how Instance Groups calculates the average metric value.</p> <ul> <li>GAUGE: This type is used for metrics that show the metric value at a certain point in time, such as requests per second to the server on an instance.</li> </ul> <p>Instance Groups calculates the average metric value for the period specified in the `measurementDuration` field.</p> <ul> <li>COUNTER: This type is used for metrics that monotonically increase over time, such as the total number of requests to the server on an instance.</li> </ul> <p>Instance Groups calculates the average value increase for the period specified in the `measurementDuration` field.</p> 
instanceGroups[].<br>scalePolicy.<br>testAutoScale.<br>customRules[].<br>metricName | **string**<br><p>Required. Name of custom metric in Yandex Monitoring that should be used for scaling.</p> <p>Value must match the regular expression `` [a-zA-Z0-9./@<em>][ 0-9a-zA-Z./@</em>,:;()[]&lt;&gt;-]{0,198} ``.</p> 
instanceGroups[].<br>scalePolicy.<br>testAutoScale.<br>customRules[].<br>labels | **object**<br><p>Labels of custom metric in Yandex Monitoring that should be used for scaling.</p> <p>Each key must match the regular expression `` ^[a-zA-Z][0-9a-zA-Z_]{0,31}$ ``. Each value must match the regular expression `` [a-zA-Z0-9./@<em>][ 0-9a-zA-Z./@</em>,:;()[]&lt;&gt;-]{0,198} ``.</p> 
instanceGroups[].<br>scalePolicy.<br>testAutoScale.<br>customRules[].<br>target | **number** (double)<br><p>Target value for the custom metric. Instance Groups maintains this level for each availability zone.</p> <p>Value must be greater than 0.</p> 
instanceGroups[].<br>scalePolicy.<br>testAutoScale.<br>customRules[].<br>folderId | **string**<br><p>Folder id of custom metric in Yandex Monitoring that should be used for scaling.</p> <p>The maximum string length in characters is 50.</p> 
instanceGroups[].<br>scalePolicy.<br>testAutoScale.<br>customRules[].<br>service | **string**<br><p>Service of custom metric in Yandex Monitoring that should be used for scaling.</p> <p>The maximum string length in characters is 200.</p> 
instanceGroups[].<br>scalePolicy.<br>fixedScale | **object**<br>[Manual scaling policy](/docs/compute/concepts/instance-groups/scale#fixed-policy) of the instance group. <br>`instanceGroups[].scalePolicy` includes only one of the fields `fixedScale`, `autoScale`<br><br>
instanceGroups[].<br>scalePolicy.<br>fixedScale.<br>size | **string** (int64)<br><p>Number of instances in the instance group.</p> <p>Acceptable values are 1 to 100, inclusive.</p> 
instanceGroups[].<br>scalePolicy.<br>autoScale | **object**<br>Test spec for [automatic scaling policy](/docs/compute/concepts/instance-groups/scale#auto-scale) of the instance group. <br>`instanceGroups[].scalePolicy` includes only one of the fields `fixedScale`, `autoScale`<br><br>
instanceGroups[].<br>scalePolicy.<br>autoScale.<br>minZoneSize | **string** (int64)<br><p>Lower limit for instance count in each zone.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
instanceGroups[].<br>scalePolicy.<br>autoScale.<br>maxSize | **string** (int64)<br><p>Upper limit for total instance count (across all zones). 0 means maximum limit = 100.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
instanceGroups[].<br>scalePolicy.<br>autoScale.<br>measurementDuration | **string**<br><p>Required. Time in seconds allotted for averaging metrics.</p> <p>Acceptable values are 60 seconds to 600 seconds, inclusive.</p> 
instanceGroups[].<br>scalePolicy.<br>autoScale.<br>warmupDuration | **string**<br><p>The warmup time of the instance in seconds. During this time, traffic is sent to the instance, but instance metrics are not collected.</p> <p>The maximum value is 600 seconds.</p> 
instanceGroups[].<br>scalePolicy.<br>autoScale.<br>stabilizationDuration | **string**<br><p>Minimum amount of time in seconds allotted for monitoring before Instance Groups can reduce the number of instances in the group. During this time, the group size doesn't decrease, even if the new metric values indicate that it should.</p> <p>Acceptable values are 60 seconds to 1800 seconds, inclusive.</p> 
instanceGroups[].<br>scalePolicy.<br>autoScale.<br>initialSize | **string** (int64)<br><p>Target group size.</p> <p>The minimum value is 1.</p> 
instanceGroups[].<br>scalePolicy.<br>autoScale.<br>cpuUtilizationRule | **object**<br><p>Defines an autoscaling rule based on the average CPU utilization of the instance group.</p> 
instanceGroups[].<br>scalePolicy.<br>autoScale.<br>cpuUtilizationRule.<br>utilizationTarget | **number** (double)<br><p>Target CPU utilization level. Instance Groups maintains this level for each availability zone.</p> <p>Acceptable values are 10 to 100, inclusive.</p> 
instanceGroups[].<br>scalePolicy.<br>autoScale.<br>customRules[] | **object**<br><p>Defines an autoscaling rule based on a <a href="/docs/monitoring/operations/metric/add">custom metric</a> from Yandex Monitoring.</p> <p>The maximum number of elements is 1.</p> 
instanceGroups[].<br>scalePolicy.<br>autoScale.<br>customRules[].<br>ruleType | **string**<br><p>Required. Custom metric rule type. This field affects which label from the custom metric should be used: `zone_id` or `instance_id`.</p> <ul> <li>UTILIZATION: This type means that the metric applies to one instance. First, Instance Groups calculates the average metric value for each instance, then averages the values for instances in one availability zone. This type of metric must have the `instance_id` label.</li> <li>WORKLOAD: This type means that the metric applies to instances in one availability zone. This type of metric must have the `zone_id` label.</li> </ul> 
instanceGroups[].<br>scalePolicy.<br>autoScale.<br>customRules[].<br>metricType | **string**<br><p>Required. Type of custom metric. This field affects how Instance Groups calculates the average metric value.</p> <ul> <li>GAUGE: This type is used for metrics that show the metric value at a certain point in time, such as requests per second to the server on an instance.</li> </ul> <p>Instance Groups calculates the average metric value for the period specified in the `measurementDuration` field.</p> <ul> <li>COUNTER: This type is used for metrics that monotonically increase over time, such as the total number of requests to the server on an instance.</li> </ul> <p>Instance Groups calculates the average value increase for the period specified in the `measurementDuration` field.</p> 
instanceGroups[].<br>scalePolicy.<br>autoScale.<br>customRules[].<br>metricName | **string**<br><p>Required. Name of custom metric in Yandex Monitoring that should be used for scaling.</p> <p>Value must match the regular expression `` [a-zA-Z0-9./@<em>][ 0-9a-zA-Z./@</em>,:;()[]&lt;&gt;-]{0,198} ``.</p> 
instanceGroups[].<br>scalePolicy.<br>autoScale.<br>customRules[].<br>labels | **object**<br><p>Labels of custom metric in Yandex Monitoring that should be used for scaling.</p> <p>Each key must match the regular expression `` ^[a-zA-Z][0-9a-zA-Z_]{0,31}$ ``. Each value must match the regular expression `` [a-zA-Z0-9./@<em>][ 0-9a-zA-Z./@</em>,:;()[]&lt;&gt;-]{0,198} ``.</p> 
instanceGroups[].<br>scalePolicy.<br>autoScale.<br>customRules[].<br>target | **number** (double)<br><p>Target value for the custom metric. Instance Groups maintains this level for each availability zone.</p> <p>Value must be greater than 0.</p> 
instanceGroups[].<br>scalePolicy.<br>autoScale.<br>customRules[].<br>folderId | **string**<br><p>Folder id of custom metric in Yandex Monitoring that should be used for scaling.</p> <p>The maximum string length in characters is 50.</p> 
instanceGroups[].<br>scalePolicy.<br>autoScale.<br>customRules[].<br>service | **string**<br><p>Service of custom metric in Yandex Monitoring that should be used for scaling.</p> <p>The maximum string length in characters is 200.</p> 
instanceGroups[].<br>deployPolicy | **object**<br><p>Deployment policy of the instance group.</p> 
instanceGroups[].<br>deployPolicy.<br>maxUnavailable | **string** (int64)<br><p>The maximum number of running instances that can be taken offline (i.e., stopped or deleted) at the same time during the update process. If `maxExpansion` is not specified or set to zero, `maxUnavailable` must be set to a non-zero value.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
instanceGroups[].<br>deployPolicy.<br>maxDeleting | **string** (int64)<br><p>The maximum number of instances that can be deleted at the same time.</p> <p>The value 0 is any number of virtual machines within the allowed values.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
instanceGroups[].<br>deployPolicy.<br>maxCreating | **string** (int64)<br><p>The maximum number of instances that can be created at the same time.</p> <p>The value 0 is any number of virtual machines within the allowed values.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
instanceGroups[].<br>deployPolicy.<br>maxExpansion | **string** (int64)<br><p>The maximum number of instances that can be temporarily allocated above the group's target size during the update process. If `maxUnavailable` is not specified or set to zero, `maxExpansion` must be set to a non-zero value.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
instanceGroups[].<br>deployPolicy.<br>startupDuration | **string**<br><p>Instance startup duration. Instance will be considered up and running (and start receiving traffic) only after startup_duration has elapsed and all health checks are passed. See `ManagedInstanceStatus` for more information.</p> <p>Acceptable values are 0 seconds to 3600 seconds, inclusive.</p> 
instanceGroups[].<br>deployPolicy.<br>strategy | **string**<br><p>Affects the lifecycle of the instance during deployment.</p> <ul> <li>PROACTIVE: Instance Groups can forcefully stop a running instance. This is the default.</li> <li>OPPORTUNISTIC: Instance Groups does not stop a running instance. Instead, it will wait until the instance stops itself or becomes unhealthy.</li> </ul> 
instanceGroups[].<br>allocationPolicy | **object**<br><p>Allocation policy of the instance group by zones and regions.</p> 
instanceGroups[].<br>allocationPolicy.<br>zones[] | **object**<br><p>Required. List of availability zones.</p> <p>The minimum number of elements is 1.</p> 
instanceGroups[].<br>allocationPolicy.<br>zones[].<br>zoneId | **string**<br><p>Required. ID of the availability zone where the instance resides.</p> 
instanceGroups[].<br>loadBalancerState | **object**<br><p>Information that indicates which entities can be related to this load balancer.</p> 
instanceGroups[].<br>loadBalancerState.<br>targetGroupId | **string**<br><p>ID of the target group used for load balancing.</p> 
instanceGroups[].<br>loadBalancerState.<br>statusMessage | **string**<br><p>Status message of the target group.</p> 
instanceGroups[].<br>managedInstancesState | **object**<br><p>States of instances for this instance group.</p> 
instanceGroups[].<br>managedInstancesState.<br>targetSize | **string** (int64)<br><p>Target number of instances for this instance group.</p> 
instanceGroups[].<br>managedInstancesState.<br>runningActualCount | **string** (int64)<br><p>The number of running instances that match the current instance template. For more information, see `RUNNING_ACTUAL`.</p> 
instanceGroups[].<br>managedInstancesState.<br>runningOutdatedCount | **string** (int64)<br><p>The number of running instances that does not match the current instance template. For more information, see `RUNNING_OUTDATED`.</p> 
instanceGroups[].<br>managedInstancesState.<br>processingCount | **string** (int64)<br><p>The number of instances in flight (for example, updating, starting, deleting). For more information, see `ManagedInstanceStatus`.</p> 
instanceGroups[].<br>loadBalancerSpec | **object**<br><p>Load balancing specification.</p> 
instanceGroups[].<br>loadBalancerSpec.<br>targetGroupSpec | **object**<br><p>Specification of the target group that the instance group will be added to. For more information, see <a href="/docs/load-balancer/concepts/target-resources">Target groups and resources</a>.</p> 
instanceGroups[].<br>loadBalancerSpec.<br>targetGroupSpec.<br>name | **string**<br><p>Name of the target group.</p> <p>Value must match the regular expression `` \|<a href="%5B-a-z0-9%5D%7B0,61%7D%5Ba-z0-9%5D">a-z</a>? ``.</p> 
instanceGroups[].<br>loadBalancerSpec.<br>targetGroupSpec.<br>description | **string**<br><p>Description of the target group.</p> <p>The maximum string length in characters is 256.</p> 
instanceGroups[].<br>loadBalancerSpec.<br>targetGroupSpec.<br>labels | **object**<br><p>Resource labels as `key:value` pairs.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression `` [a-z][-<em>./@0-9a-z]* ``. The maximum string length in characters for each value is 63. Each value must match the regular expression `` [-</em>./@0-9a-z]* ``.</p> 
instanceGroups[].<br>healthChecksSpec | **object**<br><p>Health checking specification. For more information, see <a href="/docs/load-balancer/concepts/health-check">Health check</a>.</p> 
instanceGroups[].<br>healthChecksSpec.<br>healthCheckSpecs[] | **object**<br><p>Required. Health checking specification. For more information, see <a href="/docs/load-balancer/concepts/health-check">Health check</a>.</p> <p>The minimum number of elements is 1.</p> 
instanceGroups[].<br>healthChecksSpec.<br>healthCheckSpecs[].<br>interval | **string**<br><p>The interval between health checks. The default is 2 seconds.</p> <p>Acceptable values are 1 seconds to 300 seconds, inclusive.</p> 
instanceGroups[].<br>healthChecksSpec.<br>healthCheckSpecs[].<br>timeout | **string**<br><p>Timeout for the managed instance to return a response for the health check. The default is 1 second.</p> <p>Acceptable values are 1 seconds to 60 seconds, inclusive.</p> 
instanceGroups[].<br>healthChecksSpec.<br>healthCheckSpecs[].<br>unhealthyThreshold | **string** (int64)<br><p>The number of failed health checks for the managed instance to be considered unhealthy. The default (0) is 2.</p> <p>Value must be one of 0, 2, 3, 4, 5, 6, 7, 8, 9 or 10.</p> 
instanceGroups[].<br>healthChecksSpec.<br>healthCheckSpecs[].<br>healthyThreshold | **string** (int64)<br><p>The number of successful health checks required in order for the managed instance to be considered healthy. The default (0) is 2.</p> <p>Value must be one of 0, 2, 3, 4, 5, 6, 7, 8, 9 or 10.</p> 
instanceGroups[].<br>healthChecksSpec.<br>healthCheckSpecs[].<br>tcpOptions | **object**<br>Configuration options for a TCP health check. <br>`instanceGroups[].healthChecksSpec.healthCheckSpecs[]` includes only one of the fields `tcpOptions`, `httpOptions`<br><br>
instanceGroups[].<br>healthChecksSpec.<br>healthCheckSpecs[].<br>tcpOptions.<br>port | **string** (int64)<br><p>Port to use for TCP health checks.</p> <p>Acceptable values are 1 to 65535, inclusive.</p> 
instanceGroups[].<br>healthChecksSpec.<br>healthCheckSpecs[].<br>httpOptions | **object**<br>Configuration options for an HTTP health check. <br>`instanceGroups[].healthChecksSpec.healthCheckSpecs[]` includes only one of the fields `tcpOptions`, `httpOptions`<br><br>
instanceGroups[].<br>healthChecksSpec.<br>healthCheckSpecs[].<br>httpOptions.<br>port | **string** (int64)<br><p>Port to use for HTTP health checks.</p> <p>Acceptable values are 1 to 65535, inclusive.</p> 
instanceGroups[].<br>healthChecksSpec.<br>healthCheckSpecs[].<br>httpOptions.<br>path | **string**<br><p>URL path to set for health checking requests.</p> 
instanceGroups[].<br>serviceAccountId | **string**<br><p>ID of the service account. The service account will be used for all API calls made by the Instance Groups component on behalf of the user (for example, creating instances, adding them to load balancer target group, etc.). For more information, see <a href="/docs/iam/concepts/users/service-accounts">Service accounts</a>. To get the service account ID, use a <a href="/docs/iam/api-ref/ServiceAccount/list">list</a> request.</p> 
instanceGroups[].<br>status | **string**<br><p>Status of the instance group.</p> <ul> <li>STARTING: Instance group is being started and will become active soon.</li> <li>ACTIVE: Instance group is active. In this state the group manages its instances and monitors their health, creating, deleting, stopping, updating and starting instances as needed. To stop the instance group, call <a href="/docs/compute/api-ref/InstanceGroup/stop">stop</a>.</li> <li>STOPPING: Instance group is being stopped. Group's instances stop receiving traffic from the load balancer (if any) and are then stopped.</li> <li>STOPPED: Instance group is stopped. In this state the group cannot be updated and does not react to any changes made to its instances. To start the instance group, call <a href="/docs/compute/api-ref/InstanceGroup/start">start</a>.</li> <li>DELETING: Instance group is being deleted.</li> </ul> 
instanceGroups[].<br>variables[] | **object**<br>
instanceGroups[].<br>variables[].<br>key | **string**<br><p>The string length in characters must be 1-128. Value must match the regular expression `` [a-zA-Z0-9._-]* ``.</p> 
instanceGroups[].<br>variables[].<br>value | **string**<br><p>The maximum string length in characters is 128.</p> 
instanceGroups[].<br>deletionProtection | **boolean** (boolean)<br><p>Flag prohibiting deletion of the instance group.</p> <p>Allowed values:</br>- `false`: The instance group can be deleted.</br>- `true`: The instance group cannot be deleted.</p> <p>The default is `false`.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/compute/api-ref/InstanceGroup/list#query_params">pageSize</a>, use <a href="/docs/compute/api-ref/InstanceGroup/list#responses">nextPageToken</a> as the value for the <a href="/docs/compute/api-ref/InstanceGroup/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/compute/api-ref/InstanceGroup/list#responses">nextPageToken</a> to continue paging through the results.</p> 