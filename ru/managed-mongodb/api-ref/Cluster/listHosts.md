---
editable: false
sourcePath: en/_api-ref/mdb/mongodb/api-ref/Cluster/listHosts.md
---

# Managed Service for MongoDB API, REST: Cluster.listHosts
Retrieves a list of hosts for the specified cluster.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/{clusterId}/hosts
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the MongoDB cluster. To get the MongoDB cluster ID, use a <a href="/docs/managed-mongodb/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/managed-mongodb/api-ref/Cluster/listHosts#query_params">pageSize</a>, the service returns a <a href="/docs/managed-mongodb/api-ref/Cluster/listHosts#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive. Default value: 100.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token. To get the next page of results, set <a href="/docs/managed-mongodb/api-ref/Cluster/listHosts#query_params">pageToken</a> to the <a href="/docs/managed-mongodb/api-ref/Cluster/listHosts#responses">nextPageToken</a> returned by the previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
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
      "shardName": "string",
      "type": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
hosts[] | **object**<br><p>List of Host resources.</p> 
hosts[].<br>name | **string**<br><p>Name of the MongoDB host. The host name is assigned by MDB at creation time, and cannot be changed. 1-63 characters long.</p> <p>The name is unique across all MDB hosts that exist on the platform, as it defines the FQDN of the host.</p> 
hosts[].<br>clusterId | **string**<br><p>ID of the MongoDB host. The ID is assigned by MDB at creation time.</p> 
hosts[].<br>zoneId | **string**<br><p>ID of the availability zone where the MongoDB host resides.</p> 
hosts[].<br>resources | **object**<br><p>Resources allocated to the MongoDB host.</p> 
hosts[].<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-mongodb/concepts/instance-types">documentation</a>.</p> 
hosts[].<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
hosts[].<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
hosts[].<br>role | **string**<br><p>Role of the host in the cluster.</p> <ul> <li>ROLE_UNKNOWN: Role of the host in the cluster is unknown.</li> <li>PRIMARY: Host is the primary MongoDB server in the cluster.</li> <li>SECONDARY: Host is a secondary MongoDB server in the cluster.</li> </ul> 
hosts[].<br>health | **string**<br><p>Status code of the aggregated health of the host.</p> <ul> <li>HEALTH_UNKNOWN: Health of the host is unknown.</li> <li>ALIVE: The host is performing all its functions normally.</li> <li>DEAD: The host is inoperable, and cannot perform any of its essential functions.</li> <li>DEGRADED: The host is degraded, and can perform only some of its essential functions.</li> </ul> 
hosts[].<br>services[] | **object**<br><p>Services provided by the host.</p> 
hosts[].<br>services[].<br>type | **string**<br><p>Type of the service provided by the host.</p> <ul> <li>MONGOD: The host is running a mongod daemon.</li> <li>MONGOS: The host is running a mongos daemon.</li> <li>MONGOCFG: The host is running a MongoDB config server.</li> </ul> 
hosts[].<br>services[].<br>health | **string**<br><p>Status code of server availability.</p> <ul> <li>HEALTH_UNKNOWN: Health of the server is unknown.</li> <li>ALIVE: The server is working normally.</li> <li>DEAD: The server is dead or unresponsive.</li> </ul> 
hosts[].<br>subnetId | **string**<br><p>ID of the subnet that the host belongs to.</p> 
hosts[].<br>assignPublicIp | **boolean** (boolean)<br><p>Flag showing public IP assignment status to this host.</p> 
hosts[].<br>shardName | **string**<br><p>Shard which this host belongs to.</p> 
hosts[].<br>type | **string**<br><p>Host type</p> <ul> <li>MONGOD: A mongod host.</li> <li>MONGOS: A mongos host.</li> <li>MONGOCFG: A mongocfg host.</li> <li>MONGOINFRA: A mongoinfra (mongos+mongocfg) host.</li> </ul> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-mongodb/api-ref/Cluster/listHosts#query_params">pageSize</a>, use the <a href="/docs/managed-mongodb/api-ref/Cluster/listHosts#responses">nextPageToken</a> as the value for the <a href="/docs/managed-mongodb/api-ref/Cluster/listHosts#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-mongodb/api-ref/Cluster/listHosts#responses">nextPageToken</a> to continue paging through the results.</p> 