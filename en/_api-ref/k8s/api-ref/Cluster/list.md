---
editable: false
---

# Method list
Retrieves the list of Kubernetes cluster in the specified folder.
 

 
## HTTP request {#https-request}
```
GET https://mks.{{ api-host }}/managed-kubernetes/v1/clusters
```
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
folderId | <p>Required. ID of the folder to list Kubernetes cluster in. To get the folder ID use a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> 
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/managed-kubernetes/api-ref/Cluster/list#query_params">pageSize</a>, the service returns a <a href="/docs/managed-kubernetes/api-ref/Cluster/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token. To get the next page of results, set ``page_token`` to the <a href="/docs/managed-kubernetes/api-ref/Cluster/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters resources listed in the response. The expression must specify:</p> <ol> <li>The field name. Currently you can use filtering only on <a href="/docs/managed-kubernetes/api-ref/Cluster#representation">Cluster.name</a> field.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``). Must be 3-63 characters long and match the regular expression ``[a-z][-a-z0-9]{1,61}[a-z0-9]``.</li> </ol> <p>The maximum string length in characters is 1000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "clusters": [
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

            // `clusters[].master.maintenancePolicy.maintenanceWindow` includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`
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
            // end of the list of possible fields`clusters[].master.maintenancePolicy.maintenanceWindow`

          }
        },
        "securityGroupIds": [
          "string"
        ],

        // `clusters[].master` includes only one of the fields `zonalMaster`, `regionalMaster`
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
        // end of the list of possible fields`clusters[].master`

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
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
clusters[] | **object**<br><p>List of Kubernetes cluster.</p> 
clusters[].<br>id | **string**<br><p>ID of the Kubernetes cluster.</p> 
clusters[].<br>folderId | **string**<br><p>ID of the folder that the Kubernetes cluster belongs to.</p> 
clusters[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
clusters[].<br>name | **string**<br><p>Name of the Kubernetes cluster.</p> 
clusters[].<br>description | **string**<br><p>Description of the Kubernetes cluster. 0-256 characters long.</p> 
clusters[].<br>labels | **object**<br><p>Resource labels as ``key:value`` pairs. Maximum of 64 per resource.</p> 
clusters[].<br>status | **string**<br>Status of the Kubernetes cluster.<br><ul> <li>PROVISIONING: Kubernetes cluster is waiting for resources to be allocated.</li> <li>RUNNING: Kubernetes cluster is running.</li> <li>RECONCILING: Kubernetes cluster is being reconciled.</li> <li>STOPPING: Kubernetes cluster is being stopped.</li> <li>STOPPED: Kubernetes cluster stopped.</li> <li>DELETING: Kubernetes cluster is being deleted.</li> <li>STARTING: Kubernetes cluster is being started.</li> </ul> 
clusters[].<br>health | **string**<br>Health of the Kubernetes cluster.<br><ul> <li>HEALTHY: Kubernetes cluster is alive and well.</li> <li>UNHEALTHY: Kubernetes cluster is inoperable.</li> </ul> 
clusters[].<br>networkId | **string**<br><p>ID of the network the Kubernetes cluster belongs to.</p> 
clusters[].<br>master | **object**<br>Properties of the master for the Kubernetes cluster.<br>
clusters[].<br>master.<br>version | **string**<br><p>Version of Kubernetes components that runs on the master.</p> 
clusters[].<br>master.<br>endpoints | **object**<br>Endpoints of the master. Endpoints constitute of scheme and port (i.e. `https://ip-address:port`) and can be used by the clients to communicate with the Kubernetes API of the Kubernetes cluster.<br>
clusters[].<br>master.<br>endpoints.<br>internalV4Endpoint | **string**<br><p>Internal endpoint that can be used to connect to the master from cloud networks.</p> 
clusters[].<br>master.<br>endpoints.<br>externalV4Endpoint | **string**<br><p>External endpoint that can be used to access Kubernetes cluster API from the internet (outside of the cloud).</p> 
clusters[].<br>master.<br>endpoints.<br>externalV6Endpoint | **string**<br><p>External IPv6 endpoint that can be used to access Kubernetes cluster API from the internet (outside of the cloud).</p> 
clusters[].<br>master.<br>masterAuth | **object**<br>Master authentication parameters are used to establish trust between the master and a client.<br>
clusters[].<br>master.<br>masterAuth.<br>clusterCaCertificate | **string**<br><p>PEM-encoded public certificate that is the root of trust for the Kubernetes cluster.</p> 
clusters[].<br>master.<br>versionInfo | **object**<br>Detailed information about the Kubernetes version that is running on the master.<br>
clusters[].<br>master.<br>versionInfo.<br>currentVersion | **string**<br><p>Current Kubernetes version, format: major.minor (e.g. 1.15).</p> 
clusters[].<br>master.<br>versionInfo.<br>newRevisionAvailable | **boolean** (boolean)<br><p>Newer revisions may include Kubernetes patches (e.g 1.15.1 -&gt; 1.15.2) as well as some internal component updates - new features or bug fixes in platform specific components either on the master or nodes.</p> 
clusters[].<br>master.<br>versionInfo.<br>newRevisionSummary | **string**<br><p>Description of the changes to be applied when updating to the latest revision. Empty if new_revision_available is false.</p> 
clusters[].<br>master.<br>versionInfo.<br>versionDeprecated | **boolean** (boolean)<br><p>The current version is on the deprecation schedule, component (master or node group) should be upgraded.</p> 
clusters[].<br>master.<br>maintenancePolicy | **object**<br>Maintenance policy of the master.<br>
clusters[].<br>master.<br>maintenancePolicy.<br>autoUpgrade | **boolean** (boolean)<br><p>If set to true, automatic updates are installed in the specified period of time with no interaction from the user. If set to false, automatic upgrades are disabled.</p> 
clusters[].<br>master.<br>maintenancePolicy.<br>maintenanceWindow | **object**<br><p>Maintenance window settings. Update will start at the specified time and last no more than the specified duration. The time is set in UTC.</p> 
clusters[].<br>master.<br>maintenancePolicy.<br>maintenanceWindow.<br>anytime | **object**<br>Updating the master at any time. <br>`clusters[].master.maintenancePolicy.maintenanceWindow` includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`<br><br>
clusters[].<br>master.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow | **object**<br>Updating the master on any day during the specified time window. <br>`clusters[].master.maintenancePolicy.maintenanceWindow` includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`<br><br>
clusters[].<br>master.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime | **object**<br><p>Required. Window start time, in the UTC timezone.</p> <p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
clusters[].<br>master.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value "24:00:00" for scenarios like business closing time.</p> 
clusters[].<br>master.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
clusters[].<br>master.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
clusters[].<br>master.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
clusters[].<br>master.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>duration | **string**<br><p>Window duration.</p> <p>Acceptable values are 3600 seconds to 86400 seconds, inclusive.</p> 
clusters[].<br>master.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow | **object**<br>Updating the master on selected days during the specified time window. <br>`clusters[].master.maintenancePolicy.maintenanceWindow` includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`<br><br>
clusters[].<br>master.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[] | **object**<br><p>Required. Days of the week and the maintenance window for these days when automatic updates are allowed.</p> <p>The number of elements must be in the range 1-7.</p> 
clusters[].<br>master.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>days[] | **string**<br><p>Required. Days of the week when automatic updates are allowed.</p> <p>The number of elements must be in the range 1-7.</p> <ul> <li>MONDAY: The day-of-week of Monday.</li> <li>TUESDAY: The day-of-week of Tuesday.</li> <li>WEDNESDAY: The day-of-week of Wednesday.</li> <li>THURSDAY: The day-of-week of Thursday.</li> <li>FRIDAY: The day-of-week of Friday.</li> <li>SATURDAY: The day-of-week of Saturday.</li> <li>SUNDAY: The day-of-week of Sunday.</li> </ul> 
clusters[].<br>master.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime | **object**<br><p>Required. Window start time, in the UTC timezone.</p> <p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
clusters[].<br>master.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value "24:00:00" for scenarios like business closing time.</p> 
clusters[].<br>master.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
clusters[].<br>master.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
clusters[].<br>master.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
clusters[].<br>master.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>duration | **string**<br><p>Window duration.</p> <p>Acceptable values are 3600 seconds to 86400 seconds, inclusive.</p> 
clusters[].<br>master.<br>securityGroupIds[] | **string**<br><p>Master security groups.</p> 
clusters[].<br>master.<br>zonalMaster | **object**<br>Parameters of the availability zone for the master. <br>`clusters[].master` includes only one of the fields `zonalMaster`, `regionalMaster`<br><br>
clusters[].<br>master.<br>zonalMaster.<br>zoneId | **string**<br><p>ID of the availability zone where the master resides.</p> 
clusters[].<br>master.<br>zonalMaster.<br>internalV4Address | **string**<br><p>IPv4 internal network address that is assigned to the master.</p> 
clusters[].<br>master.<br>zonalMaster.<br>externalV4Address | **string**<br><p>IPv4 external network address that is assigned to the master.</p> 
clusters[].<br>master.<br>regionalMaster | **object**<br>Parameters of the region for the master. <br>`clusters[].master` includes only one of the fields `zonalMaster`, `regionalMaster`<br><br>
clusters[].<br>master.<br>regionalMaster.<br>regionId | **string**<br><p>ID of the region where the master resides.</p> 
clusters[].<br>master.<br>regionalMaster.<br>internalV4Address | **string**<br><p>IPv4 internal network address that is assigned to the master.</p> 
clusters[].<br>master.<br>regionalMaster.<br>externalV4Address | **string**<br><p>IPv4 external network address that is assigned to the master.</p> 
clusters[].<br>ipAllocationPolicy | **object**<br>Allocation policy for IP addresses of services and pods inside the Kubernetes cluster in different availability zones.<br>
clusters[].<br>ipAllocationPolicy.<br>clusterIpv4CidrBlock | **string**<br><p>CIDR block. IP range for allocating pod addresses.</p> <p>It should not overlap with any subnet in the network the Kubernetes cluster located in. Static routes will be set up for this CIDR blocks in node subnets.</p> 
clusters[].<br>ipAllocationPolicy.<br>nodeIpv4CidrMaskSize | **string** (int64)<br><p>Size of the masks that are assigned for each node in the cluster.</p> <p>If not specified, 24 is used.</p> <p>Value must be one of 0, 24, 25, 26, 27 or 28.</p> 
clusters[].<br>ipAllocationPolicy.<br>serviceIpv4CidrBlock | **string**<br><p>CIDR block. IP range Kubernetes service Kubernetes cluster IP addresses will be allocated from.</p> <p>It should not overlap with any subnet in the network the Kubernetes cluster located in.</p> 
clusters[].<br>ipAllocationPolicy.<br>clusterIpv6CidrBlock | **string**<br><p>IPv6 range for allocating pod IP addresses.</p> 
clusters[].<br>ipAllocationPolicy.<br>serviceIpv6CidrBlock | **string**<br><p>IPv6 range for allocating Kubernetes service IP addresses</p> 
clusters[].<br>serviceAccountId | **string**<br><p>Service account to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster.</p> 
clusters[].<br>nodeServiceAccountId | **string**<br><p>Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics.</p> 
clusters[].<br>releaseChannel | **string**<br>When creating a Kubernetes cluster, you should specify one of three release channels. The release channel contains several Kubernetes versions. Channels differ in the set of available versions, the management of auto-updates, and the updates received. You can't change the channel once the Kubernetes cluster is created, you can only recreate the Kubernetes cluster and specify a new release channel. For more details see [documentation](https://cloud.yandex.com/docs/managed-kubernetes/concepts/release-channels-and-updates).<br><ul> <li>RAPID: Minor updates with new functions and improvements are often added. You can't disable automatic updates in this channel, but you can specify a time period for automatic updates.</li> <li>REGULAR: New functions and improvements are added in chunks shortly after they appear on ``RAPID``.</li> <li>STABLE: Only updates related to bug fixes or security improvements are added.</li> </ul> 
clusters[].<br>networkPolicy | **object**<br>
clusters[].<br>networkPolicy.<br>provider | **string**<br>
clusters[].<br>kmsProvider | **object**<br>KMS provider configuration.<br>
clusters[].<br>kmsProvider.<br>keyId | **string**<br><p>KMS key ID for secrets encryption. To obtain a KMS key ID use a <a href="/docs/kms/api-ref/SymmetricKey/list">list</a> request.</p> 
clusters[].<br>logGroupId | **string**<br><p>Log group where cluster stores cluster system logs, like audit, events, or controlplane logs.</p> 
clusters[].<br>gatewayIpv4Address | **string**<br><p>Gateway IPv4 address.</p> <p>The maximum string length in characters is 15.</p> 
clusters[].<br>cilium | **object**<br>
clusters[].<br>cilium.<br>routingMode | **string**<br>
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-kubernetes/api-ref/Cluster/list#query_params">pageSize</a>, use the ``next_page_token`` as the value for the <a href="/docs/managed-kubernetes/api-ref/Cluster/list#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own ``next_page_token`` to continue paging through the results.</p> 