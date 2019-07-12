# yc managed-clickhouse

Управление ClickHouse.

#### Использование команды

Синтаксис:

`yc managed-clickhouse <group>`

Алиасы:

- `yc clickhouse <group>`.

#### Группы

- `yc managed-clickhouse cluster` — управление кластерами ClickHouse.
    - `get` — [получить информацию об указанном кластере ClickHouse](../../../managed-clickhouse/operations/cluster-list.md#get-cluster).
    - `list` — [получить список кластеров ClickHouse](../../../managed-clickhouse/operations/cluster-list.md#list-clusters).
    - `create` — [создать кластер ClickHouse](../../../managed-clickhouse/operations/cluster-create.md).
    - `restore` — [восстановить кластер ClickHouse](../../../managed-clickhouse/operations/cluster-backups.md#restore).
    - `update` — [изменить указанный кластер ClickHouse](../../../managed-clickhouse/operations/update.md).
    - `update-config` — изменить конфигурацию указанного кластера ClickHouse.
    - `delete` — [удалить указанный кластер ClickHouse](../../../managed-clickhouse/operations/cluster-delete.md).
    - `backup` — [создать резервную копию указанного кластера ClickHouse](../../../managed-clickhouse/operations/cluster-backups.md#create-backup).
    - `list-backups` — получить список доступных резервных копий для указанного кластера ClickHouse.
    - `list-logs` — получить логи для указанного кластера ClickHouse.
    - `list-operations` — получить список операций для указанного кластера ClickHouse.
    - `clear-compression` — сбросить параметры сжатия указанного кластера ClickHouse.
    - `set-compression` — установить параметры сжатия для указанного кластера ClickHouse.
    - `add-external-dictionary` — добавить внешний словарь в указанный кластер ClickHouse.
    - `remove-external-dictionary` — удалить внешний словарь из указанного кластера ClickHouse.
    - `add-graphite-rollup` — добавить настройку агрегации данных для Graphite в указанный кластер ClickHouse.
    - `remove-graphite-rollup` — удалить настройку агрегации данных для Graphite из указанного кластера ClickHouse.
- `yc managed-clickhouse hosts` — управление хостами кластера ClickHouse.
    - `list` — [получить список хостов для указанного кластера ClickHouse](../../../managed-clickhouse/operations/hosts.md#list-hosts).
    - `add` — [добавить новый хост для кластера в указанной зоне доступности](../../../managed-clickhouse/operations/hosts.md#add-host).
    - `delete` — [удалить указанный хост](../../../managed-clickhouse/operations/hosts.md#remove-host).
- `yc managed-clickhouse database` — управление базами данных ClickHouse.
    - `get` — получить информацию об указанной базе данных ClickHouse.
    - `list` — получить список баз данных ClickHouse.
    - `create` — создать базу данных ClickHouse.
    - `delete` — удалить указанную базу данных ClickHouse.
- `yc managed-clickhouse user` — управление пользователями ClickHouse.
    - `get` — получить информацию об указанном пользователе ClickHouse.
    - `list` — [получить список пользователей для указанного кластера ClickHouse](../../../managed-clickhouse/operations/cluster-users.md#list-users).
    - `create` — [создать пользователя ClickHouse](../../../managed-clickhouse/operations/cluster-users.md#adduser).
    - `update` — [изменить указанного пользователя ClickHouse](../../../managed-clickhouse/operations/cluster-users.md#updateuser).
    - `delete` — [удалить указанного пользователя ClickHouse](../../../managed-clickhouse/operations/cluster-users.md#removeuser).
    - `grant-permission` — предоставить права указанному пользователя ClickHouse.
    - `revoke-permission` — аннулировать права указанного пользователя ClickHouse.
- `yc managed-clickhouse backup` — управление [резервными копиями ClickHouse](../../../managed-clickhouse/concepts/backup.md).
    - `get` — [получить информацию об указанной резервной копии ClickHouse](../../../managed-clickhouse/operations/cluster-backups.md#get-backup).
    - `list` — [получить список доступных резервных копий ClickHouse](../../../managed-clickhouse/operations/cluster-backups.md#list-backups).
- `yc managed-clickhouse resource-preset` — управление [классами хостов ClickHouse](../../../managed-clickhouse/concepts/instance-types.md).
    - `get` — получить информацию об указанных классах хостов ClickHouse.
    - `list` — получить информацию о доступных классах хостов ClickHouse.
