---
editable: false
sourcePath: en/_api-ref/mdb/kafka/api-ref/Cluster/listHosts.md
---

# Method listHosts
Retrieves a list of hosts for the specified Apache Kafka® cluster.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-kafka/v1/clusters/{clusterId}/hosts
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the Apache Kafka® cluster.</p> <p>To get the Apache Kafka® cluster ID, make a <a href="/docs/managed-kafka/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return.</p> <p>If the number of available results is larger than <a href="/docs/managed-kafka/api-ref/Cluster/listHosts#query_params">pageSize</a>, the service returns a <a href="/docs/managed-kafka/api-ref/Cluster/listHosts#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token.</p> <p>To get the next page of results, set <a href="/docs/managed-kafka/api-ref/Cluster/listHosts#query_params">pageToken</a> to the <a href="/docs/managed-kafka/api-ref/Cluster/listHosts#responses">nextPageToken</a> returned by the previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "hosts": [
    {
      "name": "string",
      "clusterId": "string",
      "zoneId": "string",
      "role": "string",
      "resources": {
        "resourcePresetId": "string",
        "diskSize": "string",
        "diskTypeId": "string"
      },
      "health": "string",
      "subnetId": "string",
      "assignPublicIp": true
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
hosts[] | **object**<br><p>List of hosts.</p> 
hosts[].<br>name | **string**<br><p>Name of the host.</p> 
hosts[].<br>clusterId | **string**<br><p>ID of the Apache Kafka® cluster.</p> 
hosts[].<br>zoneId | **string**<br><p>ID of the availability zone where the host resides.</p> 
hosts[].<br>role | **string**<br><p>Host role.</p> <ul> <li>KAFKA: the host is a Kafka broker.</li> <li>ZOOKEEPER: the host is a ZooKeeper server.</li> </ul> 
hosts[].<br>resources | **object**<br><p>Computational resources allocated to the host.</p> 
hosts[].<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory, etc.). All available presets are listed in the <a href="/docs/managed-kafka/concepts/instance-types">documentation</a>.</p> 
hosts[].<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes. Must be greater than 2 * partition segment size in bytes * partitions count, so each partition can have one active segment file and one closed segment file that can be deleted.</p> 
hosts[].<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> 
hosts[].<br>health | **string**<br><p>Aggregated host health data.</p> <ul> <li>UNKNOWN: health of the host is unknown.</li> <li>ALIVE: the host is performing all its functions normally.</li> <li>DEAD: the host is inoperable and cannot perform any of its essential functions.</li> <li>DEGRADED: the host is degraded and can perform only some of its essential functions.</li> </ul> 
hosts[].<br>subnetId | **string**<br><p>ID of the subnet the host resides in.</p> 
hosts[].<br>assignPublicIp | **boolean** (boolean)<br><p>The flag that defines whether a public IP address is assigned to the node.</p> <p>If the value is ``true``, then this node is available on the Internet via it's public IP address.</p> 
nextPageToken | **string**<br><p>Token that allows you to get the next page of results for list requests.</p> <p>If the number of results is larger than <a href="/docs/managed-kafka/api-ref/Cluster/listHosts#query_params">pageSize</a>, use the <a href="/docs/managed-kafka/api-ref/Cluster/listHosts#responses">nextPageToken</a> as the value for the <a href="/docs/managed-kafka/api-ref/Cluster/listHosts#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-kafka/api-ref/Cluster/listHosts#responses">nextPageToken</a> to continue paging through the results.</p> 