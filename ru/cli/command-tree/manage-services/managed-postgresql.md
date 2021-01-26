# yc managed-postgresql

Управление {{ PG }}.

#### Использование команды

Синтаксис:

`yc managed-postgresql <group>`

Алиасы:

- `yc postgresql <group>`;
- `yc postgres <group>`.

#### Группы

- `yc managed-postgresql cluster` — управление кластерами {{ PG }}.
    - `get` — [получить информацию об указанном кластере {{ PG }}](../../../managed-postgresql/operations/cluster-list.md#get-cluster).
    - `list` — [получить список кластеров {{ PG }}](../../../managed-postgresql/operations/cluster-list.md#list-clusters).
    - `create` — [создать кластер {{ PG }}](../../../managed-postgresql/operations/cluster-create.md).
    - `restore` — [восстановить кластер {{ PG }}](../../../managed-postgresql/operations/cluster-backups.md#restore).
    - `update` — [изменить указанный кластер {{ PG }}](../../../managed-postgresql/operations/update.md).
    - `update-config` — изменить конфигурацию указанного кластера {{ PG }}.
    - `delete` — [удалить указанный кластер {{ PG }}](../../../managed-postgresql/operations/cluster-delete.md).
    - `backup` — [создать резервную копию указанного кластера {{ PG }}](../../../managed-postgresql/operations/cluster-backups.md#create-backup).
    - `list-backups` — получить список доступных резервных копий для указанного кластера {{ PG }}.
    - `list-logs` — получить логи для указанного кластера {{ PG }}.
    - `list-operations` — получить список операций для указанного кластера {{ PG }}.
- `yc managed-postgresql hosts` — управление хостами кластеров {{ PG }}.
    - `list` — [получить список хостов для указанного кластера {{ PG }}](../../../managed-postgresql/operations/hosts.md#list).
    - `add` — [добавить новый хост для кластера в указанной зоне доступности](../../../managed-postgresql/operations/hosts.md#add).
    - `update` — [изменить указанный хост](../../../managed-postgresql/operations/hosts.md#update).
    - `delete` — [удалить указанный хост](../../../managed-postgresql/operations/hosts.md#remove).
    - `update-config` — изменить конфигурацию для указанных хостов {{ PG }}.
- `yc managed-postgresql database` — управление базами данных {{ PG }}.
    - `get` — получить информацию об указанной базе данных {{ PG }}.
    - `list` — получить список баз данных {{ PG }}.
    - `create` — создать базу данных {{ PG }}.
    - `update` — изменить указанную базу данных {{ PG }}.
    - `delete` — удалить указанную базу данных {{ PG }}.
- `yc managed-postgresql user` — управление пользователями {{ PG }}.
    - `get` — получить информацию об указанном пользователе {{ PG }}.
    - `list` — [получить список пользователей для указанного кластера {{ PG }}](../../../managed-postgresql/operations/cluster-users.md#list-users).
    - `create` — [создать пользователя {{ PG }}](../../../managed-postgresql/operations/cluster-users.md#adduser).
    - `update` — [изменить указанного пользователя {{ PG }}](../../../managed-postgresql/operations/cluster-users.md#updateuser).
    - `delete` — [удалить указанного пользователя {{ PG }}](../../../managed-postgresql/operations/cluster-users.md#removeuser).
    - `grant-permission` — предоставить права указанному пользователю {{ PG }}.
    - `revoke-permission` — аннулировать права указанного пользователя {{ PG }}.
- `yc managed-postgresql backup` — управление [резервными копиями {{ PG }}](../../../managed-postgresql/concepts/backup.md).
    - `get` — [получить информацию об указанной резервной копии {{ PG }}](../../../managed-postgresql/operations/cluster-backups.md#get-backup).
    - `list` — [получить список доступных резервных копий {{ PG }}](../../../managed-postgresql/operations/cluster-backups.md#list-backups).
- `yc managed-postgresql resource-preset` — управление [классами хостов {{ PG }}](../../../managed-postgresql/concepts/instance-types.md).
    - `get` — получить информацию об указанных классах хостов {{ PG }}.
    - `list` — получить информацию о доступных классах хостов  {{ PG }}.
