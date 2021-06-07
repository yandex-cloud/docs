---
editable: false
---

# Метод listHosts
Получает список хостов для указанного кластера Elasticsearch.
 

 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-elasticsearch/v1/clusters/{clusterId}/hosts
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера Elasticsearch.  Чтобы получить идентификатор кластера Elasticsearch, выполните запрос [list](/docs/managed-elasticsearch/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на одной странице в ответе.  Если количество результатов больше чем `page_size`, сервис вернет значение [nextPageToken](/docs/managed-elasticsearch/api-ref/Cluster/listHosts#responses), которое можно использовать для получения следующей страницы.  Максимальное значение — 1000.
pageToken | Токен страницы.  Установите значение `page_token` равным значению поля [nextPageToken](/docs/managed-elasticsearch/api-ref/Cluster/listHosts#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
 
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
      "assignPublicIp": true
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
hosts[] | **object**<br><p>Метаданные хоста кластера.</p> 
hosts[].<br>name | **string**<br><p>Имя хоста.</p> 
hosts[].<br>clusterId | **string**<br><p>Идентификатор кластера Elasticsearch.</p> 
hosts[].<br>zoneId | **string**<br><p>Идентификатор зоны доступности, в которой находится хост.</p> 
hosts[].<br>type | **string**<br><p>Тип хоста.</p> <ul> <li>DATA_NODE: этот хост является узлом Elasticsearch с ролью Data node.</li> <li>MASTER_NODE: этот хост является узлом Elasticsearch с ролью Master node.</li> </ul> 
hosts[].<br>resources | **object**<br>
hosts[].<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т.д.). Все доступные наборы ресурсов перечислены в <a href="/docs/managed-elasticsearch/concepts/instance-types">документации</a>.</p> 
hosts[].<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
hosts[].<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Все доступные типы перечислены в <a href="/docs/managed-elasticsearch/concepts/storage">документации</a>.</p> 
hosts[].<br>health | **string**<br><p>Агрегированные данные о работоспособности хоста.</p> <ul> <li>UNKNOWN: состояние хоста неизвестно.</li> <li>ALIVE: хост работает и выполняет все свои функции.</li> <li>DEAD: хост не работает и не выполняет свои функции.</li> <li>DEGRADED: хост находится в состоянии деградации и может выполнять только некоторые свои функции.</li> </ul> 
hosts[].<br>services[] | **object**<br><p>Метаданные сервисов кластера.</p> 
hosts[].<br>services[].<br>type | **string**<br><p>Тип сервиса, предоставляемого хостом.</p> <ul> <li>ELASTICSEARCH: сервис Elasticsearch.</li> </ul> 
hosts[].<br>services[].<br>health | **string**<br><p>Данные о работоспособности сервиса.</p> <ul> <li>UNKNOWN: состояние сервиса неизвестно.</li> <li>ALIVE: сервис работает в штатном режиме.</li> <li>DEAD: сервис не работает или не отвечает.</li> </ul> 
hosts[].<br>subnetId | **string**<br><p>Идентификатор подсети, в которой находится хост.</p> 
hosts[].<br>assignPublicIp | **boolean** (boolean)<br><p>Флаг, определяющий, назначен ли хосту публичный IP-адрес.</p> <p>Если значение равно ``true``, то этот хост доступен в Интернете через его публичный IP-адрес.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы результатов в ответе.</p> <p>Если количество результатов больше чем <a href="/docs/managed-elasticsearch/api-ref/Cluster/listHosts#query_params">pageSize</a>, используйте ``next_page_token`` в качестве значения параметра <a href="/docs/managed-elasticsearch/api-ref/Cluster/listHosts#query_params">pageToken</a> в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения ``next_page_token`` для перебора страниц результатов.</p> 