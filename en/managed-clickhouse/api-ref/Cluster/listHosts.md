---
editable: false
sourcePath: en/_api-ref/mdb/clickhouse/v1/api-ref/Cluster/listHosts.md
---

# Managed Service for ClickHouse API, REST: Cluster.listHosts
Retrieves a list of hosts for the specified cluster.
 

 
## HTTP request {#https-request}
```
GET https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{clusterId}/hosts
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | <p>Required. ID of the ClickHouse cluster. To get the ClickHouse cluster ID use a <a href="/docs/managed-clickhouse/api-ref/Cluster/list">list</a> request.</p> <p>The maximum string length in characters is 50.</p> 
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | <p>The maximum number of results per page to return. If the number of available results is larger than <a href="/docs/managed-clickhouse/api-ref/Cluster/listHosts#query_params">pageSize</a>, the service returns a <a href="/docs/managed-clickhouse/api-ref/Cluster/listHosts#responses">nextPageToken</a> that can be used to get the next page of results in subsequent list requests.</p> <p>The maximum value is 1000.</p> 
pageToken | <p>Page token.  To get the next page of results, set <a href="/docs/managed-clickhouse/api-ref/Cluster/listHosts#query_params">pageToken</a> to the <a href="/docs/managed-clickhouse/api-ref/Cluster/listHosts#responses">nextPageToken</a> returned by the previous list request.</p> <p>The maximum string length in characters is 100.</p> 
 
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
      "assignPublicIp": true,
      "shardName": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
hosts[] | **object**<br><p>Requested list of hosts for the cluster.</p> 
hosts[].<br>name | **string**<br><p>Name of the ClickHouse host. The host name is assigned by MDB at creation time, and cannot be changed. 1-63 characters long.</p> <p>The name is unique across all MDB hosts that exist on the platform, as it defines the FQDN of the host.</p> 
hosts[].<br>clusterId | **string**<br><p>ID of the ClickHouse host. The ID is assigned by MDB at creation time.</p> 
hosts[].<br>zoneId | **string**<br><p>ID of the availability zone where the ClickHouse host resides.</p> 
hosts[].<br>type | **string**<br><p>Type of the host.</p> <ul> <li>CLICKHOUSE: ClickHouse host.</li> <li>ZOOKEEPER: ZooKeeper host.</li> </ul> 
hosts[].<br>resources | **object**<br><p>Resources allocated to the ClickHouse host.</p> 
hosts[].<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/managed-clickhouse/concepts/instance-types">documentation</a></p> 
hosts[].<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
hosts[].<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-hdd - network HDD drive,</li> <li>network-ssd - network SSD drive,</li> <li>local-ssd - local SSD storage.</li> </ul> 
hosts[].<br>health | **string**<br><p>Status code of the aggregated health of the host.</p> <ul> <li>UNKNOWN: Health of the host is unknown.</li> <li>ALIVE: The host is performing all its functions normally.</li> <li>DEAD: The host is inoperable, and cannot perform any of its essential functions.</li> <li>DEGRADED: The host is degraded, and can perform only some of its essential functions.</li> </ul> 
hosts[].<br>services[] | **object**<br><p>Services provided by the host.</p> 
hosts[].<br>services[].<br>type | **string**<br><p>Type of the service provided by the host.</p> <ul> <li>CLICKHOUSE: The host is a ClickHouse server.</li> <li>ZOOKEEPER: The host is a ZooKeeper server.</li> </ul> 
hosts[].<br>services[].<br>health | **string**<br><p>Status code of server availability.</p> <ul> <li>UNKNOWN: Health of the server is unknown.</li> <li>ALIVE: The server is working normally.</li> <li>DEAD: The server is dead or unresponsive.</li> </ul> 
hosts[].<br>subnetId | **string**<br><p>ID of the subnet that the host belongs to.</p> 
hosts[].<br>assignPublicIp | **boolean** (boolean)<br><p>Flag showing public IP assignment status to this host.</p> 
hosts[].<br>shardName | **string**
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-clickhouse/api-ref/Cluster/listHosts#query_params">pageSize</a>, use the <a href="/docs/managed-clickhouse/api-ref/Cluster/listHosts#responses">nextPageToken</a> as the value for the <a href="/docs/managed-clickhouse/api-ref/Cluster/listHosts#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-clickhouse/api-ref/Cluster/listHosts#responses">nextPageToken</a> to continue paging through the results.</p> 