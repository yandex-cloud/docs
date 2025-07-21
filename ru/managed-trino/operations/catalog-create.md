---
title: Создание каталога {{ TR }}
description: Следуя этой инструкции, вы создадите каталог в кластере {{ mtr-name }}.
---

# Создание каталога {{ TR }}

## Роли для создания каталога {{ TR }} {#roles}

Для создания [каталога {{ TR }}](../concepts/index.md#catalog) с типом подключения [{{ connection-manager-name }}](../../metadata-hub/concepts/connection-manager.md) вашему аккаунту в {{ yandex-cloud }} нужна дополнительная роль [{{ roles-connection-manager-user }}](../../metadata-hub/security/connection-manager-roles.md#connection-manager-user), чтобы использовать подключения из {{ connection-manager-name }}.

[Сервисному аккаунту](../../iam/concepts/users/service-accounts.md) кластера должны быть назначены роли [{{ roles-connection-manager-user }}](../../metadata-hub/security/connection-manager-roles.md#connection-manager-user) и [{{ roles-lockbox-payloadviewer }}](../../lockbox/security/index.md#lockbox-payloadViewer). Это даст кластеру нужные права для работы с подключениями из {{ connection-manager-name }}. Подробнее см. в разделе [Имперсонация](../concepts/impersonation.md).

О назначении ролей читайте в [документации {{ iam-full-name }}](../../iam/operations/roles/grant.md).

## Создать каталог {{ TR }} {#create-catalog}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. На странице [каталога ресурсов]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
  1. Нажмите на имя нужного кластера.
  1. На панели слева выберите ![image](../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.trino.title_catalogs }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.trino.catalogs.create_action }}**.
  1. В поле **{{ ui-key.yacloud.trino.catalogs.field_catalog-name }}** задайте имя каталога {{ TR }}.
  1. В поле **{{ ui-key.yacloud.trino.catalogs.field_catalog-type }}** выберите тип [коннектора](../concepts/index.md#connector).
  1. Задайте [настройки каталога {{ TR }}](#catalog-settings).
  1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Настройки каталога {{ TR }} {#catalog-settings}

Настройки каталога {{ TR }} отличаются в зависимости от выбранного коннектора.

{% note info %}

Коннекторы с пометкой {{ preview-stage }} находятся на стадии предварительного тестирования. Стабильность работы не гарантируется.

{% endnote %}

### Коннектор {{ CH }} {#ch}

Чтобы задать настройки, выберите тип подключения — [{{ connection-manager-name }}](../../metadata-hub/concepts/connection-manager.md) или On-premise (пользовательская инсталляция).

{% list tabs %}

- Connection Manager

  * **Идентификатор подключения** — идентификатор подключения в {{ connection-manager-name }} для подключения к кластеру {{ CH }}.
    
    Чтобы узнать идентификатор подключения:
      1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
      1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.connection-manager.label_connections }}**.

  * **База данных** — имя БД в кластере {{ CH }}.
  * **Параметры клиента** — параметры клиента {{ CH }} в формате `ключ: значение`.

    {% cut "Доступные параметры" %}

    * `async` — использовать ли асинхронный режим. Значение: `true` или `false`.

    * `buffer_queue_variation` — сколько раз может заполниться буфер, прежде чем его размер будет увеличен.

    * `buffer_size` — размер буфера. При переполнении увеличивается до `max_buffer_size`.

    * `client_name` — имя клиента.

    * `compress` — сжимать ли данные в ответе сервера. Значение: `true` или `false`.

    * `compress_algorithm` — какой алгоритм использовать для сжатия данных. Возможные значения: [BROTLI](https://ru.wikipedia.org/wiki/Brotli), [BZ2](https://ru.wikipedia.org/wiki/Bzip2), [DEFLATE](https://ru.wikipedia.org/wiki/Deflate), [GZIP](https://ru.wikipedia.org/wiki/Gzip), [LZ4](https://ru.wikipedia.org/wiki/LZ4), [SNAPPY](https://ru.wikipedia.org/wiki/Snappy_(библиотека)), [XZ](https://ru.wikipedia.org/wiki/XZ), [ZSTD](https://ru.wikipedia.org/wiki/Zstandard) или `NONE`.

    * `compress_level` — уровень сжатия данных.

    * `connect_timeout` — максимальное время ожидания подключения к серверу (в миллисекундах).

    * `decompress` — распаковывать ли данные в запросе клиента. Значение: `true` или `false`.

    * `decompress_algorithm` — какой алгоритм использовать для распаковки данных. Возможные значения: [BROTLI](https://ru.wikipedia.org/wiki/Brotli), [BZ2](https://ru.wikipedia.org/wiki/Bzip2), [DEFLATE](https://ru.wikipedia.org/wiki/Deflate), [GZIP](https://ru.wikipedia.org/wiki/Gzip), [LZ4](https://ru.wikipedia.org/wiki/LZ4), [SNAPPY](https://ru.wikipedia.org/wiki/Snappy_(библиотека)), [XZ](https://ru.wikipedia.org/wiki/XZ), [ZSTD](https://ru.wikipedia.org/wiki/Zstandard) или `NONE`.

    * `decompress_level` — уровень сжатия данных при распаковке.

    * `failover` — максимальное число попыток подключения к репликам, если сервер недоступен.

    * `load_balancing_policy` — алгоритм выбора реплик для подключения.
        
        * `firstAlive` — запрос отправляется на первую доступную реплику.
        * `random` — запрос отправляется на любую реплику случайным образом.
        * `roundRobin` — запрос отправляется в соответствии с политикой [Round-robin](https://ru.wikipedia.org/wiki/Round-robin_(алгоритм)).

    * `max_buffer_size` — максимальный размер буфера.

    * `max_threads_per_client` — максимальное число потоков на одного клиента.

    * `product_name` — имя продукта в `User-Agent`.

    * `read_buffer_size` — размер буфера для чтения данных (в байтах). По умолчанию значение равно `buffer_size`. При заполнении буфера размер увеличивается до значения `max_buffer_size`.

    * `request_buffering` — режим буферизации запросов.

        * `RESOURCE_EFFICIENT` — обеспечивает умеренную производительность при минимальном использовании CPU и памяти. В этом режиме учитывается только размер буфера, очередь не используется.
        * `PERFORMANCE` — обеспечивает лучшую производительность за счет активного использования CPU и памяти.
        * `CUSTOM` — позволяет вручную настроить параметры буферизации, чтобы сбалансировать использование ресурсов и желаемую производительность.

    * `request_chunk_size` — размер куска данных в запросе (в байтах).

    * `response_buffering` — режим буферизации ответов.

        * `RESOURCE_EFFICIENT` — обеспечивает умеренную производительность при минимальном использовании CPU и памяти. В этом режиме учитывается только размер буфера, очередь не используется.
        * `PERFORMANCE` — обеспечивает лучшую производительность за счет активного использования CPU и памяти.
        * `CUSTOM` — позволяет вручную настроить параметры буферизации, чтобы сбалансировать использование ресурсов и желаемую производительность.

    * `server_time_zone` — часовой пояс.

    * `use_server_time_zone` — использовать ли часовой пояс сервера. Значение: `true` или `false`.

    * `use_server_time_zone_for_dates` — использовать ли часовой пояс сервера при обработке значений `Date`. Значение: `true` или `false`.

    * `use_time_zone` — какой часовой пояс использовать. Пример значения: `Europe/Amsterdam`. Работает, если значение `use_server_time_zone` равно `false`.

    * `write_buffer_size` — размер буфера для записи данных (в байтах). По умолчанию значение равно `buffer_size`. При заполнении буфера размер увеличивается до значения `max_buffer_size`.

    {% endcut %}

  * **Дополнительные настройки** — в формате `ключ: значение`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/clickhouse.html).

- On-premise

  * **URL** — URL для подключения к БД {{ CH }} в формате `jdbc:clickhouse://<адрес_хоста>:<порт>/<имя_БД>`.
  * **Имя пользователя** — имя пользователя для подключения к БД {{ CH }}.
  * **Пароль** — пароль пользователя для подключения к БД {{ CH }}.
  * **Дополнительные настройки** — в формате `ключ: значение`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/clickhouse.html).

{% endlist %}

### Коннектор Delta Lake {#delta-lake}

  {% include [connector-settings](../../_includes/managed-trino/connector-settings.md) %}

  * **Дополнительные настройки** — в формате `ключ: значение`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/delta-lake.html).

### Коннектор Hive {#hive}

  {% include [connector-settings](../../_includes/managed-trino/connector-settings.md) %}

  * **Дополнительные настройки** — в формате `ключ: значение`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/hive.html).

