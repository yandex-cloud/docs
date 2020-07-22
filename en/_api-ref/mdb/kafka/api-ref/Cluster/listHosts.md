---
editable: false
---

# Method listHosts
Retrieves a list of hosts for the specified cluster.
 

 
## HTTP request {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/{clusterId}/hosts
```
 
## Path parameters {#path_params}
 
Parameter | Description
--- | ---
clusterId | Required. ID of the Apache Kafka cluster. To get the Apache Kafka cluster ID use a [list](/docs/managed-kafka/api-ref/Cluster/list) request.  The maximum string length in characters is 50.
 
## Query parameters {#query_params}
 
Parameter | Description
--- | ---
pageSize | The maximum number of results per page to return. If the number of available results is larger than [pageSize](/docs/managed-kafka/api-ref/Cluster/listHosts#query_params), the service returns a [nextPageToken](/docs/managed-kafka/api-ref/Cluster/listHosts#responses) that can be used to get the next page of results in subsequent list requests.  The maximum value is 1000.
pageToken | Page token.  To get the next page of results, set [pageToken](/docs/managed-kafka/api-ref/Cluster/listHosts#query_params) to the [nextPageToken](/docs/managed-kafka/api-ref/Cluster/listHosts#responses) returned by a previous list request.  The maximum string length in characters is 100.
 
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
hosts[] | **object**<br><p>List of Host resources.</p> 
hosts[].<br>name | **string**<br><p>Required. Name of the host.</p> 
hosts[].<br>clusterId | **string**<br><p>Required. ID of the Apache Kafka cluster.</p> 
hosts[].<br>zoneId | **string**<br><p>ID of the availability zone.</p> 
hosts[].<br>role | **string**<br><p>Host role.</p> 
hosts[].<br>resources | **object**<br><p>Resources allocated to the host.</p> 
hosts[].<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/kafka/concepts/instance-types">documentation</a>.</p> 
hosts[].<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
hosts[].<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> 
hosts[].<br>health | **string**<br><p>Aggregated host health</p> 
hosts[].<br>subnetId | **string**<br>
hosts[].<br>assignPublicIp | **boolean** (boolean)<br>
nextPageToken | **string**<br><p>This token allows you to get the next page of results for list requests. If the number of results is larger than <a href="/docs/managed-kafka/api-ref/Cluster/listHosts#query_params">pageSize</a>, use the <a href="/docs/managed-kafka/api-ref/Cluster/listHosts#responses">nextPageToken</a> as the value for the <a href="/docs/managed-kafka/api-ref/Cluster/listHosts#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <a href="/docs/managed-kafka/api-ref/Cluster/listHosts#responses">nextPageToken</a> to continue paging through the results.</p> 