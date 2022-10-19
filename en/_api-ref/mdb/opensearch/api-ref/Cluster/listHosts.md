---
editable: false
---

# Method listHosts
Retrieves a list of hosts for the specified cluster.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/{clusterId}/hosts
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the OpenSearch cluster. To get the OpenSearch cluster ID use a <a href="/docs/managed-opensearch/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/managed-opensearch/api-ref/Cluster/listHosts#query_params">pageSize</a>, the service returns a <a href="/docs/managed-opensearch/api-ref/Cluster/listHosts#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/managed-opensearch/api-ref/Cluster/listHosts#query_params">pageToken</a> to the <a href="/docs/managed-opensearch/api-ref/Cluster/listHosts#responses">nextPageToken</a> returned by a previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
## Response {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "hosts": [
    {
      "name": "string",
      "clusterId": "string",
      "zoneId": "string",
      "resources": {
        "resourcePresetId": "string",
        "diskSize": "string",
        "diskTypeId": "string"
      },
      "type": "string",
      "health": "string",
      "subnetId": "string",
      "assignPublicIp": true,
      "system": {
        "cpu": {
          "timestamp": "string",
          "used": "number"
        },
        "memory": {
          "timestamp": "string",
          "used": "string",
          "total": "string"
        },
        "disk": {
          "timestamp": "string",
          "used": "string",
          "total": "string"
        }
      },
      "nodeGroup": "string",
      "roles": [
        "string"
      ]
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
hosts[] | **object**<br><p>List of Host resources.</p> 
hosts[].<br>name | **string**<br><p>Required. Name of the host.</p> 
hosts[].<br>clusterId | **string**<br><p>Required. ID of the OpenSearch cluster.</p> 
hosts[].<br>zoneId | **string**<br><p>ID of the availability zone.</p> 
hosts[].<br>resources | **object**<br><p>Resources allocated to the host.</p> 
hosts[].<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.).</p> 
hosts[].<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
hosts[].<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> 
hosts[].<br>type | **string**<br><p>Host type.</p> 
hosts[].<br>health | **string**<br><p>Aggregated host health</p> 
hosts[].<br>subnetId | **string**
hosts[].<br>assignPublicIp | **boolean** (boolean)
hosts[].<br>system | **object**<br><p>System metrics</p> 
hosts[].<br>system.<br>cpu | **object**
hosts[].<br>system.<br>cpu.<br>timestamp | **string** (int64)
hosts[].<br>system.<br>cpu.<br>used | **number** (double)
hosts[].<br>system.<br>memory | **object**
hosts[].<br>system.<br>memory.<br>timestamp | **string** (int64)
hosts[].<br>system.<br>memory.<br>used | **string** (int64)
hosts[].<br>system.<br>memory.<br>total | **string** (int64)
hosts[].<br>system.<br>disk | **object**
hosts[].<br>system.<br>disk.<br>timestamp | **string** (int64)
hosts[].<br>system.<br>disk.<br>used | **string** (int64)
hosts[].<br>system.<br>disk.<br>total | **string** (int64)
hosts[].<br>nodeGroup | **string**<br><p>Which node group the host belongs to</p> 
hosts[].<br>roles[] | **string**
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-opensearch/api-ref/Cluster/listHosts#query_params">pageSize</a>, use the <a href="/docs/managed-opensearch/api-ref/Cluster/listHosts#responses">nextPageToken</a> as the value for the <a href="/docs/managed-opensearch/api-ref/Cluster/listHosts#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-opensearch/api-ref/Cluster/listHosts#responses">nextPageToken</a> to continue paging through the results.</p> 