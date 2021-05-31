---
editable: false
---

# ClusterService

Набор методов для управления кластерами Apache Kafka®.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанный кластер Apache Kafka®. |
| [List](#List) | Получает список кластеров Apache Kafka®, принадлежащих указанному каталогу. |
| [Create](#Create) | Создает новый кластер Apache Kafka® в указанном каталоге. |
| [Update](#Update) | Изменяет указанный кластер Apache Kafka®. |
| [Delete](#Delete) | Удаляет указанный кластер Apache Kafka®. |
| [Move](#Move) | Перемещает кластер Apache Kafka® в указанный каталог. |
| [Start](#Start) | Запускает указанный кластер Apache Kafka®. |
| [Stop](#Stop) | Останавливает указанный кластер Apache Kafka®. |
| [ListLogs](#ListLogs) | Получает логи для указанного кластера Apache Kafka®. |
| [StreamLogs](#StreamLogs) | То же самое, что [ListLogs](#ListLogs), с той разницей, что со стороны сервера передается поток логов. |
| [ListOperations](#ListOperations) | Получает список операций для указанного кластера Apache Kafka®. |
| [ListHosts](#ListHosts) | Получает список хостов для указанного кластера Apache Kafka®. |

## Вызовы ClusterService {#calls}

## Get {#Get}

Возвращает указанный кластер Apache Kafka®. <br>Чтобы получить список доступных кластеров Apache Kafka®, выполните запрос [List](#List).

**rpc Get ([GetClusterRequest](#GetClusterRequest)) returns ([Cluster](#Cluster))**

### GetClusterRequest {#GetClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Apache Kafka®. <br>Чтобы получить идентификатор кластера, выполните запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.


### Cluster {#Cluster}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера Apache Kafka®. Этот идентификатор генерируется при создании кластера. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер Apache Kafka®. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя кластера Apache Kafka®. Имя должно быть уникальным в рамках каталога. Длина 1-63 символов. Значение должно соответствовать регулярному выражению `[a-zA-Z0-9_-]*`. 
description | **string**<br>Описание кластера Apache Kafka®. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера Apache Kafka® в виде пар `key:value`. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания кластера Apache Kafka®. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления — во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления — новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring)**<br>Описание систем мониторинга, относящихся к кластеру Apache Kafka®. 
config | **[ConfigSpec](#ConfigSpec)**<br>Конфигурация кластера Apache Kafka®. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Здоровье кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](#Host) всех хостов в кластере — `UNKNOWN`).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](#Host) всех хостов в кластере — `ALIVE`).</li><li>`DEAD`: Кластер не работает ([Host.health](#Host) всех хостов в кластере — `DEAD`).</li><li>`DEGRADED`: Кластер находится в состоянии деградации ([Host.health](#Host) по крайней мере одного из хостов в кластере — не `ALIVE`).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: В кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>


### Monitoring {#Monitoring}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для кластера Apache Kafka®. 


### ConfigSpec {#ConfigSpec}

Поле | Описание
--- | ---
version | **string**<br>Версия Apache Kafka®, которая используется в кластере. Возможные значения: `2.1`, `2.6`. 
kafka | **[Kafka](#Kafka)**<br>Конфигурация и распределение ресурсов для брокеров Kafka. 
zookeeper | **[Zookeeper](#Zookeeper)**<br>Конфигурация и распределение ресурсов для хостов ZooKeeper. 
zone_id[] | **string**<br>Идентификаторы зон доступности, в которых находятся брокеры Kafka. 
brokers_count | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Количество брокеров Kafka, развернутых в каждой зоне доступности. 
assign_public_ip | **bool**<br>Флаг, определяющий, назначен ли кластеру публичный IP-адрес. Если значение равно `true`, то кластер Apache Kafka® доступен в Интернете через его публичный IP-адрес. 


### Kafka {#Kafka}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Вычислительные ресурсы, выделенные брокерам Kafka. 
kafka_config | **oneof:** `kafka_config_2_1` или `kafka_config_2_6`<br>Конфигурация брокера Kafka.
&nbsp;&nbsp;kafka_config_2_1 | **[KafkaConfig2_1](#KafkaConfig2_1)**<br>Конфигурация брокера Kafka. 
&nbsp;&nbsp;kafka_config_2_6 | **[KafkaConfig2_6](#KafkaConfig2_6)**<br>Конфигурация брокера Kafka. 


### Zookeeper {#Zookeeper}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Вычислительные ресурсы, выделенные хостам ZooKeeper. 


## List {#List}

Получает список кластеров Apache Kafka®, принадлежащих указанному каталогу.

**rpc List ([ListClustersRequest](#ListClustersRequest)) returns ([ListClustersResponse](#ListClustersResponse))**

### ListClustersRequest {#ListClustersRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога, для которого нужно получить список кластеров Apache Kafka®. <br>Чтобы получить идентификатор каталога, выполните запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на одной странице в ответе. <br>Если количество результатов больше чем `page_size`, сервис вернет значение [ListClustersResponse.next_page_token](#ListClustersResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. <br>Установите значение `page_token` равным значению поля [ListClustersResponse.next_page_token](#ListClustersResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br><ol><li>Имя поля, по которому нужно выполнить фильтрацию. В настоящее время фильтрацию можно использовать только по полю [Cluster.name](#Cluster1). </li><li>Условный оператор. Поддерживаются операторы `=` и `!=` для одиночных значений, `IN` и `NOT IN` для списков значений. </li><li>Значение. Должно содержать от 1 до 63 символов и соответствовать регулярному выражению `^[a-zA-Z0-9_-]+$`. </li></ol> Максимальная длина строки в символах — 1000.


### ListClustersResponse {#ListClustersResponse}

Поле | Описание
--- | ---
clusters[] | **[Cluster](#Cluster1)**<br>Список кластеров Apache Kafka®. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. <br>Если количество результатов больше чем [ListClustersRequest.page_size](#ListClustersRequest), используйте `next_page_token` в качестве значения параметра [ListClustersRequest.page_token](#ListClustersRequest) в следующем запросе. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Cluster {#Cluster1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера Apache Kafka®. Этот идентификатор генерируется при создании кластера. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер Apache Kafka®. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя кластера Apache Kafka®. Имя должно быть уникальным в рамках каталога. Длина 1-63 символов. Значение должно соответствовать регулярному выражению `[a-zA-Z0-9_-]*`. 
description | **string**<br>Описание кластера Apache Kafka®. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера Apache Kafka® в виде пар `key:value`. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания кластера Apache Kafka®. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления — во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления — новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring1)**<br>Описание систем мониторинга, относящихся к кластеру Apache Kafka®. 
config | **[ConfigSpec](#ConfigSpec1)**<br>Конфигурация кластера Apache Kafka®. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Здоровье кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](#Host) всех хостов в кластере — `UNKNOWN`).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](#Host) всех хостов в кластере — `ALIVE`).</li><li>`DEAD`: Кластер не работает ([Host.health](#Host) всех хостов в кластере — `DEAD`).</li><li>`DEGRADED`: Кластер находится в состоянии деградации ([Host.health](#Host) по крайней мере одного из хостов в кластере — не `ALIVE`).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: В кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>


### Monitoring {#Monitoring1}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для кластера Apache Kafka®. 


### ConfigSpec {#ConfigSpec1}

Поле | Описание
--- | ---
version | **string**<br>Версия Apache Kafka®, которая используется в кластере. Возможные значения: `2.1`, `2.6`. 
kafka | **[Kafka](#Kafka1)**<br>Конфигурация и распределение ресурсов для брокеров Kafka. 
zookeeper | **[Zookeeper](#Zookeeper1)**<br>Конфигурация и распределение ресурсов для хостов ZooKeeper. 
zone_id[] | **string**<br>Идентификаторы зон доступности, в которых находятся брокеры Kafka. 
brokers_count | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Количество брокеров Kafka, развернутых в каждой зоне доступности. 
assign_public_ip | **bool**<br>Флаг, определяющий, назначен ли кластеру публичный IP-адрес. Если значение равно `true`, то кластер Apache Kafka® доступен в Интернете через его публичный IP-адрес. 


### Kafka {#Kafka1}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Вычислительные ресурсы, выделенные брокерам Kafka. 
kafka_config | **oneof:** `kafka_config_2_1` или `kafka_config_2_6`<br>Конфигурация брокера Kafka.
&nbsp;&nbsp;kafka_config_2_1 | **[KafkaConfig2_1](#KafkaConfig2_1)**<br>Конфигурация брокера Kafka. 
&nbsp;&nbsp;kafka_config_2_6 | **[KafkaConfig2_6](#KafkaConfig2_6)**<br>Конфигурация брокера Kafka. 


### Zookeeper {#Zookeeper1}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Вычислительные ресурсы, выделенные хостам ZooKeeper. 


## Create {#Create}

Создает новый кластер Apache Kafka® в указанном каталоге.

**rpc Create ([CreateClusterRequest](#CreateClusterRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateClusterMetadata](#CreateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster2)<br>

### CreateClusterRequest {#CreateClusterRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога, в котором будет создан кластер Apache Kafka®. <br>Чтобы получить идентификатор каталога, выполните запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). Максимальная длина строки в символах — 50.
name | **string**<br>Обязательное поле. Имя кластера Apache Kafka®. Имя должно быть уникальным в рамках каталога. Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению ` [a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Описание кластера Apache Kafka®. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Пользовательские метки для кластера Apache Kafka® в виде пар `key:value`. <br>Например, "project": "mvp" или "source": "dictionary". Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_./\\@0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_./\\@0-9a-z]* `.
environment | **[Cluster.Environment](#Cluster2)**<br>Среда развертывания кластера Apache Kafka®. 
config_spec | **[ConfigSpec](#ConfigSpec2)**<br>Конфигурация Kafka и хостов в кластере Apache Kafka®. 
topic_specs[] | **[TopicSpec](#TopicSpec)**<br>Одна или несколько конфигураций топиков, создаваемых в кластере Apache Kafka®. 
user_specs[] | **[UserSpec](#UserSpec)**<br>Конфигурации учетных записей, создаваемых в кластере Apache Kafka®. 
network_id | **string**<br>Идентификатор сети, в которой будет создан кластер Apache Kafka®. Максимальная длина строки в символах — 50.


### ConfigSpec {#ConfigSpec2}

Поле | Описание
--- | ---
version | **string**<br>Версия Apache Kafka®, которая используется в кластере. Возможные значения: `2.1`, `2.6`. 
kafka | **[Kafka](#Kafka2)**<br>Конфигурация и распределение ресурсов для брокеров Kafka. 
zookeeper | **[Zookeeper](#Zookeeper2)**<br>Конфигурация и распределение ресурсов для хостов ZooKeeper. 
zone_id[] | **string**<br>Идентификаторы зон доступности, в которых находятся брокеры Kafka. 
brokers_count | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Количество брокеров Kafka, развернутых в каждой зоне доступности. 
assign_public_ip | **bool**<br>Флаг, определяющий, назначен ли кластеру публичный IP-адрес. Если значение равно `true`, то кластер Apache Kafka® доступен в Интернете через его публичный IP-адрес. 


### Kafka {#Kafka2}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Вычислительные ресурсы, выделенные брокерам Kafka. 
kafka_config | **oneof:** `kafka_config_2_1` или `kafka_config_2_6`<br>Конфигурация брокера Kafka.
&nbsp;&nbsp;kafka_config_2_1 | **[KafkaConfig2_1](#KafkaConfig2_1)**<br>Конфигурация брокера Kafka. 
&nbsp;&nbsp;kafka_config_2_6 | **[KafkaConfig2_6](#KafkaConfig2_6)**<br>Конфигурация брокера Kafka. 


### Zookeeper {#Zookeeper2}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Вычислительные ресурсы, выделенные хостам ZooKeeper. 


### TopicSpec {#TopicSpec}

Поле | Описание
--- | ---
name | **string**<br>Имя топика. 
partitions | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Количество разделов в топике. 
replication_factor | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Количество копий данных топика, хранящихся в кластере. 
topic_config | **oneof:** `topic_config_2_1`<br>Пользовательские настройки топика.
&nbsp;&nbsp;topic_config_2_1 | **[TopicConfig2_1](#TopicConfig2_1)**<br>Пользовательские настройки топика. 


### TopicConfig2_1 {#TopicConfig2_1}

Поле | Описание
--- | ---
cleanup_policy | enum **CleanupPolicy**<br>Политика хранения старых сообщений лога. <ul><li>`CLEANUP_POLICY_DELETE`: эта политика отбрасывает сегменты лога либо при истечении срока их хранения, либо при достижении предельного размера лога. См. также описание [KafkaConfig2_1.log_retention_ms](#KafkaConfig2_1) и других подобных параметров.</li><li>`CLEANUP_POLICY_COMPACT`: эта политика сжимает сообщения в логе.</li><li>`CLEANUP_POLICY_COMPACT_AND_DELETE`: эта политика использует как сжатие сообщений, так и удаление сегментов лога.</li><ul/>
compression_type | enum **CompressionType**<br>Тип сжатия для указанного топика. <ul><li>`COMPRESSION_TYPE_UNCOMPRESSED`: не использовать кодек (сообщения не сжимаются).</li><li>`COMPRESSION_TYPE_ZSTD`: кодек Zstandard.</li><li>`COMPRESSION_TYPE_LZ4`: Кодек LZ4.</li><li>`COMPRESSION_TYPE_SNAPPY`: Кодек Snappy.</li><li>`COMPRESSION_TYPE_GZIP`: кодек GZip.</li><li>`COMPRESSION_TYPE_PRODUCER`: кодек задается на стороне производителя (допустимые кодеки: `ZSTD`, `LZ4`, `GZIP` или `SNAPPY`).</li><ul/>
delete_retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Время (в миллисекундах), в течение которого нужно хранить tombstone-маркеры удаления для топиков со сжатым логом. 
file_delete_delay_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Время ожидания перед удалением файла из файловой системы. 
flush_messages | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Количество сообщений, которые должны быть накоплены в разделе прежде, чем эти сообщения будут сброшены на диск. <br>Эта настройка переопределяет на уровне топика настройку уровня кластера [KafkaConfig2_1.log_flush_interval_messages](#KafkaConfig2_1). 
flush_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимальное время (в миллисекундах), в течение которого сообщение в любом топике хранится в памяти перед сбросом на диск. <br>Эта настройка переопределяет на уровне топика настройку уровня кластера [KafkaConfig2_1.log_flush_interval_ms](#KafkaConfig2_1). 
min_compaction_lag_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Минимальное время в миллисекундах, в течение которого сообщение в логе будет оставаться несжатым. 
retention_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимальный размер, до которого может вырасти раздел, прежде чем Kafka начнет отбрасывать старые сегменты лога, если действует настройка `delete` `cleanup_policy`. Эта настройка полезна, если вам необходимо контролировать размер лога из-за ограниченного дискового пространства. <br>Эта настройка переопределяет на уровне топика настройку уровня кластера [KafkaConfig2_1.log_retention_bytes](#KafkaConfig2_1). 
retention_ms | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Количество миллисекунд до удаления файла сегмента лога; в течение этого времени Kafka будет хранить файл сегмента лога. <br>Эта настройка переопределяет на уровне топика настройку уровня кластера [KafkaConfig2_1.log_retention_ms](#KafkaConfig2_1). 


### UserSpec {#UserSpec}

Поле | Описание
--- | ---
name | **string**<br>Обязательное поле. Имя пользователя Kafka. Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.
password | **string**<br>Обязательное поле. Пароль пользователя Kafka. Длина строки в символах должна быть от 8 до 128.
permissions[] | **[Permission](#Permission)**<br>Набор разрешений, предоставленных пользователю. 


### Permission {#Permission}

Поле | Описание
--- | ---
topic_name | **string**<br>Имя топика, к которому предоставляется доступ. <br>Чтобы получить имя топика, выполните запрос [TopicService.List](./topic_service#List). 
role | enum **AccessRole**<br>Роль доступа, которую нужно предоставить пользователю. <ul><li>`ACCESS_ROLE_PRODUCER`: роль пользователя — производитель.</li><li>`ACCESS_ROLE_CONSUMER`: роль пользователя — потребитель.</li><ul/>


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
cluster_id | **string**<br>Идентификатор кластера Apache Kafka®, который создается. 


### Cluster {#Cluster2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера Apache Kafka®. Этот идентификатор генерируется при создании кластера. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер Apache Kafka®. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя кластера Apache Kafka®. Имя должно быть уникальным в рамках каталога. Длина 1-63 символов. Значение должно соответствовать регулярному выражению `[a-zA-Z0-9_-]*`. 
description | **string**<br>Описание кластера Apache Kafka®. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера Apache Kafka® в виде пар `key:value`. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания кластера Apache Kafka®. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления — во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления — новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Описание систем мониторинга, относящихся к кластеру Apache Kafka®. 
config | **[ConfigSpec](#ConfigSpec3)**<br>Конфигурация кластера Apache Kafka®. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Здоровье кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](#Host) всех хостов в кластере — `UNKNOWN`).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](#Host) всех хостов в кластере — `ALIVE`).</li><li>`DEAD`: Кластер не работает ([Host.health](#Host) всех хостов в кластере — `DEAD`).</li><li>`DEGRADED`: Кластер находится в состоянии деградации ([Host.health](#Host) по крайней мере одного из хостов в кластере — не `ALIVE`).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: В кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>


### Monitoring {#Monitoring2}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для кластера Apache Kafka®. 


### ConfigSpec {#ConfigSpec3}

Поле | Описание
--- | ---
version | **string**<br>Версия Apache Kafka®, которая используется в кластере. Возможные значения: `2.1`, `2.6`. 
kafka | **[Kafka](#Kafka3)**<br>Конфигурация и распределение ресурсов для брокеров Kafka. 
zookeeper | **[Zookeeper](#Zookeeper3)**<br>Конфигурация и распределение ресурсов для хостов ZooKeeper. 
zone_id[] | **string**<br>Идентификаторы зон доступности, в которых находятся брокеры Kafka. 
brokers_count | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Количество брокеров Kafka, развернутых в каждой зоне доступности. 
assign_public_ip | **bool**<br>Флаг, определяющий, назначен ли кластеру публичный IP-адрес. Если значение равно `true`, то кластер Apache Kafka® доступен в Интернете через его публичный IP-адрес. 


### Kafka {#Kafka3}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Вычислительные ресурсы, выделенные брокерам Kafka. 
kafka_config | **oneof:** `kafka_config_2_1` или `kafka_config_2_6`<br>Конфигурация брокера Kafka.
&nbsp;&nbsp;kafka_config_2_1 | **[KafkaConfig2_1](#KafkaConfig2_1)**<br>Конфигурация брокера Kafka. 
&nbsp;&nbsp;kafka_config_2_6 | **[KafkaConfig2_6](#KafkaConfig2_6)**<br>Конфигурация брокера Kafka. 


### Zookeeper {#Zookeeper3}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Вычислительные ресурсы, выделенные хостам ZooKeeper. 


## Update {#Update}

Изменяет указанный кластер Apache Kafka®.

**rpc Update ([UpdateClusterRequest](#UpdateClusterRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterMetadata](#UpdateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster3)<br>

### UpdateClusterRequest {#UpdateClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Apache Kafka®, который нужно изменить. <br>Чтобы получить идентификатор кластера Apache Kafka®, выполните запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
description | **string**<br>Новое описание кластера Apache Kafka®. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Пользовательские метки для кластера Apache Kafka® в виде пар `key:value`. <br>Например, "project": "mvp" или "source": "dictionary". <br>Новый набор меток полностью заменит старый. Чтобы добавить метку, запросите текущий набор меток с помощью метода [ClusterService.Get](#Get), затем отправьте запрос [ClusterService.Update](#Update), добавив новую метку в этот набор. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
config_spec | **[ConfigSpec](#ConfigSpec4)**<br>Новая конфигурация Kafka и хостов кластера Apache Kafka®. <br>Используйте параметр `update_mask` чтобы предотвратить сброс настроек кластера, не перечисленных в `config_spec`, на значения по умолчанию. 
name | **string**<br>Новое имя кластера Apache Kafka®. Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.


### ConfigSpec {#ConfigSpec4}

Поле | Описание
--- | ---
version | **string**<br>Версия Apache Kafka®, которая используется в кластере. Возможные значения: `2.1`, `2.6`. 
kafka | **[Kafka](#Kafka4)**<br>Конфигурация и распределение ресурсов для брокеров Kafka. 
zookeeper | **[Zookeeper](#Zookeeper4)**<br>Конфигурация и распределение ресурсов для хостов ZooKeeper. 
zone_id[] | **string**<br>Идентификаторы зон доступности, в которых находятся брокеры Kafka. 
brokers_count | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Количество брокеров Kafka, развернутых в каждой зоне доступности. 
assign_public_ip | **bool**<br>Флаг, определяющий, назначен ли кластеру публичный IP-адрес. Если значение равно `true`, то кластер Apache Kafka® доступен в Интернете через его публичный IP-адрес. 


### Kafka {#Kafka4}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Вычислительные ресурсы, выделенные брокерам Kafka. 
kafka_config | **oneof:** `kafka_config_2_1` или `kafka_config_2_6`<br>Конфигурация брокера Kafka.
&nbsp;&nbsp;kafka_config_2_1 | **[KafkaConfig2_1](#KafkaConfig2_1)**<br>Конфигурация брокера Kafka. 
&nbsp;&nbsp;kafka_config_2_6 | **[KafkaConfig2_6](#KafkaConfig2_6)**<br>Конфигурация брокера Kafka. 


### Zookeeper {#Zookeeper4}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Вычислительные ресурсы, выделенные хостам ZooKeeper. 


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
cluster_id | **string**<br>Идентификатор кластера Apache Kafka®, который изменяется. 


### Cluster {#Cluster3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера Apache Kafka®. Этот идентификатор генерируется при создании кластера. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер Apache Kafka®. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя кластера Apache Kafka®. Имя должно быть уникальным в рамках каталога. Длина 1-63 символов. Значение должно соответствовать регулярному выражению `[a-zA-Z0-9_-]*`. 
description | **string**<br>Описание кластера Apache Kafka®. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера Apache Kafka® в виде пар `key:value`. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания кластера Apache Kafka®. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления — во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления — новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring3)**<br>Описание систем мониторинга, относящихся к кластеру Apache Kafka®. 
config | **[ConfigSpec](#ConfigSpec5)**<br>Конфигурация кластера Apache Kafka®. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Здоровье кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](#Host) всех хостов в кластере — `UNKNOWN`).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](#Host) всех хостов в кластере — `ALIVE`).</li><li>`DEAD`: Кластер не работает ([Host.health](#Host) всех хостов в кластере — `DEAD`).</li><li>`DEGRADED`: Кластер находится в состоянии деградации ([Host.health](#Host) по крайней мере одного из хостов в кластере — не `ALIVE`).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: В кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>


### Monitoring {#Monitoring3}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для кластера Apache Kafka®. 


### ConfigSpec {#ConfigSpec5}

Поле | Описание
--- | ---
version | **string**<br>Версия Apache Kafka®, которая используется в кластере. Возможные значения: `2.1`, `2.6`. 
kafka | **[Kafka](#Kafka5)**<br>Конфигурация и распределение ресурсов для брокеров Kafka. 
zookeeper | **[Zookeeper](#Zookeeper5)**<br>Конфигурация и распределение ресурсов для хостов ZooKeeper. 
zone_id[] | **string**<br>Идентификаторы зон доступности, в которых находятся брокеры Kafka. 
brokers_count | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Количество брокеров Kafka, развернутых в каждой зоне доступности. 
assign_public_ip | **bool**<br>Флаг, определяющий, назначен ли кластеру публичный IP-адрес. Если значение равно `true`, то кластер Apache Kafka® доступен в Интернете через его публичный IP-адрес. 


### Kafka {#Kafka5}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Вычислительные ресурсы, выделенные брокерам Kafka. 
kafka_config | **oneof:** `kafka_config_2_1` или `kafka_config_2_6`<br>Конфигурация брокера Kafka.
&nbsp;&nbsp;kafka_config_2_1 | **[KafkaConfig2_1](#KafkaConfig2_1)**<br>Конфигурация брокера Kafka. 
&nbsp;&nbsp;kafka_config_2_6 | **[KafkaConfig2_6](#KafkaConfig2_6)**<br>Конфигурация брокера Kafka. 


### Zookeeper {#Zookeeper5}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Вычислительные ресурсы, выделенные хостам ZooKeeper. 


## Delete {#Delete}

Удаляет указанный кластер Apache Kafka®.

**rpc Delete ([DeleteClusterRequest](#DeleteClusterRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterMetadata](#DeleteClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterRequest {#DeleteClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Apache Kafka®, который следует удалить. <br>Чтобы получить идентификатор кластера Apache Kafka®, выполните запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.


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
cluster_id | **string**<br>Идентификатор кластера Apache Kafka®, который удаляется. 


## Move {#Move}

Перемещает кластер Apache Kafka® в указанный каталог.

**rpc Move ([MoveClusterRequest](#MoveClusterRequest)) returns ([operation.Operation](#Operation3))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[MoveClusterMetadata](#MoveClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster4)<br>

### MoveClusterRequest {#MoveClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Apache Kafka®, который нужно переместить. <br>Чтобы получить идентификатор кластера Apache Kafka®, выполните запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
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
cluster_id | **string**<br>Идентификатор перемещаемого кластера Apache Kafka®. 
source_folder_id | **string**<br>Идентификатор исходного каталога. 
destination_folder_id | **string**<br>Идентификатор каталога назначения. 


### Cluster {#Cluster4}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера Apache Kafka®. Этот идентификатор генерируется при создании кластера. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер Apache Kafka®. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя кластера Apache Kafka®. Имя должно быть уникальным в рамках каталога. Длина 1-63 символов. Значение должно соответствовать регулярному выражению `[a-zA-Z0-9_-]*`. 
description | **string**<br>Описание кластера Apache Kafka®. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера Apache Kafka® в виде пар `key:value`. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания кластера Apache Kafka®. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления — во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления — новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring4)**<br>Описание систем мониторинга, относящихся к кластеру Apache Kafka®. 
config | **[ConfigSpec](#ConfigSpec6)**<br>Конфигурация кластера Apache Kafka®. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Здоровье кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](#Host) всех хостов в кластере — `UNKNOWN`).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](#Host) всех хостов в кластере — `ALIVE`).</li><li>`DEAD`: Кластер не работает ([Host.health](#Host) всех хостов в кластере — `DEAD`).</li><li>`DEGRADED`: Кластер находится в состоянии деградации ([Host.health](#Host) по крайней мере одного из хостов в кластере — не `ALIVE`).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: В кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>


### Monitoring {#Monitoring4}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для кластера Apache Kafka®. 


### ConfigSpec {#ConfigSpec6}

Поле | Описание
--- | ---
version | **string**<br>Версия Apache Kafka®, которая используется в кластере. Возможные значения: `2.1`, `2.6`. 
kafka | **[Kafka](#Kafka6)**<br>Конфигурация и распределение ресурсов для брокеров Kafka. 
zookeeper | **[Zookeeper](#Zookeeper6)**<br>Конфигурация и распределение ресурсов для хостов ZooKeeper. 
zone_id[] | **string**<br>Идентификаторы зон доступности, в которых находятся брокеры Kafka. 
brokers_count | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Количество брокеров Kafka, развернутых в каждой зоне доступности. 
assign_public_ip | **bool**<br>Флаг, определяющий, назначен ли кластеру публичный IP-адрес. Если значение равно `true`, то кластер Apache Kafka® доступен в Интернете через его публичный IP-адрес. 


### Kafka {#Kafka6}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Вычислительные ресурсы, выделенные брокерам Kafka. 
kafka_config | **oneof:** `kafka_config_2_1` или `kafka_config_2_6`<br>Конфигурация брокера Kafka.
&nbsp;&nbsp;kafka_config_2_1 | **[KafkaConfig2_1](#KafkaConfig2_1)**<br>Конфигурация брокера Kafka. 
&nbsp;&nbsp;kafka_config_2_6 | **[KafkaConfig2_6](#KafkaConfig2_6)**<br>Конфигурация брокера Kafka. 


### Zookeeper {#Zookeeper6}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Вычислительные ресурсы, выделенные хостам ZooKeeper. 


## Start {#Start}

Запускает указанный кластер Apache Kafka®.

**rpc Start ([StartClusterRequest](#StartClusterRequest)) returns ([operation.Operation](#Operation4))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartClusterMetadata](#StartClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster5)<br>

### StartClusterRequest {#StartClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Apache Kafka®, который нужно запустить. <br>Чтобы получить идентификатор кластера Apache Kafka®, выполните запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.


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
cluster_id | **string**<br>Идентификатор кластера Apache Kafka®. 


### Cluster {#Cluster5}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера Apache Kafka®. Этот идентификатор генерируется при создании кластера. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер Apache Kafka®. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя кластера Apache Kafka®. Имя должно быть уникальным в рамках каталога. Длина 1-63 символов. Значение должно соответствовать регулярному выражению `[a-zA-Z0-9_-]*`. 
description | **string**<br>Описание кластера Apache Kafka®. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера Apache Kafka® в виде пар `key:value`. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания кластера Apache Kafka®. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления — во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления — новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring5)**<br>Описание систем мониторинга, относящихся к кластеру Apache Kafka®. 
config | **[ConfigSpec](#ConfigSpec7)**<br>Конфигурация кластера Apache Kafka®. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Здоровье кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](#Host) всех хостов в кластере — `UNKNOWN`).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](#Host) всех хостов в кластере — `ALIVE`).</li><li>`DEAD`: Кластер не работает ([Host.health](#Host) всех хостов в кластере — `DEAD`).</li><li>`DEGRADED`: Кластер находится в состоянии деградации ([Host.health](#Host) по крайней мере одного из хостов в кластере — не `ALIVE`).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: В кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>


### Monitoring {#Monitoring5}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для кластера Apache Kafka®. 


### ConfigSpec {#ConfigSpec7}

Поле | Описание
--- | ---
version | **string**<br>Версия Apache Kafka®, которая используется в кластере. Возможные значения: `2.1`, `2.6`. 
kafka | **[Kafka](#Kafka7)**<br>Конфигурация и распределение ресурсов для брокеров Kafka. 
zookeeper | **[Zookeeper](#Zookeeper7)**<br>Конфигурация и распределение ресурсов для хостов ZooKeeper. 
zone_id[] | **string**<br>Идентификаторы зон доступности, в которых находятся брокеры Kafka. 
brokers_count | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Количество брокеров Kafka, развернутых в каждой зоне доступности. 
assign_public_ip | **bool**<br>Флаг, определяющий, назначен ли кластеру публичный IP-адрес. Если значение равно `true`, то кластер Apache Kafka® доступен в Интернете через его публичный IP-адрес. 


### Kafka {#Kafka7}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Вычислительные ресурсы, выделенные брокерам Kafka. 
kafka_config | **oneof:** `kafka_config_2_1` или `kafka_config_2_6`<br>Конфигурация брокера Kafka.
&nbsp;&nbsp;kafka_config_2_1 | **[KafkaConfig2_1](#KafkaConfig2_1)**<br>Конфигурация брокера Kafka. 
&nbsp;&nbsp;kafka_config_2_6 | **[KafkaConfig2_6](#KafkaConfig2_6)**<br>Конфигурация брокера Kafka. 


### Zookeeper {#Zookeeper7}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Вычислительные ресурсы, выделенные хостам ZooKeeper. 


## Stop {#Stop}

Останавливает указанный кластер Apache Kafka®.

**rpc Stop ([StopClusterRequest](#StopClusterRequest)) returns ([operation.Operation](#Operation5))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopClusterMetadata](#StopClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster6)<br>

### StopClusterRequest {#StopClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Apache Kafka®, который нужно остановить. <br>Чтобы получить идентификатор кластера Apache Kafka®, выполните запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.


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
cluster_id | **string**<br>Идентификатор кластера Apache Kafka®. 


### Cluster {#Cluster6}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера Apache Kafka®. Этот идентификатор генерируется при создании кластера. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер Apache Kafka®. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя кластера Apache Kafka®. Имя должно быть уникальным в рамках каталога. Длина 1-63 символов. Значение должно соответствовать регулярному выражению `[a-zA-Z0-9_-]*`. 
description | **string**<br>Описание кластера Apache Kafka®. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера Apache Kafka® в виде пар `key:value`. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания кластера Apache Kafka®. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления — во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления — новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring6)**<br>Описание систем мониторинга, относящихся к кластеру Apache Kafka®. 
config | **[ConfigSpec](#ConfigSpec8)**<br>Конфигурация кластера Apache Kafka®. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Здоровье кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](#Host) всех хостов в кластере — `UNKNOWN`).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](#Host) всех хостов в кластере — `ALIVE`).</li><li>`DEAD`: Кластер не работает ([Host.health](#Host) всех хостов в кластере — `DEAD`).</li><li>`DEGRADED`: Кластер находится в состоянии деградации ([Host.health](#Host) по крайней мере одного из хостов в кластере — не `ALIVE`).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: В кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>


### Monitoring {#Monitoring6}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для кластера Apache Kafka®. 


### ConfigSpec {#ConfigSpec8}

Поле | Описание
--- | ---
version | **string**<br>Версия Apache Kafka®, которая используется в кластере. Возможные значения: `2.1`, `2.6`. 
kafka | **[Kafka](#Kafka8)**<br>Конфигурация и распределение ресурсов для брокеров Kafka. 
zookeeper | **[Zookeeper](#Zookeeper8)**<br>Конфигурация и распределение ресурсов для хостов ZooKeeper. 
zone_id[] | **string**<br>Идентификаторы зон доступности, в которых находятся брокеры Kafka. 
brokers_count | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Количество брокеров Kafka, развернутых в каждой зоне доступности. 
assign_public_ip | **bool**<br>Флаг, определяющий, назначен ли кластеру публичный IP-адрес. Если значение равно `true`, то кластер Apache Kafka® доступен в Интернете через его публичный IP-адрес. 


### Kafka {#Kafka8}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Вычислительные ресурсы, выделенные брокерам Kafka. 
kafka_config | **oneof:** `kafka_config_2_1` или `kafka_config_2_6`<br>Конфигурация брокера Kafka.
&nbsp;&nbsp;kafka_config_2_1 | **[KafkaConfig2_1](#KafkaConfig2_1)**<br>Конфигурация брокера Kafka. 
&nbsp;&nbsp;kafka_config_2_6 | **[KafkaConfig2_6](#KafkaConfig2_6)**<br>Конфигурация брокера Kafka. 


### Zookeeper {#Zookeeper8}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Вычислительные ресурсы, выделенные хостам ZooKeeper. 


## ListLogs {#ListLogs}

Получает логи для указанного кластера Apache Kafka®. <br>Дополнительные сведения о логах см. в разделе [Logs](/docs/managed-kafka/operations/cluster-logs) документации.

**rpc ListLogs ([ListClusterLogsRequest](#ListClusterLogsRequest)) returns ([ListClusterLogsResponse](#ListClusterLogsResponse))**

### ListClusterLogsRequest {#ListClusterLogsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Apache Kafka®, для которого нужно получить логи. <br>Чтобы получить идентификатор кластера Apache Kafka®, выполните запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
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
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. <br>Если количество результатов больше чем [ListClusterLogsRequest.page_size](#ListClusterLogsRequest), используйте `next_page_token` в качестве значения параметра [ListClusterLogsRequest.page_token](#ListClusterLogsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. Это значение взаимозаменяемо с [StreamLogRecord.next_record_token](#StreamLogRecord) из метода StreamLogs. 


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
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Apache Kafka®. <br>Чтобы получить идентификатор кластера Apache Kafka®, выполните запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
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

Получает список операций для указанного кластера Apache Kafka®.

**rpc ListOperations ([ListClusterOperationsRequest](#ListClusterOperationsRequest)) returns ([ListClusterOperationsResponse](#ListClusterOperationsResponse))**

### ListClusterOperationsRequest {#ListClusterOperationsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Apache Kafka®, для которого нужно получить список операций. Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на одной странице в ответе. <br>Если количество результатов больше чем `page_size`, сервис вернет значение [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. <br>Установите значение `page_token` равным значению поля [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListClusterOperationsResponse {#ListClusterOperationsResponse}

Поле | Описание
--- | ---
operations[] | **[operation.Operation](#Operation6)**<br>Получает список операций для указанного кластера Apache Kafka®. 
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

Получает список хостов для указанного кластера Apache Kafka®.

**rpc ListHosts ([ListClusterHostsRequest](#ListClusterHostsRequest)) returns ([ListClusterHostsResponse](#ListClusterHostsResponse))**

### ListClusterHostsRequest {#ListClusterHostsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Apache Kafka®. <br>Чтобы получить идентификатор кластера Apache Kafka®, выполните запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
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
cluster_id | **string**<br>Идентификатор кластера Apache Kafka®. 
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится хост. 
role | enum **Role**<br>Роль хоста. <ul><li>`KAFKA`: хост — брокер Kafka.</li><li>`ZOOKEEPER`: хост — сервер ZooKeeper.</li><ul/>
resources | **[Resources](#Resources)**<br>Вычислительные ресурсы, выделенные хосту. 
health | enum **Health**<br>Агрегированные данные о работоспособности хоста. <ul><li>`UNKNOWN`: состояние хоста неизвестно.</li><li>`ALIVE`: хост работает и выполняет все свои функции.</li><li>`DEAD`: хост не работает и не выполняет свои функции.</li><li>`DEGRADED`: хост находится в состоянии деградации и может выполнять только некоторые свои функции.</li><ul/>
subnet_id | **string**<br>Идентификатор подсети, в которой находится хост. 
assign_public_ip | **bool**<br>Флаг, определяющий, назначен ли хосту публичный IP-адрес. <br>Если значение равно `true`, то этот хост доступен в Интернете через его публичный IP-адрес. 


### Resources {#Resources}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [документации](/docs/managed-kafka/concepts/instance-types). 
disk_size | **int64**<br>Объем хранилища, доступного хосту, в байтах. 
disk_type_id | **string**<br>Тип хранилища для хоста. 


