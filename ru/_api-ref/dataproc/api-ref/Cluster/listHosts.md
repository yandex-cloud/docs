---
editable: false
---

# Метод listHosts
Получает список хостов для указанного кластера.
 

 
## HTTP-запрос {#https-request}
```
GET https://dataproc.api.cloud.yandex.net/dataproc/v1/clusters/{clusterId}/hosts
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Идентификатор кластера, для которого запрашивается список хостов.  Чтобы получить идентификатор кластера, выполните запрос [list](/docs/data-proc/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [nextPageToken](/docs/data-proc/api-ref/Cluster/listHosts#responses), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение `page_token` равным значению поля [nextPageToken](/docs/data-proc/api-ref/Cluster/listHosts#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
filter | Параметры фильтрации хостов в ответе.  В параметрах фильтрации указываются: 1. Имя поля. В настоящее время фильтрация осуществляется только по полю [Cluster.name](/docs/data-proc/api-ref/Cluster#representation). 2. Оператор. Может быть `=` или `!=` для отдельных значений, `IN` или `NOT IN` для списков значений. 3. Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]`. Пример фильтра: `name=my-host`.  Максимальная длина строки в символах — 1000.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "hosts": [
    {
      "name": "string",
      "subclusterId": "string",
      "health": "string",
      "computeInstanceId": "string",
      "role": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
hosts[] | **object**<br><p>Хост Data Proc. Дополнительные сведения о концепции см. в <a href="/docs/data-proc/concepts/">документации</a>.</p> 
hosts[].<br>name | **string**<br><p>Имя хоста Data Proc. Data Proc генерирует имя хоста при его создании, после этого имя невозможно изменить. Имя уникально для всех существующих хостов Data Proc в Яндекс.Облаке, так как оно определяет полное доменное имя (FQDN) хоста.</p> 
hosts[].<br>subclusterId | **string**<br><p>Идентификатор подкластера Data Proc, которому принадлежит хост.</p> 
hosts[].<br>health | **string**<br><p>Код состояния хоста.</p> <ul> <li>HEALTH_UNKNOWN: Состояние кластера неизвестно (``health`` для каждого хоста в кластере — UNKNOWN).</li> <li>ALIVE: Кластер работает нормально (``health`` для каждого хоста в кластере — ALIVE).</li> <li>DEAD: Кластер не работает (``health`` для каждого хоста в кластере — DEAD).</li> <li>DEGRADED: Кластер работает неоптимально (``health`` по крайней мере для одного хоста в кластере не ALIVE).</li> </ul> 
hosts[].<br>computeInstanceId | **string**<br><p>Идентификатор виртуальной машины Cloud Compute, используемой в качестве хоста Data Proc.</p> 
hosts[].<br>role | **string**<br><p>Роль хоста в кластере.</p> <ul> <li>MASTERNODE: Подкластер выполняет роль мастера.</li> </ul> <p>Мастер может запускать следующие сервисы, в зависимости от запрошенных компонентов:</p> <ul> <li>HDFS: Namenode, Secondary Namenode</li> <li>YARN: ResourceManager, Timeline Server</li> <li>HBase Master</li> <li>Hive: Server, Metastore, HCatalog</li> <li>Spark History Server</li> <li>Zeppelin</li> <li>ZooKeeper</li> </ul> <ul> <li>DATANODE: Подкластер выполняет роль DATANODE в кластере Data Proc.</li> </ul> <p>DATANODE может запускать следующие сервисы, в зависимости от запрошенных компонентов:</p> <ul> <li>HDFS DataNode</li> <li>YARN NodeManager</li> <li>HBase RegionServer</li> <li>библиотеки Spark</li> </ul> <ul> <li>COMPUTENODE: Подкластер выполняет роль COMPUTENODE в кластере Data Proc.</li> </ul> <p>COMPUTENODE может запускать следующие сервисы, в зависимости от запрошенных компонентов:</p> <ul> <li>YARN NodeManager</li> <li>библиотеки Spark</li> </ul> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы списка. Если количество результатов больше чем <a href="/docs/data-proc/api-ref/Cluster/listHosts#query_params">pageSize</a>, используйте ``next_page_token`` в качестве значения параметра <a href="/docs/data-proc/api-ref/Cluster/listHosts#query_params">pageToken</a> в следующем запросе списка ресурсов.</p> <p>Все последующие запросы будут получать свои значения ``next_page_token`` для перебора страниц результатов.</p> 