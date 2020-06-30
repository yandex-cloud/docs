---
editable: false
---

# Метод listHosts
Retrieves a list of hosts for the specified Apache Kafka cluster.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-kafka/v1/clusters/{clusterId}/hosts
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. ID of the Apache Kafka cluster.  To get the Apache Kafka cluster ID, make a [list](/docs/managed-kafka/api-ref/Cluster/list) request.  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | The maximum number of results per page to return.  If the number of available results is larger than `page_size`, the service returns a [nextPageToken](/docs/managed-kafka/api-ref/Cluster/listHosts#responses) that can be used to get the next page of results in subsequent list requests.  Максимальное значение — 1000.
pageToken | Page token.  To get the next page of results, set `page_token` to the [nextPageToken](/docs/managed-kafka/api-ref/Cluster/listHosts#responses) returned by a previous list request.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
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

 
Поле | Описание
--- | ---
hosts[] | **object**<br><p>Cluster host metadata.</p> 
hosts[].<br>name | **string**<br><p>Name of the host.</p> 
hosts[].<br>clusterId | **string**<br><p>ID of the Apache Kafka cluster.</p> 
hosts[].<br>zoneId | **string**<br><p>ID of the availability zone where the host resides.</p> 
hosts[].<br>role | **string**<br><p>Host role.</p> <ul> <li>KAFKA: The host is a Kafka broker.</li> <li>ZOOKEEPER: The host is a ZooKeeper server.</li> </ul> 
hosts[].<br>resources | **object**<br><p>Resources allocated to the host.</p> <p>Cluster computational resources.</p> 
hosts[].<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory, etc.). All available presets are listed in the <a href="/docs/managed-kafka/concepts/instance-types">documentation</a>.</p> 
hosts[].<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
hosts[].<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host.</p> 
hosts[].<br>health | **string**<br><p>Aggregated host health data.</p> <ul> <li>UNKNOWN: Health of the host is unknown.</li> <li>ALIVE: The host is performing all its functions normally.</li> <li>DEAD: The host is inoperable and cannot perform any of its essential functions.</li> <li>DEGRADED: The host is degraded and can perform only some of its essential functions.</li> </ul> 
hosts[].<br>subnetId | **string**<br><p>ID of the subnet the host resides in.</p> 
hosts[].<br>assignPublicIp | **boolean** (boolean)<br><p>The flag that defines whether a public IP address is assigned to the node.</p> <p>If the value is <code>true</code>, then this node is available on the Internet via it's public IP address.</p> 
nextPageToken | **string**<br><p>Token that allows you to get the next page of results for list requests.</p> <p>If the number of results is larger than <a href="/docs/managed-kafka/api-ref/Cluster/listHosts#query_params">pageSize</a>, use the <code>next_page_token</code> as the value for the <a href="/docs/managed-kafka/api-ref/Cluster/listHosts#query_params">pageToken</a> query parameter in the next list request. Each subsequent list request will have its own <code>next_page_token</code> to continue paging through the results.</p> 