---
editable: false
sourcePath: en/_api-ref/k8s/v1/api-ref/Cluster/index.md
---

# Managed Services for Kubernetes API, REST: Cluster methods
A set of methods for managing Kubernetes cluster.
## JSON Representation {#representation}
```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "status": "string",
  "health": "string",
  "networkId": "string",
  "master": {
    "version": "string",
    "endpoints": {
      "internalV4Endpoint": "string",
      "externalV4Endpoint": "string",
      "externalV6Endpoint": "string"
    },
    "masterAuth": {
      "clusterCaCertificate": "string"
    },
    "versionInfo": {
      "currentVersion": "string",
      "newRevisionAvailable": true,
      "newRevisionSummary": "string",
      "versionDeprecated": true
    },
    "maintenancePolicy": {
      "autoUpgrade": true,
      "maintenanceWindow": {

        // `master.maintenancePolicy.maintenanceWindow` includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`
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
        // end of the list of possible fields`master.maintenancePolicy.maintenanceWindow`

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

      // `master.masterLogging` includes only one of the fields `logGroupId`, `folderId`
      "logGroupId": "string",
      "folderId": "string",
      // end of the list of possible fields`master.masterLogging`

    },

    // `master` includes only one of the fields `zonalMaster`, `regionalMaster`
    "zonalMaster": {
      "zoneId": "string",
      "internalV4Address": "string",
      "externalV4Address": "string"
    },
    "regionalMaster": {
      "regionId": "string",
      "internalV4Address": "string",
      "externalV4Address": "string",
      "externalV6Address": "string"
    },
    // end of the list of possible fields`master`

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
  "logGroupId": "string",
  "gatewayIpv4Address": "string",
  "cilium": {
    "routingMode": "string"
  }
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the Kubernetes cluster.</p> 
folderId | **string**<br><p>ID of the folder that the Kubernetes cluster belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
name | **string**<br><p>Name of the Kubernetes cluster.</p> 
description | **string**<br><p>Description of the Kubernetes cluster. 0-256 characters long.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
status | **string**<br>Status of the Kubernetes cluster.<br><ul> <li>PROVISIONING: Kubernetes cluster is waiting for resources to be allocated.</li> <li>RUNNING: Kubernetes cluster is running.</li> <li>RECONCILING: Kubernetes cluster is being reconciled.</li> <li>STOPPING: Kubernetes cluster is being stopped.</li> <li>STOPPED: Kubernetes cluster stopped.</li> <li>DELETING: Kubernetes cluster is being deleted.</li> <li>STARTING: Kubernetes cluster is being started.</li> </ul> 
health | **string**<br>Health of the Kubernetes cluster.<br><ul> <li>HEALTHY: Kubernetes cluster is alive and well.</li> <li>UNHEALTHY: Kubernetes cluster is inoperable.</li> </ul> 
networkId | **string**<br><p>ID of the network the Kubernetes cluster belongs to.</p> 
master | **object**
master.<br>version | **string**<br><p>Version of Kubernetes components that runs on the master.</p> 
master.<br>endpoints | **object**
master.<br>endpoints.<br>internalV4Endpoint | **string**<br><p>Internal endpoint that can be used to connect to the master from cloud networks.</p> 
master.<br>endpoints.<br>externalV4Endpoint | **string**<br><p>External endpoint that can be used to access Kubernetes cluster API from the internet (outside of the cloud).</p> 
master.<br>endpoints.<br>externalV6Endpoint | **string**<br><p>External IPv6 endpoint that can be used to access Kubernetes cluster API from the internet (outside of the cloud).</p> 
master.<br>masterAuth | **object**
master.<br>masterAuth.<br>clusterCaCertificate | **string**<br><p>PEM-encoded public certificate that is the root of trust for the Kubernetes cluster.</p> 
master.<br>versionInfo | **object**
master.<br>versionInfo.<br>currentVersion | **string**<br><p>Current Kubernetes version, format: major.minor (e.g. 1.15).</p> 
master.<br>versionInfo.<br>newRevisionAvailable | **boolean** (boolean)<br><p>Newer revisions may include Kubernetes patches (e.g 1.15.1 -&gt; 1.15.2) as well as some internal component updates - new features or bug fixes in platform specific components either on the master or nodes.</p> 
master.<br>versionInfo.<br>newRevisionSummary | **string**<br><p>Description of the changes to be applied when updating to the latest revision. Empty if new_revision_available is false.</p> 
master.<br>versionInfo.<br>versionDeprecated | **boolean** (boolean)<br><p>The current version is on the deprecation schedule, component (master or node group) should be upgraded.</p> 
master.<br>maintenancePolicy | **object**
master.<br>maintenancePolicy.<br>autoUpgrade | **boolean** (boolean)<br><p>If set to true, automatic updates are installed in the specified period of time with no interaction from the user. If set to false, automatic upgrades are disabled.</p> 
master.<br>maintenancePolicy.<br>maintenanceWindow | **object**<br><p>Maintenance window settings. Update will start at the specified time and last no more than the specified duration. The time is set in UTC.</p> 
master.<br>maintenancePolicy.<br>maintenanceWindow.<br>anytime | **object** <br>`master.maintenancePolicy.maintenanceWindow` includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`<br>
master.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow | **object** <br>`master.maintenancePolicy.maintenanceWindow` includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`<br>
master.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime | **object**<br><p>Required. Window start time, in the UTC timezone.</p> <p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
master.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value "24:00:00" for scenarios like business closing time.</p> 
master.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
master.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
master.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
master.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>duration | **string**<br><p>Window duration.</p> <p>Acceptable values are 3600 seconds to 86400 seconds, inclusive.</p> 
master.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow | **object** <br>`master.maintenancePolicy.maintenanceWindow` includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`<br>
master.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[] | **object**<br><p>Required. Days of the week and the maintenance window for these days when automatic updates are allowed.</p> <p>The number of elements must be in the range 1-7.</p> 
master.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>days[] | **string**<br><p>Required. Days of the week when automatic updates are allowed.</p> <p>The number of elements must be in the range 1-7.</p> <ul> <li>MONDAY: The day-of-week of Monday.</li> <li>TUESDAY: The day-of-week of Tuesday.</li> <li>WEDNESDAY: The day-of-week of Wednesday.</li> <li>THURSDAY: The day-of-week of Thursday.</li> <li>FRIDAY: The day-of-week of Friday.</li> <li>SATURDAY: The day-of-week of Saturday.</li> <li>SUNDAY: The day-of-week of Sunday.</li> </ul> 
master.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime | **object**<br><p>Required. Window start time, in the UTC timezone.</p> <p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
master.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value "24:00:00" for scenarios like business closing time.</p> 
master.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
master.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
master.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
master.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>duration | **string**<br><p>Window duration.</p> <p>Acceptable values are 3600 seconds to 86400 seconds, inclusive.</p> 
master.<br>securityGroupIds[] | **string**<br><p>Master security groups.</p> 
master.<br>masterLogging | **object**
master.<br>masterLogging.<br>enabled | **boolean** (boolean)<br><p>Identifies whether Cloud Logging is enabled for master components.</p> 
master.<br>masterLogging.<br>auditEnabled | **boolean** (boolean)<br><p>Identifies whether Cloud Logging is enabled for audit logs.</p> 
master.<br>masterLogging.<br>clusterAutoscalerEnabled | **boolean** (boolean)<br><p>Identifies whether Cloud Logging is enabled for cluster-autoscaler.</p> 
master.<br>masterLogging.<br>kubeApiserverEnabled | **boolean** (boolean)<br><p>Identifies whether Cloud Logging is enabled for kube-apiserver.</p> 
master.<br>masterLogging.<br>eventsEnabled | **boolean** (boolean)<br><p>Identifies whether Cloud Logging is enabled for events.</p> 
master.<br>masterLogging.<br>logGroupId | **string** <br>`master.masterLogging` includes only one of the fields `logGroupId`, `folderId`<br><br><p>ID of the log group where logs of master components should be stored.</p> <p>Value must match the regular expression ``([a-zA-Z][-a-zA-Z0-9_.]{0,63})?``.</p> 
master.<br>masterLogging.<br>folderId | **string** <br>`master.masterLogging` includes only one of the fields `logGroupId`, `folderId`<br><br><p>ID of the folder where logs should be stored (in default group).</p> <p>Value must match the regular expression ``([a-zA-Z][-a-zA-Z0-9_.]{0,63})?``.</p> 
master.<br>zonalMaster | **object** <br>`master` includes only one of the fields `zonalMaster`, `regionalMaster`<br>
master.<br>zonalMaster.<br>zoneId | **string**<br><p>ID of the availability zone where the master resides.</p> 
master.<br>zonalMaster.<br>internalV4Address | **string**<br><p>IPv4 internal network address that is assigned to the master.</p> 
master.<br>zonalMaster.<br>externalV4Address | **string**<br><p>IPv4 external network address that is assigned to the master.</p> 
master.<br>regionalMaster | **object** <br>`master` includes only one of the fields `zonalMaster`, `regionalMaster`<br>
master.<br>regionalMaster.<br>regionId | **string**<br><p>ID of the region where the master resides.</p> 
master.<br>regionalMaster.<br>internalV4Address | **string**<br><p>IPv4 internal network address that is assigned to the master.</p> 
master.<br>regionalMaster.<br>externalV4Address | **string**<br><p>IPv4 external network address that is assigned to the master.</p> 
master.<br>regionalMaster.<br>externalV6Address | **string**<br><p>IPv6 external network address that is assigned to the master.</p> 
ipAllocationPolicy | **object**
ipAllocationPolicy.<br>clusterIpv4CidrBlock | **string**<br><p>CIDR block. IP range for allocating pod addresses.</p> <p>It should not overlap with any subnet in the network the Kubernetes cluster located in. Static routes will be set up for this CIDR blocks in node subnets.</p> 
ipAllocationPolicy.<br>nodeIpv4CidrMaskSize | **string** (int64)<br><p>Size of the masks that are assigned for each node in the cluster.</p> <p>If not specified, 24 is used.</p> <p>Value must be one of 0, 24, 25, 26, 27 or 28.</p> 
ipAllocationPolicy.<br>serviceIpv4CidrBlock | **string**<br><p>CIDR block. IP range Kubernetes service Kubernetes cluster IP addresses will be allocated from.</p> <p>It should not overlap with any subnet in the network the Kubernetes cluster located in.</p> 
ipAllocationPolicy.<br>clusterIpv6CidrBlock | **string**<br><p>IPv6 range for allocating pod IP addresses.</p> 
ipAllocationPolicy.<br>serviceIpv6CidrBlock | **string**<br><p>IPv6 range for allocating Kubernetes service IP addresses</p> 
serviceAccountId | **string**<br><p>Service account to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster.</p> 
nodeServiceAccountId | **string**<br><p>Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics.</p> 
releaseChannel | **string**<br>When creating a Kubernetes cluster, you should specify one of three release channels. The release channel contains several Kubernetes versions. Channels differ in the set of available versions, the management of auto-updates, and the updates received. You can't change the channel once the Kubernetes cluster is created, you can only recreate the Kubernetes cluster and specify a new release channel. For more details see [documentation](https://cloud.yandex.com/docs/managed-kubernetes/concepts/release-channels-and-updates).<br><ul> <li>RAPID: Minor updates with new functions and improvements are often added. You can't disable automatic updates in this channel, but you can specify a time period for automatic updates.</li> <li>REGULAR: New functions and improvements are added in chunks shortly after they appear on ``RAPID``.</li> <li>STABLE: Only updates related to bug fixes or security improvements are added.</li> </ul> 
networkPolicy | **object**
networkPolicy.<br>provider | **string**
kmsProvider | **object**
kmsProvider.<br>keyId | **string**<br><p>KMS key ID for secrets encryption. To obtain a KMS key ID use a <a href="/docs/kms/api-ref/SymmetricKey/list">list</a> request.</p> 
logGroupId | **string**<br><p>Log group where cluster stores cluster system logs, like audit, events, or controlplane logs.</p> 
gatewayIpv4Address | **string**<br><p>Gateway IPv4 address.</p> <p>The maximum string length in characters is 15.</p> 
cilium | **object**
cilium.<br>routingMode | **string**

## Methods {#methods}
Method | Description
--- | ---
[create](create.md) | Creates a Kubernetes cluster in the specified folder.
[delete](delete.md) | Deletes the specified Kubernetes cluster.
[get](get.md) | Returns the specified Kubernetes cluster.
[list](list.md) | Retrieves the list of Kubernetes cluster in the specified folder.
[listNodeGroups](listNodeGroups.md) | Lists nodegroup for the specified Kubernetes cluster.
[listNodes](listNodes.md) | Lists cluster's nodes.
[listOperations](listOperations.md) | Lists operations for the specified Kubernetes cluster.
[start](start.md) | Starts the specified Kubernetes cluster.
[stop](stop.md) | Stops the specified Kubernetes cluster.
[update](update.md) | Updates the specified Kubernetes cluster.