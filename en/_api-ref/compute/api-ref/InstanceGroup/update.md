---
editable: false
---

# Method update
Updates the specified instance group.
This method starts an operation that can be cancelled by another operation.
 

 
## HTTP request {#https-request}
```
PATCH https://compute.api.cloud.yandex.net/compute/v1/instanceGroups/{instanceGroupId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
instanceGroupId | Required. ID of the instance group to update. To get the instance group ID, use an [list](/docs/compute/api-ref/InstanceGroup/list) request.  The maximum string length in characters is 50.
 
## Body parameters {#body_params}
 
```json 
{
  "updateMask": "string",
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

        // `instanceTemplate.bootDiskSpec.diskSpec` includes only one of the fields `imageId`, `snapshotId`
        "imageId": "string",
        "snapshotId": "string",
        // end of the list of possible fields`instanceTemplate.bootDiskSpec.diskSpec`

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

          // `instanceTemplate.secondaryDiskSpecs[].diskSpec` includes only one of the fields `imageId`, `snapshotId`
          "imageId": "string",
          "snapshotId": "string",
          // end of the list of possible fields`instanceTemplate.secondaryDiskSpecs[].diskSpec`

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

    // `scalePolicy` includes only one of the fields `fixedScale`, `autoScale`
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
      }
    },
    // end of the list of possible fields`scalePolicy`

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
  "healthChecksSpec": {
    "healthCheckSpecs": [
      {
        "interval": "string",
        "timeout": "string",
        "unhealthyThreshold": "string",
        "healthyThreshold": "string",

        // `healthChecksSpec.healthCheckSpecs[]` includes only one of the fields `tcpOptions`, `httpOptions`
        "tcpOptions": {
          "port": "string"
        },
        "httpOptions": {
          "port": "string",
          "path": "string"
        },
        // end of the list of possible fields`healthChecksSpec.healthCheckSpecs[]`

      }
    ]
  },
  "serviceAccountId": "string",
  "loadBalancerSpec": {
    "targetGroupSpec": {
      "name": "string",
      "description": "string",
      "labels": "object"
    }
  }
}
```

 
Field | Description
--- | ---
updateMask | **string**<br><p>Field mask that specifies which fields of the InstanceGroup resource are going to be updated.</p> <p>A comma-separated names off ALL fields to be updated. Оnly the specified fields will be changed. The others will be left untouched. If the field is specified in <code>updateMask</code> and no value for that field was sent in the request, the field's value will be reset to the default. The default value for most fields is null or 0.</p> <p>If <code>updateMask</code> is not sent in the request, all fields' values will be updated. Fields specified in the request will be updated to provided values. The rest of the fields will be reset to the default.</p> 
name | **string**<br><p>Name of the instance group.</p> <p>Value must match the regular expression <code>\|[a-z][-a-z0-9]{1,61}[a-z0-9]</code>.</p> 
description | **string**<br><p>Description of the instance group.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Resource labels as <code>key:value</code> pairs.</p> <p>The existing set of <code>labels</code> is completely replaced by the provided set.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression <code>[a-z][-_0-9a-z]*</code>. The maximum string length in characters for each value is 63. Each value must match the regular expression <code>[-_0-9a-z]*</code>.</p> 
instanceTemplate | **object**<br><p>Required. Instance template that the instance group belongs to.</p> 
instanceTemplate.<br>description | **string**<br><p>Description of the instance template.</p> <p>The maximum string length in characters is 256.</p> 
instanceTemplate.<br>labels | **object**<br><p>Resource labels as <code>key:value</code> pairs.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression <code>[a-z][-_0-9a-z]*</code>. The maximum string length in characters for each value is 63. Each value must match the regular expression <code>[-_0-9a-z]*</code>.</p> 
instanceTemplate.<br>platformId | **string**<br><p>ID of the hardware platform configuration for the instance. Platforms allows you to create various types of instances: with a large amount of memory, with a large number of cores, with a burstable performance. For more information, see <a href="/docs/compute/concepts/vm-platforms">Platforms</a>.</p> 
instanceTemplate.<br>resourcesSpec | **object**<br><p>Required. Computing resources of the instance such as the amount of memory and number of cores.</p> 
instanceTemplate.<br>resourcesSpec.<br>memory | **string** (int64)<br><p>The amount of memory available to the instance, specified in bytes.</p> <p>The maximum value is 274877906944.</p> 
instanceTemplate.<br>resourcesSpec.<br>cores | **string** (int64)<br><p>The number of cores available to the instance.</p> <p>Value must be one of 1, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 40, 44, 48, 52, 56, 60 or 64.</p>
instanceTemplate.<br>resourcesSpec.<br>coreFraction | **string** (int64)<br><p>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core.</p> <p>Value must be one of 0, 5, 20, 50 or 100.</p> 
instanceTemplate.<br>resourcesSpec.<br>gpus | **string** (int64)<br><p>The number of GPUs available to the instance.</p> <p>Value must be one of 0, 1, 2 or 4.</p> 
instanceTemplate.<br>metadata | **object**<br><p>The metadata <code>key:value</code> pairs assigned to this instance template. This includes custom metadata and predefined keys.</p> <p>For example, you may use the metadata in order to provide your public SSH key to the instance. For more information, see <a href="/docs/compute/concepts/vm-metadata">Metadata</a>.</p> <p>No more than 128 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression <code>[a-z][-_0-9a-z]*</code>. The maximum string length in characters for each value is 262144.</p> 
instanceTemplate.<br>bootDiskSpec | **object**<br><p>Required. Boot disk specification that will be attached to the instance.</p> 
instanceTemplate.<br>bootDiskSpec.<br>mode | **string**<br><p>Required. Access mode to the Disk resource.</p> <ul> <li>READ_ONLY: Read-only access.</li> <li>READ_WRITE: Read/Write access.</li> </ul> 
instanceTemplate.<br>bootDiskSpec.<br>deviceName | **string**<br><p>Serial number that is reflected in the /dev/disk/by-id/ tree of a Linux operating system running within the instance.</p> <p>This value can be used to reference the device for mounting, resizing, and so on, from within the instance.</p> <p>Value must match the regular expression <code>\|[a-z][-_0-9a-z]{0,19}</code>.</p> 
instanceTemplate.<br>bootDiskSpec.<br>diskSpec | **object**<br><p>Required. Disk specification that is attached to the instance. For more information, see <a href="/docs/compute/concepts/disk">Disks</a>.</p> 
instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>description | **string**<br><p>Description of the disk.</p> <p>The maximum string length in characters is 256.</p> 
instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>typeId | **string**<br><p>Required. ID of the disk type.</p> 
instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>size | **string** (int64)<br><p>Size of the disk, specified in bytes.</p> <p>Acceptable values are 4194304 to 4398046511104, inclusive.</p> 
instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>imageId | **string** <br>`instanceTemplate.bootDiskSpec.diskSpec` includes only one of the fields `imageId`, `snapshotId`<br><br><p>ID of the image that will be used for disk creation.</p> <p>The maximum string length in characters is 50.</p> 
instanceTemplate.<br>bootDiskSpec.<br>diskSpec.<br>snapshotId | **string** <br>`instanceTemplate.bootDiskSpec.diskSpec` includes only one of the fields `imageId`, `snapshotId`<br><br><p>ID of the snapshot that will be used for disk creation.</p> <p>The maximum string length in characters is 50.</p> 
instanceTemplate.<br>secondaryDiskSpecs[] | **object**<br><p>Array of secondary disks that will be attached to the instance.</p> <p>The maximum number of elements is 3.</p> 
instanceTemplate.<br>secondaryDiskSpecs[].<br>mode | **string**<br><p>Required. Access mode to the Disk resource.</p> <ul> <li>READ_ONLY: Read-only access.</li> <li>READ_WRITE: Read/Write access.</li> </ul> 
instanceTemplate.<br>secondaryDiskSpecs[].<br>deviceName | **string**<br><p>Serial number that is reflected in the /dev/disk/by-id/ tree of a Linux operating system running within the instance.</p> <p>This value can be used to reference the device for mounting, resizing, and so on, from within the instance.</p> <p>Value must match the regular expression <code>\|[a-z][-_0-9a-z]{0,19}</code>.</p> 
instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec | **object**<br><p>Required. Disk specification that is attached to the instance. For more information, see <a href="/docs/compute/concepts/disk">Disks</a>.</p> 
instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>description | **string**<br><p>Description of the disk.</p> <p>The maximum string length in characters is 256.</p> 
instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>typeId | **string**<br><p>Required. ID of the disk type.</p> 
instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>size | **string** (int64)<br><p>Size of the disk, specified in bytes.</p> <p>Acceptable values are 4194304 to 4398046511104, inclusive.</p> 
instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>imageId | **string** <br>`instanceTemplate.secondaryDiskSpecs[].diskSpec` includes only one of the fields `imageId`, `snapshotId`<br><br><p>ID of the image that will be used for disk creation.</p> <p>The maximum string length in characters is 50.</p> 
instanceTemplate.<br>secondaryDiskSpecs[].<br>diskSpec.<br>snapshotId | **string** <br>`instanceTemplate.secondaryDiskSpecs[].diskSpec` includes only one of the fields `imageId`, `snapshotId`<br><br><p>ID of the snapshot that will be used for disk creation.</p> <p>The maximum string length in characters is 50.</p> 
instanceTemplate.<br>networkInterfaceSpecs[] | **object**<br><p>Required. Array of network interfaces that will be attached to the instance.</p> <p>Must contain exactly 1 element.</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>networkId | **string**<br><p>ID of the network.</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>subnetIds[] | **string**<br><p>IDs of the subnets.</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec | **object**<br><p>Primary IPv4 address that is assigned to the instance for this network interface.</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec | **object**<br><p>An external IP address configuration. If not specified, then this managed instance will have no external internet access.</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV4AddressSpec.<br>oneToOneNatSpec.<br>ipVersion | **string**<br><p>IP version for the public IP address.</p> <ul> <li>IPV4: IPv4 address, for example 192.168.0.0.</li> <li>IPV6: IPv6 address, not available yet.</li> </ul> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec | **object**<br><p>Primary IPv6 address that is assigned to the instance for this network interface. IPv6 not available yet.</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec | **object**<br><p>An external IP address configuration. If not specified, then this managed instance will have no external internet access.</p> 
instanceTemplate.<br>networkInterfaceSpecs[].<br>primaryV6AddressSpec.<br>oneToOneNatSpec.<br>ipVersion | **string**<br><p>IP version for the public IP address.</p> <ul> <li>IPV4: IPv4 address, for example 192.168.0.0.</li> <li>IPV6: IPv6 address, not available yet.</li> </ul> 
instanceTemplate.<br>schedulingPolicy | **object**<br><p>Scheduling policy for the instance.</p> 
instanceTemplate.<br>schedulingPolicy.<br>preemptible | **boolean** (boolean)<br><p>Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time if their resources are needed by Compute. For more information, see <a href="/docs/compute/concepts/preemptible-vm">Preemptible Virtual Machines</a>.</p> 
instanceTemplate.<br>serviceAccountId | **string**<br><p>Service account ID for the instance.</p> 
scalePolicy | **object**<br><p>Required. Scaling policy of the instance group.</p> 
scalePolicy.<br>fixedScale | **object**<br>Fixed scaling policy of the instance group. <br>`scalePolicy` includes only one of the fields `fixedScale`, `autoScale`<br><br>
scalePolicy.<br>fixedScale.<br>size | **string** (int64)<br><p>Number of instances in the instance group.</p> <p>Acceptable values are 1 to 100, inclusive.</p> 
scalePolicy.<br>autoScale | **object** <br>`scalePolicy` includes only one of the fields `fixedScale`, `autoScale`<br><br>
scalePolicy.<br>autoScale.<br>minZoneSize | **string** (int64)<br><p>Lower limit for instance count in each zone.</p> <p>Acceptable values are 0 to 100, inclusive.</p>
scalePolicy.<br>autoScale.<br>maxSize | **string** (int64)<br><p>Upper limit for total instance count (across all zones). 0 means maximum limit = 100.</p> <p>Acceptable values are 0 to 100, inclusive.</p>
scalePolicy.<br>autoScale.<br>measurementDuration | **string**<br><p>Required. Acceptable values are 60 seconds to 600 seconds, inclusive.</p>
scalePolicy.<br>autoScale.<br>warmupDuration | **string**<br><p>The maximum value is 600 seconds.</p>
scalePolicy.<br>autoScale.<br>stabilizationDuration | **string**<br><p>Acceptable values are 60 seconds to 1800 seconds, inclusive.</p>
scalePolicy.<br>autoScale.<br>initialSize | **string** (int64)<br><p>The minimum value is 1.</p>
scalePolicy.<br>autoScale.<br>cpuUtilizationRule | **object**<br>
scalePolicy.<br>autoScale.<br>cpuUtilizationRule.<br>utilizationTarget | **number** (double)<br><p>Acceptable values are 10 to 100, inclusive.</p>
deployPolicy | **object**<br><p>Required. Deployment policy of the instance group.</p> 
deployPolicy.<br>maxUnavailable | **string** (int64)<br><p>The maximum number of running instances that can be taken offline (i.e., stopped or deleted) at the same time during the update process. If maxExpansion is not specified or set to zero, maxUnavailable must be set to a non-zero value.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
deployPolicy.<br>maxDeleting | **string** (int64)<br><p>The maximum number of instances that can be deleted at the same time.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
deployPolicy.<br>maxCreating | **string** (int64)<br><p>The maximum number of instances that can be created at the same time.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
deployPolicy.<br>maxExpansion | **string** (int64)<br><p>The maximum number of instances that can be temporarily allocated above the group's target size during the update process. If maxUnavailable is not specified or set to zero, maxExpansion must be set to a non-zero value.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
deployPolicy.<br>startupDuration | **string**<br><p>Instance startup duration. Instance will be considered up and running (and start receiving traffic) only after startup_duration has elapsed and all health checks are passed. See ManagedInstanceStatus for more information.</p> <p>Acceptable values are 0 seconds to 3600 seconds, inclusive.</p> 
allocationPolicy | **object**<br><p>Required. Allocation policy of the instance group by zones and regions.</p> 
allocationPolicy.<br>zones[] | **object**<br><p>Required. List of availability zones.</p> <p>The minimum number of elements is 1.</p> 
allocationPolicy.<br>zones[].<br>zoneId | **string**<br><p>Required. ID of the availability zone where the instance resides.</p> 
healthChecksSpec | **object**<br><p>Health checking specification. For more information, see <a href="/docs/load-balancer/concepts/health-check">Health check</a>.</p> 
healthChecksSpec.<br>healthCheckSpecs[] | **object**<br><p>Required. Health checking specification. For more information, see <a href="/docs/load-balancer/concepts/health-check">Health check</a>.</p> <p>The minimum number of elements is 1.</p> 
healthChecksSpec.<br>healthCheckSpecs[].<br>interval | **string**<br><p>The interval between health checks. The default is 2 seconds.</p> <p>Acceptable values are 1 seconds to 300 seconds, inclusive.</p> 
healthChecksSpec.<br>healthCheckSpecs[].<br>timeout | **string**<br><p>Timeout for the managed instance to return a response for the health check. The default is 1 second.</p> <p>Acceptable values are 1 seconds to 60 seconds, inclusive.</p> 
healthChecksSpec.<br>healthCheckSpecs[].<br>unhealthyThreshold | **string** (int64)<br><p>The number of failed health checks for the managed instance to be considered unhealthy. The default (0) is 2.</p> <p>Value must be one of 0, 2, 3, 4, 5, 6, 7, 8, 9 or 10.</p> 
healthChecksSpec.<br>healthCheckSpecs[].<br>healthyThreshold | **string** (int64)<br><p>The number of successful health checks required in order for the managed instance to be considered healthy. The default (0) is 2.</p> <p>Value must be one of 0, 2, 3, 4, 5, 6, 7, 8, 9 or 10.</p> 
healthChecksSpec.<br>healthCheckSpecs[].<br>tcpOptions | **object**<br>Configuration options for a TCP health check. <br>`healthChecksSpec.healthCheckSpecs[]` includes only one of the fields `tcpOptions`, `httpOptions`<br><br>
healthChecksSpec.<br>healthCheckSpecs[].<br>tcpOptions.<br>port | **string** (int64)<br><p>Port to use for TCP health checks.</p> <p>Acceptable values are 1 to 32767, inclusive.</p> 
healthChecksSpec.<br>healthCheckSpecs[].<br>httpOptions | **object**<br>Configuration options for an HTTP health check. <br>`healthChecksSpec.healthCheckSpecs[]` includes only one of the fields `tcpOptions`, `httpOptions`<br><br>
healthChecksSpec.<br>healthCheckSpecs[].<br>httpOptions.<br>port | **string** (int64)<br><p>Port to use for HTTP health checks.</p> <p>Acceptable values are 1 to 32767, inclusive.</p> 
healthChecksSpec.<br>healthCheckSpecs[].<br>httpOptions.<br>path | **string**<br><p>URL path to set for health checking requests.</p> 
serviceAccountId | **string**<br><p>ID of the service account. The service account will be used for all API calls made by the Instance Groups component on behalf of the user (for example, creating instances, adding them to load balancer target group, etc.). For more information, see <a href="/docs/iam/concepts/users/service-accounts">Service accounts</a>. To get the service account ID, use a <a href="/docs/iam/api-ref/ServiceAccount/list">list</a> request.</p> 
loadBalancerSpec | **object**<br><p>Load Balancer specification for load balancing support.</p> 
loadBalancerSpec.<br>targetGroupSpec | **object**<br><p>Specification of the target group that the instance group will be added to. For more information, see <a href="/docs/load-balancer/target-resources">Target groups and resources</a>.</p> 
loadBalancerSpec.<br>targetGroupSpec.<br>name | **string**<br><p>Name of the target group.</p> <p>Value must match the regular expression <code>\|[a-z][-a-z0-9]{1,61}[a-z0-9]</code>.</p> 
loadBalancerSpec.<br>targetGroupSpec.<br>description | **string**<br><p>Description of the target group.</p> <p>The maximum string length in characters is 256.</p> 
loadBalancerSpec.<br>targetGroupSpec.<br>labels | **object**<br><p>Resource labels as <code>key:value</code> pairs.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression <code>[a-z][-_0-9a-z]*</code>. The maximum string length in characters for each value is 63. Each value must match the regular expression <code>[-_0-9a-z]*</code>.</p> 
 
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
done | **boolean** (boolean)<br><p>If the value is <code>false</code>, it means the operation is still in progress. If <code>true</code>, the operation is completed, and either <code>error</code> or <code>response</code> is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br><br><p>The error result of the operation in case of failure or cancellation.</p> 
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 