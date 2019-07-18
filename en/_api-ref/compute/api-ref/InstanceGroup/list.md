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
          "coreFraction": "string"
        },
        "metadata": "object",
        "bootDiskSpec": {
          "mode": "string",
          "deviceName": "string",
          "diskSpec": {
            "description": "string",
            "typeId": "string",
            "size": "string",

            // `instanceGroups[].instanceTemplate.bootDiskSpec.diskSpec` includes only one of the fields `imageId`, `snapshotId`
            "imageId": "string",
            "snapshotId": "string",
            // end of the list of possible fields`instanceGroups[].instanceTemplate.bootDiskSpec.diskSpec`

          }
        },
        "secondaryDiskSpecs": [
          {
            "mode": "string",
            "deviceName": "string",
            "diskSpec": {
              "description": "string",
              "typeId": "string",
              "size": "string",

              // `instanceGroups[].instanceTemplate.secondaryDiskSpecs[].diskSpec` includes only one of the fields `imageId`, `snapshotId`
              "imageId": "string",
              "snapshotId": "string",
              // end of the list of possible fields`instanceGroups[].instanceTemplate.secondaryDiskSpecs[].diskSpec`

            }
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
                "ipVersion": "string"
              }
            },
            "primaryV6AddressSpec": {
              "oneToOneNatSpec": {
                "ipVersion": "string"
              }
            }
          }
        ],
        "schedulingPolicy": {
          "preemptible": true
        },
        "serviceAccountId": "string"
      },
      "scalePolicy": {
        "fixedScale": {
          "size": "string"
        }
      },
      "deployPolicy": {
        "maxUnavailable": "string",
        "maxDeleting": "string",
        "maxCreating": "string",
        "maxExpansion": "string",
        "startupDuration": "string"
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
      "serviceAccountId": "string"
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
instanceGroups[].<br>labels | **object**<br><p>Resource labels as <code>key:value</code> pairs.</p> 
instanceGroups[].<br>instanceTemplate | **object**<br><p>Instance template for creating the instance group. For more information, see <a href="/docs/compute/concepts/ig-instance-templates">Instance Templates</a>.</p> 
instanceGroups[].<br>instanceTemplate.<br>description | **string**<br><p>Description of the instance template.</p> <p>The maximum string length in characters is 256.</p> 
instanceGroups[].<br>instanceTemplate.<br>labels | **object**<br><p>Resource labels as <code>key:value</code> pairs.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression <code>[a-z][-_0-9a-z]*</code>. The maximum string length in characters for each value is 63. Each value must match the regular expression <code>[-_0-9a-z]*</code>.</p> 
instanceGroups[].<br>instanceTemplate.<br>platformId | **string**<br><p>ID of the hardware platform configuration for the instance. Currently only several platforms is available - <code>standard-v1</code>, <code>standard-v2</code>. These platforms are suitable for most tasks. These platforms allows you to create various types of instances: with a large amount of memory, with a large number of cores, with a burstable performance. For more information, see <a href="/docs/compute/concepts/vm-platforms">Platforms</a>.</p> <p>Value must match the regular expression <code>standard-v1\|standard-v2</code>.</p> 
instanceGroups[].<br>instanceTemplate.<br>resourcesSpec | **object**<br><p>Required. Computing resources of the instance such as the amount of memory and number of cores.</p> 
instanceGroups[].<br>instanceTemplate.<br>resourcesSpec.<br>memory | **string** (int64)<br><p>The amount of memory available to the instance, specified in bytes.</p> <p>The maximum value is 274877906944.</p> 
instanceGroups[].<br>instanceTemplate.<br>resourcesSpec.<br>cores | **string** (int64)<br><p>The number of cores available to the instance.</p> <p>Value must be one of 1, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30 or 32.</p> 
instanceGroups[].<br>instanceTemplate.<br>resourcesSpec.<br>coreFraction | **string** (int64)<br><p>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core.</p> <p>Value must be one of 0, 5, 20, 50 or 100.</p> 
instanceGroups[].<br>instanceTemplate.<br>metadata | **object**<br><p>The metadata <code>key:value</code> pairs assigned to this instance template. This includes custom metadata and predefined keys.</p> <p>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see <a href="/docs/compute/concepts/vm-metadata">Metadata</a>.</p> <p>No more than 128 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression <code>[a-z][-_0-9a-z]*</code>. The maximum string length in characters for each value is 262144.</p> 
instanceGroups[].<br>instanceTemplate.<br>bootDiskSpec | **object**<br><p>Required. Boot disk specification that will be attached to the instance.</p> 
instanceGroups[].<br>instanceTemplate.<br>bootDiskSpec.<br>mode | **string**<br><p>Required. Access mode to the Disk resource.</p> <ul> <li>READ_ONLY: Read-only access.</li> <li>READ_WRITE: Read/Write access.</li> </ul> 
instanceGroups[].<br>instanceTemplate.<br>bootDiskSpec.<br>deviceName | **string**<br><p>Serial number that is reflected in the /dev/disk/by-id/ tree of a Linux operating system running within the instance.</p> <p>This value can be used to reference the device for mounting, resizing, and so on, from within the instance.</p> <p>Value must match the regular expression <code>\|[a-z][-_0-9a-z]{0,19}</code>.</p> 
instanceGroups[].<br>instanceTemplate.<br>bootDiskSpec.<br>diskSpec | **object**<br><p>Required. Disk specification that is attached to the instance. For more information, see <a href="/docs/compute/concepts/disk">Disks</a>.</p> 
instanceGroups[].<br>instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>description | **string**<br><p>Description of the disk.</p> <p>The maximum string length in characters is 256.</p> 
instanceGroups[].<br>instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>typeId | **string**<br><p>Required. ID of the disk type.</p> 
instanceGroups[].<br>instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>size | **string** (int64)<br><p>Size of the disk, specified in bytes.</p> <p>Acceptable values are 4194304 to 4398046511104, inclusive.</p> 
instanceGroups[].<br>instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>imageId | **string** <br>`instanceGroups[].instanceTemplate.bootDiskSpec.diskSpec` includes only one of the fields `imageId`, `snapshotId`<br><br><p>ID of the image that will be used for disk creation.</p> <p>The maximum string length in characters is 50.</p> 
instanceGroups[].<br>instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>snapshotId | **string** <br>`instanceGroups[].instanceTemplate.bootDiskSpec.diskSpec` includes only one of the fields `imageId`, `snapshotId`<br><br><p>ID of the snapshot that will be used for disk creation.</p> <p>The maximum string length in characters is 50.</p> 
instanceGroups[].<br>instanceTemplate.<br>secondaryDiskSpecs[] | **object**<br><p>Array of secondary disks that will be attached to the instance.</p> <p>The maximum number of elements is 3.</p> 
instanceGroups[].<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>mode | **string**<br><p>Required. Access mode to the Disk resource.</p> <ul> <li>READ_ONLY: Read-only access.</li> <li>READ_WRITE: Read/Write access.</li> </ul> 
instanceGroups[].<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>deviceName | **string**<br><p>Serial number that is reflected in the /dev/disk/by-id/ tree of a Linux operating system running within the instance.</p> <p>This value can be used to reference the device for mounting, resizing, and so on, from within the instance.</p> <p>Value must match the regular expression <code>\|[a-z][-_0-9a-z]{0,19}</code>.</p> 
instanceGroups[].<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec | **object**<br><p>Required. Disk specification that is attached to the instance. For more information, see <a href="/docs/compute/concepts/disk">Disks</a>.</p> 
instanceGroups[].<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>description | **string**<br><p>Description of the disk.</p> <p>The maximum string length in characters is 256.</p> 
instanceGroups[].<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>typeId | **string**<br><p>Required. ID of the disk type.</p> 
instanceGroups[].<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>size | **string** (int64)<br><p>Size of the disk, specified in bytes.</p> <p>Acceptable values are 4194304 to 4398046511104, inclusive.</p> 
instanceGroups[].<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>imageId | **string** <br>`instanceGroups[].instanceTemplate.secondaryDiskSpecs[].diskSpec` includes only one of the fields `imageId`, `snapshotId`<br><br><p>ID of the image that will be used for disk creation.</p> <p>The maximum string length in characters is 50.</p> 
instanceGroups[].<br>instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>snapshotId | **string** <br>`instanceGroups[].instanceTemplate.secondaryDiskSpecs[].diskSpec` includes only one of the fields `imageId`, `snapshotId`<br><br><p>ID of the snapshot that will be used for disk creation.</p> <p>The maximum string length in characters is 50.</p> 
instanceGroups[].<br>instanceTemplate.<br>networkInterfaceSpecs[] | **object**<br><p>Required. Array of network interfaces that will be attached to the instance.</p> <p>Must contain exactly 1 element.</p> 
instanceGroups[].<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>networkId | **string**<br><p>ID of the network.</p> 
instanceGroups[].<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>subnetIds[] | **string**<br><p>IDs of the subnets.</p> 
instanceGroups[].<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec | **object**<br><p>Primary IPv4 address that is assigned to the instance for this network interface.</p> 
instanceGroups[].<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec | **object**<br><p>An external IP address configuration. If not specified, then this managed instance will have no external internet access.</p> 
instanceGroups[].<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec.<br>ipVersion | **string**<br><p>IP version for the public IP address.</p> <ul> <li>IPV4: IPv4 address, for example 192.168.0.0.</li> <li>IPV6: IPv6 address, not available yet.</li> </ul> 
instanceGroups[].<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec | **object**<br><p>Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet.</p> 
instanceGroups[].<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec | **object**<br><p>An external IP address configuration. If not specified, then this managed instance will have no external internet access.</p> 
instanceGroups[].<br>instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec.<br>ipVersion | **string**<br><p>IP version for the public IP address.</p> <ul> <li>IPV4: IPv4 address, for example 192.168.0.0.</li> <li>IPV6: IPv6 address, not available yet.</li> </ul> 
instanceGroups[].<br>instanceTemplate.<br>schedulingPolicy | **object**<br><p>Scheduling policy for the instance.</p> 
instanceGroups[].<br>instanceTemplate.<br>schedulingPolicy.<br>preemptible | **boolean** (boolean)<br><p>Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time if their resources are needed by Compute. For more information, see <a href="/docs/compute/concepts/preemptible-vm">Preemptible Virtual Machines</a>.</p> 
instanceGroups[].<br>instanceTemplate.<br>serviceAccountId | **string**<br><p>Service account ID for the instance.</p> 
instanceGroups[].<br>scalePolicy | **object**<br><p>Scaling policy of the instance group.</p> 
instanceGroups[].<br>scalePolicy.<br>fixedScale | **object**<br>Fixed scaling policy of the instance group.<br>
instanceGroups[].<br>scalePolicy.<br>fixedScale.<br>size | **string** (int64)<br><p>Number of instances in the instance group.</p> <p>Acceptable values are 1 to 100, inclusive.</p> 
instanceGroups[].<br>deployPolicy | **object**<br><p>Deployment policy of the instance group.</p> 
instanceGroups[].<br>deployPolicy.<br>maxUnavailable | **string** (int64)<br><p>The maximum number of running instances that can be taken offline (i.e., stopped or deleted) at the same time during the update process. If maxExpansion is not specified or set to zero, maxUnavailable must be set to a non-zero value.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
instanceGroups[].<br>deployPolicy.<br>maxDeleting | **string** (int64)<br><p>The maximum number of instances that can be deleted at the same time.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
instanceGroups[].<br>deployPolicy.<br>maxCreating | **string** (int64)<br><p>The maximum number of instances that can be created at the same time.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
instanceGroups[].<br>deployPolicy.<br>maxExpansion | **string** (int64)<br><p>The maximum number of instances that can be temporarily allocated above the group's target size during the update process. If maxUnavailable is not specified or set to zero, maxExpansion must be set to a non-zero value.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
instanceGroups[].<br>deployPolicy.<br>startupDuration | **string**<br><p>Instance startup duration. Instance will be considered up and running (and start receiving traffic) only after startup_duration has elapsed and all health checks are passed. See ManagedInstanceStatus for more information.</p> <p>Acceptable values are 0 seconds to 3600 seconds, inclusive.</p> 
instanceGroups[].<br>allocationPolicy | **object**<br><p>Allocation policy of the instance group by zones and regions.</p> 
instanceGroups[].<br>allocationPolicy.<br>zones[] | **object**<br><p>Required. List of availability zones.</p> <p>The minimum number of elements is 1.</p> 
instanceGroups[].<br>allocationPolicy.<br>zones[].<br>zoneId | **string**<br><p>Required. ID of the availability zone where the instance resides.</p> 
instanceGroups[].<br>loadBalancerState | **object**<br><p>Information that indicates which entities can be related to this load balancer.</p> 
instanceGroups[].<br>loadBalancerState.<br>targetGroupId | **string**<br><p>ID of the target group used for load balancing.</p> 
instanceGroups[].<br>loadBalancerState.<br>statusMessage | **string**<br><p>Status message of the target group.</p> 
instanceGroups[].<br>managedInstancesState | **object**<br><p>States of instances for this instance group.</p> 
instanceGroups[].<br>managedInstancesState.<br>targetSize | **string** (int64)<br><p>Target number of instances for this instance group.</p> 
instanceGroups[].<br>managedInstancesState.<br>runningActualCount | **string** (int64)<br><p>The number of running instances that match the current instance template. For more information, see RUNNING_ACTUAL.</p> 
instanceGroups[].<br>managedInstancesState.<br>runningOutdatedCount | **string** (int64)<br><p>The number of running instances that does not match the current instance template. For more information, see RUNNING_OUTDATED.</p> 
instanceGroups[].<br>managedInstancesState.<br>processingCount | **string** (int64)<br><p>The number of instances in flight (for example, updating, starting, deleting). For more information, see ManagedInstanceStatus.</p> 
instanceGroups[].<br>loadBalancerSpec | **object**<br><p>Load balancing specification.</p> 
instanceGroups[].<br>loadBalancerSpec.<br>targetGroupSpec | **object**<br><p>Specification of the target group that the instance group will be added to. For more information, see <a href="/docs/load-balancer/target-resources">Target groups and resources</a>.</p> 
instanceGroups[].<br>loadBalancerSpec.<br>targetGroupSpec.<br>name | **string**<br><p>Name of the target group.</p> <p>Value must match the regular expression <code>\|[a-z][-a-z0-9]{1,61}[a-z0-9]</code>.</p> 
instanceGroups[].<br>loadBalancerSpec.<br>targetGroupSpec.<br>description | **string**<br><p>Description of the target group.</p> <p>The maximum string length in characters is 256.</p> 
instanceGroups[].<br>loadBalancerSpec.<br>targetGroupSpec.<br>labels | **object**<br><p>Resource labels as <code>key:value</code> pairs.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression <code>[a-z][-_0-9a-z]*</code>. The maximum string length in characters for each value is 63. Each value must match the regular expression <code>[-_0-9a-z]*</code>.</p> 
instanceGroups[].<br>healthChecksSpec | **object**<br><p>Health checking specification. For more information, see <a href="/docs/load-balancer/concepts/health-check">Health check</a>.</p> 
instanceGroups[].<br>healthChecksSpec.<br>healthCheckSpecs[] | **object**<br><p>Required. Health checking specification. For more information, see <a href="/docs/load-balancer/concepts/health-check">Health check</a>.</p> <p>The minimum number of elements is 1.</p> 
instanceGroups[].<br>healthChecksSpec.<br>healthCheckSpecs[].<br>interval | **string**<br><p>The interval between health checks. The default is 2 seconds.</p> <p>Acceptable values are 1 seconds to 300 seconds, inclusive.</p> 
instanceGroups[].<br>healthChecksSpec.<br>healthCheckSpecs[].<br>timeout | **string**<br><p>Timeout for the managed instance to return a response for the health check. The default is 1 second.</p> <p>Acceptable values are 1 seconds to 60 seconds, inclusive.</p> 
instanceGroups[].<br>healthChecksSpec.<br>healthCheckSpecs[].<br>unhealthyThreshold | **string** (int64)<br><p>The number of failed health checks for the managed instance to be considered unhealthy. The default (0) is 2.</p> <p>Value must be one of 0, 2, 3, 4, 5, 6, 7, 8, 9 or 10.</p> 
instanceGroups[].<br>healthChecksSpec.<br>healthCheckSpecs[].<br>healthyThreshold | **string** (int64)<br><p>The number of successful health checks required in order for the managed instance to be considered healthy. The default (0) is 2.</p> <p>Value must be one of 0, 2, 3, 4, 5, 6, 7, 8, 9 or 10.</p> 
instanceGroups[].<br>healthChecksSpec.<br>healthCheckSpecs[].<br>tcpOptions | **object**<br>Configuration options for a TCP health check. <br>`instanceGroups[].healthChecksSpec.healthCheckSpecs[]` includes only one of the fields `tcpOptions`, `httpOptions`<br><br>
instanceGroups[].<br>healthChecksSpec.<br>healthCheckSpecs[].<br>tcpOptions.<br>port | **string** (int64)<br><p>Port to use for TCP health checks.</p> <p>Acceptable values are 1 to 32767, inclusive.</p> 
instanceGroups[].<br>healthChecksSpec.<br>healthCheckSpecs[].<br>httpOptions | **object**<br>Configuration options for an HTTP health check. <br>`instanceGroups[].healthChecksSpec.healthCheckSpecs[]` includes only one of the fields `tcpOptions`, `httpOptions`<br><br>
instanceGroups[].<br>healthChecksSpec.<br>healthCheckSpecs[].<br>httpOptions.<br>port | **string** (int64)<br><p>Port to use for HTTP health checks.</p> <p>Acceptable values are 1 to 32767, inclusive.</p> 
instanceGroups[].<br>healthChecksSpec.<br>healthCheckSpecs[].<br>httpOptions.<br>path | **string**<br><p>URL path to set for health checking requests.</p> 
instanceGroups[].<br>serviceAccountId | **string**<br><p>ID of the service account. The service account will be used for all API calls made by the Instance Groups component on behalf of the user (for example, creating instances, adding them to load balancer target group, etc.). For more information, see <a href="/docs/iam/concepts/users/service-accounts">Service accounts</a>. To get the service account ID, use a <a href="/docs/iam/api-ref/ServiceAccount/list">list</a> request.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/compute/api-ref/InstanceGroup/list#query_params">pageSize</a>, use <a href="/docs/compute/api-ref/InstanceGroup/list#responses">nextPageToken</a> as the value for the <a href="/docs/compute/api-ref/InstanceGroup/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/compute/api-ref/InstanceGroup/list#responses">nextPageToken</a> to continue paging through the results.</p> 