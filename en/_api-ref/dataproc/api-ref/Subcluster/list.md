---
editable: false
---

# Method list
Retrieves a list of Dataproc subcluster.
 

 
## HTTP request {#https-request}
```
GET https://dataproc.api.cloud.yandex.net/dataproc/v1/clusters/{clusterId}/subclusters
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the Dataproc cluster to get subclusters from.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a `next_page_token` that can be used to get the next page of results in subsequent ListSubclusters requests. Acceptable values are 0 to 1000, inclusive. Default value: 100.  The maximum value is 1000.
pageToken | Page token. Set `page_token` to the `next_page_token` returned by a previous ListSubclusters request to get the next page of results.  The maximum string length in characters is 100.
filter | A filter expression that filters resources listed in the response. The expression must specify: 1. The field name. Currently you can only use filtering with the [Cluster.name](/docs/data-proc/api-ref/Cluster#representation) field. 2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. 3. The value. Мust be 1-63 characters long and match the regular expression `^[a-zA-Z0-9_-]+$`.  The maximum string length in characters is 1000.
 
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
      "status": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
subclusters[] | **object**<br><p>A Dataproc Subcluster resource. For more information, see the <a href="/docs/data-proc/concepts">Concepts</a> section of the documentation.</p> 
subclusters[].<br>id | **string**<br><p>ID of the Dataproc subcluster. This ID is assigned by Dataproc in the process of creating Dataproc subcluster.</p> 
subclusters[].<br>clusterId | **string**<br><p>ID of the Dataproc cluster. This ID is assigned by Dataproc in the process of creating Dataproc cluster.</p> 
subclusters[].<br>createdAt | **string** (date-time)<br><p>Creation timestamp in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> <p>String in <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> text format.</p> 
subclusters[].<br>name | **string**<br><p>Name of the Dataproc subcluster. The name is unique within the folder. 1-64 characters long.</p> 
subclusters[].<br>role | **string**<br><p>Role of all hosts in subcluster.</p> <ul> <li>ROLE_UNSPECIFIED: Host have undefined role</li> <li>MASTERNODE: Masternode includes these services (depends on given component list)</li> </ul> <ul> <li>HDFS Namenode, Secondary Namenode,</li> <li>YARN ResorceManager, Timeline Server,</li> <li>Zookeeper,</li> <li>Hive Server, Hive Metastore, HCatalog</li> <li>HBase Master,</li> <li>Spark History Server,</li> <li>Zeppelin</li> </ul> <ul> <li>DATANODE: Datanode includes these services (depends on given component list)</li> </ul> <ul> <li>HDFS Datanode,</li> <li>YARN NodeManager,</li> <li>HBase RegionServer,</li> <li>Spark libraries.</li> </ul> <ul> <li>COMPUTENODE: Computenodes includes these services (depends on given component list)</li> </ul> <ul> <li>YARN NodeManager.</li> <li>Spark libraries.</li> </ul> 
subclusters[].<br>resources | **object**<br><p>Resource configuration for hosts in subcluster.</p> 
subclusters[].<br>resources.<br>resourcePresetId | **string**<br><p>ID of the resource preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/data-proc/concepts/instance-types">documentation</a>.</p> 
subclusters[].<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd — network HDD drive,</li> <li>network-nvme — network SSD drive.</li> </ul> 
subclusters[].<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
subclusters[].<br>subnetId | **string**<br><p>ID of using compute subnet for hosts in subcluster.</p> 
subclusters[].<br>hostsCount | **string** (int64)<br><p>Number of hosts in subcluster.</p> 
subclusters[].<br>status | **string**<br><p>Subcluster status</p> <ul> <li>STATUS_UNKNOWN: Subcluster state is unknown.</li> <li>CREATING: Subcluster is being created.</li> <li>RUNNING: Subcluster is running.</li> <li>ERROR: Subcluster failed.</li> <li>STOPPING: Subcluster stopping</li> <li>STOPPED: Subcluster stopped</li> <li>STARTING: Subcluster starting</li> </ul> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for ListSubclusters requests, if the number of results is larger than <code>page_size</code> specified in the request. To get the next page, specify the value of <code>next_page_token</code> as a value for the <code>page_token</code> parameter in the next ListClusters request. Subsequent ListClusters requests will have their own <code>next_page_token</code> to continue paging through the results.</p> 