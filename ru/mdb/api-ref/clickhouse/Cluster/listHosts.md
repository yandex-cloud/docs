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
hosts | **object**<br>Только для вывода. Запрошенный список хостов для кластера.
hosts.<br>name | **string**<br>Имя хоста ClickHouse. Имя хоста назначается MDB во время создания и не может быть изменено. Длина имени должна быть от 1 до 63 символов.  Имя уникально для всех существующих хостов MDB в Яндекс.Облаке, так как оно определяет полное доменное имя (FQDN) хоста.
hosts.<br>clusterId | **string**<br>Идентификатор хоста ClickHouse. Этот идентификатор генерирует MDB при создании.
hosts.<br>zoneId | **string**<br>Идентификатор зоны доступности, в которой находится хост ClickHouse.
hosts.<br>type | **string**<br>Тип хоста.   - CLICKHOUSE: Хост ClickHouse.  - ZOOKEEPER: Хост ZooKeeper.<br>`CLICKHOUSE`<br>`ZOOKEEPER`<br>
hosts.<br>resources | **object**<br>Ресурсы, выделенные хосту ClickHouse.
hosts.<br>resources.<br>resourcePresetId | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [Классы баз данных](/docs/mdb/concepts/instance-types)
hosts.<br>resources.<br>diskSize | **string** (int64)<br>Объем хранилища, доступный хосту, в байтах.
hosts.<br>resources.<br>diskTypeId | **string**<br>Тип хранилища для хоста. Возможные значения: * local-ssd — хранилище на базе локальных SSD-дисков.
hosts.<br>health | **string**<br>Код работоспособности хоста.   - ALIVE: Хост выполняет все свои функции в нормальном режиме.  - DEAD: Хост не работает и не может выполнять свои основные функции.  - DEGRADED: Хост деградировал, и может выполнять только некоторые из своих основных функций.<br>`UNKNOWN`<br>`ALIVE`<br>`DEAD`<br>`DEGRADED`<br>
hosts.<br>services | **object**<br>Сервисы, предоставляемые хостом.
hosts.<br>services.<br>type | **string**<br>Тип сервиса, предоставляемого хостом.   - CLICKHOUSE: Хост — это сервер ClickHouse.  - ZOOKEEPER: Хост — сервер ZooKeeper.<br>`CLICKHOUSE`<br>`ZOOKEEPER`<br>
hosts.<br>services.<br>health | **string**<br>Код состояния доступности сервера.   - ALIVE: Сервер работает нормально.  - DEAD: Сервер отключен или не отвечает.<br>`UNKNOWN`<br>`ALIVE`<br>`DEAD`<br>
hosts.<br>subnetId | **string**<br>Идентификатор подсети, к которой принадлежит хост.
nextPageToken | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [pageSize](/docs/mdb/api-ref/clickhouse/Cluster/listHosts#query_params), используйте [nextPageToken](/docs/mdb/api-ref/clickhouse/Cluster/listHosts#responses) в качестве значения параметра [pageToken](/docs/mdb/api-ref/clickhouse/Cluster/listHosts#query_params) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения [nextPageToken](/docs/mdb/api-ref/clickhouse/Cluster/listHosts#responses) для перебора страниц результатов.