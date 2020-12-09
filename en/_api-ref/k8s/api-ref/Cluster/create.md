---
editable: false
---

# Method create
Creates a Kubernetes cluster in the specified folder.
 

 
## HTTP request {#https-request}
```
POST https://mks.api.cloud.yandex.net/managed-kubernetes/v1/clusters
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

    // `masterSpec` includes only one of the fields `zonalMasterSpec`, `regionalMasterSpec`
    "zonalMasterSpec": {
      "zoneId": "string",
      "internalV4AddressSpec": {
        "subnetId": "string"
      },
      "externalV4AddressSpec": {}
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
      "externalV4AddressSpec": {}
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
  "gatewayIpv4Address": "string"
}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>Required. ID of the folder to create a Kubernetes cluster in. To get the folder ID use a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> 
name | **string**<br><p>Name of the Kubernetes cluster. The name must be unique within the folder.</p> <p>Value must match the regular expression `` \|<a href="%5B-a-z0-9%5D%7B0,61%7D%5Ba-z0-9%5D">a-z</a>? ``.</p> 
description | **string**<br><p>Description of the Kubernetes cluster.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Resource labels as `key:value` pairs.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression `` [a-z][-<em>./@0-9a-z]* ``. The maximum string length in characters for each value is 63. Each value must match the regular expression `` [-</em>./@0-9a-z]* ``.</p> 
networkId | **string**<br><p>Required. ID of the network.</p> 
masterSpec | **object**<br>Required. IP allocation policy of the Kubernetes cluster.<br>
masterSpec.<br>version | **string**<br><p>Version of Kubernetes components that runs on the master.</p> 
masterSpec.<br>maintenancePolicy | **object**<br>Maintenance policy of the master.<br>
masterSpec.<br>maintenancePolicy.<br>autoUpgrade | **boolean** (boolean)<br><p>If set to true, automatic updates are installed in the specified period of time with no interaction from the user. If set to false, automatic upgrades are disabled.</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow | **object**<br><p>Maintenance window settings. Update will start at the specified time and last no more than the specified duration. The time is set in UTC.</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>anytime | **object**<br>Updating the master at any time. <br>`masterSpec.maintenancePolicy.maintenanceWindow` includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`<br><br>
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow | **object**<br>Updating the master on any day during the specified time window. <br>`masterSpec.maintenancePolicy.maintenanceWindow` includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`<br><br>
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime | **object**<br><p>Required. Window start time, in the UTC timezone.</p> <p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value &quot;24:00:00&quot; for scenarios like business closing time.</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>startTime.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>dailyMaintenanceWindow.<br>duration | **string**<br><p>Window duration.</p> <p>Acceptable values are 3600 seconds to 86400 seconds, inclusive.</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow | **object**<br>Updating the master on selected days during the specified time window. <br>`masterSpec.maintenancePolicy.maintenanceWindow` includes only one of the fields `anytime`, `dailyMaintenanceWindow`, `weeklyMaintenanceWindow`<br><br>
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[] | **object**<br><p>Required. Days of the week and the maintenance window for these days when automatic updates are allowed.</p> <p>The number of elements must be in the range 1-7.</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>days[] | **string**<br><p>Represents a day of week.</p> <ul> <li>DAY_OF_WEEK_UNSPECIFIED: The unspecified day-of-week.</li> <li>MONDAY: The day-of-week of Monday.</li> <li>TUESDAY: The day-of-week of Tuesday.</li> <li>WEDNESDAY: The day-of-week of Wednesday.</li> <li>THURSDAY: The day-of-week of Thursday.</li> <li>FRIDAY: The day-of-week of Friday.</li> <li>SATURDAY: The day-of-week of Saturday.</li> <li>SUNDAY: The day-of-week of Sunday.</li> </ul> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime | **object**<br><p>Required. Window start time, in the UTC timezone.</p> <p>Represents a time of day. The date and time zone are either not significant or are specified elsewhere. An API may choose to allow leap seconds. Related types are <a href="https://github.com/googleapis/googleapis/blob/master/google/type/date.proto">google.type.Date</a> and <a href="https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/timestamp.proto">google.protobuf.Timestamp</a>.</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime.<br>hours | **integer** (int32)<br><p>Hours of day in 24 hour format. Should be from 0 to 23. An API may choose to allow the value &quot;24:00:00&quot; for scenarios like business closing time.</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime.<br>minutes | **integer** (int32)<br><p>Minutes of hour of day. Must be from 0 to 59.</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime.<br>seconds | **integer** (int32)<br><p>Seconds of minutes of the time. Must normally be from 0 to 59. An API may allow the value 60 if it allows leap-seconds.</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>startTime.<br>nanos | **integer** (int32)<br><p>Fractions of seconds in nanoseconds. Must be from 0 to 999,999,999.</p> 
masterSpec.<br>maintenancePolicy.<br>maintenanceWindow.<br>weeklyMaintenanceWindow.<br>daysOfWeek[].<br>duration | **string**<br><p>Window duration.</p> <p>Acceptable values are 3600 seconds to 86400 seconds, inclusive.</p> 
masterSpec.<br>securityGroupIds[] | **string**<br><p>Master security groups.</p> 
masterSpec.<br>zonalMasterSpec | **object**<br>Specification of the zonal master. <br>`masterSpec` includes only one of the fields `zonalMasterSpec`, `regionalMasterSpec`<br><br>
masterSpec.<br>zonalMasterSpec.<br>zoneId | **string**<br><p>Required. ID of the availability zone.</p> 
masterSpec.<br>zonalMasterSpec.<br>internalV4AddressSpec | **object**<br><p>Specification of parameters for internal IPv4 networking.</p> 
masterSpec.<br>zonalMasterSpec.<br>internalV4AddressSpec.<br>subnetId | **string**<br><p>ID of the subnet. If no ID is specified, and there only one subnet in specified zone, an address in this subnet will be allocated.</p> 
masterSpec.<br>zonalMasterSpec.<br>externalV4AddressSpec | **object**<br><p>Specification of parameters for external IPv4 networking.</p> 
masterSpec.<br>regionalMasterSpec | **object**<br>Specification of the regional master. <br>`masterSpec` includes only one of the fields `zonalMasterSpec`, `regionalMasterSpec`<br><br>
masterSpec.<br>regionalMasterSpec.<br>regionId | **string**<br><p>Required. ID of the availability zone where the master resides.</p> 
masterSpec.<br>regionalMasterSpec.<br>locations[] | **object**<br><p>List of locations where the master will be allocated.</p> 
masterSpec.<br>regionalMasterSpec.<br>locations[].<br>zoneId | **string**<br><p>Required. ID of the availability zone.</p> 
masterSpec.<br>regionalMasterSpec.<br>locations[].<br>internalV4AddressSpec | **object**<br><p>If not specified and there is a single subnet in specified zone, address in this subnet will be allocated.</p> 
masterSpec.<br>regionalMasterSpec.<br>locations[].<br>internalV4AddressSpec.<br>subnetId | **string**<br><p>ID of the subnet. If no ID is specified, and there only one subnet in specified zone, an address in this subnet will be allocated.</p> 
masterSpec.<br>regionalMasterSpec.<br>externalV4AddressSpec | **object**<br><p>Specify to allocate a static public IP for the master.</p> 
ipAllocationPolicy | **object**<br>IP allocation policy of the Kubernetes cluster.<br>
ipAllocationPolicy.<br>clusterIpv4CidrBlock | **string**<br><p>CIDR block. IP range for allocating pod addresses.</p> <p>It should not overlap with any subnet in the network the Kubernetes cluster located in. Static routes will be set up for this CIDR blocks in node subnets.</p> 
ipAllocationPolicy.<br>nodeIpv4CidrMaskSize | **string** (int64)<br><p>Size of the masks that are assigned for each node in the cluster.</p> <p>If not specified, 24 is used.</p> <p>Value must be one of 0, 24, 25, 26, 27 or 28.</p> 
ipAllocationPolicy.<br>serviceIpv4CidrBlock | **string**<br><p>CIDR block. IP range Kubernetes service Kubernetes cluster IP addresses will be allocated from.</p> <p>It should not overlap with any subnet in the network the Kubernetes cluster located in.</p> 
ipAllocationPolicy.<br>clusterIpv6CidrBlock | **string**<br><p>IPv6 range for allocating pod IP addresses.</p> 
ipAllocationPolicy.<br>serviceIpv6CidrBlock | **string**<br><p>IPv6 range for allocating Kubernetes service IP addresses</p> 
serviceAccountId | **string**<br><p>Required. Service account to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster. Selected service account should have `edit` role on the folder where the Kubernetes cluster will be located and on the folder where selected network resides.</p> 
nodeServiceAccountId | **string**<br><p>Required. Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics.</p> 
releaseChannel | **string**<br>Release channel for the master.<br><ul> <li>RAPID: Minor updates with new functions and improvements are often added. You can't disable automatic updates in this channel, but you can specify a time period for automatic updates.</li> <li>REGULAR: New functions and improvements are added in chunks shortly after they appear on `RAPID`.</li> <li>STABLE: Only updates related to bug fixes or security improvements are added.</li> </ul> 
networkPolicy | **object**<br>
networkPolicy.<br>provider | **string**<br>
kmsProvider | **object**<br>KMS provider configuration.<br>
kmsProvider.<br>keyId | **string**<br><p>KMS key ID for secrets encryption. To obtain a KMS key ID use a <a href="/docs/kms/api-ref/SymmetricKey/list">list</a> request.</p> 
gatewayIpv4Address | **string**<br><p>Gateway IPv4 address.</p> 
 
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
done | **boolean** (boolean)<br><p>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available.</p> 
metadata | **object**<br><p>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any.</p> 
error | **object**<br>The error result of the operation in case of failure or cancellation. <br> includes only one of the fields `error`, `response`<br><br><p>The error result of the operation in case of failure or cancellation.</p> 
error.<br>code | **integer** (int32)<br><p>Error code. An enum value of <a href="https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto">google.rpc.Code</a>.</p> 
error.<br>message | **string**<br><p>An error message.</p> 
error.<br>details[] | **object**<br><p>A list of messages that carry the error details.</p> 
response | **object** <br> includes only one of the fields `error`, `response`<br><br><p>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is <a href="https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#empty">google.protobuf.Empty</a>. If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any.</p> 