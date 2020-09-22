---
editable: false
---

# Метод listHosts
Получает список хостов для указанного кластера.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/clusters/{clusterId}/hosts
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера ClickHouse. Чтобы получить идентификатор кластера ClickHouse, используйте запрос [list](/docs/managed-clickhouse/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на одной странице в ответе. Если количество результатов больше чем [pageSize](/docs/managed-clickhouse/api-ref/Cluster/listHosts#query_params), сервис вернет значение [nextPageToken](/docs/managed-clickhouse/api-ref/Cluster/listHosts#responses), которое можно использовать для получения следующей страницы.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение [pageToken](/docs/managed-clickhouse/api-ref/Cluster/listHosts#query_params) равным значению поля [nextPageToken](/docs/managed-clickhouse/api-ref/Cluster/listHosts#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
## Ответ {#responses}
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

 
Поле | Описание
--- | ---
hosts[] | **object**<br><p>Запрошенный список хостов для кластера.</p> 
hosts[].<br>name | **string**<br><p>Имя хоста ClickHouse. Имя хоста назначается MDB во время создания и не может быть изменено. Длина 1-63 символов.</p> <p>Имя уникально для всех существующих хостов MDB в Яндекс.Облаке, так как оно определяет полное доменное имя (FQDN) хоста.</p> 
hosts[].<br>clusterId | **string**<br><p>Идентификатор хоста ClickHouse. Этот идентификатор генерирует MDB при создании.</p> 
hosts[].<br>zoneId | **string**<br><p>Идентификатор зоны доступности, в которой находится хост ClickHouse.</p> 
hosts[].<br>type | **string**<br><p>Тип хоста.</p> <ul> <li>CLICKHOUSE: Хост ClickHouse.</li> <li>ZOOKEEPER: Хост ZooKeeper.</li> </ul> 
hosts[].<br>resources | **object**<br><p>Ресурсы, выделенные хосту ClickHouse.</p> 
hosts[].<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-clickhouse/concepts/instance-types">документации</a>.</p> 
hosts[].<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
hosts[].<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>network-hdd — сетевой HDD-диск;</li> <li>network-ssd — сетевой SSD-диск;</li> <li>local-ssd — локальное SSD-хранилище.</li> </ul> 
hosts[].<br>health | **string**<br><p>Код работоспособности хоста.</p> <ul> <li>UNKNOWN: Состояние хоста неизвестно.</li> <li>ALIVE: Хост работает и выполняет все свои функции.</li> <li>DEAD: Хост не работает и не может выполнять свои основные функции.</li> <li>DEGRADED: Хост деградировал, и может выполнять только некоторые из своих основных функций.</li> </ul> 
hosts[].<br>services[] | **object**<br><p>Сервисы, предоставляемые хостом.</p> 
hosts[].<br>services[].<br>type | **string**<br><p>Тип сервиса, предоставляемого хостом.</p> <ul> <li>CLICKHOUSE: Хост — это сервер ClickHouse.</li> <li>ZOOKEEPER: Хост — сервер ZooKeeper.</li> </ul> 
hosts[].<br>services[].<br>health | **string**<br><p>Код состояния доступности сервера.</p> <ul> <li>UNKNOWN: Работоспособность сервера неизвестна.</li> <li>ALIVE: Сервер работает нормально.</li> <li>DEAD: Сервер отключен или не отвечает.</li> </ul> 
hosts[].<br>subnetId | **string**<br><p>Идентификатор подсети, к которой принадлежит хост.</p> 
hosts[].<br>assignPublicIp | **boolean** (boolean)<br><p>Флаг, показывающий статус публичного IP-адреса для этого хоста.</p> 
hosts[].<br>shardName | **string**<br>
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/managed-clickhouse/api-ref/Cluster/listHosts#query_params">pageSize</a>, используйте <a href="/docs/managed-clickhouse/api-ref/Cluster/listHosts#responses">nextPageToken</a> в качестве значения параметра <a href="/docs/managed-clickhouse/api-ref/Cluster/listHosts#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения <a href="/docs/managed-clickhouse/api-ref/Cluster/listHosts#responses">nextPageToken</a> для перебора страниц результатов.</p> 