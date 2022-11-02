---
editable: false
sourcePath: en/_api-ref/mdb/sqlserver/api-ref/Cluster/listHosts.md
---

# Method listHosts
Retrieves the list of hosts for the specified SQL Server cluster.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/mdb/sqlserver/v1/clusters/{clusterId}/hosts
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the SQL Server cluster.</p> <p>To get the SQL Server cluster ID, use a <a href="/docs/managed-sqlserver/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return.</p> <p>If the number of available results is larger than <a href="/docs/managed-sqlserver/api-ref/Cluster/listHosts#query_params">pageSize</a>, the service returns a <a href="/docs/managed-sqlserver/api-ref/Cluster/listHosts#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/managed-sqlserver/api-ref/Cluster/listHosts#query_params">pageToken</a> to the <a href="/docs/managed-sqlserver/api-ref/Cluster/listHosts#responses">nextPageToken</a> returned by the previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
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
      "role": "string",
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
hosts[] | **object**<br><p>List of SQL Server hosts.</p> 
hosts[].<br>name | **string**<br><p>Name of the SQL Server host.</p> <p>The host name is assigned by Managed Service for SQL Server at the moment of creation and cannot be changed. 1-63 characters long.</p> <p>The name is unique across all database hosts that exist on the platform as it defines the FQDN of the host.</p> 
hosts[].<br>clusterId | **string**<br><p>ID of the SQL Server host.</p> <p>The ID is assigned by Managed Service for SQL Server at the moment of creation.</p> 
hosts[].<br>zoneId | **string**<br><p>ID of the availability zone where the SQL Server host resides.</p> 
hosts[].<br>resources | **object**<br><p>Resources allocated to the host.</p> 
hosts[].<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory, etc.).</p> <p>All available presets are listed in the <a href="/docs/managed-sqlserver/concepts/instance-types">documentation</a>.</p> 
hosts[].<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host.</p> 
hosts[].<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> <p>Possible values:</p> <ul> <li>``network-hdd`` - network HDD drive;</li> <li>``network-ssd`` - network SSD drive;</li> <li>``local-ssd`` - local SSD storage.</li> </ul> 
hosts[].<br>role | **string**<br><p>Role of the host in the cluster.</p> <ul> <li>ROLE_UNKNOWN: Role of the host in the cluster is unknown.</li> <li>MASTER: Host is the master SQL Server instance in the cluster.</li> <li>REPLICA: Host is a replica SQL Server instance in the cluster.</li> </ul> 
hosts[].<br>health | **string**<br><p>Status code of the aggregated health of the host.</p> <ul> <li>HEALTH_UNKNOWN: Health of the host is unknown.</li> <li>ALIVE: The host is performing all its functions normally.</li> <li>DEAD: The host is inoperable and cannot perform any of its essential functions.</li> <li>DEGRADED: The host is degraded and can perform only some of its essential functions.</li> </ul> 
hosts[].<br>services[] | **object**<br><p>Services provided by the host.</p> 
hosts[].<br>services[].<br>type | **string**<br><p>Type of the service provided by the host.</p> <ul> <li>SQLSERVER: SQL Server service.</li> </ul> 
hosts[].<br>services[].<br>health | **string**<br><p>Status code of server availability.</p> <ul> <li>HEALTH_UNKNOWN: Health of the server is unknown.</li> <li>ALIVE: The server is working normally.</li> <li>DEAD: The server is dead or unresponsive.</li> </ul> 
hosts[].<br>subnetId | **string**<br><p>ID of the subnet that the host belongs to.</p> 
hosts[].<br>assignPublicIp | **boolean** (boolean)<br><p>Flag showing public IP assignment status to this host.</p> 
nextPageToken | **string**<br><p>Token that allows you to get the next page of results for list requests.</p> <p>If the number of results is larger than <a href="/docs/managed-sqlserver/api-ref/Cluster/listHosts#query_params">pageSize</a>, use the <a href="/docs/managed-sqlserver/api-ref/Cluster/listHosts#responses">nextPageToken</a> as the value for the <a href="/docs/managed-sqlserver/api-ref/Cluster/listHosts#query_params">pageToken</a> query parameter in the next list request.</p> <p>Each subsequent list request has its own <a href="/docs/managed-sqlserver/api-ref/Cluster/listHosts#responses">nextPageToken</a> to continue paging through the results.</p> 