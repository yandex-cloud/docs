---
editable: false
sourcePath: en/_api-ref/mdb/opensearch/v1/api-ref/Cluster/listHosts.md
---

# Managed Service for OpenSearch API, REST: Cluster.listHosts
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
pageSize | <p>The maximum number of results per page to return.</p> <p>If the number of available results is larger than <a href="/docs/managed-opensearch/api-ref/Cluster/listHosts#query_params">pageSize</a>, the service returns a <a href="/docs/managed-opensearch/api-ref/Cluster/listHosts#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/managed-opensearch/api-ref/Cluster/listHosts#query_params">pageToken</a> to the <a href="/docs/managed-opensearch/api-ref/Cluster/listHosts#responses">nextPageToken</a> returned by the previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
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
hosts[] | **object**<br><p>Requested list of hosts for the cluster.</p> 
hosts[].<br>name | **string**<br><p>Required. Name of the OpenSearch host.</p> <p>The host name is assigned by the platform at creation time and cannot be changed.</p> <p>The name is unique across all MDB hosts that exist on the platform, as it defines the FQDN of the host.</p> 
hosts[].<br>clusterId | **string**<br><p>Required. ID of the OpenSearch cluster. The ID is assigned by the platform at creation time.</p> 
hosts[].<br>zoneId | **string**<br><p>ID of the availability zone the OpenSearch host belongs to.</p> 
hosts[].<br>resources | **object**<br><p>Resources allocated to the OpenSearch host.</p> <p>A list of computational resources allocated to a host.</p> 
hosts[].<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources allocated to a host.</p> 
hosts[].<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage used by the host, in bytes.</p> 
hosts[].<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage used by the host: ``network-hdd``, ``network-ssd`` or ``local-ssd``.</p> 
hosts[].<br>type | **string**<br><p>Type of the host.</p> <ul> <li>TYPE_UNSPECIFIED: The type is not specified. - OPENSEARCH: An OpenSearch type host.</li> <li>DASHBOARDS: A Dashboards type host.</li> </ul> 
hosts[].<br>health | **string**<br><p>Status code of the aggregated health of the host.</p> <ul> <li>UNKNOWN: Health of the host is unknown.</li> <li>ALIVE: The host is performing all its functions normally.</li> <li>DEAD: The host is inoperable and cannot perform any of its essential functions.</li> <li>DEGRADED: The host is working below capacity or not fully functional.</li> </ul> 
hosts[].<br>subnetId | **string**<br><p>ID of the subnet that the host belongs to.</p> 
hosts[].<br>assignPublicIp | **boolean** (boolean)<br><p>Determines whether a public IP is assigned to the host.</p> 
hosts[].<br>system | **object**<br><p>Resources used by the host.</p> <p>Resources used by the host.</p> 
hosts[].<br>system.<br>cpu | **object**<br><p>CPU usage of the host.</p> <p>CPU usage of the host.</p> 
hosts[].<br>system.<br>cpu.<br>timestamp | **string** (int64)<br><p>Time of the record.</p> 
hosts[].<br>system.<br>cpu.<br>used | **number** (double)<br><p>Percentage of the CPU used.</p> 
hosts[].<br>system.<br>memory | **object**<br><p>RAM usage of the host.</p> <p>RAM usage of the host.</p> 
hosts[].<br>system.<br>memory.<br>timestamp | **string** (int64)<br><p>Time of the record.</p> 
hosts[].<br>system.<br>memory.<br>used | **string** (int64)<br><p>The amount of RAM used, in bytes.</p> 
hosts[].<br>system.<br>memory.<br>total | **string** (int64)<br><p>Total amount of RAM allocated to the host.</p> 
hosts[].<br>system.<br>disk | **object**<br><p>Disk usage of the host.</p> <p>Disk usage of the host.</p> 
hosts[].<br>system.<br>disk.<br>timestamp | **string** (int64)<br><p>Time of the record.</p> 
hosts[].<br>system.<br>disk.<br>used | **string** (int64)<br><p>The amount of disk space used, in bytes.</p> 
hosts[].<br>system.<br>disk.<br>total | **string** (int64)<br><p>Total amount of disk space allocated to the host.</p> 
hosts[].<br>nodeGroup | **string**<br><p>Name of the host group that the host belongs to.</p> 
hosts[].<br>roles[] | **string**<br><p>Roles of the host.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests.</p> <p>If the number of results is larger than <a href="/docs/managed-opensearch/api-ref/Cluster/listHosts#query_params">pageSize</a>, use the <a href="/docs/managed-opensearch/api-ref/Cluster/listHosts#responses">nextPageToken</a> as the value for the <a href="/docs/managed-opensearch/api-ref/Cluster/listHosts#query_params">pageToken</a> query parameter in the next list request.</p> <p>Each subsequent list request has its own <a href="/docs/managed-opensearch/api-ref/Cluster/listHosts#responses">nextPageToken</a> to continue paging through the results.</p> 