---
editable: false
sourcePath: en/_api-ref/k8s/api-ref/Cluster/update.md
---

# Method update
Updates the specified Kubernetes cluster.
 

 
## HTTP request {#https-request}
```
PATCH https://mks.{{ api-host }}/managed-kubernetes/v1/clusters/{clusterId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the Kubernetes cluster to update. To get the Kubernetes cluster ID use a <a href="/docs/managed-kubernetes/api-ref/Cluster/list">list</a> request.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "updateMask": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "masterSpec": {
    "version": {

      // `masterSpec.version` includes only one of the fields `version`, `latestRevision`
      "version": "string",
      "latestRevision": true,
      // end of the list of possible fields`masterSpec.version`

    },
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
    ]
  },
  "serviceAccountId": "string",
  "nodeServiceAccountId": "string",
  "networkPolicy": {
    "provider": "string"
  },
  "ipAllocationPolicy": {
    "clusterIpv4CidrBlock": "string",
    "nodeIpv4CidrMaskSize": "string",
    "serviceIpv4CidrBlock": "string",
    "clusterIpv6CidrBlock": "string",
    "serviceIpv6CidrBlock": "string"
  },
  "gatewayIpv4Address": "string"
}
```

 
Field | Description
--- | ---
updateMask | **string**<br><p>A comma-separated names off ALL fields to be updated. Оnly the specified fields will be changed. The others will be left untouched. If the field is specified in ``updateMask`` and no value for that field was sent in the request, the field's value will be reset to the default. The default value for most fields is null or 0.</p> <p>If ``updateMask`` is not sent in the request, all fields' values will be updated. Fields specified in the request will be updated to provided values. The rest of the fields will be reset to the default.</p> 
name | **string**<br><p>Name of the Kubernetes cluster. The name must be unique within the folder.</p> <p>Value must match the regular expression ``\|[a-z]([-a-z0-9]{0,61}[a-z0-9])?``.</p> 
description | **string**<br><p>Description of the Kubernetes cluster.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Resource labels as ``key:value`` pairs.</p> <p>Existing set of ``labels`` is completely replaced by the provided set.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_./\@0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_./\@0-9a-z]*``.</p> 
masterSpec | **object**<br>Specification of the master update.
masterSpec.<br>version | **object**<br><p>Specification of the master update.</p> 
masterSpec.<br>version.<br>version | **string** <br>`masterSpec.version` includes only one of the fields `version`, `latestRevision`<br><br><p>Request update to a newer version of Kubernetes (1.x -&gt; 1.y).</p> 
masterSpec.<br>version.<br>latestRevision | **boolean** (boolean) <br>`masterSpec.version` includes only one of the fields `version`, `latestRevision`<br><br><p>Request update to the latest revision for the current version.</p> 
masterSpec.<br>maintenancePolicy | **object**<br><p>Maintenance policy of the master.</p> 
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
serviceAccountId | **string**<br><p>Service account to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster. Selected service account should have ``edit`` role on the folder where the Kubernetes cluster will be located and on the folder where selected network resides.</p> 
nodeServiceAccountId | **string**<br><p>Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics.</p> 
networkPolicy | **object**
networkPolicy.<br>provider | **string**
ipAllocationPolicy | **object**<br>Allocation policy for IP addresses of services and pods inside the Kubernetes cluster in different availability zones.
ipAllocationPolicy.<br>clusterIpv4CidrBlock | **string**<br><p>CIDR block. IP range for allocating pod addresses.</p> <p>It should not overlap with any subnet in the network the Kubernetes cluster located in. Static routes will be set up for this CIDR blocks in node subnets.</p> 
ipAllocationPolicy.<br>nodeIpv4CidrMaskSize | **string** (int64)<br><p>Size of the masks that are assigned for each node in the cluster.</p> <p>If not specified, 24 is used.</p> <p>Value must be one of 0, 24, 25, 26, 27 or 28.</p> 
ipAllocationPolicy.<br>serviceIpv4CidrBlock | **string**<br><p>CIDR block. IP range Kubernetes service Kubernetes cluster IP addresses will be allocated from.</p> <p>It should not overlap with any subnet in the network the Kubernetes cluster located in.</p> 
ipAllocationPolicy.<br>clusterIpv6CidrBlock | **string**<br><p>IPv6 range for allocating pod IP addresses.</p> 
ipAllocationPolicy.<br>serviceIpv6CidrBlock | **string**<br><p>IPv6 range for allocating Kubernetes service IP addresses</p> 
gatewayIpv4Address | **string**<br><p>Gateway IPv4 address.</p> <p>The maximum string length in characters is 15.</p> 
 
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
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br>
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 