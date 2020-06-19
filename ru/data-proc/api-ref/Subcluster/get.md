---
editable: false
---

# Метод get
Возвращает указанный подкластер.
 
Чтобы получить список доступных подкластеров Data Proc, выполните запрос [list](/docs/data-proc/api-ref/Subcluster/list).
 
## HTTP-запрос {#https-request}
```
GET https://dataproc.api.cloud.yandex.net/dataproc/v1/clusters/{clusterId}/subclusters/{subclusterId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера Data Proc, которому принадлежит подкластер.  Максимальная длина строки в символах — 50.
subclusterId | Обязательное поле. Идентификатор возвращаемого подкластера.  Чтобы получить идентификатор подкластера, используйте запрос [list](/docs/data-proc/api-ref/Subcluster/list).  Максимальная длина строки в символах — 50.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
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
```
Подкластер Data Proc. Дополнительные сведения о концепции см. в [документации](/docs/data-proc/concepts/).
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор подкластера. Генерируется во время создания.</p> 
clusterId | **string**<br><p>Идентификатор кластера Data Proc, которому принадлежит подкластер.</p> 
createdAt | **string** (date-time)<br><p>Время создания.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
name | **string**<br><p>Имя подкластера. Имя должно быть уникальным в кластере.</p> <p>Длина строки в символах должна быть от 1 до 63.</p> 
role | **string**<br><p>Роль, которую выполняют хосты подкластера.</p> <ul> <li>MASTERNODE: Подкластер выполняет роль мастера.</li> </ul> <p>Мастер может запускать следующие сервисы, в зависимости от запрошенных компонентов:</p> <ul> <li>HDFS: Namenode, Secondary Namenode</li> <li>YARN: ResourceManager, Timeline Server</li> <li>HBase Master</li> <li>Hive: Server, Metastore, HCatalog</li> <li>Spark History Server</li> <li>Zeppelin</li> <li>ZooKeeper</li> </ul> <ul> <li>DATANODE: Подкластер выполняет роль DATANODE в кластере Data Proc.</li> </ul> <p>DATANODE может запускать следующие сервисы, в зависимости от запрошенных компонентов:</p> <ul> <li>HDFS DataNode</li> <li>YARN NodeManager</li> <li>HBase RegionServer</li> <li>библиотеки Spark</li> </ul> <ul> <li>COMPUTENODE: Подкластер выполняет роль COMPUTENODE в кластере Data Proc.</li> </ul> <p>COMPUTENODE может запускать следующие сервисы, в зависимости от запрошенных компонентов:</p> <ul> <li>YARN NodeManager</li> <li>библиотеки Spark</li> </ul> 
resources | **object**<br><p>Ресурсы, выделенные для каждого хоста в подкластере.</p> 
resources.<br>resourcePresetId | **string**<br><p>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в <a href="/docs/data-proc/concepts/instance-types">документации</a>.</p> 
resources.<br>diskTypeId | **string**<br><p>Тип хранилища для хоста. Возможные значения:</p> <ul> <li>network-hdd — сетевой HDD-диск;</li> <li>network-ssd — сетевой SSD-диск.</li> </ul> 
resources.<br>diskSize | **string** (int64)<br><p>Объем хранилища, доступного хосту, в байтах.</p> 
subnetId | **string**<br><p>Идентификатор подсети VPC, используемой для хостов подкластера.</p> 
hostsCount | **string** (int64)<br><p>Количество хостов в подкластере.</p> 