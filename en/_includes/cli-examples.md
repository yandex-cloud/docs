# Examples of CLI commands

Structure of CLI commands for Yandex [!KEYREF full-service-name]:

```
yc mdb <cluster | operation> <command> <arguments>
```

Examples are provided for all commands and grouped by resource.

## cluster {#cluster}

### Get {#cluster-get}

Request information about a cluster.

General format for running the `Get` command:

```
yc mdb cluster Get --clusterId=<cluster ID>
```

Sample request for cluster information:

```
yc mdb cluster Get --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe
```

The response structure is described in the API reference (see the description of the [get method](/yandex-mdb-api-ref/Cluster/get.html#responses)).

### List {#cluster-list}

Request a list of [!KEYREF service-name] clusters in the project.

Common format for running the `List` command:

```
yc mdb cluster List --projectId=<project ID> \
    [--pageSize=<number of clusters per page]
    [--pageToken=<page token received in the response to the previous List command>]
    [--orderBy=<flag for sorting results>]
```

Sample request for a list of clusters sorted by environment:

```
yc mdb cluster List --projectId=b795fc21-2631-49e7-9bb8-385765bf00fe \
    --orderBy=environment
```

The response structure is described in the API reference (see the description of the [get method](/yandex-mdb-api-ref/Cluster/get.html#responses)).

### Create {#cluster-create}

[!KEYREF PG]:

```
yc mdb cluster Create --projectId <project ID> \
    --name <cluster name> \
    --type postgresql_cluster \
    --environment prestable \
    --infrastructureOptions '{"instanceType": "[!KEYREF db-small]", "volumeSize": 10737418240, "hosts": [{"options": {"geo": "[!KEYREF ru-central1-a]"}}, {"options": {"geo": "[!KEYREF ru-central1-b]"}}, {"options": {"geo": "[!KEYREF ru-central1-c]"}}]}' \
    --databaseOptions '{"users": [{"name": "<DB user name>", "options": {"password": "<DB user password>"}}], "databases": [{"name": "<DB name>", "options": {"owner": "<username of DB owner>"}}]}'
```

[!KEYREF CH]:

```
yc mdb cluster Create --projectId <project ID> \
    --name <cluster name> \
    --type clickhouse_cluster \
    --environment prestable \
    --infrastructureOptions '{"instanceType": "[!KEYREF db-small]", "volumeSize": 10737418240, "hosts": [{"options": {"geo": "[!KEYREF ru-central1-a]"}}, {"options": {"geo": "[!KEYREF ru-central1-b]"}}]}' \
    --databaseOptions '{"users": [{"name": "<DB user name>", "options": {"password": "<DB user password>"}}], "databases": [{"name": "<DB name>", "options": {"owner": "<username of DB owner>"}}]}'
```

### Delete {#cluster-delete}

Permanently delete the cluster and all backups.

General format for running the `Delete` command:

```
yc mdb cluster Delete --clusterId=<cluster ID>
```

Example of cluster deletion:

```
yc mdb cluster Delete --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe
```

### Restore {#cluster-restore}

Create a new cluster from a certain backup.

Common format for running the `Restore` command:

```
yc mdb cluster Restore --clusterId=<cluster ID> \
    -- environment=<environment> \
    --name=<cluster name> \
    --restorePoint=<description of the backup used>] \
    --infrastructure_options=<storage capacity, list of instances> \
    --database_options=<DB properties> \
    [--description=<cluster description>
```

Example of restoring a [!KEYREF PG] cluster from a backup:

```
yc mdb cluster Restore --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe \
    --environment=prestable \
    --name=restored_cluster \
    --restorePoint '{"backupId": "base_10000001000000000000010E_D_00000001000000000000000C", "time": "2018-04-17T01:00:00+03:00"}' \
    --infrastructureOptions '{"instanceType": "[!KEYREF db-small]", "volumeSize": 10737418240, "hosts": [{"options": {"geo": "[!KEYREF ru-central1-a]"}}, {"options": {"geo": "[!KEYREF ru-central1-b]"}}, {"options": {"geo": "[!KEYREF ru-central1-c]"}}]}' \
    --databaseOptions '{"databases": [{"name": "restored_dbname"}]}'
```

Example of restoring a [!KEYREF CH] cluster from a backup:

```
yc mdb cluster Restore --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe \
    --environment=prestable \
    --name=restored_cluster \
    --restorePoint '{"backupId": "base_10000001000000000000010E_D_00000001000000000000000C", "time": "2018-04-17T01:00:00+03:00"}' \
    --infrastructureOptions '{"instanceType": "[!KEYREF db-small]", "volumeSize": 10737418240, "hosts": [{"options": {"geo": "[!KEYREF ru-central1-a]"}}, {"options": {"geo": "[!KEYREF ru-central1-b]"}}]}' \
    --databaseOptions '{"databases": [{"name": "restored_dbname"}]}'
```

### UpdateOptions {#cluster-update-options}

Change the settings of an existing cluster. This command can only be used to change the database settings. To change the user settings, use the command [[!TITLE #cluster-update-user]](#cluster-update-user), while the DB instances can only be added ([[!TITLE #cluster-add-host]](#cluster-add-host)) or deleted ([[!TITLE #cluster-remove-host]](#cluster-remove-host)).

Common format for running the `UpdateOptions` command:

```
yc mdb cluster UpdateOptions --clusterId=<cluster ID> \
    [--databaseOptions <JSON document with DB settings>]
```

Example of changing database settings (maximum number of simultaneous connections):

```
yc mdb cluster UpdateOptions --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe \
    --databaseOptions '{"postgres": {"max_connections": 200}}'
```

Example of changing database settings (connection lifetime in the standby mode):

```
yc mdb cluster UpdateOptions --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe \
    --databaseOptions '{"clickhouse": {"keep_alive_timeout": 10}}'
```

### GetLogs {#cluster-getlogs}

Request logs for a cluster.

Common format for running the `GetLogs` command:

```
yc mdb cluster GetLogs --clusterId=<cluster ID> \
    --service [postgres | pgbouncer | clickhouse] \
    --columns <required log table columns> \
    --fromTime <start of the period for which logs are requested> \
    --toTime <end of the period> \
    --pageSize <number of log lines per page> \
    --pageToken <page ID received in response to the previous GetLogs request> \
    --orderBy <flag for sorting results>
```

Sample request for logs for the [!KEYREF PG] DB over the past hour excluding the last 20 minutes:

```
yc mdb cluster GetLogs --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe \
--service postgres \
--columns "ms,query,user_name" \
--fromTime -3600 \
--toTime -1200
```

### AddExtension {#cluster-add-extension}

Common format for running the `AddExtension` command:

```
yc mdb cluster AddExtension --clusterId=<cluster ID> \
    --name <extension name>
```

Example of enabling the [!KEYREF PG] extension:

```
yc mdb cluster AddExtension --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe \
    --name pg_trgm
```

### RemoveExtension {#cluster-remove-extension}

Common format for running the `RemoveExtension` command:

```
yc mdb cluster RemoveExtension --clusterId=<luster ID> \
    --name <extension name>
```

Example of enabling the [!KEYREF PG] extension:

```
yc mdb cluster RemoveExtension --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe \
    --name pg_trgm
```

### ListExtensions {#cluster-list-extensions}

Common format for running the `ListExtensions` command:

```
yc mdb cluster ListExtensions --clusterId=<cluster ID> \
    [--orderBy=
```

Sample request for a list of [!KEYREF PG] extensions:

```
yc mdb cluster ListExtensions --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe \
    --orderBy=name
```

### AddUser {#cluster-add-user}

Common format for running the `AddUser` command:

```
yc mdb cluster AddUser --clusterId=<cluster ID> \
    --name <user name>
    --options <DB access settings>
```

Example of creating a `test-user` for the `db_name` database with a limit of 10 simultaneous connections:

```
yc mdb cluster AddUser --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe \
    --name test-user \
    --options '{"databases": ["db_name"], "password": "P@ssWordP@ssWordP@ssWordP@ssWord", "conn_limit": 10}'
```

Example of creating a `test-user` for the `db_name` database:

```
yc mdb cluster AddUser --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe \
    --name test-user
    --options '{"databases": ["db_name"], "password": "P@ssWordP@ssWordP@ssWordP@ssWord"}'
```

### UpdateUser {#cluster-update-user}

Common format for running the `UpdateUser` command:

```
yc mdb cluster UpdateUser --clusterId=<cluster ID> \
    --name <user name>
    [--options <DB access settings>]
```

Example of changing the limit of simultaneous connections for a `test-user`:

```
yc mdb cluster UpdateUser --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe \
    --name test-user
    --options '{"conn_limit": 1}'
```

Example of changing the password of a  `test-user`:

```
yc mdb cluster UpdateUser --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe \
    --name test-user
    --options '{"password": "niceNewPassword"}'
```

### RemoveUser {#cluster-remove-user}

Common format for running the `RemoveUser` command:

```
yc mdb cluster RemoveUser --clusterId=<cluster ID> \
    --name <user name>
```

Example of deleting a `test-user`:

```
yc mdb cluster RemoveUser --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe \
    --name test-user
```

### ListUsers {#cluster-list-users}

Common format for running the `ListUsers` command:

```
yc mdb cluster ListUsers --clusterId=<cluster ID> \
    [--orderBy <user name>]
```

Sample request for a list of DB users:

```
yc mdb cluster ListUsers --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe \
    --orderBy name
```

### AddHost {#cluster-add-host}

To add a DB instance for a cluster.

Common format for running the `AddHost` command:

```
yc mdb cluster AddHost --clusterId=<cluster ID> \
    --options '{"geo": "<availability zone name>"}'
```

Example of adding an instance in a zone :

```
yc mdb cluster AddHost --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe \
    --options '{"geo": "[!KEYREF ru-central1-b]"}'
```

### RemoveHost {#cluster-remove-host}

Delete a DB instance in a cluster.

Common format for running the `RemoveHost` command:

```
yc mdb cluster RemoveHost --clusterId=<cluster ID> \
    --name=<DB instance network name>
```

Example of deleting an instance:

```
yc mdb cluster RemoveHost --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe \
    --name=[!KEYREF ru-central1-b]-rrri3tjl1on1yepu1z.prod.cloud.yandex.net
```

### ListBackups {#cluster-list-backups}

Common format for running the `ListBackups` command:

```
yc mdb cluster ListBackups --clusterId=<cluster ID>
```

Sample request for a list of backups:

```
yc mdb cluster ListBackups --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe
```

### CreateBackup {#cluster-create-backup}

Common format for running the `CreateBackup` command:

```
yc mdb cluster CreateBackup --clusterId=<cluster ID>
```

Sample request for a list of backups:

```
yc mdb cluster CreateBackup --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe
```

### ListClusterOperations {#cluster-list-operations}

Common format for running the `ListClusterOperations` command:

```
yc mdb cluster ListClusterOperations --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe \
    [--pageSize=<number of operations per page>]
    [--pageToken=<page ID received in response to the previous ListClusterOperations request>]
```

Sample request for cluster operations:

```
yc mdb cluster ListClusterOperations --clusterId=b795fc21-2631-49e7-9bb8-385765bf00fe
```

Sample response:

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

Request information about available and used quotas of [!KEYREF service-name] resources for the project.

> [!NOTE]
>
> Квоты нужно запрашивать именно для проекта, не для кластера. Чтобы получить ID проекта,

Common format for running the `GetQuota` command:

```
yc mdb cluster GetQuota --projectId=<project ID>
```

Sample quota request:

```
yc mdb cluster GetQuota --projectId=b795fc21-2631-49e7-9bb8-385765bf00fe
```

Sample response:

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

Get the status of the operation started for a cluster.

General format for running the `Get` command:

```
yc mdb operation Get --operationId=<operation ID>
```

Sample operation status request:

```
yc mdb operation Get --operationId 178b6235-ac05-4561-8501-6dcee29a738e
```

