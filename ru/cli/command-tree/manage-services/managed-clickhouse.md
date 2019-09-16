# yc managed-clickhouse

Управление {{ CH }}.

#### Использование команды

Синтаксис:

`yc managed-clickhouse <group>`

Алиасы:

- `yc clickhouse <group>`.

#### Группы

- `yc managed-clickhouse cluster` — управление кластерами {{ CH }}.
    - `get` — [получить информацию об указанном кластере {{ CH }}](../../../managed-clickhouse/operations/cluster-list.md#get-cluster).
    - `list` — [получить список кластеров {{ CH }}](../../../managed-clickhouse/operations/cluster-list.md#list-clusters).
    - `create` — [создать кластер {{ CH }}](../../../managed-clickhouse/operations/cluster-create.md).
    - `restore` — [восстановить кластер {{ CH }}](../../../managed-clickhouse/operations/cluster-backups.md#restore).
    - `update` — [изменить указанный кластер {{ CH }}](../../../managed-clickhouse/operations/update.md).
    - `update-config` — изменить конфигурацию указанного кластера {{ CH }}.
    - `delete` — [удалить указанный кластер {{ CH }}](../../../managed-clickhouse/operations/cluster-delete.md).
    - `backup` — [создать резервную копию указанного кластера {{ CH }}](../../../managed-clickhouse/operations/cluster-backups.md#create-backup).
    - `list-backups` — получить список доступных резервных копий для указанного кластера {{ CH }}.
    - `list-logs` — получить логи для указанного кластера {{ CH }}.
    - `list-operations` — получить список операций для указанного кластера {{ CH }}.
    - `clear-compression` — сбросить параметры сжатия указанного кластера {{ CH }}.
    - `set-compression` — установить параметры сжатия для указанного кластера {{ CH }}.
    - `add-external-dictionary` — добавить внешний словарь в указанный кластер {{ CH }}.
    - `remove-external-dictionary` — удалить внешний словарь из указанного кластера {{ CH }}.
    - `add-graphite-rollup` — добавить настройку агрегации данных для Graphite в указанный кластер {{ CH }}.
    - `remove-graphite-rollup` — удалить настройку агрегации данных для Graphite из указанного кластера {{ CH }}.
- `yc managed-clickhouse hosts` — управление хостами кластера {{ CH }}.
    - `list` — [получить список хостов для указанного кластера {{ CH }}](../../../managed-clickhouse/operations/hosts.md#list-hosts).
    - `add` — [добавить новый хост для кластера в указанной зоне доступности](../../../managed-clickhouse/operations/hosts.md#add-host).
    - `delete` — [удалить указанный хост](../../../managed-clickhouse/operations/hosts.md#remove-host).
- `yc managed-clickhouse database` — управление базами данных {{ CH }}.
    - `get` — получить информацию об указанной базе данных {{ CH }}.
    - `list` — получить список баз данных {{ CH }}.
    - `create` — создать базу данных {{ CH }}.
    - `delete` — удалить указанную базу данных {{ CH }}.
- `yc managed-clickhouse user` — управление пользователями {{ CH }}.
    - `get` — получить информацию об указанном пользователе {{ CH }}.
    - `list` — [получить список пользователей для указанного кластера {{ CH }}](../../../managed-clickhouse/operations/cluster-users.md#list-users).
    - `create` — [создать пользователя {{ CH }}](../../../managed-clickhouse/operations/cluster-users.md#adduser).
    - `update` — [изменить указанного пользователя {{ CH }}](../../../managed-clickhouse/operations/cluster-users.md#updateuser).
    - `delete` — [удалить указанного пользователя {{ CH }}](../../../managed-clickhouse/operations/cluster-users.md#removeuser).
    - `grant-permission` — предоставить права указанному пользователя {{ CH }}.
    - `revoke-permission` — аннулировать права указанного пользователя {{ CH }}.
- `yc managed-clickhouse backup` — управление [резервными копиями {{ CH }}](../../../managed-clickhouse/concepts/backup.md).
    - `get` — [получить информацию об указанной резервной копии {{ CH }}](../../../managed-clickhouse/operations/cluster-backups.md#get-backup).
    - `list` — [получить список доступных резервных копий {{ CH }}](../../../managed-clickhouse/operations/cluster-backups.md#list-backups).
- `yc managed-clickhouse resource-preset` — управление [классами хостов {{ CH }}](../../../managed-clickhouse/concepts/instance-types.md).
    - `get` — получить информацию об указанных классах хостов {{ CH }}.
    - `list` — получить информацию о доступных классах хостов {{ CH }}.
