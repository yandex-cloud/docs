---
editable: false
---

# Data Proc API, REST: Cluster.listHosts
Retrieves the list of hosts in the specified cluster.
 

 
## HTTP request {#https-request}
```
GET https://dataproc.{{ api-host }}/dataproc/v1/clusters/{clusterId}/hosts
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>ID of the cluster to list hosts for.</p> <p>To get a cluster ID, make a <a href="/docs/data-proc/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/data-proc/api-ref/Cluster/listHosts#query_params">pageSize</a>, the service returns a <a href="/docs/data-proc/api-ref/Cluster/listHosts#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Default value: 100.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/data-proc/api-ref/Cluster/listHosts#query_params">pageToken</a> to the <a href="/docs/data-proc/api-ref/Cluster/listHosts#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
filter | <p>A filter expression that filters hosts listed in the response.</p> <p>The expression must specify:</p> <ol> <li>The field name. Currently you can use filtering only on <a href="/docs/data-proc/api-ref/Cluster#representation">Cluster.name</a> field.</li> <li>An ``=`` operator.</li> <li>The value in double quotes (``"``). Must be 3-63 characters long and match the regular expression ``[a-z][-a-z0-9]{1,61}[a-z0-9]``. Example of a filter: ``name=my-host``</li> </ol> <p>The maximum string length in characters is 1000.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "hosts": [
    {
      "name": "string",
      "subclusterId": "string",
      "health": "string",
      "computeInstanceId": "string",
      "role": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
hosts[] | **object**<br><p>Requested list of hosts.</p> 
hosts[].<br>name | **string**<br><p>Name of the Data Proc host. The host name is assigned by Data Proc at creation time and cannot be changed. The name is generated to be unique across all Data Proc hosts that exist on the platform, as it defines the FQDN of the host.</p> 
hosts[].<br>subclusterId | **string**<br><p>ID of the Data Proc subcluster that the host belongs to.</p> 
hosts[].<br>health | **string**<br><p>Status code of the aggregated health of the host.</p> <ul> <li>HEALTH_UNKNOWN: Object is in unknown state (we have no data).</li> <li>ALIVE: Object is alive and well (for example, all hosts of the cluster are alive).</li> <li>DEAD: Object is inoperable (it cannot perform any of its essential functions).</li> <li>DEGRADED: Object is partially alive (it can perform some of its essential functions).</li> </ul> 
hosts[].<br>computeInstanceId | **string**<br><p>ID of the Compute virtual machine that is used as the Data Proc host.</p> 
hosts[].<br>role | **string**<br><p>Role of the host in the cluster.</p> <ul> <li> <p>MASTERNODE: The subcluster fulfills the master role.</p> <p>Master can run the following services, depending on the requested components:</p> <ul> <li>HDFS: Namenode, Secondary Namenode</li> <li>YARN: ResourceManager, Timeline Server</li> <li>HBase Master</li> <li>Hive: Server, Metastore, HCatalog</li> <li>Spark History Server</li> <li>Zeppelin</li> <li>ZooKeeper</li> </ul> </li> <li> <p>DATANODE: The subcluster is a DATANODE in a Data Proc cluster.</p> <p>DATANODE can run the following services, depending on the requested components:</p> <ul> <li>HDFS DataNode</li> <li>YARN NodeManager</li> <li>HBase RegionServer</li> <li>Spark libraries</li> </ul> </li> <li> <p>COMPUTENODE: The subcluster is a COMPUTENODE in a Data Proc cluster.</p> <p>COMPUTENODE can run the following services, depending on the requested components:</p> <ul> <li>YARN NodeManager</li> <li>Spark libraries</li> </ul> </li> </ul> 
nextPageToken | **string**<br><p>Token for getting the next page of the list. If the number of results is greater than the specified <a href="/docs/data-proc/api-ref/Cluster/listHosts#query_params">pageSize</a>, use ``next_page_token`` as the value for the <a href="/docs/data-proc/api-ref/Cluster/listHosts#query_params">pageToken</a> parameter in the next list request.</p> <p>Each subsequent page will have its own ``next_page_token`` to continue paging through the results.</p> 