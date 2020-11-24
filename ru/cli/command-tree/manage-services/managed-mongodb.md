# yc managed-mongodb

Управление {{ MG }}.

#### Использование команды

Синтаксис:

`yc managed-mongodb <group>`

Алиасы:

- `yc mongodb <group>`;
- `yc mongo <group>`.

#### Группы

- `yc managed-mongodb cluster` — управление кластерами {{ MG }}.
    - `get` — [получить информацию об указанном кластере {{ MG }}](../../../managed-mongodb/operations/cluster-list.md#get-cluster).
    - `list` — [получить список кластеров {{ MG }}](../../../managed-mongodb/operations/cluster-list.md#list-clusters).
    - `create` — [создать кластер {{ MG }}](../../../managed-mongodb/operations/cluster-create.md).
    - `restore` — [восстановить кластер {{ MG }}](../../../managed-mongodb/operations/cluster-backups.md#restore).
    - `update` — [изменить указанный кластер {{ MG }}](../../../managed-mongodb/operations/update.md).
    - `update-config` — изменить конфигурацию указанного кластера {{ MG }}.
    - `delete` — [удалить указанный кластер {{ MG }}](../../../managed-mongodb/operations/cluster-delete.md).
    - `backup` — [создать резервную копию указанного кластера {{ MG }}](../../../managed-mongodb/operations/cluster-backups.md#create-backup).
    - `list-backups` — получить список доступных резервных копий для указанного кластера {{ MG }}.
    - `list-logs` — получить логи для указанного кластера {{ MG }}.
    - `list-operations` — получить список операций для указанного кластера {{ MG }}.
- `yc managed-mongodb hosts` — управление хостами кластеров {{ MG }}.
    - `list` — [получить список хостов для указанного кластера {{ MG }}](../../../managed-mongodb/operations/hosts.md#list-hosts).
    - `add` — [добавить новый хост для кластера в указанной зоне доступности](../../../managed-mongodb/operations/hosts.md#add-host).
    - `delete` — [удалить указанный хост](../../../managed-mongodb/operations/hosts.md#remove-host).
- `yc managed-mongodb database` — управление базами данных {{ MG }}.
    - `get` — получить информацию об указанной базе данных {{ MG }}.
    - `list` — получить список баз данных {{ MG }}.
    - `create` — создать базу данных  {{ MG }}.
    - `delete` — удалить указанную базу данных {{ MG }}.
- `yc managed-mongodb user` — управление пользователями {{ MG }}.
    - `get` — получить информацию об указанном пользователе {{ MG }}.
    - `list` — [получить список пользователей для указанного кластера {{ MG }}](../../../managed-mongodb/operations/cluster-users.md#list-users).
    - `create` — [создать пользователя {{ MG }}](../../../managed-mongodb/operations/cluster-users.md#adduser).
    - `update` — [изменение указанного пользователя {{ MG }}](../../../managed-mongodb/operations/cluster-users.md#updateuser).
    - `delete` — [удалить указанного пользователя {{ MG }}](../../../managed-mongodb/operations/cluster-users.md#removeuser).
    - `grant-permission` — предоставить права указанному пользователя {{ MG }}.
    - `revoke-permission` — аннулировать права указанного пользователя {{ MG }}.
- `yc managed-mongodb backup` — управление [резервными копиями {{ MG }}](../../../managed-mongodb/concepts/backup.md).
    - `get` — [получить информацию об указанной резервной копии {{ MG }}](../../../managed-mongodb/operations/cluster-backups.md#get-backup).
    - `list` — [получить список доступных резервных копий {{ MG }}](../../../managed-mongodb/operations/cluster-backups.md#list-backups).
- `yc managed-mongodb resource-preset` — управление [классами хостов {{ MG }}](../../../managed-mongodb/concepts/instance-types.md).
    - `get` — получить информацию об указанных классах хостов {{ MG }}.
    - `list` — получить информацию о доступных классах хостов {{ MG }}.
