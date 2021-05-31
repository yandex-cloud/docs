---
editable: false
---

# ClusterService

Набор методов для управления ресурсами Cluster для PostgreSQL.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанный ресурс Cluster для PostgreSQL. |
| [List](#List) | Получает список ресурсов Cluster для PostgreSQL, принадлежащих указанному каталогу. |
| [Create](#Create) | Создает кластер PostgreSQL в указанном каталоге. |
| [Update](#Update) | Изменяет указанный кластер PostgreSQL. |
| [Delete](#Delete) | Удаляет указанный кластер PostgreSQL. |
| [Start](#Start) | Запускает указанный кластер PostgreSQL. |
| [Stop](#Stop) | Останавливает указанный кластер PostgreSQL. |
| [Move](#Move) | Перемещает кластер PostgreSQL в указанный каталог. |
| [Backup](#Backup) | Создает резервную копию для указанного кластера PostgreSQL. |
| [Restore](#Restore) | Создает новый кластер PostgreSQL с использованием указанной резервной копии. |
| [StartFailover](#StartFailover) | Запускает ручное переключение мастера для указанного кластера PostgreSQL. |
| [ListLogs](#ListLogs) | Получает логи для указанного кластера PostgreSQL. |
| [ListOperations](#ListOperations) | Получает список ресурсов Operation для указанного кластера. |
| [ListBackups](#ListBackups) | Получает список доступных резервных копий для указанного кластера PostgreSQL. |
| [ListHosts](#ListHosts) | Получает список хостов для указанного кластера. |
| [AddHosts](#AddHosts) | Создает новые хосты для кластера. |
| [DeleteHosts](#DeleteHosts) | Удаляет указанные хосты кластера. |
| [UpdateHosts](#UpdateHosts) | Обновляет указанные хосты. |

## Вызовы ClusterService {#calls}

## Get {#Get}

Возвращает указанный ресурс Cluster для PostgreSQL. <br>Чтобы получить список доступных ресурсов Cluster для PostgreSQL, отправьте запрос [List](#List).

**rpc Get ([GetClusterRequest](#GetClusterRequest)) returns ([Cluster](#Cluster))**

### GetClusterRequest {#GetClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор возвращаемого ресурса Cluster для PostgreSQL. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.


### Cluster {#Cluster}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера PostgreSQL. Этот идентификатор генерирует MDB при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер PostgreSQL. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера PostgreSQL. Имя уникально в рамках каталога. Длина 1-63 символов. 
description | **string**<br>Описание кластера PostgreSQL. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера PostgreSQL в виде пар `` key:value ``. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания для кластера PostgreSQL. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring)**<br>Описание систем мониторинга, относящихся к данному кластеру PostgreSQL. 
config | **[ClusterConfig](#ClusterConfig)**<br>Конфигурация кластера PostgreSQL. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Агрегированная работоспособность кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](#Host) для каждого хоста в кластере — UNKNOWN).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](#Host) для каждого хоста в кластере — ALIVE).</li><li>`DEAD`: Кластер не работает ([Host.health](#Host) для каждого узла в кластере — DEAD).</li><li>`DEGRADED`: Кластер работает неоптимально ([Host.health](#Host) по крайней мере для одного узла в кластере не ALIVE).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: На кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>


### Monitoring {#Monitoring}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для данного кластера PostgreSQL. 


### ClusterConfig {#ClusterConfig}

Поле | Описание
--- | ---
version | **string**<br>Версия серверного программного обеспечения PostgreSQL. 
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12` или `postgresql_config_12_1c`<br>Конфигурация для серверов PostgreSQL в кластере.
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlConfigSet9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql9_6.proto)**<br>Конфигурация сервера PostgreSQL 9.6. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlConfigSet10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10_1c.proto)**<br>Конфигурация сервера PostgreSQL 10 1С. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlConfigSet10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10.proto)**<br>Конфигурация сервера PostgreSQL 10. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlConfigSet11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11.proto)**<br>Конфигурация сервера PostgreSQL 11. 
&nbsp;&nbsp;postgresql_config_11_1c | **[config.PostgresqlConfigSet11_1C](./config/host10#PostgresqlConfigSet11_1C)**<br>Конфигурация сервера PostgreSQL 11 1C. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlConfigSet12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12.proto)**<br>Конфигурация сервера PostgreSQL 12. 
&nbsp;&nbsp;postgresql_config_12_1c | **[config.PostgresqlConfigSet12_1C](./config/host10#PostgresqlConfigSet12_1C)**<br>Конфигурация сервера PostgreSQL 12 1C. 
pooler_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig)**<br>Конфигурация менеджера соединений. 
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные хостам PostgreSQL. 
autofailover | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Параметр конфигурации, который включает / отключает автоматическое переключение мастера в кластере. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access)**<br>Политика доступа к БД 


### ConnectionPoolerConfig {#ConnectionPoolerConfig}

Поле | Описание
--- | ---
pooling_mode | enum **PoolingMode**<br>Режим, в котором работает менеджер подключений. См. описание всех режимов в [документации PgBouncer](https://pgbouncer.github.io/usage). <ul><li>`SESSION`: Сессионный режим управления подключениями.</li><li>`TRANSACTION`: Транзакционный режим управления подключениями.</li><li>`STATEMENT`: Операторный режим управления подключениями.</li><ul/>
pool_discard | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Установка параметра `server_reset_query_always` в PgBouncer. 


### Resources {#Resources}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [документации](/docs/managed-postgresql/concepts/instance-types). 
disk_size | **int64**<br>Объем хранилища, доступного хосту, в байтах. 
disk_type_id | **string**<br><ul><li>network-hdd — сетевой HDD-диск; </li><li>network-ssd — сетевой SSD-диск; </li><li>local-ssd — локальное SSD-хранилище.</li></ul> 


### Access {#Access}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить доступ для DataLens 
serverless | **bool**<br>Разрешить доступ для Serverless 


## List {#List}

Получает список ресурсов Cluster для PostgreSQL, принадлежащих указанному каталогу.

**rpc List ([ListClustersRequest](#ListClustersRequest)) returns ([ListClustersResponse](#ListClustersResponse))**

### ListClustersRequest {#ListClustersRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога для вывода списка кластеров PostgreSQL. Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListClustersResponse.next_page_token](#ListClustersResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListClustersResponse.next_page_token](#ListClustersResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br><ol><li>Имя поля. В настоящее время фильтрацию можно использовать только с полем [Cluster.name](#Cluster1). </li><li>Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. </li><li>Значение. Должен содержать от 1 до 63 символов и соответствовать регулярному выражению `^[a-zA-Z0-9_-]+$`.</li></ol> Максимальная длина строки в символах — 1000.


### ListClustersResponse {#ListClustersResponse}

Поле | Описание
--- | ---
clusters[] | **[Cluster](#Cluster1)**<br>Список ресурсов Cluster для PostgreSQL. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListClustersRequest.page_size](#ListClustersRequest), используйте `next_page_token` в качестве значения параметра [ListClustersRequest.page_token](#ListClustersRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Cluster {#Cluster1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера PostgreSQL. Этот идентификатор генерирует MDB при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер PostgreSQL. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера PostgreSQL. Имя уникально в рамках каталога. Длина 1-63 символов. 
description | **string**<br>Описание кластера PostgreSQL. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера PostgreSQL в виде пар `` key:value ``. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания для кластера PostgreSQL. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring1)**<br>Описание систем мониторинга, относящихся к данному кластеру PostgreSQL. 
config | **[ClusterConfig](#ClusterConfig1)**<br>Конфигурация кластера PostgreSQL. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Агрегированная работоспособность кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](#Host) для каждого хоста в кластере — UNKNOWN).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](#Host) для каждого хоста в кластере — ALIVE).</li><li>`DEAD`: Кластер не работает ([Host.health](#Host) для каждого узла в кластере — DEAD).</li><li>`DEGRADED`: Кластер работает неоптимально ([Host.health](#Host) по крайней мере для одного узла в кластере не ALIVE).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: На кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>


### Monitoring {#Monitoring1}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для данного кластера PostgreSQL. 


### ClusterConfig {#ClusterConfig1}

Поле | Описание
--- | ---
version | **string**<br>Версия серверного программного обеспечения PostgreSQL. 
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12` или `postgresql_config_12_1c`<br>Конфигурация для серверов PostgreSQL в кластере.
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlConfigSet9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql9_6.proto)**<br>Конфигурация сервера PostgreSQL 9.6. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlConfigSet10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10_1c.proto)**<br>Конфигурация сервера PostgreSQL 10 1С. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlConfigSet10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10.proto)**<br>Конфигурация сервера PostgreSQL 10. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlConfigSet11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11.proto)**<br>Конфигурация сервера PostgreSQL 11. 
&nbsp;&nbsp;postgresql_config_11_1c | **[config.PostgresqlConfigSet11_1C](./config/host10#PostgresqlConfigSet11_1C)**<br>Конфигурация сервера PostgreSQL 11 1C. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlConfigSet12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12.proto)**<br>Конфигурация сервера PostgreSQL 12. 
&nbsp;&nbsp;postgresql_config_12_1c | **[config.PostgresqlConfigSet12_1C](./config/host10#PostgresqlConfigSet12_1C)**<br>Конфигурация сервера PostgreSQL 12 1C. 
pooler_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig1)**<br>Конфигурация менеджера соединений. 
resources | **[Resources](#Resources1)**<br>Ресурсы, выделенные хостам PostgreSQL. 
autofailover | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Параметр конфигурации, который включает / отключает автоматическое переключение мастера в кластере. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access1)**<br>Политика доступа к БД 


### ConnectionPoolerConfig {#ConnectionPoolerConfig1}

Поле | Описание
--- | ---
pooling_mode | enum **PoolingMode**<br>Режим, в котором работает менеджер подключений. См. описание всех режимов в [документации PgBouncer](https://pgbouncer.github.io/usage). <ul><li>`SESSION`: Сессионный режим управления подключениями.</li><li>`TRANSACTION`: Транзакционный режим управления подключениями.</li><li>`STATEMENT`: Операторный режим управления подключениями.</li><ul/>
pool_discard | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Установка параметра `server_reset_query_always` в PgBouncer. 


### Resources {#Resources1}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [документации](/docs/managed-postgresql/concepts/instance-types). 
disk_size | **int64**<br>Объем хранилища, доступного хосту, в байтах. 
disk_type_id | **string**<br><ul><li>network-hdd — сетевой HDD-диск; </li><li>network-ssd — сетевой SSD-диск; </li><li>local-ssd — локальное SSD-хранилище.</li></ul> 


### Access {#Access1}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить доступ для DataLens 
serverless | **bool**<br>Разрешить доступ для Serverless 


## Create {#Create}

Создает кластер PostgreSQL в указанном каталоге.

**rpc Create ([CreateClusterRequest](#CreateClusterRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateClusterMetadata](#CreateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster2)<br>

### CreateClusterRequest {#CreateClusterRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога, в котором нужно создать кластер PostgreSQL. Максимальная длина строки в символах — 50.
name | **string**<br>Обязательное поле. Имя кластера PostgreSQL. Имя должно быть уникальным в каталоге. Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.
description | **string**<br>Описание кластера PostgreSQL. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Пользовательские метки для кластера PostgreSQL в виде пар `` key:value ``. Не больше 64 меток на ресурс. Например, "project": "mvp" или "source": "dictionary". Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Максимальная длина строки в символах для каждого ключа — 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
environment | **[Cluster.Environment](#Cluster2)**<br>Обязательное поле. Среда развертывания для кластера PostgreSQL. 
config_spec | **[ConfigSpec](#ConfigSpec)**<br>Обязательное поле. Конфигурация и ресурсы для хостов, которые должны быть созданы для кластера PostgreSQL. 
database_specs[] | **[DatabaseSpec](#DatabaseSpec)**<br>Обязательное поле. Описания баз данных, которые нужно создать в кластере PostgreSQL. 
user_specs[] | **[UserSpec](#UserSpec)**<br>Обязательное поле. Описания пользователей базы данных, которых нужно создать в кластере PostgreSQL. 
host_specs[] | **[HostSpec](#HostSpec)**<br>Обязательное поле. Конфигурации для отдельных хостов, которые должны быть созданы для кластера PostgreSQL. 
network_id | **string**<br>Обязательное поле. Идентификатор сети, в которой нужно создать кластер. Максимальная длина строки в символах — 50.


### ConfigSpec {#ConfigSpec}

Поле | Описание
--- | ---
version | **string**<br>Версия PostgreSQL, используемая в кластере. Возможные значения `9.6`, `10`, `10_1c`, `11`, `12`. 
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12` или `postgresql_config_12_1c`<br>Конфигурация кластера PostgreSQL.
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlConfig9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql9_6.proto)**<br>Конфигурация для кластера PostgreSQL 9.6. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlConfig10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10_1c.proto)**<br>Конфигурация для кластера PostgreSQL 10. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlConfig10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10.proto)**<br>Конфигурация для кластера PostgreSQL 10. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlConfig11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11.proto)**<br>Конфигурация для кластера PostgreSQL 11. 
&nbsp;&nbsp;postgresql_config_11_1c | **[config.PostgresqlConfig11_1C](./config/host10#PostgresqlConfig11_1C)**<br>Конфигурация для кластера PostgreSQL 11 1C. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlConfig12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12.proto)**<br>Конфигурация для кластера PostgreSQL 12. 
&nbsp;&nbsp;postgresql_config_12_1c | **[config.PostgresqlConfig12_1C](./config/host10#PostgresqlConfig12_1C)**<br>Конфигурация для кластера PostgreSQL 12 1C. 
pooler_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig2)**<br>Конфигурация менеджера соединений. 
resources | **[Resources](#Resources2)**<br>Ресурсы, выделенные хостам PostgreSQL. 
autofailover | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Параметр конфигурации, который включает / отключает автоматическое переключение мастера в кластере. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access2)**<br>Политика доступа к БД 


### ConnectionPoolerConfig {#ConnectionPoolerConfig2}

Поле | Описание
--- | ---
pooling_mode | enum **PoolingMode**<br>Режим, в котором работает менеджер подключений. См. описание всех режимов в [документации PgBouncer](https://pgbouncer.github.io/usage). <ul><li>`SESSION`: Сессионный режим управления подключениями.</li><li>`TRANSACTION`: Транзакционный режим управления подключениями.</li><li>`STATEMENT`: Операторный режим управления подключениями.</li><ul/>
pool_discard | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Установка параметра `server_reset_query_always` в PgBouncer. 


### Resources {#Resources2}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [документации](/docs/managed-postgresql/concepts/instance-types). 
disk_size | **int64**<br>Объем хранилища, доступного хосту, в байтах. 
disk_type_id | **string**<br><ul><li>network-hdd — сетевой HDD-диск; </li><li>network-ssd — сетевой SSD-диск; </li><li>local-ssd — локальное SSD-хранилище.</li></ul> 


### Access {#Access2}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить доступ для DataLens 
serverless | **bool**<br>Разрешить доступ для Serverless 


### DatabaseSpec {#DatabaseSpec}

Поле | Описание
--- | ---
name | **string**<br>Обязательное поле. Имя базы данных PostgreSQL. Длина 1-63 символов. Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.
owner | **string**<br>Обязательное поле. Имя пользователя, которого нужно назначить владельцем базы данных. Чтобы получить список доступных пользователей PostgreSQL, сделайте запрос [UserService.List](./user_service#List). Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.
lc_collate | **string**<br>POSIX-локаль для порядка сортировки строк. Может быть установлен только во время создания. Значение должно соответствовать регулярному выражению ` |[a-zA-Z_]+.UTF-8|C `.
lc_ctype | **string**<br>POSIX-локаль для классификации символов. Может быть установлена только во время создания. Значение должно соответствовать регулярному выражению ` |[a-zA-Z_]+.UTF-8|C `.
extensions[] | **[Extension](#Extension)**<br>Расширения PostgreSQL, которые следует подключить для базы данных. 


### Extension {#Extension}

Поле | Описание
--- | ---
name | **string**<br>Имя расширения, например `pg_trgm` или `pg_btree`. Расширения, которые поддерживает Managed Service for PostgreSQL, [перечислены в документации](/docs/managed-postgresql/operations/cluster-extensions). 
version | **string**<br>Версия расширения. 


### UserSpec {#UserSpec}

Поле | Описание
--- | ---
name | **string**<br>Обязательное поле. Имя пользователя PostgreSQL. Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.
password | **string**<br>Обязательное поле. Пароль пользователя PostgreSQL. Длина строки в символах должна быть от 8 до 128.
permissions[] | **[Permission](#Permission)**<br>Набор разрешений, предоставляемых пользователю для доступа к определенным базам данных. 
conn_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимальное количество подключений к базе данных, доступное пользователю. <br>При использовании сессионного пулинга эта настройка ограничивает количество подключений к каждому отдельному хосту в кластере PostgreSQL. В этом случае значение настройки должно быть больше общего числа подключений, которые могут быть открыты сервисами бэкенда для доступа к кластеру PostgreSQL. Значение этой настройки не должно превышать значения настройки [Cluster.config.postgresql_config_12.effective_config.max_connections](#Cluster2). <br>При использовании транзакционного пулинга эта настройка ограничивает количество активных транзакций пользователя, поэтому в этом режиме пользователь может открывать тысячи подключений, но одновременно будет установлено только `N` подключений, где `N` — значение настройки. <br>Минимальное значение: `10` (по умолчанию: `50`) при использовании сессионного пулинга. Минимальная значение — 10.
settings | **[UserSettings](#UserSettings)**<br>Настройки PostgreSQL для пользователя. 
login | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Этот флаг определяет, может ли пользователь войти в базу данных PostgreSQL. <br>Значение по умолчанию: `true` (вход разрешен). 
grants[] | **string**<br>Роли и права, предоставленные пользователю (`GRANT <роль> ТО  <пользователь>`). <br>Дополнительные сведения см. в [документации](/docs/managed-postgresql/operations/grant). Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.


### Permission {#Permission}

Поле | Описание
--- | ---
database_name | **string**<br>Имя базы данных, к которой предоставляет доступ разрешение. 


### UserSettings {#UserSettings}

Поле | Описание
--- | ---
default_transaction_isolation | enum **TransactionIsolation**<br>Для каждой транзакции в SQL устанавливается уровень изоляции. Эта настройка определяет уровень изоляции, который будет устанавливаться по умолчанию для новых транзакций SQL. <br>См. подробное описание в [документации PostgreSQL](https://www.postgresql.org/docs/current/transaction-iso.html). <ul><li>`TRANSACTION_ISOLATION_READ_UNCOMMITTED`: поведение этого уровня изоляции в PostgreSQL идентично `TRANSACTION_ISOLATION_READ_COMMITTED`.</li><li>`TRANSACTION_ISOLATION_READ_COMMITTED`: (по умолчанию) запрос видит только те строки, которые были зафиксированы до начала его выполнения.</li><li>`TRANSACTION_ISOLATION_REPEATABLE_READ`: все запросы в текущей транзакции видят только те строки, которые были зафиксированы перед первым выполненным в этой транзакции запросом `SELECT` или `INSERT`.</li><li>`TRANSACTION_ISOLATION_SERIALIZABLE`: обеспечивает самый строгий уровень изоляции транзакций. Все запросы в текущей транзакции видят только те строки, которые были зафиксированы перед первым выполнением запроса `SELECT` или `INSERT` в этой транзакции. Если наложение операций чтения и записи параллельных сериализуемых транзакций может привести к ситуации, невозможной при последовательном их выполнении, произойдет откат одной из транзакций с ошибкой сбоя сериализации.</li><ul/>
lock_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимальная длительность ожидания (в миллисекундах) любым оператором получения блокировки таблицы, индекса, строки или другого объекта базы данных. Если ожидание не закончилось за указанное время, оператор прерывается. <br>Значение по умолчанию: `0` (контроль длительности отключен, ожидать получения блокировки можно сколь угодно долго). 
log_min_duration_statement | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Эта настройка управляет логированием длительности выполнения команд SQL. <br>В лог записывается продолжительность выполнения всех команд, время обработки которых равно или превышает указанное в значении настройки количество миллисекунд. Например, при значении настройки `500`в лог не попадет выражение, выполнявшееся 300 миллисекунд, не будет регистрироваться, а выражение, выполнявшееся 2000 миллисекунд — попадет. <br>Значение `0` заставляет PostgreSQL записывать продолжительность работы всех команд. <br>Значение `-1` (по умолчанию) отключает запись продолжительности выполнения команд. <br>См. подробное описание в [документации PostgreSQL](https://www.postgresql.org/docs/current/runtime-config-logging.html). 
synchronous_commit | enum **SynchronousCommit**<br>Эта настройка определяет, будет ли СУБД выполнять операцию подтверждения транзакции синхронно. <br>Синхронность операции означает, что кластер будет ждать выполнения синхронных операций прежде чем подтвердить транзакцию клиенту. Эти операции гарантируют различные уровни сохранности и видимости данных в кластере. <br>См. подробное описание в [документации PostgreSQL](https://www.postgresql.org/docs/current/runtime-config-wal.html#GUC-SYNCHRONOUS-COMMIT). <ul><li>`SYNCHRONOUS_COMMIT_ON`: (по умолчанию) транзакция подтверждается, если данные попали в WAL (Write-Ahead Log) и он записан на диск мастера и на диск синхронной реплики.</li><li>`SYNCHRONOUS_COMMIT_OFF`: транзакция подтверждается, даже если данные еще не попали в WAL. Синхронной записи нет, данные о транзакции могут быть потеряны в результате сбоя дисковой подсистемы.</li><li>`SYNCHRONOUS_COMMIT_LOCAL`: транзакция подтверждается, если данные попали в WAL и он записан на диск мастера. Данные о транзакции могут быть потеряны в результате сбоя дисковой подсистемы мастера.</li><li>`SYNCHRONOUS_COMMIT_REMOTE_WRITE`: транзакция подтверждается, если WAL записан на диск мастера, синхронная реплика приняла WAL и передала его операционной системе для записи на диск. В случае потери дисковой системы мастера и сбоя операционной системы на реплике данные транзакции с таким уровнем синхронизации могут быть потеряны.</li><li>`SYNCHRONOUS_COMMIT_REMOTE_APPLY`: транзакция подтверждается, если WAL записан на диск мастера, синхронная реплика приняла WAL и применила изменения из него. Данные о транзакции могут быть потеряны из-за одновременного необратимого сбоя на мастере и его синхронной реплике.</li><ul/>
temp_file_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимальный объем дискового пространства (в килобайтах), который один процесс сможет использовать для временных файлов. Транзакция, которая попытается превысить этот предел, будет отменена. <br>Большие запросы из-за их размера выполняются PostgreSQL не в оперативной памяти, а на диске. Слишком большие запросы могут нагрузить диск и помешать выполнению других запросов. Эта настройка предотвращает выполнение запросов, которые могут сильно повлиять на производительность, ограничивая размер временных файлов. 
log_statement | enum **LogStatement**<br>Эта настройка определяет, какие команды SQL должны записываться в лог (на уровне пользователя). <br>См. подробное описание в [документации PostgreSQL](https://www.postgresql.org/docs/current/runtime-config-logging.html). <ul><li>`LOG_STATEMENT_NONE`: (по умолчанию) фильтр отключен, команды SQL не записываются в лог.</li><li>`LOG_STATEMENT_DDL`: в лог записываются команды SQL, которые позволяют изменять определения данных (такие как `CREATE`, `ALTER`, `DROP` и другие).</li><li>`LOG_STATEMENT_MOD`: в лог записываются команды SQL, попадающие под фильтр `LOG_STATEMENT_DDL`, и команды, позволяющие изменять данные (такие как `INSERT`, `UPDATE` и другие).</li><li>`LOG_STATEMENT_ALL`: в лог записываются все команды SQL.</li><ul/>


### HostSpec {#HostSpec}

Поле | Описание
--- | ---
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится хост. Чтобы получить список доступных зон, используйте запрос [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List). Максимальная длина строки в символах — 50.
subnet_id | **string**<br>Идентификатор подсети, к которой должен принадлежать хост. Эта подсеть должна быть частью сети, к которой принадлежит кластер. Идентификатор сети задан в поле [Cluster.network_id](#Cluster2). Максимальная длина строки в символах — 50.
assign_public_ip | **bool**<br><ul><li>false — не назначать хосту публичный IP-адрес. </li><li>true — у хоста должен быть публичный IP-адрес.</li></ul> 
replication_source | **string**<br>[Host.name](#Host) of the host to be used as the replication source (for cascading replication). 
priority | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Приоритет хоста как реплики. Большее значение соответствует более высокому приоритету. <br>Хост с наивысшим приоритетом является синхронной репликой. Все остальные асинхронны. Синхронная реплика при необходимости заменяет мастер. <br>Когда реплика становится мастером, ее приоритет игнорируется. 
config_spec | **[ConfigHostSpec](#ConfigHostSpec)**<br>Конфигурация сервера PostgreSQL для хоста. 


### ConfigHostSpec {#ConfigHostSpec}

Поле | Описание
--- | ---
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12` или `postgresql_config_12_1c`<br>
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlHostConfig9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host9_6.proto)**<br>Конфигурация для хоста, на котором развернут сервером PostgreSQL 9.6. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlHostConfig10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host10_1c.proto)**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 10 1С. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlHostConfig10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host10.proto)**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 10. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlHostConfig11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host11.proto)**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 11. 
&nbsp;&nbsp;postgresql_config_11_1c | **[config.PostgresqlHostConfig11_1C](./config/host10#PostgresqlHostConfig11_1C)**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 11 1C. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlHostConfig12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host12.proto)**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 12. 
&nbsp;&nbsp;postgresql_config_12_1c | **[config.PostgresqlHostConfig12_1C](./config/host10#PostgresqlHostConfig12_1C)**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 12 1C. 


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
cluster_id | **string**<br>Идентификатор создаваемого кластера PostgreSQL. 


### Cluster {#Cluster2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера PostgreSQL. Этот идентификатор генерирует MDB при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер PostgreSQL. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера PostgreSQL. Имя уникально в рамках каталога. Длина 1-63 символов. 
description | **string**<br>Описание кластера PostgreSQL. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера PostgreSQL в виде пар `` key:value ``. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания для кластера PostgreSQL. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Описание систем мониторинга, относящихся к данному кластеру PostgreSQL. 
config | **[ClusterConfig](#ClusterConfig2)**<br>Конфигурация кластера PostgreSQL. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Агрегированная работоспособность кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](#Host) для каждого хоста в кластере — UNKNOWN).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](#Host) для каждого хоста в кластере — ALIVE).</li><li>`DEAD`: Кластер не работает ([Host.health](#Host) для каждого узла в кластере — DEAD).</li><li>`DEGRADED`: Кластер работает неоптимально ([Host.health](#Host) по крайней мере для одного узла в кластере не ALIVE).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: На кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>


### Monitoring {#Monitoring2}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для данного кластера PostgreSQL. 


### ClusterConfig {#ClusterConfig2}

Поле | Описание
--- | ---
version | **string**<br>Версия серверного программного обеспечения PostgreSQL. 
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12` или `postgresql_config_12_1c`<br>Конфигурация для серверов PostgreSQL в кластере.
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlConfigSet9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql9_6.proto)**<br>Конфигурация сервера PostgreSQL 9.6. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlConfigSet10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10_1c.proto)**<br>Конфигурация сервера PostgreSQL 10 1С. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlConfigSet10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10.proto)**<br>Конфигурация сервера PostgreSQL 10. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlConfigSet11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11.proto)**<br>Конфигурация сервера PostgreSQL 11. 
&nbsp;&nbsp;postgresql_config_11_1c | **[config.PostgresqlConfigSet11_1C](./config/host10#PostgresqlConfigSet11_1C)**<br>Конфигурация сервера PostgreSQL 11 1C. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlConfigSet12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12.proto)**<br>Конфигурация сервера PostgreSQL 12. 
&nbsp;&nbsp;postgresql_config_12_1c | **[config.PostgresqlConfigSet12_1C](./config/host10#PostgresqlConfigSet12_1C)**<br>Конфигурация сервера PostgreSQL 12 1C. 
pooler_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig3)**<br>Конфигурация менеджера соединений. 
resources | **[Resources](#Resources3)**<br>Ресурсы, выделенные хостам PostgreSQL. 
autofailover | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Параметр конфигурации, который включает / отключает автоматическое переключение мастера в кластере. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access3)**<br>Политика доступа к БД 


### ConnectionPoolerConfig {#ConnectionPoolerConfig3}

Поле | Описание
--- | ---
pooling_mode | enum **PoolingMode**<br>Режим, в котором работает менеджер подключений. См. описание всех режимов в [документации PgBouncer](https://pgbouncer.github.io/usage). <ul><li>`SESSION`: Сессионный режим управления подключениями.</li><li>`TRANSACTION`: Транзакционный режим управления подключениями.</li><li>`STATEMENT`: Операторный режим управления подключениями.</li><ul/>
pool_discard | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Установка параметра `server_reset_query_always` в PgBouncer. 


### Resources {#Resources3}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [документации](/docs/managed-postgresql/concepts/instance-types). 
disk_size | **int64**<br>Объем хранилища, доступного хосту, в байтах. 
disk_type_id | **string**<br><ul><li>network-hdd — сетевой HDD-диск; </li><li>network-ssd — сетевой SSD-диск; </li><li>local-ssd — локальное SSD-хранилище.</li></ul> 


### Access {#Access3}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить доступ для DataLens 
serverless | **bool**<br>Разрешить доступ для Serverless 


## Update {#Update}

Изменяет указанный кластер PostgreSQL.

**rpc Update ([UpdateClusterRequest](#UpdateClusterRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterMetadata](#UpdateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster3)<br>

### UpdateClusterRequest {#UpdateClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор изменяемого ресурса Cluster для PostgreSQL, который нужно изменить. Чтобы получить идентификатор PostgreSQL кластера, используйте запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска, которая указывает, какие поля ресурса Cluster для PostgreSQL должны быть изменены. 
description | **string**<br>Новое описание кластера PostgreSQL. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Пользовательские метки для кластера PostgreSQL в виде пар `` key:value ``. Не больше 64 меток на ресурс. Например, "project": "mvp" или "source": "dictionary". <br>Новый набор меток полностью заменит старый. Чтобы добавить метку, запросите текущий набор меток с помощью метода [ClusterService.Get](#Get), затем отправьте запрос [ClusterService.Update](#Update), добавив новую метку в этот набор. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Максимальная длина строки в символах для каждого ключа — 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
config_spec | **[ConfigSpec](#ConfigSpec)**<br>Новая конфигурация и ресурсы для хостов кластера. 
name | **string**<br>Новое имя кластера. Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.


### ConfigSpec {#ConfigSpec1}

Поле | Описание
--- | ---
version | **string**<br>Версия PostgreSQL, используемая в кластере. Возможные значения `9.6`, `10`, `10_1c`, `11`, `12`. 
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12` или `postgresql_config_12_1c`<br>Конфигурация кластера PostgreSQL.
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlConfig9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql9_6.proto)**<br>Конфигурация для кластера PostgreSQL 9.6. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlConfig10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10_1c.proto)**<br>Конфигурация для кластера PostgreSQL 10. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlConfig10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10.proto)**<br>Конфигурация для кластера PostgreSQL 10. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlConfig11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11.proto)**<br>Конфигурация для кластера PostgreSQL 11. 
&nbsp;&nbsp;postgresql_config_11_1c | **[config.PostgresqlConfig11_1C](./config/host10#PostgresqlConfig11_1C)**<br>Конфигурация для кластера PostgreSQL 11 1C. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlConfig12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12.proto)**<br>Конфигурация для кластера PostgreSQL 12. 
&nbsp;&nbsp;postgresql_config_12_1c | **[config.PostgresqlConfig12_1C](./config/host10#PostgresqlConfig12_1C)**<br>Конфигурация для кластера PostgreSQL 12 1C. 
pooler_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig4)**<br>Конфигурация менеджера соединений. 
resources | **[Resources](#Resources4)**<br>Ресурсы, выделенные хостам PostgreSQL. 
autofailover | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Параметр конфигурации, который включает / отключает автоматическое переключение мастера в кластере. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access4)**<br>Политика доступа к БД 


### ConnectionPoolerConfig {#ConnectionPoolerConfig4}

Поле | Описание
--- | ---
pooling_mode | enum **PoolingMode**<br>Режим, в котором работает менеджер подключений. См. описание всех режимов в [документации PgBouncer](https://pgbouncer.github.io/usage). <ul><li>`SESSION`: Сессионный режим управления подключениями.</li><li>`TRANSACTION`: Транзакционный режим управления подключениями.</li><li>`STATEMENT`: Операторный режим управления подключениями.</li><ul/>
pool_discard | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Установка параметра `server_reset_query_always` в PgBouncer. 


### Resources {#Resources4}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [документации](/docs/managed-postgresql/concepts/instance-types). 
disk_size | **int64**<br>Объем хранилища, доступного хосту, в байтах. 
disk_type_id | **string**<br><ul><li>network-hdd — сетевой HDD-диск; </li><li>network-ssd — сетевой SSD-диск; </li><li>local-ssd — локальное SSD-хранилище.</li></ul> 


### Access {#Access4}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить доступ для DataLens 
serverless | **bool**<br>Разрешить доступ для Serverless 


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
cluster_id | **string**<br>Идентификатор изменяемого ресурса Cluster для PostgreSQL. 


### Cluster {#Cluster3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера PostgreSQL. Этот идентификатор генерирует MDB при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер PostgreSQL. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера PostgreSQL. Имя уникально в рамках каталога. Длина 1-63 символов. 
description | **string**<br>Описание кластера PostgreSQL. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера PostgreSQL в виде пар `` key:value ``. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания для кластера PostgreSQL. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring3)**<br>Описание систем мониторинга, относящихся к данному кластеру PostgreSQL. 
config | **[ClusterConfig](#ClusterConfig3)**<br>Конфигурация кластера PostgreSQL. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Агрегированная работоспособность кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](#Host) для каждого хоста в кластере — UNKNOWN).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](#Host) для каждого хоста в кластере — ALIVE).</li><li>`DEAD`: Кластер не работает ([Host.health](#Host) для каждого узла в кластере — DEAD).</li><li>`DEGRADED`: Кластер работает неоптимально ([Host.health](#Host) по крайней мере для одного узла в кластере не ALIVE).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: На кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>


### Monitoring {#Monitoring3}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для данного кластера PostgreSQL. 


### ClusterConfig {#ClusterConfig3}

Поле | Описание
--- | ---
version | **string**<br>Версия серверного программного обеспечения PostgreSQL. 
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12` или `postgresql_config_12_1c`<br>Конфигурация для серверов PostgreSQL в кластере.
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlConfigSet9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql9_6.proto)**<br>Конфигурация сервера PostgreSQL 9.6. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlConfigSet10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10_1c.proto)**<br>Конфигурация сервера PostgreSQL 10 1С. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlConfigSet10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10.proto)**<br>Конфигурация сервера PostgreSQL 10. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlConfigSet11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11.proto)**<br>Конфигурация сервера PostgreSQL 11. 
&nbsp;&nbsp;postgresql_config_11_1c | **[config.PostgresqlConfigSet11_1C](./config/host10#PostgresqlConfigSet11_1C)**<br>Конфигурация сервера PostgreSQL 11 1C. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlConfigSet12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12.proto)**<br>Конфигурация сервера PostgreSQL 12. 
&nbsp;&nbsp;postgresql_config_12_1c | **[config.PostgresqlConfigSet12_1C](./config/host10#PostgresqlConfigSet12_1C)**<br>Конфигурация сервера PostgreSQL 12 1C. 
pooler_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig5)**<br>Конфигурация менеджера соединений. 
resources | **[Resources](#Resources5)**<br>Ресурсы, выделенные хостам PostgreSQL. 
autofailover | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Параметр конфигурации, который включает / отключает автоматическое переключение мастера в кластере. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access5)**<br>Политика доступа к БД 


### ConnectionPoolerConfig {#ConnectionPoolerConfig5}

Поле | Описание
--- | ---
pooling_mode | enum **PoolingMode**<br>Режим, в котором работает менеджер подключений. См. описание всех режимов в [документации PgBouncer](https://pgbouncer.github.io/usage). <ul><li>`SESSION`: Сессионный режим управления подключениями.</li><li>`TRANSACTION`: Транзакционный режим управления подключениями.</li><li>`STATEMENT`: Операторный режим управления подключениями.</li><ul/>
pool_discard | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Установка параметра `server_reset_query_always` в PgBouncer. 


### Resources {#Resources5}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [документации](/docs/managed-postgresql/concepts/instance-types). 
disk_size | **int64**<br>Объем хранилища, доступного хосту, в байтах. 
disk_type_id | **string**<br><ul><li>network-hdd — сетевой HDD-диск; </li><li>network-ssd — сетевой SSD-диск; </li><li>local-ssd — локальное SSD-хранилище.</li></ul> 


### Access {#Access5}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить доступ для DataLens 
serverless | **bool**<br>Разрешить доступ для Serverless 


## Delete {#Delete}

Удаляет указанный кластер PostgreSQL.

**rpc Delete ([DeleteClusterRequest](#DeleteClusterRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterMetadata](#DeleteClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterRequest {#DeleteClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера PostgreSQL, который следует удалить. Чтобы получить идентификатор PostgreSQL кластера, используйте запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.


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
cluster_id | **string**<br>Идентификатор удаляемого кластера PostgreSQL. 


## Start {#Start}

Запускает указанный кластер PostgreSQL.

**rpc Start ([StartClusterRequest](#StartClusterRequest)) returns ([operation.Operation](#Operation3))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartClusterMetadata](#StartClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster4)<br>

### StartClusterRequest {#StartClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера PostgreSQL, который следует запустить. Максимальная длина строки в символах — 50.


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
cluster_id | **string**<br>Идентификатор кластера PostgreSQL. 


### Cluster {#Cluster4}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера PostgreSQL. Этот идентификатор генерирует MDB при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер PostgreSQL. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера PostgreSQL. Имя уникально в рамках каталога. Длина 1-63 символов. 
description | **string**<br>Описание кластера PostgreSQL. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера PostgreSQL в виде пар `` key:value ``. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания для кластера PostgreSQL. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring4)**<br>Описание систем мониторинга, относящихся к данному кластеру PostgreSQL. 
config | **[ClusterConfig](#ClusterConfig4)**<br>Конфигурация кластера PostgreSQL. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Агрегированная работоспособность кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](#Host) для каждого хоста в кластере — UNKNOWN).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](#Host) для каждого хоста в кластере — ALIVE).</li><li>`DEAD`: Кластер не работает ([Host.health](#Host) для каждого узла в кластере — DEAD).</li><li>`DEGRADED`: Кластер работает неоптимально ([Host.health](#Host) по крайней мере для одного узла в кластере не ALIVE).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: На кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>


### Monitoring {#Monitoring4}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для данного кластера PostgreSQL. 


### ClusterConfig {#ClusterConfig4}

Поле | Описание
--- | ---
version | **string**<br>Версия серверного программного обеспечения PostgreSQL. 
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12` или `postgresql_config_12_1c`<br>Конфигурация для серверов PostgreSQL в кластере.
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlConfigSet9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql9_6.proto)**<br>Конфигурация сервера PostgreSQL 9.6. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlConfigSet10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10_1c.proto)**<br>Конфигурация сервера PostgreSQL 10 1С. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlConfigSet10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10.proto)**<br>Конфигурация сервера PostgreSQL 10. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlConfigSet11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11.proto)**<br>Конфигурация сервера PostgreSQL 11. 
&nbsp;&nbsp;postgresql_config_11_1c | **[config.PostgresqlConfigSet11_1C](./config/host10#PostgresqlConfigSet11_1C)**<br>Конфигурация сервера PostgreSQL 11 1C. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlConfigSet12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12.proto)**<br>Конфигурация сервера PostgreSQL 12. 
&nbsp;&nbsp;postgresql_config_12_1c | **[config.PostgresqlConfigSet12_1C](./config/host10#PostgresqlConfigSet12_1C)**<br>Конфигурация сервера PostgreSQL 12 1C. 
pooler_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig6)**<br>Конфигурация менеджера соединений. 
resources | **[Resources](#Resources6)**<br>Ресурсы, выделенные хостам PostgreSQL. 
autofailover | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Параметр конфигурации, который включает / отключает автоматическое переключение мастера в кластере. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access6)**<br>Политика доступа к БД 


### ConnectionPoolerConfig {#ConnectionPoolerConfig6}

Поле | Описание
--- | ---
pooling_mode | enum **PoolingMode**<br>Режим, в котором работает менеджер подключений. См. описание всех режимов в [документации PgBouncer](https://pgbouncer.github.io/usage). <ul><li>`SESSION`: Сессионный режим управления подключениями.</li><li>`TRANSACTION`: Транзакционный режим управления подключениями.</li><li>`STATEMENT`: Операторный режим управления подключениями.</li><ul/>
pool_discard | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Установка параметра `server_reset_query_always` в PgBouncer. 


### Resources {#Resources6}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [документации](/docs/managed-postgresql/concepts/instance-types). 
disk_size | **int64**<br>Объем хранилища, доступного хосту, в байтах. 
disk_type_id | **string**<br><ul><li>network-hdd — сетевой HDD-диск; </li><li>network-ssd — сетевой SSD-диск; </li><li>local-ssd — локальное SSD-хранилище.</li></ul> 


### Access {#Access6}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить доступ для DataLens 
serverless | **bool**<br>Разрешить доступ для Serverless 


## Stop {#Stop}

Останавливает указанный кластер PostgreSQL.

**rpc Stop ([StopClusterRequest](#StopClusterRequest)) returns ([operation.Operation](#Operation4))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopClusterMetadata](#StopClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster5)<br>

### StopClusterRequest {#StopClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера PostgreSQL, который следует остановить. Максимальная длина строки в символах — 50.


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
cluster_id | **string**<br>Идентификатор кластера PostgreSQL. 


### Cluster {#Cluster5}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера PostgreSQL. Этот идентификатор генерирует MDB при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер PostgreSQL. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера PostgreSQL. Имя уникально в рамках каталога. Длина 1-63 символов. 
description | **string**<br>Описание кластера PostgreSQL. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера PostgreSQL в виде пар `` key:value ``. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания для кластера PostgreSQL. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring5)**<br>Описание систем мониторинга, относящихся к данному кластеру PostgreSQL. 
config | **[ClusterConfig](#ClusterConfig5)**<br>Конфигурация кластера PostgreSQL. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Агрегированная работоспособность кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](#Host) для каждого хоста в кластере — UNKNOWN).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](#Host) для каждого хоста в кластере — ALIVE).</li><li>`DEAD`: Кластер не работает ([Host.health](#Host) для каждого узла в кластере — DEAD).</li><li>`DEGRADED`: Кластер работает неоптимально ([Host.health](#Host) по крайней мере для одного узла в кластере не ALIVE).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: На кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>


### Monitoring {#Monitoring5}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для данного кластера PostgreSQL. 


### ClusterConfig {#ClusterConfig5}

Поле | Описание
--- | ---
version | **string**<br>Версия серверного программного обеспечения PostgreSQL. 
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12` или `postgresql_config_12_1c`<br>Конфигурация для серверов PostgreSQL в кластере.
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlConfigSet9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql9_6.proto)**<br>Конфигурация сервера PostgreSQL 9.6. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlConfigSet10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10_1c.proto)**<br>Конфигурация сервера PostgreSQL 10 1С. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlConfigSet10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10.proto)**<br>Конфигурация сервера PostgreSQL 10. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlConfigSet11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11.proto)**<br>Конфигурация сервера PostgreSQL 11. 
&nbsp;&nbsp;postgresql_config_11_1c | **[config.PostgresqlConfigSet11_1C](./config/host10#PostgresqlConfigSet11_1C)**<br>Конфигурация сервера PostgreSQL 11 1C. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlConfigSet12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12.proto)**<br>Конфигурация сервера PostgreSQL 12. 
&nbsp;&nbsp;postgresql_config_12_1c | **[config.PostgresqlConfigSet12_1C](./config/host10#PostgresqlConfigSet12_1C)**<br>Конфигурация сервера PostgreSQL 12 1C. 
pooler_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig7)**<br>Конфигурация менеджера соединений. 
resources | **[Resources](#Resources7)**<br>Ресурсы, выделенные хостам PostgreSQL. 
autofailover | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Параметр конфигурации, который включает / отключает автоматическое переключение мастера в кластере. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access7)**<br>Политика доступа к БД 


### ConnectionPoolerConfig {#ConnectionPoolerConfig7}

Поле | Описание
--- | ---
pooling_mode | enum **PoolingMode**<br>Режим, в котором работает менеджер подключений. См. описание всех режимов в [документации PgBouncer](https://pgbouncer.github.io/usage). <ul><li>`SESSION`: Сессионный режим управления подключениями.</li><li>`TRANSACTION`: Транзакционный режим управления подключениями.</li><li>`STATEMENT`: Операторный режим управления подключениями.</li><ul/>
pool_discard | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Установка параметра `server_reset_query_always` в PgBouncer. 


### Resources {#Resources7}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [документации](/docs/managed-postgresql/concepts/instance-types). 
disk_size | **int64**<br>Объем хранилища, доступного хосту, в байтах. 
disk_type_id | **string**<br><ul><li>network-hdd — сетевой HDD-диск; </li><li>network-ssd — сетевой SSD-диск; </li><li>local-ssd — локальное SSD-хранилище.</li></ul> 


### Access {#Access7}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить доступ для DataLens 
serverless | **bool**<br>Разрешить доступ для Serverless 


## Move {#Move}

Перемещает кластер PostgreSQL в указанный каталог.

**rpc Move ([MoveClusterRequest](#MoveClusterRequest)) returns ([operation.Operation](#Operation5))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[MoveClusterMetadata](#MoveClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster6)<br>

### MoveClusterRequest {#MoveClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера PostgreSQL, который следует переместить. Максимальная длина строки в символах — 50.
destination_folder_id | **string**<br>Обязательное поле. Идентификатор каталога, в который следует переместить кластер. Максимальная длина строки в символах — 50.


### Operation {#Operation5}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster6)>**<br>в случае успешного выполнения операции. 


### MoveClusterMetadata {#MoveClusterMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор перемещаемого кластера PostgreSQL. 
source_folder_id | **string**<br>Идентификатор исходного каталога. 
destination_folder_id | **string**<br>Идентификатор каталога назначения. 


### Cluster {#Cluster6}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера PostgreSQL. Этот идентификатор генерирует MDB при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер PostgreSQL. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера PostgreSQL. Имя уникально в рамках каталога. Длина 1-63 символов. 
description | **string**<br>Описание кластера PostgreSQL. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера PostgreSQL в виде пар `` key:value ``. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания для кластера PostgreSQL. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring6)**<br>Описание систем мониторинга, относящихся к данному кластеру PostgreSQL. 
config | **[ClusterConfig](#ClusterConfig6)**<br>Конфигурация кластера PostgreSQL. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Агрегированная работоспособность кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](#Host) для каждого хоста в кластере — UNKNOWN).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](#Host) для каждого хоста в кластере — ALIVE).</li><li>`DEAD`: Кластер не работает ([Host.health](#Host) для каждого узла в кластере — DEAD).</li><li>`DEGRADED`: Кластер работает неоптимально ([Host.health](#Host) по крайней мере для одного узла в кластере не ALIVE).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: На кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>


### Monitoring {#Monitoring6}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для данного кластера PostgreSQL. 


### ClusterConfig {#ClusterConfig6}

Поле | Описание
--- | ---
version | **string**<br>Версия серверного программного обеспечения PostgreSQL. 
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12` или `postgresql_config_12_1c`<br>Конфигурация для серверов PostgreSQL в кластере.
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlConfigSet9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql9_6.proto)**<br>Конфигурация сервера PostgreSQL 9.6. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlConfigSet10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10_1c.proto)**<br>Конфигурация сервера PostgreSQL 10 1С. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlConfigSet10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10.proto)**<br>Конфигурация сервера PostgreSQL 10. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlConfigSet11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11.proto)**<br>Конфигурация сервера PostgreSQL 11. 
&nbsp;&nbsp;postgresql_config_11_1c | **[config.PostgresqlConfigSet11_1C](./config/host10#PostgresqlConfigSet11_1C)**<br>Конфигурация сервера PostgreSQL 11 1C. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlConfigSet12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12.proto)**<br>Конфигурация сервера PostgreSQL 12. 
&nbsp;&nbsp;postgresql_config_12_1c | **[config.PostgresqlConfigSet12_1C](./config/host10#PostgresqlConfigSet12_1C)**<br>Конфигурация сервера PostgreSQL 12 1C. 
pooler_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig8)**<br>Конфигурация менеджера соединений. 
resources | **[Resources](#Resources8)**<br>Ресурсы, выделенные хостам PostgreSQL. 
autofailover | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Параметр конфигурации, который включает / отключает автоматическое переключение мастера в кластере. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access8)**<br>Политика доступа к БД 


### ConnectionPoolerConfig {#ConnectionPoolerConfig8}

Поле | Описание
--- | ---
pooling_mode | enum **PoolingMode**<br>Режим, в котором работает менеджер подключений. См. описание всех режимов в [документации PgBouncer](https://pgbouncer.github.io/usage). <ul><li>`SESSION`: Сессионный режим управления подключениями.</li><li>`TRANSACTION`: Транзакционный режим управления подключениями.</li><li>`STATEMENT`: Операторный режим управления подключениями.</li><ul/>
pool_discard | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Установка параметра `server_reset_query_always` в PgBouncer. 


### Resources {#Resources8}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [документации](/docs/managed-postgresql/concepts/instance-types). 
disk_size | **int64**<br>Объем хранилища, доступного хосту, в байтах. 
disk_type_id | **string**<br><ul><li>network-hdd — сетевой HDD-диск; </li><li>network-ssd — сетевой SSD-диск; </li><li>local-ssd — локальное SSD-хранилище.</li></ul> 


### Access {#Access8}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить доступ для DataLens 
serverless | **bool**<br>Разрешить доступ для Serverless 


## Backup {#Backup}

Создает резервную копию для указанного кластера PostgreSQL.

**rpc Backup ([BackupClusterRequest](#BackupClusterRequest)) returns ([operation.Operation](#Operation6))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[BackupClusterMetadata](#BackupClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster7)<br>

### BackupClusterRequest {#BackupClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера PostgreSQL, для которого следует создать резервную копию. Чтобы получить идентификатор PostgreSQL кластера, используйте запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.


### Operation {#Operation6}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[BackupClusterMetadata](#BackupClusterMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster7)>**<br>в случае успешного выполнения операции. 


### BackupClusterMetadata {#BackupClusterMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера PostgreSQL, для которого выполняется резервное копирование. 


### Cluster {#Cluster7}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера PostgreSQL. Этот идентификатор генерирует MDB при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер PostgreSQL. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера PostgreSQL. Имя уникально в рамках каталога. Длина 1-63 символов. 
description | **string**<br>Описание кластера PostgreSQL. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера PostgreSQL в виде пар `` key:value ``. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания для кластера PostgreSQL. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring7)**<br>Описание систем мониторинга, относящихся к данному кластеру PostgreSQL. 
config | **[ClusterConfig](#ClusterConfig7)**<br>Конфигурация кластера PostgreSQL. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Агрегированная работоспособность кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](#Host) для каждого хоста в кластере — UNKNOWN).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](#Host) для каждого хоста в кластере — ALIVE).</li><li>`DEAD`: Кластер не работает ([Host.health](#Host) для каждого узла в кластере — DEAD).</li><li>`DEGRADED`: Кластер работает неоптимально ([Host.health](#Host) по крайней мере для одного узла в кластере не ALIVE).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: На кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>


### Monitoring {#Monitoring7}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для данного кластера PostgreSQL. 


### ClusterConfig {#ClusterConfig7}

Поле | Описание
--- | ---
version | **string**<br>Версия серверного программного обеспечения PostgreSQL. 
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12` или `postgresql_config_12_1c`<br>Конфигурация для серверов PostgreSQL в кластере.
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlConfigSet9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql9_6.proto)**<br>Конфигурация сервера PostgreSQL 9.6. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlConfigSet10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10_1c.proto)**<br>Конфигурация сервера PostgreSQL 10 1С. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlConfigSet10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10.proto)**<br>Конфигурация сервера PostgreSQL 10. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlConfigSet11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11.proto)**<br>Конфигурация сервера PostgreSQL 11. 
&nbsp;&nbsp;postgresql_config_11_1c | **[config.PostgresqlConfigSet11_1C](./config/host10#PostgresqlConfigSet11_1C)**<br>Конфигурация сервера PostgreSQL 11 1C. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlConfigSet12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12.proto)**<br>Конфигурация сервера PostgreSQL 12. 
&nbsp;&nbsp;postgresql_config_12_1c | **[config.PostgresqlConfigSet12_1C](./config/host10#PostgresqlConfigSet12_1C)**<br>Конфигурация сервера PostgreSQL 12 1C. 
pooler_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig9)**<br>Конфигурация менеджера соединений. 
resources | **[Resources](#Resources9)**<br>Ресурсы, выделенные хостам PostgreSQL. 
autofailover | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Параметр конфигурации, который включает / отключает автоматическое переключение мастера в кластере. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access9)**<br>Политика доступа к БД 


### ConnectionPoolerConfig {#ConnectionPoolerConfig9}

Поле | Описание
--- | ---
pooling_mode | enum **PoolingMode**<br>Режим, в котором работает менеджер подключений. См. описание всех режимов в [документации PgBouncer](https://pgbouncer.github.io/usage). <ul><li>`SESSION`: Сессионный режим управления подключениями.</li><li>`TRANSACTION`: Транзакционный режим управления подключениями.</li><li>`STATEMENT`: Операторный режим управления подключениями.</li><ul/>
pool_discard | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Установка параметра `server_reset_query_always` в PgBouncer. 


### Resources {#Resources9}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [документации](/docs/managed-postgresql/concepts/instance-types). 
disk_size | **int64**<br>Объем хранилища, доступного хосту, в байтах. 
disk_type_id | **string**<br><ul><li>network-hdd — сетевой HDD-диск; </li><li>network-ssd — сетевой SSD-диск; </li><li>local-ssd — локальное SSD-хранилище.</li></ul> 


### Access {#Access9}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить доступ для DataLens 
serverless | **bool**<br>Разрешить доступ для Serverless 


## Restore {#Restore}

Создает новый кластер PostgreSQL с использованием указанной резервной копии.

**rpc Restore ([RestoreClusterRequest](#RestoreClusterRequest)) returns ([operation.Operation](#Operation7))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RestoreClusterMetadata](#RestoreClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster8)<br>

### RestoreClusterRequest {#RestoreClusterRequest}

Поле | Описание
--- | ---
backup_id | **string**<br>Обязательное поле. Идентификатор резервной копии, из которой следует создать кластер. Чтобы получить идентификатор резервной копии, используйте запрос [ClusterService.ListBackups](#ListBackups). 
time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Обязательное поле. Момент времени, на который должен быть восстановлен кластер PostgreSQL. 
time_inclusive | **bool**<br><ul><li>false (по умолчанию) — точкой восстановления является первая точка резервного копирования перед `time`. </li><li>true — точкой восстановления является первая точка резервного копирования после `time`.</li></ul> 
name | **string**<br>Обязательное поле. Имя нового кластера PostgreSQL. Имя должно быть уникальным в каталоге. Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.
description | **string**<br>Описание нового кластера PostgreSQL. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Пользовательские метки для кластера PostgreSQL в виде пар `` key:value ``. Не больше 64 меток на ресурс. Например, "project": "mvp" или "source": "dictionary". Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Максимальная длина строки в символах для каждого ключа — 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
environment | **[Cluster.Environment](#Cluster8)**<br>Среда развертывания для нового кластера PostgreSQL. 
config_spec | **[ConfigSpec](#ConfigSpec)**<br>Конфигурация для создаваемого кластера PostgreSQL. 
host_specs[] | **[HostSpec](#HostSpec)**<br>Конфигурации для хостов PostgreSQL, которые должны быть созданы для кластера, создаваемого из резервной копии. Количество элементов должно быть больше 0.
network_id | **string**<br>Обязательное поле. Идентификатор сети, в которой нужно создать PostgreSQL кластер. Максимальная длина строки в символах — 50.
folder_id | **string**<br>Идентификатор каталога, в котором нужно создать кластер PostgreSQL. Максимальная длина строки в символах — 50.


### ConfigSpec {#ConfigSpec2}

Поле | Описание
--- | ---
version | **string**<br>Версия PostgreSQL, используемая в кластере. Возможные значения `9.6`, `10`, `10_1c`, `11`, `12`. 
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12` или `postgresql_config_12_1c`<br>Конфигурация кластера PostgreSQL.
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlConfig9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql9_6.proto)**<br>Конфигурация для кластера PostgreSQL 9.6. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlConfig10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10_1c.proto)**<br>Конфигурация для кластера PostgreSQL 10. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlConfig10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10.proto)**<br>Конфигурация для кластера PostgreSQL 10. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlConfig11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11.proto)**<br>Конфигурация для кластера PostgreSQL 11. 
&nbsp;&nbsp;postgresql_config_11_1c | **[config.PostgresqlConfig11_1C](./config/host10#PostgresqlConfig11_1C)**<br>Конфигурация для кластера PostgreSQL 11 1C. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlConfig12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12.proto)**<br>Конфигурация для кластера PostgreSQL 12. 
&nbsp;&nbsp;postgresql_config_12_1c | **[config.PostgresqlConfig12_1C](./config/host10#PostgresqlConfig12_1C)**<br>Конфигурация для кластера PostgreSQL 12 1C. 
pooler_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig10)**<br>Конфигурация менеджера соединений. 
resources | **[Resources](#Resources10)**<br>Ресурсы, выделенные хостам PostgreSQL. 
autofailover | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Параметр конфигурации, который включает / отключает автоматическое переключение мастера в кластере. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access10)**<br>Политика доступа к БД 


### ConnectionPoolerConfig {#ConnectionPoolerConfig10}

Поле | Описание
--- | ---
pooling_mode | enum **PoolingMode**<br>Режим, в котором работает менеджер подключений. См. описание всех режимов в [документации PgBouncer](https://pgbouncer.github.io/usage). <ul><li>`SESSION`: Сессионный режим управления подключениями.</li><li>`TRANSACTION`: Транзакционный режим управления подключениями.</li><li>`STATEMENT`: Операторный режим управления подключениями.</li><ul/>
pool_discard | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Установка параметра `server_reset_query_always` в PgBouncer. 


### Resources {#Resources10}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [документации](/docs/managed-postgresql/concepts/instance-types). 
disk_size | **int64**<br>Объем хранилища, доступного хосту, в байтах. 
disk_type_id | **string**<br><ul><li>network-hdd — сетевой HDD-диск; </li><li>network-ssd — сетевой SSD-диск; </li><li>local-ssd — локальное SSD-хранилище.</li></ul> 


### Access {#Access10}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить доступ для DataLens 
serverless | **bool**<br>Разрешить доступ для Serverless 


### HostSpec {#HostSpec1}

Поле | Описание
--- | ---
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится хост. Чтобы получить список доступных зон, используйте запрос [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List). Максимальная длина строки в символах — 50.
subnet_id | **string**<br>Идентификатор подсети, к которой должен принадлежать хост. Эта подсеть должна быть частью сети, к которой принадлежит кластер. Идентификатор сети задан в поле [Cluster.network_id](#Cluster8). Максимальная длина строки в символах — 50.
assign_public_ip | **bool**<br><ul><li>false — не назначать хосту публичный IP-адрес. </li><li>true — у хоста должен быть публичный IP-адрес.</li></ul> 
replication_source | **string**<br>[Host.name](#Host) of the host to be used as the replication source (for cascading replication). 
priority | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Приоритет хоста как реплики. Большее значение соответствует более высокому приоритету. <br>Хост с наивысшим приоритетом является синхронной репликой. Все остальные асинхронны. Синхронная реплика при необходимости заменяет мастер. <br>Когда реплика становится мастером, ее приоритет игнорируется. 
config_spec | **[ConfigHostSpec](#ConfigHostSpec)**<br>Конфигурация сервера PostgreSQL для хоста. 


### ConfigHostSpec {#ConfigHostSpec1}

Поле | Описание
--- | ---
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12` или `postgresql_config_12_1c`<br>
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlHostConfig9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host9_6.proto)**<br>Конфигурация для хоста, на котором развернут сервером PostgreSQL 9.6. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlHostConfig10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host10_1c.proto)**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 10 1С. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlHostConfig10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host10.proto)**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 10. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlHostConfig11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host11.proto)**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 11. 
&nbsp;&nbsp;postgresql_config_11_1c | **[config.PostgresqlHostConfig11_1C](./config/host10#PostgresqlHostConfig11_1C)**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 11 1C. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlHostConfig12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host12.proto)**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 12. 
&nbsp;&nbsp;postgresql_config_12_1c | **[config.PostgresqlHostConfig12_1C](./config/host10#PostgresqlHostConfig12_1C)**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 12 1C. 


### Operation {#Operation7}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RestoreClusterMetadata](#RestoreClusterMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster8)>**<br>в случае успешного выполнения операции. 


### RestoreClusterMetadata {#RestoreClusterMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор нового кластера PostgreSQL, создаваемого из резервной копии. 
backup_id | **string**<br>Идентификатор резервной копии, используемой для создания кластера. 


### Cluster {#Cluster8}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера PostgreSQL. Этот идентификатор генерирует MDB при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер PostgreSQL. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера PostgreSQL. Имя уникально в рамках каталога. Длина 1-63 символов. 
description | **string**<br>Описание кластера PostgreSQL. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера PostgreSQL в виде пар `` key:value ``. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания для кластера PostgreSQL. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring8)**<br>Описание систем мониторинга, относящихся к данному кластеру PostgreSQL. 
config | **[ClusterConfig](#ClusterConfig8)**<br>Конфигурация кластера PostgreSQL. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Агрегированная работоспособность кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](#Host) для каждого хоста в кластере — UNKNOWN).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](#Host) для каждого хоста в кластере — ALIVE).</li><li>`DEAD`: Кластер не работает ([Host.health](#Host) для каждого узла в кластере — DEAD).</li><li>`DEGRADED`: Кластер работает неоптимально ([Host.health](#Host) по крайней мере для одного узла в кластере не ALIVE).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: На кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>


### Monitoring {#Monitoring8}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для данного кластера PostgreSQL. 


### ClusterConfig {#ClusterConfig8}

Поле | Описание
--- | ---
version | **string**<br>Версия серверного программного обеспечения PostgreSQL. 
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12` или `postgresql_config_12_1c`<br>Конфигурация для серверов PostgreSQL в кластере.
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlConfigSet9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql9_6.proto)**<br>Конфигурация сервера PostgreSQL 9.6. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlConfigSet10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10_1c.proto)**<br>Конфигурация сервера PostgreSQL 10 1С. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlConfigSet10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10.proto)**<br>Конфигурация сервера PostgreSQL 10. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlConfigSet11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11.proto)**<br>Конфигурация сервера PostgreSQL 11. 
&nbsp;&nbsp;postgresql_config_11_1c | **[config.PostgresqlConfigSet11_1C](./config/host10#PostgresqlConfigSet11_1C)**<br>Конфигурация сервера PostgreSQL 11 1C. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlConfigSet12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12.proto)**<br>Конфигурация сервера PostgreSQL 12. 
&nbsp;&nbsp;postgresql_config_12_1c | **[config.PostgresqlConfigSet12_1C](./config/host10#PostgresqlConfigSet12_1C)**<br>Конфигурация сервера PostgreSQL 12 1C. 
pooler_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig11)**<br>Конфигурация менеджера соединений. 
resources | **[Resources](#Resources11)**<br>Ресурсы, выделенные хостам PostgreSQL. 
autofailover | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Параметр конфигурации, который включает / отключает автоматическое переключение мастера в кластере. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access11)**<br>Политика доступа к БД 


### ConnectionPoolerConfig {#ConnectionPoolerConfig11}

Поле | Описание
--- | ---
pooling_mode | enum **PoolingMode**<br>Режим, в котором работает менеджер подключений. См. описание всех режимов в [документации PgBouncer](https://pgbouncer.github.io/usage). <ul><li>`SESSION`: Сессионный режим управления подключениями.</li><li>`TRANSACTION`: Транзакционный режим управления подключениями.</li><li>`STATEMENT`: Операторный режим управления подключениями.</li><ul/>
pool_discard | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Установка параметра `server_reset_query_always` в PgBouncer. 


### Resources {#Resources11}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [документации](/docs/managed-postgresql/concepts/instance-types). 
disk_size | **int64**<br>Объем хранилища, доступного хосту, в байтах. 
disk_type_id | **string**<br><ul><li>network-hdd — сетевой HDD-диск; </li><li>network-ssd — сетевой SSD-диск; </li><li>local-ssd — локальное SSD-хранилище.</li></ul> 


### Access {#Access11}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить доступ для DataLens 
serverless | **bool**<br>Разрешить доступ для Serverless 


## StartFailover {#StartFailover}

Запускает ручное переключение мастера для указанного кластера PostgreSQL.

**rpc StartFailover ([StartClusterFailoverRequest](#StartClusterFailoverRequest)) returns ([operation.Operation](#Operation8))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartClusterFailoverMetadata](#StartClusterFailoverMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster9)<br>

### StartClusterFailoverRequest {#StartClusterFailoverRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера PostgreSQL. Максимальная длина строки в символах — 50.
host_name | **string**<br>Новый хост-мастер. Если хост не указан, кластер переключается на реплику с самыми свежими данными. Максимальная длина строки в символах — 253.


### Operation {#Operation8}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StartClusterFailoverMetadata](#StartClusterFailoverMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster9)>**<br>в случае успешного выполнения операции. 


### StartClusterFailoverMetadata {#StartClusterFailoverMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера PostgreSQL, для которого переключается мастер. 


### Cluster {#Cluster9}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера PostgreSQL. Этот идентификатор генерирует MDB при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер PostgreSQL. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера PostgreSQL. Имя уникально в рамках каталога. Длина 1-63 символов. 
description | **string**<br>Описание кластера PostgreSQL. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера PostgreSQL в виде пар `` key:value ``. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания для кластера PostgreSQL. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring9)**<br>Описание систем мониторинга, относящихся к данному кластеру PostgreSQL. 
config | **[ClusterConfig](#ClusterConfig9)**<br>Конфигурация кластера PostgreSQL. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Агрегированная работоспособность кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](#Host) для каждого хоста в кластере — UNKNOWN).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](#Host) для каждого хоста в кластере — ALIVE).</li><li>`DEAD`: Кластер не работает ([Host.health](#Host) для каждого узла в кластере — DEAD).</li><li>`DEGRADED`: Кластер работает неоптимально ([Host.health](#Host) по крайней мере для одного узла в кластере не ALIVE).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: На кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>


### Monitoring {#Monitoring9}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для данного кластера PostgreSQL. 


### ClusterConfig {#ClusterConfig9}

Поле | Описание
--- | ---
version | **string**<br>Версия серверного программного обеспечения PostgreSQL. 
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12` или `postgresql_config_12_1c`<br>Конфигурация для серверов PostgreSQL в кластере.
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlConfigSet9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql9_6.proto)**<br>Конфигурация сервера PostgreSQL 9.6. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlConfigSet10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10_1c.proto)**<br>Конфигурация сервера PostgreSQL 10 1С. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlConfigSet10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql10.proto)**<br>Конфигурация сервера PostgreSQL 10. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlConfigSet11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql11.proto)**<br>Конфигурация сервера PostgreSQL 11. 
&nbsp;&nbsp;postgresql_config_11_1c | **[config.PostgresqlConfigSet11_1C](./config/host10#PostgresqlConfigSet11_1C)**<br>Конфигурация сервера PostgreSQL 11 1C. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlConfigSet12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/postgresql12.proto)**<br>Конфигурация сервера PostgreSQL 12. 
&nbsp;&nbsp;postgresql_config_12_1c | **[config.PostgresqlConfigSet12_1C](./config/host10#PostgresqlConfigSet12_1C)**<br>Конфигурация сервера PostgreSQL 12 1C. 
pooler_config | **[ConnectionPoolerConfig](#ConnectionPoolerConfig12)**<br>Конфигурация менеджера соединений. 
resources | **[Resources](#Resources12)**<br>Ресурсы, выделенные хостам PostgreSQL. 
autofailover | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Параметр конфигурации, который включает / отключает автоматическое переключение мастера в кластере. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access12)**<br>Политика доступа к БД 


### ConnectionPoolerConfig {#ConnectionPoolerConfig12}

Поле | Описание
--- | ---
pooling_mode | enum **PoolingMode**<br>Режим, в котором работает менеджер подключений. См. описание всех режимов в [документации PgBouncer](https://pgbouncer.github.io/usage). <ul><li>`SESSION`: Сессионный режим управления подключениями.</li><li>`TRANSACTION`: Транзакционный режим управления подключениями.</li><li>`STATEMENT`: Операторный режим управления подключениями.</li><ul/>
pool_discard | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Установка параметра `server_reset_query_always` в PgBouncer. 


### Resources {#Resources12}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [документации](/docs/managed-postgresql/concepts/instance-types). 
disk_size | **int64**<br>Объем хранилища, доступного хосту, в байтах. 
disk_type_id | **string**<br><ul><li>network-hdd — сетевой HDD-диск; </li><li>network-ssd — сетевой SSD-диск; </li><li>local-ssd — локальное SSD-хранилище.</li></ul> 


### Access {#Access12}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить доступ для DataLens 
serverless | **bool**<br>Разрешить доступ для Serverless 


## ListLogs {#ListLogs}

Получает логи для указанного кластера PostgreSQL.

**rpc ListLogs ([ListClusterLogsRequest](#ListClusterLogsRequest)) returns ([ListClusterLogsResponse](#ListClusterLogsResponse))**

### ListClusterLogsRequest {#ListClusterLogsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера PostgreSQL, для которого следует запросить логи. Чтобы получить идентификатор PostgreSQL кластера, используйте запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
column_filter[] | **string**<br>Столбцы из таблицы логов для запроса. Если столбцы не указаны, записи логов возвращаются целиком. 
service_type | enum **ServiceType**<br>Тип сервиса, для которого следует запросить логи. <ul><li>`POSTGRESQL`: Логи работы PostgreSQL.</li><li>`POOLER`: Логи работы менеджера подключений.</li><ul/>
from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Начало периода, для которого следует запросить логи, в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Конец периода, для которого следует запросить логи, в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
always_next_page_token | **bool**<br>Всегда возвращает `next_page_token`, даже если текущая страница пуста. 


### ListClusterLogsResponse {#ListClusterLogsResponse}

Поле | Описание
--- | ---
logs[] | **[LogRecord](#LogRecord)**<br>Запрошенные записи логов. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListClusterLogsRequest.page_size](#ListClusterLogsRequest), используйте `next_page_token` в качестве значения параметра [ListClusterLogsRequest.page_token](#ListClusterLogsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### LogRecord {#LogRecord}

Поле | Описание
--- | ---
timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Отметка времени для записи журнала в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) текстовом формате. 
message | **map<string,string>**<br>Содержание записи журнала. 


## ListOperations {#ListOperations}

Получает список ресурсов Operation для указанного кластера.

**rpc ListOperations ([ListClusterOperationsRequest](#ListClusterOperationsRequest)) returns ([ListClusterOperationsResponse](#ListClusterOperationsResponse))**

### ListClusterOperationsRequest {#ListClusterOperationsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор ресурса Cluster для PostgreSQL, для которого запрашивается список операций. Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListClusterOperationsResponse {#ListClusterOperationsResponse}

Поле | Описание
--- | ---
operations[] | **[operation.Operation](#Operation9)**<br>Список ресурсов Operation для указанного кластера PostgreSQL. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListClusterOperationsRequest.page_size](#ListClusterOperationsRequest), используйте `next_page_token` в качестве значения параметра [ListClusterOperationsRequest.page_token](#ListClusterOperationsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Operation {#Operation9}

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


## ListBackups {#ListBackups}

Получает список доступных резервных копий для указанного кластера PostgreSQL.

**rpc ListBackups ([ListClusterBackupsRequest](#ListClusterBackupsRequest)) returns ([ListClusterBackupsResponse](#ListClusterBackupsResponse))**

### ListClusterBackupsRequest {#ListClusterBackupsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера PostgreSQL. Чтобы получить идентификатор PostgreSQL кластера, используйте запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListClusterBackupsResponse.next_page_token](#ListClusterBackupsResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListClusterBackupsResponse.next_page_token](#ListClusterBackupsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListClusterBackupsResponse {#ListClusterBackupsResponse}

Поле | Описание
--- | ---
backups[] | **[Backup](#Backup)**<br>Список ресурсов Backup для PostgreSQL. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListClusterBackupsRequest.page_size](#ListClusterBackupsRequest), используйте `next_page_token` в качестве значения параметра [ListClusterBackupsRequest.page_token](#ListClusterBackupsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Backup {#Backup}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор резервной копии. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит резервная копия. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) (т. е. когда операция резервного копирования была завершена). 
source_cluster_id | **string**<br>Идентификатор кластера PostgreSQL, для которого была создана резервная копия. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время запуска операции резервного копирования. 


## ListHosts {#ListHosts}

Получает список хостов для указанного кластера.

**rpc ListHosts ([ListClusterHostsRequest](#ListClusterHostsRequest)) returns ([ListClusterHostsResponse](#ListClusterHostsResponse))**

### ListClusterHostsRequest {#ListClusterHostsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера PostgreSQL. Чтобы получить идентификатор PostgreSQL кластера, используйте запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListClusterHostsResponse {#ListClusterHostsResponse}

Поле | Описание
--- | ---
hosts[] | **[Host](#Host)**<br>Список ресурсов Host. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListClusterHostsRequest.page_size](#ListClusterHostsRequest), используйте `next_page_token` в качестве значения параметра [ListClusterHostsRequest.page_token](#ListClusterHostsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Host {#Host}

Поле | Описание
--- | ---
name | **string**<br>Имя хоста PostgreSQL. Имя хоста назначается MDB во время создания и не может быть изменено. Длина 1-63 символов. <br>Имя уникально для всех существующих хостов MDB в Яндекс.Облаке, так как оно определяет полное доменное имя (FQDN) хоста. 
cluster_id | **string**<br>Идентификатор хоста PostgreSQL. Этот идентификатор генерирует MDB при создании. 
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится хост PostgreSQL. 
resources | **[Resources](#Resources13)**<br>Ресурсы, выделенные для хоста PostgreSQL. 
role | enum **Role**<br>Роль хоста в кластере. <ul><li>`ROLE_UNKNOWN`: Роль хоста в кластере неизвестна.</li><li>`MASTER`: Хост является мастером в кластере PostgreSQL.</li><li>`REPLICA`: Хост является репликой в кластере PostgreSQL.</li><ul/>
health | enum **Health**<br>Код работоспособности хоста. <ul><li>`HEALTH_UNKNOWN`: Состояние хоста неизвестно.</li><li>`ALIVE`: Хозяин выполняет все свои функции нормально.</li><li>`DEAD`: Хост не работает и не может выполнять свои основные функции.</li><li>`DEGRADED`: Хост деградировал, и может выполнять только некоторые из своих основных функций.</li><ul/>
services[] | **[Service](#Service)**<br>Сервисы, предоставляемые хостом. 
subnet_id | **string**<br>Идентификатор подсети, к которой принадлежит хост. 
replication_source | **string**<br>Имя хоста, который будет использоваться в качестве источника репликации (для каскадной репликации). 
priority | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Приоритет хоста как реплики. Более высокое значение соответствует более высокому приоритету. <br>Хост с наивысшим приоритетом является синхронной репликой. Все остальные асинхронны. Синхронная реплика при необходимости заменяет мастер. <br>Когда реплика становится мастером, ее приоритет игнорируется. 
config | **[HostConfig](#HostConfig)**<br>Конфигурация сервера PostgreSQL для хоста. 
assign_public_ip | **bool**<br>Флаг, показывающий статус публичного IP-адреса для этого хоста. 
replica_type | enum **ReplicaType**<br> <ul><ul/>


### Resources {#Resources13}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [документации](/docs/managed-postgresql/concepts/instance-types). 
disk_size | **int64**<br>Объем хранилища, доступного хосту, в байтах. 
disk_type_id | **string**<br><ul><li>network-hdd — сетевой HDD-диск; </li><li>network-ssd — сетевой SSD-диск; </li><li>local-ssd — локальное SSD-хранилище.</li></ul> 


### Service {#Service}

Поле | Описание
--- | ---
type | enum **Type**<br>Тип сервиса, предоставляемого хостом. <ul><li>`POSTGRESQL`: Данный хост — это сервер PostgreSQL.</li><li>`POOLER`: Данный хост — это сервер PgBouncer.</li><ul/>
health | enum **Health**<br>Код состояния доступности сервера. <ul><li>`HEALTH_UNKNOWN`: Работоспособность сервера неизвестна.</li><li>`ALIVE`: Сервер работает нормально.</li><li>`DEAD`: Сервер отключен или не отвечает.</li><ul/>


### HostConfig {#HostConfig}

Поле | Описание
--- | ---
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12` или `postgresql_config_12_1c`<br>Конфигурация сервера PostgreSQL для хоста.
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlHostConfig9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host9_6.proto)**<br>Конфигурация для хоста, на котором развернут сервером PostgreSQL 9.6. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlHostConfig10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host10_1c.proto)**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 10 1С. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlHostConfig10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host10.proto)**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 10. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlHostConfig11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host11.proto)**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 11. 
&nbsp;&nbsp;postgresql_config_11_1c | **[config.PostgresqlHostConfig11_1C](./config/host10#PostgresqlHostConfig11_1C)**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 11 1C. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlHostConfig12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host12.proto)**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 12. 
&nbsp;&nbsp;postgresql_config_12_1c | **[config.PostgresqlHostConfig12_1C](./config/host10#PostgresqlHostConfig12_1C)**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 12 1C. 


## AddHosts {#AddHosts}

Создает новые хосты для кластера.

**rpc AddHosts ([AddClusterHostsRequest](#AddClusterHostsRequest)) returns ([operation.Operation](#Operation10))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddClusterHostsMetadata](#AddClusterHostsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### AddClusterHostsRequest {#AddClusterHostsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера PostgreSQL, для которого следует добавить хосты. Чтобы получить идентификатор PostgreSQL кластера, используйте запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
host_specs[] | **[HostSpec](#HostSpec)**<br>Конфигурации для хостов PostgreSQL, которые должны быть добавлены в кластер. Количество элементов должно быть больше 0.


### HostSpec {#HostSpec2}

Поле | Описание
--- | ---
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится хост. Чтобы получить список доступных зон, используйте запрос [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List). Максимальная длина строки в символах — 50.
subnet_id | **string**<br>Идентификатор подсети, к которой должен принадлежать хост. Эта подсеть должна быть частью сети, к которой принадлежит кластер. Идентификатор сети задан в поле [Cluster.network_id](#Cluster10). Максимальная длина строки в символах — 50.
assign_public_ip | **bool**<br><ul><li>false — не назначать хосту публичный IP-адрес. </li><li>true — у хоста должен быть публичный IP-адрес.</li></ul> 
replication_source | **string**<br>[Host.name](#Host1) of the host to be used as the replication source (for cascading replication). 
priority | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Приоритет хоста как реплики. Большее значение соответствует более высокому приоритету. <br>Хост с наивысшим приоритетом является синхронной репликой. Все остальные асинхронны. Синхронная реплика при необходимости заменяет мастер. <br>Когда реплика становится мастером, ее приоритет игнорируется. 
config_spec | **[ConfigHostSpec](#ConfigHostSpec)**<br>Конфигурация сервера PostgreSQL для хоста. 


### ConfigHostSpec {#ConfigHostSpec2}

Поле | Описание
--- | ---
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12` или `postgresql_config_12_1c`<br>
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlHostConfig9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host9_6.proto)**<br>Конфигурация для хоста, на котором развернут сервером PostgreSQL 9.6. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlHostConfig10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host10_1c.proto)**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 10 1С. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlHostConfig10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host10.proto)**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 10. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlHostConfig11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host11.proto)**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 11. 
&nbsp;&nbsp;postgresql_config_11_1c | **[config.PostgresqlHostConfig11_1C](./config/host10#PostgresqlHostConfig11_1C)**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 11 1C. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlHostConfig12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host12.proto)**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 12. 
&nbsp;&nbsp;postgresql_config_12_1c | **[config.PostgresqlHostConfig12_1C](./config/host10#PostgresqlHostConfig12_1C)**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 12 1C. 


### Operation {#Operation10}

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
cluster_id | **string**<br>Идентификатор кластера PostgreSQL, в который добавляются хосты. 
host_names[] | **string**<br>Имена хостов, добавляемых в кластер. 


## DeleteHosts {#DeleteHosts}

Удаляет указанные хосты кластера.

**rpc DeleteHosts ([DeleteClusterHostsRequest](#DeleteClusterHostsRequest)) returns ([operation.Operation](#Operation11))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterHostsMetadata](#DeleteClusterHostsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterHostsRequest {#DeleteClusterHostsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера PostgreSQL из которого следует удалить хосты. Чтобы получить идентификатор PostgreSQL кластера, используйте запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
host_names[] | **string**<br>Имена хостов, которые следует удалить. Количество элементов должно быть больше 0. Максимальная длина строки в символах для каждого значения — 253.


### Operation {#Operation11}

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
cluster_id | **string**<br>Идентификатор кластера PostgreSQL из которого следует удалить хосты. 
host_names[] | **string**<br>Имена удаляемых хостов. 


## UpdateHosts {#UpdateHosts}

Обновляет указанные хосты.

**rpc UpdateHosts ([UpdateClusterHostsRequest](#UpdateClusterHostsRequest)) returns ([operation.Operation](#Operation12))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterHostsMetadata](#UpdateClusterHostsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### UpdateClusterHostsRequest {#UpdateClusterHostsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера PostgreSQL, в котором следует обновить хосты. Чтобы получить идентификатор PostgreSQL кластера, используйте запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
update_host_specs[] | **[UpdateHostSpec](#UpdateHostSpec)**<br>Новые конфигурации, которые следует применить к хостам. Количество элементов должно быть больше 0.


### UpdateHostSpec {#UpdateHostSpec}

Поле | Описание
--- | ---
host_name | **string**<br>Обязательное поле. Имя хоста, который следует обновить. Чтобы получить имя хоста PostgreSQL, используйте запрос [ClusterService.ListHosts](#ListHosts). 
replication_source | **string**<br>[Host.name](#Host1) хоста, который будет использоваться в качестве источника репликации (для каскадной репликации). Чтобы получить имя хоста PostgreSQL, используйте запрос [ClusterService.ListHosts](#ListHosts). 
priority | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Хост с наивысшим приоритетом является синхронной репликой. Все остальные асинхронны. Синхронная реплика при необходимости заменяет мастер. <br>Когда реплика становится мастером, ее приоритет игнорируется. 
config_spec | **[ConfigHostSpec](#ConfigHostSpec)**<br>Конфигурация сервера PostgreSQL для хоста. 


### ConfigHostSpec {#ConfigHostSpec3}

Поле | Описание
--- | ---
postgresql_config | **oneof:** `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12` или `postgresql_config_12_1c`<br>
&nbsp;&nbsp;postgresql_config_9_6 | **[PostgresqlHostConfig9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host9_6.proto)**<br>Конфигурация для хоста, на котором развернут сервером PostgreSQL 9.6. 
&nbsp;&nbsp;postgresql_config_10_1c | **[PostgresqlHostConfig10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host10_1c.proto)**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 10 1С. 
&nbsp;&nbsp;postgresql_config_10 | **[PostgresqlHostConfig10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host10.proto)**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 10. 
&nbsp;&nbsp;postgresql_config_11 | **[PostgresqlHostConfig11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host11.proto)**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 11. 
&nbsp;&nbsp;postgresql_config_11_1c | **[config.PostgresqlHostConfig11_1C](./config/host10#PostgresqlHostConfig11_1C)**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 11 1C. 
&nbsp;&nbsp;postgresql_config_12 | **[PostgresqlHostConfig12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host12.proto)**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 12. 
&nbsp;&nbsp;postgresql_config_12_1c | **[config.PostgresqlHostConfig12_1C](./config/host10#PostgresqlHostConfig12_1C)**<br>Конфигурация для хоста, на котором развернут сервер PostgreSQL 12 1C. 


### Operation {#Operation12}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateClusterHostsMetadata](#UpdateClusterHostsMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### UpdateClusterHostsMetadata {#UpdateClusterHostsMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>​Идентификатор кластера PostgreSQL, в котором следует обновить хосты.​ 
host_names[] | **string**<br>Имена обновляемых хостов. 


