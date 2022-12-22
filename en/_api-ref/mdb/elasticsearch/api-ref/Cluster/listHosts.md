---
editable: false
---

# Managed Service for Elasticsearch API, REST: Cluster.listHosts
Retrieves a list of hosts for the specified Elasticsearch cluster.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-elasticsearch/v1/clusters/{clusterId}/hosts
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the Elasticsearch cluster.</p> <p>To get the Elasticsearch cluster ID, make a <a href="/docs/managed-elasticsearch/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return.</p> <p>If the number of available results is larger than ``page_size``, the service returns a <a href="/docs/managed-elasticsearch/api-ref/Cluster/listHosts#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token.</p> <p>To get the next page of results, set ``page_token`` to the <a href="/docs/managed-elasticsearch/api-ref/Cluster/listHosts#responses">nextPageToken</a> returned by the previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "hosts": [
    {
      "name": "string",
      "clusterId": "string",
      "zoneId": "string",
      "type": "string",
      "resources": {
        "resourcePresetId": "string",
        "diskSize": "string",
        "diskTypeId": "string"
      },
      "health": "string",
      "services": [
        {
          "type": "string",
          "health": "string"
        }
      ],
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
hosts[].<br>clusterId | **string**<br><p>ID of the Elasticsearch cluster.</p> 
hosts[].<br>zoneId | **string**<br><p>ID of the availability zone where the host resides.</p> 
hosts[].<br>type | **string**<br><p>Host type.</p> <ul> <li>DATA_NODE: the host is an Elasticsearch data node.</li> <li>MASTER_NODE: the host is an Elasticsearch master node.</li> </ul> 
hosts[].<br>resources | **object**<br><p>Computational resources.</p> 
hosts[].<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-elasticsearch/concepts/instance-types">documentation</a>.</p> 
hosts[].<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
hosts[].<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. All available types are listed in the <a href="/docs/managed-elasticsearch/concepts/storage">documentation</a>.</p> 
hosts[].<br>health | **string**<br><p>Aggregated host health data.</p> <ul> <li>UNKNOWN: health of the host is unknown.</li> <li>ALIVE: the host is performing all its functions normally.</li> <li>DEAD: the host is inoperable and cannot perform any of its essential functions.</li> <li>DEGRADED: the host is degraded and can perform only some of its essential functions.</li> </ul> 
hosts[].<br>services[] | **object**<br><p>Services provided by the host.</p> 
hosts[].<br>services[].<br>type | **string**<br><p>Type of the service provided by the host.</p> <ul> <li>ELASTICSEARCH: the Elasticsearch service.</li> </ul> 
hosts[].<br>services[].<br>health | **string**<br><p>Service health data.</p> <ul> <li>UNKNOWN: health of the service is unknown.</li> <li>ALIVE: the service is working normally.</li> <li>DEAD: the service is dead or unresponsive.</li> </ul> 
hosts[].<br>subnetId | **string**<br><p>ID of the subnet the host resides in.</p> 
hosts[].<br>assignPublicIp | **boolean** (boolean)<br><p>The flag that defines whether a public IP address is assigned to the host.</p> <p>If the value is ``true``, then this host is available on the Internet via it's public IP address.</p> 
nextPageToken | **string**<br><p>Token that allows you to get the next page of results for list requests.</p> <p>If the number of results is larger than <a href="/docs/managed-elasticsearch/api-ref/Cluster/listHosts#query_params">pageSize</a>, use the ``next_page_token`` as the value for the <a href="/docs/managed-elasticsearch/api-ref/Cluster/listHosts#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own ``next_page_token`` to continue paging through the results.</p> 