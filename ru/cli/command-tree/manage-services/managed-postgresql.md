# yc managed-postgresql

Управление [!KEYREF PG].

#### Использование команды

Синтаксис: 
 
`yc managed-postgresql <group>`

Алиасы:
  
- `yc postgresql <group>`;
- `yc postgres <group>`.

#### Группы

- `yc managed-postgresql cluster` — управление кластерами [!KEYREF PG].
    - `get` — [получить информацию об указанном кластере [!KEYREF PG]](../../../managed-postgresql/operations/cluster-list.md#get-cluster).
    - `list` — [получить список кластеров [!KEYREF PG]](../../../managed-postgresql/operations/cluster-list.md#list-clusters).
    - `create` — [создать кластер [!KEYREF PG]](../../../managed-postgresql/operations/cluster-create.md).
    - `restore` — [восстановить кластер [!KEYREF PG]](../../../managed-postgresql/operations/cluster-backups.md#restore).
    - `update` — [изменить указанный кластер [!KEYREF PG]](../../../managed-postgresql/operations/update.md).
    - `update-config` — изменить конфигурацию указанного кластера [!KEYREF PG].
    - `delete` — [удалить указанный кластер [!KEYREF PG]](../../../managed-postgresql/operations/cluster-delete.md).
    - `backup` — [создать резервную копию указанного кластера [!KEYREF PG]](../../../managed-postgresql/operations/cluster-backups.md#create-backup).
    - `list-backups` — получить список доступных резервных копий для указанного кластера [!KEYREF PG].
    - `list-logs` — получить логи для указанного кластера [!KEYREF PG].
    - `list-operations` — получить список операций для указанного кластера [!KEYREF PG].  
- `yc managed-postgresql hosts` — управление хостами кластеров [!KEYREF PG].
    - `list` — [получить список хостов для указанного кластера [!KEYREF PG]](../../../managed-postgresql/operations/hosts.md#list). 
    - `add` — [добавить новый хост для кластера в указанной зоне доступности](../../../managed-postgresql/operations/hosts.md#add).
    - `update` — [изменить указанный хост](../../../managed-postgresql/operations/hosts.md#update).  
    - `delete` — [удалить указанный хост](../../../managed-postgresql/operations/hosts.md#remove). 
    - `update-config` — изменить конфигурацию для указанных хостов [!KEYREF PG].  
- `yc managed-postgresql database` — управление базами данных [!KEYREF PG].
    - `get` — получить информацию об указанной базе данных [!KEYREF PG].
    - `list` — получить список баз данных [!KEYREF PG].
    - `create` — создать базу данных [!KEYREF PG].
    - `update` — изменить указанную базу данных [!KEYREF PG].
    - `delete` — удалить указанную базу данных [!KEYREF PG].
- `yc managed-postgresql user` — управление пользователями [!KEYREF PG].
    - `get` — получить информацию об указанном пользователе [!KEYREF PG].
    - `list` — [получить список пользователей для указанного кластера [!KEYREF PG]](../../../managed-postgresql/operations/cluster-users.md#list-users).
    - `create` — [создать пользователя [!KEYREF PG]](../../../managed-postgresql/operations/cluster-users.md#adduser).
    - `update` — [изменить указанного пользователя [!KEYREF PG]](../../../managed-postgresql/operations/cluster-users.md#updateuser). 
    - `delete` — [удалить указанного пользователя [!KEYREF PG]](../../../managed-postgresql/operations/cluster-users.md#removeuser).
    - `grant-permission` — предоставить права указанному пользователя [!KEYREF PG].
    - `revoke-permission` — аннулировать права указанного пользователя [!KEYREF PG].
- `yc managed-postgresql backup` — управление [резервными копиями [!KEYREF PG]](../../../managed-postgresql/concepts/backup.md).
    - `get` — [получить информацию об указанной резервной копии [!KEYREF PG]](../../../managed-postgresql/operations/cluster-backups.md#get-backup).
    - `list` — [получить список доступных резервных копий [!KEYREF PG]](../../../managed-postgresql/operations/cluster-backups.md#list-backups).
- `yc managed-postgresql resource-preset` — управление [классами хостов [!KEYREF PG]](../../../managed-postgresql/concepts/instance-types.md).
    - `get` — получить информацию об указанных классах хостов [!KEYREF PG].
    - `list` — получить информацию о доступных классах хостов  [!KEYREF PG].
