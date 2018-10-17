# Метод listHosts
Получает список хостов для указанного кластера.
 

 
## HTTP-запрос
`GET /managed-clickhouse/v1/clusters/{clusterId}/hosts`
 
## Path-параметры {#path_params}
 
Name | Description
--- | ---
clusterId | Обязательное поле. Идентификатор кластера ClickHouse. Чтобы получить идентификатор кластера ClickHouse, используйте запрос [list](/docs/mdb/api-ref/clickhouse/Cluster/list).  Максимальная длина — 50 символов.
 
## Query-параметры {#query_params}
 
Name | Description
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/mdb/api-ref/clickhouse/Cluster/listHosts#query_params), сервис вернет значение [nextPageToken](/docs/mdb/api-ref/clickhouse/Cluster/listHosts#responses), которое можно использовать для получения следующей страницы.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение [pageToken](/docs/mdb/api-ref/clickhouse/Cluster/listHosts#query_params) равным значению поля [nextPageToken](/docs/mdb/api-ref/clickhouse/Cluster/listHosts#responses) прошлого запроса, чтобы получить следующую страницу результатов.  Максимальная длина — 100 символов.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**


 
Поле | Описание
--- | ---
hosts | **object**<br><p>Запрошенный список хостов для кластера.</p> 
hosts.<br>name | **string**<br><p>Имя хоста ClickHouse. Имя хоста назначается MDB во время создания и не может быть изменено. Длина имени должна быть от 1 до 63 символов.</p> <p>Имя уникально для всех существующих хостов MDB в Яндекс.Облаке, так как оно определяет полное доменное имя (FQDN) хоста.</p> 
hosts.<br>clusterId | **string**<br><p>Идентификатор хоста ClickHouse. Этот идентификатор генерирует MDB при создании.</p> 
hosts.<br>zoneId | **string**<br><p>Идентификатор зоны доступности, в которой находится хост ClickHouse.</p> 
hosts.<br>type | **string**<br><p>Тип хоста.</p> <ul> <li>CLICKHOUSE: Хост ClickHouse.</li> <li>ZOOKEEPER: Хост ZooKeeper.</li> </ul> 
hosts.<br>resources | **object**<br><p>Ресурсы, выделенные хосту ClickHouse.</p> 
hosts.<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/mdb/concepts/instance-types">Классы баз данных</a></p> 
hosts.<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступный хосту, в байтах.</p> 
hosts.<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>local-ssd — хранилище на базе локальных SSD-дисков.</li> </ul> 
hosts.<br>health | **string**<br><p>Код работоспособности хоста.</p> <ul> <li>ALIVE: Хост выполняет все свои функции в нормальном режиме.</li> <li>DEAD: Хост не работает и не может выполнять свои основные функции.</li> <li>DEGRADED: Хост деградировал, и может выполнять только некоторые из своих основных функций.</li> </ul> 
hosts.<br>services | **object**<br><p>Сервисы, предоставляемые хостом.</p> 
hosts.<br>services.<br>type | **string**<br><p>Тип сервиса, предоставляемого хостом.</p> <ul> <li>CLICKHOUSE: Хост — это сервер ClickHouse.</li> <li>ZOOKEEPER: Хост — сервер ZooKeeper.</li> </ul> 
hosts.<br>services.<br>health | **string**<br><p>Код состояния доступности сервера.</p> <ul> <li>ALIVE: Сервер работает нормально.</li> <li>DEAD: Сервер отключен или не отвечает.</li> </ul> 
hosts.<br>subnetId | **string**<br><p>Идентификатор подсети, к которой принадлежит хост.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/mdb/api-ref/clickhouse/Cluster/listHosts#query_params">pageSize</a>, используйте <a href="/docs/mdb/api-ref/clickhouse/Cluster/listHosts#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/mdb/api-ref/clickhouse/Cluster/listHosts#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/mdb/api-ref/clickhouse/Cluster/listHosts#responses">nextPageToken</a> для перебора страниц результатов.</p> 