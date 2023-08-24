# Настройки параметров {{ CH }}-кластера


#### Как создать пользователя для доступа из {{ datalens-name }} с правами только на чтение? {#datalens-readonly}

Воспользуйтесь [инструкцией](../../managed-clickhouse/operations/cluster-users.md#example-create-readonly-user), чтобы создать пользователя с правами только на чтение. Если в настройках кластера [включена опция](../../managed-clickhouse/operations/update.md#change-additional-settings) **{{ ui-key.yacloud.mdb.cluster.overview.label_access-datalens }}**, сервис сможет [подключаться](../../managed-clickhouse/operations/datalens-connect.md#create-connector) к кластеру с помощью этого пользователя.



#### Как дать пользователю права на создание и удаление таблиц или БД? {#create-delete-role}

Включите в настройках кластера опцию [{#T}](../../managed-clickhouse/operations/cluster-users.md#sql-user-management) и выдайте пользователю нужные права [с помощью выражения]({{ ch.docs }}/sql-reference/statements/grant/) `GRANT`.

#### Как узнать значение настройки internal_replication? {#internal-replication}

Информация о настройке `internal_replication` недоступна ни в интерфейсах {{ yandex-cloud }}, ни в системных таблицах {{ CH }}. Значение настройки по умолчанию — `true`.

#### Как повысить максимальный объем оперативной памяти для выполнения запроса? {#max-memory-usage}

Если для выполнения запроса не хватает объема оперативной памяти пользователя, возникает ошибка:

```text
DB::Exception: Memory limit (total) exceeded:
would use 14.10 GiB (attempt to allocate chunk of 4219924 bytes), maximum: 14.10 GiB.
(MEMORY_LIMIT_EXCEEDED), Stack trace (when copying this message, always include the lines below)
```

Для [увеличения](../../managed-clickhouse/operations/cluster-users.md#update-settings) максимального объема оперативной памяти используйте параметр [Max memory usage](../../managed-clickhouse/concepts/settings-list.md#setting-max-memory-usage).

Если в кластере включена опция [Управление пользователями через SQL](../../managed-clickhouse/operations/cluster-users.md#sql-user-management), параметр `Max memory usage` можно задать:

* Для сессии текущего пользователя с помощью запроса:

    ```sql
    SET max_memory_usage = <значение в байтах>;
    ```

* Для всех пользователей по умолчанию с помощью создания [профиля настроек]({{ ch.docs }}/operations/access-rights/#settings-profiles-management).
