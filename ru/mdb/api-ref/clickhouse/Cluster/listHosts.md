# Метод listHosts
Получает список хостов для указанного кластера.
 

 
## HTTP-запрос {#https-request}
`GET https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/{clusterId}/hosts`
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера ClickHouse. Чтобы получить идентификатор кластера ClickHouse, используйте запрос [list](/docs/mdb/api-ref/clickhouse/Cluster/list).  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/mdb/api-ref/clickhouse/Cluster/listHosts#query_params), сервис вернет значение [nextPageToken](/docs/mdb/api-ref/clickhouse/Cluster/listHosts#responses), которое можно использовать для получения следующей страницы.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/mdb/api-ref/clickhouse/Cluster/listHosts#query_params) равным значению поля [nextPageToken](/docs/mdb/api-ref/clickhouse/Cluster/listHosts#responses) прошлого запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**


 
Поле | Описание
--- | ---
hosts | **object**<br><p>Запрошенный список хостов для кластера.</p> 
hosts.<br>name | **string**<br><p>Name of the ClickHouse host. The host name is assigned by MDB at creation time, and cannot be changed. 1-63 characters long.</p> <p>The name is unique across all existing MDB hosts in Yandex.Cloud, as it defines the FQDN of the host.</p> 
hosts.<br>clusterId | **string**<br><p>ID of the ClickHouse host. The ID is assigned by MDB at creation time.</p> 
hosts.<br>zoneId | **string**<br><p>ID of the availability zone where the ClickHouse host resides.</p> 
hosts.<br>type | **string**<br><p>Type of the host.</p> <ul> <li>CLICKHOUSE: ClickHouse host.</li> <li>ZOOKEEPER: ZooKeeper host.</li> </ul> 
hosts.<br>resources | **object**<br><p>Resources allocated to the ClickHouse host.</p> 
hosts.<br>resources.<br>resourcePresetId | **string**<br><p>ID of the preset for computational resources available to a host (CPU, memory etc.). All available presets are listed in the <a href="/docs/mdb/concepts/instance-types">documentation</a></p> 
hosts.<br>resources.<br>diskSize | **string** (int64)<br><p>Volume of the storage available to a host, in bytes.</p> 
hosts.<br>resources.<br>diskTypeId | **string**<br><p>Type of the storage environment for the host. Possible values:</p> <ul> <li>network-nvme — network SSD drive,</li> <li>local-nvme — local SSD storage.</li> </ul> 
hosts.<br>health | **string**<br><p>Status code of the aggregated health of the host.</p> <ul> <li>UNKNOWN: Health of the host is unknown.</li> <li>ALIVE: The host is performing all its functions normally.</li> <li>DEAD: The host is inoperable, and cannot perform any of its essential functions.</li> <li>DEGRADED: The host is degraded, and can perform only some of its essential functions.</li> </ul> 
hosts.<br>services | **object**<br><p>Services provided by the host.</p> 
hosts.<br>services.<br>type | **string**<br><p>Type of the service provided by the host.</p> <ul> <li>CLICKHOUSE: The host is a ClickHouse server.</li> <li>ZOOKEEPER: The host is a ZooKeeper server.</li> </ul> 
hosts.<br>services.<br>health | **string**<br><p>Status code of server availability.</p> <ul> <li>UNKNOWN: Health of the server is unknown.</li> <li>ALIVE: The server is working normally.</li> <li>DEAD: The server is dead or unresponsive.</li> </ul> 
hosts.<br>subnetId | **string**<br><p>ID of the subnet that the host belongs to.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/mdb/api-ref/clickhouse/Cluster/listHosts#query_params">pageSize</a>, используйте <a href="/docs/mdb/api-ref/clickhouse/Cluster/listHosts#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/mdb/api-ref/clickhouse/Cluster/listHosts#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/mdb/api-ref/clickhouse/Cluster/listHosts#responses">nextPageToken</a> для перебора страниц результатов.</p> 