---
editable: false
---

# Managed Service for MySQL API, REST: Cluster.listHosts
Retrieves a list of hosts for a cluster.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-mysql/v1/clusters/{clusterId}/hosts
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the cluster to list hosts for.</p> <p>To get this ID, make a <a href="/docs/managed-mysql/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return.</p> <p>If the number of available results is larger than <a href="/docs/managed-mysql/api-ref/Cluster/listHosts#query_params">pageSize</a>, the API returns a <a href="/docs/managed-mysql/api-ref/Cluster/listHosts#responses">nextPageToken</a> that can be used to get the next page of results in the subsequent <a href="/docs/managed-mysql/api-ref/Cluster/listHosts">listHosts</a> requests.</p> <p>Acceptable values are 0 to 1000, inclusive.</p> 
pageToken | <p>Page token that can be used to iterate through multiple pages of results.</p> <p>To get the next page of results, set <a href="/docs/managed-mysql/api-ref/Cluster/listHosts#query_params">pageToken</a> to the <a href="/docs/managed-mysql/api-ref/Cluster/listHosts#responses">nextPageToken</a> returned by the previous <a href="/docs/managed-mysql/api-ref/Cluster/listHosts">listHosts</a> request.</p> <p>The maximum string length in characters is 100.</p> 
 
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
      "assignPublicIp": true,
      "replicationSource": "string",
      "backupPriority": "string",
      "priority": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
hosts[] | **object**<br><p>List of hosts in the cluster.</p> 
hosts[].<br>name | **string**<br><p>Name of the host.</p> <p>This name is assigned by the platform at the time of creation. The name is unique across all MDB hosts that exist on the platform, as it defines the FQDN of the host.</p> 
hosts[].<br>clusterId | **string**<br><p>ID of the cluster the host belongs to.</p> 
hosts[].<br>zoneId | **string**<br><p>ID of the availability zone where the host resides.</p> 
hosts[].<br>resources | **object**<br><p>Resources allocated to the host.</p> <p>Cluster resource preset.</p> 
hosts[].<br>resources.<br>resourcePresetId | **string**<br><p>ID of the resource preset that defines available computational resources (vCPU, RAM, etc.) for a cluster host.</p> <p>All available presets are listed in <a href="/docs/managed-mysql/concepts/instance-types">the documentation</a>.</p> 
hosts[].<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage (for each cluster host, in bytes).</p> 
hosts[].<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage.</p> <p>Possible values:</p> <ul> <li>``network-hdd`` - standard network storage</li> <li>``network-ssd`` - fast network storage</li> <li>``network-ssd-nonreplicated`` - fast network nonreplicated storage</li> <li>``local-ssd`` - fast local storage.</li> </ul> <p>See <a href="/docs/managed-mysql/concepts/storage">the documentation</a> for details.</p> 
hosts[].<br>role | **string**<br><p>Role of the host in the cluster.</p> <ul> <li>ROLE_UNKNOWN: Role of the host is unknown.</li> <li>MASTER: Host is the master.</li> <li>REPLICA: Host is a replica.</li> </ul> 
hosts[].<br>health | **string**<br><p>Aggregated health of the host.</p> <ul> <li>HEALTH_UNKNOWN: Health of the host is unknown.</li> <li>ALIVE: Host is performing all its functions normally.</li> <li>DEAD: Host is inoperable, and cannot perform any of its essential functions.</li> <li>DEGRADED: Host is degraded, and can perform only some of its essential functions.</li> <li>READONLY: Host is alive, but in read-only mode.</li> </ul> 
hosts[].<br>services[] | **object**<br><p>List of services provided by the host.</p> 
hosts[].<br>services[].<br>type | **string**<br><p>Type of the service provided by the host.</p> <ul> <li>MYSQL: The host is a MySQL server.</li> </ul> 
hosts[].<br>services[].<br>health | **string**<br><p>Aggregated health of the service.</p> <ul> <li>HEALTH_UNKNOWN: Health of the service is unknown.</li> <li>ALIVE: The service is working normally.</li> <li>DEAD: The service is dead or unresponsive.</li> <li>READONLY: The service is in read-only mode.</li> </ul> 
hosts[].<br>subnetId | **string**<br><p>ID of the subnet that the host belongs to.</p> 
hosts[].<br>assignPublicIp | **boolean** (boolean)<br><p>Flag that shows if public IP address is assigned to the host so that the host can be accessed from the internet.</p> 
hosts[].<br>replicationSource | **string**<br><p>Name of the host to be used as the replication source for cascading replication.</p> 
hosts[].<br>backupPriority | **string** (int64)<br><p>Host backup priority.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
hosts[].<br>priority | **string** (int64)<br><p>Host master promotion priority.</p> <p>Acceptable values are 0 to 100, inclusive.</p> 
nextPageToken | **string**<br><p>The token that can be used to get the next page of results.</p> <p>If the number of results is larger than <a href="/docs/managed-mysql/api-ref/Cluster/listHosts#query_params">pageSize</a>, use the <a href="/docs/managed-mysql/api-ref/Cluster/listHosts#responses">nextPageToken</a> as the value for the <a href="/docs/managed-mysql/api-ref/Cluster/listHosts#query_params">pageToken</a> in the subsequent <a href="/docs/managed-mysql/api-ref/Cluster/listHosts">listHosts</a> request to iterate through multiple pages of results.</p> <p>Each of the subsequent <a href="/docs/managed-mysql/api-ref/Cluster/listHosts">listHosts</a> requests should use the <a href="/docs/managed-mysql/api-ref/Cluster/listHosts#responses">nextPageToken</a> value returned by the previous request to continue paging through the results.</p> 