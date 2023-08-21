---
editable: false
sourcePath: en/_api-ref/k8s/v1/api-ref/Cluster/create.md
---

# Managed Services for Kubernetes API, REST: Cluster.create
Creates a Kubernetes cluster in the specified folder.
 

 
## HTTP request {#https-request}
```
POST https://mks.{{ api-host }}/managed-kubernetes/v1/clusters
```
 
## Body parameters {#body_params}
 
```json 
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "networkId": "string",
  "masterSpec": {
    "locations": [
      {
        "zoneId": "string",
        "subnetId": "string"
      }
    ],
    "etcdClusterSize": "string",
    "version": "string",
    "maintenancePolicy": {
      "autoUpgrade": true,
      "maintenanceWindow": {

        // `masterSpec.maintenancePolicy.maintenanceWindow` includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`
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
        // end of the list of possible fields`masterSpec.maintenancePolicy.maintenanceWindow`

      }
    },
    "securityGroupIds": [
      "string"
    ],
    "masterLogging": {
      "enabled": true,
      "auditEnabled": true,
      "clusterAutoscalerEnabled": true,
      "kubeApiserverEnabled": true,
      "eventsEnabled": true,

      // `masterSpec.masterLogging` includes only one of the fields `logGroupId`, `folderId`
      "logGroupId": "string",
      "folderId": "string",
      // end of the list of possible fields`masterSpec.masterLogging`

    },

    // `masterSpec` includes only one of the fields `zonalMasterSpec`, `regionalMasterSpec`
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
    // end of the list of possible fields`masterSpec`

  },
  "ipAllocationPolicy": {
    "clusterIpv4CidrBlock": "string",
    "nodeIpv4CidrMaskSize": "string",
    "serviceIpv4CidrBlock": "string",
    "clusterIpv6CidrBlock": "string",
    "serviceIpv6CidrBlock": "string"
  },
  "serviceAccountId": "string",
  "nodeServiceAccountId": "string",
  "releaseChannel": "string",
  "networkPolicy": {
    "provider": "string"
  },
  "kmsProvider": {
    "keyId": "string"
  },
  "gatewayIpv4Address": "string",
  "cilium": {
    "routingMode": "string"
  }
}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>Required. ID of the folder to create a Kubernetes cluster in. To get the folder ID use a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> 
name | **string**<br><p>Name of the Kubernetes cluster. The name must be unique within the folder.</p> <p>Value must match the regular expression ``\|[a-z]([-a-z0-9]{0,61}[a-z0-9])?``.</p> 
description | **string**<br><p>Description of the Kubernetes cluster.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_./\@0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_./\@0-9a-z]*``.</p> 
networkId | **string**<br><p>Required. ID of the network.</p> 
masterSpec | **object**<br>Required. Master specification of the Kubernetes cluster.
masterSpec.<br>locations[] | **object**<br><p>Locations specification for Kubernetes control-plane (master) instances. Works in conjunction with ``etcdClusterSize``. See it's documentation for details. Possible combinations:</p> <ul> <li>1 location and etcd_cluster_size = 1 - a single node cluster whose availability is limited by the availability of a single Compute Instance; downtime is expected during cluster updates.</li> <li>1 location and etcd_cluster_size = 3 - a highly available cluster within a single availability zone; can survive the failure of a Compute Instance, a server, or an individual server rack.</li> <li>3 location and etcd_cluster_size = 3 - a highly available cluster with each etcd instance located within separate availability zone; can survive the failure of a single availability zone.</li> </ul> 
masterSpec.<br>locations[].<br>zoneId | **string**<br><p>Required. ID of the availability zone where the master resides.</p> 
masterSpec.<br>locations[].<br>subnetId | **string**<br><p>ID of the VPC network's subnet where the master resides. If not specified and there is a single subnet in specified zone, address in this subnet will be allocated.</p> 
masterSpec.<br>etcdClusterSize | **string** (int64)<br><p>Number of etcd nodes in cluster. Works in conjunction with ``locations``. See it's documentation for details. Optional. If not set, will be assumed equal to the number of locations.</p> <p>Value must be one of 0, 1 or 3.</p> 
masterSpec.<br>version | **string**<br><p>Version of Kubernetes components that runs on the master.</p> 
masterSpec.<br>maintenancePolicy | **object**<br>Maintenance policy of the master.
masterSpec.<br>maintenancePolicy.<br>autoUpgrade | **boolean** (boolean)<br><p>If set to true, automatic updates are installed in the specified period of time with no interaction from the user. If set to false, automatic upgrades are disabled.</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow | **object**<br><p>Maintenance window settings. Update will start at the specified time and last no more than the specified duration. The time is set in UTC.</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>anytime | **object**<br>Updating the master at any time. <br>`masterSpec.maintenancePolicy.maintenanceWindow` includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`<br>
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow | **object**<br>Updating the master on any day during the specified time window. <br>`masterSpec.maintenancePolicy.maintenanceWindow` includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`<br>
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime | **object**<br><p>Required. Window start time, in the UTC timezone.</p> <p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value "24:00:00" for scenarios like business closing time.</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>duration | **string**<br><p>Window duration.</p> <p>Acceptable values are 3600 seconds to 86400 seconds, inclusive.</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow | **object**<br>Updating the master on selected days during the specified time window. <br>`masterSpec.maintenancePolicy.maintenanceWindow` includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`<br>
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[] | **object**<br><p>Required. Days of the week and the maintenance window for these days when automatic updates are allowed.</p> <p>The number of elements must be in the range 1-7.</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>days[] | **string**<br><p>Required. Days of the week when automatic updates are allowed.</p> <p>The number of elements must be in the range 1-7.</p> <ul> <li>MONDAY: The day-of-week of Monday.</li> <li>TUESDAY: The day-of-week of Tuesday.</li> <li>WEDNESDAY: The day-of-week of Wednesday.</li> <li>THURSDAY: The day-of-week of Thursday.</li> <li>FRIDAY: The day-of-week of Friday.</li> <li>SATURDAY: The day-of-week of Saturday.</li> <li>SUNDAY: The day-of-week of Sunday.</li> </ul> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime | **object**<br><p>Required. Window start time, in the UTC timezone.</p> <p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value "24:00:00" for scenarios like business closing time.</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>duration | **string**<br><p>Window duration.</p> <p>Acceptable values are 3600 seconds to 86400 seconds, inclusive.</p> 
masterSpec.<br>securityGroupIds[] | **string**<br><p>Master security groups.</p> 
masterSpec.<br>masterLogging | **object**<br>Cloud Logging for master components.
masterSpec.<br>masterLogging.<br>enabled | **boolean** (boolean)<br><p>Identifies whether Cloud Logging is enabled for master components.</p> 
masterSpec.<br>masterLogging.<br>auditEnabled | **boolean** (boolean)<br><p>Identifies whether Cloud Logging is enabled for audit logs.</p> 
masterSpec.<br>masterLogging.<br>clusterAutoscalerEnabled | **boolean** (boolean)<br><p>Identifies whether Cloud Logging is enabled for cluster-autoscaler.</p> 
masterSpec.<br>masterLogging.<br>kubeApiserverEnabled | **boolean** (boolean)<br><p>Identifies whether Cloud Logging is enabled for kube-apiserver.</p> 
masterSpec.<br>masterLogging.<br>eventsEnabled | **boolean** (boolean)<br><p>Identifies whether Cloud Logging is enabled for events.</p> 
masterSpec.<br>masterLogging.<br>logGroupId | **string** <br>`masterSpec.masterLogging` includes only one of the fields `logGroupId`, `folderId`<br><br><p>ID of the log group where logs of master components should be stored.</p> <p>Value must match the regular expression ``([a-zA-Z][-a-zA-Z0-9_.]{0,63})?``.</p> 
masterSpec.<br>masterLogging.<br>folderId | **string** <br>`masterSpec.masterLogging` includes only one of the fields `logGroupId`, `folderId`<br><br><p>ID of the folder where logs should be stored (in default group).</p> <p>Value must match the regular expression ``([a-zA-Z][-a-zA-Z0-9_.]{0,63})?``.</p> 
masterSpec.<br>zonalMasterSpec | **object**<br>Specification of the zonal master. <br>`masterSpec` includes only one of the fields `zonalMasterSpec`, `regionalMasterSpec`<br>
masterSpec.<br>zonalMasterSpec.<br>zoneId | **string**<br><p>Required. ID of the availability zone.</p> 
masterSpec.<br>zonalMasterSpec.<br>internalV4AddressSpec | **object**<br><p>Specification of parameters for internal IPv4 networking.</p> 
masterSpec.<br>zonalMasterSpec.<br>internalV4AddressSpec.<br>subnetId | **string**<br><p>ID of the subnet. If no ID is specified, and there only one subnet in specified zone, an address in this subnet will be allocated.</p> 
masterSpec.<br>zonalMasterSpec.<br>externalV4AddressSpec | **object**<br><p>Specification of parameters for external IPv4 networking.</p> 
masterSpec.<br>zonalMasterSpec.<br>externalV4AddressSpec.<br>address | **string**<br><p>IP address.</p> 
masterSpec.<br>regionalMasterSpec | **object**<br>Specification of the regional master. <br>`masterSpec` includes only one of the fields `zonalMasterSpec`, `regionalMasterSpec`<br>
masterSpec.<br>regionalMasterSpec.<br>regionId | **string**<br><p>Required. ID of the availability zone where the master resides.</p> 
masterSpec.<br>regionalMasterSpec.<br>locations[] | **object**<br><p>List of locations where the master will be allocated.</p> 
masterSpec.<br>regionalMasterSpec.<br>locations[].<br>zoneId | **string**<br><p>Required. ID of the availability zone.</p> 
masterSpec.<br>regionalMasterSpec.<br>locations[].<br>internalV4AddressSpec | **object**<br><p>If not specified and there is a single subnet in specified zone, address in this subnet will be allocated.</p> 
masterSpec.<br>regionalMasterSpec.<br>locations[].<br>internalV4AddressSpec.<br>subnetId | **string**<br><p>ID of the subnet. If no ID is specified, and there only one subnet in specified zone, an address in this subnet will be allocated.</p> 
masterSpec.<br>regionalMasterSpec.<br>externalV4AddressSpec | **object**<br><p>Specify to allocate a static public IP for the master.</p> 
masterSpec.<br>regionalMasterSpec.<br>externalV4AddressSpec.<br>address | **string**<br><p>IP address.</p> 
masterSpec.<br>regionalMasterSpec.<br>externalV6AddressSpec | **object**<br><p>Specification of parameters for external IPv6 networking.</p> 
masterSpec.<br>regionalMasterSpec.<br>externalV6AddressSpec.<br>address | **string**<br><p>IP address.</p> 
ipAllocationPolicy | **object**<br>IP allocation policy of the Kubernetes cluster.
ipAllocationPolicy.<br>clusterIpv4CidrBlock | **string**<br><p>CIDR block. IP range for allocating pod addresses.</p> <p>It should not overlap with any subnet in the network the Kubernetes cluster located in. Static routes will be set up for this CIDR blocks in node subnets.</p> 
ipAllocationPolicy.<br>nodeIpv4CidrMaskSize | **string** (int64)<br><p>Size of the masks that are assigned for each node in the cluster.</p> <p>If not specified, 24 is used.</p> <p>Value must be one of 0, 24, 25, 26, 27 or 28.</p> 
ipAllocationPolicy.<br>serviceIpv4CidrBlock | **string**<br><p>CIDR block. IP range Kubernetes service Kubernetes cluster IP addresses will be allocated from.</p> <p>It should not overlap with any subnet in the network the Kubernetes cluster located in.</p> 
ipAllocationPolicy.<br>clusterIpv6CidrBlock | **string**<br><p>IPv6 range for allocating pod IP addresses.</p> 
ipAllocationPolicy.<br>serviceIpv6CidrBlock | **string**<br><p>IPv6 range for allocating Kubernetes service IP addresses</p> 
serviceAccountId | **string**<br><p>Required. Service account to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster. Selected service account should have ``edit`` role on the folder where the Kubernetes cluster will be located and on the folder where selected network resides.</p> 
nodeServiceAccountId | **string**<br><p>Required. Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics.</p> 
releaseChannel | **string**<br>Release channel for the master.<br><ul> <li>RAPID: Minor updates with new functions and improvements are often added. You can't disable automatic updates in this channel, but you can specify a time period for automatic updates.</li> <li>REGULAR: New functions and improvements are added in chunks shortly after they appear on ``RAPID``.</li> <li>STABLE: Only updates related to bug fixes or security improvements are added.</li> </ul> 
networkPolicy | **object**
networkPolicy.<br>provider | **string**
kmsProvider | **object**<br>KMS provider configuration.
kmsProvider.<br>keyId | **string**<br><p>KMS key ID for secrets encryption. To obtain a KMS key ID use a <a href="/docs/kms/api-ref/SymmetricKey/list">list</a> request.</p> 
gatewayIpv4Address | **string**<br><p>Gateway IPv4 address.</p> 
cilium | **object**
cilium.<br>routingMode | **string**
 
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
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
createdBy | **string**<br><p>ID of the user or service account who initiated the operation.</p> 
modifiedAt | **string** (date-time)<br><p>The time when the Operation resource was last modified.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
done | **boolean** (boolean)<br><p>If the value is ``false``, it means the operation is still in progress. If ``true``, the operation is completed, and either ``error`` or ``response`` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 