---
editable: false
---

# ClusterService

Набор методов для управления ресурсами Cluster для MongoDB.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанный ресурс Cluster для MongoDB. |
| [List](#List) | Получает список ресурсов Cluster для MongoDB, принадлежащих указанному каталогу. |
| [Create](#Create) | Создает кластер MongoDB в указанном каталоге. |
| [Update](#Update) | Изменяет указанный кластер MongoDB. |
| [Delete](#Delete) | Удаляет указанный кластер MongoDB. |
| [Start](#Start) | Запускает указанный кластер MongoDB. |
| [Stop](#Stop) | Останавливает указанный кластер MongoDB. |
| [Move](#Move) | Перемещает кластер MongoDB в указанный каталог. |
| [Backup](#Backup) | Создает резервную копию для указанного кластера MongoDB. |
| [Restore](#Restore) | Создает новый кластер MongoDB с использованием указанной резервной копии. |
| [ListLogs](#ListLogs) | Получает логи для указанного кластера MongoDB. |
| [ListOperations](#ListOperations) | Получает список ресурсов Operation для указанного кластера. |
| [ListBackups](#ListBackups) | Получает список доступных резервных копий для указанного кластера MongoDB. |
| [ListHosts](#ListHosts) | Получает список хостов для указанного кластера. |
| [AddHosts](#AddHosts) | Создает новые хосты для кластера. |
| [DeleteHosts](#DeleteHosts) | Удаляет указанные хосты кластера. |
| [EnableSharding](#EnableSharding) | Включает шардирование для кластера: создает 3 хоста mongocfg и 2 хоста mongos, которые необходимы чтобы добавлять и использовать шарды в кластере. |
| [GetShard](#GetShard) | Возвращает указанный шард. |
| [ListShards](#ListShards) | Получает список шардов. |
| [AddShard](#AddShard) | Создает новый шард. |
| [DeleteShard](#DeleteShard) | Удаляет указанный шард. |

## Вызовы ClusterService {#calls}

## Get {#Get}

Возвращает указанный ресурс Cluster для MongoDB. <br>Чтобы получить список доступных кластеров MongoDB, отправьте запрос [List](#List).

**rpc Get ([GetClusterRequest](#GetClusterRequest)) returns ([Cluster](../cluster.proto#Cluster))**

### GetClusterRequest {#GetClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор возвращаемого ресурса Cluster для MongoDB. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](#List). false Максимальная длина строки в символах — 50.


### Cluster {#Cluster}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера MongoDB. Этот идентификатор генерирует MDB при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер MongoDB. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера MongoDB. Имя уникально в рамках каталога. Длина 1-63 символов. 
description | **string**<br>Описание кластера MongoDB. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера MongoDB как пары `` key:value ``. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания кластера MongoDB. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](../cluster.proto#Monitoring)**<br>Описание систем мониторинга, относящихся к данному кластеру MongoDB. 
config | **[ClusterConfig](../cluster.proto#ClusterConfig)**<br>Конфигурация кластера MongoDB. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Агрегированная работоспособность кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](../cluster.proto#Host) для каждого хоста в кластере — UNKNOWN).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](../cluster.proto#Host) для каждого хоста в кластере — ALIVE).</li><li>`DEAD`: Кластер не работает ([Host.health](../cluster.proto#Host) для каждого узла в кластере — DEAD).</li><li>`DEGRADED`: Кластер работает неоптимально ([Host.health](../cluster.proto#Host) по крайней мере для одного узла в кластере не ALIVE).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: На кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>
sharded | **bool**<br>Указывает текущее состояние шардирования кластера. 


### Monitoring {#Monitoring}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для данного кластера MongoDB. 


### ClusterConfig {#ClusterConfig}

Поле | Описание
--- | ---
version | **string**<br>Версия серверного программного обеспечения MongoDB. Возможные значения: `3.6`, `4.0`, `4.2`. 
feature_compatibility_version | **string**<br><ul><li>`3.6` — сохранить совместимость данных с версией 3.6. После установки этого параметра данные не будут совместимы с версией 3.4 или ниже. </li><li>`4.0` — сохранить совместимость данных с версией 4.0. После установки этого параметра данные не будут совместимы с версией 3.6 или ниже. </li><li>`4.2` — сохранить совместимость данных с версией 4.2. После установки этого параметра данные не будут совместимы с версией 4.0 или ниже.</li></ul> 
mongodb | **oneof:** `mongodb_3_6`, `mongodb_4_0` или `mongodb_4_2`<br>Конфигурация для серверов MongoDB в кластере.
&nbsp;&nbsp;mongodb_3_6 | **[Mongodb3_6](../cluster.proto#Mongodb3_6)**<br>Конфигурация и распределение ресурсов для кластера MongoDB 3.6. 
&nbsp;&nbsp;mongodb_4_0 | **[Mongodb4_0](../cluster.proto#Mongodb4_0)**<br>Конфигурация и распределение ресурсов для кластера MongoDB 4.0. 
&nbsp;&nbsp;mongodb_4_2 | **[Mongodb4_0](../cluster.proto#Mongodb4_0)**<br>Конфигурация и распределение ресурсов для кластера MongoDB 4.2. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 


### Mongodb3_6 {#Mongodb3_6}

Поле | Описание
--- | ---
mongod | **[Mongod](../cluster.proto#Mongod)**<br>Конфигурация и распределение ресурсов для mongod в кластере MongoDB 3.6. 
mongocfg | **[MongoCfg](../cluster.proto#MongoCfg)**<br>Конфигурация и распределение ресурсов mongocfg для кластера MongoDB 3.6. 
mongos | **[Mongos](../cluster.proto#Mongos)**<br>Конфигурация и распределение ресурсов mongos для кластера MongoDB 3.6. 


### Mongod {#Mongod}

Поле | Описание
--- | ---
config | **`config.MongodConfigSet3_6`**<br>Конфигурация для хостов mongod 3.6. 
resources | **[Resources](../cluster.proto#Resources)**<br>Ресурсы, выделенные хостам MongoDB. 


### MongoCfg {#MongoCfg}

Поле | Описание
--- | ---
config | **`config.MongoCfgConfigSet3_6`**<br> 
resources | **[Resources](../cluster.proto#Resources)**<br>Ресурсы, выделенные хостам mongocfg. 


### Mongos {#Mongos}

Поле | Описание
--- | ---
config | **`config.MongosConfigSet3_6`**<br> 
resources | **[Resources](../cluster.proto#Resources)**<br>Ресурсы, выделенные хостам mongocfg. 


### Mongodb4_0 {#Mongodb4_0}

Поле | Описание
--- | ---
mongod | **[Mongod](../cluster.proto#Mongod1)**<br>Конфигурация и распределение ресурсов для mongod в кластере MongoDB 4.0. 
mongocfg | **[MongoCfg](../cluster.proto#MongoCfg1)**<br>Конфигурация и распределение ресурсов mongocfg для кластера MongoDB 4.0. 
mongos | **[Mongos](../cluster.proto#Mongos1)**<br>Конфигурация и распределение ресурсов mongos для кластера MongoDB 4.0. 


### Mongod {#Mongod}

Поле | Описание
--- | ---
config | **`config.MongodConfigSet4_0`**<br>Конфигурация для хостов mongod 4.0. 
resources | **[Resources](../cluster.proto#Resources)**<br>Ресурсы, выделенные хостам mongod. 


### MongoCfg {#MongoCfg}

Поле | Описание
--- | ---
config | **`config.MongoCfgConfigSet4_0`**<br>Конфигурация для хостов mongocfg 4.0. 
resources | **[Resources](../cluster.proto#Resources)**<br>Ресурсы, выделенные хостам mongocfg. 


### Mongos {#Mongos}

Поле | Описание
--- | ---
config | **`config.MongosConfigSet4_0`**<br>Конфигурация для хостов mongos 4.0. 
resources | **[Resources](../cluster.proto#Resources)**<br>Ресурсы, выделенные хостам mongos. 


## List {#List}

Получает список ресурсов Cluster для MongoDB, принадлежащих указанному каталогу.

**rpc List ([ListClustersRequest](#ListClustersRequest)) returns ([ListClustersResponse](#ListClustersResponse))**

### ListClustersRequest {#ListClustersRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога для вывода списка кластеров MongoDB. Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/grpc/folder_service#List). false Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListClustersResponse.next_page_token](#ListClustersResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListClustersResponse.next_page_token](#ListClustersResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br><ol><li>Имя поля. В настоящее время фильтрацию можно использовать только с полем [Cluster.name](../cluster.proto#Cluster1). </li><li>Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. </li><li>Значение. Должен содержать от 1 до 63 символов и соответствовать регулярному выражению `^[a-zA-Z0-9_-]+$`.</li></ol> Максимальная длина строки в символах — 1000.


### ListClustersResponse {#ListClustersResponse}

Поле | Описание
--- | ---
clusters[] | **[Cluster](../cluster.proto#Cluster1)**<br>Список ресурсов Cluster для MongoDB. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListClustersRequest.page_size](#ListClustersRequest1), используйте `next_page_token` в качестве значения параметра [ListClustersRequest.page_token](#ListClustersRequest1) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Cluster {#Cluster}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера MongoDB. Этот идентификатор генерирует MDB при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер MongoDB. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера MongoDB. Имя уникально в рамках каталога. Длина 1-63 символов. 
description | **string**<br>Описание кластера MongoDB. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера MongoDB как пары `` key:value ``. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания кластера MongoDB. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](../cluster.proto#Monitoring1)**<br>Описание систем мониторинга, относящихся к данному кластеру MongoDB. 
config | **[ClusterConfig](../cluster.proto#ClusterConfig1)**<br>Конфигурация кластера MongoDB. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Агрегированная работоспособность кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](../cluster.proto#Host) для каждого хоста в кластере — UNKNOWN).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](../cluster.proto#Host) для каждого хоста в кластере — ALIVE).</li><li>`DEAD`: Кластер не работает ([Host.health](../cluster.proto#Host) для каждого узла в кластере — DEAD).</li><li>`DEGRADED`: Кластер работает неоптимально ([Host.health](../cluster.proto#Host) по крайней мере для одного узла в кластере не ALIVE).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: На кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>
sharded | **bool**<br>Указывает текущее состояние шардирования кластера. 


### Monitoring {#Monitoring}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для данного кластера MongoDB. 


### ClusterConfig {#ClusterConfig}

Поле | Описание
--- | ---
version | **string**<br>Версия серверного программного обеспечения MongoDB. Возможные значения: `3.6`, `4.0`, `4.2`. 
feature_compatibility_version | **string**<br><ul><li>`3.6` — сохранить совместимость данных с версией 3.6. После установки этого параметра данные не будут совместимы с версией 3.4 или ниже. </li><li>`4.0` — сохранить совместимость данных с версией 4.0. После установки этого параметра данные не будут совместимы с версией 3.6 или ниже. </li><li>`4.2` — сохранить совместимость данных с версией 4.2. После установки этого параметра данные не будут совместимы с версией 4.0 или ниже.</li></ul> 
mongodb | **oneof:** `mongodb_3_6`, `mongodb_4_0` или `mongodb_4_2`<br>Конфигурация для серверов MongoDB в кластере.
&nbsp;&nbsp;mongodb_3_6 | **[Mongodb3_6](../cluster.proto#Mongodb3_61)**<br>Конфигурация и распределение ресурсов для кластера MongoDB 3.6. 
&nbsp;&nbsp;mongodb_4_0 | **[Mongodb4_0](../cluster.proto#Mongodb4_01)**<br>Конфигурация и распределение ресурсов для кластера MongoDB 4.0. 
&nbsp;&nbsp;mongodb_4_2 | **[Mongodb4_0](../cluster.proto#Mongodb4_01)**<br>Конфигурация и распределение ресурсов для кластера MongoDB 4.2. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 


### Mongodb3_6 {#Mongodb3_6}

Поле | Описание
--- | ---
mongod | **[Mongod](../cluster.proto#Mongod2)**<br>Конфигурация и распределение ресурсов для mongod в кластере MongoDB 3.6. 
mongocfg | **[MongoCfg](../cluster.proto#MongoCfg2)**<br>Конфигурация и распределение ресурсов mongocfg для кластера MongoDB 3.6. 
mongos | **[Mongos](../cluster.proto#Mongos2)**<br>Конфигурация и распределение ресурсов mongos для кластера MongoDB 3.6. 


### Mongod {#Mongod}

Поле | Описание
--- | ---
config | **`config.MongodConfigSet3_6`**<br>Конфигурация для хостов mongod 3.6. 
resources | **[Resources](../cluster.proto#Resources)**<br>Ресурсы, выделенные хостам MongoDB. 


### MongoCfg {#MongoCfg}

Поле | Описание
--- | ---
config | **`config.MongoCfgConfigSet3_6`**<br> 
resources | **[Resources](../cluster.proto#Resources)**<br>Ресурсы, выделенные хостам mongocfg. 


### Mongos {#Mongos}

Поле | Описание
--- | ---
config | **`config.MongosConfigSet3_6`**<br> 
resources | **[Resources](../cluster.proto#Resources)**<br>Ресурсы, выделенные хостам mongocfg. 


### Mongodb4_0 {#Mongodb4_0}

Поле | Описание
--- | ---
mongod | **[Mongod](../cluster.proto#Mongod3)**<br>Конфигурация и распределение ресурсов для mongod в кластере MongoDB 4.0. 
mongocfg | **[MongoCfg](../cluster.proto#MongoCfg3)**<br>Конфигурация и распределение ресурсов mongocfg для кластера MongoDB 4.0. 
mongos | **[Mongos](../cluster.proto#Mongos3)**<br>Конфигурация и распределение ресурсов mongos для кластера MongoDB 4.0. 


### Mongod {#Mongod}

Поле | Описание
--- | ---
config | **`config.MongodConfigSet4_0`**<br>Конфигурация для хостов mongod 4.0. 
resources | **[Resources](../cluster.proto#Resources)**<br>Ресурсы, выделенные хостам mongod. 


### MongoCfg {#MongoCfg}

Поле | Описание
--- | ---
config | **`config.MongoCfgConfigSet4_0`**<br>Конфигурация для хостов mongocfg 4.0. 
resources | **[Resources](../cluster.proto#Resources)**<br>Ресурсы, выделенные хостам mongocfg. 


### Mongos {#Mongos}

Поле | Описание
--- | ---
config | **`config.MongosConfigSet4_0`**<br>Конфигурация для хостов mongos 4.0. 
resources | **[Resources](../cluster.proto#Resources)**<br>Ресурсы, выделенные хостам mongos. 


## Create {#Create}

Создает кластер MongoDB в указанном каталоге.

**rpc Create ([CreateClusterRequest](#CreateClusterRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateClusterMetadata](#CreateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](../cluster.proto#Cluster2)<br>

### CreateClusterRequest {#CreateClusterRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога, в котором нужно создать кластер MongoDB. false Максимальная длина строки в символах — 50.
name | **string**<br>Обязательное поле. Имя кластера MongoDB. Имя должно быть уникальным в каталоге. false Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.
description | **string**<br>Описание кластера MongoDB. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Пользовательские метки для кластера MongoDB как `` key:value `` pairs. Maximum 64 per resource. For example, `project": "mvp" или "source": "dictionary". Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Максимальная длина строки в символах для каждого ключа — 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
environment | **[Cluster.Environment](../cluster.proto#Cluster2)**<br>Обязательное поле. Среда развертывания кластера MongoDB. false
config_spec | **[ConfigSpec](#ConfigSpec)**<br>Обязательное поле. Конфигурация и ресурсы для хостов, которые должны быть созданы для кластера MongoDB. false
database_specs[] | **[DatabaseSpec](../database.proto#DatabaseSpec)**<br>Описания баз данных, которые нужно создать в кластере MongoDB. Количество элементов должно быть больше 0.
user_specs[] | **[UserSpec](../user.proto#UserSpec)**<br>Описания пользователей базы данных, которых нужно создать в кластере MongoDB. Количество элементов должно быть больше 0.
host_specs[] | **[HostSpec](#HostSpec)**<br>Конфигурации для отдельных хостов, которые должны быть созданы для кластера MongoDB. Количество элементов должно быть больше 0.
network_id | **string**<br>Обязательное поле. Идентификатор сети, в которой нужно создать кластер. false Максимальная длина строки в символах — 50.


### ConfigSpec {#ConfigSpec}

Поле | Описание
--- | ---
version | **string**<br>Версия MongoDB, используемая в кластере. Возможные значения: `3.6`, `4.0`, `4.2`. 
feature_compatibility_version | **string**<br><ul><li>`3.6` — сохранить совместимость данных с версией 3.6. После установки этого параметра данные не будут совместимы с версией 3.4 или ниже. </li><li>`4.0` — сохранить совместимость данных с версией 4.0. После установки этого параметра данные не будут совместимы с версией 3.6 или ниже. </li><li>`4.2` — сохранить совместимость данных с версией 4.2. После установки этого параметра данные не будут совместимы с версией 4.0 или ниже.</li></ul> 
mongodb_spec | **oneof:** `mongodb_spec_3_6`, `mongodb_spec_4_0` или `mongodb_spec_4_2`<br>
&nbsp;&nbsp;mongodb_spec_3_6 | **[MongodbSpec3_6](#MongodbSpec3_6)**<br>Конфигурация и распределение ресурсов для кластера MongoDB 3.6. 
&nbsp;&nbsp;mongodb_spec_4_0 | **[MongodbSpec4_0](#MongodbSpec4_0)**<br>Конфигурация и распределение ресурсов для кластера MongoDB 4.0. 
&nbsp;&nbsp;mongodb_spec_4_2 | **[MongodbSpec4_0](#MongodbSpec4_0)**<br>Конфигурация и распределение ресурсов для кластера MongoDB 4.2. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](../cluster.proto#Access)**<br>Политика доступа к БД 


### MongodbSpec3_6 {#MongodbSpec3_6}

Поле | Описание
--- | ---
mongod | **[Mongod](../cluster.proto#Mongod4)**<br>Конфигурация и выделенные ресурсы для хостов mongod 3.6. 
mongocfg | **[MongoCfg](../cluster.proto#MongoCfg4)**<br>Конфигурация и выделенные ресурсы для хостов mongocfg 3.6. 
mongos | **[Mongos](../cluster.proto#Mongos4)**<br>Конфигурация и выделенные ресурсы для хостов mongos 3.6. 


### Mongod {#Mongod}

Поле | Описание
--- | ---
config | **`config.MongodConfig3_6`**<br>Конфигурация для хостов mongod 3.6. 
resources | **[Resources](../cluster.proto#Resources)**<br>Ресурсы, выделенные каждому хосту mongod. 


### MongoCfg {#MongoCfg}

Поле | Описание
--- | ---
config | **`config.MongoCfgConfig3_6`**<br>Конфигурация для хостов mongocfg 3.6. 
resources | **[Resources](../cluster.proto#Resources)**<br>Ресурсы, выделенные для каждого хоста mongocfg. 


### Mongos {#Mongos}

Поле | Описание
--- | ---
config | **`config.MongosConfig3_6`**<br>Конфигурация для хостов mongos 3.6. 
resources | **[Resources](../cluster.proto#Resources)**<br>Ресурсы, выделенные для каждого хоста mongos. 


### MongodbSpec4_0 {#MongodbSpec4_0}

Поле | Описание
--- | ---
mongod | **[Mongod](../cluster.proto#Mongod5)**<br>Конфигурация и выделенные ресурсы для хостов mongod 4.0. 
mongocfg | **[MongoCfg](../cluster.proto#MongoCfg5)**<br>Конфигурация и выделенные ресурсы для хостов mongocfg 4.0. 
mongos | **[Mongos](../cluster.proto#Mongos5)**<br>Конфигурация и выделенные ресурсы для хостов mongos 4.0. 


### Mongod {#Mongod}

Поле | Описание
--- | ---
config | **`config.MongodConfig4_0`**<br>Конфигурация для хостов mongod 4.0. 
resources | **[Resources](../cluster.proto#Resources)**<br>Ресурсы, выделенные каждому хосту mongod. 


### MongoCfg {#MongoCfg}

Поле | Описание
--- | ---
config | **`config.MongoCfgConfig4_0`**<br>Конфигурация для хостов mongocfg 4.0. 
resources | **[Resources](../cluster.proto#Resources)**<br>Ресурсы, выделенные для каждого хоста mongocfg. 


### Mongos {#Mongos}

Поле | Описание
--- | ---
config | **`config.MongosConfig4_0`**<br>Конфигурация для хостов mongos 4.0. 
resources | **[Resources](../cluster.proto#Resources)**<br>Ресурсы, выделенные для каждого хоста mongos. 


### Access {#Access}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить доступ для DataLens 


### DatabaseSpec {#DatabaseSpec}

Поле | Описание
--- | ---
name | **string**<br>Обязательное поле. Имя базы данных MongoDB. Длина 1-63 символов. false Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]{1,63} `.


### UserSpec {#UserSpec}

Поле | Описание
--- | ---
name | **string**<br>Обязательное поле. Имя пользователя базы данных MongoDB. false Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.
password | **string**<br>Обязательное поле. Пароль пользователя MongoDB. false Длина строки в символах должна быть от 8 до 128.
permissions[] | **[Permission](../user.proto#Permission)**<br>Набор разрешений, которые следует предоставить пользователю. 


### Permission {#Permission}

Поле | Описание
--- | ---
database_name | **string**<br>Имя базы данных, к которой предоставляет доступ разрешение. 
roles[] | **string**<br>Роли MongoDB базы данных `database_name`, которые предоставляет разрешение. 


### HostSpec {#HostSpec}

Поле | Описание
--- | ---
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится хост. Чтобы получить список доступных зон, используйте запрос [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/grpc/zone_service#List). Максимальная длина строки в символах — 50.
subnet_id | **string**<br>Идентификатор подсети, к которой должен принадлежать хост. Эта подсеть должна быть частью сети, к которой принадлежит кластер. Идентификатор сети устанавливается в поле [Cluster.network_id](../cluster.proto#Cluster2). Максимальная длина строки в символах — 50.
assign_public_ip | **bool**<br><ul><li>false — не назначать хосту публичный IP-адрес. </li><li>true — у хоста должен быть публичный IP-адрес.</li></ul> 
type | **[Host.Type](../cluster.proto#Host)**<br>Тип развертываемого хоста. 
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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](../cluster.proto#Cluster2)>**<br>в случае успешного выполнения операции. 


### CreateClusterMetadata {#CreateClusterMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор создаваемого кластера MongoDB. 


### Cluster {#Cluster}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера MongoDB. Этот идентификатор генерирует MDB при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер MongoDB. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера MongoDB. Имя уникально в рамках каталога. Длина 1-63 символов. 
description | **string**<br>Описание кластера MongoDB. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера MongoDB как пары `` key:value ``. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания кластера MongoDB. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](../cluster.proto#Monitoring2)**<br>Описание систем мониторинга, относящихся к данному кластеру MongoDB. 
config | **[ClusterConfig](../cluster.proto#ClusterConfig2)**<br>Конфигурация кластера MongoDB. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Агрегированная работоспособность кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](../cluster.proto#Host) для каждого хоста в кластере — UNKNOWN).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](../cluster.proto#Host) для каждого хоста в кластере — ALIVE).</li><li>`DEAD`: Кластер не работает ([Host.health](../cluster.proto#Host) для каждого узла в кластере — DEAD).</li><li>`DEGRADED`: Кластер работает неоптимально ([Host.health](../cluster.proto#Host) по крайней мере для одного узла в кластере не ALIVE).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: На кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>
sharded | **bool**<br>Указывает текущее состояние шардирования кластера. 


## Update {#Update}

Изменяет указанный кластер MongoDB.

**rpc Update ([UpdateClusterRequest](#UpdateClusterRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterMetadata](#UpdateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](../cluster.proto#Cluster3)<br>

### UpdateClusterRequest {#UpdateClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор изменяемого ресурса Cluster для MongoDB. Чтобы получить идентификатор кластера MongoDB, используйте запрос [ClusterService.List](#List). false Максимальная длина строки в символах — 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска, которая указывает, какие поля ресурса Cluster для MongoDB должны быть изменены. 
description | **string**<br>Новое описание кластера MongoDB. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Пользовательские метки для кластера MongoDB как "` key:value `` pairs. Maximum 64 per resource. For example, `project": "mvp" или "source": "dictionary". <br>Новый набор меток полностью заменит старый. Чтобы добавить метку, запросите текущий набор меток с помощью метода [ClusterService.Get](#Get), затем отправьте запрос [ClusterService.Update](#Update), добавив новую метку в этот набор. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Максимальная длина строки в символах для каждого ключа — 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
config_spec | **[ConfigSpec](#ConfigSpec1)**<br>Новая конфигурация и ресурсы для хостов кластера. 


### ConfigSpec {#ConfigSpec}

Поле | Описание
--- | ---
version | **string**<br>Версия MongoDB, используемая в кластере. Возможные значения: `3.6`, `4.0`, `4.2`. 
feature_compatibility_version | **string**<br><ul><li>`3.6` — сохранить совместимость данных с версией 3.6. После установки этого параметра данные не будут совместимы с версией 3.4 или ниже. </li><li>`4.0` — сохранить совместимость данных с версией 4.0. После установки этого параметра данные не будут совместимы с версией 3.6 или ниже. </li><li>`4.2` — сохранить совместимость данных с версией 4.2. После установки этого параметра данные не будут совместимы с версией 4.0 или ниже.</li></ul> 
mongodb_spec | **oneof:** `mongodb_spec_3_6`, `mongodb_spec_4_0` или `mongodb_spec_4_2`<br>
&nbsp;&nbsp;mongodb_spec_3_6 | **[MongodbSpec3_6](#MongodbSpec3_61)**<br>Конфигурация и распределение ресурсов для кластера MongoDB 3.6. 
&nbsp;&nbsp;mongodb_spec_4_0 | **[MongodbSpec4_0](#MongodbSpec4_01)**<br>Конфигурация и распределение ресурсов для кластера MongoDB 4.0. 
&nbsp;&nbsp;mongodb_spec_4_2 | **[MongodbSpec4_0](#MongodbSpec4_01)**<br>Конфигурация и распределение ресурсов для кластера MongoDB 4.2. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](../cluster.proto#Access1)**<br>Политика доступа к БД 


### MongodbSpec3_6 {#MongodbSpec3_6}

Поле | Описание
--- | ---
mongod | **[Mongod](../cluster.proto#Mongod6)**<br>Конфигурация и выделенные ресурсы для хостов mongod 3.6. 
mongocfg | **[MongoCfg](../cluster.proto#MongoCfg6)**<br>Конфигурация и выделенные ресурсы для хостов mongocfg 3.6. 
mongos | **[Mongos](../cluster.proto#Mongos6)**<br>Конфигурация и выделенные ресурсы для хостов mongos 3.6. 


### Mongod {#Mongod}

Поле | Описание
--- | ---
config | **`config.MongodConfig3_6`**<br>Конфигурация для хостов mongod 3.6. 
resources | **[Resources](../cluster.proto#Resources)**<br>Ресурсы, выделенные каждому хосту mongod. 


### MongoCfg {#MongoCfg}

Поле | Описание
--- | ---
config | **`config.MongoCfgConfig3_6`**<br>Конфигурация для хостов mongocfg 3.6. 
resources | **[Resources](../cluster.proto#Resources)**<br>Ресурсы, выделенные для каждого хоста mongocfg. 


### Mongos {#Mongos}

Поле | Описание
--- | ---
config | **`config.MongosConfig3_6`**<br>Конфигурация для хостов mongos 3.6. 
resources | **[Resources](../cluster.proto#Resources)**<br>Ресурсы, выделенные для каждого хоста mongos. 


### MongodbSpec4_0 {#MongodbSpec4_0}

Поле | Описание
--- | ---
mongod | **[Mongod](../cluster.proto#Mongod7)**<br>Конфигурация и выделенные ресурсы для хостов mongod 4.0. 
mongocfg | **[MongoCfg](../cluster.proto#MongoCfg7)**<br>Конфигурация и выделенные ресурсы для хостов mongocfg 4.0. 
mongos | **[Mongos](../cluster.proto#Mongos7)**<br>Конфигурация и выделенные ресурсы для хостов mongos 4.0. 


### Mongod {#Mongod}

Поле | Описание
--- | ---
config | **`config.MongodConfig4_0`**<br>Конфигурация для хостов mongod 4.0. 
resources | **[Resources](../cluster.proto#Resources)**<br>Ресурсы, выделенные каждому хосту mongod. 


### MongoCfg {#MongoCfg}

Поле | Описание
--- | ---
config | **`config.MongoCfgConfig4_0`**<br>Конфигурация для хостов mongocfg 4.0. 
resources | **[Resources](../cluster.proto#Resources)**<br>Ресурсы, выделенные для каждого хоста mongocfg. 


### Mongos {#Mongos}

Поле | Описание
--- | ---
config | **`config.MongosConfig4_0`**<br>Конфигурация для хостов mongos 4.0. 
resources | **[Resources](../cluster.proto#Resources)**<br>Ресурсы, выделенные для каждого хоста mongos. 


### Access {#Access}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить доступ для DataLens 


### Operation {#Operation}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](../cluster.proto#Cluster3)>**<br>в случае успешного выполнения операции. 


### UpdateClusterMetadata {#UpdateClusterMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор изменяемого ресурса Cluster для MongoDB. 


### Cluster {#Cluster}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера MongoDB. Этот идентификатор генерирует MDB при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер MongoDB. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера MongoDB. Имя уникально в рамках каталога. Длина 1-63 символов. 
description | **string**<br>Описание кластера MongoDB. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера MongoDB как пары `` key:value ``. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания кластера MongoDB. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](../cluster.proto#Monitoring2)**<br>Описание систем мониторинга, относящихся к данному кластеру MongoDB. 
config | **[ClusterConfig](../cluster.proto#ClusterConfig2)**<br>Конфигурация кластера MongoDB. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Агрегированная работоспособность кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](../cluster.proto#Host) для каждого хоста в кластере — UNKNOWN).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](../cluster.proto#Host) для каждого хоста в кластере — ALIVE).</li><li>`DEAD`: Кластер не работает ([Host.health](../cluster.proto#Host) для каждого узла в кластере — DEAD).</li><li>`DEGRADED`: Кластер работает неоптимально ([Host.health](../cluster.proto#Host) по крайней мере для одного узла в кластере не ALIVE).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: На кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>
sharded | **bool**<br>Указывает текущее состояние шардирования кластера. 


## Delete {#Delete}

Удаляет указанный кластер MongoDB.

**rpc Delete ([DeleteClusterRequest](#DeleteClusterRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterMetadata](#DeleteClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterRequest {#DeleteClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера MongoDB, который следует удалить. Чтобы получить идентификатор кластера MongoDB, используйте запрос [ClusterService.List](#List). false Максимальная длина строки в символах — 50.


### Operation {#Operation}

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
cluster_id | **string**<br>Идентификатор удаляемого кластера MongoDB. 


## Start {#Start}

Запускает указанный кластер MongoDB.

**rpc Start ([StartClusterRequest](#StartClusterRequest)) returns ([operation.Operation](#Operation3))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartClusterMetadata](#StartClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](../cluster.proto#Cluster4)<br>

### StartClusterRequest {#StartClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера MongoDB, который следует запустить. false Максимальная длина строки в символах — 50.


### Operation {#Operation}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](../cluster.proto#Cluster4)>**<br>в случае успешного выполнения операции. 


### StartClusterMetadata {#StartClusterMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера MongoDB. 


### Cluster {#Cluster}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера MongoDB. Этот идентификатор генерирует MDB при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер MongoDB. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера MongoDB. Имя уникально в рамках каталога. Длина 1-63 символов. 
description | **string**<br>Описание кластера MongoDB. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера MongoDB как пары `` key:value ``. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания кластера MongoDB. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](../cluster.proto#Monitoring2)**<br>Описание систем мониторинга, относящихся к данному кластеру MongoDB. 
config | **[ClusterConfig](../cluster.proto#ClusterConfig2)**<br>Конфигурация кластера MongoDB. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Агрегированная работоспособность кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](../cluster.proto#Host) для каждого хоста в кластере — UNKNOWN).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](../cluster.proto#Host) для каждого хоста в кластере — ALIVE).</li><li>`DEAD`: Кластер не работает ([Host.health](../cluster.proto#Host) для каждого узла в кластере — DEAD).</li><li>`DEGRADED`: Кластер работает неоптимально ([Host.health](../cluster.proto#Host) по крайней мере для одного узла в кластере не ALIVE).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: На кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>
sharded | **bool**<br>Указывает текущее состояние шардирования кластера. 


## Stop {#Stop}

Останавливает указанный кластер MongoDB.

**rpc Stop ([StopClusterRequest](#StopClusterRequest)) returns ([operation.Operation](#Operation4))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopClusterMetadata](#StopClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](../cluster.proto#Cluster5)<br>

### StopClusterRequest {#StopClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера MongoDB, который следует остановить. false Максимальная длина строки в символах — 50.


### Operation {#Operation}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](../cluster.proto#Cluster5)>**<br>в случае успешного выполнения операции. 


### StopClusterMetadata {#StopClusterMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера MongoDB. 


### Cluster {#Cluster}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера MongoDB. Этот идентификатор генерирует MDB при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер MongoDB. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера MongoDB. Имя уникально в рамках каталога. Длина 1-63 символов. 
description | **string**<br>Описание кластера MongoDB. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера MongoDB как пары `` key:value ``. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания кластера MongoDB. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](../cluster.proto#Monitoring2)**<br>Описание систем мониторинга, относящихся к данному кластеру MongoDB. 
config | **[ClusterConfig](../cluster.proto#ClusterConfig2)**<br>Конфигурация кластера MongoDB. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Агрегированная работоспособность кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](../cluster.proto#Host) для каждого хоста в кластере — UNKNOWN).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](../cluster.proto#Host) для каждого хоста в кластере — ALIVE).</li><li>`DEAD`: Кластер не работает ([Host.health](../cluster.proto#Host) для каждого узла в кластере — DEAD).</li><li>`DEGRADED`: Кластер работает неоптимально ([Host.health](../cluster.proto#Host) по крайней мере для одного узла в кластере не ALIVE).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: На кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>
sharded | **bool**<br>Указывает текущее состояние шардирования кластера. 


## Move {#Move}

Перемещает кластер MongoDB в указанный каталог.

**rpc Move ([MoveClusterRequest](#MoveClusterRequest)) returns ([operation.Operation](#Operation5))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[MoveClusterMetadata](#MoveClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](../cluster.proto#Cluster6)<br>

### MoveClusterRequest {#MoveClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера MongoDB, который следует переместить. false Максимальная длина строки в символах — 50.
destination_folder_id | **string**<br>Обязательное поле. Идентификатор каталога, в который следует переместить кластер. false Максимальная длина строки в символах — 50.


### Operation {#Operation}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](../cluster.proto#Cluster6)>**<br>в случае успешного выполнения операции. 


### MoveClusterMetadata {#MoveClusterMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор перемещаемого кластера MongoDB. 
source_folder_id | **string**<br>Идентификатор исходного каталога. 
destination_folder_id | **string**<br>Идентификатор каталога назначения. 


### Cluster {#Cluster}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера MongoDB. Этот идентификатор генерирует MDB при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер MongoDB. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера MongoDB. Имя уникально в рамках каталога. Длина 1-63 символов. 
description | **string**<br>Описание кластера MongoDB. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера MongoDB как пары `` key:value ``. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания кластера MongoDB. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](../cluster.proto#Monitoring2)**<br>Описание систем мониторинга, относящихся к данному кластеру MongoDB. 
config | **[ClusterConfig](../cluster.proto#ClusterConfig2)**<br>Конфигурация кластера MongoDB. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Агрегированная работоспособность кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](../cluster.proto#Host) для каждого хоста в кластере — UNKNOWN).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](../cluster.proto#Host) для каждого хоста в кластере — ALIVE).</li><li>`DEAD`: Кластер не работает ([Host.health](../cluster.proto#Host) для каждого узла в кластере — DEAD).</li><li>`DEGRADED`: Кластер работает неоптимально ([Host.health](../cluster.proto#Host) по крайней мере для одного узла в кластере не ALIVE).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: На кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>
sharded | **bool**<br>Указывает текущее состояние шардирования кластера. 


## Backup {#Backup}

Создает резервную копию для указанного кластера MongoDB.

**rpc Backup ([BackupClusterRequest](#BackupClusterRequest)) returns ([operation.Operation](#Operation6))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[BackupClusterMetadata](#BackupClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](../cluster.proto#Cluster7)<br>

### BackupClusterRequest {#BackupClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера MongoDB, для которого следует создать резервную копию. Чтобы получить идентификатор кластера MongoDB, используйте запрос [ClusterService.List](#List). false Максимальная длина строки в символах — 50.


### Operation {#Operation}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](../cluster.proto#Cluster7)>**<br>в случае успешного выполнения операции. 


### BackupClusterMetadata {#BackupClusterMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера MongoDB, для которого выполняется резервное копирование. 


### Cluster {#Cluster}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера MongoDB. Этот идентификатор генерирует MDB при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер MongoDB. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера MongoDB. Имя уникально в рамках каталога. Длина 1-63 символов. 
description | **string**<br>Описание кластера MongoDB. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера MongoDB как пары `` key:value ``. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания кластера MongoDB. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](../cluster.proto#Monitoring2)**<br>Описание систем мониторинга, относящихся к данному кластеру MongoDB. 
config | **[ClusterConfig](../cluster.proto#ClusterConfig2)**<br>Конфигурация кластера MongoDB. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Агрегированная работоспособность кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](../cluster.proto#Host) для каждого хоста в кластере — UNKNOWN).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](../cluster.proto#Host) для каждого хоста в кластере — ALIVE).</li><li>`DEAD`: Кластер не работает ([Host.health](../cluster.proto#Host) для каждого узла в кластере — DEAD).</li><li>`DEGRADED`: Кластер работает неоптимально ([Host.health](../cluster.proto#Host) по крайней мере для одного узла в кластере не ALIVE).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: На кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>
sharded | **bool**<br>Указывает текущее состояние шардирования кластера. 


## Restore {#Restore}

Создает новый кластер MongoDB с использованием указанной резервной копии.

**rpc Restore ([RestoreClusterRequest](#RestoreClusterRequest)) returns ([operation.Operation](#Operation7))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RestoreClusterMetadata](#RestoreClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](../cluster.proto#Cluster8)<br>

### RestoreClusterRequest {#RestoreClusterRequest}

Поле | Описание
--- | ---
backup_id | **string**<br>Обязательное поле. Идентификатор резервной копии, из которой следует создать кластер. Чтобы получить идентификатор резервной копии, используйте запрос [ClusterService.ListBackups](#ListBackups). false
name | **string**<br>Обязательное поле. Имя нового кластера MongoDB. Имя должно быть уникальным в каталоге. false Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.
description | **string**<br>Описание нового кластера MongoDB. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Пользовательские метки для кластера MongoDB как "` key:value `` пары. Максимум 64 на ресурс. Например, "project": "mvp" или "source": "dictionary". Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Максимальная длина строки в символах для каждого ключа — 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
environment | **[Cluster.Environment](../cluster.proto#Cluster8)**<br>Обязательное поле. Среда развертывания для нового кластера MongoDB. false
config_spec | **[ConfigSpec](#ConfigSpec2)**<br>Обязательное поле. Конфигурация для создаваемого кластера MongoDB. false
host_specs[] | **[HostSpec](#HostSpec1)**<br>Конфигурации для хостов MongoDB, которые должны быть созданы для кластера, создаваемого из резервной копии. Количество элементов должно быть больше 0.
network_id | **string**<br>Обязательное поле. Идентификатор сети, в которой нужно создать кластер MongoDB. false Максимальная длина строки в символах — 50.


### ConfigSpec {#ConfigSpec}

Поле | Описание
--- | ---
version | **string**<br>Версия MongoDB, используемая в кластере. Возможные значения: `3.6`, `4.0`, `4.2`. 
feature_compatibility_version | **string**<br><ul><li>`3.6` — сохранить совместимость данных с версией 3.6. После установки этого параметра данные не будут совместимы с версией 3.4 или ниже. </li><li>`4.0` — сохранить совместимость данных с версией 4.0. После установки этого параметра данные не будут совместимы с версией 3.6 или ниже. </li><li>`4.2` — сохранить совместимость данных с версией 4.2. После установки этого параметра данные не будут совместимы с версией 4.0 или ниже.</li></ul> 
mongodb_spec | **oneof:** `mongodb_spec_3_6`, `mongodb_spec_4_0` или `mongodb_spec_4_2`<br>
&nbsp;&nbsp;mongodb_spec_3_6 | **[MongodbSpec3_6](#MongodbSpec3_62)**<br>Конфигурация и распределение ресурсов для кластера MongoDB 3.6. 
&nbsp;&nbsp;mongodb_spec_4_0 | **[MongodbSpec4_0](#MongodbSpec4_02)**<br>Конфигурация и распределение ресурсов для кластера MongoDB 4.0. 
&nbsp;&nbsp;mongodb_spec_4_2 | **[MongodbSpec4_0](#MongodbSpec4_02)**<br>Конфигурация и распределение ресурсов для кластера MongoDB 4.2. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](../cluster.proto#Access2)**<br>Политика доступа к БД 


### MongodbSpec3_6 {#MongodbSpec3_6}

Поле | Описание
--- | ---
mongod | **[Mongod](../cluster.proto#Mongod8)**<br>Конфигурация и выделенные ресурсы для хостов mongod 3.6. 
mongocfg | **[MongoCfg](../cluster.proto#MongoCfg8)**<br>Конфигурация и выделенные ресурсы для хостов mongocfg 3.6. 
mongos | **[Mongos](../cluster.proto#Mongos8)**<br>Конфигурация и выделенные ресурсы для хостов mongos 3.6. 


### Mongod {#Mongod}

Поле | Описание
--- | ---
config | **`config.MongodConfig3_6`**<br>Конфигурация для хостов mongod 3.6. 
resources | **[Resources](../cluster.proto#Resources)**<br>Ресурсы, выделенные каждому хосту mongod. 


### MongoCfg {#MongoCfg}

Поле | Описание
--- | ---
config | **`config.MongoCfgConfig3_6`**<br>Конфигурация для хостов mongocfg 3.6. 
resources | **[Resources](../cluster.proto#Resources)**<br>Ресурсы, выделенные для каждого хоста mongocfg. 


### Mongos {#Mongos}

Поле | Описание
--- | ---
config | **`config.MongosConfig3_6`**<br>Конфигурация для хостов mongos 3.6. 
resources | **[Resources](../cluster.proto#Resources)**<br>Ресурсы, выделенные для каждого хоста mongos. 


### MongodbSpec4_0 {#MongodbSpec4_0}

Поле | Описание
--- | ---
mongod | **[Mongod](../cluster.proto#Mongod9)**<br>Конфигурация и выделенные ресурсы для хостов mongod 4.0. 
mongocfg | **[MongoCfg](../cluster.proto#MongoCfg9)**<br>Конфигурация и выделенные ресурсы для хостов mongocfg 4.0. 
mongos | **[Mongos](../cluster.proto#Mongos9)**<br>Конфигурация и выделенные ресурсы для хостов mongos 4.0. 


### Mongod {#Mongod}

Поле | Описание
--- | ---
config | **`config.MongodConfig4_0`**<br>Конфигурация для хостов mongod 4.0. 
resources | **[Resources](../cluster.proto#Resources)**<br>Ресурсы, выделенные каждому хосту mongod. 


### MongoCfg {#MongoCfg}

Поле | Описание
--- | ---
config | **`config.MongoCfgConfig4_0`**<br>Конфигурация для хостов mongocfg 4.0. 
resources | **[Resources](../cluster.proto#Resources)**<br>Ресурсы, выделенные для каждого хоста mongocfg. 


### Mongos {#Mongos}

Поле | Описание
--- | ---
config | **`config.MongosConfig4_0`**<br>Конфигурация для хостов mongos 4.0. 
resources | **[Resources](../cluster.proto#Resources)**<br>Ресурсы, выделенные для каждого хоста mongos. 


### Access {#Access}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить доступ для DataLens 


### HostSpec {#HostSpec}

Поле | Описание
--- | ---
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится хост. Чтобы получить список доступных зон, используйте запрос [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/grpc/zone_service#List). Максимальная длина строки в символах — 50.
subnet_id | **string**<br>Идентификатор подсети, к которой должен принадлежать хост. Эта подсеть должна быть частью сети, к которой принадлежит кластер. Идентификатор сети устанавливается в поле [Cluster.network_id](../cluster.proto#Cluster8). Максимальная длина строки в символах — 50.
assign_public_ip | **bool**<br><ul><li>false — не назначать хосту публичный IP-адрес. </li><li>true — у хоста должен быть публичный IP-адрес.</li></ul> 
type | **[Host.Type](../cluster.proto#Host)**<br>Тип развертываемого хоста. 
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
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RestoreClusterMetadata](#RestoreClusterMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](../cluster.proto#Cluster8)>**<br>в случае успешного выполнения операции. 


### RestoreClusterMetadata {#RestoreClusterMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор нового кластера MongoDB, создаваемого из резервной копии. 
backup_id | **string**<br>Идентификатор резервной копии, используемой для создания кластера. 


### Cluster {#Cluster}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера MongoDB. Этот идентификатор генерирует MDB при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер MongoDB. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера MongoDB. Имя уникально в рамках каталога. Длина 1-63 символов. 
description | **string**<br>Описание кластера MongoDB. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера MongoDB как пары `` key:value ``. Максимум 64 на ресурс. 
environment | enum **Environment**<br>Среда развертывания кластера MongoDB. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](../cluster.proto#Monitoring2)**<br>Описание систем мониторинга, относящихся к данному кластеру MongoDB. 
config | **[ClusterConfig](../cluster.proto#ClusterConfig2)**<br>Конфигурация кластера MongoDB. 
network_id | **string**<br>Идентификатор сети, к которой принадлежит кластер. 
health | enum **Health**<br>Агрегированная работоспособность кластера. <ul><li>`HEALTH_UNKNOWN`: Состояние кластера неизвестно ([Host.health](../cluster.proto#Host) для каждого хоста в кластере — UNKNOWN).</li><li>`ALIVE`: Кластер работает нормально ([Host.health](../cluster.proto#Host) для каждого хоста в кластере — ALIVE).</li><li>`DEAD`: Кластер не работает ([Host.health](../cluster.proto#Host) для каждого узла в кластере — DEAD).</li><li>`DEGRADED`: Кластер работает неоптимально ([Host.health](../cluster.proto#Host) по крайней мере для одного узла в кластере не ALIVE).</li><ul/>
status | enum **Status**<br>Текущее состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно.</li><li>`CREATING`: Кластер создается.</li><li>`RUNNING`: Кластер работает нормально.</li><li>`ERROR`: На кластере произошла ошибка, блокирующая работу.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>
sharded | **bool**<br>Указывает текущее состояние шардирования кластера. 


## ListLogs {#ListLogs}

Получает логи для указанного кластера MongoDB.

**rpc ListLogs ([ListClusterLogsRequest](#ListClusterLogsRequest)) returns ([ListClusterLogsResponse](#ListClusterLogsResponse))**

### ListClusterLogsRequest {#ListClusterLogsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера MongoDB, для которого следует запросить логи. Чтобы получить идентификатор кластера MongoDB, используйте запрос [ClusterService.List](#List). false Максимальная длина строки в символах — 50.
column_filter[] | **string**<br>Столбцы из таблицы логов для запроса. Если столбцы не указаны, записи логов возвращаются целиком. 
service_type | enum **ServiceType**<br>Тип сервиса, для которого следует запросить логи. <ul><li>`MONGOD`: Логи работы MongoDB.</li><ul/>
from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Начало периода, для которого следует запросить логи, в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Конец периода, для которого следует запросить логи, в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListClusterLogsResponse {#ListClusterLogsResponse}

Поле | Описание
--- | ---
logs[] | **[LogRecord](#LogRecord)**<br>Запрошенные записи логов. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListClusterLogsRequest.page_size](#ListClusterLogsRequest1), используйте `next_page_token` в качестве значения параметра [ListClusterLogsRequest.page_token](#ListClusterLogsRequest1) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


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
cluster_id | **string**<br>Обязательное поле. Идентификатор ресурса Cluster для MongoDB, для которого запрашивается список операций. false Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListClusterOperationsResponse {#ListClusterOperationsResponse}

Поле | Описание
--- | ---
operations[] | **[operation.Operation](#Operation8)**<br>Список ресурсов Operation для указанного кластера MongoDB. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListClusterOperationsRequest.page_size](#ListClusterOperationsRequest1), используйте `next_page_token` в качестве значения параметра [ListClusterOperationsRequest.page_token](#ListClusterOperationsRequest1) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Operation {#Operation}

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

Получает список доступных резервных копий для указанного кластера MongoDB.

**rpc ListBackups ([ListClusterBackupsRequest](#ListClusterBackupsRequest)) returns ([ListClusterBackupsResponse](#ListClusterBackupsResponse))**

### ListClusterBackupsRequest {#ListClusterBackupsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера MongoDB. Чтобы получить идентификатор кластера MongoDB, используйте запрос [ClusterService.List](#List). false Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListClusterBackupsResponse.next_page_token](#ListClusterBackupsResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListClusterBackupsResponse.next_page_token](#ListClusterBackupsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListClusterBackupsResponse {#ListClusterBackupsResponse}

Поле | Описание
--- | ---
backups[] | **[Backup](#Backup)**<br>Список ресурсов Backup для MongoDB. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListClusterBackupsRequest.page_size](#ListClusterBackupsRequest1), используйте `next_page_token` в качестве значения параметра [ListClusterBackupsRequest.page_token](#ListClusterBackupsRequest1) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Backup {#Backup}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор резервной копии. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит резервная копия. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) (т. е. когда операция резервного копирования была завершена). 
source_cluster_id | **string**<br>Идентификатор кластера MongoDB, для которого была создана резервная копия. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время запуска операции резервного копирования. 
source_shard_names[] | **string**<br>Имена шардов, которые использовались при создании резервной копии. 


## ListHosts {#ListHosts}

Получает список хостов для указанного кластера.

**rpc ListHosts ([ListClusterHostsRequest](#ListClusterHostsRequest)) returns ([ListClusterHostsResponse](#ListClusterHostsResponse))**

### ListClusterHostsRequest {#ListClusterHostsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера MongoDB. Чтобы получить идентификатор кластера MongoDB, используйте запрос [ClusterService.List](#List). false Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListClusterHostsResponse {#ListClusterHostsResponse}

Поле | Описание
--- | ---
hosts[] | **[Host](../cluster.proto#Host)**<br>Список ресурсов Host. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListClusterHostsRequest.page_size](#ListClusterHostsRequest1), используйте `next_page_token` в качестве значения параметра [ListClusterHostsRequest.page_token](#ListClusterHostsRequest1) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Host {#Host}

Поле | Описание
--- | ---
name | **string**<br>Имя хоста MongoDB. Имя хоста назначается MDB во время создания и не может быть изменено. Длина 1-63 символов. <br>Имя уникально для всех существующих хостов MDB в Яндекс.Облаке, так как оно определяет полное доменное имя (FQDN) хоста. 
cluster_id | **string**<br>Идентификатор хоста MongoDB. Этот идентификатор генерирует MDB при создании. 
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится хост MongoDB. 
resources | **[Resources](../cluster.proto#Resources)**<br>Ресурсы, выделенные хосту MongoDB. 
role | enum **Role**<br>Роль хоста в кластере. <ul><li>`ROLE_UNKNOWN`: Роль хоста в кластере неизвестна.</li><li>`PRIMARY`: Хост является основным сервером MongoDB в кластере.</li><li>`SECONDARY`: Хост является вторичным сервером MongoDB в кластере.</li><ul/>
health | enum **Health**<br>Код работоспособности хоста. <ul><li>`HEALTH_UNKNOWN`: Состояние хоста неизвестно.</li><li>`ALIVE`: Хозяин выполняет все свои функции нормально.</li><li>`DEAD`: Хост не работает и не может выполнять свои основные функции.</li><li>`DEGRADED`: Хост деградировал, и может выполнять только некоторые из своих основных функций.</li><ul/>
services[] | **[Service](../cluster.proto#Service)**<br>Сервисы, предоставляемые хостом. 
subnet_id | **string**<br>Идентификатор подсети, к которой принадлежит хост. 
assign_public_ip | **bool**<br>Флаг, показывающий статус публичного IP-адреса для этого хоста. 
shard_name | **string**<br>Шард, которому принадлежит этот этот хост. 
type | enum **Type**<br>Тип хоста <ul><li>`MONGOD`: Хост mongod.</li><li>`MONGOS`: Хост mongos.</li><li>`MONGOCFG`: Хост mongocfg.</li><ul/>


### Resources {#Resources}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [документации](/docs/managed-mongodb/concepts/instance-types). 
disk_size | **int64**<br>Объем хранилища, доступного хосту, в байтах. 
disk_type_id | **string**<br><ul><li>network-hdd — сетевой HDD-диск; </li><li>network-ssd — сетевой SSD-диск; </li><li>local-ssd — локальное SSD-хранилище.</li></ul> 


### Service {#Service}

Поле | Описание
--- | ---
type | enum **Type**<br>Тип сервиса, предоставляемого хостом. <ul><li>`MONGOD`: На хосте работает демон mongod.</li><li>`MONGOS`: На хосте работает демон mongos.</li><li>`MONGOCFG`: На хосте работает сервер конфигураций MongoDB.</li><ul/>
health | enum **Health**<br>Код состояния доступности сервера. <ul><li>`HEALTH_UNKNOWN`: Работоспособность сервера неизвестна.</li><li>`ALIVE`: Сервер работает нормально.</li><li>`DEAD`: Сервер отключен или не отвечает.</li><ul/>


## AddHosts {#AddHosts}

Создает новые хосты для кластера.

**rpc AddHosts ([AddClusterHostsRequest](#AddClusterHostsRequest)) returns ([operation.Operation](#Operation9))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddClusterHostsMetadata](#AddClusterHostsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### AddClusterHostsRequest {#AddClusterHostsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера MongoDB, для которого следует добавить хосты. Чтобы получить идентификатор кластера MongoDB, используйте запрос [ClusterService.List](#List). false Максимальная длина строки в символах — 50.
host_specs[] | **[HostSpec](#HostSpec2)**<br>Конфигурации для хостов MongoDB, которые должны быть добавлены в кластер. Количество элементов должно быть больше 0.


### HostSpec {#HostSpec}

Поле | Описание
--- | ---
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится хост. Чтобы получить список доступных зон, используйте запрос [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/grpc/zone_service#List). Максимальная длина строки в символах — 50.
subnet_id | **string**<br>Идентификатор подсети, к которой должен принадлежать хост. Эта подсеть должна быть частью сети, к которой принадлежит кластер. Идентификатор сети устанавливается в поле [Cluster.network_id](../cluster.proto#Cluster9). Максимальная длина строки в символах — 50.
assign_public_ip | **bool**<br><ul><li>false — не назначать хосту публичный IP-адрес. </li><li>true — у хоста должен быть публичный IP-адрес.</li></ul> 
type | **[Host.Type](../cluster.proto#Host1)**<br>Тип развертываемого хоста. 
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
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AddClusterHostsMetadata](#AddClusterHostsMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### AddClusterHostsMetadata {#AddClusterHostsMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера MongoDB, в который добавляются хосты. 
host_names[] | **string**<br>Имена хостов, добавляемых в кластер. 


## DeleteHosts {#DeleteHosts}

Удаляет указанные хосты кластера.

**rpc DeleteHosts ([DeleteClusterHostsRequest](#DeleteClusterHostsRequest)) returns ([operation.Operation](#Operation10))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterHostsMetadata](#DeleteClusterHostsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterHostsRequest {#DeleteClusterHostsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера MongoDB, из которого следует удалить хосты. Чтобы получить идентификатор кластера MongoDB, используйте запрос [ClusterService.List](#List). false Максимальная длина строки в символах — 50.
host_names[] | **string**<br>Имена хостов, которые следует удалить. Количество элементов должно быть больше 0. Максимальная длина строки в символах для каждого значения — 253.


### Operation {#Operation}

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
cluster_id | **string**<br>Идентификатор кластера MongoDB, из которого следует удалить хосты. 
host_names[] | **string**<br>Имена удаляемых хостов. 


## EnableSharding {#EnableSharding}

Включает шардирование для кластера: создает 3 хоста mongocfg и 2 хоста mongos, которые необходимы чтобы добавлять и использовать шарды в кластере.

**rpc EnableSharding ([EnableClusterShardingRequest](#EnableClusterShardingRequest)) returns ([operation.Operation](#Operation11))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[EnableClusterShardingMetadata](#EnableClusterShardingMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### EnableClusterShardingRequest {#EnableClusterShardingRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера MongoDB, для которого нужно включить шардирование. false Максимальная длина строки в символах — 50.
mongocfg | **[MongoCfg](../cluster.proto#MongoCfg10)**<br>Обязательное поле. Спецификация mongocfg для шардирования. false
mongos | **[Mongos](../cluster.proto#Mongos10)**<br>Обязательное поле. Спецификация mongos для шардирования. false
host_specs[] | **[HostSpec](#HostSpec3)**<br>Конфигурации для хостов mongos и mongocfg. Количество элементов должно быть больше 0.


### MongoCfg {#MongoCfg}

Поле | Описание
--- | ---
resources | **[Resources](../cluster.proto#Resources1)**<br>Обязательное поле. Ресурсы для хостов mongocfg. false


### Mongos {#Mongos}

Поле | Описание
--- | ---
resources | **[Resources](../cluster.proto#Resources1)**<br>Обязательное поле. Ресурсы для хостов mongos. false


### HostSpec {#HostSpec}

Поле | Описание
--- | ---
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится хост. Чтобы получить список доступных зон, используйте запрос [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/grpc/zone_service#List). Максимальная длина строки в символах — 50.
subnet_id | **string**<br>Идентификатор подсети, к которой должен принадлежать хост. Эта подсеть должна быть частью сети, к которой принадлежит кластер. Идентификатор сети устанавливается в поле [Cluster.network_id](../cluster.proto#Cluster9). Максимальная длина строки в символах — 50.
assign_public_ip | **bool**<br><ul><li>false — не назначать хосту публичный IP-адрес. </li><li>true — у хоста должен быть публичный IP-адрес.</li></ul> 
type | **[Host.Type](../cluster.proto#Host1)**<br>Тип развертываемого хоста. 
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
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[EnableClusterShardingMetadata](#EnableClusterShardingMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### EnableClusterShardingMetadata {#EnableClusterShardingMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера MongoDB, для которого включается шардирование. 


## GetShard {#GetShard}

Возвращает указанный шард.

**rpc GetShard ([GetClusterShardRequest](#GetClusterShardRequest)) returns ([Shard](../cluster.proto#Shard))**

### GetClusterShardRequest {#GetClusterShardRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор MongoDB-кластера, которому принадлежит шард. Чтобы получить идентификатор кластера, используйте запрос [List](#List). false Максимальная длина строки в символах — 50.
shard_name | **string**<br>Обязательное поле. Имя запрашиваемого шарда MongoDB. Чтобы получить имя шарда, используйте запрос [ListShards](#ListShards). false Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.


### Shard {#Shard}

Поле | Описание
--- | ---
name | **string**<br>Имя шарда. 
cluster_id | **string**<br>Идентификатор кластера, к которому принадлежит шард. 


## ListShards {#ListShards}

Получает список шардов.

**rpc ListShards ([ListClusterShardsRequest](#ListClusterShardsRequest)) returns ([ListClusterShardsResponse](#ListClusterShardsResponse))**

### ListClusterShardsRequest {#ListClusterShardsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера MongoDB, для которого следует вернуть список баз данных. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](#List). false Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListClusterShardsResponse.next_page_token](#ListClusterShardsResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListClusterShardsResponse.next_page_token](#ListClusterShardsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListClusterShardsResponse {#ListClusterShardsResponse}

Поле | Описание
--- | ---
shards[] | **[Shard](../cluster.proto#Shard1)**<br>Список шардов MongoDB. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListClusterShardsRequest.page_size](#ListClusterShardsRequest1), используйте `next_page_token` в качестве значения параметра [ListClusterShardsRequest.page_token](#ListClusterShardsRequest1) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Shard {#Shard}

Поле | Описание
--- | ---
name | **string**<br>Имя шарда. 
cluster_id | **string**<br>Идентификатор кластера, к которому принадлежит шард. 


## AddShard {#AddShard}

Создает новый шард.

**rpc AddShard ([AddClusterShardRequest](#AddClusterShardRequest)) returns ([operation.Operation](#Operation12))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddClusterShardMetadata](#AddClusterShardMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Shard](../cluster.proto#Shard2)<br>

### AddClusterShardRequest {#AddClusterShardRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера MongoDB, в который нужно добавить шард. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](#List). false Максимальная длина строки в символах — 50.
shard_name | **string**<br>Обязательное поле. Имя создаваемого шарда MongoDB. false Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.
host_specs[] | **[HostSpec](#HostSpec4)**<br>Конфигурации для хостов mongod, которые будут созданы вместе с шардом. Количество элементов должно быть больше 0.


### HostSpec {#HostSpec}

Поле | Описание
--- | ---
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится хост. Чтобы получить список доступных зон, используйте запрос [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/grpc/zone_service#List). Максимальная длина строки в символах — 50.
subnet_id | **string**<br>Идентификатор подсети, к которой должен принадлежать хост. Эта подсеть должна быть частью сети, к которой принадлежит кластер. Идентификатор сети устанавливается в поле [Cluster.network_id](../cluster.proto#Cluster9). Максимальная длина строки в символах — 50.
assign_public_ip | **bool**<br><ul><li>false — не назначать хосту публичный IP-адрес. </li><li>true — у хоста должен быть публичный IP-адрес.</li></ul> 
type | **[Host.Type](../cluster.proto#Host1)**<br>Тип развертываемого хоста. 
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
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AddClusterShardMetadata](#AddClusterShardMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Shard](../cluster.proto#Shard2)>**<br>в случае успешного выполнения операции. 


### AddClusterShardMetadata {#AddClusterShardMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера MongoDB, в который добавляется шард. 
shard_name | **string**<br>Имя добавляемого шарда. 


### Shard {#Shard}

Поле | Описание
--- | ---
name | **string**<br>Имя шарда. 
cluster_id | **string**<br>Идентификатор кластера, к которому принадлежит шард. 


## DeleteShard {#DeleteShard}

Удаляет указанный шард.

**rpc DeleteShard ([DeleteClusterShardRequest](#DeleteClusterShardRequest)) returns ([operation.Operation](#Operation13))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterShardMetadata](#DeleteClusterShardMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterShardRequest {#DeleteClusterShardRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера MongoDB, в котором следует удалить шард. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](#List). false Максимальная длина строки в символах — 50.
shard_name | **string**<br>Обязательное поле. Имя шарда MongoDB, который следует удалить. Чтобы получить имя шарда, используйте запрос [ListShards](#ListShards). false Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.


### Operation {#Operation}

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
cluster_id | **string**<br>Идентификатор кластера MongoDB, в котором удаляется шард. 
shard_name | **string**<br>Имя удаляемого шарда. 


