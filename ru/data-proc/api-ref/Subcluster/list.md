---
editable: false
sourcePath: en/_api-ref/dataproc/v1/api-ref/Subcluster/list.md
---

# Data Proc API, REST: Subcluster.list
Retrieves a list of subclusters in the specified cluster.
 

 
## HTTP request {#https-request}
```
GET https://dataproc.{{ api-host }}/dataproc/v1/clusters/{clusterId}/subclusters
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the Data Proc cluster to list subclusters in.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/data-proc/api-ref/Subcluster/list#query_params">pageSize</a>, the service returns a <a href="/docs/data-proc/api-ref/Subcluster/list#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set ``page_token`` to the <a href="/docs/data-proc/api-ref/Subcluster/list#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters subclusters listed in the response.</p> <p>The expression must specify:</p> <ol> <li>The field name. Currently you can use filtering only on <a href="/docs/data-proc/api-ref/Subcluster#representation">Subcluster.name</a> field.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``). Must be 3-63 characters long and match the regular expression ``[a-z][-a-z0-9]{1,61}[a-z0-9]``. Example of a filter: ``name=dataproc123_subcluster456``.</li> </ol> <p>The maximum string length in characters is 1000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "subclusters": [
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
      "assignPublicIp": true,
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
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
subclusters[] | **object**<br><p>List of subclusters in the specified cluster.</p> 
subclusters[].<br>id | **string**<br><p>ID of the subcluster. Generated at creation time.</p> 
subclusters[].<br>clusterId | **string**<br><p>ID of the Data Proc cluster that the subcluster belongs to.</p> 
subclusters[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format. The range of possible values is from ``0001-01-01T00:00:00Z`` to ``9999-12-31T23:59:59.999999999Z``, i.e. from 0 to 9 digits for fractions of a second.</p> <p>To work with values in this field, use the APIs described in the <a href="https://developers.google.com/protocol-buffers/docs/reference/overview">Protocol Buffers reference</a>. In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).</p> 
subclusters[].<br>name | **string**<br><p>Name of the subcluster. The name is unique within the cluster.</p> <p>The string length in characters must be 1-63.</p> 
subclusters[].<br>role | **string**<br><p>Role that is fulfilled by hosts of the subcluster.</p> <ul> <li> <p>MASTERNODE: The subcluster fulfills the master role.</p> <p>Master can run the following services, depending on the requested components:</p> <ul> <li>HDFS: Namenode, Secondary Namenode</li> <li>YARN: ResourceManager, Timeline Server</li> <li>HBase Master</li> <li>Hive: Server, Metastore, HCatalog</li> <li>Spark History Server</li> <li>Zeppelin</li> <li>ZooKeeper</li> </ul> </li> <li> <p>DATANODE: The subcluster is a DATANODE in a Data Proc cluster.</p> <p>DATANODE can run the following services, depending on the requested components:</p> <ul> <li>HDFS DataNode</li> <li>YARN NodeManager</li> <li>HBase RegionServer</li> <li>Spark libraries</li> </ul> </li> <li> <p>COMPUTENODE: The subcluster is a COMPUTENODE in a Data Proc cluster.</p> <p>COMPUTENODE can run the following services, depending on the requested components:</p> <ul> <li>YARN NodeManager</li> <li>Spark libraries</li> </ul> </li> </ul> 
subclusters[].<br>resources | **object**<br><p>Resources allocated for each host in the subcluster.</p> 
subclusters[].<br>resources.<br>resourcePresetId | **string**<br><p>ID of the resource preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/data-proc/concepts/instance-types">documentation</a>.</p> 
subclusters[].<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive.</li> </ul> 
subclusters[].<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
subclusters[].<br>subnetId | **string**<br><p>ID of the VPC subnet used for hosts in the subcluster.</p> 
subclusters[].<br>hostsCount | **string** (int64)<br><p>Number of hosts in the subcluster.</p> 
subclusters[].<br>assignPublicIp | **boolean** (boolean)<br><p>Assign public ip addresses for all hosts in subcluter.</p> 
subclusters[].<br>autoscalingConfig | **object**<br><p>Configuration for instance group based subclusters</p> 
subclusters[].<br>autoscalingConfig.<br>maxHostsCount | **string** (int64)<br><p>Upper limit for total instance subcluster count.</p> <p>Acceptable values are 1 to 100, inclusive.</p> 
subclusters[].<br>autoscalingConfig.<br>preemptible | **boolean** (boolean)<br><p>Preemptible instances are stopped at least once every 24 hours, and can be stopped at any time if their resources are needed by Compute. For more information, see <a href="/docs/compute/concepts/preemptible-vm">Preemptible Virtual Machines</a>.</p> 
subclusters[].<br>autoscalingConfig.<br>measurementDuration | **string**<br><p>Required. Time in seconds allotted for averaging metrics.</p> <p>Acceptable values are 60 seconds to 600 seconds, inclusive.</p> 
subclusters[].<br>autoscalingConfig.<br>warmupDuration | **string**<br><p>The warmup time of the instance in seconds. During this time, traffic is sent to the instance, but instance metrics are not collected.</p> <p>The maximum value is 600 seconds.</p> 
subclusters[].<br>autoscalingConfig.<br>stabilizationDuration | **string**<br><p>Minimum amount of time in seconds allotted for monitoring before Instance Groups can reduce the number of instances in the group. During this time, the group size doesn't decrease, even if the new metric values indicate that it should.</p> <p>Acceptable values are 60 seconds to 1800 seconds, inclusive.</p> 
subclusters[].<br>autoscalingConfig.<br>cpuUtilizationTarget | **number** (double)<br><p>Defines an autoscaling rule based on the average CPU utilization of the instance group.</p> <p>Acceptable values are 10 to 100, inclusive.</p> 
subclusters[].<br>autoscalingConfig.<br>decommissionTimeout | **string** (int64)<br><p>Timeout to gracefully decommission nodes during downscaling. In seconds. Default value: 120</p> <p>Acceptable values are 0 to 86400, inclusive.</p> 
subclusters[].<br>instanceGroupId | **string**<br><p>ID of Compute Instance Group for autoscaling subclusters</p> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/data-proc/api-ref/Subcluster/list#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/data-proc/api-ref/Subcluster/list#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 