### Коннектор Iceberg {#iceberg}

  {% include [connector-settings](../../_includes/managed-trino/connector-settings.md) %}

  * **Дополнительные настройки** — в формате `ключ: значение`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/iceberg.html).

### Коннектор Oracle {{ preview-stage }} {#oracle}

  * **Тип подключения** — On-premise.
  * **URL** — URL для подключения к БД Oracle в формате `jdbc:oracle:thin:@<адрес_хоста>:<порт>:<SID>`. `SID` — системный идентификатор Oracle.
  * **Имя пользователя** — имя пользователя для подключения к БД Oracle.
  * **Пароль** — пароль пользователя для подключения к БД Oracle.
  * **Дополнительные настройки** — в формате `ключ: значение`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/oracle.html).

### Коннектор {{ PG }} {#pg}

Чтобы задать настройки, выберите тип подключения — [{{ connection-manager-name }}](../../metadata-hub/concepts/connection-manager.md) или On-premise (пользовательская инсталляция).

{% list tabs %}

- Connection Manager

  * **Идентификатор подключения** — идентификатор подключения в {{ connection-manager-name }} для подключения к кластеру {{ PG }}.
    
    Чтобы узнать идентификатор подключения:
      1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
      1. Нажмите на имя нужного кластера и перейдите на вкладку **{{ ui-key.yacloud.connection-manager.label_connections }}**.

  * **База данных** — имя БД в кластере {{ PG }}.
  * **Дополнительные настройки** — в формате `ключ: значение`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/postgresql.html).

