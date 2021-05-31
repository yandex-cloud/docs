---
editable: false
---

# ClusterService

Методы для управления кластерами Redis.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанный кластер Redis. |
| [List](#List) | Возвращает список кластеров Redis, принадлежащих указанному каталогу. |
| [Create](#Create) | Создает кластер Redis в указанном каталоге. |
| [Update](#Update) | Изменяет указанный кластер Redis. |
| [Delete](#Delete) | Удаляет указанный кластер Redis. |
| [Start](#Start) | Запускает указанный кластер Redis. |
| [Stop](#Stop) | Останавливает указанный кластер Redis. |
| [Move](#Move) | Перемещает кластер Redis в указанный каталог. |
| [Backup](#Backup) | Создает резервную копию для указанного кластера Redis. |
| [Restore](#Restore) | Создает новый кластер Redis с использованием указанной резервной копии. |
| [StartFailover](#StartFailover) | Запускает ручное переключение мастера для указанного кластера Redis. |
| [ListLogs](#ListLogs) | Получает логи для указанного кластера Redis. |
| [ListOperations](#ListOperations) | Возвращает список операций для указанного кластера. |
| [ListBackups](#ListBackups) | Получает список доступных резервных копий для указанного кластера Redis. |
| [ListHosts](#ListHosts) | Получает список хостов для указанного кластера. |
| [AddHosts](#AddHosts) | Создает новые хосты для кластера. |
| [DeleteHosts](#DeleteHosts) | Удаляет указанные хосты кластера. |
| [GetShard](#GetShard) | Возвращает указанный шард. |
| [ListShards](#ListShards) | Получает список шардов. |
| [AddShard](#AddShard) | Создает новый шард. |
| [DeleteShard](#DeleteShard) | Удаляет указанный шард. |
| [Rebalance](#Rebalance) | Перебалансирует кластер. |

## Вызовы ClusterService {#calls}

## Get {#Get}

Возвращает указанный кластер Redis. <br>Чтобы получить список доступных резервных копий Redis, используйте запрос [List](#List).

**rpc Get ([GetClusterRequest](#GetClusterRequest)) returns ([Cluster](#Cluster))**

### GetClusterRequest {#GetClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор возвращаемого кластера Redis. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.


### Cluster {#Cluster}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера Redis. Этот идентификатор генерирует MDB при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер Redis. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера Redis. Имя уникально в рамках каталога. Длина имени должна быть от 3 до 63 символов. 
description | **string**<br>Описание кластера Redis. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера Redis в виде пар ``key:value``. Максимум 64 на кластер. 
environment | enum **Environment**<br>Среда развертывания кластера Redis. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring)**<br>Описание систем мониторинга, относящихся к данному кластеру Redis. 
config | **[ClusterConfig](#ClusterConfig)**<br>Конфигурация кластера Redis. 
network_id | **string**<br> 
health | enum **Health**<br>Агрегированная работоспособность кластера. <ul><li>`HEALTH_UNKNOWN`: Хост находится в неизвестном состоянии (у нас нет данных)</li><li>`ALIVE`: Кластер жив и здоров (все хосты живы)</li><li>`DEAD`: Кластер не работает и не может выполнять свои основные функции</li><li>`DEGRADED`: Кластер частично жив (может выполнять некоторые из своих основных функций)</li><ul/>
status | enum **Status**<br>Состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно</li><li>`CREATING`: Кластер создается</li><li>`RUNNING`: Кластер работает нормально</li><li>`ERROR`: Кластер отказал.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>
sharded | **bool**<br>Включение/выключение режима Redis Cluster. 


### Monitoring {#Monitoring}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для кластера Redis. 


### ClusterConfig {#ClusterConfig}

Поле | Описание
--- | ---
version | **string**<br>Версия серверного программного обеспечения Redis. 
redis_config | **oneof:** `redis_config_5_0`<br>Конфигурация для серверов Redis в кластере.
&nbsp;&nbsp;redis_config_5_0 | **[config.RedisConfigSet5_0](#RedisConfigSet5_0)**<br>Конфигурация сервера Redis 5.0. 
resources | **[Resources](#Resources)**<br>Ресурсы, выделенные хостам Redis. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access)**<br>Политика доступа к БД 


### Resources {#Resources}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [документации](/docs/managed-redis/concepts/instance-types). 
disk_size | **int64**<br>Объем хранилища, доступного хосту, в байтах. 


### Access {#Access}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить доступ для DataLens 


## List {#List}

Возвращает список кластеров Redis, принадлежащих указанному каталогу.

**rpc List ([ListClustersRequest](#ListClustersRequest)) returns ([ListClustersResponse](#ListClustersResponse))**

### ListClustersRequest {#ListClustersRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога, для которого нужно получить список кластеров Redis. Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListClustersResponse.next_page_token](#ListClustersResponse), которое можно использовать для получения следующей страницы. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListClustersResponse.next_page_token](#ListClustersResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br><ol><li>Имя поля. В настоящее время фильтрацию можно использовать только с полем [Cluster.name](#Cluster1). </li><li>Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. </li><li>Значение. Должен содержать от 3 до 63 символов и соответствовать регулярному выражению `^[a-z]([-a-z0-9]{,61}[a-z0-9])?$`.</li></ol> Максимальная длина строки в символах — 1000.


### ListClustersResponse {#ListClustersResponse}

Поле | Описание
--- | ---
clusters[] | **[Cluster](#Cluster1)**<br>Список кластеров Redis. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListClustersRequest.page_size](#ListClustersRequest), используйте `next_page_token` в качестве значения параметра [ListClustersRequest.page_token](#ListClustersRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Cluster {#Cluster1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера Redis. Этот идентификатор генерирует MDB при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер Redis. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера Redis. Имя уникально в рамках каталога. Длина имени должна быть от 3 до 63 символов. 
description | **string**<br>Описание кластера Redis. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера Redis в виде пар ``key:value``. Максимум 64 на кластер. 
environment | enum **Environment**<br>Среда развертывания кластера Redis. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring1)**<br>Описание систем мониторинга, относящихся к данному кластеру Redis. 
config | **[ClusterConfig](#ClusterConfig1)**<br>Конфигурация кластера Redis. 
network_id | **string**<br> 
health | enum **Health**<br>Агрегированная работоспособность кластера. <ul><li>`HEALTH_UNKNOWN`: Хост находится в неизвестном состоянии (у нас нет данных)</li><li>`ALIVE`: Кластер жив и здоров (все хосты живы)</li><li>`DEAD`: Кластер не работает и не может выполнять свои основные функции</li><li>`DEGRADED`: Кластер частично жив (может выполнять некоторые из своих основных функций)</li><ul/>
status | enum **Status**<br>Состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно</li><li>`CREATING`: Кластер создается</li><li>`RUNNING`: Кластер работает нормально</li><li>`ERROR`: Кластер отказал.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>
sharded | **bool**<br>Включение/выключение режима Redis Cluster. 


### Monitoring {#Monitoring1}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для кластера Redis. 


### ClusterConfig {#ClusterConfig1}

Поле | Описание
--- | ---
version | **string**<br>Версия серверного программного обеспечения Redis. 
redis_config | **oneof:** `redis_config_5_0`<br>Конфигурация для серверов Redis в кластере.
&nbsp;&nbsp;redis_config_5_0 | **[config.RedisConfigSet5_0](#RedisConfigSet5_0)**<br>Конфигурация сервера Redis 5.0. 
resources | **[Resources](#Resources1)**<br>Ресурсы, выделенные хостам Redis. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access1)**<br>Политика доступа к БД 


### Resources {#Resources1}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [документации](/docs/managed-redis/concepts/instance-types). 
disk_size | **int64**<br>Объем хранилища, доступного хосту, в байтах. 


### Access {#Access1}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить доступ для DataLens 


## Create {#Create}

Создает кластер Redis в указанном каталоге.

**rpc Create ([CreateClusterRequest](#CreateClusterRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateClusterMetadata](#CreateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster2)<br>

### CreateClusterRequest {#CreateClusterRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога, в котором нужно создать кластер Redis. Максимальная длина строки в символах — 50.
name | **string**<br>Обязательное поле. Имя кластера Redis. Имя должно быть уникальным в каталоге. Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.
description | **string**<br>Описание кластера Redis. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Пользовательские метки для кластера Redis в виде пар ``key:value``. Максимум 64 на кластер. Например, "project": "mvp" или "source": "dictionary". Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Максимальная длина строки в символах для каждого ключа — 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
environment | **[Cluster.Environment](#Cluster2)**<br>Обязательное поле. Среда развертывания кластера Redis. 
config_spec | **[ConfigSpec](#ConfigSpec)**<br>Обязательное поле. Конфигурация и ресурсы для хостов, которые должны быть созданы для кластера Redis. 
host_specs[] | **[HostSpec](#HostSpec)**<br>Конфигурации для отдельных хостов, которые должны быть созданы для кластера Redis. Количество элементов должно быть больше 0.
network_id | **string**<br>Обязательное поле. Идентификатор сети, в которой нужно создать кластер. Максимальная длина строки в символах — 50.
sharded | **bool**<br>Включение/выключение режима Redis Cluster. 


### ConfigSpec {#ConfigSpec}

Поле | Описание
--- | ---
version | **string**<br>Версия Redis, используемая в кластере. Единственное возможное значение — `5.0`. 
redis_spec | **oneof:** `redis_config_5_0`<br>Конфигурация кластера Redis.
&nbsp;&nbsp;redis_config_5_0 | **[config.RedisConfig5_0](#RedisConfig5_0)**<br>Конфигурация кластера Redis. 
resources | **[Resources](#Resources2)**<br>Ресурсы, выделенные хостам Redis. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access2)**<br>Политика доступа к БД 


### Resources {#Resources2}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [документации](/docs/managed-redis/concepts/instance-types). 
disk_size | **int64**<br>Объем хранилища, доступного хосту, в байтах. 


### Access {#Access2}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить доступ для DataLens 


### HostSpec {#HostSpec}

Поле | Описание
--- | ---
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится хост. Чтобы получить список доступных зон, используйте запрос [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List). 
subnet_id | **string**<br>Идентификатор подсети, к которой должен принадлежать хост. Эта подсеть должна быть частью сети, к которой принадлежит кластер. Идентификатор сети задан в поле [Cluster.network_id](#Cluster2). 
shard_name | **string**<br>Идентификатор шарда Redis, которому принадлежит хост. Чтобы получить идентификатор шарда, используйте запрос [ClusterService.ListShards](#ListShards). Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.


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
cluster_id | **string**<br>Идентификатор создаваемого кластера Redis. 


### Cluster {#Cluster2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера Redis. Этот идентификатор генерирует MDB при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер Redis. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера Redis. Имя уникально в рамках каталога. Длина имени должна быть от 3 до 63 символов. 
description | **string**<br>Описание кластера Redis. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера Redis в виде пар ``key:value``. Максимум 64 на кластер. 
environment | enum **Environment**<br>Среда развертывания кластера Redis. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring2)**<br>Описание систем мониторинга, относящихся к данному кластеру Redis. 
config | **[ClusterConfig](#ClusterConfig2)**<br>Конфигурация кластера Redis. 
network_id | **string**<br> 
health | enum **Health**<br>Агрегированная работоспособность кластера. <ul><li>`HEALTH_UNKNOWN`: Хост находится в неизвестном состоянии (у нас нет данных)</li><li>`ALIVE`: Кластер жив и здоров (все хосты живы)</li><li>`DEAD`: Кластер не работает и не может выполнять свои основные функции</li><li>`DEGRADED`: Кластер частично жив (может выполнять некоторые из своих основных функций)</li><ul/>
status | enum **Status**<br>Состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно</li><li>`CREATING`: Кластер создается</li><li>`RUNNING`: Кластер работает нормально</li><li>`ERROR`: Кластер отказал.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>
sharded | **bool**<br>Включение/выключение режима Redis Cluster. 


### Monitoring {#Monitoring2}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для кластера Redis. 


### ClusterConfig {#ClusterConfig2}

Поле | Описание
--- | ---
version | **string**<br>Версия серверного программного обеспечения Redis. 
redis_config | **oneof:** `redis_config_5_0`<br>Конфигурация для серверов Redis в кластере.
&nbsp;&nbsp;redis_config_5_0 | **[config.RedisConfigSet5_0](#RedisConfigSet5_0)**<br>Конфигурация сервера Redis 5.0. 
resources | **[Resources](#Resources3)**<br>Ресурсы, выделенные хостам Redis. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access3)**<br>Политика доступа к БД 


### Resources {#Resources3}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [документации](/docs/managed-redis/concepts/instance-types). 
disk_size | **int64**<br>Объем хранилища, доступного хосту, в байтах. 


### Access {#Access3}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить доступ для DataLens 


## Update {#Update}

Изменяет указанный кластер Redis.

**rpc Update ([UpdateClusterRequest](#UpdateClusterRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateClusterMetadata](#UpdateClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster3)<br>

### UpdateClusterRequest {#UpdateClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Redis, который следует обновить. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска, которая указывает, какие поля кластера Redis должны быть изменены. 
description | **string**<br>Новое описание кластера Redis. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Пользовательские метки для кластера Redis как `` key:value `` pairs. Maximum 64 per cluster. For example, `project": "mvp" или "source": "dictionary". <br>Новый набор меток полностью заменит старый. Чтобы добавить метку, запросите текущий набор меток с помощью метода [ClusterService.Get](#Get), затем отправьте запрос [ClusterService.Update](#Update), добавив новую метку в этот набор. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Максимальная длина строки в символах для каждого ключа — 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
config_spec | **[ConfigSpec](#ConfigSpec)**<br>Новая конфигурация и ресурсы для хостов кластера. 
name | **string**<br>Новое имя кластера. Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.


### ConfigSpec {#ConfigSpec1}

Поле | Описание
--- | ---
version | **string**<br>Версия Redis, используемая в кластере. Единственное возможное значение — `5.0`. 
redis_spec | **oneof:** `redis_config_5_0`<br>Конфигурация кластера Redis.
&nbsp;&nbsp;redis_config_5_0 | **[config.RedisConfig5_0](#RedisConfig5_0)**<br>Конфигурация кластера Redis. 
resources | **[Resources](#Resources4)**<br>Ресурсы, выделенные хостам Redis. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access4)**<br>Политика доступа к БД 


### Resources {#Resources4}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [документации](/docs/managed-redis/concepts/instance-types). 
disk_size | **int64**<br>Объем хранилища, доступного хосту, в байтах. 


### Access {#Access4}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить доступ для DataLens 


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
cluster_id | **string**<br>Идентификатор изменяемого кластера Redis. 


### Cluster {#Cluster3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера Redis. Этот идентификатор генерирует MDB при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер Redis. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера Redis. Имя уникально в рамках каталога. Длина имени должна быть от 3 до 63 символов. 
description | **string**<br>Описание кластера Redis. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера Redis в виде пар ``key:value``. Максимум 64 на кластер. 
environment | enum **Environment**<br>Среда развертывания кластера Redis. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring3)**<br>Описание систем мониторинга, относящихся к данному кластеру Redis. 
config | **[ClusterConfig](#ClusterConfig3)**<br>Конфигурация кластера Redis. 
network_id | **string**<br> 
health | enum **Health**<br>Агрегированная работоспособность кластера. <ul><li>`HEALTH_UNKNOWN`: Хост находится в неизвестном состоянии (у нас нет данных)</li><li>`ALIVE`: Кластер жив и здоров (все хосты живы)</li><li>`DEAD`: Кластер не работает и не может выполнять свои основные функции</li><li>`DEGRADED`: Кластер частично жив (может выполнять некоторые из своих основных функций)</li><ul/>
status | enum **Status**<br>Состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно</li><li>`CREATING`: Кластер создается</li><li>`RUNNING`: Кластер работает нормально</li><li>`ERROR`: Кластер отказал.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>
sharded | **bool**<br>Включение/выключение режима Redis Cluster. 


### Monitoring {#Monitoring3}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для кластера Redis. 


### ClusterConfig {#ClusterConfig3}

Поле | Описание
--- | ---
version | **string**<br>Версия серверного программного обеспечения Redis. 
redis_config | **oneof:** `redis_config_5_0`<br>Конфигурация для серверов Redis в кластере.
&nbsp;&nbsp;redis_config_5_0 | **[config.RedisConfigSet5_0](#RedisConfigSet5_0)**<br>Конфигурация сервера Redis 5.0. 
resources | **[Resources](#Resources5)**<br>Ресурсы, выделенные хостам Redis. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access5)**<br>Политика доступа к БД 


### Resources {#Resources5}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [документации](/docs/managed-redis/concepts/instance-types). 
disk_size | **int64**<br>Объем хранилища, доступного хосту, в байтах. 


### Access {#Access5}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить доступ для DataLens 


## Delete {#Delete}

Удаляет указанный кластер Redis.

**rpc Delete ([DeleteClusterRequest](#DeleteClusterRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterMetadata](#DeleteClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterRequest {#DeleteClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Redis, который следует удалить. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.


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
cluster_id | **string**<br>Идентификатор удаляемого кластера Redis. 


## Start {#Start}

Запускает указанный кластер Redis.

**rpc Start ([StartClusterRequest](#StartClusterRequest)) returns ([operation.Operation](#Operation3))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartClusterMetadata](#StartClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster4)<br>

### StartClusterRequest {#StartClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Redis, который следует запустить. Максимальная длина строки в символах — 50.


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
cluster_id | **string**<br>Идентификатор кластера Redis. 


### Cluster {#Cluster4}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера Redis. Этот идентификатор генерирует MDB при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер Redis. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера Redis. Имя уникально в рамках каталога. Длина имени должна быть от 3 до 63 символов. 
description | **string**<br>Описание кластера Redis. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера Redis в виде пар ``key:value``. Максимум 64 на кластер. 
environment | enum **Environment**<br>Среда развертывания кластера Redis. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring4)**<br>Описание систем мониторинга, относящихся к данному кластеру Redis. 
config | **[ClusterConfig](#ClusterConfig4)**<br>Конфигурация кластера Redis. 
network_id | **string**<br> 
health | enum **Health**<br>Агрегированная работоспособность кластера. <ul><li>`HEALTH_UNKNOWN`: Хост находится в неизвестном состоянии (у нас нет данных)</li><li>`ALIVE`: Кластер жив и здоров (все хосты живы)</li><li>`DEAD`: Кластер не работает и не может выполнять свои основные функции</li><li>`DEGRADED`: Кластер частично жив (может выполнять некоторые из своих основных функций)</li><ul/>
status | enum **Status**<br>Состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно</li><li>`CREATING`: Кластер создается</li><li>`RUNNING`: Кластер работает нормально</li><li>`ERROR`: Кластер отказал.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>
sharded | **bool**<br>Включение/выключение режима Redis Cluster. 


### Monitoring {#Monitoring4}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для кластера Redis. 


### ClusterConfig {#ClusterConfig4}

Поле | Описание
--- | ---
version | **string**<br>Версия серверного программного обеспечения Redis. 
redis_config | **oneof:** `redis_config_5_0`<br>Конфигурация для серверов Redis в кластере.
&nbsp;&nbsp;redis_config_5_0 | **[config.RedisConfigSet5_0](#RedisConfigSet5_0)**<br>Конфигурация сервера Redis 5.0. 
resources | **[Resources](#Resources6)**<br>Ресурсы, выделенные хостам Redis. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access6)**<br>Политика доступа к БД 


### Resources {#Resources6}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [документации](/docs/managed-redis/concepts/instance-types). 
disk_size | **int64**<br>Объем хранилища, доступного хосту, в байтах. 


### Access {#Access6}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить доступ для DataLens 


## Stop {#Stop}

Останавливает указанный кластер Redis.

**rpc Stop ([StopClusterRequest](#StopClusterRequest)) returns ([operation.Operation](#Operation4))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StopClusterMetadata](#StopClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster5)<br>

### StopClusterRequest {#StopClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Redis, который следует остановить. Максимальная длина строки в символах — 50.


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
cluster_id | **string**<br>Идентификатор кластера Redis. 


### Cluster {#Cluster5}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера Redis. Этот идентификатор генерирует MDB при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер Redis. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера Redis. Имя уникально в рамках каталога. Длина имени должна быть от 3 до 63 символов. 
description | **string**<br>Описание кластера Redis. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера Redis в виде пар ``key:value``. Максимум 64 на кластер. 
environment | enum **Environment**<br>Среда развертывания кластера Redis. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring5)**<br>Описание систем мониторинга, относящихся к данному кластеру Redis. 
config | **[ClusterConfig](#ClusterConfig5)**<br>Конфигурация кластера Redis. 
network_id | **string**<br> 
health | enum **Health**<br>Агрегированная работоспособность кластера. <ul><li>`HEALTH_UNKNOWN`: Хост находится в неизвестном состоянии (у нас нет данных)</li><li>`ALIVE`: Кластер жив и здоров (все хосты живы)</li><li>`DEAD`: Кластер не работает и не может выполнять свои основные функции</li><li>`DEGRADED`: Кластер частично жив (может выполнять некоторые из своих основных функций)</li><ul/>
status | enum **Status**<br>Состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно</li><li>`CREATING`: Кластер создается</li><li>`RUNNING`: Кластер работает нормально</li><li>`ERROR`: Кластер отказал.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>
sharded | **bool**<br>Включение/выключение режима Redis Cluster. 


### Monitoring {#Monitoring5}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для кластера Redis. 


### ClusterConfig {#ClusterConfig5}

Поле | Описание
--- | ---
version | **string**<br>Версия серверного программного обеспечения Redis. 
redis_config | **oneof:** `redis_config_5_0`<br>Конфигурация для серверов Redis в кластере.
&nbsp;&nbsp;redis_config_5_0 | **[config.RedisConfigSet5_0](#RedisConfigSet5_0)**<br>Конфигурация сервера Redis 5.0. 
resources | **[Resources](#Resources7)**<br>Ресурсы, выделенные хостам Redis. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access7)**<br>Политика доступа к БД 


### Resources {#Resources7}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [документации](/docs/managed-redis/concepts/instance-types). 
disk_size | **int64**<br>Объем хранилища, доступного хосту, в байтах. 


### Access {#Access7}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить доступ для DataLens 


## Move {#Move}

Перемещает кластер Redis в указанный каталог.

**rpc Move ([MoveClusterRequest](#MoveClusterRequest)) returns ([operation.Operation](#Operation5))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[MoveClusterMetadata](#MoveClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster6)<br>

### MoveClusterRequest {#MoveClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Redis, который следует переместить. Максимальная длина строки в символах — 50.
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
cluster_id | **string**<br>Идентификатор перемещаемого кластера Redis. 
source_folder_id | **string**<br>Идентификатор исходного каталога. 
destination_folder_id | **string**<br>Идентификатор каталога, в который следует переместить кластер. 


### Cluster {#Cluster6}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера Redis. Этот идентификатор генерирует MDB при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер Redis. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера Redis. Имя уникально в рамках каталога. Длина имени должна быть от 3 до 63 символов. 
description | **string**<br>Описание кластера Redis. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера Redis в виде пар ``key:value``. Максимум 64 на кластер. 
environment | enum **Environment**<br>Среда развертывания кластера Redis. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring6)**<br>Описание систем мониторинга, относящихся к данному кластеру Redis. 
config | **[ClusterConfig](#ClusterConfig6)**<br>Конфигурация кластера Redis. 
network_id | **string**<br> 
health | enum **Health**<br>Агрегированная работоспособность кластера. <ul><li>`HEALTH_UNKNOWN`: Хост находится в неизвестном состоянии (у нас нет данных)</li><li>`ALIVE`: Кластер жив и здоров (все хосты живы)</li><li>`DEAD`: Кластер не работает и не может выполнять свои основные функции</li><li>`DEGRADED`: Кластер частично жив (может выполнять некоторые из своих основных функций)</li><ul/>
status | enum **Status**<br>Состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно</li><li>`CREATING`: Кластер создается</li><li>`RUNNING`: Кластер работает нормально</li><li>`ERROR`: Кластер отказал.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>
sharded | **bool**<br>Включение/выключение режима Redis Cluster. 


### Monitoring {#Monitoring6}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для кластера Redis. 


### ClusterConfig {#ClusterConfig6}

Поле | Описание
--- | ---
version | **string**<br>Версия серверного программного обеспечения Redis. 
redis_config | **oneof:** `redis_config_5_0`<br>Конфигурация для серверов Redis в кластере.
&nbsp;&nbsp;redis_config_5_0 | **[config.RedisConfigSet5_0](#RedisConfigSet5_0)**<br>Конфигурация сервера Redis 5.0. 
resources | **[Resources](#Resources8)**<br>Ресурсы, выделенные хостам Redis. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access8)**<br>Политика доступа к БД 


### Resources {#Resources8}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [документации](/docs/managed-redis/concepts/instance-types). 
disk_size | **int64**<br>Объем хранилища, доступного хосту, в байтах. 


### Access {#Access8}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить доступ для DataLens 


## Backup {#Backup}

Создает резервную копию для указанного кластера Redis.

**rpc Backup ([BackupClusterRequest](#BackupClusterRequest)) returns ([operation.Operation](#Operation6))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[BackupClusterMetadata](#BackupClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster7)<br>

### BackupClusterRequest {#BackupClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Redis для резервного копирования. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.


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
cluster_id | **string**<br>Идентификатор кластера Redis, для которого выполняется резервное копирование. 


### Cluster {#Cluster7}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера Redis. Этот идентификатор генерирует MDB при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер Redis. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера Redis. Имя уникально в рамках каталога. Длина имени должна быть от 3 до 63 символов. 
description | **string**<br>Описание кластера Redis. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера Redis в виде пар ``key:value``. Максимум 64 на кластер. 
environment | enum **Environment**<br>Среда развертывания кластера Redis. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring7)**<br>Описание систем мониторинга, относящихся к данному кластеру Redis. 
config | **[ClusterConfig](#ClusterConfig7)**<br>Конфигурация кластера Redis. 
network_id | **string**<br> 
health | enum **Health**<br>Агрегированная работоспособность кластера. <ul><li>`HEALTH_UNKNOWN`: Хост находится в неизвестном состоянии (у нас нет данных)</li><li>`ALIVE`: Кластер жив и здоров (все хосты живы)</li><li>`DEAD`: Кластер не работает и не может выполнять свои основные функции</li><li>`DEGRADED`: Кластер частично жив (может выполнять некоторые из своих основных функций)</li><ul/>
status | enum **Status**<br>Состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно</li><li>`CREATING`: Кластер создается</li><li>`RUNNING`: Кластер работает нормально</li><li>`ERROR`: Кластер отказал.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>
sharded | **bool**<br>Включение/выключение режима Redis Cluster. 


### Monitoring {#Monitoring7}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для кластера Redis. 


### ClusterConfig {#ClusterConfig7}

Поле | Описание
--- | ---
version | **string**<br>Версия серверного программного обеспечения Redis. 
redis_config | **oneof:** `redis_config_5_0`<br>Конфигурация для серверов Redis в кластере.
&nbsp;&nbsp;redis_config_5_0 | **[config.RedisConfigSet5_0](#RedisConfigSet5_0)**<br>Конфигурация сервера Redis 5.0. 
resources | **[Resources](#Resources9)**<br>Ресурсы, выделенные хостам Redis. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access9)**<br>Политика доступа к БД 


### Resources {#Resources9}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [документации](/docs/managed-redis/concepts/instance-types). 
disk_size | **int64**<br>Объем хранилища, доступного хосту, в байтах. 


### Access {#Access9}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить доступ для DataLens 


## Restore {#Restore}

Создает новый кластер Redis с использованием указанной резервной копии.

**rpc Restore ([RestoreClusterRequest](#RestoreClusterRequest)) returns ([operation.Operation](#Operation7))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RestoreClusterMetadata](#RestoreClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster8)<br>

### RestoreClusterRequest {#RestoreClusterRequest}

Поле | Описание
--- | ---
backup_id | **string**<br>Обязательное поле. Идентификатор резервной копии, из которой следует создать кластер. Чтобы получить идентификатор резервной копии, используйте запрос [ClusterService.ListBackups](#ListBackups). 
name | **string**<br>Обязательное поле. Имя нового кластера Redis. Имя должно быть уникальным в каталоге. Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.
description | **string**<br>Описание нового кластера Redis. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Пользовательские метки для кластера Redis как `` key:value `` pairs. Maximum 64 per cluster. For example, `project": "mvp" или "source": "dictionary". Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Максимальная длина строки в символах для каждого ключа — 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
environment | **[Cluster.Environment](#Cluster8)**<br>Обязательное поле. Среда развертывания для нового кластера Redis. 
config_spec | **[ConfigSpec](#ConfigSpec)**<br>Обязательное поле. Конфигурация для создаваемого кластера Redis. 
host_specs[] | **[HostSpec](#HostSpec)**<br>Конфигурации для хостов Redis, которые должны быть созданы для кластера, создаваемого из резервной копии. Количество элементов должно быть больше 0.
network_id | **string**<br>Обязательное поле. Идентификатор сети, в которой нужно создать кластер. Максимальная длина строки в символах — 50.
folder_id | **string**<br>Идентификатор каталога, в котором нужно создать кластер Redis. Максимальная длина строки в символах — 50.


### ConfigSpec {#ConfigSpec2}

Поле | Описание
--- | ---
version | **string**<br>Версия Redis, используемая в кластере. Единственное возможное значение — `5.0`. 
redis_spec | **oneof:** `redis_config_5_0`<br>Конфигурация кластера Redis.
&nbsp;&nbsp;redis_config_5_0 | **[config.RedisConfig5_0](#RedisConfig5_0)**<br>Конфигурация кластера Redis. 
resources | **[Resources](#Resources10)**<br>Ресурсы, выделенные хостам Redis. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access10)**<br>Политика доступа к БД 


### Resources {#Resources10}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [документации](/docs/managed-redis/concepts/instance-types). 
disk_size | **int64**<br>Объем хранилища, доступного хосту, в байтах. 


### Access {#Access10}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить доступ для DataLens 


### HostSpec {#HostSpec1}

Поле | Описание
--- | ---
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится хост. Чтобы получить список доступных зон, используйте запрос [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List). 
subnet_id | **string**<br>Идентификатор подсети, к которой должен принадлежать хост. Эта подсеть должна быть частью сети, к которой принадлежит кластер. Идентификатор сети задан в поле [Cluster.network_id](#Cluster8). 
shard_name | **string**<br>Идентификатор шарда Redis, которому принадлежит хост. Чтобы получить идентификатор шарда, используйте запрос [ClusterService.ListShards](#ListShards). Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.


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
cluster_id | **string**<br>Идентификатор нового кластера Redis, создаваемого из резервной копии. 
backup_id | **string**<br>Идентификатор резервной копии, используемой для создания кластера. 


### Cluster {#Cluster8}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера Redis. Этот идентификатор генерирует MDB при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер Redis. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера Redis. Имя уникально в рамках каталога. Длина имени должна быть от 3 до 63 символов. 
description | **string**<br>Описание кластера Redis. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера Redis в виде пар ``key:value``. Максимум 64 на кластер. 
environment | enum **Environment**<br>Среда развертывания кластера Redis. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring8)**<br>Описание систем мониторинга, относящихся к данному кластеру Redis. 
config | **[ClusterConfig](#ClusterConfig8)**<br>Конфигурация кластера Redis. 
network_id | **string**<br> 
health | enum **Health**<br>Агрегированная работоспособность кластера. <ul><li>`HEALTH_UNKNOWN`: Хост находится в неизвестном состоянии (у нас нет данных)</li><li>`ALIVE`: Кластер жив и здоров (все хосты живы)</li><li>`DEAD`: Кластер не работает и не может выполнять свои основные функции</li><li>`DEGRADED`: Кластер частично жив (может выполнять некоторые из своих основных функций)</li><ul/>
status | enum **Status**<br>Состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно</li><li>`CREATING`: Кластер создается</li><li>`RUNNING`: Кластер работает нормально</li><li>`ERROR`: Кластер отказал.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>
sharded | **bool**<br>Включение/выключение режима Redis Cluster. 


### Monitoring {#Monitoring8}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для кластера Redis. 


### ClusterConfig {#ClusterConfig8}

Поле | Описание
--- | ---
version | **string**<br>Версия серверного программного обеспечения Redis. 
redis_config | **oneof:** `redis_config_5_0`<br>Конфигурация для серверов Redis в кластере.
&nbsp;&nbsp;redis_config_5_0 | **[config.RedisConfigSet5_0](#RedisConfigSet5_0)**<br>Конфигурация сервера Redis 5.0. 
resources | **[Resources](#Resources11)**<br>Ресурсы, выделенные хостам Redis. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access11)**<br>Политика доступа к БД 


### Resources {#Resources11}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [документации](/docs/managed-redis/concepts/instance-types). 
disk_size | **int64**<br>Объем хранилища, доступного хосту, в байтах. 


### Access {#Access11}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить доступ для DataLens 


## StartFailover {#StartFailover}

Запускает ручное переключение мастера для указанного кластера Redis.

**rpc StartFailover ([StartClusterFailoverRequest](#StartClusterFailoverRequest)) returns ([operation.Operation](#Operation8))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[StartClusterFailoverMetadata](#StartClusterFailoverMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster9)<br>

### StartClusterFailoverRequest {#StartClusterFailoverRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Redis, в котором следует переключить мастер. Максимальная длина строки в символах — 50.


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
cluster_id | **string**<br>Идентификатор кластера Redis, для которого будет инициировано переключение мастера. 


### Cluster {#Cluster9}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера Redis. Этот идентификатор генерирует MDB при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер Redis. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера Redis. Имя уникально в рамках каталога. Длина имени должна быть от 3 до 63 символов. 
description | **string**<br>Описание кластера Redis. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера Redis в виде пар ``key:value``. Максимум 64 на кластер. 
environment | enum **Environment**<br>Среда развертывания кластера Redis. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring9)**<br>Описание систем мониторинга, относящихся к данному кластеру Redis. 
config | **[ClusterConfig](#ClusterConfig9)**<br>Конфигурация кластера Redis. 
network_id | **string**<br> 
health | enum **Health**<br>Агрегированная работоспособность кластера. <ul><li>`HEALTH_UNKNOWN`: Хост находится в неизвестном состоянии (у нас нет данных)</li><li>`ALIVE`: Кластер жив и здоров (все хосты живы)</li><li>`DEAD`: Кластер не работает и не может выполнять свои основные функции</li><li>`DEGRADED`: Кластер частично жив (может выполнять некоторые из своих основных функций)</li><ul/>
status | enum **Status**<br>Состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно</li><li>`CREATING`: Кластер создается</li><li>`RUNNING`: Кластер работает нормально</li><li>`ERROR`: Кластер отказал.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>
sharded | **bool**<br>Включение/выключение режима Redis Cluster. 


### Monitoring {#Monitoring9}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для кластера Redis. 


### ClusterConfig {#ClusterConfig9}

Поле | Описание
--- | ---
version | **string**<br>Версия серверного программного обеспечения Redis. 
redis_config | **oneof:** `redis_config_5_0`<br>Конфигурация для серверов Redis в кластере.
&nbsp;&nbsp;redis_config_5_0 | **[config.RedisConfigSet5_0](#RedisConfigSet5_0)**<br>Конфигурация сервера Redis 5.0. 
resources | **[Resources](#Resources12)**<br>Ресурсы, выделенные хостам Redis. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access12)**<br>Политика доступа к БД 


### Resources {#Resources12}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [документации](/docs/managed-redis/concepts/instance-types). 
disk_size | **int64**<br>Объем хранилища, доступного хосту, в байтах. 


### Access {#Access12}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить доступ для DataLens 


## ListLogs {#ListLogs}

Получает логи для указанного кластера Redis.

**rpc ListLogs ([ListClusterLogsRequest](#ListClusterLogsRequest)) returns ([ListClusterLogsResponse](#ListClusterLogsResponse))**

### ListClusterLogsRequest {#ListClusterLogsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Redis, для которого следует запросить логи. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
column_filter[] | **string**<br>Столбцы из таблицы логов для запроса. Если столбцы не указаны, записи логов возвращаются целиком. 
service_type | enum **ServiceType**<br> <ul><li>`REDIS`: Логи работы Redis.</li><ul/>
from_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Начало периода, для которого следует запросить логи, в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
to_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Конец периода, для которого следует запросить логи, в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse), которое можно использовать для получения следующей страницы. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListClusterLogsResponse.next_page_token](#ListClusterLogsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


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

Возвращает список операций для указанного кластера.

**rpc ListOperations ([ListClusterOperationsRequest](#ListClusterOperationsRequest)) returns ([ListClusterOperationsResponse](#ListClusterOperationsResponse))**

### ListClusterOperationsRequest {#ListClusterOperationsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Redis, для которого запрашивается список операций. Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse), которое можно использовать для получения следующей страницы. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListClusterOperationsResponse.next_page_token](#ListClusterOperationsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListClusterOperationsResponse {#ListClusterOperationsResponse}

Поле | Описание
--- | ---
operations[] | **[operation.Operation](#Operation9)**<br>Список операций для указанного кластера Redis. 
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

Получает список доступных резервных копий для указанного кластера Redis.

**rpc ListBackups ([ListClusterBackupsRequest](#ListClusterBackupsRequest)) returns ([ListClusterBackupsResponse](#ListClusterBackupsResponse))**

### ListClusterBackupsRequest {#ListClusterBackupsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Redis. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListClusterBackupsResponse.next_page_token](#ListClusterBackupsResponse), которое можно использовать для получения следующей страницы. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListClusterBackupsResponse.next_page_token](#ListClusterBackupsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListClusterBackupsResponse {#ListClusterBackupsResponse}

Поле | Описание
--- | ---
backups[] | **[Backup](#Backup)**<br>Список резервных копий Redis. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListClusterBackupsRequest.page_size](#ListClusterBackupsRequest), используйте `next_page_token` в качестве значения параметра [ListClusterBackupsRequest.page_token](#ListClusterBackupsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Backup {#Backup}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор резервной копии. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит резервная копия. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) (т. е. когда операция резервного копирования была завершена). 
source_cluster_id | **string**<br>Идентификатор кластера Redis, для которого была создана резервная копия. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время запуска операции резервного копирования в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
source_shard_names[] | **string**<br>Имена шардов, которые использовались при создании резервной копии. 


## ListHosts {#ListHosts}

Получает список хостов для указанного кластера.

**rpc ListHosts ([ListClusterHostsRequest](#ListClusterHostsRequest)) returns ([ListClusterHostsResponse](#ListClusterHostsResponse))**

### ListClusterHostsRequest {#ListClusterHostsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Redis. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse), которое можно использовать для получения следующей страницы. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListClusterHostsResponse.next_page_token](#ListClusterHostsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListClusterHostsResponse {#ListClusterHostsResponse}

Поле | Описание
--- | ---
hosts[] | **[Host](#Host)**<br>Cписок хостов для кластера. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListClusterHostsRequest.page_size](#ListClusterHostsRequest), используйте `next_page_token` в качестве значения параметра [ListClusterHostsRequest.page_token](#ListClusterHostsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Host {#Host}

Поле | Описание
--- | ---
name | **string**<br>Имя хоста Redis. Имя хоста назначается MDB во время создания и не может быть изменено. Длина 1-63 символов. <br>Имя уникально для всех существующих хостов MDB в Яндекс.Облаке, так как оно определяет полное доменное имя (FQDN) хоста. 
cluster_id | **string**<br>Идентификатор кластера Redis. Этот идентификатор генерирует MDB при создании. 
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится хост Redis. 
subnet_id | **string**<br>Идентификатор подсети, к которой принадлежит хост. 
resources | **[Resources](#Resources13)**<br>Ресурсы, выделенные хосту Redis. 
role | enum **Role**<br>Роль хоста в кластере. <ul><li>`ROLE_UNKNOWN`: Роль хоста в кластере неизвестна.</li><li>`MASTER`: Хост является мастером в кластере Redis.</li><li>`REPLICA`: Хост является репликой в кластере Redis.</li><ul/>
health | enum **Health**<br>Код работоспособности хоста. <ul><li>`HEALTH_UNKNOWN`: Состояние хоста неизвестно.</li><li>`ALIVE`: Хозяин выполняет все свои функции нормально.</li><li>`DEAD`: Хост не работает и не может выполнять свои основные функции.</li><li>`DEGRADED`: Хост деградировал, и может выполнять только некоторые из своих основных функций.</li><ul/>
services[] | **[Service](#Service)**<br>Сервисы, предоставляемые хостом. 
shard_name | **string**<br> 


### Resources {#Resources13}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [документации](/docs/managed-redis/concepts/instance-types). 
disk_size | **int64**<br>Объем хранилища, доступного хосту, в байтах. 


### Service {#Service}

Поле | Описание
--- | ---
type | enum **Type**<br>Тип сервиса, предоставляемого хостом. <ul><li>`REDIS`: Хост — сервер Redis.</li><li>`ARBITER`: Хост предоставляет только сервис Sentinel (хост кворума).</li><li>`REDIS_CLUSTER`: Хост является узлом Redis Cluster.</li><ul/>
health | enum **Health**<br>Код состояния доступности сервера. <ul><li>`HEALTH_UNKNOWN`: Работоспособность сервера неизвестна.</li><li>`ALIVE`: Сервер работает нормально.</li><li>`DEAD`: Сервер отключен или не отвечает.</li><ul/>


## AddHosts {#AddHosts}

Создает новые хосты для кластера.

**rpc AddHosts ([AddClusterHostsRequest](#AddClusterHostsRequest)) returns ([operation.Operation](#Operation10))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddClusterHostsMetadata](#AddClusterHostsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### AddClusterHostsRequest {#AddClusterHostsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Redis, для которого следует добавить хосты. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
host_specs[] | **[HostSpec](#HostSpec)**<br>Конфигурации для хостов Redis, которые должны быть добавлены в кластер. Количество элементов должно быть больше 0.


### HostSpec {#HostSpec2}

Поле | Описание
--- | ---
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится хост. Чтобы получить список доступных зон, используйте запрос [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List). 
subnet_id | **string**<br>Идентификатор подсети, к которой должен принадлежать хост. Эта подсеть должна быть частью сети, к которой принадлежит кластер. Идентификатор сети задан в поле [Cluster.network_id](#Cluster10). 
shard_name | **string**<br>Идентификатор шарда Redis, которому принадлежит хост. Чтобы получить идентификатор шарда, используйте запрос [ClusterService.ListShards](#ListShards). Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.


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
cluster_id | **string**<br>Идентификатор кластера Redis, в который добавляются хосты. 
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
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Redis из которого следует удалить хосты. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
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
cluster_id | **string**<br>Идентификатор кластера Redis, из которого следует удалить хосты. 
host_names[] | **string**<br>Имена удаляемых хостов. 


## GetShard {#GetShard}

Возвращает указанный шард.

**rpc GetShard ([GetClusterShardRequest](#GetClusterShardRequest)) returns ([Shard](#Shard))**

### GetClusterShardRequest {#GetClusterShardRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Redis, к которому принадлежит шард. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
shard_name | **string**<br>Обязательное поле. Имя запрашиваемого шарда Redis. Чтобы получить имя шаода, используйте запрос [ClusterService.ListShards](#ListShards). Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.


### Shard {#Shard}

Поле | Описание
--- | ---
name | **string**<br>Имя шарда Redis. Имя шарда назначается пользователем при создании и не может быть изменено. Длина 1-63 символов. 
cluster_id | **string**<br>Идентификатор кластера Redis, к которому принадлежит шард. Этот идентификатор генерирует MDB при создании. 


## ListShards {#ListShards}

Получает список шардов.

**rpc ListShards ([ListClusterShardsRequest](#ListClusterShardsRequest)) returns ([ListClusterShardsResponse](#ListClusterShardsResponse))**

### ListClusterShardsRequest {#ListClusterShardsRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера redis, для которого нужно вывести список шардов. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListClusterShardsResponse.next_page_token](#ListClusterShardsResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListClusterShardsResponse.next_page_token](#ListClusterShardsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListClusterShardsResponse {#ListClusterShardsResponse}

Поле | Описание
--- | ---
shards[] | **[Shard](#Shard1)**<br>Список шардов Redis. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListClusterShardsRequest.page_size](#ListClusterShardsRequest), используйте `next_page_token` в качестве значения параметра [ListClusterShardsRequest.page_token](#ListClusterShardsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Shard {#Shard1}

Поле | Описание
--- | ---
name | **string**<br>Имя шарда Redis. Имя шарда назначается пользователем при создании и не может быть изменено. Длина 1-63 символов. 
cluster_id | **string**<br>Идентификатор кластера Redis, к которому принадлежит шард. Этот идентификатор генерирует MDB при создании. 


## AddShard {#AddShard}

Создает новый шард.

**rpc AddShard ([AddClusterShardRequest](#AddClusterShardRequest)) returns ([operation.Operation](#Operation12))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddClusterShardMetadata](#AddClusterShardMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Shard](#Shard2)<br>

### AddClusterShardRequest {#AddClusterShardRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Redis, в котором следует создать шард. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
shard_name | **string**<br>Обязательное поле. Имя шарда. Имя должно быть уникальным в пределах кластера. Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.
host_specs[] | **[HostSpec](#HostSpec)**<br>Конфигурации для хостов Redis, которые должны быть созданы вместе с шардом. Должен содержать хотя бы один элемент. Количество элементов должно быть больше 0.


### HostSpec {#HostSpec3}

Поле | Описание
--- | ---
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится хост. Чтобы получить список доступных зон, используйте запрос [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List). 
subnet_id | **string**<br>Идентификатор подсети, к которой должен принадлежать хост. Эта подсеть должна быть частью сети, к которой принадлежит кластер. Идентификатор сети задан в поле [Cluster.network_id](#Cluster10). 
shard_name | **string**<br>Идентификатор шарда Redis, которому принадлежит хост. Чтобы получить идентификатор шарда, используйте запрос [ClusterService.ListShards](#ListShards). Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.


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
cluster_id | **string**<br>Идентификатор кластера Redis, в который добавляется шард. 
shard_name | **string**<br>Имя создаваемого шарда Redis. 


### Shard {#Shard2}

Поле | Описание
--- | ---
name | **string**<br>Имя шарда Redis. Имя шарда назначается пользователем при создании и не может быть изменено. Длина 1-63 символов. 
cluster_id | **string**<br>Идентификатор кластера Redis, к которому принадлежит шард. Этот идентификатор генерирует MDB при создании. 


## DeleteShard {#DeleteShard}

Удаляет указанный шард.

**rpc DeleteShard ([DeleteClusterShardRequest](#DeleteClusterShardRequest)) returns ([operation.Operation](#Operation13))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteClusterShardMetadata](#DeleteClusterShardMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteClusterShardRequest {#DeleteClusterShardRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Redis, к которому принадлежит шард. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.
shard_name | **string**<br>Обязательное поле. Имя шарда Redis, который следует удалить. Чтобы получить имя шаода, используйте запрос [ClusterService.ListShards](#ListShards). Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.


### Operation {#Operation13}

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
cluster_id | **string**<br>Идентификатор кластера Redis, к которому принадлежит шард. 
shard_name | **string**<br>Имя удаляемого шарда Redis. 


## Rebalance {#Rebalance}

Перебалансирует кластер. Равномерно распределяет все хэш-слоты между шардами.

**rpc Rebalance ([RebalanceClusterRequest](#RebalanceClusterRequest)) returns ([operation.Operation](#Operation14))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RebalanceClusterMetadata](#RebalanceClusterMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Cluster](#Cluster10)<br>

### RebalanceClusterRequest {#RebalanceClusterRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Redis, который следует перебалансировать. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](#List). Максимальная длина строки в символах — 50.


### Operation {#Operation14}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RebalanceClusterMetadata](#RebalanceClusterMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Cluster](#Cluster10)>**<br>в случае успешного выполнения операции. 


### RebalanceClusterMetadata {#RebalanceClusterMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера Redis, для которого выполняется перебалансировка. 


### Cluster {#Cluster10}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор кластера Redis. Этот идентификатор генерирует MDB при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит кластер Redis. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя кластера Redis. Имя уникально в рамках каталога. Длина имени должна быть от 3 до 63 символов. 
description | **string**<br>Описание кластера Redis. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Пользовательские метки для кластера Redis в виде пар ``key:value``. Максимум 64 на кластер. 
environment | enum **Environment**<br>Среда развертывания кластера Redis. <ul><li>`PRODUCTION`: Стабильная среда с осторожной политикой обновления: во время регулярного обслуживания применяются только срочные исправления.</li><li>`PRESTABLE`: Среда с более агрессивной политикой обновления: новые версии развертываются независимо от обратной совместимости.</li><ul/>
monitoring[] | **[Monitoring](#Monitoring10)**<br>Описание систем мониторинга, относящихся к данному кластеру Redis. 
config | **[ClusterConfig](#ClusterConfig10)**<br>Конфигурация кластера Redis. 
network_id | **string**<br> 
health | enum **Health**<br>Агрегированная работоспособность кластера. <ul><li>`HEALTH_UNKNOWN`: Хост находится в неизвестном состоянии (у нас нет данных)</li><li>`ALIVE`: Кластер жив и здоров (все хосты живы)</li><li>`DEAD`: Кластер не работает и не может выполнять свои основные функции</li><li>`DEGRADED`: Кластер частично жив (может выполнять некоторые из своих основных функций)</li><ul/>
status | enum **Status**<br>Состояние кластера. <ul><li>`STATUS_UNKNOWN`: Состояние кластера неизвестно</li><li>`CREATING`: Кластер создается</li><li>`RUNNING`: Кластер работает нормально</li><li>`ERROR`: Кластер отказал.</li><li>`UPDATING`: Кластер изменяется.</li><li>`STOPPING`: Кластер останавливается.</li><li>`STOPPED`: Кластер остановлен.</li><li>`STARTING`: Кластер запускается.</li><ul/>
sharded | **bool**<br>Включение/выключение режима Redis Cluster. 


### Monitoring {#Monitoring10}

Поле | Описание
--- | ---
name | **string**<br>Название системы мониторинга. 
description | **string**<br>Описание системы мониторинга. 
link | **string**<br>Ссылка на графики системы мониторинга для кластера Redis. 


### ClusterConfig {#ClusterConfig10}

Поле | Описание
--- | ---
version | **string**<br>Версия серверного программного обеспечения Redis. 
redis_config | **oneof:** `redis_config_5_0`<br>Конфигурация для серверов Redis в кластере.
&nbsp;&nbsp;redis_config_5_0 | **[config.RedisConfigSet5_0](#RedisConfigSet5_0)**<br>Конфигурация сервера Redis 5.0. 
resources | **[Resources](#Resources14)**<br>Ресурсы, выделенные хостам Redis. 
backup_window_start | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**<br>Время запуска ежедневного резервного копирования, в часовом поясе UTC. 
access | **[Access](#Access13)**<br>Политика доступа к БД 


### Resources {#Resources14}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Идентификатор набора вычислительных ресурсов, доступных хосту (процессор, память и т. д.). Все доступные наборы ресурсов перечислены в [документации](/docs/managed-redis/concepts/instance-types). 
disk_size | **int64**<br>Объем хранилища, доступного хосту, в байтах. 


### Access {#Access13}

Поле | Описание
--- | ---
data_lens | **bool**<br>Разрешить доступ для DataLens 


