---
editable: false
---

# Method get
Returns the specified Dataproc subcluster resource.
 
To get the list of available Dataproc subcluster resources, make a [list](/docs/data-proc/api-ref/Subcluster/list) request.
 
## HTTP request {#https-request}
```
GET https://dataproc.api.cloud.yandex.net/dataproc/v1/clusters/{clusterId}/subclusters/{subclusterId}
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the Dataproc cluster to get subcluster from.  The maximum string length in characters is 50.
subclusterId | Required. ID of the Dataproc subcluster resource to return. To get the subcluster ID use a [list](/docs/data-proc/api-ref/Subcluster/list) request.  The maximum string length in characters is 50.
 
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
  "hostsCount": "string"
}
```
A Dataproc Subcluster resource. For more information, see
the [Concepts](/docs/data-proc/concepts) section of the documentation.
 
Field | Description
--- | ---
id | **string**<br><p>ID of the Dataproc subcluster. This ID is assigned by Dataproc in the process of creating Dataproc subcluster.</p> 
clusterId | **string**<br><p>ID of the Dataproc cluster. This ID is assigned by Dataproc in the process of creating Dataproc cluster.</p> 
createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
name | **string**<br><p>Name of the Dataproc subcluster. The name is unique within the folder. 1-64 characters long.</p> 
role | **string**<br><p>Role of all hosts in subcluster.</p> <ul> <li>ROLE_UNSPECIFIED: Host have undefined role</li> <li>MASTERNODE: Masternode includes these services (depends on given component list)</li> </ul> <ul> <li>HDFS Namenode, Secondary Namenode,</li> <li>YARN ResorceManager, Timeline Server,</li> <li>Zookeeper,</li> <li>Hive Server, Hive Metastore, HCatalog</li> <li>HBase Master,</li> <li>Spark History Server,</li> <li>Zeppelin</li> </ul> <ul> <li>DATANODE: Datanode includes these services (depends on given component list)</li> </ul> <ul> <li>HDFS Datanode,</li> <li>YARN NodeManager,</li> <li>HBase RegionServer,</li> <li>Spark libraries.</li> </ul> <ul> <li>COMPUTENODE: Computenodes includes these services (depends on given component list)</li> </ul> <ul> <li>YARN NodeManager.</li> <li>Spark libraries.</li> </ul> 
resources | **object**<br><p>Resource configuration for hosts in subcluster.</p> 
resources.<br>resourcePresetId | **string**<br><p>ID of the resource preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/data-proc/concepts/instance-types">documentation</a>.</p> 
resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd — network HDD drive,</li> <li>network-ssd — network SSD drive.</li> </ul> 
resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
subnetId | **string**<br><p>ID of using compute subnet for hosts in subcluster.</p> 
hostsCount | **string** (int64)<br><p>Number of hosts in subcluster.</p> 