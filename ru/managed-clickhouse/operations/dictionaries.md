# Подключение внешних словарей в {{ mch-name }}

Вы можете подключать к кластеру [внешние словари](../concepts/dictionaries.md#external-dicts) и отключать их. Подробнее о словарях читайте в [документации {{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/).

{{ mch-name }} поддерживает несколько типов источников словарей:

* {{ CH }};
* HTTP(s);
* {{ MG }};
* {{ MY }};
* {{ PG }}.

Словарями можно управлять либо через SQL, либо через интерфейсы облака. SQL — рекомендуемый способ.

{% note warning %}

Изменение настроек словарей приводит к перезапуску серверов {{ CH }} на хостах кластера.

{% endnote %}

## Получить список словарей {#get-dicts-list}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_dictionaries }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы подключить внешний словарь к кластеру {{ CH }}:

    1. Посмотрите описание команды CLI для получения детальной информации о кластере:

        ```bash
        {{ yc-mdb-ch }} cluster get --help
        ```

    1. Выполните команду:

        ```bash
        {{ yc-mdb-ch }} cluster get <имя_кластера>
        ```

    Подключенные словари отображаются в блоке `dictionaries:` результата выполнения команды.

- API {#api}

    Чтобы просмотреть список словарей, воспользуйтесь методом REST API [get](../api-ref/Cluster/get.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Get](../api-ref/grpc/cluster_service.md#Get).

- SQL {#sql}

    1. [Подключитесь](connect.md) к нужной базе данных кластера {{ mch-name }} с помощью `clickhouse-client`.
    1. Выполните [запрос]({{ ch.docs }}/sql-reference/statements/show/#show-dictionaries) `SHOW DICTIONARIES`.

{% endlist %}

## Подключить словарь {#add-dictionary}

{% list tabs group=instructions %}

- Консоль управления {#console}

    {% note warning %}

    Если словарь добавлен через консоль, для него недоступно управление через SQL.

    {% endnote %}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_dictionaries }}**.
    1. В правом верхнем углу экрана нажмите **{{ ui-key.yacloud.mdb.cluster.dictionaries.button-action_add-dictionary }}**.
    1. Укажите [настройки словаря](#settings-console) и нажмите **{{ ui-key.yacloud.mdb.cluster.dictionaries.button_submit }}**.

- CLI {#cli}

    {% note warning %}

    Если словарь добавлен через CLI, для него недоступно управление через SQL.

    {% endnote %}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы подключить внешний словарь к кластеру {{ CH }}:

    1. Посмотрите описание команды CLI для добавления словарей:

        ```bash
        {{ yc-mdb-ch }} cluster add-external-dictionary --help
        ```

    1. Выполните команду добавления словаря и укажите [его настройки](#settings-cli):

        ```bash
        {{ yc-mdb-ch }} cluster add-external-dictionary \
           --name=<имя_кластера_{{ CH }}> \
           --dict-name=<имя_словаря> \
           ...
        ```

- API {#api}

    {% note warning %}

    Если словарь добавлен через API, для него недоступно управление через SQL.

    {% endnote %}

    Чтобы подключить словарь, воспользуйтесь методом REST API [createExternalDictionary](../api-ref/Cluster/createExternalDictionary.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/CreateExternalDictionary](../api-ref/grpc/cluster_service.md#CreateExternalDictionary).

- SQL {#sql}

    {% note warning %}

    Если словарь добавлен через SQL, для него недоступно управление через консоль, CLI и API.

    {% endnote %}

    1. [Подключитесь](connect.md) к нужной базе данных кластера {{ mch-name }} с помощью `clickhouse-client`.
    1. Выполните [DDL-запрос]({{ ch.docs }}/sql-reference/statements/create/dictionary/) и укажите [настройки словаря](#settings-sql):

        ```sql
        CREATE DICTIONARY <имя_словаря>(
        <столбцы_данных>
        )
        PRIMARY KEY <имя_столбца_с_ключами>
        SOURCE(<источник>(<конфигурация_источника>))
        LIFETIME(<интервал_обновления>)
        LAYOUT(<способ_размещения_в_памяти>());
        ```

{% endlist %}

## Удалить словарь {#delete-dictionary}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. В [консоли управления]({{ link-console-main }}) перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.clickhouse.cluster.switch_dictionaries }}**.
    1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке нужного словаря и выберите пункт **{{ ui-key.yacloud.mdb.cluster.dictionaries.button_action-delete }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы удалить внешний словарь:

    1. Посмотрите описание команды CLI для удаления словаря:

        ```bash
        {{ yc-mdb-ch }} cluster remove-external-dictionary --help
        ```

    1. Удалите словарь с помощью команды:

        ```bash
        {{ yc-mdb-ch }} cluster remove-external-dictionary \
           --name=<имя_кластера> \
           --dict-name=<имя_словаря>
        ```

- API {#api}

    Чтобы удалить словарь, воспользуйтесь методом REST API [deleteExternalDictionary](../api-ref/Cluster/deleteExternalDictionary.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/DeleteExternalDictionary](../api-ref/grpc/cluster_service.md#DeleteExternalDictionary).

- SQL {#sql}

    1. [Подключитесь](connect.md) к нужной базе данных кластера {{ mch-name }} с помощью `clickhouse-client`.
    1. Выполните [запрос]({{ ch.docs }}/sql-reference/statements/drop/#drop-dictionary) `DROP DICTIONARY <имя_БД>.<имя_словаря>`.

{% endlist %}

## Настройки словарей {#settings}

### SQL {#settings-sql}

* `<имя_словаря>` — имя нового словаря.
* `<столбцы_данных>` — список столбцов с данными словаря и их тип.
* `PRIMARY KEY` — имя ключевого столбца словаря.
* `SOURCE` — источник и его параметры.
* `LIFETIME` — периодичность обновления словаря.
* `LAYOUT` — способ размещения словаря в памяти. Поддерживаются способы: `flat`, `hashed`, `cache`, `range_hashed`, `complex_key_hashed`, `complex_key_cache`.

Подробные описание настроек читайте в [документации {{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-lifetime/).

### Консоль управления {#settings-console}

* **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_name }}** — имя нового словаря.

#### Источник {#console-source}

{% list tabs group=data_sources %}

- {{ CH }} {#clickhouse}

    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_host }}** — имя хоста источника. Хост должен находиться в той же сети, что и кластер {{ CH }}.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_port }}** — порт для подключения к источнику.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_user }}** — имя пользователя базы данных источника.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_password }}** — пароль для доступа к базе данных источника.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_db }}** — имя базы данных источника.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_table }}** — имя таблицы источника.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_where }}** — условие для выбора строк, из которых будет сформирован словарь. Например, условие выбора `id=10` эквивалентно SQL-команде `WHERE id=10`.
    * (Опционально) **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_invalidate-query }}** — SQL-запрос для проверки изменений словаря. {{ CH }} будет обновлять словарь только при изменении результата выполнения этого запроса.
        Подробнее читайте в [документации {{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-lifetime/).

- HTTP(s) {#https}

    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_http-url }}** — URL HTTP(s)-источника.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_http-format }}** — [формат]({{ ch.docs }}/interfaces/formats/#formats) файла для HTTP(s)-источника. Подробнее о форматах читайте в [документации {{ CH }}]({{ ch.docs }}/interfaces/formats/#formats).

- {{ MG }} {#mongodb}

    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_host }}** — имя хоста источника. Хост должен находиться в той же сети, что и кластер {{ CH }}.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_port }}** — порт для подключения к источнику.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_user }}** — имя пользователя базы данных источника.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_password }}** — пароль для доступа к базе данных источника.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_db }}** — имя базы данных источника.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_collection }}** — имя коллекции источника.

