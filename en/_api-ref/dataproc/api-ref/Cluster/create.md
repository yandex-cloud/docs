---
editable: false
---

# Method create
Creates a cluster in the specified folder.
 

 
## HTTP request {#https-request}
```
POST https://dataproc.{{ api-host }}/dataproc/v1/clusters
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
      ],
      "initializationActions": [
        {
          "uri": "string",
          "args": [
            "string"
          ],
          "timeout": "string"
        }
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
        "hostsCount": "string",
        "assignPublicIp": true,
        "autoscalingConfig": {
          "maxHostsCount": "string",
          "preemptible": true,
          "measurementDuration": "string",
          "warmupDuration": "string",
          "stabilizationDuration": "string",
          "cpuUtilizationTarget": "number",
          "decommissionTimeout": "string"
        }
      }
    ]
  },
  "zoneId": "string",
  "serviceAccountId": "string",
  "bucket": "string",
  "uiProxy": true,
  "securityGroupIds": [
    "string"
  ],
  "hostGroupIds": [
    "string"
  ],
  "deletionProtection": true,
  "logGroupId": "string"
}
```

 
Field | Description
--- | ---
folderId | **string**<br><p>Required. ID of the folder to create a cluster in.</p> <p>To get a folder ID make a <a href="/docs/resource-manager/api-ref/Folder/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
name | **string**<br><p>Name of the cluster. The name must be unique within the folder. The name can't be changed after the Data Proc cluster is created.</p> <p>Value must match the regular expression ``\|[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
description | **string**<br><p>Description of the cluster.</p> <p>The maximum string length in characters is 256.</p> 
labels | **object**<br><p>Cluster labels as ``key:value`` pairs.</p> <p>No more than 64 per resource. The string length in characters for each key must be 1-63. Each key must match the regular expression ``[a-z][-_0-9a-z]*``. The maximum string length in characters for each value is 63. Each value must match the regular expression ``[-_0-9a-z]*``.</p> 
configSpec | **object**<br><p>Required. Configuration and resources for hosts that should be created with the cluster.</p> 
configSpec.<br>versionId | **string**<br><p>Version of the image for cluster provisioning.</p> <p>All available versions are listed in the <a href="/docs/data-proc/concepts/environment">documentation</a>.</p> 
configSpec.<br>hadoop | **object**<br><p>Data Proc specific options.</p> <p>Hadoop configuration that describes services installed in a cluster, their properties and settings.</p> 
configSpec.<br>hadoop.<br>services[] | **string**<br><p>Set of services used in the cluster (if empty, the default set is used).</p> 
configSpec.<br>hadoop.<br>properties | **object**<br><p>Properties set for all hosts in ``*-site.xml`` configurations. The key should indicate the service and the property.</p> <p>For example, use the key 'hdfs:dfs.replication' to set the ``dfs.replication`` property in the file ``/etc/hadoop/conf/hdfs-site.xml``.</p> 
configSpec.<br>hadoop.<br>sshPublicKeys[] | **string**<br><p>List of public SSH keys to access to cluster hosts.</p> 
configSpec.<br>hadoop.<br>initializationActions[] | **object**<br><p>Set of init-actions</p> 
configSpec.<br>hadoop.<br>initializationActions[].<br>uri | **string**<br><p>URI of the executable file</p> 
configSpec.<br>hadoop.<br>initializationActions[].<br>args[] | **string**<br><p>Arguments to the initialization action</p> 
configSpec.<br>hadoop.<br>initializationActions[].<br>timeout | **string** (int64)<br><p>Execution timeout</p> 
configSpec.<br>subclustersSpec[] | **object**<br><p>Specification for creating subclusters.</p> 
configSpec.<br>subclustersSpec[].<br>name | **string**<br><p>Name of the subcluster.</p> <p>Value must match the regular expression ``\|[a-z][-a-z0-9]{1,61}[a-z0-9]``.</p> 
configSpec.<br>subclustersSpec[].<br>role | **string**<br><p>Required. Role of the subcluster in the Data Proc cluster.</p> <ul> <li> <p>MASTERNODE: The subcluster fulfills the master role.</p> <p>Master can run the following services, depending on the requested components:</p> <ul> <li>HDFS: Namenode, Secondary Namenode</li> <li>YARN: ResourceManager, Timeline Server</li> <li>HBase Master</li> <li>Hive: Server, Metastore, HCatalog</li> <li>Spark History Server</li> <li>Zeppelin</li> <li>ZooKeeper</li> </ul> </li> <li> <p>DATANODE: The subcluster is a DATANODE in a Data Proc cluster.</p> <p>DATANODE can run the following services, depending on the requested components:</p> <ul> <li>HDFS DataNode</li> <li>YARN NodeManager</li> <li>HBase RegionServer</li> <li>Spark libraries</li> </ul> </li> <li> <p>COMPUTENODE: The subcluster is a COMPUTENODE in a Data Proc cluster.</p> <p>COMPUTENODE can run the following services, depending on the requested components:</p> <ul> <li>YARN NodeManager</li> <li>Spark libraries</li> </ul> </li> </ul> 
configSpec.<br>subclustersSpec[].<br>resources | **object**<br><p>Required. Resource configuration for hosts in the subcluster.</p> 
configSpec.<br>subclustersSpec[].<br>resources.<br>resourcePresetId | **string**<br><p>ID of the resource preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/data-proc/concepts/instance-types">documentation</a>.</p> 
configSpec.<br>subclustersSpec[].<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive.</li> </ul> 
configSpec.<br>subclustersSpec[].<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
configSpec.<br>subclustersSpec[].<br>subnetId | **string**<br><p>Required. ID of the VPC subnet used for hosts in the subcluster.</p> <p>The maximum string length in characters is 50.</p> 
configSpec.<br>subclustersSpec[].<br>hostsCount | **string** (int64)<br><p>Required. Number of hosts in the subcluster.</p> <p>The minimum value is 1.</p> 
configSpec.<br>subclustersSpec[].<br>assignPublicIp | **boolean** (boolean)<br><p>Assign public ip addresses for all hosts in subcluter.</p> 
configSpec.<br>subclustersSpec[].<br>autoscalingConfig | **object**<br><p>Configuration for instance group based subclusters</p> 
configSpec.<br>subclustersSpec[].<br>autoscalingConfig.<br>maxHostsCount | **string** (int64)<br><p>Upper limit for total instance subcluster count.</p> <p>Acceptable values are 1 to 100, inclusive.</p> 
configSpec.<br>subclustersSpec[].<br>autoscalingConfig.<br>preemptible | **boolean** (boolean)<br><p>Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time if their resources are needed by Compute. For more information, see <a href="/docs/compute/concepts/preemptible-vm">Preemptible Virtual Machines</a>.</p> 
configSpec.<br>subclustersSpec[].<br>autoscalingConfig.<br>measurementDuration | **string**<br><p>Required. Time in seconds allotted for averaging metrics.</p> <p>Acceptable values are 60 seconds to 600 seconds, inclusive.</p> 
configSpec.<br>subclustersSpec[].<br>autoscalingConfig.<br>warmupDuration | **string**<br><p>The warmup time of the instance in seconds. During this time, traffic is sent to the instance, but instance metrics are not collected.</p> <p>The maximum value is 600 seconds.</p> 
configSpec.<br>subclustersSpec[].<br>autoscalingConfig.<br>stabilizationDuration | **string**<br><p>Minimum amount of time in seconds allotted for monitoring before Instance Groups can reduce the number of instances in the group. During this time, the group size doesn't decrease, even if the new metric values indicate that it should.</p> <p>Acceptable values are 60 seconds to 1800 seconds, inclusive.</p> 
configSpec.<br>subclustersSpec[].<br>autoscalingConfig.<br>cpuUtilizationTarget | **number** (double)<br><p>Defines an autoscaling rule based on the average CPU utilization of the instance group.</p> <p>Acceptable values are 10 to 100, inclusive.</p> 
configSpec.<br>subclustersSpec[].<br>autoscalingConfig.<br>decommissionTimeout | **string** (int64)<br><p>Timeout to gracefully decommission nodes during downscaling. In seconds. Default value: 120</p> <p>Acceptable values are 0 to 86400, inclusive.</p> 
zoneId | **string**<br><p>Required. ID of the availability zone where the cluster should be placed.</p> <p>To get the list of available zones make a <a href="/docs/compute/api-ref/Zone/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
serviceAccountId | **string**<br><p>Required. ID of the service account to be used by the Data Proc manager agent.</p> 
bucket | **string**<br><p>Name of the Object Storage bucket to use for Data Proc jobs.</p> 
uiProxy | **boolean** (boolean)<br><p>Enable UI Proxy feature.</p> 
securityGroupIds[] | **string**<br><p>User security groups.</p> 
hostGroupIds[] | **string**<br><p>Host groups to place VMs of cluster on.</p> 
deletionProtection | **boolean** (boolean)<br><p>Deletion Protection inhibits deletion of the cluster</p> 
logGroupId | **string**<br><p>ID of the cloud logging log group to write logs. If not set, logs will not be sent to logging service</p> 
 
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