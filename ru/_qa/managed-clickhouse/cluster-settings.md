#### Как создать пользователя для доступа из {{ datalens-name }} с правами только на чтение? {#datalens-readonly}

Воспользуйтесь [инструкцией](../../managed-clickhouse/operations/cluster-users.md#example-create-readonly-user), чтобы создать пользователя с правами только на чтение. Если в настройках кластера [включена опция](../../managed-clickhouse/operations/update.md#change-additional-settings) **{{ ui-key.yacloud.mdb.cluster.overview.label_access-datalens }}**, сервис сможет [подключаться](../../managed-clickhouse/operations/datalens-connect.md#create-connector) к кластеру с помощью этого пользователя.

#### Как дать пользователю права на создание и удаление таблиц или БД? {#create-delete-role}

[Включите управление пользователями через SQL](../../managed-clickhouse/operations/update.md#SQL-management) и выдайте пользователю нужные права с помощью команды `GRANT`.

Подробнее о команде `GRANT` читайте в [документации {{ CH }}]({{ ch.docs }}{{ lang }}/sql-reference/statements/grant).

#### Как узнать значение настройки internal_replication? {#internal-replication}

Информация о настройке `internal_replication` недоступна ни в интерфейсах {{ yandex-cloud }}, ни в системных таблицах {{ CH }}. Значение настройки по умолчанию — `true`.

#### Почему возникает ошибка `MEMORY_LIMIT_EXCEEDED`? {#max-memory-usage}

Настройка [Max memory usage](../../managed-clickhouse/concepts/settings-list.md) ограничивает объем оперативной памяти, который может использовать один запрос на одном сервере. По умолчанию ее значение равно `0`, то есть ограничение не задано.

Увеличивайте значение **Max memory usage** только если для него задано ненулевое значение и запрос превышает это ограничение. В таком случае возникает ошибка:

```text
DB::Exception: Memory limit (total) exceeded:
would use 14.10 GiB (attempt to allocate chunk of 4219924 bytes), maximum: 14.10 GiB.
(MEMORY_LIMIT_EXCEEDED), Stack trace (when copying this message, always include the lines below)
```

Максимальное значение **Max memory usage** ограничено настройкой **Max server memory usage**. Если **Max memory usage** равно `0`, причиной ошибки `MEMORY_LIMIT_EXCEEDED` может быть достижение общего лимита памяти сервера. Увеличение **Max memory usage** в этом случае не поможет. [Оптимизируйте запрос]({{ ch.docs }}resources/support-center/knowledge-base/performance-optimization/memory-limit-exceeded-for-query), чтобы сократить потребление памяти, или [измените класс хостов](../../managed-clickhouse/operations/update.md#change-resource-preset). Подробнее в разделе [{#T}](../../managed-clickhouse/concepts/memory-management.md).

[Увеличить](../../managed-clickhouse/operations/cluster-users.md#update-settings) значение **Max memory usage** можно в настройках пользователя или с помощью SQL-запросов:

* Для текущей сессии:

    ```sql
    SET max_memory_usage = <значение_в_байтах>;
    ```

* Для отдельного запроса:

    ```sql
    SELECT <выражение>
    FROM <имя_таблицы>
    SETTINGS max_memory_usage = <значение_в_байтах>;
    ```

Если в кластере включено [управление пользователями через SQL](../../managed-clickhouse/concepts/user-access-rights.md#sql-user-management), значение **Max memory usage** можно задать для выбранных пользователей с помощью [профиля настроек]({{ ch.docs }}{{ lang }}/operations/access-rights#settings-profiles-management). Например, чтобы задать значение для одного пользователя:

```sql
CREATE SETTINGS PROFILE max_memory_usage_profile
SETTINGS max_memory_usage = <значение_в_байтах>
TO <имя_пользователя>;
```

#### Почему в высокодоступном кластере {{ mch-name }} должно быть три или пять хостов {{ ZK }}? {#zookeeper-hosts-number}

{{ ZK }} использует алгоритм консенсуса: сервис продолжает функционировать, пока большинство хостов {{ ZK }} находятся в рабочем состоянии.

Например, если кластер имеет два хоста {{ ZK }}, то при отключении одного из них оставшийся хост не составляет большинство, поэтому сервис становится недоступным. Таким образом, кластер с двумя хостами {{ ZK }} не является [высокодоступным](../../managed-clickhouse/concepts/high-availability.md).

Кластер с тремя хостами {{ ZK }} является высокодоступным. При обслуживании или выходе из строя одного из них кластер сохраняет работоспособность. Таким образом, три — минимальное рекомендуемое число хостов {{ ZK }} в кластере {{ mch-name }}.

Кластер с четырьмя хостами {{ ZK }} не имеет преимуществ перед кластером с тремя хостами: он также способен функционировать при отключении только одного хоста. При отключении двух хостов консенсус не соблюдается и сервис становится недоступным.

Кластер с пятью хостами {{ ZK }} уже способен выдерживать отключение двух хостов, так как три из пяти хостов составляют большинство. Поэтому обслуживать такой кластер удобнее, чем кластер с тремя хостами. Даже если один из пяти хостов [находится на обслуживании](../../managed-clickhouse/concepts/maintenance.md) или перезапускается, кластер остается высокодоступным, т. е. выдерживает отключение еще одного хоста.

Добавление в кластер более пяти хостов {{ ZK }} не поддерживается.

Таким образом, в кластере {{ mch-name }} рекомендуется создавать три или пять хостов {{ ZK }}.

#### Как добавить хост в кластер с отключенным сервисом координации? {#add-hosts-disabled-coordination}

Если в кластере с одним хостом и отключенным [сервисом координации](../../managed-clickhouse/concepts/coordination-system.md) попытаться добавить хост, возникнет ошибка:

```text
ERROR: rpc error: code = FailedPrecondition desc = shard cannot have more than 1 host in non-HA cluster configuration
```

Чтобы добавить хост в кластер, сначала [включите сервис координации](../../managed-clickhouse/operations/update.md#enable-coordination) {{ CK }} или {{ ZK }} на отдельных хостах.

#### Как добавить многохостовый шард в кластер с отключенным сервисом координации? {#add-shard-disabled-coordination}

Если в шардированном кластере с отключенным [сервисом координации](../../managed-clickhouse/concepts/coordination-system.md) попытаться добавить шард с несколькими хостами, возникнет ошибка:

```text
ERROR: rpc error: code = FailedPrecondition desc = To create a shard with two or more hosts, you must enable the coordination service first.
```

Чтобы добавить многохостовый шард в кластер, сначала [включите сервис координации](../../managed-clickhouse/operations/update.md#enable-coordination) {{ CK }} или {{ ZK }} на отдельных хостах.