- On-premise

  * **URL** — URL для подключения к БД {{ PG }} в формате `jdbc:postgresql://<адрес_хоста>:<порт>/<имя_БД>`.
  * **Имя пользователя** — имя пользователя для подключения к БД {{ PG }}.
  * **Пароль** — пароль пользователя для подключения к БД {{ PG }}.
  * **Дополнительные настройки** — в формате `ключ: значение`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/postgresql.html).

{% endlist %}

### Коннектор MS SQL Server {{ preview-stage }} {#ms-sql}

  * **Тип подключения** — On-premise.
  * **URL** — URL для подключения к БД Microsoft SQL Server в формате `jdbc:sqlserver://<адрес_хоста>:<порт>;databaseName=<имя_БД>`.
  * **Имя пользователя** — имя пользователя для подключения к БД Microsoft SQL Server.
  * **Пароль** — пароль пользователя для подключения к БД Microsoft SQL Server.
  * **Дополнительные настройки** — в формате `ключ: значение`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/sqlserver.html).

### Коннектор TPC-DS {#tpc-ds}

Коннектор TPC-DS не требует обязательных настроек.

Вы можете задать дополнительные настройки в формате `ключ: значение`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/tpcds.html).

### Коннектор TPC-H {#tpc-h}

Коннектор TPC-H не требует обязательных настроек.

Вы можете задать дополнительные настройки в формате `ключ: значение`. Список доступных настроек см. в [официальной документации](https://trino.io/docs/current/connector/tpch.html).

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}