#### Как добавить хост в кластер? {#add-host}

Чтобы добавить хост, воспользуйтесь [инструкцией](../../managed-clickhouse/operations/hosts.md#add-host). Вы также можете добавить новые хосты в кластер при [создании шарда](../../managed-clickhouse/operations/shards.md#add-shard).

#### Можно ли выставить параметру join_use_nulls значение 1 через CLI? {#join-use-nulls}

Да, для этого при создании или изменении настроек пользователя передайте нужное значение настройки `join_use_nulls` в параметре `--settings`, например:

```bash
yc managed-clickhouse user update <имя_пользователя> \
  --cluster-name=<имя_кластера> \
  --settings="join_use_nulls=1"
```

Подробнее см. в [документации](../../managed-clickhouse/operations/cluster-users.md#update-settings).

#### Будет ли кластер недоступен во время обновления? {#update-availability}

Если в кластере больше одного хоста, то обновление кластера проходит без простоя, так как хосты обновляются поочередно. На время рестарта будут недоступны только отдельные хосты.

#### Как изменить часовой пояс? {#timezone}

Измените настройку {{ CH }} [timezone]({{ ch.docs }}/operations/server-configuration-parameters/settings#server_configuration_parameters-timezone) или [session_timezone]({{ ch.docs }}/operations/settings/settings#session_timezone). О том, как это сделать, читайте в [инструкции](../../managed-clickhouse/operations/update.md#change-clickhouse-config).

#### Будет ли кластер недоступен при добавлении реплик? {#add-replica-availability}

Да, будет небольшой простой в работе во время перезагрузки кластера.

#### Как дать пользователю права только на чтение? {#readonly}

Для этого при создании или изменении пользователя через CLI передайте настройку `readonly=1` в параметре `--settings`, например:

```bash
yc managed-clickhouse user update <имя_пользователя> \
  --cluster-name=<имя_кластера> \
  --settings="readonly=1"
```

Подробнее см. в [документации](../../managed-clickhouse/operations/cluster-users.md#update-settings).

#### Как увеличить лимит памяти (memory limit)? {#memory-limit}

[Измените настройки пользователя](../../managed-clickhouse/operations/cluster-users.md#update-settings) и задайте нужное значение параметру `Max memory usage`.

#### Можно ли изменить тип диска? {#disk-type}

Нет, тип диска можно выбрать только при создании кластера или [восстановлении кластера](../../managed-clickhouse/operations/cluster-backups.md#restore) из резервной копии.

#### Можно ли изменить сеть и подсети? {#network}

Нет, сеть и подсети хостов можно выбрать только при создании кластера или [восстановлении кластера](../../managed-clickhouse/operations/cluster-backups.md#restore) из резервной копии.
