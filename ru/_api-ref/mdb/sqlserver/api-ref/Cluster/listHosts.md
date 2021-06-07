---
editable: false
---

# Метод listHosts
Возвращает список хостов для указанного кластера SQL Server.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/mdb/sqlserver/v1/clusters/{clusterId}/hosts
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера SQL Server.  Чтобы получить идентификатор кластера SQL Server, используйте запрос [list](/docs/managed-sqlserver/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на одной странице в ответе. Если количество результатов больше чем `page_size`, сервис вернет значение [nextPageToken](/docs/managed-sqlserver/api-ref/Cluster/listHosts#responses), которое можно использовать для получения следующей страницы.  Допустимые значения — от 0 до 1000 включительно.
pageToken | Токен страницы. Установите значение `page_token` равным значению поля [nextPageToken](/docs/managed-sqlserver/api-ref/Cluster/listHosts#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
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
      "assignPublicIp": true
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
hosts[] | **object**<br><p>Список хостов SQL Server.</p> 
hosts[].<br>name | **string**<br><p>Имя хоста SQL Server. Имя хоста Managed Service for SQL Server назначает во время создания, его нельзя изменить. Длина 1-63 символов.</p> <p>Имя уникально для всех существующих хостов баз данных в Яндекс.Облаке, так как оно определяет полное доменное имя (FQDN) хоста.</p> 
hosts[].<br>clusterId | **string**<br><p>Идентификатор хоста SQL Server. Этот идентификатор Managed Service for SQL Server генерирует при создании.</p> 
hosts[].<br>zoneId | **string**<br><p>Идентификатор зоны доступности, в которой находится хост SQL Server.</p> 
hosts[].<br>resources | **object**<br><p>Ресурсы, выделенные хосту.</p> 
hosts[].<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-sqlserver/concepts/instance-types">документации</a>.</p> 
hosts[].<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту.</p> 
hosts[].<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста.</p> <p>Возможные значения:</p> <ul> <li>network-hdd — сетевой HDD-диск;</li> <li>network-ssd — сетевой SSD-диск;</li> <li>local-ssd — локальное SSD-хранилище.</li> </ul> 
hosts[].<br>role | **string**<br><p>Роль хоста в кластере.</p> <ul> <li>ROLE_UNKNOWN: Роль хоста в кластере неизвестна.</li> <li>MASTER: Хост является мастером в кластере SQL Server.</li> <li>REPLICA: Хост является репликой в кластере SQL Server.</li> </ul> 
hosts[].<br>health | **string**<br><p>Код работоспособности хоста.</p> <ul> <li>HEALTH_UNKNOWN: Состояние хоста неизвестно.</li> <li>ALIVE: Хост работает и выполняет все свои функции.</li> <li>DEAD: Хост не работает и не может выполнять свои основные функции.</li> <li>DEGRADED: Хост деградировал, и может выполнять только некоторые из своих основных функций.</li> </ul> 
hosts[].<br>services[] | **object**<br><p>Сервисы, предоставляемые хостом.</p> 
hosts[].<br>services[].<br>type | **string**<br><p>Тип сервиса, предоставляемого хостом.</p> <ul> <li>SQLSERVER: Служба SQL Server</li> </ul> 
hosts[].<br>services[].<br>health | **string**<br><p>Код состояния доступности сервера.</p> <ul> <li>HEALTH_UNKNOWN: Работоспособность сервера неизвестна.</li> <li>ALIVE: Сервер работает нормально.</li> <li>DEAD: Сервер отключен или не отвечает.</li> </ul> 
hosts[].<br>subnetId | **string**<br><p>Идентификатор подсети, к которой принадлежит хост.</p> 
hosts[].<br>assignPublicIp | **boolean** (boolean)<br><p>Флаг, показывающий статус публичного IP-адреса для этого хоста.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем <a href="/docs/managed-sqlserver/api-ref/Cluster/listHosts#query_params">pageSize</a>, используйте ``next_page_token`` в качестве значения параметра <a href="/docs/managed-sqlserver/api-ref/Cluster/listHosts#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения ``next_page_token`` для перебора страниц результатов.</p> 