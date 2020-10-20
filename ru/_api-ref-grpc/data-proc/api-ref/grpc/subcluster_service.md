---
editable: false
---

# SubclusterService

Набор методов для управления подкластерами Data Proc.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанный подкластер. |
| [List](#List) | Получает список подкластеров для указанного кластера. |
| [Create](#Create) | Создает новый подкластер в указанном кластере. |
| [Update](#Update) | Изменяет указанный подкластер. |
| [Delete](#Delete) | Удаляет указанный подкластер. |

## Вызовы SubclusterService {#calls}

## Get {#Get}

Возвращает указанный подкластер. <br>Чтобы получить список доступных подкластеров Data Proc, выполните запрос [SubclusterService.List](#List).

**rpc Get ([GetSubclusterRequest](#GetSubclusterRequest)) returns ([Subcluster](#Subcluster))**

### GetSubclusterRequest {#GetSubclusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Data Proc, которому принадлежит подкластер. Максимальная длина строки в символах — 50.
subcluster_id | **string**<br>Обязательное поле. Идентификатор возвращаемого подкластера. <br>Чтобы получить идентификатор подкластера, используйте запрос [SubclusterService.List](#List). Максимальная длина строки в символах — 50.


### Subcluster {#Subcluster}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор подкластера. Генерируется во время создания. 
cluster_id | **string**<br>Идентификатор кластера Data Proc, которому принадлежит подкластер. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя подкластера. Имя должно быть уникальным в кластере. Длина строки в символах должна быть от 1 до 63.
role | enum **Role**<br>Роль, которую выполняют хосты подкластера. <ul><li>`MASTERNODE`: <ul><li>HDFS: Namenode, Secondary Namenode </li><li>YARN: ResourceManager, Timeline Server </li><li>HBase Master </li><li>Hive: Server, Metastore, HCatalog </li><li>Spark History Server </li><li>Zeppelin </li><li>ZooKeeper</li></ul></li><li>`DATANODE`: <ul><li>HDFS DataNode </li><li>YARN NodeManager </li><li>HBase RegionServer </li><li>библиотеки Spark</li></ul></li><li>`COMPUTENODE`: <ul><li>YARN NodeManager </li><li>библиотеки Spark</li></ul></li><ul/>
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные для каждого хоста в подкластере. 
subnet_id | **string**<br>Идентификатор подсети VPC, используемой для хостов подкластера. 
hosts_count | **int64**<br>Количество хостов в подкластере. 


### Resources {#Resources}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [документации](/docs/data-proc/concepts/instance-types). 
disk_type_id | **string**<br><ul><li>network-hdd — сетевой HDD-диск; </li><li>network-ssd — сетевой SSD-диск.</li></ul> 
disk_size | **int64**<br>Объем хранилища, доступного хосту, в байтах. 


## List {#List}

Получает список подкластеров для указанного кластера.

**rpc List ([ListSubclustersRequest](#ListSubclustersRequest)) returns ([ListSubclustersResponse](#ListSubclustersResponse))**

### ListSubclustersRequest {#ListSubclustersRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера, для которого нужно получить список подкластеров. Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListSubclustersResponse.next_page_token](#ListSubclustersResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListSubclustersResponse.next_page_token](#ListSubclustersResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br><ol><li>Имя поля. В настоящее время фильтрация осуществляется только по полю [Subcluster.name](#Subcluster1). </li><li>Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. </li><li>Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]`. Пример фильтра: `name=dataproc123_subcluster456`.</li></ol> Максимальная длина строки в символах — 1000.


### ListSubclustersResponse {#ListSubclustersResponse}

Поле | Описание
--- | ---
subclusters[] | **[Subcluster](#Subcluster1)**<br>Список подкластеров для указанного кластера. 
next_page_token | **string**<br>Токен для получения следующей страницы списка. Если количество результатов больше чем [ListSubclustersRequest.page_size](#ListSubclustersRequest), используйте `next_page_token` в качестве значения параметра [ListSubclustersRequest.page_token](#ListSubclustersRequest) в следующем запросе списка ресурсов. <br>У каждой последующей страницы будет собственный `next_page_token`, чтобы можно было продолжать просматривать результаты. 


### Subcluster {#Subcluster1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор подкластера. Генерируется во время создания. 
cluster_id | **string**<br>Идентификатор кластера Data Proc, которому принадлежит подкластер. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя подкластера. Имя должно быть уникальным в кластере. Длина строки в символах должна быть от 1 до 63.
role | enum **Role**<br>Роль, которую выполняют хосты подкластера. <ul><li>`MASTERNODE`: <ul><li>HDFS: Namenode, Secondary Namenode </li><li>YARN: ResourceManager, Timeline Server </li><li>HBase Master </li><li>Hive: Server, Metastore, HCatalog </li><li>Spark History Server </li><li>Zeppelin </li><li>ZooKeeper</li></ul></li><li>`DATANODE`: <ul><li>HDFS DataNode </li><li>YARN NodeManager </li><li>HBase RegionServer </li><li>библиотеки Spark</li></ul></li><li>`COMPUTENODE`: <ul><li>YARN NodeManager </li><li>библиотеки Spark</li></ul></li><ul/>
resources | **[Resources](#Resources1)**<br>Ресурсы, выделенные для каждого хоста в подкластере. 
subnet_id | **string**<br>Идентификатор подсети VPC, используемой для хостов подкластера. 
hosts_count | **int64**<br>Количество хостов в подкластере. 


### Resources {#Resources1}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [документации](/docs/data-proc/concepts/instance-types). 
disk_type_id | **string**<br><ul><li>network-hdd — сетевой HDD-диск; </li><li>network-ssd — сетевой SSD-диск.</li></ul> 
disk_size | **int64**<br>Объем хранилища, доступного хосту, в байтах. 


## Create {#Create}

Создает новый подкластер в указанном кластере.

**rpc Create ([CreateSubclusterRequest](#CreateSubclusterRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateSubclusterMetadata](#CreateSubclusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Subcluster](#Subcluster2)<br>

### CreateSubclusterRequest {#CreateSubclusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Data Proc, в котором следует создать подкластер. <br>Чтобы получить идентификатор кластера, выполните запрос [ClusterService.List](./cluster_service#List). Максимальная длина строки в символах — 50.
name | **string**<br>Имя подкластера. Имя должно быть уникальным в пределах кластера. Имя не может быть изменено после того, как подкластер был создан. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
role | enum **Role**<br>Обязательное поле. Роль, которую выполняют хосты подкластера. <ul><li>`MASTERNODE`: <ul><li>HDFS: Namenode, Secondary Namenode </li><li>YARN: ResourceManager, Timeline Server </li><li>HBase Master </li><li>Hive: Server, Metastore, HCatalog </li><li>Spark History Server </li><li>Zeppelin </li><li>ZooKeeper</li></ul></li><li>`DATANODE`: <ul><li>HDFS DataNode </li><li>YARN NodeManager </li><li>HBase RegionServer </li><li>библиотеки Spark</li></ul></li><li>`COMPUTENODE`: <ul><li>YARN NodeManager </li><li>библиотеки Spark</li></ul></li><ul/>
resources | **[Resources](#Resources2)**<br>Обязательное поле. Ресурсы, выделенные для каждого хоста в подкластере. 
subnet_id | **string**<br>Обязательное поле. Идентификатор подсети VPC, используемой для хостов подкластера. Максимальная длина строки в символах — 50.
hosts_count | **int64**<br>Обязательное поле. Количество хостов в подкластере. Минимальная значение — 1.


### Resources {#Resources2}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [документации](/docs/data-proc/concepts/instance-types). 
disk_type_id | **string**<br><ul><li>network-hdd — сетевой HDD-диск; </li><li>network-ssd — сетевой SSD-диск.</li></ul> 
disk_size | **int64**<br>Объем хранилища, доступного хосту, в байтах. 


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateSubclusterMetadata](#CreateSubclusterMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Subcluster](#Subcluster2)>**<br>в случае успешного выполнения операции. 


### CreateSubclusterMetadata {#CreateSubclusterMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера, в который добавляется подкластер. Максимальная длина строки в символах — 50.
subcluster_id | **string**<br>Идентификатор создаваемого подкластера. Максимальная длина строки в символах — 50.


### Subcluster {#Subcluster2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор подкластера. Генерируется во время создания. 
cluster_id | **string**<br>Идентификатор кластера Data Proc, которому принадлежит подкластер. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя подкластера. Имя должно быть уникальным в кластере. Длина строки в символах должна быть от 1 до 63.
role | enum **Role**<br>Роль, которую выполняют хосты подкластера. <ul><li>`MASTERNODE`: <ul><li>HDFS: Namenode, Secondary Namenode </li><li>YARN: ResourceManager, Timeline Server </li><li>HBase Master </li><li>Hive: Server, Metastore, HCatalog </li><li>Spark History Server </li><li>Zeppelin </li><li>ZooKeeper</li></ul></li><li>`DATANODE`: <ul><li>HDFS DataNode </li><li>YARN NodeManager </li><li>HBase RegionServer </li><li>библиотеки Spark</li></ul></li><li>`COMPUTENODE`: <ul><li>YARN NodeManager </li><li>библиотеки Spark</li></ul></li><ul/>
resources | **[Resources](#Resources3)**<br>Ресурсы, выделенные для каждого хоста в подкластере. 
subnet_id | **string**<br>Идентификатор подсети VPC, используемой для хостов подкластера. 
hosts_count | **int64**<br>Количество хостов в подкластере. 


### Resources {#Resources3}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [документации](/docs/data-proc/concepts/instance-types). 
disk_type_id | **string**<br><ul><li>network-hdd — сетевой HDD-диск; </li><li>network-ssd — сетевой SSD-диск.</li></ul> 
disk_size | **int64**<br>Объем хранилища, доступного хосту, в байтах. 


## Update {#Update}

Изменяет указанный подкластер.

**rpc Update ([UpdateSubclusterRequest](#UpdateSubclusterRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateSubclusterMetadata](#UpdateSubclusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Subcluster](#Subcluster3)<br>

### UpdateSubclusterRequest {#UpdateSubclusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера, в котором следует изменить подкластер. <br>Чтобы получить идентификатор кластера, выполните запрос [ClusterService.List](./cluster_service#List). Максимальная длина строки в символах — 50.
subcluster_id | **string**<br>Обязательное поле. Идентификатор подкластера, который следует изменить. <br>Чтобы получить идентификатор подкластера, используйте запрос [SubclusterService.List](#List). Максимальная длина строки в символах — 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска, которая указывает, какие атрибуты подкластера должны быть изменены. 
resources | **[Resources](#Resources4)**<br>Новая конфигурация ресурсов, которые должны быть выделены для каждого хоста в подкластере. 
name | **string**<br>Новое имя подкластера. Имя должно быть уникальным в пределах кластера. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
hosts_count | **int64**<br>Обязательное поле. Новое количество хостов в подкластере. Минимальная значение — 1.


### Resources {#Resources4}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [документации](/docs/data-proc/concepts/instance-types). 
disk_type_id | **string**<br><ul><li>network-hdd — сетевой HDD-диск; </li><li>network-ssd — сетевой SSD-диск.</li></ul> 
disk_size | **int64**<br>Объем хранилища, доступного хосту, в байтах. 


### Operation {#Operation1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateSubclusterMetadata](#UpdateSubclusterMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Subcluster](#Subcluster3)>**<br>в случае успешного выполнения операции. 


### UpdateSubclusterMetadata {#UpdateSubclusterMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера, которому принадлежит изменяемый подкластер. Максимальная длина строки в символах — 50.
subcluster_id | **string**<br>Идентификатор изменяемого подкластера. Максимальная длина строки в символах — 50.


### Subcluster {#Subcluster3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор подкластера. Генерируется во время создания. 
cluster_id | **string**<br>Идентификатор кластера Data Proc, которому принадлежит подкластер. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя подкластера. Имя должно быть уникальным в кластере. Длина строки в символах должна быть от 1 до 63.
role | enum **Role**<br>Роль, которую выполняют хосты подкластера. <ul><li>`MASTERNODE`: <ul><li>HDFS: Namenode, Secondary Namenode </li><li>YARN: ResourceManager, Timeline Server </li><li>HBase Master </li><li>Hive: Server, Metastore, HCatalog </li><li>Spark History Server </li><li>Zeppelin </li><li>ZooKeeper</li></ul></li><li>`DATANODE`: <ul><li>HDFS DataNode </li><li>YARN NodeManager </li><li>HBase RegionServer </li><li>библиотеки Spark</li></ul></li><li>`COMPUTENODE`: <ul><li>YARN NodeManager </li><li>библиотеки Spark</li></ul></li><ul/>
resources | **[Resources](#Resources5)**<br>Ресурсы, выделенные для каждого хоста в подкластере. 
subnet_id | **string**<br>Идентификатор подсети VPC, используемой для хостов подкластера. 
hosts_count | **int64**<br>Количество хостов в подкластере. 


### Resources {#Resources5}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [документации](/docs/data-proc/concepts/instance-types). 
disk_type_id | **string**<br><ul><li>network-hdd — сетевой HDD-диск; </li><li>network-ssd — сетевой SSD-диск.</li></ul> 
disk_size | **int64**<br>Объем хранилища, доступного хосту, в байтах. 


## Delete {#Delete}

Удаляет указанный подкластер.

**rpc Delete ([DeleteSubclusterRequest](#DeleteSubclusterRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteSubclusterMetadata](#DeleteSubclusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteSubclusterRequest {#DeleteSubclusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера, из которого следует удалить подкластер. <br>Чтобы получить идентификатор кластера, выполните запрос [ClusterService.List](./cluster_service#List). Максимальная длина строки в символах — 50.
subcluster_id | **string**<br>Обязательное поле. Идентификатор подкластера, который следует удалить. Максимальная длина строки в символах — 50.


### Operation {#Operation2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteSubclusterMetadata](#DeleteSubclusterMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### DeleteSubclusterMetadata {#DeleteSubclusterMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера, которому принадлежит удаляемый подкластер. Максимальная длина строки в символах — 50.
subcluster_id | **string**<br>Идентификатор удаляемого подкластера. Максимальная длина строки в символах — 50.


