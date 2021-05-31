---
editable: false
---

# ClusterService

Набор методов для управления кластерами Data Proc.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанный кластер Data Proc. |
| [List](#List) | Возвращает список кластеров в указанном каталоге. |
| [Create](#Create) | Создает кластер в указанном каталоге. |
| [Update](#Update) | Обновляет конфигурацию указанного кластера. |
| [Delete](#Delete) | Удаляет указанный кластер. |
| [Start](#Start) | Запускает указанный кластер. |
| [Stop](#Stop) | Останавливает указанный кластер. |
| [ListOperations](#ListOperations) | Список операций для указанного кластера. |
| [ListHosts](#ListHosts) | Получает список хостов для указанного кластера. |

## Вызовы ClusterService {#calls}

## Get {#Get}

Возвращает указанный кластер Data Proc. <br>Чтобы получить список доступных кластеров Data Proc, выполните запрос [ClusterService.List](#List).

**rpc Get ([GetClusterRequest](#GetClusterRequest)) returns ([Cluster](#Cluster))**

### GetClusterRequest {#GetClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Data Proc. <br>Чтобы получить идентификатор кластера, выполните запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.


### Cluster {#Cluster}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера. Генерируется во время создания. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя кластера. Имя уникально в рамках каталога. Длина строки в символах должна быть от 1 до 63.
description | **string**<br>Описание кластера. Длина строки в символах должна быть от 0 до 256.
labels | **map<string,string>**<br>Метки кластера как пары `key:value`. Не более 64 на ресурс.
monitoring[] | **[Monitoring](#Monitoring)**<br>Описание систем мониторинга, относящихся к кластеру. 
config | **[ClusterConfig](#ClusterConfig)**<br>Конфигурация кластера. 
health | enum **Health**<br>Агрегированная работоспособность кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](#Host) для каждого хоста в кластере — UNKNOWN).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](#Host) для каждого хоста в кластере — ALIVE).</li><li>`DEAD`: Кластер не работает ([Host.health](#Host) для каждого хоста в кластере — DEAD).</li><li>`DEGRADED`: Кластер работает неоптимально ([Host.health](#Host) по крайней мере для одного хоста в кластере не ALIVE).</li><ul/>
status | enum **Status**<br>Состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: На кластере произошла ошибка, блокирующая работу.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится кластер. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта, которым пользуется агент Data Proc для управления задачами. 
bucket | **string**<br>Имя бакета Object Storage, который используется для задач Data Proc. 


### Monitoring {#Monitoring}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на систему мониторинга. 


### ClusterConfig {#ClusterConfig}

Поле | Описание
--- | ---
version_id | **string**<br>Версия образа, которая используется при подготовке кластера. Все доступные версии перечислены в [документации](/docs/managed-hadoop/concepts/image-versions). 
hadoop | **[HadoopConfig](#HadoopConfig)**<br>Настройки конфигурации, специфические для Data Proc. 


### HadoopConfig {#HadoopConfig}

Поле | Описание
--- | ---
services[] | enum **[Service](./cluster_service#undefined)**<br>Набор компонентов, используемых в кластере (если список пуст, используется набор по умолчанию). <ul><ul/>
properties | **map<string,string>**<br>Свойства, установленные для всех хостов в конфигурациях `*-site.xml`. В ключе должны быть указаны компонент и свойство. <br>Например, используйте ключ 'hdfs:dfs.replication', чтобы установить свойство `dfs.replication` в файле `/etc/hadoop/conf/hdfs-site.xml`. 
ssh_public_keys[] | **string**<br>Список публичных ключей SSH для доступа к хостам кластера. 


## List {#List}

Возвращает список кластеров в указанном каталоге.

**rpc List ([ListClustersRequest](#ListClustersRequest)) returns ([ListClustersResponse](#ListClustersResponse))**

### ListClustersRequest {#ListClustersRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога, для которого нужно получить список кластеров. <br>Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListClustersResponse.next_page_token](#ListClustersResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListClustersResponse.next_page_token](#ListClustersResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br><ol><li>Имя поля. В настоящее время фильтрация осуществляется только по полю [Cluster.name](#Cluster1). </li><li>Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. </li><li>Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]`. Пример фильтра: `name=my-cluster`.</li></ol> Максимальная длина строки в символах — 1000.


### ListClustersResponse {#ListClustersResponse}

Поле | Описание
--- | ---
clusters[] | **[Cluster](#Cluster1)**<br>Возвращает список кластеров в указанном каталоге. 
next_page_token | **string**<br>Токен для получения следующей страницы списка. Если количество результатов больше чем [ListClustersRequest.page_size](#ListClustersRequest), используйте `next_page_token` в качестве значения параметра [ListClustersRequest.page_token](#ListClustersRequest) в следующем запросе списка ресурсов. <br>У каждой последующей страницы будет собственный `next_page_token`, чтобы можно было продолжать просматривать результаты. 


### Cluster {#Cluster1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера. Генерируется во время создания. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя кластера. Имя уникально в рамках каталога. Длина строки в символах должна быть от 1 до 63.
description | **string**<br>Описание кластера. Длина строки в символах должна быть от 0 до 256.
labels | **map<string,string>**<br>Метки кластера как пары `key:value`. Не более 64 на ресурс.
monitoring[] | **[Monitoring](#Monitoring1)**<br>Описание систем мониторинга, относящихся к кластеру. 
config | **[ClusterConfig](#ClusterConfig1)**<br>Конфигурация кластера. 
health | enum **Health**<br>Агрегированная работоспособность кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](#Host) для каждого хоста в кластере — UNKNOWN).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](#Host) для каждого хоста в кластере — ALIVE).</li><li>`DEAD`: Кластер не работает ([Host.health](#Host) для каждого хоста в кластере — DEAD).</li><li>`DEGRADED`: Кластер работает неоптимально ([Host.health](#Host) по крайней мере для одного хоста в кластере не ALIVE).</li><ul/>
status | enum **Status**<br>Состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: На кластере произошла ошибка, блокирующая работу.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится кластер. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта, которым пользуется агент Data Proc для управления задачами. 
bucket | **string**<br>Имя бакета Object Storage, который используется для задач Data Proc. 


### Monitoring {#Monitoring1}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на систему мониторинга. 


### ClusterConfig {#ClusterConfig1}

Поле | Описание
--- | ---
version_id | **string**<br>Версия образа, которая используется при подготовке кластера. Все доступные версии перечислены в [документации](/docs/managed-hadoop/concepts/image-versions). 
hadoop | **[HadoopConfig](#HadoopConfig1)**<br>Настройки конфигурации, специфические для Data Proc. 


### HadoopConfig {#HadoopConfig1}

Поле | Описание
--- | ---
services[] | enum **[Service](./cluster_service#undefined)**<br>Набор компонентов, используемых в кластере (если список пуст, используется набор по умолчанию). <ul><ul/>
properties | **map<string,string>**<br>Свойства, установленные для всех хостов в конфигурациях `*-site.xml`. В ключе должны быть указаны компонент и свойство. <br>Например, используйте ключ 'hdfs:dfs.replication', чтобы установить свойство `dfs.replication` в файле `/etc/hadoop/conf/hdfs-site.xml`. 
ssh_public_keys[] | **string**<br>Список публичных ключей SSH для доступа к хостам кластера. 


## Create {#Create}

Создает кластер в указанном каталоге.

**rpc Create ([CreateClusterRequest](#CreateClusterRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateClusterMetadata](#CreateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster2)<br>

### CreateClusterRequest {#CreateClusterRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога, в котором нужно создать кластер. <br>Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). Максимальная длина строки в символах — 50.
name | **string**<br>Имя кластера. Имя должно быть уникальным в рамках каталога. Имя не может быть изменено после того, как кластер Data Proc был создан. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание кластера. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки кластера как пары `ключ: значение`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
config_spec | **[CreateClusterConfigSpec](#CreateClusterConfigSpec)**<br>Обязательное поле. Конфигурация и ресурсы хостов, которые должны быть созданы для кластера Data Proc. 
zone_id | **string**<br>Обязательное поле. Идентификатор зоны доступности, в которой должен быть размещен кластер. <br>Чтобы получить список доступных зон, отправьте запрос [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List). Максимальная длина строки в символах — 50.
service_account_id | **string**<br>Обязательное поле. Идентификатор сервисного аккаунта, которым должен пользоваться агент Data Proc для управления задачами. 
bucket | **string**<br>Имя бакета Object Storage, который следует использовать для задач Data Proc. 


### CreateClusterConfigSpec {#CreateClusterConfigSpec}

Поле | Описание
--- | ---
version_id | **string**<br>Версия образа, которая используется при подготовке кластера. <br>Все доступные версии перечислены в [документации](/docs/data-proc/concepts/image-versions). 
hadoop | **[HadoopConfig](#HadoopConfig2)**<br>Настройки, специфические для Data Proc. 
subclusters_spec[] | **[CreateSubclusterConfigSpec](#CreateSubclusterConfigSpec)**<br>Спецификация создания подкластеров. 


### HadoopConfig {#HadoopConfig2}

Поле | Описание
--- | ---
services[] | enum **[Service](./cluster_service#undefined)**<br>Набор компонентов, используемых в кластере (если список пуст, используется набор по умолчанию). <ul><ul/>
properties | **map<string,string>**<br>Свойства, установленные для всех хостов в конфигурациях `*-site.xml`. В ключе должны быть указаны компонент и свойство. <br>Например, используйте ключ 'hdfs:dfs.replication', чтобы установить свойство `dfs.replication` в файле `/etc/hadoop/conf/hdfs-site.xml`. 
ssh_public_keys[] | **string**<br>Список публичных ключей SSH для доступа к хостам кластера. 


### CreateSubclusterConfigSpec {#CreateSubclusterConfigSpec}

Поле | Описание
--- | ---
name | **string**<br>Имя подкластера. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
role | enum **Role**<br>Обязательное поле. Роль подкластера в кластере Data Proc. <ul><li>`MASTERNODE`: <ul><li>HDFS: Namenode, Secondary Namenode </li><li>YARN: ResourceManager, Timeline Server </li><li>HBase Master </li><li>Hive: Server, Metastore, HCatalog </li><li>Spark History Server </li><li>Zeppelin </li><li>ZooKeeper</li></ul></li><li>`DATANODE`: <ul><li>HDFS DataNode </li><li>YARN NodeManager </li><li>HBase RegionServer </li><li>библиотеки Spark</li></ul></li><li>`COMPUTENODE`: <ul><li>YARN NodeManager </li><li>библиотеки Spark</li></ul></li><ul/>
resources | **[Resources](#Resources)**<br>Обязательное поле. Конфигурация ресурсов для хостов в подкластере. 
subnet_id | **string**<br>Обязательное поле. Идентификатор подсети VPC, используемой для хостов подкластера. Максимальная длина строки в символах — 50.
hosts_count | **int64**<br>Обязательное поле. Количество хостов в подкластере. Минимальная значение — 1.


### Resources {#Resources}

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
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateClusterMetadata](#CreateClusterMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster2)>**<br>в случае успешного выполнения операции. 


### CreateClusterMetadata {#CreateClusterMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор создаваемого кластера. 


### Cluster {#Cluster2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера. Генерируется во время создания. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя кластера. Имя уникально в рамках каталога. Длина строки в символах должна быть от 1 до 63.
description | **string**<br>Описание кластера. Длина строки в символах должна быть от 0 до 256.
labels | **map<string,string>**<br>Метки кластера как пары `key:value`. Не более 64 на ресурс.
monitoring[] | **[Monitoring](#Monitoring2)**<br>Описание систем мониторинга, относящихся к кластеру. 
config | **[ClusterConfig](#ClusterConfig2)**<br>Конфигурация кластера. 
health | enum **Health**<br>Агрегированная работоспособность кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](#Host) для каждого хоста в кластере — UNKNOWN).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](#Host) для каждого хоста в кластере — ALIVE).</li><li>`DEAD`: Кластер не работает ([Host.health](#Host) для каждого хоста в кластере — DEAD).</li><li>`DEGRADED`: Кластер работает неоптимально ([Host.health](#Host) по крайней мере для одного хоста в кластере не ALIVE).</li><ul/>
status | enum **Status**<br>Состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: На кластере произошла ошибка, блокирующая работу.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится кластер. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта, которым пользуется агент Data Proc для управления задачами. 
bucket | **string**<br>Имя бакета Object Storage, который используется для задач Data Proc. 


### Monitoring {#Monitoring2}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на систему мониторинга. 


### ClusterConfig {#ClusterConfig2}

Поле | Описание
--- | ---
version_id | **string**<br>Версия образа, которая используется при подготовке кластера. Все доступные версии перечислены в [документации](/docs/managed-hadoop/concepts/image-versions). 
hadoop | **[HadoopConfig](#HadoopConfig3)**<br>Настройки конфигурации, специфические для Data Proc. 


### HadoopConfig {#HadoopConfig3}

Поле | Описание
--- | ---
services[] | enum **[Service](./cluster_service#undefined)**<br>Набор компонентов, используемых в кластере (если список пуст, используется набор по умолчанию). <ul><ul/>
properties | **map<string,string>**<br>Свойства, установленные для всех хостов в конфигурациях `*-site.xml`. В ключе должны быть указаны компонент и свойство. <br>Например, используйте ключ 'hdfs:dfs.replication', чтобы установить свойство `dfs.replication` в файле `/etc/hadoop/conf/hdfs-site.xml`. 
ssh_public_keys[] | **string**<br>Список публичных ключей SSH для доступа к хостам кластера. 


## Update {#Update}

Обновляет конфигурацию указанного кластера.

**rpc Update ([UpdateClusterRequest](#UpdateClusterRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterMetadata](#UpdateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster3)<br>

### UpdateClusterRequest {#UpdateClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера, который следует изменить. <br>Чтобы получить идентификатор кластера, выполните запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска поля, которая указывает, какие атрибуты кластера должны быть изменены. 
description | **string**<br>Новое описание кластера. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Новый набор меток кластера в виде пар `ключ: значение`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
config_spec | **[UpdateClusterConfigSpec](#UpdateClusterConfigSpec)**<br>Конфигурация и ресурсы хостов, которые должны быть созданы для кластера Data Proc. 
name | **string**<br>Новое имя кластера Data Proc. Имя должно быть уникальным в рамках каталога. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
service_account_id | **string**<br>Идентификатор сервисного аккаунта, которым должен пользоваться агент Data Proc для управления задачами. 
bucket | **string**<br>Имя нового бакета Object Storage, который следует использовать для задач Data Proc. 


### UpdateClusterConfigSpec {#UpdateClusterConfigSpec}

Поле | Описание
--- | ---
subclusters_spec[] | **[UpdateSubclusterConfigSpec](#UpdateSubclusterConfigSpec)**<br>Новая конфигурация для подкластеров в кластере. 


### UpdateSubclusterConfigSpec {#UpdateSubclusterConfigSpec}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор подкластера, который следует изменить. <br>Чтобы получить идентификатор подкластера, используйте запрос [SubclusterService.List](./subcluster_service#List). 
name | **string**<br>Имя подкластера. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
resources | **[Resources](#Resources1)**<br>Конфигурация ресурсов для каждого хоста в подкластере. 
hosts_count | **int64**<br>Количество хостов в подкластере. Минимальная значение — 1.


### Resources {#Resources1}

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
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateClusterMetadata](#UpdateClusterMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster3)>**<br>в случае успешного выполнения операции. 


### UpdateClusterMetadata {#UpdateClusterMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера, который изменяется. 


### Cluster {#Cluster3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера. Генерируется во время создания. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя кластера. Имя уникально в рамках каталога. Длина строки в символах должна быть от 1 до 63.
description | **string**<br>Описание кластера. Длина строки в символах должна быть от 0 до 256.
labels | **map<string,string>**<br>Метки кластера как пары `key:value`. Не более 64 на ресурс.
monitoring[] | **[Monitoring](#Monitoring3)**<br>Описание систем мониторинга, относящихся к кластеру. 
config | **[ClusterConfig](#ClusterConfig3)**<br>Конфигурация кластера. 
health | enum **Health**<br>Агрегированная работоспособность кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](#Host) для каждого хоста в кластере — UNKNOWN).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](#Host) для каждого хоста в кластере — ALIVE).</li><li>`DEAD`: Кластер не работает ([Host.health](#Host) для каждого хоста в кластере — DEAD).</li><li>`DEGRADED`: Кластер работает неоптимально ([Host.health](#Host) по крайней мере для одного хоста в кластере не ALIVE).</li><ul/>
status | enum **Status**<br>Состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: На кластере произошла ошибка, блокирующая работу.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится кластер. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта, которым пользуется агент Data Proc для управления задачами. 
bucket | **string**<br>Имя бакета Object Storage, который используется для задач Data Proc. 


### Monitoring {#Monitoring3}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на систему мониторинга. 


### ClusterConfig {#ClusterConfig3}

Поле | Описание
--- | ---
version_id | **string**<br>Версия образа, которая используется при подготовке кластера. Все доступные версии перечислены в [документации](/docs/managed-hadoop/concepts/image-versions). 
hadoop | **[HadoopConfig](#HadoopConfig4)**<br>Настройки конфигурации, специфические для Data Proc. 


### HadoopConfig {#HadoopConfig4}

Поле | Описание
--- | ---
services[] | enum **[Service](./cluster_service#undefined)**<br>Набор компонентов, используемых в кластере (если список пуст, используется набор по умолчанию). <ul><ul/>
properties | **map<string,string>**<br>Свойства, установленные для всех хостов в конфигурациях `*-site.xml`. В ключе должны быть указаны компонент и свойство. <br>Например, используйте ключ 'hdfs:dfs.replication', чтобы установить свойство `dfs.replication` в файле `/etc/hadoop/conf/hdfs-site.xml`. 
ssh_public_keys[] | **string**<br>Список публичных ключей SSH для доступа к хостам кластера. 


## Delete {#Delete}

Удаляет указанный кластер.

**rpc Delete ([DeleteClusterRequest](#DeleteClusterRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterMetadata](#DeleteClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterRequest {#DeleteClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор удаляемого кластера. <br>Чтобы получить идентификатор кластера, выполните запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.


### Operation {#Operation2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteClusterMetadata](#DeleteClusterMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### DeleteClusterMetadata {#DeleteClusterMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор удаляемого кластера Data Proc. 


## Start {#Start}

Запускает указанный кластер.

**rpc Start ([StartClusterRequest](#StartClusterRequest)) returns ([operation.Operation](#Operation3))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartClusterMetadata](#StartClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster4)<br>

### StartClusterRequest {#StartClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера, который следует запустить. <br>Чтобы получить идентификатор кластера, выполните запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.


### Operation {#Operation3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StartClusterMetadata](#StartClusterMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster4)>**<br>в случае успешного выполнения операции. 


### StartClusterMetadata {#StartClusterMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор запускаемого кластера Data Proc. 


### Cluster {#Cluster4}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера. Генерируется во время создания. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя кластера. Имя уникально в рамках каталога. Длина строки в символах должна быть от 1 до 63.
description | **string**<br>Описание кластера. Длина строки в символах должна быть от 0 до 256.
labels | **map<string,string>**<br>Метки кластера как пары `key:value`. Не более 64 на ресурс.
monitoring[] | **[Monitoring](#Monitoring4)**<br>Описание систем мониторинга, относящихся к кластеру. 
config | **[ClusterConfig](#ClusterConfig4)**<br>Конфигурация кластера. 
health | enum **Health**<br>Агрегированная работоспособность кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](#Host) для каждого хоста в кластере — UNKNOWN).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](#Host) для каждого хоста в кластере — ALIVE).</li><li>`DEAD`: Кластер не работает ([Host.health](#Host) для каждого хоста в кластере — DEAD).</li><li>`DEGRADED`: Кластер работает неоптимально ([Host.health](#Host) по крайней мере для одного хоста в кластере не ALIVE).</li><ul/>
status | enum **Status**<br>Состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: На кластере произошла ошибка, блокирующая работу.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится кластер. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта, которым пользуется агент Data Proc для управления задачами. 
bucket | **string**<br>Имя бакета Object Storage, который используется для задач Data Proc. 


### Monitoring {#Monitoring4}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на систему мониторинга. 


### ClusterConfig {#ClusterConfig4}

Поле | Описание
--- | ---
version_id | **string**<br>Версия образа, которая используется при подготовке кластера. Все доступные версии перечислены в [документации](/docs/managed-hadoop/concepts/image-versions). 
hadoop | **[HadoopConfig](#HadoopConfig5)**<br>Настройки конфигурации, специфические для Data Proc. 


### HadoopConfig {#HadoopConfig5}

Поле | Описание
--- | ---
services[] | enum **[Service](./cluster_service#undefined)**<br>Набор компонентов, используемых в кластере (если список пуст, используется набор по умолчанию). <ul><ul/>
properties | **map<string,string>**<br>Свойства, установленные для всех хостов в конфигурациях `*-site.xml`. В ключе должны быть указаны компонент и свойство. <br>Например, используйте ключ 'hdfs:dfs.replication', чтобы установить свойство `dfs.replication` в файле `/etc/hadoop/conf/hdfs-site.xml`. 
ssh_public_keys[] | **string**<br>Список публичных ключей SSH для доступа к хостам кластера. 


## Stop {#Stop}

Останавливает указанный кластер.

**rpc Stop ([StopClusterRequest](#StopClusterRequest)) returns ([operation.Operation](#Operation4))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopClusterMetadata](#StopClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster5)<br>

### StopClusterRequest {#StopClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера, который следует остановить. <br>Чтобы получить идентификатор кластера, выполните запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.


### Operation {#Operation4}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StopClusterMetadata](#StopClusterMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster5)>**<br>в случае успешного выполнения операции. 


### StopClusterMetadata {#StopClusterMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор останавливаемого кластера Data Proc. 


### Cluster {#Cluster5}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера. Генерируется во время создания. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя кластера. Имя уникально в рамках каталога. Длина строки в символах должна быть от 1 до 63.
description | **string**<br>Описание кластера. Длина строки в символах должна быть от 0 до 256.
labels | **map<string,string>**<br>Метки кластера как пары `key:value`. Не более 64 на ресурс.
monitoring[] | **[Monitoring](#Monitoring5)**<br>Описание систем мониторинга, относящихся к кластеру. 
config | **[ClusterConfig](#ClusterConfig5)**<br>Конфигурация кластера. 
health | enum **Health**<br>Агрегированная работоспособность кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](#Host) для каждого хоста в кластере — UNKNOWN).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](#Host) для каждого хоста в кластере — ALIVE).</li><li>`DEAD`: Кластер не работает ([Host.health](#Host) для каждого хоста в кластере — DEAD).</li><li>`DEGRADED`: Кластер работает неоптимально ([Host.health](#Host) по крайней мере для одного хоста в кластере не ALIVE).</li><ul/>
status | enum **Status**<br>Состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: На кластере произошла ошибка, блокирующая работу.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится кластер. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта, которым пользуется агент Data Proc для управления задачами. 
bucket | **string**<br>Имя бакета Object Storage, который используется для задач Data Proc. 


### Monitoring {#Monitoring5}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на систему мониторинга. 


### ClusterConfig {#ClusterConfig5}

Поле | Описание
--- | ---
version_id | **string**<br>Версия образа, которая используется при подготовке кластера. Все доступные версии перечислены в [документации](/docs/managed-hadoop/concepts/image-versions). 
hadoop | **[HadoopConfig](#HadoopConfig6)**<br>Настройки конфигурации, специфические для Data Proc. 


### HadoopConfig {#HadoopConfig6}

Поле | Описание
--- | ---
services[] | enum **[Service](./cluster_service#undefined)**<br>Набор компонентов, используемых в кластере (если список пуст, используется набор по умолчанию). <ul><ul/>
properties | **map<string,string>**<br>Свойства, установленные для всех хостов в конфигурациях `*-site.xml`. В ключе должны быть указаны компонент и свойство. <br>Например, используйте ключ 'hdfs:dfs.replication', чтобы установить свойство `dfs.replication` в файле `/etc/hadoop/conf/hdfs-site.xml`. 
ssh_public_keys[] | **string**<br>Список публичных ключей SSH для доступа к хостам кластера. 


## ListOperations {#ListOperations}

Список операций для указанного кластера.

**rpc ListOperations ([ListClusterOperationsRequest](#ListClusterOperationsRequest)) returns ([ListClusterOperationsResponse](#ListClusterOperationsResponse))**

### ListClusterOperationsRequest {#ListClusterOperationsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера, для которого запрашивается список операций. Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListClusterOperationsResponse {#ListClusterOperationsResponse}

Поле | Описание
--- | ---
operations[] | **[operation.Operation](#Operation5)**<br>Список операций для указанного кластера. 
next_page_token | **string**<br>Токен для получения следующей страницы списка. Если количество результатов больше чем [ListClusterOperationsRequest.page_size](#ListClusterOperationsRequest), используйте `next_page_token` в качестве значения параметра [ListClusterOperationsRequest.page_token](#ListClusterOperationsRequest) в следующем запросе списка ресурсов. <br>У каждой последующей страницы будет собственный `next_page_token`, чтобы можно было продолжать просматривать результаты. 


### Operation {#Operation5}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>Результат операции в случае успешного завершения. Если исходный метод не возвращает никаких данных при успешном завершении, например метод Delete, поле содержит объект [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty). Если исходный метод — это стандартный метод Create / Update, поле содержит целевой ресурс операции. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `response`. 


## ListHosts {#ListHosts}

Получает список хостов для указанного кластера.

**rpc ListHosts ([ListClusterHostsRequest](#ListClusterHostsRequest)) returns ([ListClusterHostsResponse](#ListClusterHostsResponse))**

### ListClusterHostsRequest {#ListClusterHostsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера, для которого запрашивается список хостов. <br>Чтобы получить идентификатор кластера, выполните запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br><ol><li>Имя поля. В настоящее время фильтрация осуществляется только по полю [Cluster.name](#Cluster6). </li><li>Оператор. Может быть `=` или `!=` для отдельных значений, `IN` или `NOT IN` для списков значений. </li><li>Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]`. Пример фильтра: `name=my-host`.</li></ol> Максимальная длина строки в символах — 1000.


### ListClusterHostsResponse {#ListClusterHostsResponse}

Поле | Описание
--- | ---
hosts[] | **[Host](#Host)**<br>Запрошенный список хостов. 
next_page_token | **string**<br>Токен для получения следующей страницы списка. Если количество результатов больше чем [ListClusterHostsRequest.page_size](#ListClusterHostsRequest), используйте `next_page_token` в качестве значения параметра [ListClusterHostsRequest.page_token](#ListClusterHostsRequest) в следующем запросе списка ресурсов. <br>Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Host {#Host}

Поле | Описание
--- | ---
name | **string**<br>Имя хоста Data Proc. Data Proc генерирует имя хоста при его создании, после этого имя невозможно изменить. Имя уникально для всех существующих хостов Data Proc в Яндекс.Облаке, так как оно определяет полное доменное имя (FQDN) хоста. 
subcluster_id | **string**<br>Идентификатор подкластера Data Proc, которому принадлежит хост. 
health | enum **Health**<br>Код состояния хоста. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](#Host) для каждого хоста в кластере — UNKNOWN).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](#Host) для каждого хоста в кластере — ALIVE).</li><li>`DEAD`: Кластер не работает ([Host.health](#Host) для каждого хоста в кластере — DEAD).</li><li>`DEGRADED`: Кластер работает неоптимально ([Host.health](#Host) по крайней мере для одного хоста в кластере не ALIVE).</li><ul/>
compute_instance_id | **string**<br>Идентификатор виртуальной машины Cloud Compute, используемой в качестве хоста Data Proc. 
role | enum **Role**<br>Роль хоста в кластере. <ul><li>`MASTERNODE`: <ul><li>HDFS: Namenode, Secondary Namenode </li><li>YARN: ResourceManager, Timeline Server </li><li>HBase Master </li><li>Hive: Server, Metastore, HCatalog </li><li>Spark History Server </li><li>Zeppelin </li><li>ZooKeeper</li></ul></li><li>`DATANODE`: <ul><li>HDFS DataNode </li><li>YARN NodeManager </li><li>HBase RegionServer </li><li>библиотеки Spark</li></ul></li><li>`COMPUTENODE`: <ul><li>YARN NodeManager </li><li>библиотеки Spark</li></ul></li><ul/>


