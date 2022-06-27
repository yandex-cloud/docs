---
editable: false
---

# ClusterService

Набор методов для управления кластерами ClickHouse.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанный ClickHouse-кластер. |
| [List](#List) | Получает список ClickHouse-кластеров, принадлежащих указанному каталогу. |
| [Create](#Create) | Создает кластер ClickHouse в указанном каталоге. |
| [Update](#Update) | Изменяет указанный кластер ClickHouse. |
| [Delete](#Delete) | Удаляет указанный кластер ClickHouse. |
| [Start](#Start) | Запускает указанный кластер ClickHouse. |
| [Stop](#Stop) | Останавливает указанный кластер ClickHouse. |
| [Move](#Move) | Перемещает кластер ClickHouse в указанный каталог. |
| [AddZookeeper](#AddZookeeper) | Добавляет подкластер ZooKeeper в указанный кластер ClickHouse. |
| [Backup](#Backup) | Создает резервную копию для указанного кластера ClickHouse. |
| [Restore](#Restore) | Создает новый кластер ClickHouse с использованием указанной резервной копии. |
| [ListLogs](#ListLogs) | Получает логи для указанного кластера ClickHouse. |
| [StreamLogs](#StreamLogs) | То же самое, что ListLogs, с той разницей, что со стороны сервера передается поток логов. |
| [ListOperations](#ListOperations) | Получает список ресурсов Operation для указанного кластера. |
| [ListBackups](#ListBackups) | Получает список доступных резервных копий для указанного кластера ClickHouse. |
| [ListHosts](#ListHosts) | Получает список хостов для указанного кластера. |
| [AddHosts](#AddHosts) | Создает новые хосты для кластера. |
| [DeleteHosts](#DeleteHosts) | Удаляет указанные хосты кластера. |
| [GetShard](#GetShard) | Возвращает указанный шард. |
| [ListShards](#ListShards) | Получает список шардов, принадлежащих указанному кластеру. |
| [AddShard](#AddShard) | Создает новый шард в указанном кластере. |
| [UpdateShard](#UpdateShard) | Изменяет указанный шард. |
| [DeleteShard](#DeleteShard) | Удаляет указанный шард. |
| [GetShardGroup](#GetShardGroup) | Возвращает указанную группу шардов. |
| [ListShardGroups](#ListShardGroups) | Получает список групп шардов, принадлежащих указанному кластеру. |
| [CreateShardGroup](#CreateShardGroup) | Создает новую группу шардов в указанном кластере. |
| [UpdateShardGroup](#UpdateShardGroup) | Изменяет указанную группу шардов. |
| [DeleteShardGroup](#DeleteShardGroup) | Удаляет указанную группу шардов. |
| [CreateExternalDictionary](#CreateExternalDictionary) | Создает внешний словарь для указанного кластера ClickHouse. |
| [DeleteExternalDictionary](#DeleteExternalDictionary) | Удаляет указанный внешний словарь. |

## Вызовы ClusterService {#calls}

## Get {#Get}

Возвращает указанный ClickHouse-кластер. <br>Чтобы получить список доступных кластеров ClickHouse, выполните запрос [List](#List).

**rpc Get ([GetClusterRequest](#GetClusterRequest)) returns ([Cluster](#Cluster))**

### GetClusterRequest {#GetClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор возвращаемого ресурса Cluster для ClickHouse. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.


### Cluster {#Cluster}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера ClickHouse. Этот идентификатор генерирует MDB при создании кластера. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер ClickHouse. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера ClickHouse. Имя уникально в рамках каталога. Длина 1-63 символов. 
description | **string**<br>Описание кластера ClickHouse. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера ClickHouse в виде пар `key:value`. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания кластера ClickHouse. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring)**<br>Описание систем мониторинга, относящихся к данному кластеру ClickHouse. 
config | **[ClusterConfig](#ClusterConfig)**<br>Конфигурация кластера ClickHouse. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Здоровье кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](#Host) для каждого хоста в кластере — UNKNOWN).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](#Host) для каждого хоста в кластере — ALIVE).</li><li>`DEAD`: Кластер не работает ([Host.health](#Host) для каждого хоста в кластере — DEAD).</li><li>`DEGRADED`: Кластер работает неоптимально ([Host.health](#Host) по крайней мере для одного хоста в кластере не ALIVE).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: В кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>
service_account_id | **string**<br>Идентификатор сервисного аккаунта, используемого для доступа к Yandex Object Storage. 


### Monitoring {#Monitoring}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для данного кластера ClickHouse. 


### ClusterConfig {#ClusterConfig}

Поле | Описание
--- | ---
version | **string**<br>Версия серверного программного обеспечения ClickHouse. 
clickhouse | **[Clickhouse](#Clickhouse)**<br>Конфигурация и распределение ресурсов для хостов ClickHouse. 
zookeeper | **[Zookeeper](#Zookeeper)**<br>Конфигурация и распределение ресурсов для хостов ZooKeeper. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access)**<br>Политика доступа для внешних сервисов. 


### Clickhouse {#Clickhouse}

Поле | Описание
--- | ---
config | **`config.ClickhouseConfigSet`**<br>Параметры конфигурации сервера ClickHouse. 
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные хостам ClickHouse. 


### Zookeeper {#Zookeeper}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные хостам ZooKeeper. 


### Access {#Access}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить экспорт данных из кластера в Yandex DataLens. 
web_sql | **bool**<br>Разрешить SQL-запросы к базам данных кластера из консоли управления облаком. <br>Подробнее см. в [SQL-запросы в консоли управления](/docs/managed-clickhouse/operations/web-sql-query). 
metrika | **bool**<br>Разрешить импорт данных из Яндекс Метрики и AppMetrica в кластер. <br>Подробнее см. в [Экспорт данных в {{ yandex-cloud }}](https://appmetrica.yandex.ru/docs/common/cloud/about.html). 
serverless | **bool**<br>Разрешить доступ к кластеру для Serverless. 


## List {#List}

Получает список ClickHouse-кластеров, принадлежащих указанному каталогу.

**rpc List ([ListClustersRequest](#ListClustersRequest)) returns ([ListClustersResponse](#ListClustersResponse))**

### ListClustersRequest {#ListClustersRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога для вывода списка кластеров ClickHouse. Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на одной странице в ответе. Если количество результатов больше чем `page_size`, сервис вернет значение [ListClustersResponse.next_page_token](#ListClustersResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListClustersResponse.next_page_token](#ListClustersResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br><ol><li>Имя поля. В настоящее время фильтрацию можно использовать только по полю [Cluster.name](#Cluster1). </li><li>Условный оператор. Поддерживаются операторы `=` и `!=` для одиночных значений, `IN` и `NOT IN` для списков значений. </li><li>Значение. Должно содержать от 1 до 63 символов и соответствовать регулярному выражению `^[a-zA-Z0-9_-]+$`.</li></ol> Максимальная длина строки в символах — 1000.


### ListClustersResponse {#ListClustersResponse}

Поле | Описание
--- | ---
clusters[] | **[Cluster](#Cluster1)**<br>Список ресурсов Cluster для ClickHouse. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListClustersRequest.page_size](#ListClustersRequest), используйте `next_page_token` в качестве значения параметра [ListClustersRequest.page_token](#ListClustersRequest) в следующем запросе. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Cluster {#Cluster1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера ClickHouse. Этот идентификатор генерирует MDB при создании кластера. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер ClickHouse. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера ClickHouse. Имя уникально в рамках каталога. Длина 1-63 символов. 
description | **string**<br>Описание кластера ClickHouse. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера ClickHouse в виде пар `key:value`. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания кластера ClickHouse. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring1)**<br>Описание систем мониторинга, относящихся к данному кластеру ClickHouse. 
config | **[ClusterConfig](#ClusterConfig1)**<br>Конфигурация кластера ClickHouse. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Здоровье кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](#Host) для каждого хоста в кластере — UNKNOWN).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](#Host) для каждого хоста в кластере — ALIVE).</li><li>`DEAD`: Кластер не работает ([Host.health](#Host) для каждого хоста в кластере — DEAD).</li><li>`DEGRADED`: Кластер работает неоптимально ([Host.health](#Host) по крайней мере для одного хоста в кластере не ALIVE).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: В кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>
service_account_id | **string**<br>Идентификатор сервисного аккаунта, используемого для доступа к Yandex Object Storage. 


### Monitoring {#Monitoring1}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для данного кластера ClickHouse. 


### ClusterConfig {#ClusterConfig1}

Поле | Описание
--- | ---
version | **string**<br>Версия серверного программного обеспечения ClickHouse. 
clickhouse | **[Clickhouse](#Clickhouse1)**<br>Конфигурация и распределение ресурсов для хостов ClickHouse. 
zookeeper | **[Zookeeper](#Zookeeper1)**<br>Конфигурация и распределение ресурсов для хостов ZooKeeper. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access1)**<br>Политика доступа для внешних сервисов. 


### Clickhouse {#Clickhouse1}

Поле | Описание
--- | ---
config | **`config.ClickhouseConfigSet`**<br>Параметры конфигурации сервера ClickHouse. 
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные хостам ClickHouse. 


### Zookeeper {#Zookeeper1}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные хостам ZooKeeper. 


### Access {#Access1}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить экспорт данных из кластера в Yandex DataLens. 
web_sql | **bool**<br>Разрешить SQL-запросы к базам данных кластера из консоли управления облаком. <br>Подробнее см. в [SQL-запросы в консоли управления](/docs/managed-clickhouse/operations/web-sql-query). 
metrika | **bool**<br>Разрешить импорт данных из Яндекс Метрики и AppMetrica в кластер. <br>Подробнее см. в [Экспорт данных в {{ yandex-cloud }}](https://appmetrica.yandex.ru/docs/common/cloud/about.html). 
serverless | **bool**<br>Разрешить доступ к кластеру для Serverless. 


## Create {#Create}

Создает кластер ClickHouse в указанном каталоге.

**rpc Create ([CreateClusterRequest](#CreateClusterRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateClusterMetadata](#CreateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster2)<br>

### CreateClusterRequest {#CreateClusterRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога, в котором нужно создать кластер ClickHouse. Максимальная длина строки в символах — 50.
name | **string**<br>Обязательное поле. Имя кластера ClickHouse. Имя должно быть уникальным в рамках каталога. Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.
description | **string**<br>Описание кластера ClickHouse. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Пользовательские метки для кластера ClickHouse в виде пар `key:value`. Максимум 64 на ресурс. Например, "project": "mvp" или "source": "dictionary". Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Максимальная длина строки в символах для каждого ключа — 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
environment | **[Cluster.Environment](#Cluster2)**<br>Обязательное поле. Среда развертывания кластера ClickHouse. 
config_spec | **[ConfigSpec](#ConfigSpec)**<br>Обязательное поле. Конфигурация и ресурсы для хостов, которые должны быть созданы для кластера ClickHouse. 
database_specs[] | **[DatabaseSpec](#DatabaseSpec)**<br>Описания баз данных, которые нужно создать в кластере ClickHouse. Количество элементов должно быть больше 0.
user_specs[] | **[UserSpec](#UserSpec)**<br>Описания пользователей базы данных, которых нужно создать в кластере ClickHouse. Количество элементов должно быть больше 0.
host_specs[] | **[HostSpec](#HostSpec)**<br>Конфигурации для отдельных хостов, которые должны быть созданы для кластера ClickHouse. Количество элементов должно быть больше 0.
network_id | **string**<br>Обязательное поле. Идентификатор сети, в которой нужно создать кластер. Максимальная длина строки в символах — 50.
shard_name | **string**<br>Имя первого шарда в кластере. Если параметр не указан, используется значение `shard1`. Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.
service_account_id | **string**<br>Идентификатор сервисного аккаунта, используемого для доступа к Yandex Object Storage. 


### ConfigSpec {#ConfigSpec}

Поле | Описание
--- | ---
version | **string**<br>Версия серверного программного обеспечения ClickHouse. 
clickhouse | **[Clickhouse](#Clickhouse2)**<br>Конфигурация и ресурсы для сервера ClickHouse. 
zookeeper | **[Zookeeper](#Zookeeper2)**<br>Конфигурация и ресурсы для сервера ZooKeeper. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access2)**<br>Политика доступа для внешних сервисов. <br>Если вы хотите, чтобы определенный сервис получил доступ к кластеру ClickHouse — задайте необходимые значения в этой политике. 


### Clickhouse {#Clickhouse2}

Поле | Описание
--- | ---
config | **`config.ClickhouseConfig`**<br>Конфигурация для сервера ClickHouse. 
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные хостам ClickHouse. 


### Zookeeper {#Zookeeper2}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные хостам ZooKeeper. Если не задано, будет использоваться минимальный доступный набор ресурсов. Все доступные наборы ресурсов можно получить с помощью запроса [ResourcePresetService.List](./resource_preset_service#List). 


### Access {#Access2}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить экспорт данных из кластера в Yandex DataLens. 
web_sql | **bool**<br>Разрешить SQL-запросы к базам данных кластера из консоли управления облаком. <br>Подробнее см. в [SQL-запросы в консоли управления](/docs/managed-clickhouse/operations/web-sql-query). 
metrika | **bool**<br>Разрешить импорт данных из Яндекс Метрики и AppMetrica в кластер. <br>Подробнее см. в [Экспорт данных в {{ yandex-cloud }}](https://appmetrica.yandex.ru/docs/common/cloud/about.html). 
serverless | **bool**<br>Разрешить доступ к кластеру для Serverless. 


### DatabaseSpec {#DatabaseSpec}

Поле | Описание
--- | ---
name | **string**<br>Обязательное поле. Имя базы данных ClickHouse. Длина 1-63 символов. Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.


### UserSpec {#UserSpec}

Поле | Описание
--- | ---
name | **string**<br>Обязательное поле. Имя пользователя базы данных ClickHouse. Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.
password | **string**<br>Обязательное поле. Пароль пользователя ClickHouse. Длина строки в символах должна быть от 8 до 128.
permissions[] | **[Permission](#Permission)**<br>Набор разрешений, которые следует предоставить пользователю. 
settings | **[UserSettings](#UserSettings)**<br> 
quotas[] | **[UserQuota](#UserQuota)**<br>Набор квот, назначенных пользователю. 


### Permission {#Permission}

Поле | Описание
--- | ---
database_name | **string**<br>Имя базы данных, к которой предоставляет доступ разрешение. 


### UserSettings {#UserSettings}

Поле | Описание
--- | ---
readonly | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Ограничивает разрешения для запросов, не относящихся к DDL. Чтобы ограничить разрешения для DDL-запросов, используйте настройку `allow_ddl`. <br>- `0` (по умолчанию) — нет ограничений. - `1`— разрешено выполнять только запросы на чтение данных. - `2` — разрешено выполнять запросы на чтение данных и изменение настроек. <br>См. подробное описание в [документации ClickHouse](https://clickhouse.tech/docs/ru/operations/settings/permissions-for-queries/#settings_readonly). Допустимые значения — от 0 до 2 включительно.
allow_ddl | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Определяет, разрешены ли DDL-запросы (например, `CREATE`, `ALTER`, `RENAME`, и т.д.). <br>Значение по умолчанию: `true`. <br>См. подробное описание в [документации ClickHouse](https://clickhouse.tech/docs/ru/operations/settings/permissions-for-queries/#settings_allow_ddl). 
insert_quorum | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Включает или выключает кворумную запись в кластере ClickHouse. Если значение меньше `2`, то кворумная запись выключена, в противном случае она включена. <br>Кворумная запись позволяет гарантировать, что за время, не большее чем `insert_quorum_timeout`, ClickHouse смог без ошибок записать данные в кворум из `insert_quorum` реплик. Все реплики в кворуме консистентны, т.е. содержат данные всех более ранних запросов `INSERT`. Использование кворума при записи позволяет гарантировать, что данные не потеряются при выходе из строя одной или нескольких реплик. <br>При чтении данных, записанных с помощью кворумной записи, можно использовать настройку `select_sequential_consistency`. <br>См. подробное описание в [документации ClickHouse](https://clickhouse.tech/docs/ru/operations/settings/settings/#settings-insert_quorum). Минимальная значение — 0.
connect_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Время ожидания соединения в миллисекундах. <br>Значение должно быть больше `0` (по умолчанию: `10000`, 10 секунд). Значение должно быть больше 0.
receive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Время ожидания приема данных в миллисекундах. <br>Значение должно быть больше `0` (по умолчанию: `300000`, 300 секунд, 5 минут). Значение должно быть больше 0.
send_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Время ожидания отправки данных в миллисекундах. <br>Значение должно быть больше `0` (по умолчанию: `300000`, 300 секунд, 5 минут). Значение должно быть больше 0.
insert_quorum_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Время ожидания кворумной записи в миллисекундах. <br>Если кворумная запись включена, время ожидания прошло, а запись в `insert_quorum` реплик так не состоялась, то ClickHouse прервет выполнение `INSERT`-запроса и вернет ошибку. В этом случае клиент должен повторить запрос на запись того же блока на эту же или любую другую реплику. <br>Минимальное значение: `1000`, одна секунда (по умолчанию: `60000`, одна минута). Минимальная значение — 1000.
select_sequential_consistency | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Определяет поведение `SELECT`-запросов для реплицированных таблиц: если эта настройка включена, ClickHouse прервет выполнение запроса и вернет сообщение об ошибке в случае, если в реплике нет фрагментов данных, записанных с помощью кворумной записи. Фрагменты данных, записанные без использования кворумной записи, прочитаны не будут. <br>Значение по умолчанию: `false` (последовательная консистентность выключена). 
max_replica_delay_for_distributed_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимальная задержка реплики в миллисекундах. Если реплика отстает на значение больше установленного, она перестает использоваться и становится устаревшей. <br>Минимальное значение: `1000`, 1 секунда (по умолчанию: `300000`, 300 секунд, 5 минут). <br>См. подробное описание в [документации ClickHouse](https://clickhouse.tech/docs/ru/operations/settings/settings/#settings-max_replica_delay_for_distributed_queries). Минимальная значение — 1000.
fallback_to_stale_replicas_for_distributed_queries | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Включает или выключает форсирование запроса в устаревшую реплику в случае, если актуальные данные недоступны. Если этот параметр включен, то из устаревших реплик таблицы ClickHouse выбирает наиболее актуальную. Используется при выполнении `SELECT` из распределенной таблицы, которая указывает на реплицированные таблицы. <br>Значение по умолчанию: `true` (форсирование запроса включено). <br>См. подробное описание в [документации ClickHouse](https://clickhouse.tech/docs/ru/operations/settings/settings/#settings-fallback_to_stale_replicas_for_distributed_queries). 
replication_alter_partitions_sync | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Условия ожидания завершения асинхронных действий на репликах для запросов `ALTER`: <br>- `0` — не ждать. - `1` — ждать выполнения только у себя (значение по умолчанию). - `2` — ждать всех. <br>См. подробное описание в [документации ClickHouse](https://clickhouse.tech/docs/ru/sql-reference/statements/alter/#synchronicity-of-alter-queries). Допустимые значения — от 0 до 2 включительно.
distributed_product_mode | enum **DistributedProductMode**<br>Определяет поведение распределенных подзапросов. <br>См. подробное описание в [документации ClickHouse](https://clickhouse.tech/docs/ru/operations/settings/settings/#distributed-product-mode). <ul><li>`DISTRIBUTED_PRODUCT_MODE_DENY`: Значение по умолчанию. Запрещает использование этих типов подзапросов (возвращает исключение "Double-distributed in/JOIN subqueries is denied").</li><li>`DISTRIBUTED_PRODUCT_MODE_LOCAL`: Заменяет базу данных и таблицу в подзапросе локальными для конечного сервера (шарда), оставляя обычный IN / JOIN.</li><li>`DISTRIBUTED_PRODUCT_MODE_GLOBAL`: Заменяет IN/JOIN запрос на GLOBAL IN/GLOBAL JOIN.</li><li>`DISTRIBUTED_PRODUCT_MODE_ALLOW`: Позволяет использовать эти типы подзапросов.</li><ul/>
distributed_aggregation_memory_efficient | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Включает или выключает режим экономии памяти при распределенной агрегации. <br>При распределённой обработке запроса внешняя агрегация производится на удалённых серверах. Для того чтобы на сервере-инициаторе запроса использовалось немного оперативной памяти, нужно включить эту настройку. <br>Значение по умолчанию: `false` (режим экономии памяти выключен). <br>См. подробное описание в [документации ClickHouse](https://clickhouse.tech/docs/ru/sql-reference/statements/select/group-by/#select-group-by-in-external-memory). 
distributed_ddl_task_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Время ожидания выполнения DDL-запросов в миллисекундах. 
skip_unavailable_shards | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Включает или выключает тихий пропуск недоступных шардов. <br>Шард считается недоступным, если все его реплики недоступны. <br>Значение по умолчанию: `false` (тихий пропуск недоступных шардов выключен). <br>См. подробное описание в [документации ClickHouse](https://clickhouse.tech/docs/ru/operations/settings/settings/#settings-skip_unavailable_shards). 
compile | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Включает или выключает компиляцию запросов. Если вы выполняете большое количество структурно идентичных запросов — включите эту настройку. При включенной компиляции такие запросы могут выполняться быстрее за счет использования скомпилированных частей запроса. <br>Эта настройка используется совместно с `min_count_to_compile`. <br>Значение по умолчанию: `false` (компиляция выключена). <br>См. подробное описание в [документации ClickHouse](https://clickhouse.tech/docs/ru/operations/settings/settings/#compile). 
min_count_to_compile | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>После какого количества структурно идентичных запросов начать компиляцию. <br>Минимальное значение: `0` (по умолчанию: `3`). <br>Для значения `0` компиляция выполняется синхронно: запрос ожидает окончания процесса компиляции перед продолжением выполнения. Рекомендуется использовать это значение только в целях тестирования. <br>Для всех других значений компиляция выполняется асинхронно, в отдельном потоке. Когда часть запроса будет скомпилирована, она сразу же будет использована ClickHouse для подходящих запросов (включая те, которые выполняются в данный момент). <br>См. подробное описание в [документации ClickHouse](https://clickhouse.tech/docs/ru/operations/settings/settings/#min-count-to-compile). Минимальная значение — 0.
compile_expressions | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Включает или выключает компиляцию выражений. Если вы выполняете большое количество запросов, в которых используются идентичные выражения — включите эту настройку. При включенной компиляции выражений такие запросы могут выполняться быстрее за счет использования скомпилированных выражений. <br>Эта настройка используется совместно с `min_count_to_compile_expression`. <br>Значение по умолчанию: `false` (компиляция выражений выключена). 
min_count_to_compile_expression | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>После какого количества идентичных выражений начать их компиляцию. <br>Минимальное значение: `0` (по умолчанию: `3`). <br>Для значения `0` компиляция выполняется синхронно: запрос ожидает окончания процесса компиляции выражения перед продолжением выполнения. Рекомендуется использовать это значение только в целях тестирования. <br>Для всех других значений компиляция выполняется асинхронно, в отдельном потоке. Когда выражение будет скомпилировано, оно сразу же будет использовано ClickHouse для подходящих запросов (включая те, которые выполняются в данный момент). Минимальная значение — 0.
max_block_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимальный размер блока для чтения. <br>Данные в ClickHouse обрабатываются по блокам (наборам кусочков столбцов). Внутренние циклы обработки для одного блока достаточно эффективны, но есть заметные издержки на каждый блок. <br>Эта настройка — рекомендация, какой размер блока (в количестве строк) загружать из таблиц. <br>Значение должно быть больше `0` (по умолчанию: `65536`). <br>См. подробное описание в [документации ClickHouse](https://clickhouse.tech/docs/ru/operations/settings/settings/#setting-max_block_size). Значение должно быть больше 0.
min_insert_block_size_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Ограничивает минимальное количество строк в блоке, который может быть вставлен в таблицу запросом `INSERT`. Блоки меньшего размера склеиваются в блоки большего размера. <br>Минимальное значение: `0`, склейка блоков выключена (по умолчанию: `1048576`). Минимальная значение — 0.
min_insert_block_size_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Ограничивает минимальное количество байтов в блоке, который может быть вставлен в таблицу запросом `INSERT`. Блоки меньшего размера склеиваются в блоки большего размера. <br>Минимальное значение: `0`, склейка блоков выключена (по умолчанию: `‭268435456‬‬`, 256 МБ). Минимальная значение — 0.
max_insert_block_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Позволяет формировать блоки указанного размера (в байтах) при вставке в таблицу. Эта настройка действует только в тех случаях, когда сервер сам формирует такие блоки. <br>Значение должно быть больше `0` (по умолчанию: `1048576`). <br>См. подробное описание в [документации ClickHouse](https://clickhouse.tech/docs/ru/operations/settings/settings/#settings-max_insert_block_size). Значение должно быть больше 0.
min_bytes_to_use_direct_io | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>минимальный объём данных в байтах, необходимый для прямого (небуферизованного) чтения (Direct I/O) на диск. <br>По умолчанию ClickHouse читает данные не напрямую с диска, а полагается на файловую систему и её кэш. Такое чтение эффективно при небольших объемах данных. Если данные читаются в больших объемах, эффективнее читать с диска напрямую, минуя кэш файловой системы. <br>Если общий объём хранения всех данных для чтения превышает заданное значение настройки, тогда ClickHouse читает данные с диска напрямую. <br>Минимальное значение и значение по умолчанию: `0` (прямой ввод/вывод отключен). Минимальная значение — 0.
use_uncompressed_cache | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Определяет, использовать ли кэш разжатых блоков. Использование кэша несжатых блоков может существенно сократить задержку и увеличить пропускную способность при работе с большим количеством коротких запросов. Включите эту настройку для пользователей, от которых идут частые короткие запросы. <br>Этот настройка действует только для таблиц семейства MergeTree. <br>Значение по умолчанию: `false` (кэш не используется). <br>См. подробное описание в [документации ClickHouse](https://clickhouse.tech/docs/ru/operations/settings/settings/#setting-use_uncompressed_cache). 
merge_tree_max_rows_to_use_cache | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Ограничивает максимальный размер запроса в строках для использования кэша несжатых данных. Кэш не используется для запросов, превышающих указанный размер. <br>Эта настройка используется совместно с `use_uncompressed_cache`. <br>Значение должно быть больше `0` (по умолчанию: `128x8192`). Значение должно быть больше 0.
merge_tree_max_bytes_to_use_cache | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Ограничивает максимальный размер запроса в байтах для использования кэша несжатых данных. Кэш не используется для запросов, превышающих указанный размер. <br>Эта настройка используется совместно с `use_uncompressed_cache`. <br>Значение должно быть больше `0` (по умолчанию: `192x10x1024x1024`). Значение должно быть больше 0.
merge_tree_min_rows_for_concurrent_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Ограничивает минимальное количество строк, которое надо прочитать из файла, чтобы использовать одновременное чтение. Если количество строк, прочитанных из файла, превышает заданное значение, то ClickHouse пытается выполнить одновременное чтение из этого файла в несколько потоков. <br>Этот настройка действует только для таблиц семейства MergeTree. <br>Значение должно быть больше `0` (по умолчанию: `20x8192`). Значение должно быть больше 0.
merge_tree_min_bytes_for_concurrent_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Ограничивает минимальное количество байт, которое надо прочитать из файла, чтобы использовать одновременное чтение. Если количество байт, прочитанных из файла, превышает заданное значение, то ClickHouse пытается выполнить одновременное чтение из этого файла в несколько потоков. <br>Этот настройка действует только для таблиц семейства MergeTree. <br>Значение должно быть больше `0` (по умолчанию: `24x10x1024x1024`). Значение должно быть больше 0.
max_bytes_before_external_group_by | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>задает порог потребления оперативной памяти (в байтах), по достижению которого временные данные, накопленные при выполнении операции агрегации `GROUP BY`, сбрасываются на диск для экономии оперативной памяти. <br>По умолчанию агрегирование выполняется в памяти с помощью хэш-таблицы. Запрос может привести к необходимости агрегации больших объемов данных, которые могут не поместиться в оперативную память и вызвать ошибку при выполнении запроса (см. настройку `max_memory_usage`). Для таких запросов используйте эту настройку, чтобы ClickHouse сбрасывал данные на диск и успешно выполнял агрегацию. <br>Минимальное значение и значение по умолчанию: `0`, `GROUP BY` во внешней памяти отключен. <br>При использовании агрегации во внешней памяти рекомендуется задать значение этой настройки в два раза меньше значения настройки `max_memory_usage`(по умолчанию максимальное использование памяти ограничено десятью гигабайтами). <br>См. подробное описание в [документации ClickHouse](https://clickhouse.tech/docs/ru/sql-reference/statements/select/group-by/#select-group-by-in-external-memory). <br>Смотрите также настройку `distributed_aggregation_memory_efficient`. 
max_bytes_before_external_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Настройка аналогична `max_bytes_before_external_group_by`, за исключением того, что она применяется для операции сортировки (`ORDER BY`). 
group_by_two_level_threshold | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Определяет порог количества ключей, при достижении которого начинается двухуровневая агрегация. <br>Минимальное значение: `0`, порог не установлен (по умолчанию: `10000‬‬`). 
group_by_two_level_threshold_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Определяет порог количества байт в агрегате, при достижении которого начинается двухуровневая агрегация. <br>Минимальное значение: `0`, порог не установлен (по умолчанию: `100000000‬‬`). 
priority | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Определяет приоритет запроса. <br>- `0` — приоритет не используется. - `1` — наивысший приоритет. - и так далее. Чем больше число, тем ниже приоритет. <br>Эта настройка выставляется для каждого запроса по отдельности. <br>Если ClickHouse в текущий момент времени выполняет запросы с более высокими приоритетами, чем приоритет поступившего запроса, то выполнение такого запроса приостанавливается до завершения выполнения более приоритетных запросов. <br>Минимальное значение и значение по умолчанию: `0`, приоритет не используется. Минимальная значение — 0.
max_threads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Ограничивает максимальное количество потоков обработки запроса (без учёта потоков для чтения данных с удалённых серверов). <br>Этот параметр относится к потокам, которые выполняют параллельно одни стадии конвейера выполнения запроса. <br>Минимальное значение и значение по умолчанию: `0` (значение вычисляется автоматически — это количество процессорных ядер без учёта Hyper-Threading). <br>См. подробное описание в [документации ClickHouse](https://clickhouse.tech/docs/ru/operations/settings/settings/#settings-max_threads). Значение должно быть больше 0.
max_memory_usage | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Ограничивает максимально возможный объём оперативной памяти (в байтах) для выполнения запроса на одном сервере. Настройка не учитывает объём свободной памяти или общий объём памяти на машине. <br>Ограничение действует на один запрос, в пределах одного сервера. <br>Минимальное значение: `0`, нет ограничения. В конфигурационном файле по умолчанию ограничение равно `10737418240` (10 ГБ). <br>Если вы также используете настройки `max_bytes_before_external_group_by` или `max_bytes_before_external_sort`, рекомендуется, чтобы их значения были в два раза меньше значения `max_memory_usage`. <br>См. подробное описание в [документации ClickHouse](https://clickhouse.tech/docs/ru/operations/settings/query-complexity/#settings_max_memory_usage). Минимальная значение — 0.
max_memory_usage_for_user | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Ограничивает максимально возможный объём оперативной памяти (в байтах) для выполнения запросов пользователя на одном сервере. Настройка не учитывает объём свободной памяти или общий объём памяти на машине. <br>Ограничение действует на все запросы пользователя, которые выполняются одновременно в пределах одного сервера. <br>Минимальное значение и значение по умолчанию: `0`, нет ограничения. Минимальная значение — 0.
max_network_bandwidth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Ограничивает скорость обмена данными по сети (байт в секунду) при выполнении одного запроса. <br>Минимальное значение и значение по умолчанию: `0`, нет ограничения. 
max_network_bandwidth_for_user | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Ограничивает скорость обмена данными по сети (байт в секунду). Эта настройка влияет на все одновременно выполняющиеся запросы пользователя. <br>Минимальное значение и значение по умолчанию: `0`, нет ограничения. 
force_index_by_date | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Если эта настройка включена, то запрос не выполняется при условии, что использовать индекс по дате невозможно. Этот настройка действует только для таблиц семейства MergeTree. <br>Значение по умолчанию: `false` (настройка отключена, запрос выполняется, даже если ClickHouse не может использовать индекс по дате). <br>См. подробное описание в [документации ClickHouse](https://clickhouse.tech/docs/ru/operations/settings/settings/#settings-force_index_by_date). 
force_primary_key | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Если эта настройка включена, то запрос не выполняется при условии, что использовать индекс по первичному ключу невозможно. Этот настройка действует только для таблиц семейства MergeTree. <br>Значение по умолчанию: `false` (настройка отключена, запрос выполняется, даже если ClickHouse не может использовать индекс по первичному ключу). <br>См. подробное описание в [документации ClickHouse](https://clickhouse.tech/docs/ru/operations/settings/settings/#settings-force_primary_key). 
max_rows_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Ограничивает максимальное количество строк, которое можно прочитать из таблицы при выполнении запроса. <br>Минимальное значение и значение по умолчанию: `0`, нет ограничения. <br>См. подробное описание в [документации ClickHouse](https://clickhouse.tech/docs/ru/operations/settings/query-complexity/#max-rows-to-read). Минимальная значение — 0.
max_bytes_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Ограничивает максимальное количество байт (несжатых данных), которое можно прочитать из таблицы при выполнении запроса. <br>Минимальное значение и значение по умолчанию: `0`, нет ограничения. Минимальная значение — 0.
read_overflow_mode | enum **OverflowMode**<br>Определяет поведение ClickHouse в ситуации, когда количество прочитанных данных [превысило ограничения](https://clickhouse.tech/docs/ru/operations/settings/query-complexity/#restrictions-on-query-complexity). <br>- `throw` — прервать выполнение запроса, вернуть ошибку. - `break` — прервать выполнение запроса, вернуть неполный результат. <ul><ul/>
max_rows_to_group_by | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Ограничивает максимальное количество уникальных ключей, получаемых в процессе агрегации. Эта настройка позволяет ограничить потребление оперативной памяти при агрегации. <br>Минимальное значение и значение по умолчанию: `0`, нет ограничения. Минимальная значение — 0.
group_by_overflow_mode | enum **GroupByOverflowMode**<br>Определяет поведение ClickHouse в ситуации, когда количество уникальных ключей при агрегации [превысило ограничения](https://clickhouse.tech/docs/ru/operations/settings/query-complexity/#restrictions-on-query-complexity). <br>- `throw` — прервать выполнение запроса, вернуть ошибку. - `break` — прервать выполнение запроса, вернуть неполный результат. - `any` — выполнить `GROUP BY` приближённо, продолжая агрегацию для ключей, которые попали в набор, без добавления новых ключей в набор. <ul><ul/>
max_rows_to_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Ограничивает максимальное количество строк для сортировки. Эта настройка позволяет ограничить потребление оперативной памяти при сортировке. <br>Минимальное значение и значение по умолчанию: `0`, нет ограничения. Минимальная значение — 0.
max_bytes_to_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Ограничивает максимальное количество байт (несжатых данных), которое можно прочитать из таблицы до сортировки. Эта настройка позволяет ограничить потребление оперативной памяти при сортировке. <br>Минимальное значение и значение по умолчанию: `0`, нет ограничения. Минимальная значение — 0.
sort_overflow_mode | enum **OverflowMode**<br>Определяет поведение ClickHouse в ситуации, когда количество строк, полученных перед сортировкой, [превысило ограничения](https://clickhouse.tech/docs/ru/operations/settings/query-complexity/#restrictions-on-query-complexity). <br>- `throw` — прервать выполнение запроса, вернуть ошибку. - `break` — прервать выполнение запроса, вернуть неполный результат. <ul><ul/>
max_result_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Ограничивает количество строк результата. Это ограничение также проверяется для подзапросов и частей распределенных запросов, выполняемых на удаленных серверах. <br>Минимальное значение и значение по умолчанию: `0`, нет ограничения. Минимальная значение — 0.
max_result_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Ограничивает количество байт результата. Это ограничение также проверяется для подзапросов и частей распределенных запросов, выполняемых на удаленных серверах. <br>Минимальное значение и значение по умолчанию: `0`, нет ограничения. Минимальная значение — 0.
result_overflow_mode | enum **OverflowMode**<br>определяет поведение ClickHouse в ситуации, когда объём результата [превысил ограничения](https://clickhouse.tech/docs/ru/operations/settings/query-complexity/#restrictions-on-query-complexity). <br>- `throw` — прервать выполнение запроса, вернуть ошибку. - `break` — прервать выполнение запроса, вернуть неполный результат. <ul><ul/>
max_rows_in_distinct | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Ограничивает максимальное количество различных строк при использовании `DISTINCT`. <br>Минимальное значение и значение по умолчанию: `0`, нет ограничения. Минимальная значение — 0.
max_bytes_in_distinct | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Ограничивает максимальное количество байт (несжатых данных), занимаемых хэш-таблицей, при использовании `DISTINCT`. Минимальная значение — 0.
distinct_overflow_mode | enum **OverflowMode**<br>Определяет поведение ClickHouse в ситуации, когда количество данных при выполнении запроса `DISTINCT` [превысило ограничения](https://clickhouse.tech/docs/ru/operations/settings/query-complexity/#restrictions-on-query-complexity). <br>- `throw` — прервать выполнение запроса, вернуть ошибку. - `break` — прервать выполнение запроса, вернуть неполный результат. <ul><ul/>
max_rows_to_transfer | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Ограничивает максимальное количество строк, которое можно передать на удалённый сервер или сохранить во временную таблицу при использовании `GLOBAL IN`. <br>Минимальное значение и значение по умолчанию: `0`, нет ограничения. Минимальная значение — 0.
max_bytes_to_transfer | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Ограничивает максимальное количество байт (несжатых данных), которых можно передать на удалённый сервер или сохранить во временную таблицу, при использовании `GLOBAL IN`. <br>Минимальное значение и значение по умолчанию: `0`, нет ограничения. Минимальная значение — 0.
transfer_overflow_mode | enum **OverflowMode**<br>Определяет поведение ClickHouse в ситуации, когда количество данных для передачи на другой сервер [превысило ограничения](https://clickhouse.tech/docs/ru/operations/settings/query-complexity/#restrictions-on-query-complexity). <br>- `throw` — прервать выполнение запроса, вернуть ошибку. - `break` — прервать выполнение запроса, вернуть неполный результат. <ul><ul/>
max_execution_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Ограничивает максимальное время выполнения запроса в миллисекундах. На данный момент это ограничение не проверяется при одной из стадий сортировки а также при слиянии и финализации агрегатных функций. <br>Минимальное значение и значение по умолчанию: `0`, нет ограничения. Минимальная значение — 0.
timeout_overflow_mode | enum **OverflowMode**<br>Определяет поведение ClickHouse в ситуации, когда запрос [превысил ограничения](https://clickhouse.tech/docs/ru/operations/settings/query-complexity/#restrictions-on-query-complexity) на время исполнения. <br>- `throw` — прервать выполнение запроса, вернуть ошибку. - `break` — прервать выполнение запроса, вернуть неполный результат. <ul><ul/>
max_columns_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Ограничивает максимальное количество столбцов, которые можно читать из таблицы в одном запросе. Если запрос требует чтения большего количества столбцов — он будет завершен с ошибкой. <br>Минимальное значение и значение по умолчанию: `0`, нет ограничения. Минимальная значение — 0.
max_temporary_columns | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Ограничивает максимальное количество временных столбцов, которое должно храниться в оперативной памяти одновременно при выполнении запроса (с учетом постоянных столбцов) <br>Минимальное значение и значение по умолчанию: `0`, нет ограничения. Минимальная значение — 0.
max_temporary_non_const_columns | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Ограничивает максимальное количество временных столбцов, которое должно храниться в оперативной памяти одновременно при выполнении запроса (без учета постоянных столбцов). <br>Минимальное значение и значение по умолчанию: `0`, нет ограничения. Минимальная значение — 0.
max_query_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Ограничивает размер наибольшей части запроса (в байтах), которая может быть передана в оперативную память для разбора с помощью парсера SQL. <br>Значение должно быть больше `0` (по умолчанию: `262144`). <br>См. подробное описание в [документации ClickHouse](https://clickhouse.tech/docs/ru/operations/settings/settings/#settings-max_query_size). Значение должно быть больше 0.
max_ast_depth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Ограничивает максимальную глубину вложенности синтаксического дерева. <br>Для больших и сложных запросов может быть построено синтаксическое дерево очень большой глубины. При помощи этой настройки вы можете запретить выполнение излишне больших или неоптимальных запросов для больших таблиц. <br>Например, запрос `SELECT *` в большинстве случаев породит более сложное и глубокое синтаксическое дерево, чем запрос `SELECT ... WHERE ...` с ограничениями и условиями. Наложение ограничения с помощью настройки может побудить пользователя оптимизировать излишне сложные запросы. <br>Значение должно быть больше `0` (по умолчанию: `1000`). Слишком маленькое значение может привести к невозможности выполнения большинства запросов. <br>См. подробное описание в [документации ClickHouse](https://clickhouse.tech/docs/ru/operations/settings/query-complexity/#max-ast-depth). Значение должно быть больше 0.
max_ast_elements | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Ограничивает максимальное количество элементов синтаксического дерева запроса (количество узлов дерева). <br>Для больших и сложных запросов может быть построено синтаксическое дерево c очень большим количеством элементов. При помощи этой настройки вы можете запретить выполнение излишне больших или неоптимальных запросов для больших таблиц. <br>Значение должно быть больше `0` (по умолчанию: `50000`). Слишком маленькое значение может привести к невозможности выполнения большинства запросов. <br>См. подробное описание в [документации ClickHouse](https://clickhouse.tech/docs/ru/operations/settings/query-complexity/#max-ast-elements). Значение должно быть больше 0.
max_expanded_ast_elements | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Ограничивает максимальное количество элементов синтаксического дерева запроса (количество узлов дерева) после раскрытия псевдонимов и звездочки. <br>Для больших и сложных запросов может быть построено синтаксическое дерево c очень большим количеством элементов. При помощи этой настройки вы можете запретить выполнение излишне больших или неоптимальных запросов для больших таблиц. <br>Значение должно быть больше `0` (по умолчанию: `500000`). Слишком маленькое значение может привести к невозможности выполнения большинства запросов. Значение должно быть больше 0.
input_format_values_interpret_expressions | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Включает или выключает парсер SQL, если потоковый парсер не может проанализировать данные. <br>Используйте эту настройку, если значения, которые вы хотите вставить в таблицу, содержат в себе выражения SQL. <br>Например, при вставке в таблицу значения, содержащего в себе выражение `now()`, потоковый парсер не сможет распознать это выражение; запрос `INSERT` завершится с ошибкой, и никакие данные не будут вставлены в таблицу. При включенном парсере SQL выражение будет распознано корректно и в качестве значения будет вставлен результат выполнения SQL-функции `now()` (текущая дата и время). <br>Эта настройка действует только в том случае, если вы используете формат [Values](https://clickhouse.tech/docs/ru/interfaces/formats/#data-format-values) при вставке данных. <br>Значение по умолчанию: `true` (парсер SQL включен). <br>См. подробное описание в [документации ClickHouse](https://clickhouse.tech/docs/ru/operations/settings/settings/#settings-input_format_values_interpret_expressions). 
input_format_defaults_for_omitted_fields | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Включает или выключает замену пропущенных полей значениями по умолчанию для типа данных столбца при вставке данных запросом `INSERT`. <br>Значение по умолчанию: `true` (замена включена). 
output_format_json_quote_64bit_integers | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Определяет формат чисел в JSON-выводе. <br>Если эта настройка включена, то при выводе в JSON 64-битные числа (`UInt64` и `Int64`) выводятся в кавычках (из соображений совместимости с большинством реализаций JavaScript). Иначе — без кавычек. <br>Значение по умолчанию: `false` (вывод 64-битных целых чисел в кавычках выключен). 
output_format_json_quote_denormals | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Включает вывод специальных значений для чисел с плавающей запятой (`+nan`, `-nan`, `+inf` и `-inf`) при выводе в JSON. <br>Значение по умолчанию: `false` (специальные значения не выводятся). 
low_cardinality_allow_in_native_format | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Определяет, использовать ли тип LowCardinality в Native-формате. <br>- `true` (по умолчанию) — да, использовать. - `false`— конвертировать столбцы LowCardinality в обычные столбцы для запроса `SELECT`, и конвертировать обычные столбцы в требуемый LowCardinality-столбец для запроса `INSERT`. <br>Столбцы этого типа, также известные как «разреженные столбцы», позволяют более эффективно хранить данные в виде хэш-таблиц. Если данные это позволяют, ClickHouse использует столбец типа LowCardinality. <br>Если вы используете сторонний клиент для ClickHouse, который не умеет работать со столбцами типа LowCardinality, то такой клиент не сможет правильно интерпретировать результат запроса, если в запросе будет присутствовать столбец типа LowCardinality. Выключите эту настройку, чтобы включать в результат столбец в обычном формате и позволить сторонним клиентам обработать результат. <br>Официальный клиент ClickHouse умеет работать со столбцами типа LowCardinality. <br>Значение по умолчанию: `true` (столбцы LowCardinality используются в Native-формате). 
empty_result_for_aggregation_by_empty_set | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Позволяет возвращать пустой результат при выполнении агрегации данных без ключей (без `GROUP BY`) для пустого множества (например, `SELECT count(*) FROM table WHERE 0`). <br>- `true`— ClickHouse вернет пустой результат. - `false` (по умолчанию) — ClickHouse вернет результат, состоящий из одной строки со значениями `NULL` для агрегатных функций, в соответствии со стандартом SQL. 
http_connection_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Время ожидания установления HTTP-соединения в миллисекундах. <br>Значение должно быть больше `0` (по умолчанию: `1000`, 1 секунда). 
http_receive_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Время ожидания приема данных через HTTP-соединение в миллисекундах. <br>Значение должно быть больше `0` (по умолчанию: `1800000`, 1800 секунд, 30 минут). 
http_send_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Время ожидания отправки данных через HTTP-соединение в миллисекундах. <br>Значение должно быть больше `0` (по умолчанию: `1800000`, 1800 секунд, 30 минут). 
enable_http_compression | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Включает или выключает сжатие данных в ответе на HTTP-запрос. <br>По умолчанию ClickHouse хранит данные в сжатом виде. При выполнении запроса его результат представлен в несжатом виде. С помощью этой настройки вы можете указать ClickHouse сжимать результат запроса при отправке по HTTP. <br>Чтобы ClickHouse сжал ответ при включенной настройке, добавьте в HTTP-запрос заголовок @b. <br>ClickHouse поддерживает следующие методы сжатия: `gzip`, `br` и `deflate`. <br>Значение по умолчанию: `false` (сжатие выключено). <br>См. подробное описание в [документации ClickHouse](https://clickhouse.tech/docs/ru/interfaces/http/). 
send_progress_in_http_headers | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Включает отсылку уведомления о ходе выполнения с использованием HTTP-заголовков `X-ClickHouse-Progress`. <br>Значение по умолчанию: `false` (отсылка уведомлений выключена). 
http_headers_progress_interval | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Задает минимальный интервал (в миллисекундах) между уведомлениями о ходе выполнения запроса с помощью HTTP-заголовка `X-ClickHouse-Progress`. <br>Значение должно быть больше `0` (по умолчанию: `100`). 
add_http_cors_header | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Включает заголовок CORS в HTTP-ответы. <br>Значение по умолчанию: `false` (заголовок не включается в HTTP-ответы). 


### UserQuota {#UserQuota}

Поле | Описание
--- | ---
interval_duration | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Длительность интервала для квоты в миллисекундах. Минимальное значение — 1 секунда. Минимальная значение — 1000.
queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Общее количество запросов. 0-неограниченно. Минимальная значение — 0.
errors | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Количество запросов, которые вызвали исключение. 0-неограниченно. Минимальная значение — 0.
result_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Общее число строк, приведенных в результате. 0-неограниченно. Минимальная значение — 0.
read_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Общее число исходных строк, считанных из таблиц для выполнения запроса, на всех удаленных серверах. 0-неограниченно. Минимальная значение — 0.
execution_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Общее время выполнения запроса, в миллисекундах. 0-неограниченно. Минимальная значение — 0.


### HostSpec {#HostSpec}

Поле | Описание
--- | ---
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится хост. Чтобы получить список доступных зон, используйте запрос [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List). Максимальная длина строки в символах — 50.
type | **[Host.Type](#Host)**<br>Обязательное поле. Тип развертываемого хоста. 
subnet_id | **string**<br>Идентификатор подсети, к которой должен принадлежать хост. Эта подсеть должна быть частью сети, к которой принадлежит кластер. Идентификатор сети задается в поле [Cluster.network_id](#Cluster2). Максимальная длина строки в символах — 50.
assign_public_ip | **bool**<br><ul><li>false — не назначать хосту публичный IP-адрес. </li><li>true — у хоста должен быть публичный IP-адрес.</li></ul> 
shard_name | **string**<br>Имя шарда, которому принадлежит хост. Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.


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
cluster_id | **string**<br>Идентификатор создаваемого кластера ClickHouse. 


### Cluster {#Cluster2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера ClickHouse. Этот идентификатор генерирует MDB при создании кластера. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер ClickHouse. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера ClickHouse. Имя уникально в рамках каталога. Длина 1-63 символов. 
description | **string**<br>Описание кластера ClickHouse. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера ClickHouse в виде пар `key:value`. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания кластера ClickHouse. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Описание систем мониторинга, относящихся к данному кластеру ClickHouse. 
config | **[ClusterConfig](#ClusterConfig2)**<br>Конфигурация кластера ClickHouse. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Здоровье кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](#Host) для каждого хоста в кластере — UNKNOWN).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](#Host) для каждого хоста в кластере — ALIVE).</li><li>`DEAD`: Кластер не работает ([Host.health](#Host) для каждого хоста в кластере — DEAD).</li><li>`DEGRADED`: Кластер работает неоптимально ([Host.health](#Host) по крайней мере для одного хоста в кластере не ALIVE).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: В кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>
service_account_id | **string**<br>Идентификатор сервисного аккаунта, используемого для доступа к Yandex Object Storage. 


### Monitoring {#Monitoring2}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для данного кластера ClickHouse. 


### ClusterConfig {#ClusterConfig2}

Поле | Описание
--- | ---
version | **string**<br>Версия серверного программного обеспечения ClickHouse. 
clickhouse | **[Clickhouse](#Clickhouse3)**<br>Конфигурация и распределение ресурсов для хостов ClickHouse. 
zookeeper | **[Zookeeper](#Zookeeper3)**<br>Конфигурация и распределение ресурсов для хостов ZooKeeper. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access3)**<br>Политика доступа для внешних сервисов. 


### Clickhouse {#Clickhouse3}

Поле | Описание
--- | ---
config | **`config.ClickhouseConfigSet`**<br>Параметры конфигурации сервера ClickHouse. 
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные хостам ClickHouse. 


### Zookeeper {#Zookeeper3}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные хостам ZooKeeper. 


### Access {#Access3}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить экспорт данных из кластера в Yandex DataLens. 
web_sql | **bool**<br>Разрешить SQL-запросы к базам данных кластера из консоли управления облаком. <br>Подробнее см. в [SQL-запросы в консоли управления](/docs/managed-clickhouse/operations/web-sql-query). 
metrika | **bool**<br>Разрешить импорт данных из Яндекс Метрики и AppMetrica в кластер. <br>Подробнее см. в [Экспорт данных в {{ yandex-cloud }}](https://appmetrica.yandex.ru/docs/common/cloud/about.html). 
serverless | **bool**<br>Разрешить доступ к кластеру для Serverless. 


## Update {#Update}

Изменяет указанный кластер ClickHouse.

**rpc Update ([UpdateClusterRequest](#UpdateClusterRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterMetadata](#UpdateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster3)<br>

### UpdateClusterRequest {#UpdateClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор ресурса Cluster для ClickHouse, который следует обновить. Чтобы получить идентификатор кластера ClickHouse, используйте запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска, которая указывает, какие поля ресурса Cluster для ClickHouse должны быть изменены. 
description | **string**<br>Новое описание кластера ClickHouse. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Пользовательские метки для кластера ClickHouse в виде пар `key:value`. Максимум 64 на ресурс. Например, "project": "mvp" или "source": "dictionary". <br>Новый набор меток полностью заменит старый. Чтобы добавить метку, запросите текущий набор меток с помощью метода [ClusterService.Get](#Get), затем отправьте запрос [ClusterService.Update](#Update), добавив новую метку в этот набор. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Максимальная длина строки в символах для каждого ключа — 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
config_spec | **[ConfigSpec](#ConfigSpec)**<br>Новая конфигурация и ресурсы для хостов кластера. 
name | **string**<br>Новое имя кластера. Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.
service_account_id | **string**<br>Идентификатор сервисного аккаунта, используемого для доступа к Yandex Object Storage. 


### ConfigSpec {#ConfigSpec1}

Поле | Описание
--- | ---
version | **string**<br>Версия серверного программного обеспечения ClickHouse. 
clickhouse | **[Clickhouse](#Clickhouse4)**<br>Конфигурация и ресурсы для сервера ClickHouse. 
zookeeper | **[Zookeeper](#Zookeeper4)**<br>Конфигурация и ресурсы для сервера ZooKeeper. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access4)**<br>Политика доступа для внешних сервисов. <br>Если вы хотите, чтобы определенный сервис получил доступ к кластеру ClickHouse — задайте необходимые значения в этой политике. 


### Clickhouse {#Clickhouse4}

Поле | Описание
--- | ---
config | **`config.ClickhouseConfig`**<br>Конфигурация для сервера ClickHouse. 
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные хостам ClickHouse. 


### Zookeeper {#Zookeeper4}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные хостам ZooKeeper. Если не задано, будет использоваться минимальный доступный набор ресурсов. Все доступные наборы ресурсов можно получить с помощью запроса [ResourcePresetService.List](./resource_preset_service#List). 


### Access {#Access4}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить экспорт данных из кластера в Yandex DataLens. 
web_sql | **bool**<br>Разрешить SQL-запросы к базам данных кластера из консоли управления облаком. <br>Подробнее см. в [SQL-запросы в консоли управления](/docs/managed-clickhouse/operations/web-sql-query). 
metrika | **bool**<br>Разрешить импорт данных из Яндекс Метрики и AppMetrica в кластер. <br>Подробнее см. в [Экспорт данных в {{ yandex-cloud }}](https://appmetrica.yandex.ru/docs/common/cloud/about.html). 
serverless | **bool**<br>Разрешить доступ к кластеру для Serverless. 


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
cluster_id | **string**<br>Идентификатор изменяемого ресурса Cluster для ClickHouse. 


### Cluster {#Cluster3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера ClickHouse. Этот идентификатор генерирует MDB при создании кластера. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер ClickHouse. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера ClickHouse. Имя уникально в рамках каталога. Длина 1-63 символов. 
description | **string**<br>Описание кластера ClickHouse. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера ClickHouse в виде пар `key:value`. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания кластера ClickHouse. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring3)**<br>Описание систем мониторинга, относящихся к данному кластеру ClickHouse. 
config | **[ClusterConfig](#ClusterConfig3)**<br>Конфигурация кластера ClickHouse. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Здоровье кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](#Host) для каждого хоста в кластере — UNKNOWN).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](#Host) для каждого хоста в кластере — ALIVE).</li><li>`DEAD`: Кластер не работает ([Host.health](#Host) для каждого хоста в кластере — DEAD).</li><li>`DEGRADED`: Кластер работает неоптимально ([Host.health](#Host) по крайней мере для одного хоста в кластере не ALIVE).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: В кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>
service_account_id | **string**<br>Идентификатор сервисного аккаунта, используемого для доступа к Yandex Object Storage. 


### Monitoring {#Monitoring3}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для данного кластера ClickHouse. 


### ClusterConfig {#ClusterConfig3}

Поле | Описание
--- | ---
version | **string**<br>Версия серверного программного обеспечения ClickHouse. 
clickhouse | **[Clickhouse](#Clickhouse5)**<br>Конфигурация и распределение ресурсов для хостов ClickHouse. 
zookeeper | **[Zookeeper](#Zookeeper5)**<br>Конфигурация и распределение ресурсов для хостов ZooKeeper. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access5)**<br>Политика доступа для внешних сервисов. 


### Clickhouse {#Clickhouse5}

Поле | Описание
--- | ---
config | **`config.ClickhouseConfigSet`**<br>Параметры конфигурации сервера ClickHouse. 
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные хостам ClickHouse. 


### Zookeeper {#Zookeeper5}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные хостам ZooKeeper. 


### Access {#Access5}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить экспорт данных из кластера в Yandex DataLens. 
web_sql | **bool**<br>Разрешить SQL-запросы к базам данных кластера из консоли управления облаком. <br>Подробнее см. в [SQL-запросы в консоли управления](/docs/managed-clickhouse/operations/web-sql-query). 
metrika | **bool**<br>Разрешить импорт данных из Яндекс Метрики и AppMetrica в кластер. <br>Подробнее см. в [Экспорт данных в {{ yandex-cloud }}](https://appmetrica.yandex.ru/docs/common/cloud/about.html). 
serverless | **bool**<br>Разрешить доступ к кластеру для Serverless. 


## Delete {#Delete}

Удаляет указанный кластер ClickHouse.

**rpc Delete ([DeleteClusterRequest](#DeleteClusterRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterMetadata](#DeleteClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterRequest {#DeleteClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера ClickHouse, который нужно удалить. Чтобы получить идентификатор кластера ClickHouse, используйте запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.


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
cluster_id | **string**<br>Идентификатор удаляемого кластера ClickHouse. 


## Start {#Start}

Запускает указанный кластер ClickHouse.

**rpc Start ([StartClusterRequest](#StartClusterRequest)) returns ([operation.Operation](#Operation3))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartClusterMetadata](#StartClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster4)<br>

### StartClusterRequest {#StartClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера ClickHouse, который следует запустить. Максимальная длина строки в символах — 50.


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
cluster_id | **string**<br>Идентификатор запускаемого кластера ClickHouse. 


### Cluster {#Cluster4}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера ClickHouse. Этот идентификатор генерирует MDB при создании кластера. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер ClickHouse. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера ClickHouse. Имя уникально в рамках каталога. Длина 1-63 символов. 
description | **string**<br>Описание кластера ClickHouse. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера ClickHouse в виде пар `key:value`. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания кластера ClickHouse. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring4)**<br>Описание систем мониторинга, относящихся к данному кластеру ClickHouse. 
config | **[ClusterConfig](#ClusterConfig4)**<br>Конфигурация кластера ClickHouse. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Здоровье кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](#Host) для каждого хоста в кластере — UNKNOWN).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](#Host) для каждого хоста в кластере — ALIVE).</li><li>`DEAD`: Кластер не работает ([Host.health](#Host) для каждого хоста в кластере — DEAD).</li><li>`DEGRADED`: Кластер работает неоптимально ([Host.health](#Host) по крайней мере для одного хоста в кластере не ALIVE).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: В кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>
service_account_id | **string**<br>Идентификатор сервисного аккаунта, используемого для доступа к Yandex Object Storage. 


### Monitoring {#Monitoring4}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для данного кластера ClickHouse. 


### ClusterConfig {#ClusterConfig4}

Поле | Описание
--- | ---
version | **string**<br>Версия серверного программного обеспечения ClickHouse. 
clickhouse | **[Clickhouse](#Clickhouse6)**<br>Конфигурация и распределение ресурсов для хостов ClickHouse. 
zookeeper | **[Zookeeper](#Zookeeper6)**<br>Конфигурация и распределение ресурсов для хостов ZooKeeper. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access6)**<br>Политика доступа для внешних сервисов. 


### Clickhouse {#Clickhouse6}

Поле | Описание
--- | ---
config | **`config.ClickhouseConfigSet`**<br>Параметры конфигурации сервера ClickHouse. 
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные хостам ClickHouse. 


### Zookeeper {#Zookeeper6}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные хостам ZooKeeper. 


### Access {#Access6}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить экспорт данных из кластера в Yandex DataLens. 
web_sql | **bool**<br>Разрешить SQL-запросы к базам данных кластера из консоли управления облаком. <br>Подробнее см. в [SQL-запросы в консоли управления](/docs/managed-clickhouse/operations/web-sql-query). 
metrika | **bool**<br>Разрешить импорт данных из Яндекс Метрики и AppMetrica в кластер. <br>Подробнее см. в [Экспорт данных в {{ yandex-cloud }}](https://appmetrica.yandex.ru/docs/common/cloud/about.html). 
serverless | **bool**<br>Разрешить доступ к кластеру для Serverless. 


## Stop {#Stop}

Останавливает указанный кластер ClickHouse.

**rpc Stop ([StopClusterRequest](#StopClusterRequest)) returns ([operation.Operation](#Operation4))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopClusterMetadata](#StopClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster5)<br>

### StopClusterRequest {#StopClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера ClickHouse, который следует остановить. Максимальная длина строки в символах — 50.


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
cluster_id | **string**<br>Идентификатор останавливаемого кластера ClickHouse. 


### Cluster {#Cluster5}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера ClickHouse. Этот идентификатор генерирует MDB при создании кластера. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер ClickHouse. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера ClickHouse. Имя уникально в рамках каталога. Длина 1-63 символов. 
description | **string**<br>Описание кластера ClickHouse. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера ClickHouse в виде пар `key:value`. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания кластера ClickHouse. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring5)**<br>Описание систем мониторинга, относящихся к данному кластеру ClickHouse. 
config | **[ClusterConfig](#ClusterConfig5)**<br>Конфигурация кластера ClickHouse. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Здоровье кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](#Host) для каждого хоста в кластере — UNKNOWN).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](#Host) для каждого хоста в кластере — ALIVE).</li><li>`DEAD`: Кластер не работает ([Host.health](#Host) для каждого хоста в кластере — DEAD).</li><li>`DEGRADED`: Кластер работает неоптимально ([Host.health](#Host) по крайней мере для одного хоста в кластере не ALIVE).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: В кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>
service_account_id | **string**<br>Идентификатор сервисного аккаунта, используемого для доступа к Yandex Object Storage. 


### Monitoring {#Monitoring5}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для данного кластера ClickHouse. 


### ClusterConfig {#ClusterConfig5}

Поле | Описание
--- | ---
version | **string**<br>Версия серверного программного обеспечения ClickHouse. 
clickhouse | **[Clickhouse](#Clickhouse7)**<br>Конфигурация и распределение ресурсов для хостов ClickHouse. 
zookeeper | **[Zookeeper](#Zookeeper7)**<br>Конфигурация и распределение ресурсов для хостов ZooKeeper. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access7)**<br>Политика доступа для внешних сервисов. 


### Clickhouse {#Clickhouse7}

Поле | Описание
--- | ---
config | **`config.ClickhouseConfigSet`**<br>Параметры конфигурации сервера ClickHouse. 
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные хостам ClickHouse. 


### Zookeeper {#Zookeeper7}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные хостам ZooKeeper. 


### Access {#Access7}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить экспорт данных из кластера в Yandex DataLens. 
web_sql | **bool**<br>Разрешить SQL-запросы к базам данных кластера из консоли управления облаком. <br>Подробнее см. в [SQL-запросы в консоли управления](/docs/managed-clickhouse/operations/web-sql-query). 
metrika | **bool**<br>Разрешить импорт данных из Яндекс Метрики и AppMetrica в кластер. <br>Подробнее см. в [Экспорт данных в {{ yandex-cloud }}](https://appmetrica.yandex.ru/docs/common/cloud/about.html). 
serverless | **bool**<br>Разрешить доступ к кластеру для Serverless. 


## Move {#Move}

Перемещает кластер ClickHouse в указанный каталог.

**rpc Move ([MoveClusterRequest](#MoveClusterRequest)) returns ([operation.Operation](#Operation5))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[MoveClusterMetadata](#MoveClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster6)<br>

### MoveClusterRequest {#MoveClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера ClickHouse, который следует переместить. Максимальная длина строки в символах — 50.
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
cluster_id | **string**<br>Идентификатор перемещаемого кластера ClickHouse. 
source_folder_id | **string**<br>Идентификатор исходного каталога. 
destination_folder_id | **string**<br>Идентификатор каталога, в который следует переместить кластер. 


### Cluster {#Cluster6}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера ClickHouse. Этот идентификатор генерирует MDB при создании кластера. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер ClickHouse. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера ClickHouse. Имя уникально в рамках каталога. Длина 1-63 символов. 
description | **string**<br>Описание кластера ClickHouse. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера ClickHouse в виде пар `key:value`. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания кластера ClickHouse. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring6)**<br>Описание систем мониторинга, относящихся к данному кластеру ClickHouse. 
config | **[ClusterConfig](#ClusterConfig6)**<br>Конфигурация кластера ClickHouse. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Здоровье кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](#Host) для каждого хоста в кластере — UNKNOWN).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](#Host) для каждого хоста в кластере — ALIVE).</li><li>`DEAD`: Кластер не работает ([Host.health](#Host) для каждого хоста в кластере — DEAD).</li><li>`DEGRADED`: Кластер работает неоптимально ([Host.health](#Host) по крайней мере для одного хоста в кластере не ALIVE).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: В кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>
service_account_id | **string**<br>Идентификатор сервисного аккаунта, используемого для доступа к Yandex Object Storage. 


### Monitoring {#Monitoring6}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для данного кластера ClickHouse. 


### ClusterConfig {#ClusterConfig6}

Поле | Описание
--- | ---
version | **string**<br>Версия серверного программного обеспечения ClickHouse. 
clickhouse | **[Clickhouse](#Clickhouse8)**<br>Конфигурация и распределение ресурсов для хостов ClickHouse. 
zookeeper | **[Zookeeper](#Zookeeper8)**<br>Конфигурация и распределение ресурсов для хостов ZooKeeper. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access8)**<br>Политика доступа для внешних сервисов. 


### Clickhouse {#Clickhouse8}

Поле | Описание
--- | ---
config | **`config.ClickhouseConfigSet`**<br>Параметры конфигурации сервера ClickHouse. 
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные хостам ClickHouse. 


### Zookeeper {#Zookeeper8}

Поле | Описание
--- | ---
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные хостам ZooKeeper. 


### Access {#Access8}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить экспорт данных из кластера в Yandex DataLens. 
web_sql | **bool**<br>Разрешить SQL-запросы к базам данных кластера из консоли управления облаком. <br>Подробнее см. в [SQL-запросы в консоли управления](/docs/managed-clickhouse/operations/web-sql-query). 
metrika | **bool**<br>Разрешить импорт данных из Яндекс Метрики и AppMetrica в кластер. <br>Подробнее см. в [Экспорт данных в {{ yandex-cloud }}](https://appmetrica.yandex.ru/docs/common/cloud/about.html). 
serverless | **bool**<br>Разрешить доступ к кластеру для Serverless. 


## AddZookeeper {#AddZookeeper}

Добавляет подкластер ZooKeeper в указанный кластер ClickHouse.

**rpc AddZookeeper ([AddClusterZookeeperRequest](#AddClusterZookeeperRequest)) returns ([operation.Operation](#Operation6))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddClusterZookeeperMetadata](#AddClusterZookeeperMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster7)<br>

### AddClusterZookeeperRequest {#AddClusterZookeeperRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера ClickHouse, который следует изменить. Максимальная длина строки в символах — 50.
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные хостам ZooKeeper. 
host_specs[] | **[HostSpec](#HostSpec)**<br>Конфигурация хостов ZooKeeper. 


### Resources {#Resources}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [документации](/docs/managed-clickhouse/concepts/instance-types). 
disk_size | **int64**<br>Объем хранилища, доступного хосту, в байтах. 
disk_type_id | **string**<br><ul><li>network-hdd — сетевой HDD-диск; </li><li>network-ssd — сетевой SSD-диск; </li><li>local-ssd — локальное SSD-хранилище.</li></ul> 


### HostSpec {#HostSpec1}

Поле | Описание
--- | ---
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится хост. Чтобы получить список доступных зон, используйте запрос [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List). Максимальная длина строки в символах — 50.
type | **[Host.Type](#Host)**<br>Обязательное поле. Тип развертываемого хоста. 
subnet_id | **string**<br>Идентификатор подсети, к которой должен принадлежать хост. Эта подсеть должна быть частью сети, к которой принадлежит кластер. Идентификатор сети задается в поле [Cluster.network_id](#Cluster7). Максимальная длина строки в символах — 50.
assign_public_ip | **bool**<br><ul><li>false — не назначать хосту публичный IP-адрес. </li><li>true — у хоста должен быть публичный IP-адрес.</li></ul> 
shard_name | **string**<br>Имя шарда, которому принадлежит хост. Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.


### Operation {#Operation6}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AddClusterZookeeperMetadata](#AddClusterZookeeperMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster7)>**<br>в случае успешного выполнения операции. 


### AddClusterZookeeperMetadata {#AddClusterZookeeperMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера ClickHouse. 


### Cluster {#Cluster7}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера ClickHouse. Этот идентификатор генерирует MDB при создании кластера. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер ClickHouse. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера ClickHouse. Имя уникально в рамках каталога. Длина 1-63 символов. 
description | **string**<br>Описание кластера ClickHouse. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера ClickHouse в виде пар `key:value`. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания кластера ClickHouse. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring7)**<br>Описание систем мониторинга, относящихся к данному кластеру ClickHouse. 
config | **[ClusterConfig](#ClusterConfig7)**<br>Конфигурация кластера ClickHouse. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Здоровье кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](#Host) для каждого хоста в кластере — UNKNOWN).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](#Host) для каждого хоста в кластере — ALIVE).</li><li>`DEAD`: Кластер не работает ([Host.health](#Host) для каждого хоста в кластере — DEAD).</li><li>`DEGRADED`: Кластер работает неоптимально ([Host.health](#Host) по крайней мере для одного хоста в кластере не ALIVE).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: В кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>
service_account_id | **string**<br>Идентификатор сервисного аккаунта, используемого для доступа к Yandex Object Storage. 


### Monitoring {#Monitoring7}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для данного кластера ClickHouse. 


### ClusterConfig {#ClusterConfig7}

Поле | Описание
--- | ---
version | **string**<br>Версия серверного программного обеспечения ClickHouse. 
clickhouse | **[Clickhouse](#Clickhouse9)**<br>Конфигурация и распределение ресурсов для хостов ClickHouse. 
zookeeper | **[Zookeeper](#Zookeeper9)**<br>Конфигурация и распределение ресурсов для хостов ZooKeeper. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access9)**<br>Политика доступа для внешних сервисов. 


### Clickhouse {#Clickhouse9}

Поле | Описание
--- | ---
config | **`config.ClickhouseConfigSet`**<br>Параметры конфигурации сервера ClickHouse. 
resources | **[Resources](#Resources1)**<br>Ресурсы, выделенные хостам ClickHouse. 


### Zookeeper {#Zookeeper9}

Поле | Описание
--- | ---
resources | **[Resources](#Resources1)**<br>Ресурсы, выделенные хостам ZooKeeper. 


### Access {#Access9}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить экспорт данных из кластера в Yandex DataLens. 
web_sql | **bool**<br>Разрешить SQL-запросы к базам данных кластера из консоли управления облаком. <br>Подробнее см. в [SQL-запросы в консоли управления](/docs/managed-clickhouse/operations/web-sql-query). 
metrika | **bool**<br>Разрешить импорт данных из Яндекс Метрики и AppMetrica в кластер. <br>Подробнее см. в [Экспорт данных в {{ yandex-cloud }}](https://appmetrica.yandex.ru/docs/common/cloud/about.html). 
serverless | **bool**<br>Разрешить доступ к кластеру для Serverless. 


## Backup {#Backup}

Создает резервную копию для указанного кластера ClickHouse.

**rpc Backup ([BackupClusterRequest](#BackupClusterRequest)) returns ([operation.Operation](#Operation7))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[BackupClusterMetadata](#BackupClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster8)<br>

### BackupClusterRequest {#BackupClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера ClickHouse, для которого следует создать резервную копию. Чтобы получить идентификатор кластера ClickHouse, используйте запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.


### Operation {#Operation7}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster8)>**<br>в случае успешного выполнения операции. 


### BackupClusterMetadata {#BackupClusterMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера ClickHouse, для которого выполняется резервное копирование. 


### Cluster {#Cluster8}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера ClickHouse. Этот идентификатор генерирует MDB при создании кластера. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер ClickHouse. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера ClickHouse. Имя уникально в рамках каталога. Длина 1-63 символов. 
description | **string**<br>Описание кластера ClickHouse. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера ClickHouse в виде пар `key:value`. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания кластера ClickHouse. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring8)**<br>Описание систем мониторинга, относящихся к данному кластеру ClickHouse. 
config | **[ClusterConfig](#ClusterConfig8)**<br>Конфигурация кластера ClickHouse. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Здоровье кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](#Host) для каждого хоста в кластере — UNKNOWN).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](#Host) для каждого хоста в кластере — ALIVE).</li><li>`DEAD`: Кластер не работает ([Host.health](#Host) для каждого хоста в кластере — DEAD).</li><li>`DEGRADED`: Кластер работает неоптимально ([Host.health](#Host) по крайней мере для одного хоста в кластере не ALIVE).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: В кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>
service_account_id | **string**<br>Идентификатор сервисного аккаунта, используемого для доступа к Yandex Object Storage. 


### Monitoring {#Monitoring8}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для данного кластера ClickHouse. 


### ClusterConfig {#ClusterConfig8}

Поле | Описание
--- | ---
version | **string**<br>Версия серверного программного обеспечения ClickHouse. 
clickhouse | **[Clickhouse](#Clickhouse10)**<br>Конфигурация и распределение ресурсов для хостов ClickHouse. 
zookeeper | **[Zookeeper](#Zookeeper10)**<br>Конфигурация и распределение ресурсов для хостов ZooKeeper. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access10)**<br>Политика доступа для внешних сервисов. 


### Clickhouse {#Clickhouse10}

Поле | Описание
--- | ---
config | **`config.ClickhouseConfigSet`**<br>Параметры конфигурации сервера ClickHouse. 
resources | **[Resources](#Resources1)**<br>Ресурсы, выделенные хостам ClickHouse. 


### Zookeeper {#Zookeeper10}

Поле | Описание
--- | ---
resources | **[Resources](#Resources1)**<br>Ресурсы, выделенные хостам ZooKeeper. 


### Access {#Access10}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить экспорт данных из кластера в Yandex DataLens. 
web_sql | **bool**<br>Разрешить SQL-запросы к базам данных кластера из консоли управления облаком. <br>Подробнее см. в [SQL-запросы в консоли управления](/docs/managed-clickhouse/operations/web-sql-query). 
metrika | **bool**<br>Разрешить импорт данных из Яндекс Метрики и AppMetrica в кластер. <br>Подробнее см. в [Экспорт данных в {{ yandex-cloud }}](https://appmetrica.yandex.ru/docs/common/cloud/about.html). 
serverless | **bool**<br>Разрешить доступ к кластеру для Serverless. 


## Restore {#Restore}

Создает новый кластер ClickHouse с использованием указанной резервной копии.

**rpc Restore ([RestoreClusterRequest](#RestoreClusterRequest)) returns ([operation.Operation](#Operation8))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RestoreClusterMetadata](#RestoreClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster9)<br>

### RestoreClusterRequest {#RestoreClusterRequest}

Поле | Описание
--- | ---
backup_id | **string**<br>Обязательное поле. Идентификатор резервной копии, из которой следует создать кластер. Чтобы получить идентификатор резервной копии, используйте запрос [ClusterService.ListBackups](#ListBackups). 
name | **string**<br>Обязательное поле. Имя нового кластера ClickHouse. Имя должно быть уникальным в рамках каталога. Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.
description | **string**<br>Описание нового кластера ClickHouse. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Пользовательские метки для кластера ClickHouse в виде пар `key:value`. Максимум 64 на ресурс. Например, "project": "mvp" или "source": "dictionary". Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Максимальная длина строки в символах для каждого ключа — 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
environment | **[Cluster.Environment](#Cluster9)**<br>Обязательное поле. Среда развертывания для нового кластера ClickHouse. 
config_spec | **[ConfigSpec](#ConfigSpec)**<br>Обязательное поле. Конфигурация для создаваемого кластера ClickHouse. 
host_specs[] | **[HostSpec](#HostSpec)**<br>Конфигурации для хостов ClickHouse, которые должны быть созданы для кластера, создаваемого из резервной копии. Количество элементов должно быть больше 0.
network_id | **string**<br>Обязательное поле. Идентификатор сети, в которой нужно создать кластер. Максимальная длина строки в символах — 50.
folder_id | **string**<br>Идентификатор каталога, в котором нужно создать кластер ClickHouse. Максимальная длина строки в символах — 50.
service_account_id | **string**<br>Идентификатор сервисного аккаунта, используемого для доступа к Yandex Object Storage. 


### ConfigSpec {#ConfigSpec2}

Поле | Описание
--- | ---
version | **string**<br>Версия серверного программного обеспечения ClickHouse. 
clickhouse | **[Clickhouse](#Clickhouse11)**<br>Конфигурация и ресурсы для сервера ClickHouse. 
zookeeper | **[Zookeeper](#Zookeeper11)**<br>Конфигурация и ресурсы для сервера ZooKeeper. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access11)**<br>Политика доступа для внешних сервисов. <br>Если вы хотите, чтобы определенный сервис получил доступ к кластеру ClickHouse — задайте необходимые значения в этой политике. 


### Clickhouse {#Clickhouse11}

Поле | Описание
--- | ---
config | **`config.ClickhouseConfig`**<br>Конфигурация для сервера ClickHouse. 
resources | **[Resources](#Resources1)**<br>Ресурсы, выделенные хостам ClickHouse. 


### Zookeeper {#Zookeeper11}

Поле | Описание
--- | ---
resources | **[Resources](#Resources1)**<br>Ресурсы, выделенные хостам ZooKeeper. Если не задано, будет использоваться минимальный доступный набор ресурсов. Все доступные наборы ресурсов можно получить с помощью запроса [ResourcePresetService.List](./resource_preset_service#List). 


### Access {#Access11}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить экспорт данных из кластера в Yandex DataLens. 
web_sql | **bool**<br>Разрешить SQL-запросы к базам данных кластера из консоли управления облаком. <br>Подробнее см. в [SQL-запросы в консоли управления](/docs/managed-clickhouse/operations/web-sql-query). 
metrika | **bool**<br>Разрешить импорт данных из Яндекс Метрики и AppMetrica в кластер. <br>Подробнее см. в [Экспорт данных в {{ yandex-cloud }}](https://appmetrica.yandex.ru/docs/common/cloud/about.html). 
serverless | **bool**<br>Разрешить доступ к кластеру для Serverless. 


### HostSpec {#HostSpec2}

Поле | Описание
--- | ---
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится хост. Чтобы получить список доступных зон, используйте запрос [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List). Максимальная длина строки в символах — 50.
type | **[Host.Type](#Host)**<br>Обязательное поле. Тип развертываемого хоста. 
subnet_id | **string**<br>Идентификатор подсети, к которой должен принадлежать хост. Эта подсеть должна быть частью сети, к которой принадлежит кластер. Идентификатор сети задается в поле [Cluster.network_id](#Cluster9). Максимальная длина строки в символах — 50.
assign_public_ip | **bool**<br><ul><li>false — не назначать хосту публичный IP-адрес. </li><li>true — у хоста должен быть публичный IP-адрес.</li></ul> 
shard_name | **string**<br>Имя шарда, которому принадлежит хост. Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.


### Operation {#Operation8}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster9)>**<br>в случае успешного выполнения операции. 


### RestoreClusterMetadata {#RestoreClusterMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор нового кластера ClickHouse, создаваемого из резервной копии. 
backup_id | **string**<br>Идентификатор резервной копии, используемой для создания кластера. 


### Cluster {#Cluster9}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера ClickHouse. Этот идентификатор генерирует MDB при создании кластера. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер ClickHouse. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера ClickHouse. Имя уникально в рамках каталога. Длина 1-63 символов. 
description | **string**<br>Описание кластера ClickHouse. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера ClickHouse в виде пар `key:value`. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания кластера ClickHouse. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring9)**<br>Описание систем мониторинга, относящихся к данному кластеру ClickHouse. 
config | **[ClusterConfig](#ClusterConfig9)**<br>Конфигурация кластера ClickHouse. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Здоровье кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](#Host) для каждого хоста в кластере — UNKNOWN).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](#Host) для каждого хоста в кластере — ALIVE).</li><li>`DEAD`: Кластер не работает ([Host.health](#Host) для каждого хоста в кластере — DEAD).</li><li>`DEGRADED`: Кластер работает неоптимально ([Host.health](#Host) по крайней мере для одного хоста в кластере не ALIVE).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: В кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>
service_account_id | **string**<br>Идентификатор сервисного аккаунта, используемого для доступа к Yandex Object Storage. 


### Monitoring {#Monitoring9}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для данного кластера ClickHouse. 


### ClusterConfig {#ClusterConfig9}

Поле | Описание
--- | ---
version | **string**<br>Версия серверного программного обеспечения ClickHouse. 
clickhouse | **[Clickhouse](#Clickhouse12)**<br>Конфигурация и распределение ресурсов для хостов ClickHouse. 
zookeeper | **[Zookeeper](#Zookeeper12)**<br>Конфигурация и распределение ресурсов для хостов ZooKeeper. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access12)**<br>Политика доступа для внешних сервисов. 


### Clickhouse {#Clickhouse12}

Поле | Описание
--- | ---
config | **`config.ClickhouseConfigSet`**<br>Параметры конфигурации сервера ClickHouse. 
resources | **[Resources](#Resources1)**<br>Ресурсы, выделенные хостам ClickHouse. 


### Zookeeper {#Zookeeper12}

Поле | Описание
--- | ---
resources | **[Resources](#Resources1)**<br>Ресурсы, выделенные хостам ZooKeeper. 


### Access {#Access12}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить экспорт данных из кластера в Yandex DataLens. 
web_sql | **bool**<br>Разрешить SQL-запросы к базам данных кластера из консоли управления облаком. <br>Подробнее см. в [SQL-запросы в консоли управления](/docs/managed-clickhouse/operations/web-sql-query). 
metrika | **bool**<br>Разрешить импорт данных из Яндекс Метрики и AppMetrica в кластер. <br>Подробнее см. в [Экспорт данных в {{ yandex-cloud }}](https://appmetrica.yandex.ru/docs/common/cloud/about.html). 
serverless | **bool**<br>Разрешить доступ к кластеру для Serverless. 


## ListLogs {#ListLogs}

Получает логи для указанного кластера ClickHouse.

**rpc ListLogs ([ListClusterLogsRequest](#ListClusterLogsRequest)) returns ([ListClusterLogsResponse](#ListClusterLogsResponse))**

### ListClusterLogsRequest {#ListClusterLogsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера ClickHouse, для которого следует запросить логи. Чтобы получить идентификатор кластера ClickHouse, используйте запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
column_filter[] | **string**<br>Столбцы из таблицы логов, которые нужно запросить. Если столбцы не указаны, записи логов возвращаются целиком. 
service_type | enum **ServiceType**<br>Тип сервиса, для которого следует запросить логи. <ul><li>`CLICKHOUSE`: Логи работы ClickHouse.</li><ul/>
from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Начало периода, для которого следует запросить логи, в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Конец периода, для которого следует запросить логи, в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
page_size | **int64**<br>Максимальное количество результатов на одной странице в ответе. Если количество результатов больше чем `page_size`, сервис вернет значение [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListClusterLogsResponse {#ListClusterLogsResponse}

Поле | Описание
--- | ---
logs[] | **[LogRecord](#LogRecord)**<br>Запрошенные записи в логе. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListClusterLogsRequest.page_size](#ListClusterLogsRequest), используйте `next_page_token` в качестве значения параметра [ListClusterLogsRequest.page_token](#ListClusterLogsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. Это значение взаимозаменяемо с [StreamLogRecord.next_record_token](#StreamLogRecord) из метода StreamLogs. 


### LogRecord {#LogRecord}

Поле | Описание
--- | ---
timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Отметка времени для записи журнала в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) текстовом формате. 
message | **map<string,string>**<br>Содержимое записи в логе. 


## StreamLogs {#StreamLogs}

То же самое, что ListLogs, с той разницей, что со стороны сервера передается поток логов. Допускается использовать семантику 'tail-f' при работе с потоком логов.

**rpc StreamLogs ([StreamClusterLogsRequest](#StreamClusterLogsRequest)) returns (stream [StreamLogRecord](#StreamLogRecord))**

### StreamClusterLogsRequest {#StreamClusterLogsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Обязательное поле. Идентификатор кластера ClickHouse. Максимальная длина строки в символах — 50.
column_filter[] | **string**<br>Столбцы, которые нужно запросить из лога. 
service_type | enum **ServiceType**<br> <ul><li>`CLICKHOUSE`: Логи работы ClickHouse.</li><ul/>
from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Временная метка, начиная с которой следует запросить логи. 
to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Временная метка, до которой следует запросить логи. Если значение этого поля не задано, то будут отправлены все существующие записи в логе, а затем и новые по мере их появления. В сущности, это эквивалентно семантике `tail -f`. 
record_token | **string**<br>Токен записи. Задайте значение `record_token` равным значению [StreamLogRecord.next_record_token](#StreamLogRecord), возвращенному предыдущим запросом StreamLogs, чтобы продолжить стриминг со следующей записи в логе. Максимальная длина строки в символах — 100.


### StreamLogRecord {#StreamLogRecord}

Поле | Описание
--- | ---
record | **[LogRecord](#LogRecord)**<br>Одна из запрошенных записей в логе. 
next_record_token | **string**<br>Этот токен позволяет продолжить работу с потоком логов, начиная с этой записи. Чтобы продолжить работу с потоком, укажите значение `next_record_token` в качестве значения параметра [StreamClusterLogsRequest.record_token](#StreamClusterLogsRequest) в следующем запросе StreamLogs. Это значение взаимозаменяемо с [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) из метода ListLogs. 


### LogRecord {#LogRecord1}

Поле | Описание
--- | ---
timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Отметка времени для записи журнала в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) текстовом формате. 
message | **map<string,string>**<br>Содержимое записи в логе. 


## ListOperations {#ListOperations}

Получает список ресурсов Operation для указанного кластера.

**rpc ListOperations ([ListClusterOperationsRequest](#ListClusterOperationsRequest)) returns ([ListClusterOperationsResponse](#ListClusterOperationsResponse))**

### ListClusterOperationsRequest {#ListClusterOperationsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор ресурса Cluster для ClickHouse, для которого запрашивается список операций. Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на одной странице в ответе. Если количество результатов больше чем `page_size`, сервис вернет значение [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListClusterOperationsResponse {#ListClusterOperationsResponse}

Поле | Описание
--- | ---
operations[] | **[operation.Operation](#Operation9)**<br>Список ресурсов Operation для указанного кластера ClickHouse. 
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

Получает список доступных резервных копий для указанного кластера ClickHouse.

**rpc ListBackups ([ListClusterBackupsRequest](#ListClusterBackupsRequest)) returns ([ListClusterBackupsResponse](#ListClusterBackupsResponse))**

### ListClusterBackupsRequest {#ListClusterBackupsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера ClickHouse. Чтобы получить идентификатор кластера ClickHouse, используйте запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на одной странице в ответе. Если количество результатов больше чем `page_size`, сервис вернет значение [ListClusterBackupsResponse.next_page_token](#ListClusterBackupsResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListClusterBackupsResponse.next_page_token](#ListClusterBackupsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListClusterBackupsResponse {#ListClusterBackupsResponse}

Поле | Описание
--- | ---
backups[] | **[Backup](#Backup)**<br>Список ресурсов Backup для ClickHouse. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListClusterBackupsRequest.page_size](#ListClusterBackupsRequest), используйте `next_page_token` в качестве значения параметра [ListClusterBackupsRequest.page_token](#ListClusterBackupsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Backup {#Backup}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор резервной копии. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит резервная копия. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) (т. е. когда операция резервного копирования была завершена). 
source_cluster_id | **string**<br>Идентификатор кластера ClickHouse, для которого была создана резервная копия. 
source_shard_names[] | **string**<br>Имена шардов, включенных в резервную копию. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время запуска операции резервного копирования. 


## ListHosts {#ListHosts}

Получает список хостов для указанного кластера.

**rpc ListHosts ([ListClusterHostsRequest](#ListClusterHostsRequest)) returns ([ListClusterHostsResponse](#ListClusterHostsResponse))**

### ListClusterHostsRequest {#ListClusterHostsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера ClickHouse. Чтобы получить идентификатор кластера ClickHouse, используйте запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на одной странице в ответе. Если количество результатов больше чем `page_size`, сервис вернет значение [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListClusterHostsResponse {#ListClusterHostsResponse}

Поле | Описание
--- | ---
hosts[] | **[Host](#Host)**<br>Запрошенный список хостов для кластера. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListClusterHostsRequest.page_size](#ListClusterHostsRequest), используйте `next_page_token` в качестве значения параметра [ListClusterHostsRequest.page_token](#ListClusterHostsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Host {#Host}

Поле | Описание
--- | ---
name | **string**<br>Имя хоста ClickHouse. Имя хоста назначается MDB во время создания и не может быть изменено. Длина 1-63 символов. <br>Имя уникально для всех существующих хостов MDB в Яндекс.Облаке, так как оно определяет полное доменное имя (FQDN) хоста. 
cluster_id | **string**<br>Идентификатор хоста ClickHouse. Этот идентификатор генерирует MDB при создании. 
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится хост ClickHouse. 
type | enum **Type**<br>Тип хоста. <ul><li>`CLICKHOUSE`: Хост ClickHouse.</li><li>`ZOOKEEPER`: Хост ZooKeeper.</li><ul/>
resources | **[Resources](#Resources1)**<br>Ресурсы, выделенные хосту ClickHouse. 
health | enum **Health**<br>Код работоспособности хоста. <ul><li>`UNKNOWN`: Состояние хоста неизвестно.</li><li>`ALIVE`: Хост работает и выполняет все свои функции.</li><li>`DEAD`: Хост не работает и не может выполнять свои основные функции.</li><li>`DEGRADED`: Хост деградировал, и может выполнять только некоторые из своих основных функций.</li><ul/>
services[] | **[Service](#Service)**<br>Сервисы, предоставляемые хостом. 
subnet_id | **string**<br>Идентификатор подсети, к которой принадлежит хост. 
assign_public_ip | **bool**<br>Флаг, показывающий статус публичного IP-адреса для этого хоста. 
shard_name | **string**<br> 


### Resources {#Resources1}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [документации](/docs/managed-clickhouse/concepts/instance-types). 
disk_size | **int64**<br>Объем хранилища, доступного хосту, в байтах. 
disk_type_id | **string**<br><ul><li>network-hdd — сетевой HDD-диск; </li><li>network-ssd — сетевой SSD-диск; </li><li>local-ssd — локальное SSD-хранилище.</li></ul> 


### Service {#Service}

Поле | Описание
--- | ---
type | enum **Type**<br>Тип сервиса, предоставляемого хостом. <ul><li>`CLICKHOUSE`: Хост — это сервер ClickHouse.</li><li>`ZOOKEEPER`: Хост — сервер ZooKeeper.</li><ul/>
health | enum **Health**<br>Код состояния доступности сервера. <ul><li>`UNKNOWN`: Работоспособность сервера неизвестна.</li><li>`ALIVE`: Сервер работает нормально.</li><li>`DEAD`: Сервер отключен или не отвечает.</li><ul/>


## AddHosts {#AddHosts}

Создает новые хосты для кластера.

**rpc AddHosts ([AddClusterHostsRequest](#AddClusterHostsRequest)) returns ([operation.Operation](#Operation10))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddClusterHostsMetadata](#AddClusterHostsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### AddClusterHostsRequest {#AddClusterHostsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера ClickHouse, для которого следует добавить хосты. Чтобы получить идентификатор кластера ClickHouse, используйте запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
host_specs[] | **[HostSpec](#HostSpec)**<br>Конфигурации для хостов ClickHouse, которые должны быть добавлены в кластер. Количество элементов должно быть больше 0.


### HostSpec {#HostSpec3}

Поле | Описание
--- | ---
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится хост. Чтобы получить список доступных зон, используйте запрос [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List). Максимальная длина строки в символах — 50.
type | **[Host.Type](#Host1)**<br>Обязательное поле. Тип развертываемого хоста. 
subnet_id | **string**<br>Идентификатор подсети, к которой должен принадлежать хост. Эта подсеть должна быть частью сети, к которой принадлежит кластер. Идентификатор сети задается в поле [Cluster.network_id](#Cluster10). Максимальная длина строки в символах — 50.
assign_public_ip | **bool**<br><ul><li>false — не назначать хосту публичный IP-адрес. </li><li>true — у хоста должен быть публичный IP-адрес.</li></ul> 
shard_name | **string**<br>Имя шарда, которому принадлежит хост. Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.


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
cluster_id | **string**<br>Идентификатор кластера ClickHouse, в который добавляются хосты. 
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
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера ClickHouse из которого следует удалить хосты. Чтобы получить идентификатор кластера ClickHouse, используйте запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
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
cluster_id | **string**<br>Идентификатор кластера ClickHouse из которого следует удалить хосты. 
host_names[] | **string**<br>Имена удаляемых хостов. 


## GetShard {#GetShard}

Возвращает указанный шард.

**rpc GetShard ([GetClusterShardRequest](#GetClusterShardRequest)) returns ([Shard](#Shard))**

### GetClusterShardRequest {#GetClusterShardRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера, к которому принадлежит шард. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](#List)(#List). Чтобы получить имя базы данных, используйте запрос [ClusterService.List]. Максимальная длина строки в символах — 50.
shard_name | **string**<br>Обязательное поле. Имя шарда, информацию о котором нужно запросить. Чтобы получить имя шарда, используйте запрос [ClusterService.ListShards](#ListShards). Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.


### Shard {#Shard}

Поле | Описание
--- | ---
name | **string**<br>Имя шарда. 
cluster_id | **string**<br>Идентификатор кластера, к которому принадлежит шард. 
config | **[ShardConfig](#ShardConfig)**<br>Конфигурация шарда. 


### ShardConfig {#ShardConfig}

Поле | Описание
--- | ---
clickhouse | **[Clickhouse](#Clickhouse13)**<br>Конфигурация ClickHouse для шарда. 


### Clickhouse {#Clickhouse13}

Поле | Описание
--- | ---
config | **`config.ClickhouseConfigSet`**<br>Настройки ClickHouse для шарда. 
resources | **[Resources](#Resources2)**<br>Вычислительные ресурсы для шарда. 
weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Относительный вес шарда, который учитывается при записи данных в кластер. <br>Подробнее см. в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/table_engines/distributed/). 


## ListShards {#ListShards}

Получает список шардов, принадлежащих указанному кластеру.

**rpc ListShards ([ListClusterShardsRequest](#ListClusterShardsRequest)) returns ([ListClusterShardsResponse](#ListClusterShardsResponse))**

### ListClusterShardsRequest {#ListClusterShardsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера ClickHouse, для которого нужно вывести список шардов. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на одной странице в ответе. Если количество результатов больше чем `page_size`, сервис вернет значение [ListClusterShardsResponse.next_page_token](#ListClusterShardsResponse), которое можно использовать для получения следующей страницы. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Номер страницы. Чтобы получить следующую страницу результатов, установите значение `page_token` равным значению поля [ListClusterShardsResponse.next_page_token](#ListClusterShardsResponse) прошлого запроса. Максимальная длина строки в символах — 100.


### ListClusterShardsResponse {#ListClusterShardsResponse}

Поле | Описание
--- | ---
shards[] | **[Shard](#Shard1)**<br>Список шардов ClickHouse. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListClusterShardsRequest.page_size](#ListClusterShardsRequest), используйте `next_page_token` в качестве значения параметра [ListClusterShardsRequest.page_token](#ListClusterShardsRequest) в следующем запросе. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Shard {#Shard1}

Поле | Описание
--- | ---
name | **string**<br>Имя шарда. 
cluster_id | **string**<br>Идентификатор кластера, к которому принадлежит шард. 
config | **[ShardConfig](#ShardConfig1)**<br>Конфигурация шарда. 


### ShardConfig {#ShardConfig1}

Поле | Описание
--- | ---
clickhouse | **[Clickhouse](#Clickhouse14)**<br>Конфигурация ClickHouse для шарда. 


### Clickhouse {#Clickhouse14}

Поле | Описание
--- | ---
config | **`config.ClickhouseConfigSet`**<br>Настройки ClickHouse для шарда. 
resources | **[Resources](#Resources2)**<br>Вычислительные ресурсы для шарда. 
weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Относительный вес шарда, который учитывается при записи данных в кластер. <br>Подробнее см. в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/table_engines/distributed/). 


## AddShard {#AddShard}

Создает новый шард в указанном кластере.

**rpc AddShard ([AddClusterShardRequest](#AddClusterShardRequest)) returns ([operation.Operation](#Operation12))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddClusterShardMetadata](#AddClusterShardMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Shard](#Shard2)<br>

### AddClusterShardRequest {#AddClusterShardRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера ClickHouse, к которому нужно добавить шард. Чтобы получить идентификатор кластера ClickHouse, используйте запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
shard_name | **string**<br>Обязательное поле. Имя нового шарда. Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.
config_spec | **[ShardConfigSpec](#ShardConfigSpec)**<br>Конфигурация нового шарда. 
host_specs[] | **[HostSpec](#HostSpec)**<br>Конфигурации для хостов ClickHouse, которые должны быть созданы вместе с шардом. Количество элементов должно быть больше 0.


### ShardConfigSpec {#ShardConfigSpec}

Поле | Описание
--- | ---
clickhouse | **[Clickhouse](#Clickhouse15)**<br>Конфигурация ClickHouse для шарда. 


### Clickhouse {#Clickhouse15}

Поле | Описание
--- | ---
config | **`config.ClickhouseConfig`**<br>Настройки ClickHouse для шарда. 
resources | **[Resources](#Resources2)**<br>Вычислительные ресурсы для шарда. 
weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Относительный вес шарда, который учитывается при записи данных в кластер. Подробнее см. в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/table_engines/distributed/). 


### HostSpec {#HostSpec4}

Поле | Описание
--- | ---
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится хост. Чтобы получить список доступных зон, используйте запрос [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List). Максимальная длина строки в символах — 50.
type | **[Host.Type](#Host1)**<br>Обязательное поле. Тип развертываемого хоста. 
subnet_id | **string**<br>Идентификатор подсети, к которой должен принадлежать хост. Эта подсеть должна быть частью сети, к которой принадлежит кластер. Идентификатор сети задается в поле [Cluster.network_id](#Cluster10). Максимальная длина строки в символах — 50.
assign_public_ip | **bool**<br><ul><li>false — не назначать хосту публичный IP-адрес. </li><li>true — у хоста должен быть публичный IP-адрес.</li></ul> 
shard_name | **string**<br>Имя шарда, которому принадлежит хост. Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.


### Operation {#Operation12}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AddClusterShardMetadata](#AddClusterShardMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Shard](#Shard2)>**<br>в случае успешного выполнения операции. 


### AddClusterShardMetadata {#AddClusterShardMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера, в который добавляется шард. 
shard_name | **string**<br>Имя создаваемого шарда. 


### Shard {#Shard2}

Поле | Описание
--- | ---
name | **string**<br>Имя шарда. 
cluster_id | **string**<br>Идентификатор кластера, к которому принадлежит шард. 
config | **[ShardConfig](#ShardConfig2)**<br>Конфигурация шарда. 


### ShardConfig {#ShardConfig2}

Поле | Описание
--- | ---
clickhouse | **[Clickhouse](#Clickhouse16)**<br>Конфигурация ClickHouse для шарда. 


### Clickhouse {#Clickhouse16}

Поле | Описание
--- | ---
config | **`config.ClickhouseConfigSet`**<br>Настройки ClickHouse для шарда. 
resources | **[Resources](#Resources2)**<br>Вычислительные ресурсы для шарда. 
weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Относительный вес шарда, который учитывается при записи данных в кластер. <br>Подробнее см. в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/table_engines/distributed/). 


## UpdateShard {#UpdateShard}

Изменяет указанный шард.

**rpc UpdateShard ([UpdateClusterShardRequest](#UpdateClusterShardRequest)) returns ([operation.Operation](#Operation13))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterShardMetadata](#UpdateClusterShardMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Shard](#Shard3)<br>

### UpdateClusterShardRequest {#UpdateClusterShardRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера ClickHouse, которому принадлежит шард. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
shard_name | **string**<br>Обязательное поле. Имя шарда, который следует изменить. Чтобы получить имя шарда, используйте запрос [ClusterService.ListShards](#ListShards). Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска, которая указывает, какие атрибуты шарда должны быть изменены. 
config_spec | **[ShardConfigSpec](#ShardConfigSpec)**<br>Новая конфигурация для указанного шарда. 


### ShardConfigSpec {#ShardConfigSpec1}

Поле | Описание
--- | ---
clickhouse | **[Clickhouse](#Clickhouse17)**<br>Конфигурация ClickHouse для шарда. 


### Clickhouse {#Clickhouse17}

Поле | Описание
--- | ---
config | **`config.ClickhouseConfig`**<br>Настройки ClickHouse для шарда. 
resources | **[Resources](#Resources2)**<br>Вычислительные ресурсы для шарда. 
weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Относительный вес шарда, который учитывается при записи данных в кластер. Подробнее см. в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/table_engines/distributed/). 


### Operation {#Operation13}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateClusterShardMetadata](#UpdateClusterShardMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Shard](#Shard3)>**<br>в случае успешного выполнения операции. 


### UpdateClusterShardMetadata {#UpdateClusterShardMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера, содержащего обновляемый шард. 
shard_name | **string**<br>Имя обновляемого шарда. 


### Shard {#Shard3}

Поле | Описание
--- | ---
name | **string**<br>Имя шарда. 
cluster_id | **string**<br>Идентификатор кластера, к которому принадлежит шард. 
config | **[ShardConfig](#ShardConfig3)**<br>Конфигурация шарда. 


### ShardConfig {#ShardConfig3}

Поле | Описание
--- | ---
clickhouse | **[Clickhouse](#Clickhouse18)**<br>Конфигурация ClickHouse для шарда. 


### Clickhouse {#Clickhouse18}

Поле | Описание
--- | ---
config | **`config.ClickhouseConfigSet`**<br>Настройки ClickHouse для шарда. 
resources | **[Resources](#Resources2)**<br>Вычислительные ресурсы для шарда. 
weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Относительный вес шарда, который учитывается при записи данных в кластер. <br>Подробнее см. в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/table_engines/distributed/). 


## DeleteShard {#DeleteShard}

Удаляет указанный шард.

**rpc DeleteShard ([DeleteClusterShardRequest](#DeleteClusterShardRequest)) returns ([operation.Operation](#Operation14))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterShardMetadata](#DeleteClusterShardMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterShardRequest {#DeleteClusterShardRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера ClickHouse, которому принадлежит шард. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
shard_name | **string**<br>Обязательное поле. Имя удаляемого шарда. Чтобы получить имя шарда, используйте запрос [ClusterService.ListShards](#ListShards). Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.


### Operation {#Operation14}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteClusterShardMetadata](#DeleteClusterShardMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### DeleteClusterShardMetadata {#DeleteClusterShardMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера, содержащего удаляемый шард. 
shard_name | **string**<br>Имя удаляемого шарда. 


## GetShardGroup {#GetShardGroup}

Возвращает указанную группу шардов.

**rpc GetShardGroup ([GetClusterShardGroupRequest](#GetClusterShardGroupRequest)) returns ([ShardGroup](#ShardGroup))**

### GetClusterShardGroupRequest {#GetClusterShardGroupRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера, к которому принадлежит группа шардов. Максимальная длина строки в символах — 50.
shard_group_name | **string**<br>Обязательное поле. Имя группы шардов, информацию о которой нужно запросить. Чтобы получить имя группы шардов, используйте запрос [ClusterService.ListShardGroups](#ListShardGroups). Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.


### ShardGroup {#ShardGroup}

Поле | Описание
--- | ---
name | **string**<br>Имя группы шардов. 
cluster_id | **string**<br>Идентификатор кластера, к которому принадлежит группа шардов. 
description | **string**<br>Описание группы шардов кластера ClickHouse. Длина описания должна быть от 0 до 256 символов. 
shard_names[] | **string**<br>Список имен шардов, содержащихся в группе шардов. 


## ListShardGroups {#ListShardGroups}

Получает список групп шардов, принадлежащих указанному кластеру.

**rpc ListShardGroups ([ListClusterShardGroupsRequest](#ListClusterShardGroupsRequest)) returns ([ListClusterShardGroupsResponse](#ListClusterShardGroupsResponse))**

### ListClusterShardGroupsRequest {#ListClusterShardGroupsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера, к которому принадлежит группа шардов. Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на одной странице в ответе. Если количество результатов больше чем `page_size`, сервис вернет значение [ListClusterShardGroupsResponse.next_page_token](#ListClusterShardGroupsResponse), которое можно использовать для получения следующей страницы. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListClusterShardGroupsResponse.next_page_token](#ListClusterShardGroupsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListClusterShardGroupsResponse {#ListClusterShardGroupsResponse}

Поле | Описание
--- | ---
shard_groups[] | **[ShardGroup](#ShardGroup1)**<br>Список групп шардов кластера ClickHouse. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListClusterShardGroupsRequest.page_size](#ListClusterShardGroupsRequest), используйте `next_page_token` в качестве значения параметра [ListClusterShardGroupsRequest.page_token](#ListClusterShardGroupsRequest) в следующем запросе. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### ShardGroup {#ShardGroup1}

Поле | Описание
--- | ---
name | **string**<br>Имя группы шардов. 
cluster_id | **string**<br>Идентификатор кластера, к которому принадлежит группа шардов. 
description | **string**<br>Описание группы шардов кластера ClickHouse. Длина описания должна быть от 0 до 256 символов. 
shard_names[] | **string**<br>Список имен шардов, содержащихся в группе шардов. 


## CreateShardGroup {#CreateShardGroup}

Создает новую группу шардов в указанном кластере.

**rpc CreateShardGroup ([CreateClusterShardGroupRequest](#CreateClusterShardGroupRequest)) returns ([operation.Operation](#Operation15))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateClusterShardGroupMetadata](#CreateClusterShardGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[ShardGroup](#ShardGroup2)<br>

### CreateClusterShardGroupRequest {#CreateClusterShardGroupRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера ClickHouse, в который нужно добавить группу шардов. Чтобы получить идентификатор кластера ClickHouse, используйте запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
shard_group_name | **string**<br>Обязательное поле. Имя для новой группы шардов. Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.
description | **string**<br>Описание группы шардов кластера ClickHouse. Длина описания должна быть от 0 до 256 символов. 
shard_names[] | **string**<br>Список имен шардов, принадлежащих к новой группе. 


### Operation {#Operation15}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateClusterShardGroupMetadata](#CreateClusterShardGroupMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[ShardGroup](#ShardGroup2)>**<br>в случае успешного выполнения операции. 


### CreateClusterShardGroupMetadata {#CreateClusterShardGroupMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера ClickHouse, в который нужно добавить группу шардов. 
shard_group_name | **string**<br>Имя для новой группы шардов. 


### ShardGroup {#ShardGroup2}

Поле | Описание
--- | ---
name | **string**<br>Имя группы шардов. 
cluster_id | **string**<br>Идентификатор кластера, к которому принадлежит группа шардов. 
description | **string**<br>Описание группы шардов кластера ClickHouse. Длина описания должна быть от 0 до 256 символов. 
shard_names[] | **string**<br>Список имен шардов, содержащихся в группе шардов. 


## UpdateShardGroup {#UpdateShardGroup}

Изменяет указанную группу шардов.

**rpc UpdateShardGroup ([UpdateClusterShardGroupRequest](#UpdateClusterShardGroupRequest)) returns ([operation.Operation](#Operation16))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterShardGroupMetadata](#UpdateClusterShardGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[ShardGroup](#ShardGroup3)<br>

### UpdateClusterShardGroupRequest {#UpdateClusterShardGroupRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера, содержащего обновляемую группу шардов. Максимальная длина строки в символах — 50.
shard_group_name | **string**<br>Обязательное поле. Имя группы шардов, которую следует изменить. Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска, которая указывает, какие атрибуты группы шардов должны быть изменены. 
description | **string**<br>Описание группы шардов кластера ClickHouse. Длина описания должна быть от 0 до 256 символов. 
shard_names[] | **string**<br>Обновленный список имен шардов, принадлежащих к новой группе. 


### Operation {#Operation16}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateClusterShardGroupMetadata](#UpdateClusterShardGroupMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[ShardGroup](#ShardGroup3)>**<br>в случае успешного выполнения операции. 


### UpdateClusterShardGroupMetadata {#UpdateClusterShardGroupMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера, содержащего обновляемую группу шардов. 
shard_group_name | **string**<br>Имя группы шардов, которую следует изменить. 


### ShardGroup {#ShardGroup3}

Поле | Описание
--- | ---
name | **string**<br>Имя группы шардов. 
cluster_id | **string**<br>Идентификатор кластера, к которому принадлежит группа шардов. 
description | **string**<br>Описание группы шардов кластера ClickHouse. Длина описания должна быть от 0 до 256 символов. 
shard_names[] | **string**<br>Список имен шардов, содержащихся в группе шардов. 


## DeleteShardGroup {#DeleteShardGroup}

Удаляет указанную группу шардов.

**rpc DeleteShardGroup ([DeleteClusterShardGroupRequest](#DeleteClusterShardGroupRequest)) returns ([operation.Operation](#Operation17))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterShardGroupMetadata](#DeleteClusterShardGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterShardGroupRequest {#DeleteClusterShardGroupRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера ClickHouse, которому принадлежит группа шардов. Максимальная длина строки в символах — 50.
shard_group_name | **string**<br>Обязательное поле. Имя группы шардов, которую следует удалить. Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.


### Operation {#Operation17}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteClusterShardGroupMetadata](#DeleteClusterShardGroupMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### DeleteClusterShardGroupMetadata {#DeleteClusterShardGroupMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера ClickHouse, которому принадлежит группа шардов. 
shard_group_name | **string**<br>Имя группы шардов, которую следует удалить. 


## CreateExternalDictionary {#CreateExternalDictionary}

Создает внешний словарь для указанного кластера ClickHouse.

**rpc CreateExternalDictionary ([CreateClusterExternalDictionaryRequest](#CreateClusterExternalDictionaryRequest)) returns ([operation.Operation](#Operation18))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateClusterExternalDictionaryMetadata](#CreateClusterExternalDictionaryMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster10)<br>

### CreateClusterExternalDictionaryRequest {#CreateClusterExternalDictionaryRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера ClickHouse, для которого следует создать внешний словарь. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
external_dictionary | **[config.ClickhouseConfig.ExternalDictionary](#ClickhouseConfig)**<br>Конфигурация внешнего словаря. 


### Operation {#Operation18}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateClusterExternalDictionaryMetadata](#CreateClusterExternalDictionaryMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster10)>**<br>в случае успешного выполнения операции. 


### CreateClusterExternalDictionaryMetadata {#CreateClusterExternalDictionaryMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера, для которого создается внешний словарь. 


### Cluster {#Cluster10}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера ClickHouse. Этот идентификатор генерирует MDB при создании кластера. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер ClickHouse. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера ClickHouse. Имя уникально в рамках каталога. Длина 1-63 символов. 
description | **string**<br>Описание кластера ClickHouse. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера ClickHouse в виде пар `key:value`. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания кластера ClickHouse. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring10)**<br>Описание систем мониторинга, относящихся к данному кластеру ClickHouse. 
config | **[ClusterConfig](#ClusterConfig10)**<br>Конфигурация кластера ClickHouse. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Здоровье кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](#Host1) для каждого хоста в кластере — UNKNOWN).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](#Host1) для каждого хоста в кластере — ALIVE).</li><li>`DEAD`: Кластер не работает ([Host.health](#Host1) для каждого хоста в кластере — DEAD).</li><li>`DEGRADED`: Кластер работает неоптимально ([Host.health](#Host1) по крайней мере для одного хоста в кластере не ALIVE).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: В кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>
service_account_id | **string**<br>Идентификатор сервисного аккаунта, используемого для доступа к Yandex Object Storage. 


### Monitoring {#Monitoring10}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для данного кластера ClickHouse. 


### ClusterConfig {#ClusterConfig10}

Поле | Описание
--- | ---
version | **string**<br>Версия серверного программного обеспечения ClickHouse. 
clickhouse | **[Clickhouse](#Clickhouse19)**<br>Конфигурация и распределение ресурсов для хостов ClickHouse. 
zookeeper | **[Zookeeper](#Zookeeper13)**<br>Конфигурация и распределение ресурсов для хостов ZooKeeper. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access13)**<br>Политика доступа для внешних сервисов. 


### Clickhouse {#Clickhouse19}

Поле | Описание
--- | ---
config | **`config.ClickhouseConfigSet`**<br>Параметры конфигурации сервера ClickHouse. 
resources | **[Resources](#Resources2)**<br>Ресурсы, выделенные хостам ClickHouse. 


### Zookeeper {#Zookeeper13}

Поле | Описание
--- | ---
resources | **[Resources](#Resources2)**<br>Ресурсы, выделенные хостам ZooKeeper. 


### Access {#Access13}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить экспорт данных из кластера в Yandex DataLens. 
web_sql | **bool**<br>Разрешить SQL-запросы к базам данных кластера из консоли управления облаком. <br>Подробнее см. в [SQL-запросы в консоли управления](/docs/managed-clickhouse/operations/web-sql-query). 
metrika | **bool**<br>Разрешить импорт данных из Яндекс Метрики и AppMetrica в кластер. <br>Подробнее см. в [Экспорт данных в {{ yandex-cloud }}](https://appmetrica.yandex.ru/docs/common/cloud/about.html). 
serverless | **bool**<br>Разрешить доступ к кластеру для Serverless. 


## DeleteExternalDictionary {#DeleteExternalDictionary}

Удаляет указанный внешний словарь.

**rpc DeleteExternalDictionary ([DeleteClusterExternalDictionaryRequest](#DeleteClusterExternalDictionaryRequest)) returns ([operation.Operation](#Operation19))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterExternalDictionaryMetadata](#DeleteClusterExternalDictionaryMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster11)<br>

### DeleteClusterExternalDictionaryRequest {#DeleteClusterExternalDictionaryRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера ClickHouse, для которого следует удалить внешний словарь. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
external_dictionary_name | **string**<br>Имя удаляемого внешнего словаря. 


### Operation {#Operation19}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteClusterExternalDictionaryMetadata](#DeleteClusterExternalDictionaryMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster11)>**<br>в случае успешного выполнения операции. 


### DeleteClusterExternalDictionaryMetadata {#DeleteClusterExternalDictionaryMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера, для которого удаляется внешний словарь. 


### Cluster {#Cluster11}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера ClickHouse. Этот идентификатор генерирует MDB при создании кластера. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер ClickHouse. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера ClickHouse. Имя уникально в рамках каталога. Длина 1-63 символов. 
description | **string**<br>Описание кластера ClickHouse. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера ClickHouse в виде пар `key:value`. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания кластера ClickHouse. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring11)**<br>Описание систем мониторинга, относящихся к данному кластеру ClickHouse. 
config | **[ClusterConfig](#ClusterConfig11)**<br>Конфигурация кластера ClickHouse. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Здоровье кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](#Host1) для каждого хоста в кластере — UNKNOWN).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](#Host1) для каждого хоста в кластере — ALIVE).</li><li>`DEAD`: Кластер не работает ([Host.health](#Host1) для каждого хоста в кластере — DEAD).</li><li>`DEGRADED`: Кластер работает неоптимально ([Host.health](#Host1) по крайней мере для одного хоста в кластере не ALIVE).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: В кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>
service_account_id | **string**<br>Идентификатор сервисного аккаунта, используемого для доступа к Yandex Object Storage. 


### Monitoring {#Monitoring11}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для данного кластера ClickHouse. 


### ClusterConfig {#ClusterConfig11}

Поле | Описание
--- | ---
version | **string**<br>Версия серверного программного обеспечения ClickHouse. 
clickhouse | **[Clickhouse](#Clickhouse20)**<br>Конфигурация и распределение ресурсов для хостов ClickHouse. 
zookeeper | **[Zookeeper](#Zookeeper14)**<br>Конфигурация и распределение ресурсов для хостов ZooKeeper. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access14)**<br>Политика доступа для внешних сервисов. 


### Clickhouse {#Clickhouse20}

Поле | Описание
--- | ---
config | **`config.ClickhouseConfigSet`**<br>Параметры конфигурации сервера ClickHouse. 
resources | **[Resources](#Resources2)**<br>Ресурсы, выделенные хостам ClickHouse. 


### Zookeeper {#Zookeeper14}

Поле | Описание
--- | ---
resources | **[Resources](#Resources2)**<br>Ресурсы, выделенные хостам ZooKeeper. 


### Access {#Access14}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить экспорт данных из кластера в Yandex DataLens. 
web_sql | **bool**<br>Разрешить SQL-запросы к базам данных кластера из консоли управления облаком. <br>Подробнее см. в [SQL-запросы в консоли управления](/docs/managed-clickhouse/operations/web-sql-query). 
metrika | **bool**<br>Разрешить импорт данных из Яндекс Метрики и AppMetrica в кластер. <br>Подробнее см. в [Экспорт данных в {{ yandex-cloud }}](https://appmetrica.yandex.ru/docs/common/cloud/about.html). 
serverless | **bool**<br>Разрешить доступ к кластеру для Serverless. 


