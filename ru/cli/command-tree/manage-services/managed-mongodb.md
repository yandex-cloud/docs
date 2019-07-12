# yc managed-mongodb

Управление MongoDB.

#### Использование команды

Синтаксис:

`yc managed-mongodb <group>`

Алиасы:

- `yc mongodb <group>`;
- `yc mongo <group>`.

#### Группы

- `yc managed-mongodb cluster` — управление кластерами MongoDB.
    - `get` — [получить информацию об указанном кластере MongoDB](../../../managed-mongodb/operations/cluster-list.md#get-cluster).
    - `list` — [получить список кластеров MongoDB](../../../managed-mongodb/operations/cluster-list.md#list-clusters).
    - `create` — [создать кластер MongoDB](../../../managed-mongodb/operations/cluster-create.md).
    - `restore` — [восстановить кластер MongoDB](../../../managed-mongodb/operations/cluster-backups.md#restore).
    - `update` — [изменить указанный кластер MongoDB](../../../managed-mongodb/operations/update.md).
    - `update-config` — изменить конфигурацию указанного кластера MongoDB.
    - `delete` — [удалить указанный кластер MongoDB](../../../managed-mongodb/operations/cluster-delete.md).
    - `backup` — [создать резервную копию указанного кластера MongoDB](../../../managed-mongodb/operations/cluster-backups.md#create-backup).
    - `list-backups` — получить список доступных резервных копий для указанного кластера MongoDB.
    - `list-logs` — получить логи для указанного кластера MongoDB.
    - `list-operations` — получить список операций для указанного кластера MongoDB.
- `yc managed-mongodb hosts` — управление хостами кластеров MongoDB.
    - `list` — [получить список хостов для указанного кластера MongoDB](../../../managed-mongodb/operations/hosts.md#list-hosts).
    - `add` — [добавить новый хост для кластера в указанной зоне доступности](../../../managed-mongodb/operations/hosts.md#add-host).
    - `delete` — [удалить указанный хост](../../../managed-mongodb/operations/hosts.md#remove-host).
- `yc managed-mongodb database` — управление базами данных MongoDB.
    - `get` — получить информацию об указанной базе данных MongoDB.
    - `list` — получить список баз данных MongoDB.
    - `create` — создать базу данных  MongoDB.
    - `delete` — удалить указанную базу данных MongoDB.
- `yc managed-mongodb user` — управление пользователями MongoDB.
    - `get` — получить информацию об указанном пользователе MongoDB.
    - `list` — [получить список пользователей для указанного кластера MongoDB](../../../managed-mongodb/operations/cluster-users.md#list-users).
    - `create` — [создать пользователя MongoDB](../../../managed-mongodb/operations/cluster-users.md#adduser).
    - `update` — [изменение указанного пользователя MongoDB](../../../managed-mongodb/operations/cluster-users.md#updateuser).
    - `delete` — [удалить указанного пользователя MongoDB](../../../managed-mongodb/operations/cluster-users.md#removeuser).
    - `grant-permission` — предоставить права указанному пользователя MongoDB.
    - `revoke-permission` — аннулировать права указанного пользователя MongoDB.
- `yc managed-mongodb backup` — управление [резервными копиями MongoDB](../../../managed-mongodb/concepts/backup.md).
    - `get` — [получить информацию об указанной резервной копии MongoDB](../../../managed-mongodb/operations/cluster-backups.md#get-backup).
    - `list` — [получить список доступных резервных копий MongoDB](../../../managed-mongodb/operations/cluster-backups.md#list-backups).
- `yc managed-mongodb resource-preset` — управление [классами хостов MongoDB](../../../managed-mongodb/concepts/instance-types.md).
    - `get` — получить информацию об указанных классах хостов MongoDB.
    - `list` — получить информацию о доступных классах хостов MongoDB.
