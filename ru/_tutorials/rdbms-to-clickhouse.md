Вы можете перенести базу данных из {{ PG }} в {{ CH }} с помощью сервиса {{ data-transfer-full-name }}. Для этого:

1. [Подготовьте трансфер](#prepare-transfer).
1. [Активируйте трансфер](#activate-transfer).
1. [Проверьте работу репликации](#example-check-replication).
1. [Выполните выборку данных в приемнике](#working-with-data-ch).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).

## Перед началом работы {#before-you-begin}

Для примера все нужные ресурсы будут созданы в {{ yandex-cloud }}. Подготовьте инфраструктуру:

{% list tabs %}

* Вручную

  1. Создайте кластер-источник {{ mpg-name }} любой подходящей [конфигурации](../managed-postgresql/concepts/instance-types.md) с хостами в публичном доступе и следующими настройками:
      * Имя базы — `db1`.
      * Имя пользователя — `pg-user`.
      * Пароль — `<пароль источника>`.

  1. Создайте кластер-приемник {{ mch-name }} любой подходящей [конфигурации](../managed-clickhouse/concepts/instance-types.md) с хостами в публичном доступе и следующими настройками:
      * Количество хостов {{ CH }} — не меньше 2 (для включения репликации в кластере).
      * Имя базы — `db1`.
      * Имя пользователя — `ch-user`.
      * Пароль — `<пароль приемника>`.

  {% if audience != "internal" %}

  1. Убедитесь, что группы безопасности кластеров настроены правильно и допускают подключение к ним:
     * [{{ mch-name }}](../managed-clickhouse/operations/connect.md#configuring-security-groups).
     * [{{ mpg-name }}](../managed-postgresql/operations/connect.md#configuring-security-groups).

  {% endif %}

  1. [Выдайте роль](../managed-postgresql/operations/grant#grant-privilege) `mdb_replication` пользователю `pg-user` в кластере {{ mpg-name }}.

* С помощью {{ TF }}

    1. Если у вас еще нет {{ TF }}, {% if audience != "internal" %}[установите и настройте его](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform){% else %}установите и настройте его{% endif %}.
    1. Скачайте [файл с настройками провайдера](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Поместите его в отдельную рабочую директорию и {% if audience != "internal" %}[укажите значения параметров](../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider){% else %}укажите значения параметров{% endif %}.
    1. Скачайте в ту же рабочую директорию файл конфигурации [postgresql-to-clickhouse.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-transfer/postgresql-to-clickhouse.tf).

        В этом файле описаны:

        * {% if audience != "internal" %}[сети](../vpc/concepts/network.md#network){% else %}сети{% endif %};
        * {% if audience != "internal" %}[подсети](../vpc/concepts/network.md#subnet){% else %}подсети{% endif %};
        * {% if audience != "internal" %}[группы безопасности](../vpc/concepts/security-groups.md){% else %}группы безопасности{% endif %}, необходимые для подключения к кластерам;
        * кластер-источник {{ mpg-name }};
        * кластер-приемник {{ mch-name }};
        * эндпоинт для источника;
        * эндпоинт для приемника;
        * трансфер.

    1. Укажите в файле `postgresql-to-clickhouse.tf` пароли пользователя-администратора {{ PG }} и {{ CH }}.
    1. Выполните команду `terraform init` в директории с конфигурационным файлом. Эта команда инициализирует провайдер, указанный в конфигурационных файлах, и позволяет работать с ресурсами и источниками данных провайдера.
    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Подготовьте трансфер {#prepare-transfer}

1. [Подключитесь к кластеру {{ mpg-name }}](../managed-postgresql/operations/connect.md).
1. Создайте в базе данных `db1` таблицу `x_tab` и заполните ее данными:

     ```sql
     CREATE TABLE x_tab
     (
         id NUMERIC PRIMARY KEY,
         name CHAR(5)
     );
     CREATE INDEX ON x_tab (id);
     INSERT INTO x_tab (id, name) VALUES
       (40, 'User1'),
       (41, 'User2'),
       (42, 'User3'),
       (43, 'User4'),
       (44, 'User5');
     ```

1. Создайте трансфер:

    {% list tabs %}

    * Вручную

        1. [Создайте эндпоинт-источник](../data-transfer/operations/endpoint/source/postgresql.md) типа `{{ PG }}` и укажите в нем параметры подключения к кластеру:

            * **Тип подключения** — `Кластер Managed Service for PostgreSQL`.
            * **Кластер** — `<имя кластера-источника {{ PG }}>` из выпадающего списка.
            * **База данных** — `db1`.
            * **Пользователь** — `pg-user`.
            * **Пароль** — `<пароль пользователя>`.

        1. [Создайте эндпоинт-приемник](../data-transfer/operations/endpoint/target/clickhouse.md) типа `{{ CH }}` и укажите в нем параметры подключения к кластеру:

            * **Тип подключения** — `Кластер Managed Service for ClickHouse`.
            * **Кластер** — `<имя кластера-приемника {{ CH }}>` из выпадающего списка.
            * **База данных** — `db1`.
            * **Пользователь** — `ch-user`.
            * **Пароль** — `<пароль пользователя>`.
            * **Политика очистки** — `DROP`.

        1. [Создайте трансфер](../data-transfer/operations/transfer.md#create) типа [{{ dt-type-copy-repl }}](../data-transfer/concepts/index.md#transfer-type), использующий созданные эндпоинты.

    * С помощью {{ TF }}

        1. Укажите в файле `postgresql-to-clickhouse.tf` значение `1` для переменной `transfer_enabled`.

        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Создайте необходимую инфраструктуру:

            {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

    {% endlist %}

## Активируйте трансфер {#activate-transfer}

1. [Активируйте трансфер](../data-transfer/operations/transfer.md#activate) и дождитесь его перехода в статус {{ dt-status-repl }}.
1. Чтобы проверить, что трансфер перенес данные с учетом репликации в приемнике, подключитесь к кластеру-приемнику {{ mch-full-name }} и посмотрите, что таблица `x_tab` в базе `db1` содержит те же колонки, что таблица `x_tab` в базе-источнике, а также [колонки с временными метками](#working-with-data-ch) `__data_transfer_commit_time` и `__data_transfer_delete_time`:

   ```sql
   SELECT * FROM db1.x_tab WHERE id = 41;
   ```

   ```text
   ┌─id─┬──name──┬─── __data-transfer_commit_time─┬───__data-transfer-delete_time─┐
   │ 41 │  User2 │   1633417594957267000          │ 0                             │
   └────┴────────┴────────────────────────────────┴───────────────────────────────┘
   ```

## Проверьте работу репликации {#example-check-replication}

1. Подключитесь к кластеру-источнику.
1. Удалите строку с идентификатором `41` и измените строку с идентификатором `42` в таблице `x_tab` базы-источника {{ PG }}:

    ```sql
    DELETE FROM db1.public.x_tab WHERE id = 41;
    UPDATE db1.public.x_tab SET name = 'Key3' WHERE id = 42;
    ```

1. Убедитесь, что в таблице `x_tab` на приемнике {{ CH }} отобразились изменения:

    ```sql
    SELECT * FROM db1.x_tab WHERE (id >= 41) AND (id <= 42);
    ```

    ```text
    ┌─id─┬──name──┬─── __data-transfer_commit_time─┬───__data-transfer-delete_time─┐
    │ 41 │  User2 │   1633417594957267000          │ 1675417594957267000           │
    │ 42 │  Key3  │   1675417594957267000          │ 0                             │
    │ 42 │  User3 │   1633417594957268000          │ 1675417594957267000           │
    └────┴────────┴────────────────────────────────┴───────────────────────────────┘
    ```

## Выполните выборку данных в {{ CH }} {#working-with-data-ch}

На приемнике {{ CH }} с включенной [репликацией](../managed-clickhouse/concepts/replication.md) для воссоздания таблиц используются движки [ReplicatedReplacingMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replication/) и [ReplacingMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replacingmergetree/). В каждую таблицу автоматически добавляются столбцы:

* `__data_transfer_commit_time` — время изменения строки на это значение, в формате `TIMESTAMP`;
* `__data_transfer_delete_time` — время удаления строки в формате `TIMESTAMP`, если строка удалена в источнике. Если строка не удалялась, то устанавливается значение `0`.

    Столбец `__data_transfer_commit_time` необходим для работы движка ReplicatedReplacedMergeTree. Если запись удаляется или изменяется, в таблицу вставляется новая строка со значением в этом столбце. Запрос по одному первичному ключу возвращает несколько записей с разными значениями в столбце `__data_transfer_commit_time`.

В статусе трансфера {{ dt-status-repl }} данные в источнике могут добавляться или удаляться. Чтобы обеспечить стандартное поведение команд SQL, когда первичный ключ указывает на единственную запись, дополните запросы к перенесенным таблицам в {{ CH }} конструкцией с фильтром по столбцу `__data_transfer_delete_time`. Например, для таблицы `x_tab`:

```sql
SELECT * FROM x_tab FINAL
WHERE __data_transfer_delete_time = 0;
```

Для упрощения запросов `SELECT` создайте представление с фильтром по столбцу `__data_transfer_delete_time` и обращайтесь к нему. Например, для таблицы `x_tab`:

```sql
CREATE VIEW x_tab_view AS SELECT * FROM x_tab FINAL
WHERE __data_transfer_delete_time == 0;
```

{% note info %}

Использование ключевого слова `FINAL` сильно снижает эффективность запросов. По возможности избегайте его применения при работе с большими таблицами.

{% endnote %}

## Удалите созданные ресурсы {#clear-out}

Если созданные ресурсы вам больше не нужны, удалите их:

* Убедитесь, что трансфер находится в статусе {{ dt-status-finished }} и [удалите](../data-transfer/operations/transfer.md#delete) его.
* Удалите эндпоинты и кластеры:

    {% list tabs %}

    * Вручную

        * [Эндпоинт-источник и эндпоинт-приемник](../data-transfer/operations/endpoint/index.md#delete).
        * [{{ mpg-name }}](../managed-postgresql/operations/cluster-delete.md).
        * [{{ mch-name }}](../managed-clickhouse/operations/cluster-delete.md).

    * С помощью {{ TF }}

        Если вы создали ресурсы с помощью {{ TF }}:

        1. В терминале перейдите в директорию с планом инфраструктуры.
        1. Удалите конфигурационный файл `postgresql-to-clickhouse.tf`.
        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Подтвердите изменение ресурсов.

            {% include [terraform-apply](../_includes/mdb/terraform/apply.md) %}

            Все ресурсы, которые были описаны в конфигурационном файле `postgresql-to-clickhouse.tf`, будут удалены.

    {% endlist %}
