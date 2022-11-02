---
editable: false
sourcePath: en/_api-ref/mdb/mysql/api-ref/Cluster/addHosts.md
---

# Method addHosts
Adds new hosts in a cluster.
 

 
## HTTP request {#https-request}
```
POST https://{{ api-host-mdb }}/managed-mysql/v1/clusters/{clusterId}/hosts:batchCreate
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the cluster to add hosts to.</p> <p>To get this ID, make a <a href="/docs/managed-mysql/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Body parameters {#body_params}
 
```json 
{
  "hostSpecs": [
    {
      "zoneId": "string",
      "subnetId": "string",
      "assignPublicIp": true,
      "replicationSource": "string",
      "backupPriority": "string",
      "priority": "string"
    }
  ]
}
```

 
Field | Description
--- | ---
hostSpecs[] | **object**<br><p>Required. Configuration of the newly added hosts.</p> <p>Must contain at least one element.</p> 
hostSpecs[].<br>zoneId | **string**<br><p>ID of the availability zone where the host resides.</p> <p>To get a list of available zones, make the <a href="/docs/compute/api-ref/Zone/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
hostSpecs[].<br>subnetId | **string**<br><p>ID of the subnet to assign to the host.</p> <p>This subnet should be a part of the cluster network (the network ID is specified in the [ClusterService.CreateClusterRequest.network_id]).</p> <p>The maximum string length in characters is 50.</p> 
hostSpecs[].<br>assignPublicIp | **boolean** (boolean)<br><p>Option that enables public IP address for the host so that the host can be accessed from the internet.</p> <p>After a host has been created, this setting cannot be changed. To remove an assigned public IP address, or to assign a public IP address to a host without one, recreate the host with the appropriate ``assignPublicIp`` value set.</p> <p>Possible values:</p> <ul> <li>``false`` - don't assign a public IP address to the host.</li> <li>``true`` - assign a public IP address to the host.</li> </ul> 
hostSpecs[].<br>replicationSource | **string**<br><p>``name`` of the host to be used as the replication source (for cascading replication).</p> 
hostSpecs[].<br>backupPriority | **string** (int64)<br><p>Host backup priority</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
hostSpecs[].<br>priority | **string** (int64)<br><p>Host master promotion priority</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
 
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