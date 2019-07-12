# yc managed-postgresql

Управление PostgreSQL.

#### Использование команды

Синтаксис:

`yc managed-postgresql <group>`

Алиасы:

- `yc postgresql <group>`;
- `yc postgres <group>`.

#### Группы

- `yc managed-postgresql cluster` — управление кластерами PostgreSQL.
    - `get` — [получить информацию об указанном кластере PostgreSQL](../../../managed-postgresql/operations/cluster-list.md#get-cluster).
    - `list` — [получить список кластеров PostgreSQL](../../../managed-postgresql/operations/cluster-list.md#list-clusters).
    - `create` — [создать кластер PostgreSQL](../../../managed-postgresql/operations/cluster-create.md).
    - `restore` — [восстановить кластер PostgreSQL](../../../managed-postgresql/operations/cluster-backups.md#restore).
    - `update` — [изменить указанный кластер PostgreSQL](../../../managed-postgresql/operations/update.md).
    - `update-config` — изменить конфигурацию указанного кластера PostgreSQL.
    - `delete` — [удалить указанный кластер PostgreSQL](../../../managed-postgresql/operations/cluster-delete.md).
    - `backup` — [создать резервную копию указанного кластера PostgreSQL](../../../managed-postgresql/operations/cluster-backups.md#create-backup).
    - `list-backups` — получить список доступных резервных копий для указанного кластера PostgreSQL.
    - `list-logs` — получить логи для указанного кластера PostgreSQL.
    - `list-operations` — получить список операций для указанного кластера PostgreSQL.
- `yc managed-postgresql hosts` — управление хостами кластеров PostgreSQL.
    - `list` — [получить список хостов для указанного кластера PostgreSQL](../../../managed-postgresql/operations/hosts.md#list).
    - `add` — [добавить новый хост для кластера в указанной зоне доступности](../../../managed-postgresql/operations/hosts.md#add).
    - `update` — [изменить указанный хост](../../../managed-postgresql/operations/hosts.md#update).
    - `delete` — [удалить указанный хост](../../../managed-postgresql/operations/hosts.md#remove).
    - `update-config` — изменить конфигурацию для указанных хостов PostgreSQL.
- `yc managed-postgresql database` — управление базами данных PostgreSQL.
    - `get` — получить информацию об указанной базе данных PostgreSQL.
    - `list` — получить список баз данных PostgreSQL.
    - `create` — создать базу данных PostgreSQL.
    - `update` — изменить указанную базу данных PostgreSQL.
    - `delete` — удалить указанную базу данных PostgreSQL.
- `yc managed-postgresql user` — управление пользователями PostgreSQL.
    - `get` — получить информацию об указанном пользователе PostgreSQL.
    - `list` — [получить список пользователей для указанного кластера PostgreSQL](../../../managed-postgresql/operations/cluster-users.md#list-users).
    - `create` — [создать пользователя PostgreSQL](../../../managed-postgresql/operations/cluster-users.md#adduser).
    - `update` — [изменить указанного пользователя PostgreSQL](../../../managed-postgresql/operations/cluster-users.md#updateuser).
    - `delete` — [удалить указанного пользователя PostgreSQL](../../../managed-postgresql/operations/cluster-users.md#removeuser).
    - `grant-permission` — предоставить права указанному пользователя PostgreSQL.
    - `revoke-permission` — аннулировать права указанного пользователя PostgreSQL.
- `yc managed-postgresql backup` — управление [резервными копиями PostgreSQL](../../../managed-postgresql/concepts/backup.md).
    - `get` — [получить информацию об указанной резервной копии PostgreSQL](../../../managed-postgresql/operations/cluster-backups.md#get-backup).
    - `list` — [получить список доступных резервных копий PostgreSQL](../../../managed-postgresql/operations/cluster-backups.md#list-backups).
- `yc managed-postgresql resource-preset` — управление [классами хостов PostgreSQL](../../../managed-postgresql/concepts/instance-types.md).
    - `get` — получить информацию об указанных классах хостов PostgreSQL.
    - `list` — получить информацию о доступных классах хостов  PostgreSQL.
