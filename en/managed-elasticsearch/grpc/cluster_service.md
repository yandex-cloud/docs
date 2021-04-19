---
editable: false
---

# ClusterService

Набор методов для управления кластерами Elasticsearch.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанный кластер Elasticsearch. |
| [List](#List) | Получает список кластеров Elasticsearch, принадлежащих указанному каталогу. |
| [Create](#Create) | Создает новый кластер Elasticsearch в указанном каталоге. |
| [Update](#Update) | Изменяет указанный кластер Elasticsearch. |
| [Delete](#Delete) | Удаляет указанный кластер Elasticsearch. |
| [Move](#Move) | Перемещает кластер Elasticsearch в указанный каталог. |
| [Start](#Start) | Запускает указанный кластер Elasticsearch. |
| [Stop](#Stop) | Останавливает указанный кластер Elasticsearch. |
| [ListLogs](#ListLogs) | Получает логи для указанного кластера Elasticsearch. |
| [StreamLogs](#StreamLogs) | То же самое, что [ListLogs](#ListLogs), с той разницей, что со стороны сервера передается поток логов. |
| [ListOperations](#ListOperations) | Получает список операций для указанного кластера Elasticsearch. |
| [ListHosts](#ListHosts) | Получает список хостов для указанного кластера Elasticsearch. |
| [AddHosts](#AddHosts) | Добавляет новые хосты в указанный кластер Elasticsearch. |
| [DeleteHosts](#DeleteHosts) | Удаляет хосты из указанного кластера Elasticsearch. |

## Вызовы ClusterService {#calls}

## Get {#Get}

Возвращает указанный кластер Elasticsearch. <br>Чтобы получить список доступных кластеров Elasticsearch, выполните запрос [List](#List).

**rpc Get ([GetClusterRequest](#GetClusterRequest)) returns ([Cluster](#Cluster))**

### GetClusterRequest {#GetClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Elasticsearch. <br>Чтобы получить идентификатор кластера, выполните запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.


### Cluster {#Cluster}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера Elasticsearch. Этот идентификатор генерируется при создании кластера. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер Elasticsearch. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя кластера Elasticsearch. Имя должно быть уникальным в рамках каталога. Длина 1-63 символов. 
description | **string**<br>Описание кластера Elasticsearch. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера Elasticsearch в виде пар `key:value`. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания кластера Elasticsearch. <ul><li>`PRODUCTION`: стабильная среда с осторожной политикой обновления — во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: среда с более агрессивной политикой обновления — новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring)**<br>Описание систем мониторинга, относящихся к кластеру Elasticsearch. 
config | **[ClusterConfig](#ClusterConfig)**<br>Конфигурация кластера Elasticsearch. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Здоровье кластера. <ul><li>`HEALTH_UNKNOWN`: состояние кластера неизвестно ([Host.health](#Host) всех хостов в кластере — `UNKNOWN`).</li><li>`ALIVE`: кластер работает нормально ([Host.health](#Host) всех хостов в кластере — `ALIVE`).</li><li>`DEAD`: кластер не работает ([Host.health](#Host) всех хостов в кластере — `DEAD`).</li><li>`DEGRADED`: кластер находится в состоянии деградации ([Host.health](#Host) по крайней мере одного из хостов в кластере — не `ALIVE`).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: состояние кластера неизвестно.</li><li>`CREATING`: кластер создается.</li><li>`RUNNING`: кластер работает нормально.</li><li>`ERROR`: в кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: кластер изменяется.</li><li>`STOPPING`: кластер останавливается.</li><li>`STOPPED`: кластер остановлен.</li><li>`STARTING`: кластер запускается.</li><ul/>


### Monitoring {#Monitoring}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для кластера Elasticsearch. 


### ClusterConfig {#ClusterConfig}

Поле | Описание
--- | ---
version | **string**<br>Версия Elasticsearch. 
elasticsearch | **[Elasticsearch](#Elasticsearch)**<br>Конфигурация и распределение ресурсов для узлов Elasticsearch. 


### Elasticsearch {#Elasticsearch}

Поле | Описание
--- | ---
data_node | **[DataNode](#DataNode)**<br>Конфигурация и распределение ресурсов для узлов Elasticsearch с ролью Data node. 
master_node | **[MasterNode](#MasterNode)**<br>Конфигурация и распределение ресурсов для узлов Elasticsearch с ролью Master node. 


### DataNode {#DataNode}

Поле | Описание
--- | ---
config | **oneof:** `elasticsearch_config_set_7_6`<br>
&nbsp;&nbsp;elasticsearch_config_set_7_6 | **[config.ElasticsearchConfigSet7_6](#ElasticsearchConfigSet7_6)**<br>Конфигурация Elasticsearch 7.6 для узла с ролью Data node. 
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные узлам Elasticsearch с ролью Data node. 


### MasterNode {#MasterNode}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные узлам Elasticsearch с ролью Master node. 


## List {#List}

Получает список кластеров Elasticsearch, принадлежащих указанному каталогу.

**rpc List ([ListClustersRequest](#ListClustersRequest)) returns ([ListClustersResponse](#ListClustersResponse))**

### ListClustersRequest {#ListClustersRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога, для которого нужно получить список кластеров Elasticsearch. <br>Чтобы получить идентификатор каталога, выполните запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/grpc/folder_service#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на одной странице в ответе. Если количество результатов больше чем `page_size`, сервис вернет значение [ListClustersResponse.next_page_token](#ListClustersResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListClustersResponse.next_page_token](#ListClustersResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br><ol><li>Имя поля, по которому нужно выполнить фильтрацию. В настоящее время фильтрацию можно использовать только по полю [Cluster.name](#Cluster1). </li><li>Условный оператор. Поддерживаются операторы `=` и `!=` для одиночных значений, `IN` и `NOT IN` для списков значений. </li><li>Значение. Должно содержать от 1 до 63 символов и соответствовать регулярному выражению `^[a-zA-Z0-9_-]+$`. </li></ol> Максимальная длина строки в символах — 1000.


### ListClustersResponse {#ListClustersResponse}

Поле | Описание
--- | ---
clusters[] | **[Cluster](#Cluster1)**<br>Список кластеров Elasticsearch. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. <br>Если количество результатов больше чем [ListClustersRequest.page_size](#ListClustersRequest), используйте `next_page_token` в качестве значения параметра [ListClustersRequest.page_token](#ListClustersRequest) в следующем запросе. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Cluster {#Cluster1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера Elasticsearch. Этот идентификатор генерируется при создании кластера. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер Elasticsearch. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя кластера Elasticsearch. Имя должно быть уникальным в рамках каталога. Длина 1-63 символов. 
description | **string**<br>Описание кластера Elasticsearch. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера Elasticsearch в виде пар `key:value`. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания кластера Elasticsearch. <ul><li>`PRODUCTION`: стабильная среда с осторожной политикой обновления — во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: среда с более агрессивной политикой обновления — новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring1)**<br>Описание систем мониторинга, относящихся к кластеру Elasticsearch. 
config | **[ClusterConfig](#ClusterConfig1)**<br>Конфигурация кластера Elasticsearch. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Здоровье кластера. <ul><li>`HEALTH_UNKNOWN`: состояние кластера неизвестно ([Host.health](#Host) всех хостов в кластере — `UNKNOWN`).</li><li>`ALIVE`: кластер работает нормально ([Host.health](#Host) всех хостов в кластере — `ALIVE`).</li><li>`DEAD`: кластер не работает ([Host.health](#Host) всех хостов в кластере — `DEAD`).</li><li>`DEGRADED`: кластер находится в состоянии деградации ([Host.health](#Host) по крайней мере одного из хостов в кластере — не `ALIVE`).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: состояние кластера неизвестно.</li><li>`CREATING`: кластер создается.</li><li>`RUNNING`: кластер работает нормально.</li><li>`ERROR`: в кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: кластер изменяется.</li><li>`STOPPING`: кластер останавливается.</li><li>`STOPPED`: кластер остановлен.</li><li>`STARTING`: кластер запускается.</li><ul/>


### Monitoring {#Monitoring1}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для кластера Elasticsearch. 


### ClusterConfig {#ClusterConfig1}

Поле | Описание
--- | ---
version | **string**<br>Версия Elasticsearch. 
elasticsearch | **[Elasticsearch](#Elasticsearch1)**<br>Конфигурация и распределение ресурсов для узлов Elasticsearch. 


### Elasticsearch {#Elasticsearch1}

Поле | Описание
--- | ---
data_node | **[DataNode](#DataNode1)**<br>Конфигурация и распределение ресурсов для узлов Elasticsearch с ролью Data node. 
master_node | **[MasterNode](#MasterNode1)**<br>Конфигурация и распределение ресурсов для узлов Elasticsearch с ролью Master node. 


### DataNode {#DataNode1}

Поле | Описание
--- | ---
config | **oneof:** `elasticsearch_config_set_7_6`<br>
&nbsp;&nbsp;elasticsearch_config_set_7_6 | **[config.ElasticsearchConfigSet7_6](#ElasticsearchConfigSet7_6)**<br>Конфигурация Elasticsearch 7.6 для узла с ролью Data node. 
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные узлам Elasticsearch с ролью Data node. 


### MasterNode {#MasterNode1}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные узлам Elasticsearch с ролью Master node. 


## Create {#Create}

Создает новый кластер Elasticsearch в указанном каталоге.

**rpc Create ([CreateClusterRequest](#CreateClusterRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateClusterMetadata](#CreateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster2)<br>

### CreateClusterRequest {#CreateClusterRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога, в котором будет создан кластер Elasticsearch. Максимальная длина строки в символах — 50.
name | **string**<br>Обязательное поле. Имя кластера Elasticsearch. Имя должно быть уникальным в рамках каталога. Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.
description | **string**<br>Описание кластера Elasticsearch. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Пользовательские метки для кластера Elasticsearch в виде пар `key:value`. <br>Например, "project": "mvp" или "source": "dictionary". Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
environment | **[Cluster.Environment](#Cluster2)**<br>Среда развертывания кластера Elasticsearch. 
config_spec | **[ConfigSpec](#ConfigSpec)**<br>Обязательное поле. Конфигурация Elasticsearch и хостов для кластера. 
user_specs[] | **[UserSpec](#UserSpec)**<br>Одно или несколько описаний пользователей, которых нужно создать в кластере Elasticsearch. Количество элементов должно быть больше 0.
host_specs[] | **[HostSpec](#HostSpec)**<br>Одна или несколько конфигураций хостов, создаваемых в кластере Elasticsearch. Количество элементов должно быть больше 0.
network_id | **string**<br>Обязательное поле. Идентификатор сети, в которой будет создан кластер Elasticsearch. Максимальная длина строки в символах — 50.


### ConfigSpec {#ConfigSpec}

Поле | Описание
--- | ---
version | **string**<br>Версия Elasticsearch. 
elasticsearch_spec | **[ElasticsearchSpec](#ElasticsearchSpec)**<br>Конфигурация и распределение ресурсов для узлов Elasticsearch. 


### ElasticsearchSpec {#ElasticsearchSpec}

Поле | Описание
--- | ---
data_node | **[DataNode](#DataNode2)**<br>Конфигурация и распределение ресурсов для узлов Elasticsearch с ролью Data node. 
master_node | **[MasterNode](#MasterNode2)**<br>Конфигурация и распределение ресурсов для узлов Elasticsearch с ролью Master node. 


### DataNode {#DataNode2}

Поле | Описание
--- | ---
config | **oneof:** `elasticsearch_config_7_6`<br>Конфигурация Elasticsearch для узла с ролью Data node.
&nbsp;&nbsp;elasticsearch_config_7_6 | **[config.ElasticsearchConfig7_6](#ElasticsearchConfig7_6)**<br>Конфигурация Elasticsearch для узла с ролью Data node. 
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные узлам Elasticsearch с ролью Data node. 


### MasterNode {#MasterNode2}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные узлам Elasticsearch с ролью Master node. 


### UserSpec {#UserSpec}

Поле | Описание
--- | ---
name | **string**<br>Обязательное поле. Имя пользователя Elasticsearch. Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.
password | **string**<br>Обязательное поле. Пароль пользователя Elasticsearch. Длина строки в символах должна быть от 8 до 128.


### HostSpec {#HostSpec}

Поле | Описание
--- | ---
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится хост. Максимальная длина строки в символах — 50.
subnet_id | **string**<br>Идентификатор подсети, в которой находится хост. Максимальная длина строки в символах — 50.
assign_public_ip | **bool**<br>Флаг, определяющий, назначен ли хосту публичный IP-адрес. <br>Если значение равно `true`, то этот хост доступен в Интернете через его публичный IP-адрес. 
type | **[Host.Type](#Host)**<br>Обязательное поле. Тип хоста. 
shard_name | **string**<br>Имя шарда, который нужно создать на хосте. Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.


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
cluster_id | **string**<br>Идентификатор создаваемого кластера Elasticsearch. 


### Cluster {#Cluster2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера Elasticsearch. Этот идентификатор генерируется при создании кластера. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер Elasticsearch. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя кластера Elasticsearch. Имя должно быть уникальным в рамках каталога. Длина 1-63 символов. 
description | **string**<br>Описание кластера Elasticsearch. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера Elasticsearch в виде пар `key:value`. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания кластера Elasticsearch. <ul><li>`PRODUCTION`: стабильная среда с осторожной политикой обновления — во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: среда с более агрессивной политикой обновления — новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Описание систем мониторинга, относящихся к кластеру Elasticsearch. 
config | **[ClusterConfig](#ClusterConfig2)**<br>Конфигурация кластера Elasticsearch. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Здоровье кластера. <ul><li>`HEALTH_UNKNOWN`: состояние кластера неизвестно ([Host.health](#Host) всех хостов в кластере — `UNKNOWN`).</li><li>`ALIVE`: кластер работает нормально ([Host.health](#Host) всех хостов в кластере — `ALIVE`).</li><li>`DEAD`: кластер не работает ([Host.health](#Host) всех хостов в кластере — `DEAD`).</li><li>`DEGRADED`: кластер находится в состоянии деградации ([Host.health](#Host) по крайней мере одного из хостов в кластере — не `ALIVE`).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: состояние кластера неизвестно.</li><li>`CREATING`: кластер создается.</li><li>`RUNNING`: кластер работает нормально.</li><li>`ERROR`: в кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: кластер изменяется.</li><li>`STOPPING`: кластер останавливается.</li><li>`STOPPED`: кластер остановлен.</li><li>`STARTING`: кластер запускается.</li><ul/>


### Monitoring {#Monitoring2}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для кластера Elasticsearch. 


### ClusterConfig {#ClusterConfig2}

Поле | Описание
--- | ---
version | **string**<br>Версия Elasticsearch. 
elasticsearch | **[Elasticsearch](#Elasticsearch2)**<br>Конфигурация и распределение ресурсов для узлов Elasticsearch. 


### Elasticsearch {#Elasticsearch2}

Поле | Описание
--- | ---
data_node | **[DataNode](#DataNode3)**<br>Конфигурация и распределение ресурсов для узлов Elasticsearch с ролью Data node. 
master_node | **[MasterNode](#MasterNode3)**<br>Конфигурация и распределение ресурсов для узлов Elasticsearch с ролью Master node. 


### DataNode {#DataNode3}

Поле | Описание
--- | ---
config | **oneof:** `elasticsearch_config_set_7_6`<br>
&nbsp;&nbsp;elasticsearch_config_set_7_6 | **[config.ElasticsearchConfigSet7_6](#ElasticsearchConfigSet7_6)**<br>Конфигурация Elasticsearch 7.6 для узла с ролью Data node. 
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные узлам Elasticsearch с ролью Data node. 


### MasterNode {#MasterNode3}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные узлам Elasticsearch с ролью Master node. 


## Update {#Update}

Изменяет указанный кластер Elasticsearch.

**rpc Update ([UpdateClusterRequest](#UpdateClusterRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterMetadata](#UpdateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster3)<br>

### UpdateClusterRequest {#UpdateClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Elasticsearch, который нужно изменить. <br>Чтобы получить идентификатор кластера Elasticsearch, выполните запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
description | **string**<br>Новое описание кластера Elasticsearch. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Пользовательские метки для кластера Elasticsearch в виде пар `key:value`. <br>Например, "project": "mvp" или "source": "dictionary". <br>Новый набор меток полностью заменит старый. Чтобы добавить метку, запросите текущий набор меток с помощью метода [ClusterService.Get](#Get), затем отправьте запрос [ClusterService.Update](#Update), добавив новую метку в этот набор. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
config_spec | **[ConfigSpec](#ConfigSpec)**<br>Новая конфигурация и ресурсы для хостов кластера Elasticsearch. <br>Используйте параметр `update_mask` чтобы предотвратить сброс настроек кластера, не перечисленных в `config_spec`, на значения по умолчанию. 
name | **string**<br>Новое имя кластера Elasticsearch. Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.


### ConfigSpec {#ConfigSpec1}

Поле | Описание
--- | ---
version | **string**<br>Версия Elasticsearch. 
elasticsearch_spec | **[ElasticsearchSpec](#ElasticsearchSpec)**<br>Конфигурация и распределение ресурсов для узлов Elasticsearch. 


### ElasticsearchSpec {#ElasticsearchSpec1}

Поле | Описание
--- | ---
data_node | **[DataNode](#DataNode4)**<br>Конфигурация и распределение ресурсов для узлов Elasticsearch с ролью Data node. 
master_node | **[MasterNode](#MasterNode4)**<br>Конфигурация и распределение ресурсов для узлов Elasticsearch с ролью Master node. 


### DataNode {#DataNode4}

Поле | Описание
--- | ---
config | **oneof:** `elasticsearch_config_7_6`<br>Конфигурация Elasticsearch для узла с ролью Data node.
&nbsp;&nbsp;elasticsearch_config_7_6 | **[config.ElasticsearchConfig7_6](#ElasticsearchConfig7_6)**<br>Конфигурация Elasticsearch для узла с ролью Data node. 
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные узлам Elasticsearch с ролью Data node. 


### MasterNode {#MasterNode4}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные узлам Elasticsearch с ролью Master node. 


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
cluster_id | **string**<br>Идентификатор изменяемого кластера Elasticsearch. 


### Cluster {#Cluster3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера Elasticsearch. Этот идентификатор генерируется при создании кластера. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер Elasticsearch. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя кластера Elasticsearch. Имя должно быть уникальным в рамках каталога. Длина 1-63 символов. 
description | **string**<br>Описание кластера Elasticsearch. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера Elasticsearch в виде пар `key:value`. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания кластера Elasticsearch. <ul><li>`PRODUCTION`: стабильная среда с осторожной политикой обновления — во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: среда с более агрессивной политикой обновления — новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring3)**<br>Описание систем мониторинга, относящихся к кластеру Elasticsearch. 
config | **[ClusterConfig](#ClusterConfig3)**<br>Конфигурация кластера Elasticsearch. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Здоровье кластера. <ul><li>`HEALTH_UNKNOWN`: состояние кластера неизвестно ([Host.health](#Host) всех хостов в кластере — `UNKNOWN`).</li><li>`ALIVE`: кластер работает нормально ([Host.health](#Host) всех хостов в кластере — `ALIVE`).</li><li>`DEAD`: кластер не работает ([Host.health](#Host) всех хостов в кластере — `DEAD`).</li><li>`DEGRADED`: кластер находится в состоянии деградации ([Host.health](#Host) по крайней мере одного из хостов в кластере — не `ALIVE`).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: состояние кластера неизвестно.</li><li>`CREATING`: кластер создается.</li><li>`RUNNING`: кластер работает нормально.</li><li>`ERROR`: в кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: кластер изменяется.</li><li>`STOPPING`: кластер останавливается.</li><li>`STOPPED`: кластер остановлен.</li><li>`STARTING`: кластер запускается.</li><ul/>


### Monitoring {#Monitoring3}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для кластера Elasticsearch. 


### ClusterConfig {#ClusterConfig3}

Поле | Описание
--- | ---
version | **string**<br>Версия Elasticsearch. 
elasticsearch | **[Elasticsearch](#Elasticsearch3)**<br>Конфигурация и распределение ресурсов для узлов Elasticsearch. 


### Elasticsearch {#Elasticsearch3}

Поле | Описание
--- | ---
data_node | **[DataNode](#DataNode5)**<br>Конфигурация и распределение ресурсов для узлов Elasticsearch с ролью Data node. 
master_node | **[MasterNode](#MasterNode5)**<br>Конфигурация и распределение ресурсов для узлов Elasticsearch с ролью Master node. 


### DataNode {#DataNode5}

Поле | Описание
--- | ---
config | **oneof:** `elasticsearch_config_set_7_6`<br>
&nbsp;&nbsp;elasticsearch_config_set_7_6 | **[config.ElasticsearchConfigSet7_6](#ElasticsearchConfigSet7_6)**<br>Конфигурация Elasticsearch 7.6 для узла с ролью Data node. 
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные узлам Elasticsearch с ролью Data node. 


### MasterNode {#MasterNode5}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные узлам Elasticsearch с ролью Master node. 


## Delete {#Delete}

Удаляет указанный кластер Elasticsearch.

**rpc Delete ([DeleteClusterRequest](#DeleteClusterRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterMetadata](#DeleteClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterRequest {#DeleteClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор удаляемого кластера Elasticsearch. <br>Чтобы получить идентификатор кластера Elasticsearch, выполните запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.


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
cluster_id | **string**<br>Идентификатор удаляемого кластера Elasticsearch. 


## Move {#Move}

Перемещает кластер Elasticsearch в указанный каталог.

**rpc Move ([MoveClusterRequest](#MoveClusterRequest)) returns ([operation.Operation](#Operation3))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[MoveClusterMetadata](#MoveClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster4)<br>

### MoveClusterRequest {#MoveClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Elasticsearch, который нужно переместить. <br>Чтобы получить идентификатор кластера Elasticsearch, выполните запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
destination_folder_id | **string**<br>Обязательное поле. Идентификатор каталога, в который следует переместить кластер. Максимальная длина строки в символах — 50.


### Operation {#Operation3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[MoveClusterMetadata](#MoveClusterMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster4)>**<br>в случае успешного выполнения операции. 


### MoveClusterMetadata {#MoveClusterMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор перемещаемого кластера Elasticsearch. 
source_folder_id | **string**<br>Идентификатор исходного каталога. 
destination_folder_id | **string**<br>Идентификатор каталога, в который следует переместить кластер. 


### Cluster {#Cluster4}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера Elasticsearch. Этот идентификатор генерируется при создании кластера. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер Elasticsearch. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя кластера Elasticsearch. Имя должно быть уникальным в рамках каталога. Длина 1-63 символов. 
description | **string**<br>Описание кластера Elasticsearch. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера Elasticsearch в виде пар `key:value`. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания кластера Elasticsearch. <ul><li>`PRODUCTION`: стабильная среда с осторожной политикой обновления — во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: среда с более агрессивной политикой обновления — новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring4)**<br>Описание систем мониторинга, относящихся к кластеру Elasticsearch. 
config | **[ClusterConfig](#ClusterConfig4)**<br>Конфигурация кластера Elasticsearch. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Здоровье кластера. <ul><li>`HEALTH_UNKNOWN`: состояние кластера неизвестно ([Host.health](#Host) всех хостов в кластере — `UNKNOWN`).</li><li>`ALIVE`: кластер работает нормально ([Host.health](#Host) всех хостов в кластере — `ALIVE`).</li><li>`DEAD`: кластер не работает ([Host.health](#Host) всех хостов в кластере — `DEAD`).</li><li>`DEGRADED`: кластер находится в состоянии деградации ([Host.health](#Host) по крайней мере одного из хостов в кластере — не `ALIVE`).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: состояние кластера неизвестно.</li><li>`CREATING`: кластер создается.</li><li>`RUNNING`: кластер работает нормально.</li><li>`ERROR`: в кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: кластер изменяется.</li><li>`STOPPING`: кластер останавливается.</li><li>`STOPPED`: кластер остановлен.</li><li>`STARTING`: кластер запускается.</li><ul/>


### Monitoring {#Monitoring4}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для кластера Elasticsearch. 


### ClusterConfig {#ClusterConfig4}

Поле | Описание
--- | ---
version | **string**<br>Версия Elasticsearch. 
elasticsearch | **[Elasticsearch](#Elasticsearch4)**<br>Конфигурация и распределение ресурсов для узлов Elasticsearch. 


### Elasticsearch {#Elasticsearch4}

Поле | Описание
--- | ---
data_node | **[DataNode](#DataNode6)**<br>Конфигурация и распределение ресурсов для узлов Elasticsearch с ролью Data node. 
master_node | **[MasterNode](#MasterNode6)**<br>Конфигурация и распределение ресурсов для узлов Elasticsearch с ролью Master node. 


### DataNode {#DataNode6}

Поле | Описание
--- | ---
config | **oneof:** `elasticsearch_config_set_7_6`<br>
&nbsp;&nbsp;elasticsearch_config_set_7_6 | **[config.ElasticsearchConfigSet7_6](#ElasticsearchConfigSet7_6)**<br>Конфигурация Elasticsearch 7.6 для узла с ролью Data node. 
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные узлам Elasticsearch с ролью Data node. 


### MasterNode {#MasterNode6}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные узлам Elasticsearch с ролью Master node. 


## Start {#Start}

Запускает указанный кластер Elasticsearch.

**rpc Start ([StartClusterRequest](#StartClusterRequest)) returns ([operation.Operation](#Operation4))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartClusterMetadata](#StartClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster5)<br>

### StartClusterRequest {#StartClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Elasticsearch, который нужно запустить. <br>Чтобы получить идентификатор кластера Elasticsearch, выполните запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.


### Operation {#Operation4}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster5)>**<br>в случае успешного выполнения операции. 


### StartClusterMetadata {#StartClusterMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера Elasticsearch. 


### Cluster {#Cluster5}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера Elasticsearch. Этот идентификатор генерируется при создании кластера. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер Elasticsearch. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя кластера Elasticsearch. Имя должно быть уникальным в рамках каталога. Длина 1-63 символов. 
description | **string**<br>Описание кластера Elasticsearch. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера Elasticsearch в виде пар `key:value`. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания кластера Elasticsearch. <ul><li>`PRODUCTION`: стабильная среда с осторожной политикой обновления — во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: среда с более агрессивной политикой обновления — новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring5)**<br>Описание систем мониторинга, относящихся к кластеру Elasticsearch. 
config | **[ClusterConfig](#ClusterConfig5)**<br>Конфигурация кластера Elasticsearch. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Здоровье кластера. <ul><li>`HEALTH_UNKNOWN`: состояние кластера неизвестно ([Host.health](#Host) всех хостов в кластере — `UNKNOWN`).</li><li>`ALIVE`: кластер работает нормально ([Host.health](#Host) всех хостов в кластере — `ALIVE`).</li><li>`DEAD`: кластер не работает ([Host.health](#Host) всех хостов в кластере — `DEAD`).</li><li>`DEGRADED`: кластер находится в состоянии деградации ([Host.health](#Host) по крайней мере одного из хостов в кластере — не `ALIVE`).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: состояние кластера неизвестно.</li><li>`CREATING`: кластер создается.</li><li>`RUNNING`: кластер работает нормально.</li><li>`ERROR`: в кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: кластер изменяется.</li><li>`STOPPING`: кластер останавливается.</li><li>`STOPPED`: кластер остановлен.</li><li>`STARTING`: кластер запускается.</li><ul/>


### Monitoring {#Monitoring5}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для кластера Elasticsearch. 


### ClusterConfig {#ClusterConfig5}

Поле | Описание
--- | ---
version | **string**<br>Версия Elasticsearch. 
elasticsearch | **[Elasticsearch](#Elasticsearch5)**<br>Конфигурация и распределение ресурсов для узлов Elasticsearch. 


### Elasticsearch {#Elasticsearch5}

Поле | Описание
--- | ---
data_node | **[DataNode](#DataNode7)**<br>Конфигурация и распределение ресурсов для узлов Elasticsearch с ролью Data node. 
master_node | **[MasterNode](#MasterNode7)**<br>Конфигурация и распределение ресурсов для узлов Elasticsearch с ролью Master node. 


### DataNode {#DataNode7}

Поле | Описание
--- | ---
config | **oneof:** `elasticsearch_config_set_7_6`<br>
&nbsp;&nbsp;elasticsearch_config_set_7_6 | **[config.ElasticsearchConfigSet7_6](#ElasticsearchConfigSet7_6)**<br>Конфигурация Elasticsearch 7.6 для узла с ролью Data node. 
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные узлам Elasticsearch с ролью Data node. 


### MasterNode {#MasterNode7}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные узлам Elasticsearch с ролью Master node. 


## Stop {#Stop}

Останавливает указанный кластер Elasticsearch.

**rpc Stop ([StopClusterRequest](#StopClusterRequest)) returns ([operation.Operation](#Operation5))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopClusterMetadata](#StopClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster6)<br>

### StopClusterRequest {#StopClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Elasticsearch, который нужно остановить. <br>Чтобы получить идентификатор кластера Elasticsearch, выполните запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.


### Operation {#Operation5}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster6)>**<br>в случае успешного выполнения операции. 


### StopClusterMetadata {#StopClusterMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера Elasticsearch. 


### Cluster {#Cluster6}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера Elasticsearch. Этот идентификатор генерируется при создании кластера. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер Elasticsearch. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя кластера Elasticsearch. Имя должно быть уникальным в рамках каталога. Длина 1-63 символов. 
description | **string**<br>Описание кластера Elasticsearch. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера Elasticsearch в виде пар `key:value`. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания кластера Elasticsearch. <ul><li>`PRODUCTION`: стабильная среда с осторожной политикой обновления — во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: среда с более агрессивной политикой обновления — новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring6)**<br>Описание систем мониторинга, относящихся к кластеру Elasticsearch. 
config | **[ClusterConfig](#ClusterConfig6)**<br>Конфигурация кластера Elasticsearch. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Здоровье кластера. <ul><li>`HEALTH_UNKNOWN`: состояние кластера неизвестно ([Host.health](#Host) всех хостов в кластере — `UNKNOWN`).</li><li>`ALIVE`: кластер работает нормально ([Host.health](#Host) всех хостов в кластере — `ALIVE`).</li><li>`DEAD`: кластер не работает ([Host.health](#Host) всех хостов в кластере — `DEAD`).</li><li>`DEGRADED`: кластер находится в состоянии деградации ([Host.health](#Host) по крайней мере одного из хостов в кластере — не `ALIVE`).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: состояние кластера неизвестно.</li><li>`CREATING`: кластер создается.</li><li>`RUNNING`: кластер работает нормально.</li><li>`ERROR`: в кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: кластер изменяется.</li><li>`STOPPING`: кластер останавливается.</li><li>`STOPPED`: кластер остановлен.</li><li>`STARTING`: кластер запускается.</li><ul/>


### Monitoring {#Monitoring6}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для кластера Elasticsearch. 


### ClusterConfig {#ClusterConfig6}

Поле | Описание
--- | ---
version | **string**<br>Версия Elasticsearch. 
elasticsearch | **[Elasticsearch](#Elasticsearch6)**<br>Конфигурация и распределение ресурсов для узлов Elasticsearch. 


### Elasticsearch {#Elasticsearch6}

Поле | Описание
--- | ---
data_node | **[DataNode](#DataNode8)**<br>Конфигурация и распределение ресурсов для узлов Elasticsearch с ролью Data node. 
master_node | **[MasterNode](#MasterNode8)**<br>Конфигурация и распределение ресурсов для узлов Elasticsearch с ролью Master node. 


### DataNode {#DataNode8}

Поле | Описание
--- | ---
config | **oneof:** `elasticsearch_config_set_7_6`<br>
&nbsp;&nbsp;elasticsearch_config_set_7_6 | **[config.ElasticsearchConfigSet7_6](#ElasticsearchConfigSet7_6)**<br>Конфигурация Elasticsearch 7.6 для узла с ролью Data node. 
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные узлам Elasticsearch с ролью Data node. 


### MasterNode {#MasterNode8}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные узлам Elasticsearch с ролью Master node. 


## ListLogs {#ListLogs}

Получает логи для указанного кластера Elasticsearch. <br>Дополнительные сведения о логах см. в разделе документации [Logs](/docs/managed-elasticsearch/operations/cluster-logs).

**rpc ListLogs ([ListClusterLogsRequest](#ListClusterLogsRequest)) returns ([ListClusterLogsResponse](#ListClusterLogsResponse))**

### ListClusterLogsRequest {#ListClusterLogsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Elasticsearch, для которого нужно получить логи. <br>Чтобы получить идентификатор кластера Elasticsearch, выполните запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
column_filter[] | **string**<br>Столбцы, которые нужно запросить из лога. <br>Если столбцы не указаны, записи логов возвращаются целиком. 
from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Временная метка, начиная с которой следует запросить логи. 
to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Временная метка, до которой следует запросить логи. 
page_size | **int64**<br>Максимальное количество результатов на одной странице в ответе. <br>Если количество результатов больше чем `page_size`, сервис вернет значение [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. <br>Установите значение `page_token` равным значению поля [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
always_next_page_token | **bool**<br>Флаг, определяющий поведение при предоставлении маркера следующей страницы. <br>Если этот флаг установлен в `true`, этот метод API всегда будет возвращать [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse), даже если текущая страница пуста. 
filter | **string**<br><ol><li>Имя поля, по которому нужно выполнить фильтрацию. В настоящее время фильтрацию можно использовать только по полю `hostname`. </li><li>Условный оператор. Поддерживаются операторы `=` и `!=` для одиночных значений, `IN` и `NOT IN` для списков значений. </li><li>Значение. Должно содержать от 1 до 63 символов и соответствовать регулярному выражению `^[a-z0-9.-]{1,61}$`. </li></ol> Максимальная длина строки в символах — 1000.


### ListClusterLogsResponse {#ListClusterLogsResponse}

Поле | Описание
--- | ---
logs[] | **[LogRecord](#LogRecord)**<br>Запрошенные записи в логе. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. <br>Если количество результатов больше чем [ListClusterLogsRequest.page_size](#ListClusterLogsRequest), используйте `next_page_token` в качестве значения параметра [ListClusterLogsRequest.page_token](#ListClusterLogsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. <br>Это значение взаимозаменяемо с [StreamLogRecord.next_record_token](#StreamLogRecord) из метода StreamLogs. 


### LogRecord {#LogRecord}

Поле | Описание
--- | ---
timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Временная метка для записи в логе. 
message | **map<string,string>**<br>Содержимое записи в логе. 


## StreamLogs {#StreamLogs}

То же самое, что [ListLogs](#ListLogs), с той разницей, что со стороны сервера передается поток логов. Допускается использовать семантику `tail -f` при работе с потоком логов.

**rpc StreamLogs ([StreamClusterLogsRequest](#StreamClusterLogsRequest)) returns (stream [StreamLogRecord](#StreamLogRecord))**

### StreamClusterLogsRequest {#StreamClusterLogsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Elasticsearch. <br>Чтобы получить идентификатор кластера Elasticsearch, выполните запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
column_filter[] | **string**<br>Столбцы, которые нужно запросить из лога. <br>Если столбцы не указаны, записи логов возвращаются целиком. 
from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Временная метка, начиная с которой следует запросить логи. 
to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Временная метка, до которой следует запросить логи. <br>Если значение этого поля не задано, то будут отправлены все существующие записи в логе, а затем и новые по мере их появления. В сущности, это эквивалентно семантике `tail -f`. 
record_token | **string**<br>Токен записи. <br>Задайте значение `record_token` равным значению [StreamLogRecord.next_record_token](#StreamLogRecord), возвращенному предыдущим запросом [ClusterService.StreamLogs](#StreamLogs) чтобы продолжить стриминг со следующей записи в логе. Максимальная длина строки в символах — 100.
filter | **string**<br><ol><li>Имя поля, по которому нужно выполнить фильтрацию. В настоящее время фильтрацию можно использовать только по полю `hostname`. </li><li>Условный оператор. Поддерживаются операторы `=` и `!=` для одиночных значений, `IN` и `NOT IN` для списков значений. </li><li>Значение. Должно содержать от 3 до 63 символов и соответствовать регулярному выражению `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`. </li></ol> Максимальная длина строки в символах — 1000.


### StreamLogRecord {#StreamLogRecord}

Поле | Описание
--- | ---
record | **[LogRecord](#LogRecord)**<br>Одна из запрошенных записей в логе. 
next_record_token | **string**<br>Этот токен позволяет продолжить работу с потоком логов, начиная с этой записи. <br>Чтобы продолжить работу с потоком, укажите значение `next_record_token` в качестве значения параметра [StreamClusterLogsRequest.record_token](#StreamClusterLogsRequest) в следующем запросе StreamLogs. <br>Это значение взаимозаменяемо с [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) из метода ListLogs. 


### LogRecord {#LogRecord1}

Поле | Описание
--- | ---
timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Временная метка для записи в логе. 
message | **map<string,string>**<br>Содержимое записи в логе. 


## ListOperations {#ListOperations}

Получает список операций для указанного кластера Elasticsearch.

**rpc ListOperations ([ListClusterOperationsRequest](#ListClusterOperationsRequest)) returns ([ListClusterOperationsResponse](#ListClusterOperationsResponse))**

### ListClusterOperationsRequest {#ListClusterOperationsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Elasticsearch, для которого нужно получить список операций. <br>Чтобы получить идентификатор кластера Elasticsearch, выполните запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на одной странице в ответе. <br>Если количество результатов больше чем `page_size`, сервис вернет значение [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. <br>Установите значение `page_token` равным значению поля [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListClusterOperationsResponse {#ListClusterOperationsResponse}

Поле | Описание
--- | ---
operations[] | **[operation.Operation](#Operation6)**<br>Список операций для указанного кластера Elasticsearch. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. <br>Если количество результатов больше чем [ListClusterOperationsRequest.page_size](#ListClusterOperationsRequest), используйте `next_page_token` в качестве значения параметра [ListClusterOperationsRequest.page_token](#ListClusterOperationsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Operation {#Operation6}

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

Получает список хостов для указанного кластера Elasticsearch.

**rpc ListHosts ([ListClusterHostsRequest](#ListClusterHostsRequest)) returns ([ListClusterHostsResponse](#ListClusterHostsResponse))**

### ListClusterHostsRequest {#ListClusterHostsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Elasticsearch. <br>Чтобы получить идентификатор кластера Elasticsearch, выполните запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на одной странице в ответе. <br>Если количество результатов больше чем `page_size`, сервис вернет значение [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. <br>Установите значение `page_token` равным значению поля [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListClusterHostsResponse {#ListClusterHostsResponse}

Поле | Описание
--- | ---
hosts[] | **[Host](#Host)**<br>Список хостов. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. <br>Если количество результатов больше чем [ListClusterHostsRequest.page_size](#ListClusterHostsRequest), используйте `next_page_token` в качестве значения параметра [ListClusterHostsRequest.page_token](#ListClusterHostsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Host {#Host}

Поле | Описание
--- | ---
name | **string**<br>Имя хоста. 
cluster_id | **string**<br>Идентификатор кластера Elasticsearch. 
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится хост. 
type | enum **Type**<br>Тип хоста. <ul><li>`DATA_NODE`: этот хост является узлом Elasticsearch с ролью Data node.</li><li>`MASTER_NODE`: этот хост является узлом Elasticsearch с ролью Master node.</li><ul/>
resources | **[Resources](#Resources)**<br> 
health | enum **Health**<br>Агрегированные данные о работоспособности хоста. <ul><li>`UNKNOWN`: состояние хоста неизвестно.</li><li>`ALIVE`: хост работает и выполняет все свои функции.</li><li>`DEAD`: хост не работает и не выполняет свои функции.</li><li>`DEGRADED`: хост находится в состоянии деградации и может выполнять только некоторые свои функции.</li><ul/>
services[] | **[Service](#Service)**<br>Сервисы, предоставляемые хостом. 
subnet_id | **string**<br>Идентификатор подсети, в которой находится хост. 
assign_public_ip | **bool**<br>Флаг, определяющий, назначен ли хосту публичный IP-адрес. <br>Если значение равно `true`, то этот хост доступен в Интернете через его публичный IP-адрес. 


### Resources {#Resources}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т.д.). Все доступные наборы ресурсов перечислены в [документации](/docs/managed-elasticsearch/concepts/instance-types). 
disk_size | **int64**<br>Объем хранилища, доступного хосту, в байтах. 
disk_type_id | **string**<br>Тип хранилища для хоста. Все доступные типы перечислены в [документации](/docs/managed-elasticsearch/concepts/storage). 


### Service {#Service}

Поле | Описание
--- | ---
type | enum **Type**<br>Тип сервиса, предоставляемого хостом. <ul><li>`ELASTICSEARCH`: сервис Elasticsearch.</li><ul/>
health | enum **Health**<br>Данные о работоспособности сервиса. <ul><li>`UNKNOWN`: состояние сервиса неизвестно.</li><li>`ALIVE`: сервис работает в штатном режиме.</li><li>`DEAD`: сервис не работает или не отвечает.</li><ul/>


## AddHosts {#AddHosts}

Добавляет новые хосты в указанный кластер Elasticsearch.

**rpc AddHosts ([AddClusterHostsRequest](#AddClusterHostsRequest)) returns ([operation.Operation](#Operation7))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddClusterHostsMetadata](#AddClusterHostsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### AddClusterHostsRequest {#AddClusterHostsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Elasticsearch. <br>Чтобы получить идентификатор кластера Elasticsearch, выполните запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
host_specs[] | **[HostSpec](#HostSpec)**<br>Одна или несколько конфигураций хостов, добавляемых в кластер Elasticsearch. Количество элементов должно быть больше 0.


### HostSpec {#HostSpec1}

Поле | Описание
--- | ---
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится хост. Максимальная длина строки в символах — 50.
subnet_id | **string**<br>Идентификатор подсети, в которой находится хост. Максимальная длина строки в символах — 50.
assign_public_ip | **bool**<br>Флаг, определяющий, назначен ли хосту публичный IP-адрес. <br>Если значение равно `true`, то этот хост доступен в Интернете через его публичный IP-адрес. 
type | **[Host.Type](#Host1)**<br>Обязательное поле. Тип хоста. 
shard_name | **string**<br>Имя шарда, который нужно создать на хосте. Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.


### Operation {#Operation7}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AddClusterHostsMetadata](#AddClusterHostsMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### AddClusterHostsMetadata {#AddClusterHostsMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера Elasticsearch. 
host_names[] | **string**<br>Имена хостов, которые добавляются. 


## DeleteHosts {#DeleteHosts}

Удаляет хосты из указанного кластера Elasticsearch.

**rpc DeleteHosts ([DeleteClusterHostsRequest](#DeleteClusterHostsRequest)) returns ([operation.Operation](#Operation8))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterHostsMetadata](#DeleteClusterHostsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterHostsRequest {#DeleteClusterHostsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Elasticsearch. <br>Чтобы получить идентификатор кластера Elasticsearch, выполните запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
host_names[] | **string**<br>Имена хостов, которые следует удалить. Количество элементов должно быть больше 0. Максимальная длина строки в символах для каждого значения — 253.


### Operation {#Operation8}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteClusterHostsMetadata](#DeleteClusterHostsMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### DeleteClusterHostsMetadata {#DeleteClusterHostsMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера Elasticsearch. 
host_names[] | **string**<br>Имена хостов, которые удаляются. 


