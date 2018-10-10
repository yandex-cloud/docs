# Метод listHosts
Получает список хостов для указанного кластера.
 

 
## HTTP-запрос
`GET /managed-mongodb/v1/clusters/{clusterId}/hosts`
 
## Path-параметры {#path_params}
 
Name | Description
--- | ---
clusterId | Обязательное поле. Обязательное поле. Идентификатор кластера MongoDB. Чтобы получить идентификатор кластера MongoDB, используйте запрос [list](/docs/mdb/api-ref/mongodb/Cluster/list).  Максимальная длина — 50 символов.
 
## Query-параметры {#query_params}
 
Name | Description
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/mdb/api-ref/mongodb/Cluster/listHosts#query_params), сервис вернет значение [nextPageToken](/docs/mdb/api-ref/mongodb/Cluster/listHosts#responses), которое можно использовать для получения следующей страницы.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение [pageToken](/docs/mdb/api-ref/mongodb/Cluster/listHosts#query_params) равным значению поля [nextPageToken](/docs/mdb/api-ref/mongodb/Cluster/listHosts#responses) прошлого запроса, чтобы получить следующую страницу результатов.  Максимальная длина — 100 символов.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**


 
Поле | Описание
--- | ---
hosts | **object**<br>Список ресурсов Host.
hosts.<br>name | **string**<br>Имя хоста MongoDB. Имя хоста назначается MDB во время создания и не может быть изменено. Длина имени должна быть от 1 до 63 символов.  Имя уникально для всех существующих хостов MDB в Яндекс.Облаке, так как оно определяет полное доменное имя (FQDN) хоста.
hosts.<br>clusterId | **string**<br>Идентификатор хоста MongoDB. Этот идентификатор генерирует MDB при создании.
hosts.<br>zoneId | **string**<br>Идентификатор зоны доступности, в которой находится хост MongoDB.
hosts.<br>resources | **object**<br>Ресурсы, выделенные хосту MongoDB.
hosts.<br>resources.<br>resourcePresetId | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [Классы баз данных](/docs/mdb/concepts/instance-types).
hosts.<br>resources.<br>diskSize | **string** (int64)<br>Объем хранилища, доступный хосту, в байтах.
hosts.<br>resources.<br>diskTypeId | **string**<br>Тип хранилища для хоста. Возможные значения: * local-ssd — хранилище на базе локальных SSD-дисков.
hosts.<br>role | **string**<br>Роль хоста в кластере.   - PRIMARY: Хост является основным сервером MongoDB в кластере.  - SECONDARY: Хост является вторичным сервером MongoDB в кластере.<br>`ROLE_UNKNOWN`<br>`PRIMARY`<br>`SECONDARY`<br>
hosts.<br>health | **string**<br>Код работоспособности хоста.   - ALIVE: Хост выполняет все свои функции в нормальном режиме.  - DEAD: Хост не работает и не может выполнять свои основные функции.  - DEGRADED: Хост деградировал, и может выполнять только некоторые из своих основных функций.<br>`HEALTH_UNKNOWN`<br>`ALIVE`<br>`DEAD`<br>`DEGRADED`<br>
hosts.<br>services | **object**<br>Сервисы, предоставляемые хостом.
hosts.<br>services.<br>type | **string**<br>Тип сервиса, предоставляемого хостом.   - MONGOD: На хосте работает демон mongod.  - MONGOS: На хосте работает демон mongos.  - MONGOCFG: На хосте работает сервер конфигураций MongoDB.<br>`MONGOD`<br>`MONGOS`<br>`MONGOCFG`<br>
hosts.<br>services.<br>health | **string**<br>Код состояния доступности сервера.   - ALIVE: Сервер работает нормально.  - DEAD: Сервер отключен или не отвечает.<br>`HEALTH_UNKNOWN`<br>`ALIVE`<br>`DEAD`<br>
hosts.<br>subnetId | **string**<br>Идентификатор подсети, к которой принадлежит хост.
nextPageToken | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [pageSize](/docs/mdb/api-ref/mongodb/Cluster/listHosts#query_params), используйте [nextPageToken](/docs/mdb/api-ref/mongodb/Cluster/listHosts#responses) в качестве значения параметра [pageToken](/docs/mdb/api-ref/mongodb/Cluster/listHosts#query_params) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения [nextPageToken](/docs/mdb/api-ref/mongodb/Cluster/listHosts#responses) для перебора страниц результатов.