- {{ MY }} {#mysql}

    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_replicas }}** — список реплик {{ MY }}, которые будут использоваться как источник словаря.
        Для реплик можно задать общие параметры подключения или настроить порт, имя пользователя и пароль.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_port }}** — порт для подключения к источнику.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_user }}** — имя пользователя базы данных источника.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_password }}** — пароль для доступа к базе данных источника.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_db }}** — имя базы данных источника.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_table }}** — имя таблицы источника.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_where }}** — условие для выбора строк, из которых будет сформирован словарь. Например, условие выбора `id=10` эквивалентно SQL-команде `WHERE id=10`.
    * (Опционально) **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_invalidate-query }}** — SQL-запрос для проверки изменений словаря. {{ CH }} будет обновлять словарь только при изменении результата выполнения этого запроса.
        Подробнее читайте в [документации {{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-lifetime/).

- {{ PG }} {#postgresql}

    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_hosts }}** — имена хоста {{ PG }} и его [реплик](../../managed-postgresql/concepts/replication.md), которые будут использоваться в качестве источника словаря. Хосты должны находиться в той же сети, что и кластер {{ CH }}.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_port }}** — порт для подключения к источнику.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_user }}** — имя пользователя базы данных источника.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_password }}** — пароль для доступа к базе данных источника.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_db }}** — имя базы данных источника.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_table }}** — имя таблицы источника.
    * (Опционально) **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_invalidate-query }}** — SQL-запрос для проверки изменений словаря. {{ CH }} будет обновлять словарь только при изменении результата выполнения этого запроса.
        Подробнее читайте в [документации {{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-lifetime/).
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_postgresql-ssl-mode }}** — режим для установки защищенного SSL TCP/IP соединения с базой данных {{ PG }}.
        Подробнее читайте в [документации {{ PG }}](https://www.postgresql.org/docs/current/libpq-connect.html#LIBPQ-PARAMKEYWORDS).

{% endlist %}

Подробнее об источниках словарей и параметрах их подключения читайте в [документации {{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/).

#### Способ размещения в памяти {#console-method}

* **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_layout-type }}** — способ размещения словаря в памяти. Поддерживаются способы: `flat`, `hashed`, `cache`, `range_hashed`, `complex_key_hashed`, `complex_key_cache`. Подробнее о способах размещения словарей в памяти читайте в [документации {{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/).
* **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_size-in-cells }}** — количество ячеек кэша для способов `cache`, `complex_key_cache`. Подробнее о кэше читайте в [документации {{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/#cache).
* **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_structure-id }}** — имя ключевого столбца словаря. Ключевой столбец должен иметь тип данных UInt64. Используется для способов `flat`, `hashed`, `cache`, `range_hashed`. Подробнее о ключах читайте в [документации {{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-structure/#ext_dict-numeric-key).
* **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_structure-attributes }}** — список столбцов с данными словаря:

    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.column_attributes-name }}** — имя столбца.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.column_attributes-type }}** — тип данных столбца.
    * (Опционально) **{{ ui-key.yacloud.mdb.cluster.dictionaries.column_attributes-nullValue }}** — значение по умолчанию для пустого элемента. При загрузке словаря все пустые элементы будут заменены на это значение. Нельзя указать значение `NULL`.
    * (Опционально) **{{ ui-key.yacloud.mdb.cluster.dictionaries.column_attributes-expression }}** — [выражение]({{ ch.docs }}/sql-reference/syntax/#syntax-expressions), которое {{ CH }} выполняет со значением столбца.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.column_attributes-hierarchical }}** — признак поддержки иерархии.
    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.column_attributes-injective }}** — признак инъективности отображения `id` → `attribute`.

