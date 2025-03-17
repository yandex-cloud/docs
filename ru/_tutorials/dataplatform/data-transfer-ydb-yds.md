# Захват изменений из {{ ydb-short-name }} и поставка в {{ DS }}


В поток {{ yds-name }} можно в реальном времени поставлять данные из базы данных {{ ydb-name }} с помощью технологии [Change Data Capture](../../data-transfer/concepts/cdc.md) (CDC).

{% include [CDC-YDB](../../_includes/data-transfer/note-ydb-cdc.md) %}

Чтобы настроить CDC с использованием сервиса {{ data-transfer-name }}:

1. [Подготовьте базу данных источника {{ ydb-name }}](#prepare-source-ydb).
1. [Создайте поток данных приемника {{ yds-name }}](#create-target-yds).
1. [Подготовьте и активируйте трансфер](#prepare-transfer).
1. [Проверьте работоспособность трансфера](#verify-transfer).

Если созданные ресурсы вам больше не нужны, [удалите их](#clear-out).


## Необходимые платные ресурсы {#paid-resources}

В стоимость поддержки описываемого решения входят:

* Плата за каждую базу данных {{ ydb-name }}. Тарификация зависит от режима использования:

	* Для бессерверного режима — оплачиваются операции с данными и объем хранимых данных.
	* Для режима с выделенными инстансами — оплачивается использование вычислительных ресурсов, выделенных БД, и дискового пространства.
	
    [Подробнее о тарифах {{ ydb-name }}](../../ydb/pricing/index.md).

* Плата за сервис {{ yds-name }}. Она зависит от режима тарификации:

	* По выделенным ресурсам — оплачивается количество единиц записываемых данных и ресурсы, выделенные для обслуживания потоков данных.
	* По фактическому использованию:
		* Если БД работает в бессерверном режиме, поток данных тарифицируется по [правилам тарификации для бессерверного режима {{ ydb-short-name }}](../../ydb/pricing/serverless.md).

		* Если БД работает в режиме с выделенными инстансами, поток данных отдельно не тарифицируется (оплачивается только БД, см. [правила тарификации](../../ydb/pricing/dedicated)).

    [Подробнее о тарифах {{ yds-name }}](../../data-streams/pricing.md).


## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте базу данных источника {{ ydb-name }}](../../ydb/operations/manage-databases.md) любой подходящей конфигурации.

    1. Если для источника вы выбрали режим БД {{ dd }}, [создайте](../../vpc/operations/security-group-create.md) и [настройте](../../ydb/operations/connection.md#configuring-security-groups) группу безопасности в сети, где находится БД.

    1. [Создайте базу данных {{ ydb-name }}](../../ydb/operations/manage-databases.md) любой подходящей конфигурации для потока данных приемника {{ yds-name }}.

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Скачайте в ту же рабочую директорию файл конфигурации [data-transfer-ydb-yds.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-cdc-from-ydb-to-yds/blob/main/data-transfer-ydb-yds.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md) и правило, необходимое для подключения к базе данных {{ ydb-name }};
        * база данных источника {{ ydb-name }};
        * база данных {{ ydb-name }} для потока данных приемника;
        * трансфер.

    1. Укажите в файле `data-transfer-ydb-yds.tf` переменные:

        * `source_db_name` — имя базы данных {{ ydb-name }} источника;
        * `target_db_name` — имя базы данных {{ ydb-name }} для потока данных приемника;
        * `transfer_enabled` — значение `0`, чтобы не создавать трансфер до [создания эндпоинтов](#prepare-transfer).

    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Подготовьте базу данных источника {{ ydb-name }} {#prepare-source-ydb}

1. Подготовьтесь к выполнению SQL-запросов в базе данных источника {{ ydb-name }}:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

        1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находится нужная база данных.
        1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
        1. Выберите базу из списка и перейдите на вкладку **{{ ui-key.yacloud.ydb.database.switch_browse }}**.
        1. Нажмите кнопку **{{ ui-key.yacloud.ydb.browse.button_sql-query }}**.

    - {{ ydb-short-name }} CLI {#cli}

        1. [Настройте подключение к базе данных {{ ydb-name }}](../../ydb/operations/connection.md).
        1. Убедитесь, что можете выполнять запросы с помощью {{ ydb-short-name }} CLI с выбранным режимом аутентификации. Например, для [OAuth-токена](../../iam/concepts/authorization/oauth-token.md):

            ```bash
            ydb \
              --endpoint <эндпоинт> \
              --database <имя_БД> \
              --yc-token-file <путь_к_OAuth-токену> \
              yql -s "SELECT 1;"
            ```

            Результат:

            ```text
            ┌─────────┐
            | column0 |
            ├─────────┤
            | 1       |
            └─────────┘
            ```

    {% endlist %}

1. [Создайте таблицу](../../ydb/operations/schema.md#create-table) для тестовых данных:

    ```sql
    CREATE TABLE test
    (
        id Uint64,
        text Utf8,
        PRIMARY KEY (id)
    );
    ```

## Создайте поток данных приемника {{ yds-name }} {#create-target-yds}

[Создайте поток данных приемника {{ yds-name }}](../../data-streams/operations/manage-streams.md#create-data-stream).

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт](../../data-transfer/operations/endpoint/index.md#create) для [источника `YDB`](../../data-transfer/operations/endpoint/source/ydb.md):

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbSource.connection.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.database.title }}** — выберите базу данных источника {{ ydb-name }} из списка.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.service_account_id.title }}** — выберите или создайте сервисный аккаунт с ролью `ydb.editor`.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbSource.paths.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbSource.paths.array_item_label }} 1** — `test`.

1. [Создайте эндпоинт](../../data-transfer/operations/endpoint/index.md#create) для [приемника `{{ yds-full-name }}`](../../data-transfer/operations/endpoint/target/data-streams.md):

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSTarget.connection.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.database.title }}** — выберите базу данных {{ ydb-name }} для потока данных приемника из списка.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.stream.title }}** — укажите имя потока {{ yds-name }}.
        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.service_account_id.title }}** — выберите или создайте сервисный аккаунт с ролью `yds.editor`.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Serializer.serializer_auto.title }}`.

1. Создайте трансфер:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **_{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.increment.title }}_**, использующий созданные эндпоинты.
        1. [Активируйте](../../data-transfer/operations/transfer.md#activate) его.

    - {{ TF }} {#tf}

        1. Укажите в файле `data-transfer-ydb-yds.tf` переменные:

            * `source_endpoint_id` — значение идентификатора эндпоинта для источника;
            * `target_endpoint_id` — значение идентификатора эндпоинта для приемника;
            * `transfer_enabled` – значение `1` для создания трансфера.

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

1. [Вставьте тестовые данные](../../ydb/operations/crud.md) в таблицу `test` в базе данных источника {{ ydb-name }}:

    ```sql
    INSERT INTO test
    (
        id,
        text
    )
    VALUES
    (
        1,
        'text 1'
    ),
    (
        2,
        'text 2'
    ),
    (
        3,
        'text 3'
    );
    ```

{% include [get-yds-data](../../_includes/data-transfer/get-yds-data.md) %}

## Удалите созданные ресурсы {#clear-out}

{% include [note before delete resources](../../_includes/mdb/note-before-delete-resources.md) %}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите трансфер](../../data-transfer/operations/transfer.md#delete).
1. [Удалите эндпоинты](../../data-transfer/operations/endpoint/index.md#delete) для источника и приемника.
1. Если при создании эндпоинтов вы создавали сервисные аккаунты, [удалите их](../../iam/operations/sa/delete.md).

Остальные ресурсы удалите в зависимости от способа их создания:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Удалите базу данных источника {{ ydb-name }}](../../ydb/operations/manage-databases.md#delete-db).
    1. [Удалите базу данных {{ ydb-name }}](../../ydb/operations/manage-databases.md#delete-db) для потока данных приемника.

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
