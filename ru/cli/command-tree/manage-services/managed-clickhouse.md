# yc managed-clickhouse

Управление [!KEYREF CH].

#### Использование команды

Синтаксис: 

`yc managed-clickhouse <group>`

Алиасы:
  
- `yc clickhouse <group>`.

#### Группы

- `yc managed-clickhouse cluster` — управление кластерами [!KEYREF CH].
    - `get` — [получить информацию об указанном кластере [!KEYREF CH]](../../../managed-clickhouse/operations/cluster-list.md#get-cluster).
    - `list` — [получить список кластеров [!KEYREF CH]](../../../managed-clickhouse/operations/cluster-list.md#list-clusters).
    - `create` — [создать кластер [!KEYREF CH]](../../../managed-clickhouse/operations/cluster-create.md).
    - `restore` — [восстановить кластер [!KEYREF CH]](../../../managed-clickhouse/operations/cluster-backups.md#restore).
    - `update` — [изменить указанный кластер [!KEYREF CH]](../../../managed-clickhouse/operations/update.md).
    - `update-config` — изменить конфигурацию указанного кластера [!KEYREF CH].
    - `delete` — [удалить указанный кластер [!KEYREF CH]](../../../managed-clickhouse/operations/cluster-delete.md).
    - `backup` — [создать резервную копию указанного кластера [!KEYREF CH]](../../../managed-clickhouse/operations/cluster-backups.md#create-backup).
    - `list-backups` — получить список доступных резервных копий для указанного кластера [!KEYREF CH].
    - `list-logs` — получить логи для указанного кластера [!KEYREF CH].
    - `list-operations` — получить список операций для указанного кластера [!KEYREF CH].  
    - `clear-compression` — сбросить параметры сжатия указанного кластера [!KEYREF CH].
    - `set-compression` — установить параметры сжатия для указанного кластера [!KEYREF CH].
    - `add-external-dictionary` — добавить внешний словарь в указанный кластер [!KEYREF CH].
    - `remove-external-dictionary` — удалить внешний словарь из указанного кластера [!KEYREF CH].
    - `add-graphite-rollup` — добавить настройку агрегации данных для Graphite в указанный кластер [!KEYREF CH].
    - `remove-graphite-rollup` — удалить настройку агрегации данных для Graphite из указанного кластера [!KEYREF CH].    
- `yc managed-clickhouse hosts` — управление хостами кластера [!KEYREF CH].
    - `list` — [получить список хостов для указанного кластера [!KEYREF CH]](../../../managed-clickhouse/operations/hosts.md#list-hosts). 
    - `add` — [добавить новый хост для кластера в указанной зоне доступности](../../../managed-clickhouse/operations/hosts.md#add-host). 
    - `delete` — [удалить указанный хост](../../../managed-clickhouse/operations/hosts.md#remove-host). 
- `yc managed-clickhouse database` — управление базами данных [!KEYREF CH].
    - `get` — получить информацию об указанной базе данных [!KEYREF CH].
    - `list` — получить список баз данных [!KEYREF CH].
    - `create` — создать базу данных [!KEYREF CH].
    - `delete` — удалить указанную базу данных [!KEYREF CH].
- `yc managed-clickhouse user` — управление пользователями [!KEYREF CH].
    - `get` — получить информацию об указанном пользователе [!KEYREF CH].
    - `list` — [получить список пользователей для указанного кластера [!KEYREF CH]](../../../managed-clickhouse/operations/cluster-users.md#list-users).
    - `create` — [создать пользователя [!KEYREF CH]](../../../managed-clickhouse/operations/cluster-users.md#adduser).
    - `update` — [изменить указанного пользователя [!KEYREF CH]](../../../managed-clickhouse/operations/cluster-users.md#updateuser). 
    - `delete` — [удалить указанного пользователя [!KEYREF CH]](../../../managed-clickhouse/operations/cluster-users.md#removeuser).
    - `grant-permission` — предоставить права указанному пользователя [!KEYREF CH].
    - `revoke-permission` — аннулировать права указанного пользователя [!KEYREF CH].
- `yc managed-clickhouse backup` — управление [резервными копиями [!KEYREF CH]](../../../managed-clickhouse/concepts/backup.md).
    - `get` — [получить информацию об указанной резервной копии [!KEYREF CH]](../../../managed-clickhouse/operations/cluster-backups.md#get-backup).
    - `list` — [получить список доступных резервных копий [!KEYREF CH]](../../../managed-clickhouse/operations/cluster-backups.md#list-backups).
- `yc managed-clickhouse resource-preset` — управление [классами хостов [!KEYREF CH]](../../../managed-clickhouse/concepts/instance-types.md).
    - `get` — получить информацию об указанных классах хостов [!KEYREF CH].
    - `list` — получить информацию о доступных классах хостов [!KEYREF CH].
