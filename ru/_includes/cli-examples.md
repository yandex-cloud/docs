# Примеры команд CLI

Структура команд CLI для Yandex [!KEYREF full-service-name]:

```
yc mdb <cluster | operation> <команда> <аргументы>
```

Ниже приведены примеры для всех команд, сгруппированных по ресурсам.

## cluster {#cluster}

### Get {#cluster-get}

Запросить информацию о кластере.

Общий формат вызова команды `Get`:

```
yc mdb cluster Get --clusterId=<идентификатор кластера>
```

Пример запроса информации о кластере:

```
yc mdb cluster Get --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe
```

Структура ответа описана в справочнике API, в описании [метода get](/yandex-mdb-api-ref/Cluster/get.html#responses).


### List {#cluster-list}

Запросить список кластеров [!KEYREF service-name] в проекте.

Общий формат вызова команды `List`:

```
yc mdb cluster List --projectId=<идентификатор проекта> \
    [--pageSize=<количество кластеров на странице>]
    [--pageToken=<токен страницы, полученный в ответе на предыдущую команду List>]
    [--orderBy=<признак для сортировки результатов>]
```

Пример запроса списка кластеров с сортировкой по окружению:

```
yc mdb cluster List --projectId=b795fc21-2631-49e7-9bb8-385765bf00fe \
    --orderBy=environment
```

Структура ответа описана в справочнике API, в описании [метода get](/yandex-mdb-api-ref/Cluster/get.html#responses).


### Create {#cluster-create}

[!KEYREF PG]:

```
yc mdb cluster Create --projectId <идентификатор проекта> \
    --name <имя кластера> \
    --type postgresql_cluster \
    --environment prestable \
    --infrastructureOptions '{"instanceType": "[!KEYREF db-small]", "volumeSize": 10737418240, "hosts": [{"options": {"geo": "[!KEYREF ru-central1-a]"}}, {"options": {"geo": "[!KEYREF ru-central1-b]"}}, {"options": {"geo": "[!KEYREF ru-central1-c]"}}]}' \
    --databaseOptions '{"users": [{"name": "<имя пользователя БД>", "options": {"password": "<пароль пользователя БД>"}}], "databases": [{"name": "<имя БД>", "options": {"owner": "<имя пользователя — владельца БД>"}}]}'
```

[!KEYREF CH]:

```
yc mdb cluster Create --projectId <идентификатор проекта> \
    --name <имя кластера> \
    --type clickhouse_cluster \
    --environment prestable \
    --infrastructureOptions '{"instanceType": "[!KEYREF db-small]", "volumeSize": 10737418240, "hosts": [{"options": {"geo": "[!KEYREF ru-central1-a]"}}, {"options": {"geo": "[!KEYREF ru-central1-b]"}}]}' \
    --databaseOptions '{"users": [{"name": "<имя пользователя БД>", "options": {"password": "<пароль пользователя БД>"}}], "databases": [{"name": "<имя БД>", "options": {"owner": "<имя пользователя — владельца БД>"}}]}'
```


### Delete {#cluster-delete}

Безвозвратно удалить кластер и все резервные копии.

Общий формат вызова команды `Delete`:

```
yc mdb cluster Delete --clusterId=<идентификатор кластера>
```

Пример удаления кластера:

```
yc mdb cluster Delete --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe
```


### Restore {#cluster-restore}

Создать новый кластер из определенной резервной копии.

Общий формат вызова команды `Restore`:

```
yc mdb cluster Restore --clusterId=<идентификатор кластера> \
    --environment=<окружение> \
    --name=<имя кластера> \
    --restorePoint=<описание используемой резервной копии>] \
    --infrastructure_options=<объем хранилища, список экземпляров> \
    --database_options=<свойства БД> \
    [--description=<описание кластера>
```

Пример восстановления [!KEYREF PG]-кластера из резервной копии:

```
yc mdb cluster Restore --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe \
    --environment=prestable \
    --name=restored_cluster \
    --restorePoint '{"backupId": "base_10000001000000000000010E_D_00000001000000000000000C", "time": "2018-04-17T01:00:00+03:00"}' \
    --infrastructureOptions '{"instanceType": "[!KEYREF db-small]", "volumeSize": 10737418240, "hosts": [{"options": {"geo": "[!KEYREF ru-central1-a]"}}, {"options": {"geo": "[!KEYREF ru-central1-b]"}}, {"options": {"geo": "[!KEYREF ru-central1-c]"}}]}' \
    --databaseOptions '{"databases": [{"name": "restored_dbname"}]}'
```

Пример восстановления [!KEYREF CH]-кластера из резервной копии:

```
yc mdb cluster Restore --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe \
    --environment=prestable \
    --name=restored_cluster \
    --restorePoint '{"backupId": "base_10000001000000000000010E_D_00000001000000000000000C", "time": "2018-04-17T01:00:00+03:00"}' \
    --infrastructureOptions '{"instanceType": "[!KEYREF db-small]", "volumeSize": 10737418240, "hosts": [{"options": {"geo": "[!KEYREF ru-central1-a]"}}, {"options": {"geo": "[!KEYREF ru-central1-b]"}}]}' \
    --databaseOptions '{"databases": [{"name": "restored_dbname"}]}'
```


### UpdateOptions {#cluster-update-options}

Изменить настройки существующего кластера. Этой командой можно изменить только настройки базы данных: для изменения настроек пользователей предназаначена команда [[!TITLE #cluster-update-user]](#cluster-update-user), а экземпляры БД можно только добавить ([[!TITLE #cluster-add-host]](#cluster-add-host)) или удалить ([[!TITLE #cluster-remove-host]](#cluster-remove-host)).

Общий формат вызова команды `UpdateOptions`:

```
yc mdb cluster UpdateOptions --clusterId=<идентификатор кластера> \
    [--databaseOptions <JSON-документ с настройками БД>]
```

Пример изменения настроек базы данных (максимальное количество одновременных соединений):

```
yc mdb cluster UpdateOptions --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe \
    --databaseOptions '{"postgres": {"max_connections": 200}}'
```

Пример изменения настроек базы данных (время жизни соединения в режиме ожидания):

```
yc mdb cluster UpdateOptions --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe \
    --databaseOptions '{"clickhouse": {"keep_alive_timeout": 10}}'
```


### GetLogs {#cluster-getlogs}

Запросить логи для кластера.

Общий формат вызова команды `GetLogs`:

```
yc mdb cluster GetLogs --clusterId=<идентификатор кластера> \
    --service [postgres | pgbouncer | clickhouse] \
    --columns <нужные колонки таблицы логов> \
    --fromTime <начало отрезка времени, для которого запрашиваются логи> \
    --toTime <конец отрезка времени> \
    --pageSize <количество строк лога на странице> \
    --pageToken <идентификатор страницы, полученный в ответ на предыдущий запрос GetLogs> \
    --orderBy <признак для сортировки результатов>
```

Пример запроса логов для базы данных [!KEYREF PG] за последний час за исключением последних 20 минут:

```
yc mdb cluster GetLogs --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe \
--service postgres \
--columns "ms,query,user_name" \
--fromTime -3600 \
--toTime -1200
```


### AddExtension {#cluster-add-extension}

Общий формат вызова команды `AddExtension`:

```
yc mdb cluster AddExtension --clusterId=<идентификатор кластера> \
    --name <имя расширения>
```

Пример включения [!KEYREF PG]-расширения:

```
yc mdb cluster AddExtension --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe \
    --name pg_trgm
```


### RemoveExtension {#cluster-remove-extension}

Общий формат вызова команды `RemoveExtension`:

```
yc mdb cluster RemoveExtension --clusterId=<идентификатор кластера> \
    --name <имя расширения>
```

Пример включения [!KEYREF PG]-расширения:

```
yc mdb cluster RemoveExtension --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe \
    --name pg_trgm
```


### ListExtensions {#cluster-list-extensions}

Общий формат вызова команды `ListExtensions`:

```
yc mdb cluster ListExtensions --clusterId=<идентификатор кластера> \
    [--orderBy=
```

Пример запроса списка [!KEYREF PG]-расширений:

```
yc mdb cluster ListExtensions --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe \
    --orderBy=name
```


### AddUser {#cluster-add-user}

Общий формат вызова команды `AddUser`:

```
yc mdb cluster AddUser --clusterId=<идентификатор кластера> \
    --name <имя пользователя>
    --options <настройки доступа к БД>
```

Пример создания пользователя `test-user` для базы данных `db_name` с лимитом в 10 одновременных соединений:

```
yc mdb cluster AddUser --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe \
    --name test-user \
    --options '{"databases": ["db_name"], "password": "P@ssWordP@ssWordP@ssWordP@ssWord", "conn_limit": 10}'
```

Пример создания пользователя `test-user` для базы данных `db_name`:

```
yc mdb cluster AddUser --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe \
    --name test-user
    --options '{"databases": ["db_name"], "password": "P@ssWordP@ssWordP@ssWordP@ssWord"}'
```


### UpdateUser {#cluster-update-user}

Общий формат вызова команды `UpdateUser`:

```
yc mdb cluster UpdateUser --clusterId=<идентификатор кластера> \
    --name <имя пользователя>
    [--options <настройки доступа к БД>]
```

Пример изменения лимита одновременных соединений для пользователя `test-user`:

```
yc mdb cluster UpdateUser --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe \
    --name test-user
    --options '{"conn_limit": 1}'
```

Пример изменения пароля для пользователя `test-user`:

```
yc mdb cluster UpdateUser --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe \
    --name test-user
    --options '{"password": "niceNewPassword"}'
```


### RemoveUser {#cluster-remove-user}

Общий формат вызова команды `RemoveUser`:

```
yc mdb cluster RemoveUser --clusterId=<идентификатор кластера> \
    --name <имя пользователя>
```

Пример удаления пользователя `test-user`:

```
yc mdb cluster RemoveUser --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe \
    --name test-user
```


### ListUsers {#cluster-list-users}

Общий формат вызова команды `ListUsers`:

```
yc mdb cluster ListUsers --clusterId=<идентификатор кластера> \
    [--orderBy <имя пользователя>]
```

Пример запроса списка пользователей БД:

```
yc mdb cluster ListUsers --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe \
    --orderBy name
```


### AddHost {#cluster-add-host}

Добавить экземпляр БД для кластера.

Общий формат вызова команды `AddHost`:

```
yc mdb cluster AddHost --clusterId=<идентификатор кластера> \
    --options '{"geo": "<имя зоны доступности>"}'
```

Пример добавления экземпляра в зоне :

```
yc mdb cluster AddHost --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe \
    --options '{"geo": "[!KEYREF ru-central1-b]"}'
```


### RemoveHost {#cluster-remove-host}

Удалить экземпляр БД в кластере.

Общий формат вызова команды `RemoveHost`:

```
yc mdb cluster RemoveHost --clusterId=<идентификатор кластера> \
    --name=<сетевое имя экземпляра БД>
```

Пример удаления экземпляра:

```
yc mdb cluster RemoveHost --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe \
    --name=[!KEYREF ru-central1-b]-rrri3tjl1on1yepu1z.prod.cloud.yandex.net
```


### ListBackups {#cluster-list-backups}

Общий формат вызова команды `ListBackups`:

```
yc mdb cluster ListBackups --clusterId=<идентификатор кластера>
```

Пример запроса списка резервных копий:

```
yc mdb cluster ListBackups --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe
```


### CreateBackup {#cluster-create-backup}

Общий формат вызова команды `CreateBackup`:

```
yc mdb cluster CreateBackup --clusterId=<идентификатор кластера>
```

Пример запроса списка резервных копий:

```
yc mdb cluster CreateBackup --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe
```


### ListClusterOperations {#cluster-list-operations}

Общий формат вызова команды `ListClusterOperations`:

```
yc mdb cluster ListClusterOperations --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe \
    [--pageSize=<количество операций на странице>]
    [--pageToken=<идентификатор страницы, полученный в ответ на предыдущий запрос ListClusterOperations>]
```

Пример запроса операций для кластера:

```
yc mdb cluster ListClusterOperations --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe
```

Пример ответа:

```
-----------------------------------------------------------------------------------------------------------------------
|                                                       Result                                                        |
+---------------+-----------------------------------------------------------------------------------------------------+
|  nextPageToken|  MTA/MjAxOC0wNC1xMyAxNjozNTowMi41OTUxNDIrMDM6MDA/MWVmNGNkNDYtYmQ0MS00YzBmLTk5ODctMjI5NTViZjAxNTA2   |
+---------------+-----------------------------------------------------------------------------------------------------+
||                                                    operations                                                     ||
|+---------------------------------+---------------------------------------------------------------------------------+|
||  clusterType                    |  postgresql_cluster                                                             ||
||  createdAt                      |  2018-04-17T15:08:49.146418+00:00                                               ||
||  createdBy                      |  15337b5d-f952-4b0a-804e-2806854b97c8                                           ||
||  description                    |  None                                                                           ||
||  environment                    |  prestable                                                                      ||
||  id                             |  1083495d-00f8-4865-b63f-de596a5746bd                                           ||
||  modifiedAt                     |  2018-04-17T15:14:55.932863+00:00                                               ||
||  operationType                  |  postgresql_host_create                                                         ||
||  projectId                      |  025edc32-ea54-4ba4-b995-1a935e0b198a                                           ||
||  startedAt                      |  2018-04-17T15:08:49.262540+00:00                                               ||
||  status                         |  DONE                                                                           ||
||  targetId                       |  de6a1c79-18f8-42da-a4a2-bd7b290e9623                                           ||
|+---------------------------------+---------------------------------------------------------------------------------+|
||                                                    operations                                                     ||
|+---------------------------------+---------------------------------------------------------------------------------+|
||  clusterType                    |  postgresql_cluster                                                             ||
||  createdAt                      |  2018-04-17T09:40:49.138536+00:00                                               ||
||  createdBy                      |  15337b5d-f952-4b0a-804e-2806854b97c8                                           ||
||  description                    |  None                                                                           ||
||  environment                    |  prestable                                                                      ||
||  id                             |  18ef2a5c-d60c-4a83-aaba-eb51ce43186c                                           ||
||  modifiedAt                     |  2018-04-17T10:44:26.031592+00:00                                               ||
||  operationType                  |  postgresql_cluster_modify                                                      ||
||  projectId                      |  025edc32-ea54-4ba4-b995-1a935e0b198a                                           ||
||  startedAt                      |  2018-04-17T10:42:44.698478+00:00                                               ||
||  status                         |  DONE                                                                           ||
||  targetId                       |  de6a1c79-18f8-42da-a4a2-bd7b290e9623                                           ||
|+---------------------------------+---------------------------------------------------------------------------------+|
||                                                    operations                                                     ||
|+---------------------------------+---------------------------------------------------------------------------------+|
||  clusterType                    |  postgresql_cluster                                                             ||
||  createdAt                      |  2018-04-13T13:35:02.595142+00:00                                               ||
||  createdBy                      |  15337b5d-f952-4b0a-804e-2806854b97c8                                           ||
||  description                    |  None                                                                           ||
||  environment                    |  prestable                                                                      ||
||  id                             |  2ef4cd46-bd41-4c0f-9987-22955bf01506                                           ||
||  modifiedAt                     |  2018-04-13T13:45:06.486300+00:00                                               ||
||  operationType                  |  postgresql_cluster_create                                                      ||
||  projectId                      |  025edc32-ea54-4ba4-b995-1a935e0b198a                                           ||
||  startedAt                      |  2018-04-13T13:35:02.878668+00:00                                               ||
||  status                         |  DONE                                                                           ||
||  targetId                       |  de6a1c79-18f8-42da-a4a2-bd7b290e9623                                           ||
|+---------------------------------+---------------------------------------------------------------------------------+|
```


### GetQuota {#cluster-get-quota}

Запросить информацию о доступных и использованных квотах ресурсов [!KEYREF service-name] для проекта.

> [!NOTE]
>
> Квоты нужно запрашивать именно для проекта, не для кластера. Чтобы получить ID проекта, 

Общий формат вызова команды `GetQuota`:

```
yc mdb cluster GetQuota --projectId=<идентификатор проекта>
```

Пример запроса квот:

```
yc mdb cluster GetQuota --projectId=b795fc21-2631-49e7-9bb8-385765bf00fe
```

Пример ответа:

```
-----------------------------------------------------------
|                         Result                          |
+----------------+----------------------------------------+
|  clustersQuota |  2                                     |
|  clustersUsed  |  1                                     |
|  cpuQuota      |  96.0                                  |
|  cpuUsed       |  16.0                                  |
|  id            |  825edc32-ea54-4ba4-b995-1a935e0b198a  |
|  ioQuota       |  15728640000                           |
|  ioUsed        |  1048576000                            |
|  memoryQuota   |  412316860416                          |
|  memoryUsed    |  51539607552                           |
|  networkQuota  |  8053063680                            |
|  networkUsed   |  536870912                             |
|  spaceQuota    |  5153960755200                         |
|  spaceUsed     |  42949672960                           |
+----------------+----------------------------------------+
```


## operation {#operation}

### Get {#operation-get}

Получить статус операции, запущенной для кластера.

Общий формат вызова команды `Get`:

```
yc mdb operation Get --operationId=<идентификатор операции>
```

Пример запроса статуса операции:

```
yc mdb operation Get --operationId 178b6235-ac05-4561-8501-6dcee29a738e
```

