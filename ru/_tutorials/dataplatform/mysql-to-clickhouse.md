# Асинхронная репликация данных из {{ mmy-name }} в {{ mch-name }} с помощью {{ data-transfer-full-name }}


С помощью сервиса {{ data-transfer-name }} вы можете перенести базу данных из кластера-источника {{ MY }} в {{ CH }}.

Чтобы перенести данные:

1. [Подготовьте кластер-источник](#prepare-source).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).
1. [Выполните выборку данных в {{ CH }}](#working-with-data-ch).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

* Кластер {{ mmy-name }}: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий (см. [тарифы {{ mmy-name }}](../../managed-mysql/pricing.md)).
* Кластер {{ mch-name }}: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий (см. [тарифы {{ mch-name }}](../../managed-clickhouse/pricing.md)).
* Публичные IP-адреса, если для хостов кластеров включен публичный доступ (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md)).
* Каждый трансфер: использование вычислительных ресурсов и количество переданных строк данных (см. [тарифы {{ data-transfer-name }}](../../data-transfer/pricing.md)).


## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте кластер-источник {{ mmy-name }}](../../managed-mysql/operations/cluster-create.md) любой подходящей конфигурации. Для подключения к кластеру с локальной машины пользователя, а не из облачной сети {{ yandex-cloud }}, включите публичный доступ к кластеру при его создании.

    1. [Создайте кластер-приемник {{ mch-name }}](../../managed-clickhouse/operations/cluster-create.md) любой подходящей конфигурации со следующими настройками:

        * Количество хостов {{ CH }} — не меньше 2 (для включения репликации в кластере).
        * Имя базы данных — такое же, как на кластере-источнике.
        * Для подключения к кластеру с локальной машины пользователя, а не из облачной сети {{ yandex-cloud }}, включите публичный доступ к кластеру при его создании.

    
    1. Если вы используете группы безопасности в кластерах, настройте их так, чтобы к кластерам можно было подключаться из интернета:

        * [{{ mmy-name }}](../../managed-mysql/operations/connect.md#configuring-security-groups).
        * [{{ mch-name }}](../../managed-clickhouse/operations/connect/index.md#configuring-security-groups).


- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Скачайте в ту же рабочую директорию файл конфигурации [data-transfer-mmy-mch.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-mysql-to-clickhouse/blob/main/data-transfer-mmy-mch.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсети](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md) и правило, необходимое для подключения к кластеру {{ mmy-name }};
        * кластер-источник {{ mmy-name }};
        * кластер-приемник {{ mch-name }};
        * эндпоинт для источника;
        * эндпоинт для приемника;
        * трансфер.

    1. Укажите в файле `data-transfer-mmy-mch.tf`:

        * параметры кластера-источника {{ mmy-name }}, которые будут использоваться как [параметры эндпоинта-источника](../../data-transfer/operations/endpoint/target/mysql.md#managed-service):

            * `source_mysql_version` — версия {{ MY }};
            * `source_db_name` — имя базы данных {{ MY }};
            * `source_user` и `source_password` — имя и пароль пользователя-владельца базы данных.

        * параметры кластера-приемника {{ mch-name }}, которые будут использоваться как [параметры эндпоинта-приемника](../../data-transfer/operations/endpoint/target/clickhouse.md#managed-service):

            * `target_db_name` — имя базы данных {{ CH }};
            * `target_user` и `target_password` — имя и пароль пользователя-владельца базы данных.

    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Подготовьте кластер-источник {#prepare-source}

1. Если вы создавали инфраструктуру вручную, [подготовьте кластер-источник](../../data-transfer/operations/prepare.md#source-my).

1. [Подключитесь к кластеру-источнику {{ mmy-name }}](../../managed-mysql/operations/connect.md).

1. Наполните базу тестовыми данными.

    1. Создайте таблицу `x_tab`:

    ```sql
    CREATE TABLE x_tab
    (
        id INT,
        name TEXT,
        PRIMARY KEY (id)
    );
    ```

    1. Заполните таблицу данными:

    ```sql
    INSERT INTO x_tab (id, name) VALUES
        (40, 'User1'),
        (41, 'User2'),
        (42, 'User3'),
        (43, 'User4'),
        (44, 'User5');
    ```

## Подготовьте и активируйте трансфер {#prepare-transfer}

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте эндпоинт для источника](../../data-transfer/operations/endpoint/index.md#create):

        * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `{{ MY }}`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlSource.connection.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.mysql.console.form.mysql.MysqlConnectionType.mdb_cluster_id.title }}`.

            Выберите кластер-источник из списка и укажите настройки подключения к нему.

    1. [Создайте эндпоинт для приемника](../../data-transfer/operations/endpoint/index.md#create):

        * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `ClickHouse`.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTarget.title }}** → **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseTarget.connection.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseManaged.mdb_cluster_id.title }}`.

            Выберите кластер-приемник из списка и укажите настройки подключения к нему.

    1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.snapshot_and_increment.title }}_**, использующий созданные эндпоинты.
    1. [Активируйте](../../data-transfer/operations/transfer.md#activate) его.

- {{ TF }} {#tf}

    1. Укажите в файле `data-transfer-mmy-mch.tf` для переменной `transfer_enabled` значение `1`.

    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        Трансфер активируется автоматически после создания.

{% endlist %}

## Проверьте работоспособность трансфера {#verify-transfer}

1. Дождитесь перехода трансфера в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

1. Убедитесь, что в базу данных {{ mch-name }} перенеслись данные из кластера-источника {{ mmy-name }}:

    1. [Подключитесь к кластеру](../../managed-clickhouse/operations/connect/clients.md#clickhouse-client) с помощью `clickhouse-client`.

    1. Выполните запрос:

        ```sql
        SELECT * FROM <имя_базы_данных_{{ CH }}>.x_tab
        ```

        Результат:

        ```text
        ┌─id─┬─name──┬─__data_transfer_commit_time─┬─__data_transfer_delete_time─┐
        │ 40 │ User1 │         1661952756538347180 │                           0 │
        │ 41 │ User2 │         1661952756538347180 │                           0 │
        │ 42 │ User3 │         1661952756538347180 │                           0 │
        │ 43 │ User4 │         1661952756538347180 │                           0 │
        │ 44 │ User5 │         1661952756538347180 │                           0 │
        └────┴───────┴─────────────────────────────┴─────────────────────────────┘
        ```

        Таблица также содержит [столбцы с временными метками](#working-with-data-ch) `__data_transfer_commit_time` и `__data_transfer_delete_time`.

1. Удалите строку с `id` `41` и измените с `id` `42` в таблице `x_tab` базы-источника {{ MY }}:

    1. [Подключитесь к кластеру-источнику {{ mmy-name }}](../../managed-mysql/operations/connect.md).

    1. Выполните запросы:

        ```sql
        DELETE FROM x_tab WHERE id = 41;
        UPDATE x_tab SET name = 'Key3' WHERE id = 42;
        ```

1. Убедитесь, что в таблице `x_tab` на приемнике {{ CH }} отобразились изменения:

    ```sql
    SELECT * FROM <имя_базы_данных_{{ CH }}>.x_tab WHERE id in (41,42);
    ```

    Результат:

    ```text
    ┌─id─┬─name──┬─__data_transfer_commit_time─┬─__data_transfer_delete_time─┐
    │ 41 │ User2 │         1661952756538347180 │                           0 │
    │ 42 │ User3 │         1661952756538347180 │                           0 │
    └────┴───────┴─────────────────────────────┴─────────────────────────────┘
    ┌─id─┬─name─┬─__data_transfer_commit_time─┬─__data_transfer_delete_time─┐
    │ 41 │ ᴺᵁᴸᴸ │         1661953256000000000 │         1661953256000000000 │
    └────┴──────┴─────────────────────────────┴─────────────────────────────┘
    ┌─id─┬─name─┬─__data_transfer_commit_time─┬─__data_transfer_delete_time─┐
    │ 42 │ Key3 │         1661953280000000000 │                           0 │
    └────┴──────┴─────────────────────────────┴─────────────────────────────┘
    ```

## Выполните выборку данных в {{ CH }} {#working-with-data-ch}

На приемнике {{ CH }} с включенной [репликацией](../../managed-clickhouse/concepts/replication.md) для воссоздания таблиц используются движки [ReplicatedReplacingMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replication/) и [ReplacingMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replacingmergetree/). В каждую таблицу автоматически добавляются столбцы:

* `__data_transfer_commit_time` — время изменения строки на это значение, в формате `TIMESTAMP`;
* `__data_transfer_delete_time` — время удаления строки в формате `TIMESTAMP`, если строка удалена в источнике. Если строка не удалялась, то устанавливается значение `0`.

    Столбец `__data_transfer_commit_time` необходим для работы движка ReplicatedReplacedMergeTree. Если запись удаляется или изменяется, в таблицу вставляется новая строка со значением в этом столбце. Запрос по одному первичному ключу возвращает несколько записей с разными значениями в столбце `__data_transfer_commit_time`.

В статусе трансфера **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}** данные в источнике могут добавляться или удаляться. Чтобы обеспечить стандартное поведение команд SQL, когда первичный ключ указывает на единственную запись, дополните запросы к перенесенным таблицам в {{ CH }} конструкцией с фильтром по столбцу `__data_transfer_delete_time`. Например, для таблицы `x_tab`:

```sql
SELECT * FROM <имя_базы_данных_{{ CH }}>.x_tab FINAL
WHERE __data_transfer_delete_time = 0;
```

Для упрощения запросов `SELECT` создайте представление с фильтром по столбцу `__data_transfer_delete_time` и обращайтесь к нему. Например, для таблицы `x_tab`:

```sql
CREATE VIEW x_tab_view AS SELECT * FROM <имя_базы_данных_{{ CH }}>.x_tab FINAL
WHERE __data_transfer_delete_time == 0;
```

## Удалите созданные ресурсы {#clear-out}

{% include [note before delete resources](../../_includes/mdb/note-before-delete-resources.md) %}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Удалите трансфер](../../data-transfer/operations/transfer.md#delete-transfer).
    1. [Удалите эндпоинты](../../data-transfer/operations/endpoint/index.md#delete) для источника и приемника.
    1. [Удалите кластер {{ mmy-name }}](../../managed-mysql/operations/cluster-delete.md).
    1. [Удалите кластер {{ mch-name }}](../../managed-clickhouse/operations/cluster-delete.md).

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