Подробнее о параметрах столбцов читайте в [документации {{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-structure/#ext_dict_structure-attributes).

#### Частота обновления {#console-rate}

* **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_update-interval }}** — задайте периодичность обновления словаря:

    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.label_fixed-lifetime }}** — фиксированный период между обновлениями словаря:

        * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_fixed-lifetime }}** — период обновления данных словаря в секундах.

    * **{{ ui-key.yacloud.mdb.cluster.dictionaries.label_range-lifetime }}** — диапазон, внутри которого {{ CH }} случайно выберет время для обновления. Это поможет распределить нагрузку на источник словаря при обновлении на большом количестве серверов:

        * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_range-lifetime-min }}** — минимальное значение периода между обновлениями словаря в секундах.
        * **{{ ui-key.yacloud.mdb.cluster.dictionaries.field_range-lifetime-max }}** — максимальное значение периода между обновлениями словаря в секундах.

Подробнее об обновлении словарей читайте в [документации {{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-lifetime/).

### CLI {#settings-cli}

* `--dict-name` — имя нового словаря.

{% list tabs group=data_sources %}

- {{ CH }} {#clickhouse}

    * `--clickhouse-source` — настройки источника {{ CH }}:

        * `db` — имя базы данных источника.
        * `table` — имя таблицы источника.
        * `host` — имя хоста источника. Хост должен находиться в той же сети, что и кластер {{ CH }}.
        * `port` — порт для подключения к источнику.
        * `user` — имя пользователя базы данных источника.
        * `password` — пароль для доступа к базе данных источника.
        * `where` — условие для выбора строк, из которых будет сформирован словарь. Например, условие выбора `id=10` эквивалентно SQL-команде `WHERE id=10`.

- HTTP(s) {#https}

    * `--http-source-url` — URL HTTP(s)-источника.
    * `--http-source-format` — [формат]({{ ch.docs }}/interfaces/formats/#formats) файла для HTTP(s)-источника. Подробнее о форматах читайте в [документации {{ CH }}]({{ ch.docs }}/interfaces/formats/#formats).

- {{ MG }} {#mongodb}

    * `--mongodb-source` — настройки источника {{ MG }}:

        * `db` — имя базы данных источника.
        * `connection` — имя коллекции для {{ MG }}-источника.
        * `host` — имя хоста источника. Хост должен находиться в той же сети, что и кластер {{ CH }}.
        * `port` — порт для подключения к источнику.
        * `user` — имя пользователя базы данных источника.
        * `password` — пароль для доступа к базе данных источника.

- {{ MY }} {#mysql}

    * `--mysql-source` — настройки источника {{ MY }}:

        * `db` — имя базы данных источника.
        * `table` — имя таблицы источника.
        * `port` — порт для подключения к источнику.
        * `user` — имя пользователя базы данных источника.
        * `password` — пароль для доступа к базе данных источника.
        * `where` — условие для выбора строк, из которых будет сформирован словарь. Например, условие выбора `id=10` эквивалентно SQL-команде `WHERE id=10`.

    * `--mysql-replica` — настройки реплик источника {{ MY }}:

        * `host` — имя хоста реплики.
        * `priority` — приоритет реплики. При попытке соединения {{ CH }} обходит реплики в соответствии с приоритетом. Чем меньше цифра, тем выше приоритет.
        * `port` — порт для подключения к реплике.
        * `user` — имя пользователя базы данных.
        * `password` — пароль для доступа к базе данных.

    * `--mysql-invalidate-query` — запрос для проверки изменений словаря. {{ CH }} будет обновлять словарь только при изменении результата выполнения этого запроса.

- {{ PG }} {#postgresql}

    * `--postgresql-source` — настройки источника {{ PG }}:

        * `db` — имя базы данных источника.
        * `table` — имя таблицы источника.
        * `port` — порт для подключения к источнику.
        * `user` — имя пользователя базы данных источника.
        * `password` — пароль для доступа к базе данных источника.
        * `ssl-mode` — режим для установки защищенного SSL TCP/IP соединения с базой данных {{ PG }}. Допустимые значения: `disable`, `allow`, `prefer`, `verify-ca`, `verify-full`.

    * `--postgresql-source-hosts` — имена хоста {{ PG }} и его [реплик](../../managed-postgresql/concepts/replication.md), которые будут использоваться в качестве источника словаря. Хосты должны находиться в той же сети, что и кластер {{ CH }}.

    * `--postgresql-invalidate-query` — запрос для проверки изменений словаря. {{ CH }} будет обновлять словарь только при изменении результата выполнения этого запроса.

{% endlist %}

* `--structure-id` — имя ключевого столбца словаря. Ключевой столбец должен иметь тип данных UInt64. Используется для способов `flat`, `hashed`, `cache`, `range_hashed`. Подробнее о ключах читайте в [документации {{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-structure/#ext_dict-numeric-key).
* `--structure-key` — список столбцов с данными словаря:

    * `name` — имя столбца.
    * `type` — тип данных столбца.
    * `null-value` — значение по умолчанию для пустого элемента. При загрузке словаря все пустые элементы будут заменены на это значение. Нельзя указать значение `NULL`.
    * `expression` — [выражение]({{ ch.docs }}/sql-reference/syntax/#syntax-expressions), которое {{ CH }} выполняет со значением столбца.
    * `hierarchical` — признак поддержки иерархии.
    * `injective` — признак инъективности отображения `id` → `attribute`.

* `--structure-attribute` — описание полей, доступных для запросов к базе данных:

    * `name` — имя столбца.
    * `type` — тип данных столбца.
    * `null-value` — значение по умолчанию для пустого элемента. При загрузке словаря все пустые элементы будут заменены на это значение. Нельзя указать значение `NULL`.
    * `expression` — [выражение]({{ ch.docs }}/sql-reference/syntax/#syntax-expressions), которое {{ CH }} выполняет со значением столбца.
    * `hierarchical` — признак поддержки иерархии.
    * `injective` — признак инъективности отображения `id` → `attribute`.

* `--fixed-lifetime` — фиксированный период между обновлениями словаря в секундах.
* `--lifetime-range` — диапазон, внутри которого {{ CH }} случайно выберет время для обновления. Это поможет распределить нагрузку на источник словаря при обновлении на большом количестве серверов.

    * `min` — минимальное значение периода между обновлениями словаря в секундах.
    * `max` — максимальное значение периода между обновлениями словаря в секундах.

* `--layout-type` — способ размещения словаря в памяти. Поддерживаются способы: `flat`, `hashed`, `cache`, `range_hashed`, `complex_key_hashed`, `complex_key_cache`. Подробнее о способах размещения словарей в памяти читайте в [документации {{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/).
* `--layout-size-in-cells` — количество ячеек кэша для способов `cache`, `complex_key_cache`. Подробнее о кэше читайте в [документации {{ CH }}]({{ ch.docs }}/sql-reference/dictionaries/external-dictionaries/external-dicts-dict-layout/#cache).

### API {#settings-api}

Описание настроек приведены на странице описания метода API [createExternalDictionary](../api-ref/Cluster/createExternalDictionary.md).

## Примеры

{% list tabs group=instructions %}

- CLI {#cli}

    Подключите словарь с тестовыми характеристиками:

    * кластер `mych`;
    * имя `mychdict`;
    * имя ключевого столбца `id`;
    * поля, доступные для запросов к базе данных:

        * `id` с типом `UInt64`;
        * `field1`с типом `String`;

    * фиксированный период между обновлениями словаря 300 секунд;
    * способ размещения словаря в памяти `cache`;
    * источник {{ PG }}:

        * база данных `db1`;
        * имя таблицы `table`;
        * порт для подключения `5432`;
        * имя пользователя базы данных `user1`;
        * пароль для доступа к базе данных `user1user1`;
        * режим для установки защищенного SSL TCP/IP соединения с базой данных `verify-full`;

    * имя хоста `rc1b-05vjbfhf********.{{ dns-zone }}`.

    Выполните следующую команду:

    ```bash
    {{ yc-mdb-ch }} cluster add-external-dictionary \
       --name=mych \
       --dict-name=mychdict \
       --structure-id=id \
       --structure-attribute name=id,`
                            `type=UInt64,`
                            `name=field1,`
                            `type=String \
       --fixed-lifetime=300 \
       --layout-type=cache \
       --postgresql-source db=db1,`
                          `table=table,`
                          `port=5432,`
                          `user=user1,`
                          `password=user1user1,`
                          `ssl-mode=verify-full \
       --postgresql-source-hosts=rc1b-05vjbfhf********.{{ dns-zone }}
    ```

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
