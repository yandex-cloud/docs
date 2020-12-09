---
editable: false
---

# Cluster
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
      "externalV4Endpoint": "string"
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

    // `master` includes only one of the fields `zonalMaster`, `regionalMaster`
    "zonalMaster": {
      "zoneId": "string",
      "internalV4Address": "string",
      "externalV4Address": "string"
    },
    "regionalMaster": {
      "regionId": "string",
      "internalV4Address": "string",
      "externalV4Address": "string"
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
  "gatewayIpv4Address": "string"
}
```
 
Field | Description
--- | ---
id | **string**<br><p>ID of the Kubernetes cluster.</p> 
folderId | **string**<br><p>ID of the folder that the Kubernetes cluster belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the Kubernetes cluster.</p> 
description | **string**<br><p>Description of the Kubernetes cluster. 0-256 characters long.</p> 
labels | **object**<br><p>Resource labels as `key:value` pairs. Мaximum of 64 per resource.</p> 
status | **string**<br>Status of the Kubernetes cluster.<br><ul> <li>PROVISIONING: Kubernetes cluster is waiting for resources to be allocated.</li> <li>RUNNING: Kubernetes cluster is running.</li> <li>RECONCILING: Kubernetes cluster is being reconciled.</li> <li>STOPPING: Kubernetes cluster is being stopped.</li> <li>STOPPED: Kubernetes cluster stopped.</li> <li>DELETING: Kubernetes cluster is being deleted.</li> <li>STARTING: Kubernetes cluster is being started.</li> </ul> 
health | **string**<br>Health of the Kubernetes cluster.<br><ul> <li>HEALTHY: Kubernetes cluster is alive and well.</li> <li>UNHEALTHY: Kubernetes cluster is inoperable.</li> </ul> 
networkId | **string**<br><p>ID of the network the Kubernetes cluster belongs to.</p> 
master | **object**<br>
master.<br>version | **string**<br><p>Version of Kubernetes components that runs on the master.</p> 
master.<br>endpoints | **object**<br>
master.<br>endpoints.<br>internalV4Endpoint | **string**<br><p>Internal endpoint that can be used to connect to the master from cloud networks.</p> 
master.<br>endpoints.<br>externalV4Endpoint | **string**<br><p>External endpoint that can be used to access Kubernetes cluster API from the internet (outside of the cloud).</p> 
master.<br>masterAuth | **object**<br>
master.<br>masterAuth.<br>clusterCaCertificate | **string**<br><p>PEM-encoded public certificate that is the root of trust for the Kubernetes cluster.</p> 
master.<br>versionInfo | **object**<br>
master.<br>versionInfo.<br>currentVersion | **string**<br><p>Current Kubernetes version, format: major.minor (e.g. 1.15).</p> 
master.<br>versionInfo.<br>newRevisionAvailable | **boolean** (boolean)<br><p>Newer revisions may include Kubernetes patches (e.g 1.15.1 -&gt; 1.15.2) as well as some internal component updates — new features or bug fixes in Yandex specific components either on the master or nodes.</p> 
master.<br>versionInfo.<br>newRevisionSummary | **string**<br><p>Description of the changes to be applied when updating to the latest revision. Empty if new_revision_available is false.</p> 
master.<br>versionInfo.<br>versionDeprecated | **boolean** (boolean)<br><p>The current version is on the deprecation schedule, component (master or node group) should be upgraded.</p> 
master.<br>maintenancePolicy | **object**<br>
master.<br>maintenancePolicy.<br>autoUpgrade | **boolean** (boolean)<br><p>If set to true, automatic updates are installed in the specified period of time with no interaction from the user. If set to false, automatic upgrades are disabled.</p> 
master.<br>maintenancePolicy.<br>maintenanceWindow | **object**<br><p>Maintenance window settings. Update will start at the specified time and last no more than the specified duration. The time is set in UTC.</p> 
master.<br>maintenancePolicy.<br>maintenanceWindow.<br>anytime | **object** <br>`master.maintenancePolicy.maintenanceWindow` includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`<br><br>
master.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow | **object** <br>`master.maintenancePolicy.maintenanceWindow` includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`<br><br>
master.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime | **object**<br><p>Required. Window start time, in the UTC timezone.</p> <p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
master.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value &quot;24:00:00&quot; for scenarios like business closing time.</p> 
master.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
master.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
master.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
master.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>duration | **string**<br><p>Window duration.</p> <p>Acceptable values are 3600 seconds to 86400 seconds, inclusive.</p> 
master.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow | **object** <br>`master.maintenancePolicy.maintenanceWindow` includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`<br><br>
master.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[] | **object**<br><p>Required. Days of the week and the maintenance window for these days when automatic updates are allowed.</p> <p>The number of elements must be in the range 1-7.</p> 
master.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>days[] | **string**<br><p>Represents a day of week.</p> <ul> <li>DAY_OF_WEEK_UNSPECIFIED: The unspecified day-of-week.</li> <li>MONDAY: The day-of-week of Monday.</li> <li>TUESDAY: The day-of-week of Tuesday.</li> <li>WEDNESDAY: The day-of-week of Wednesday.</li> <li>THURSDAY: The day-of-week of Thursday.</li> <li>FRIDAY: The day-of-week of Friday.</li> <li>SATURDAY: The day-of-week of Saturday.</li> <li>SUNDAY: The day-of-week of Sunday.</li> </ul> 
master.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime | **object**<br><p>Required. Window start time, in the UTC timezone.</p> <p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
master.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value &quot;24:00:00&quot; for scenarios like business closing time.</p> 
master.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
master.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
master.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
master.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>duration | **string**<br><p>Window duration.</p> <p>Acceptable values are 3600 seconds to 86400 seconds, inclusive.</p> 
master.<br>securityGroupIds[] | **string**<br><p>Master security groups.</p> 
master.<br>zonalMaster | **object** <br>`master` includes only one of the fields `zonalMaster`, `regionalMaster`<br><br>
master.<br>zonalMaster.<br>zoneId | **string**<br><p>ID of the availability zone where the master resides.</p> 
master.<br>zonalMaster.<br>internalV4Address | **string**<br><p>IPv4 internal network address that is assigned to the master.</p> 
master.<br>zonalMaster.<br>externalV4Address | **string**<br><p>IPv4 external network address that is assigned to the master.</p> 
master.<br>regionalMaster | **object** <br>`master` includes only one of the fields `zonalMaster`, `regionalMaster`<br><br>
master.<br>regionalMaster.<br>regionId | **string**<br><p>ID of the region where the master resides.</p> 
master.<br>regionalMaster.<br>internalV4Address | **string**<br><p>IPv4 internal network address that is assigned to the master.</p> 
master.<br>regionalMaster.<br>externalV4Address | **string**<br><p>IPv4 external network address that is assigned to the master.</p> 
ipAllocationPolicy | **object**<br>
ipAllocationPolicy.<br>clusterIpv4CidrBlock | **string**<br><p>CIDR block. IP range for allocating pod addresses.</p> <p>It should not overlap with any subnet in the network the Kubernetes cluster located in. Static routes will be set up for this CIDR blocks in node subnets.</p> 
ipAllocationPolicy.<br>nodeIpv4CidrMaskSize | **string** (int64)<br><p>Size of the masks that are assigned for each node in the cluster.</p> <p>If not specified, 24 is used.</p> <p>Value must be one of 0, 24, 25, 26, 27 or 28.</p> 
ipAllocationPolicy.<br>serviceIpv4CidrBlock | **string**<br><p>CIDR block. IP range Kubernetes service Kubernetes cluster IP addresses will be allocated from.</p> <p>It should not overlap with any subnet in the network the Kubernetes cluster located in.</p> 
ipAllocationPolicy.<br>clusterIpv6CidrBlock | **string**<br><p>IPv6 range for allocating pod IP addresses.</p> 
ipAllocationPolicy.<br>serviceIpv6CidrBlock | **string**<br><p>IPv6 range for allocating Kubernetes service IP addresses</p> 
serviceAccountId | **string**<br><p>Service account to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster.</p> 
nodeServiceAccountId | **string**<br><p>Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics.</p> 
releaseChannel | **string**<br>When creating a Kubernetes cluster, you should specify one of three release channels. The release channel contains several Kubernetes versions. Channels differ in the set of available versions, the management of auto-updates, and the updates received. You can't change the channel once the Kubernetes cluster is created, you can only recreate the Kubernetes cluster and specify a new release channel. For more details see [documentation](https://cloud.yandex.com/docs/managed-kubernetes/concepts/release-channels-and-updates).<br><ul> <li>RAPID: Minor updates with new functions and improvements are often added. You can't disable automatic updates in this channel, but you can specify a time period for automatic updates.</li> <li>REGULAR: New functions and improvements are added in chunks shortly after they appear on `RAPID`.</li> <li>STABLE: Only updates related to bug fixes or security improvements are added.</li> </ul> 
networkPolicy | **object**<br>
networkPolicy.<br>provider | **string**<br>
kmsProvider | **object**<br>
kmsProvider.<br>keyId | **string**<br><p>KMS key ID for secrets encryption. To obtain a KMS key ID use a <a href="/docs/kms/api-ref/SymmetricKey/list">list</a> request.</p> 
logGroupId | **string**<br><p>Log group where cluster stores cluster system logs, like audit, events, or controlplane logs.</p> 
gatewayIpv4Address | **string**<br><p>Gateway IPv4 address.</p> <p>The maximum string length in characters is 15.</p> 

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