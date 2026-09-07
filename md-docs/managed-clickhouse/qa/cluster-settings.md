[Документация Yandex Cloud](../../index.md) > [Yandex Managed Service for ClickHouse®](../index.md) > Вопросы и ответы > Настройки параметров кластера

# Настройки параметров ClickHouse®-кластера

* [Как создать пользователя для доступа из DataLens с правами только на чтение?](#datalens-readonly)

* [Как дать пользователю права на создание и удаление таблиц или БД?](#create-delete-role)

* [Как узнать значение настройки internal_replication?](#internal-replication)

* [Как повысить максимальный объем оперативной памяти для выполнения запроса?](#max-memory-usage)

* [Почему в кластере Managed Service for ClickHouse® должно быть три или пять хостов ZooKeeper?](#zookeeper-hosts-number)

* [Как добавить хост в кластер с отключенным сервисом координации?](#add-hosts-disabled-coordination)

* [Как добавить многохостовый шард в кластер с отключенным сервисом координации?](#add-shard-disabled-coordination)

#### Как создать пользователя для доступа из DataLens с правами только на чтение? {#datalens-readonly}

Воспользуйтесь [инструкцией](../operations/cluster-users.md#example-create-readonly-user), чтобы создать пользователя с правами только на чтение. Если в настройках кластера [включена опция](../operations/update.md#change-additional-settings) **Доступ из DataLens**, сервис сможет [подключаться](../operations/datalens-connect.md#create-connector) к кластеру с помощью этого пользователя.

#### Как дать пользователю права на создание и удаление таблиц или БД? {#create-delete-role}

[Включите управление пользователями через SQL](../operations/update.md#SQL-management) и выдайте пользователю нужные права с помощью команды `GRANT`.

Подробнее о команде `GRANT` читайте в [документации ClickHouse®](https://clickhouse.com/docs/ru/sql-reference/statements/grant).

#### Как узнать значение настройки internal_replication? {#internal-replication}

Информация о настройке `internal_replication` недоступна ни в интерфейсах Yandex Cloud, ни в системных таблицах ClickHouse®. Значение настройки по умолчанию — `true`.

#### Почему возникает ошибка `MEMORY_LIMIT_EXCEEDED`? {#max-memory-usage}

Настройка [Max memory usage](../concepts/settings-list.md) ограничивает объем оперативной памяти, который может использовать один запрос на одном сервере. По умолчанию ее значение равно `0`, то есть ограничение не задано.

Увеличивайте значение **Max memory usage** только если для него задано ненулевое значение и запрос превышает это ограничение. В таком случае возникает ошибка:

```text
DB::Exception: Memory limit (total) exceeded:
would use 14.10 GiB (attempt to allocate chunk of 4219924 bytes), maximum: 14.10 GiB.
(MEMORY_LIMIT_EXCEEDED), Stack trace (when copying this message, always include the lines below)
```

Максимальное значение **Max memory usage** ограничено настройкой **Max server memory usage**. Если **Max memory usage** равно `0`, причиной ошибки `MEMORY_LIMIT_EXCEEDED` может быть достижение общего лимита памяти сервера. Увеличение **Max memory usage** в этом случае не поможет. [Оптимизируйте запрос](https://clickhouse.com/docs/resources/support-center/knowledge-base/performance-optimization/memory-limit-exceeded-for-query), чтобы сократить потребление памяти, или [измените класс хостов](../operations/update.md#change-resource-preset). Подробнее в разделе [Управление памятью в Managed Service for ClickHouse®](../concepts/memory-management.md).

[Увеличить](../operations/cluster-users.md#update-settings) значение **Max memory usage** можно в настройках пользователя или с помощью SQL-запросов:

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

Если в кластере включено [управление пользователями через SQL](../concepts/user-access-rights.md#sql-user-management), значение **Max memory usage** можно задать для выбранных пользователей с помощью [профиля настроек](https://clickhouse.com/docs/ru/operations/access-rights#settings-profiles-management). Например, чтобы задать значение для одного пользователя:

```sql
CREATE SETTINGS PROFILE max_memory_usage_profile
SETTINGS max_memory_usage = <значение_в_байтах>
TO <имя_пользователя>;
```

#### Почему в высокодоступном кластере Managed Service for ClickHouse® должно быть три или пять хостов ZooKeeper? {#zookeeper-hosts-number}

ZooKeeper использует алгоритм консенсуса: сервис продолжает функционировать, пока большинство хостов ZooKeeper находятся в рабочем состоянии.

Например, если кластер имеет два хоста ZooKeeper, то при отключении одного из них оставшийся хост не составляет большинство, поэтому сервис становится недоступным. Таким образом, кластер с двумя хостами ZooKeeper не является [высокодоступным](../concepts/high-availability.md).

Кластер с тремя хостами ZooKeeper является высокодоступным. При обслуживании или выходе из строя одного из них кластер сохраняет работоспособность. Таким образом, три — минимальное рекомендуемое число хостов ZooKeeper в кластере Managed Service for ClickHouse®.

Кластер с четырьмя хостами ZooKeeper не имеет преимуществ перед кластером с тремя хостами: он также способен функционировать при отключении только одного хоста. При отключении двух хостов консенсус не соблюдается и сервис становится недоступным.

Кластер с пятью хостами ZooKeeper уже способен выдерживать отключение двух хостов, так как три из пяти хостов составляют большинство. Поэтому обслуживать такой кластер удобнее, чем кластер с тремя хостами. Даже если один из пяти хостов [находится на обслуживании](../concepts/maintenance.md) или перезапускается, кластер остается высокодоступным, т. е. выдерживает отключение еще одного хоста.

Добавление в кластер более пяти хостов ZooKeeper не поддерживается.

Таким образом, в кластере Managed Service for ClickHouse® рекомендуется создавать три или пять хостов ZooKeeper.

#### Как добавить хост в кластер с отключенным сервисом координации? {#add-hosts-disabled-coordination}

Если в кластере с одним хостом и отключенным [сервисом координации](../concepts/coordination-system.md) попытаться добавить хост, возникнет ошибка:

```text
ERROR: rpc error: code = FailedPrecondition desc = shard cannot have more than 1 host in non-HA cluster configuration
```

Чтобы добавить хост в кластер, сначала [включите сервис координации](../operations/update.md#enable-coordination) ClickHouse® Keeper или ZooKeeper на отдельных хостах.

#### Как добавить многохостовый шард в кластер с отключенным сервисом координации? {#add-shard-disabled-coordination}

Если в шардированном кластере с отключенным [сервисом координации](../concepts/coordination-system.md) попытаться добавить шард с несколькими хостами, возникнет ошибка:

```text
ERROR: rpc error: code = FailedPrecondition desc = To create a shard with two or more hosts, you must enable the coordination service first.
```

Чтобы добавить многохостовый шард в кластер, сначала [включите сервис координации](../operations/update.md#enable-coordination) ClickHouse® Keeper или ZooKeeper на отдельных хостах.

_ClickHouse® является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._