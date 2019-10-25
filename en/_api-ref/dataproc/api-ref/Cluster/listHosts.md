---
editable: false
---

# Method listHosts
Retrieves a list of hosts.
 

 
## HTTP request {#https-request}
```
GET https://dataproc.api.cloud.yandex.net/dataproc/v1/clusters/{clusterId}/hosts
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | ID of the Dataproc cluster. This ID is assigned by Dataproc at creation time.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a `next_page_token` that can be used to get the next page of results in subsequent ListClusterHosts requests. Acceptable values are 0 to 1000, inclusive. Default value: 100.  The maximum value is 1000.
pageToken | Page token. Set `page_token` to the `next_page_token` returned by a previous ListClusterHosts request to get the next page of results.  The maximum string length in characters is 100.
filter | String that describes a display filter.  The maximum string length in characters is 1000.
 
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
hosts[] | **object**<br><p>A Dataproc Host resource. For more information, see the <a href="/docs/data-proc/concepts">Concepts</a> section of the documentation.</p> 
hosts[].<br>name | **string**<br><p>Name of the Dataproc host. The host name is assigned by Dataproc at creation time, and cannot be changed. 1-63 characters long.</p> <p>The name is unique across all existing Dataproc hosts in Yandex.Cloud, as it defines the FQDN of the host.</p> 
hosts[].<br>subclusterId | **string**<br><p>ID of Dataproc subcluster host. The ID is assigned by Dataproc at creation time.</p> 
hosts[].<br>health | **string**<br><p>Status code of the aggregated health of the host.</p> <ul> <li>HEALTH_UNKNOWN: State of the cluster is unknown ([Host.health] for every host in the cluster is UNKNOWN).</li> <li>ALIVE: Cluster is alive and well ([Host.health] for every host in the cluster is ALIVE).</li> <li>DEAD: Cluster is inoperable ([Host.health] for every host in the cluster is DEAD).</li> <li>DEGRADED: Cluster is working below capacity ([Host.health] for at least one host in the cluster is not ALIVE).</li> </ul> 
hosts[].<br>computeInstanceId | **string**<br><p>ID of compute instance appropriated to the Dataproc host.</p> 
hosts[].<br>role | **string**<br><p>Role of current host in cluster.</p> <ul> <li>ROLE_UNSPECIFIED: Host have undefined role</li> <li>MASTERNODE: Masternode includes these services (depends on given component list)</li> </ul> <ul> <li>HDFS Namenode, Secondary Namenode,</li> <li>YARN ResorceManager, Timeline Server,</li> <li>Zookeeper,</li> <li>Hive Server, Hive Metastore, HCatalog</li> <li>HBase Master,</li> <li>Spark History Server,</li> <li>Zeppelin</li> </ul> <ul> <li>DATANODE: Datanode includes these services (depends on given component list)</li> </ul> <ul> <li>HDFS Datanode,</li> <li>YARN NodeManager,</li> <li>HBase RegionServer,</li> <li>Spark libraries.</li> </ul> <ul> <li>COMPUTENODE: Computenodes includes these services (depends on given component list)</li> </ul> <ul> <li>YARN NodeManager.</li> <li>Spark libraries.</li> </ul> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for ListClusterHosts requests, if the number of results is larger than <code>page_size</code> specified in the request. To get the next page, specify the value of <code>next_page_token</code> as a value for the <code>page_token</code> parameter in the next ListSubclusterHosts request. Subsequent ListClusterHosts requests will have their own <code>next_page_token</code> to continue paging through the results.</p> 