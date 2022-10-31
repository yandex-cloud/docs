# Изменение {{ CH }}-кластера

#### Как добавить хост в кластер? {#add-host}

Чтобы добавить хост, воспользуйтесь [инструкцией](../operations/hosts.md#add-host). Вы также можете добавить новые хосты в кластер при [создании шарда](../operations/shards.md#add-shard).

#### Можно ли выставить параметру join_use_nulls значение 1 через CLI? {#join-use-nulls}

Да, для этого при создании или изменении настроек пользователя передайте нужное значение настройки `join_use_nulls` в параметре `--settings`, например:

```bash
yc managed-clickhouse user update <имя пользователя> \
  --cluster-name=<имя кластера> \
  --settings="join_use_nulls=1"
```

Подробнее см. в [документации](../operations/cluster-users.md#update-settings).

#### Будет ли кластер недоступен во время обновления? {#update-availability}

Если в кластере больше одного хоста, то обновление кластера проходит без простоя, так как хосты обновляются поочередно. На время рестарта будут недоступны только отдельные хосты.

#### Как изменить часовой пояс (timezone)? {#timezone}

Воспользуйтесь инструкцией в разделе [{#T}](../operations/update.md#change-clickhouse-config).

#### Будет ли кластер недоступен при добавлении реплик? {#add-replica-availability}

Да, будет небольшой простой в работе во время перезагрузки кластера.

#### Как дать пользователю права только на чтение? {#readonly}

Для этого при создании или изменении пользователя через CLI передайте настройку `readonly=1` в параметре `--settings`, например:

```bash
yc managed-clickhouse user update <имя пользователя> \
  --cluster-name=<имя кластера> \
  --settings="readonly=1"
```

Подробнее см. в [документации](../operations/cluster-users.md#update-settings).

#### Как увеличить лимит памяти (memory limit)? {#memory-limit}

[Измените настройки пользователя](../operations/cluster-users.md#update-settings) и задайте нужное значение параметру `Max memory usage`.
