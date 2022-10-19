---
editable: false
---

# Method create
Creates an OpenSearch cluster.
 

 
## HTTP request {#https-request}
```
POST https://{{ api-host-mdb }}/managed-opensearch/v1/clusters
```
 
## Body parameters {#body_params}
 
```json 
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "environment": "string",
  "configSpec": {
    "version": "string",
    "adminPassword": "string",
    "opensearchSpec": {
      "plugins": [
        "string"
      ],
      "nodeGroups": [
        {
          "name": "string",
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "hostsCount": "string",
          "zoneIds": [
            "string"
          ],
          "subnetIds": [
            "string"
          ],
          "assignPublicIp": true,
          "roles": [
            "string"
          ]
        }
      ]
    },
    "dashboardsSpec": {
      "nodeGroups": [
        {
          "name": "string",
          "resources": {
            "resourcePresetId": "string",
            "diskSize": "string",
            "diskTypeId": "string"
          },
          "hostsCount": "string",
          "zoneIds": [
            "string"
          ],
          "subnetIds": [
            "string"
          ],
          "assignPublicIp": true
        }
      ]
    },
    "access": {
      "dataTransfer": true,
      "serverless": true
    }
  },
  "networkId": "string",
  "securityGroupIds": [
    "string"
  ],
  "serviceAccountId": "string",
  "deletionProtection": true,
  "maintenanceWindow": {

    // `maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`
    "anytime": {},
    "weeklyMaintenanceWindow": {
      "day": "string",
      "hour": "string"
    },
    // end of the list of possible fields`maintenanceWindow`

  }
}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>Required. ID of the folder to create the OpenSearch cluster in.</p> <p>The maximum string length in characters is 50.</p> 
name | **string**<br><p>Required. Name of the OpenSearch cluster. The name must be unique within the folder.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
description | **string**<br><p>Description of the OpenSearch cluster.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Custom labels for the OpenSearch cluster as ``key:value`` pairs. Maximum 64 per resource. For example, "project": "mvp" or "source": "dictionary".</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``.</p> 
environment | **string**<br><p>Deployment environment of the OpenSearch cluster.</p> <ul> <li>PRODUCTION: Stable environment with a conservative update policy: only hotfixes are applied during regular maintenance.</li> <li>PRESTABLE: Environment with more aggressive update policy: new versions are rolled out irrespective of backward compatibility.</li> </ul> 
configSpec | **object**<br><p>Required. Cluster configuration and resources for hosts that should be created for the OpenSearch cluster.</p> 
configSpec.<br>version | **string**<br><p>OpenSearch version.</p> 
configSpec.<br>adminPassword | **string**<br><p>Required. OpenSearch admin password.</p> 
configSpec.<br>opensearchSpec | **object**<br><p>OpenSearch configuration</p> <p>OpenSearch create-time configuration</p> 
configSpec.<br>opensearchSpec.<br>plugins[] | **string**<br><p>Cluster plugins</p> 
configSpec.<br>opensearchSpec.<br>nodeGroups[] | **object**
configSpec.<br>opensearchSpec.<br>nodeGroups[].<br>name | **string**<br><p>Required. Required. Name of the group to be created.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
configSpec.<br>opensearchSpec.<br>nodeGroups[].<br>resources | **object**<br><p>Resources allocated to data node hosts.</p> 
configSpec.<br>opensearchSpec.<br>nodeGroups[].<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.).</p> 
configSpec.<br>opensearchSpec.<br>nodeGroups[].<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>opensearchSpec.<br>nodeGroups[].<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> 
configSpec.<br>opensearchSpec.<br>nodeGroups[].<br>hostsCount | **string** (int64)<br><p>Number of nodes in the group</p> <p>The minimum value is 1.</p> 
configSpec.<br>opensearchSpec.<br>nodeGroups[].<br>zoneIds[] | **string**<br><p>IDs of the availability zone for hosts</p> <p>The maximum number of elements is 10. The maximum string length in characters for each value is 50.</p> 
configSpec.<br>opensearchSpec.<br>nodeGroups[].<br>subnetIds[] | **string**<br><p>IDs of the subnetworks in respective zones.</p> <p>The maximum number of elements is 10. The maximum string length in characters for each value is 50.</p> 
configSpec.<br>opensearchSpec.<br>nodeGroups[].<br>assignPublicIp | **boolean** (boolean)
configSpec.<br>opensearchSpec.<br>nodeGroups[].<br>roles[] | **string**
configSpec.<br>dashboardsSpec | **object**<br><p>Dashboards configuration</p> <p>Dashboards create-time configuration</p> 
configSpec.<br>dashboardsSpec.<br>nodeGroups[] | **object**
configSpec.<br>dashboardsSpec.<br>nodeGroups[].<br>name | **string**<br><p>Required. Required. Name of the group to be created.</p> <p>The maximum string length in characters is 63. Value must match the regular expression ``[a-zA-Z0-9_-]*``.</p> 
configSpec.<br>dashboardsSpec.<br>nodeGroups[].<br>resources | **object**<br><p>Resources allocated to data node hosts.</p> 
configSpec.<br>dashboardsSpec.<br>nodeGroups[].<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.).</p> 
configSpec.<br>dashboardsSpec.<br>nodeGroups[].<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>dashboardsSpec.<br>nodeGroups[].<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> 
configSpec.<br>dashboardsSpec.<br>nodeGroups[].<br>hostsCount | **string** (int64)<br><p>Number of nodes in the group</p> <p>The minimum value is 1.</p> 
configSpec.<br>dashboardsSpec.<br>nodeGroups[].<br>zoneIds[] | **string**<br><p>IDs of the availability zone for hosts</p> 
configSpec.<br>dashboardsSpec.<br>nodeGroups[].<br>subnetIds[] | **string**<br><p>IDs of the subnetworks in respective zones.</p> <p>The maximum number of elements is 10. The maximum string length in characters for each value is 50.</p> 
configSpec.<br>dashboardsSpec.<br>nodeGroups[].<br>assignPublicIp | **boolean** (boolean)
configSpec.<br>access | **object**<br><p>Access for other services.</p> 
configSpec.<br>access.<br>dataTransfer | **boolean** (boolean)<br><p>Allow access for DataTransfer. NOTE: Do not propagate to public API until Data Transfer integration is required.</p> 
configSpec.<br>access.<br>serverless | **boolean** (boolean)<br><p>Allow access for Serverless. NOTE: Do not propagate to public API until Serverless integration is required.</p> 
networkId | **string**<br><p>Required. ID of the network to create the cluster in.</p> <p>The maximum string length in characters is 50.</p> 
securityGroupIds[] | **string**<br><p>User security groups</p> 
serviceAccountId | **string**<br><p>ID of the service account used for access to Yandex Object Storage.</p> 
deletionProtection | **boolean** (boolean)<br><p>Deletion Protection inhibits deletion of the cluster</p> 
maintenanceWindow | **object**<br><p>Window of maintenance operations</p> 
maintenanceWindow.<br>anytime | **object** <br>`maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br>
maintenanceWindow.<br>weeklyMaintenanceWindow | **object** <br>`maintenanceWindow` includes only one of the fields `anytime`, `weeklyMaintenanceWindow`<br>
maintenanceWindow.<br>weeklyMaintenanceWindow.<br>day | **string**
maintenanceWindow.<br>weeklyMaintenanceWindow.<br>hour | **string** (int64)<br><p>Hour of the day in UTC</p> <p>Acceptable values are 1 to 24, inclusive.</p> 
 
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