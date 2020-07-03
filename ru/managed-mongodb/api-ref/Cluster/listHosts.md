---
editable: false
---

# Метод listHosts
Получает список хостов для указанного кластера.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-mongodb/v1/clusters/{clusterId}/hosts
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера MongoDB. Чтобы получить идентификатор кластера MongoDB, используйте запрос [list](/docs/managed-mongodb/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем [pageSize](/docs/managed-mongodb/api-ref/Cluster/listHosts#query_params), сервис вернет значение [nextPageToken](/docs/managed-mongodb/api-ref/Cluster/listHosts#responses), которое можно использовать для получения следующей страницы.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/managed-mongodb/api-ref/Cluster/listHosts#query_params) равным значению поля [nextPageToken](/docs/managed-mongodb/api-ref/Cluster/listHosts#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
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

 
Поле | Описание
--- | ---
hosts[] | **object**<br><p>Список ресурсов Host.</p> 
hosts[].<br>name | **string**<br><p>Имя хоста MongoDB. Имя хоста назначается MDB во время создания и не может быть изменено. Длина 1-63 символов.</p> <p>Имя уникально для всех существующих хостов MDB в Яндекс.Облаке, так как оно определяет полное доменное имя (FQDN) хоста.</p> 
hosts[].<br>clusterId | **string**<br><p>Идентификатор хоста MongoDB. Этот идентификатор генерирует MDB при создании.</p> 
hosts[].<br>zoneId | **string**<br><p>Идентификатор зоны доступности, в которой находится хост MongoDB.</p> 
hosts[].<br>resources | **object**<br><p>Ресурсы, выделенные хосту MongoDB.</p> 
hosts[].<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-mongodb/concepts/instance-types">документации</a>.</p> 
hosts[].<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
hosts[].<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>network-hdd — сетевой HDD-диск;</li> <li>network-ssd — сетевой SSD-диск;</li> <li>local-ssd — локальное SSD-хранилище.</li> </ul> 
hosts[].<br>role | **string**<br><p>Роль хоста в кластере.</p> <ul> <li>ROLE_UNKNOWN: Роль хоста в кластере неизвестна.</li> <li>PRIMARY: Хост является основным сервером MongoDB в кластере.</li> <li>SECONDARY: Хост является вторичным сервером MongoDB в кластере.</li> </ul> 
hosts[].<br>health | **string**<br><p>Код работоспособности хоста.</p> <ul> <li>HEALTH_UNKNOWN: Состояние хоста неизвестно.</li> <li>ALIVE: Хозяин выполняет все свои функции нормально.</li> <li>DEAD: Хост не работает и не может выполнять свои основные функции.</li> <li>DEGRADED: Хост деградировал, и может выполнять только некоторые из своих основных функций.</li> </ul> 
hosts[].<br>services[] | **object**<br><p>Сервисы, предоставляемые хостом.</p> 
hosts[].<br>services[].<br>type | **string**<br><p>Тип сервиса, предоставляемого хостом.</p> <ul> <li>MONGOD: На хосте работает демон mongod.</li> <li>MONGOS: На хосте работает демон mongos.</li> <li>MONGOCFG: На хосте работает сервер конфигураций MongoDB.</li> </ul> 
hosts[].<br>services[].<br>health | **string**<br><p>Код состояния доступности сервера.</p> <ul> <li>HEALTH_UNKNOWN: Работоспособность сервера неизвестна.</li> <li>ALIVE: Сервер работает нормально.</li> <li>DEAD: Сервер отключен или не отвечает.</li> </ul> 
hosts[].<br>subnetId | **string**<br><p>Идентификатор подсети, к которой принадлежит хост.</p> 
hosts[].<br>assignPublicIp | **boolean** (boolean)<br><p>Флаг, показывающий статус публичного IP-адреса для этого хоста.</p> 
hosts[].<br>shardName | **string**<br><p>Шард, которому принадлежит этот этот хост.</p> 
hosts[].<br>type | **string**<br><p>Тип хоста</p> <ul> <li>MONGOD: Хост mongod.</li> <li>MONGOS: Хост mongos.</li> <li>MONGOCFG: Хост mongocfg.</li> </ul> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/managed-mongodb/api-ref/Cluster/listHosts#query_params">pageSize</a>, используйте <a href="/docs/managed-mongodb/api-ref/Cluster/listHosts#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/managed-mongodb/api-ref/Cluster/listHosts#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/managed-mongodb/api-ref/Cluster/listHosts#responses">nextPageToken</a> для перебора страниц результатов.</p> 