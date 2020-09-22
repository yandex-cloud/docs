---
editable: false
---

# Method get
Returns the specified subcluster.
 
To get the list of all available subclusters, make a [list](/docs/data-proc/api-ref/Subcluster/list) request.
 
## HTTP request {#https-request}
```
GET https://dataproc.api.cloud.yandex.net/dataproc/v1/clusters/{clusterId}/subclusters/{subclusterId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the Data Proc cluster that the subcluster belongs to.  The maximum string length in characters is 50.
subclusterId | Required. ID of the subcluster to return.  To get a subcluster ID make a [list](/docs/data-proc/api-ref/Subcluster/list) request.  The maximum string length in characters is 50.
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "clusterId": "string",
  "createdAt": "string",
  "name": "string",
  "role": "string",
  "resources": {
    "resourcePresetId": "string",
    "diskTypeId": "string",
    "diskSize": "string"
  },
  "subnetId": "string",
  "hostsCount": "string",
  "autoscalingConfig": {
    "maxHostsCount": "string",
    "preemptible": true,
    "measurementDuration": "string",
    "warmupDuration": "string",
    "stabilizationDuration": "string",
    "cpuUtilizationTarget": "number",
    "decommissionTimeout": "string"
  },
  "instanceGroupId": "string"
}
```
A Data Proc subcluster. For details about the concept, see [documentation](/docs/data-proc/concepts/).
 
Field | Description
--- | ---
id | **string**<br><p>ID of the subcluster. Generated at creation time.</p> 
clusterId | **string**<br><p>ID of the Data Proc cluster that the subcluster belongs to.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the subcluster. The name is unique within the cluster.</p> <p>The string length in characters must be 1-63.</p> 
role | **string**<br><p>Role that is fulfilled by hosts of the subcluster.</p> <ul> <li>MASTERNODE: The subcluster fulfills the master role.</li> </ul> <p>Master can run the following services, depending on the requested components:</p> <ul> <li>HDFS: Namenode, Secondary Namenode</li> <li>YARN: ResourceManager, Timeline Server</li> <li>HBase Master</li> <li>Hive: Server, Metastore, HCatalog</li> <li>Spark History Server</li> <li>Zeppelin</li> <li>ZooKeeper</li> </ul> <ul> <li>DATANODE: The subcluster is a DATANODE in a Data Proc cluster.</li> </ul> <p>DATANODE can run the following services, depending on the requested components:</p> <ul> <li>HDFS DataNode</li> <li>YARN NodeManager</li> <li>HBase RegionServer</li> <li>Spark libraries</li> </ul> <ul> <li>COMPUTENODE: The subcluster is a COMPUTENODE in a Data Proc cluster.</li> </ul> <p>COMPUTENODE can run the following services, depending on the requested components:</p> <ul> <li>YARN NodeManager</li> <li>Spark libraries</li> </ul> 
resources | **object**<br><p>Resources allocated for each host in the subcluster.</p> 
resources.<br>resourcePresetId | **string**<br><p>ID of the resource preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/data-proc/concepts/instance-types">documentation</a>.</p> 
resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd — network HDD drive,</li> <li>network-ssd — network SSD drive.</li> </ul> 
resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
subnetId | **string**<br><p>ID of the VPC subnet used for hosts in the subcluster.</p> 
hostsCount | **string** (int64)<br><p>Number of hosts in the subcluster.</p> 
autoscalingConfig | **object**<br><p>Configuration for instance group based subclusters</p> 
autoscalingConfig.<br>maxHostsCount | **string** (int64)<br><p>Upper limit for total instance subcluster count.</p> <p>Acceptable values are 1 to 100, inclusive.</p> 
autoscalingConfig.<br>preemptible | **boolean** (boolean)<br><p>Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time if their resources are needed by Compute. For more information, see <a href="/docs/compute/concepts/preemptible-vm">Preemptible Virtual Machines</a>.</p> 
autoscalingConfig.<br>measurementDuration | **string**<br><p>Required. Time in seconds allotted for averaging metrics.</p> <p>Acceptable values are 60 seconds to 600 seconds, inclusive.</p> 
autoscalingConfig.<br>warmupDuration | **string**<br><p>The warmup time of the instance in seconds. During this time, traffic is sent to the instance, but instance metrics are not collected.</p> <p>The maximum value is 600 seconds.</p> 
autoscalingConfig.<br>stabilizationDuration | **string**<br><p>Minimum amount of time in seconds allotted for monitoring before Instance Groups can reduce the number of instances in the group. During this time, the group size doesn't decrease, even if the new metric values indicate that it should.</p> <p>Acceptable values are 60 seconds to 1800 seconds, inclusive.</p> 
autoscalingConfig.<br>cpuUtilizationTarget | **number** (double)<br><p>Defines an autoscaling rule based on the average CPU utilization of the instance group.</p> <p>Acceptable values are 10 to 100, inclusive.</p> 
autoscalingConfig.<br>decommissionTimeout | **string** (int64)<br><p>Timeout to gracefully decommission nodes during downscaling. In seconds. Default value: 120</p> <p>Acceptable values are 0 to 86400, inclusive.</p> 
instanceGroupId | **string**<br><p>ID of Compute Instance Group for autoscaling subclusters</p> 