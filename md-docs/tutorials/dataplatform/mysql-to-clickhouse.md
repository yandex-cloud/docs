# Миграция базы данных из {{ MY }} в {{ CH }} с помощью {{ data-transfer-full-name }}

# Асинхронная репликация данных из {{ mmy-name }} в {{ mch-name }} с помощью {{ data-transfer-full-name }}


С помощью сервиса {{ data-transfer-name }} вы можете перенести базу данных из кластера-источника {{ MY }} в {{ CH }}.

Чтобы перенести данные:

1. [Подготовьте инфраструктуру](#prepare-infrastructure).
1. [Подготовьте кластер-источник](#prepare-source).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).
1. [Выполните выборку данных в {{ CH }}](#working-with-data-ch).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Перед началом работы {#before-you-begin}

Зарегистрируйтесь в {{ yandex-cloud }} и создайте [платежный аккаунт](../../billing/concepts/billing-account.md):
1. Перейдите в [консоль управления]({{ link-console-main }}), затем войдите в {{ yandex-cloud }} или зарегистрируйтесь.
1. На странице **[{{ ui-key.yacloud_billing.billing.label_service }}]({{ link-console-billing }})** убедитесь, что у вас подключен платежный аккаунт, и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md) и [привяжите](../../billing/operations/pin-cloud.md) к нему облако.

Если у вас есть активный платежный аккаунт, вы можете создать или выбрать [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет работать ваша инфраструктура, на [странице облака]({{ link-console-cloud }}).

[Подробнее об облаках и каталогах](../../resource-manager/concepts/resources-hierarchy.md).

### Необходимые платные ресурсы {#paid-resources}

* Кластер {{ mmy-name }}: выделенные хостам вычислительные ресурсы, объем хранилища и резервных копий (см. [тарифы {{ mmy-name }}](../../managed-mysql/pricing.md)).
* Кластер {{ mch-name }}: использование выделенных хостам вычислительных ресурсов, объем хранилища и резервных копий (см. [тарифы {{ mch-name }}](../../managed-clickhouse/pricing.md)).
* Публичные IP-адреса, если для хостов кластеров включен публичный доступ (см. [тарифы {{ vpc-name }}](../../vpc/pricing.md)).
* Каждый трансфер: использование вычислительных ресурсов и количество переданных строк данных (см. [тарифы {{ data-transfer-name }}](../../data-transfer/pricing.md)).


## Подготовьте инфраструктуру {#prepare-infrastructure}

{% list tabs group=instructions %}

- Вручную {#manual}

    {% note info %}
    
    Публичный доступ к хостам кластера нужен, если вы планируете подключаться к кластеру через интернет. Этот вариант подключения более простой, и его рекомендуется использовать для прохождения руководства. К хостам без публичного доступа тоже можно подключиться, но только с виртуальных машин {{ yandex-cloud }}, расположенных в той же облачной сети, что и кластер.
    
    {% endnote %}

    1. [Создайте кластер-источник {{ mmy-name }}](../../managed-mysql/operations/cluster-create.md) любой подходящей конфигурации. Для подключения к кластеру с локальной машины пользователя, а не из облачной сети {{ yandex-cloud }}, включите публичный доступ к кластеру при его создании.

    1. [Создайте кластер-приемник {{ mch-name }}](../../managed-clickhouse/operations/cluster-create.md) любой подходящей конфигурации со следующими настройками:

        * Количество хостов {{ CH }} — не меньше 2 (для включения репликации в кластере).
        * Имя базы данных — такое же, как на кластере-источнике.
        * Для подключения к кластеру с локальной машины пользователя, а не из облачной сети {{ yandex-cloud }}, включите публичный доступ к кластеру при его создании.

    
    1. Если вы используете группы безопасности в кластерах, настройте их так, чтобы к кластерам можно было подключаться из интернета:

        * [{{ mmy-name }}](../../managed-mysql/operations/connect/index.md#configuring-security-groups).
        * [{{ mch-name }}](../../managed-clickhouse/operations/connect/index.md#configuring-security-groups).


- {{ TF }} {#tf}

    1. Если у вас еще нет {{ TF }}, [установите его](../infrastructure-management/terraform-quickstart.md#install-terraform).
    1. [Получите данные для аутентификации](../infrastructure-management/terraform-quickstart.md#get-credentials). Вы можете добавить их в переменные окружения или указать далее в файле с настройками провайдера.
    1. [Настройте и инициализируйте провайдер](../infrastructure-management/terraform-quickstart.md#configure-provider). Чтобы не создавать конфигурационный файл с настройками провайдера вручную, [скачайте его](https://github.com/yandex-cloud-examples/yc-terraform-provider-settings/blob/main/provider.tf).
    1. Поместите конфигурационный файл в отдельную рабочую директорию и [укажите значения параметров](../infrastructure-management/terraform-quickstart.md#configure-provider). Если данные для аутентификации не были добавлены в переменные окружения, укажите их в конфигурационном файле.

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

        1. Выполните команду для просмотра планируемых изменений:
        
           ```bash
           terraform plan
           ```
        
           Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
        
        1. Если вас устраивают планируемые изменения, внесите их:
           1. Выполните команду:
        
              ```bash
              terraform apply
              ```
        
           1. Подтвердите изменение ресурсов.
           1. Дождитесь завершения операции.

        В указанном каталоге будут созданы все требуемые ресурсы. Проверить появление ресурсов и их настройки можно в [консоли управления]({{ link-console-main }}).

{% endlist %}

## Подготовьте кластер-источник {#prepare-source}

1. Если вы создавали инфраструктуру вручную, [подготовьте кластер-источник](../../data-transfer/operations/prepare.md#source-my).

1. [Подключитесь к кластеру-источнику {{ mmy-name }}](../../managed-mysql/operations/connect/index.md).

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

        1. Выполните команду для просмотра планируемых изменений:
        
           ```bash
           terraform plan
           ```
        
           Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
        
        1. Если вас устраивают планируемые изменения, внесите их:
           1. Выполните команду:
        
              ```bash
              terraform apply
              ```
        
           1. Подтвердите изменение ресурсов.
           1. Дождитесь завершения операции.

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

    1. [Подключитесь к кластеру-источнику {{ mmy-name }}](../../managed-mysql/operations/connect/index.md).

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

На приемнике {{ CH }} с включенной [репликацией](../../managed-clickhouse/concepts/replication.md) для воссоздания таблиц используются движки [ReplicatedReplacingMergeTree]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/replication) и [ReplacingMergeTree]({{ ch.docs }}{{ lang }}/engines/table-engines/mergetree-family/replacingmergetree). В каждую таблицу автоматически добавляются столбцы:

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

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Чтобы снизить потребление ресурсов, которые вам не нужны, удалите их:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Удалите трансфер](../../data-transfer/operations/transfer.md#delete-transfer).
    1. [Удалите эндпоинты](../../data-transfer/operations/endpoint/index.md#delete) для источника и приемника.
    1. [Удалите кластер {{ mmy-name }}](../../managed-mysql/operations/cluster-delete.md).
    1. [Удалите кластер {{ mch-name }}](../../managed-clickhouse/operations/cluster-delete.md).

- {{ TF }} {#tf}

    1. В терминале перейдите в директорию с планом инфраструктуры.
    
        {% note warning %}
    
        Убедитесь, что в директории нет {{ TF }}-манифестов с ресурсами, которые вы хотите сохранить. {{ TF }} удаляет все ресурсы, которые были созданы с помощью манифестов в текущей директории.
    
        {% endnote %}
    
    1. Удалите ресурсы:
    
        1. Выполните команду:
    
            ```bash
            terraform destroy
            ```
    
        1. Подтвердите удаление ресурсов и дождитесь завершения операции.
    
        Все ресурсы, которые были описаны в {{ TF }}-манифестах, будут удалены.

{% endlist %}

_{{ CH }} является зарегистрированным товарным знаком [ClickHouse, Inc](https://clickhouse.com)._