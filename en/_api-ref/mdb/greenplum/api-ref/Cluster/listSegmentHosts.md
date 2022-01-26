---
editable: false
---

# Method listSegmentHosts
Retrieves a list of segment hosts for the specified cluster.
 

 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/mdb/managed-greenplum/v1/clusters/{clusterId}/segment-hosts
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the Greenplum® cluster. To get the Greenplum® cluster ID use a [list](/docs/managed-greenplum/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/managed-greenplum/api-ref/Cluster/listSegmentHosts#query_params), the service returns a [nextPageToken](/docs/managed-greenplum/api-ref/Cluster/listSegmentHosts#responses) that can be used to get the next page of results in subsequent list requests.  The maximum value is 1000.
pageToken | Page token. To get the next page of results, set [pageToken](/docs/managed-greenplum/api-ref/Cluster/listSegmentHosts#query_params) to the [nextPageToken](/docs/managed-greenplum/api-ref/Cluster/listSegmentHosts#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
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
      "subnetId": "string",
      "assignPublicIp": true
    }
  ],
  "nextPageToken": "string"
}
```

 
Field | Description
--- | ---
hosts[] | **object**<br><p>A Greenplum® cluster host resource.</p> 
hosts[].<br>name | **string**<br><p>Required. Name of the Greenplum® host. The host name is assigned by Yandex.Cloud at creation time and cannot be changed. 1-63 characters long.</p> <p>The name is unique across all existing MDB hosts in Yandex.Cloud, as it defines the FQDN of the host.</p> <p>The maximum string length in characters is 63.</p> 
hosts[].<br>clusterId | **string**<br><p>ID of the Greenplum® cluster. The ID is assigned by Yandex.Cloud at creation time.</p> 
hosts[].<br>zoneId | **string**<br><p>ID of the availability zone the Greenplum® host belongs to.</p> 
hosts[].<br>type | **string**<br><p>Type of the host.</p> <p>Type of the host.</p> <ul> <li>TYPE_UNSPECIFIED: The type is not specified.</li> <li>MASTER: A Greenplum® master host.</li> <li>REPLICA: A Greenplum® master replica host.</li> <li>SEGMENT: A Greenplum® segment host.</li> </ul> 
hosts[].<br>resources | **object**<br><p>Resources allocated to the Greenplum® host.</p> <p>A list of computational resources allocated to a host.</p> 
hosts[].<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources allocated to a host. Available presets are listed in the <a href="/docs/managed-greenplum/concepts/instance-types">documentation</a>.</p> 
hosts[].<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage used by the host, in bytes.</p> 
hosts[].<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage used by the host: ``network-hdd``, ``network-ssd`` or ``local-ssd``.</p> 
hosts[].<br>health | **string**<br><p>Status code of the aggregated health of the host.</p> <p>Status code of the aggregated health of the host.</p> <ul> <li>UNKNOWN: Health of the host is unknown.</li> <li>ALIVE: The host is performing all its functions normally.</li> <li>DEAD: The host is inoperable and cannot perform any of its essential functions.</li> <li>DEGRADED: The host is working below capacity or not fully functional.</li> <li>UNBALANCED: One or more segments are not in preferred role.</li> </ul> 
hosts[].<br>subnetId | **string**<br><p>ID of the subnet that the host belongs to.</p> 
hosts[].<br>assignPublicIp | **boolean** (boolean)<br><p>Whether or not a public IP is assigned to the host.</p> 
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-greenplum/api-ref/Cluster/listSegmentHosts#query_params">pageSize</a>, use the <a href="/docs/managed-greenplum/api-ref/Cluster/listSegmentHosts#responses">nextPageToken</a> as the value for the <a href="/docs/managed-greenplum/api-ref/Cluster/listSegmentHosts#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-greenplum/api-ref/Cluster/listSegmentHosts#responses">nextPageToken</a> to continue paging through the results.</p> 