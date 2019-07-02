---
editable: false
---

# Method create
Creates a Dataproc cluster.
 

 
## HTTP request {#https-request}
```
POST https://dataproc.api.cloud.yandex.net/dataproc/v1/clusters
```
 
## Body parameters {#body_params}
 
```json 
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "configSpec": {
    "versionId": "string",
    "hadoop": {
      "services": [
        "string"
      ],
      "properties": "object",
      "sshPublicKeys": [
        "string"
      ]
    },
    "subclustersSpec": [
      {
        "name": "string",
        "role": "string",
        "resources": {
          "resourcePresetId": "string",
          "diskTypeId": "string",
          "diskSize": "string"
        },
        "subnetId": "string",
        "hostsCount": "string"
      }
    ]
  },
  "zoneId": "string",
  "serviceAccountId": "string"
}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>Required. ID of the folder that the Dataproc cluster belongs to.</p> <p>The maximum string length in characters is 50.</p> 
name | **string**<br><p>Name of the Dataproc cluster. The name must be unique within the folder. The name must be 1-63 characters long and match the regular expression <code>^[a-z]([-a-z0-9]{,61}[a-z0-9])?$</code>. The name can’t be changed after the Dataproc cluster is created.</p> <p>Value must match the regular expression <code>\|[a-z][-a-z0-9]{1,61}[a-z0-9]</code>.</p> 
description | **string**<br><p>Description of the Dataproc cluster. 0-256 characters long.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Custom labels for the Dataproc cluster as <code>key:value</code> pairs. Maximum 64 per resource.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression <code>[a-z][-_0-9a-z]*</code>. The maximum string length in characters for each value is 63. Each value must match the regular expression <code>[-_0-9a-z]*</code>.</p> 
configSpec | **object**<br><p>Required. Configuration and resources for hosts that should be created for the Dataproc cluster.</p> 
configSpec.<br>versionId | **string**<br><p>Vesion of image for cluster provisioning. All available versions are listed in the <a href="/docs/data-proc/concepts/image-versions">documentation</a>.</p> 
configSpec.<br>hadoop | **object**<br><p>Dataproc specific options.</p> <p>Configuration, that describes application logic of installed services, their properties and settings.</p> 
configSpec.<br>hadoop.<br>services[] | **string**<br><p>List of used services in cluster (for default use empty)</p> 
configSpec.<br>hadoop.<br>properties | **object**<br><p>Properties passed to all hosts *-site.xml configurations. In key you need to use prefix 'hdfs:dfs.replication' for setting property 'dfs.replication' in /etc/hadoop/conf/hdfs-site.xml</p> 
configSpec.<br>hadoop.<br>sshPublicKeys[] | **string**<br><p>List of ssh public keys to access to cluster hosts.</p> 
configSpec.<br>subclustersSpec[] | **object**<br><p>Subclusters configuration.</p> 
configSpec.<br>subclustersSpec[].<br>name | **string**<br><p>Name of Dataproc subcluster.</p> <p>Value must match the regular expression <code>\|[a-z][-a-z0-9]{1,61}[a-z0-9]</code>.</p> 
configSpec.<br>subclustersSpec[].<br>role | **string**<br><p>Required. Role of hosts in subcluster.</p> <ul> <li>ROLE_UNSPECIFIED: Host have undefined role</li> <li>MASTERNODE: Masternode includes these services (depends on given component list)</li> </ul> <ul> <li>HDFS Namenode, Secondary Namenode,</li> <li>YARN ResorceManager, Timeline Server,</li> <li>Zookeeper,</li> <li>Hive Server, Hive Metastore, HCatalog</li> <li>HBase Master,</li> <li>Spark History Server,</li> <li>Zeppelin</li> </ul> <ul> <li>DATANODE: Datanode includes these services (depends on given component list)</li> </ul> <ul> <li>HDFS Datanode,</li> <li>YARN NodeManager,</li> <li>HBase RegionServer,</li> <li>Spark libraries.</li> </ul> <ul> <li>COMPUTENODE: Computenodes includes these services (depends on given component list)</li> </ul> <ul> <li>YARN NodeManager.</li> <li>Spark libraries.</li> </ul> 
configSpec.<br>subclustersSpec[].<br>resources | **object**<br><p>Required. Resource configuration for hosts in subcluster.</p> 
configSpec.<br>subclustersSpec[].<br>resources.<br>resourcePresetId | **string**<br><p>ID of the resource preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/data-proc/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>subclustersSpec[].<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd — network HDD drive,</li> <li>network-nvme — network SSD drive.</li> </ul> 
configSpec.<br>subclustersSpec[].<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>subclustersSpec[].<br>subnetId | **string**<br><p>Required. ID of using compute subnet for hosts in subcluster.</p> <p>The maximum string length in characters is 50.</p> 
configSpec.<br>subclustersSpec[].<br>hostsCount | **string** (int64)<br><p>Required. Number of hosts in subcluster</p> <p>The minimum value is 1.</p> 
zoneId | **string**<br><p>Required. ID of the availability zone.</p> <p>The maximum string length in characters is 50.</p> 
serviceAccountId | **string**<br><p>Required. ID of the service account for Dataproc manager agent</p> 
 
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