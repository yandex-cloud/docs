---
editable: false
---

# Метод list
Получает список подкластеров для указанного кластера.
 

 
## HTTP-запрос {#https-request}
```
GET https://dataproc.api.cloud.yandex.net/dataproc/v1/clusters/{clusterId}/subclusters
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера, для которого нужно получить список подкластеров.  Максимальная длина строки в символах — 50.
 
## Query-параметры {#query_params}
 
Параметр | Описание
--- | ---
pageSize | Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [nextPageToken](/docs/data-proc/api-ref/Subcluster/list#responses), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100.  Максимальное значение — 1000.
pageToken | Токен страницы. Установите значение `page_token` равным значению поля [nextPageToken](/docs/data-proc/api-ref/Subcluster/list#responses) предыдущего запроса, чтобы получить следующую страницу результатов.  Максимальная длина строки в символах — 100.
filter | Параметры фильтрации подкластеров в ответе.  В параметрах фильтрации указываются: 1. Имя поля. В настоящее время фильтрация осуществляется только по полю [Subcluster.name](/docs/data-proc/api-ref/Subcluster#representation). 2. Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. 3. Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]`. Пример фильтра: `name=dataproc123_subcluster456`.  Максимальная длина строки в символах — 1000.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "subclusters": [
    {
      "id": "string",
      "clusterId": "string",
      "createdAt": "string",
      "name": "string",
      "role": "string",
      "resources": {
        "resourcePresetId": "string",
        "diskTypeId": "string",
        "diskSize": "string"
      },
      "subnetId": "string",
      "hostsCount": "string"
    }
  ],
  "nextPageToken": "string"
}
```

 
Поле | Описание
--- | ---
subclusters[] | **object**<br><p>Подкластер Data Proc. Дополнительные сведения о концепции см. в <a href="/docs/data-proc/concepts/">документации</a>.</p> 
subclusters[].<br>id | **string**<br><p>Идентификатор подкластера. Генерируется во время создания.</p> 
subclusters[].<br>clusterId | **string**<br><p>Идентификатор кластера Data Proc, которому принадлежит подкластер.</p> 
subclusters[].<br>createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
subclusters[].<br>name | **string**<br><p>Имя подкластера. Имя должно быть уникальным в кластере.</p> <p>Длина строки в символах должна быть от 1 до 63.</p> 
subclusters[].<br>role | **string**<br><p>Роль, которую выполняют хосты подкластера.</p> <ul> <li>MASTERNODE: Подкластер выполняет роль мастера.</li> </ul> <p>Мастер может запускать следующие сервисы, в зависимости от запрошенных компонентов:</p> <ul> <li>HDFS: Namenode, Secondary Namenode</li> <li>YARN: ResourceManager, Timeline Server</li> <li>HBase Master</li> <li>Hive: Server, Metastore, HCatalog</li> <li>Spark History Server</li> <li>Zeppelin</li> <li>ZooKeeper</li> </ul> <ul> <li>DATANODE: Подкластер выполняет роль DATANODE в кластере Data Proc.</li> </ul> <p>DATANODE может запускать следующие сервисы, в зависимости от запрошенных компонентов:</p> <ul> <li>HDFS DataNode</li> <li>YARN NodeManager</li> <li>HBase RegionServer</li> <li>библиотеки Spark</li> </ul> <ul> <li>COMPUTENODE: Подкластер выполняет роль COMPUTENODE в кластере Data Proc.</li> </ul> <p>COMPUTENODE может запускать следующие сервисы, в зависимости от запрошенных компонентов:</p> <ul> <li>YARN NodeManager</li> <li>библиотеки Spark</li> </ul> 
subclusters[].<br>resources | **object**<br><p>Ресурсы, выделенные для каждого хоста в подкластере.</p> 
subclusters[].<br>resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/data-proc/concepts/instance-types">документации</a>.</p> 
subclusters[].<br>resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>network-hdd — сетевой HDD-диск;</li> <li>network-ssd — сетевой SSD-диск.</li> </ul> 
subclusters[].<br>resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
subclusters[].<br>subnetId | **string**<br><p>Идентификатор подсети VPC, используемой для хостов подкластера.</p> 
subclusters[].<br>hostsCount | **string** (int64)<br><p>Количество хостов в подкластере.</p> 
nextPageToken | **string**<br><p>Токен для получения следующей страницы списка. Если количество результатов больше чем <a href="/docs/data-proc/api-ref/Subcluster/list#query_params">pageSize</a>, используйте ``next_page_token`` в качестве значения параметра <a href="/docs/data-proc/api-ref/Subcluster/list#query_params">pageToken</a> в следующем запросе списка ресурсов.</p> <p>У каждой последующей страницы будет собственный ``next_page_token``, чтобы можно было продолжать просматривать результаты.</p> 