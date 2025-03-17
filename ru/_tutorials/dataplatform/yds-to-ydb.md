# Поставка данных из очереди {{ yds-name }} в {{ ydb-name }} с помощью {{ data-transfer-name }}

С помощью сервиса {{ data-transfer-name }} можно поставлять данные из потока {{ yds-name }} в базу данных {{ ydb-name }}.

Чтобы перенести данные:

1. [Подготовьте поток данных {{ yds-name }}](#prepare-source).
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

* Плата за трансфер: использование вычислительных ресурсов и количество переданных строк данных (см. [тарифы {{ data-transfer-name }}](../../data-transfer/pricing.md)).


## Перед началом работы {#before-you-begin}

Подготовьте инфраструктуру поставки данных:

{% list tabs group=instructions %}

- Вручную {#manual}

    1. [Создайте базу данных {{ ydb-name }}](../../ydb/operations/manage-databases.md) любой подходящей конфигурации для потока {{ yds-name }}.

    1. [Создайте базу данных приемника {{ ydb-name }}](../../ydb/operations/manage-databases.md) любой подходящей конфигурации.

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Скачайте в ту же рабочую директорию файл конфигурации [yds-to-ydb.tf](https://github.com/yandex-cloud-examples/yc-data-transfer-from-yds-to-ydb/blob/main/yds-to-ydb.tf).

        В этом файле описаны:

        * [сеть](../../vpc/concepts/network.md#network);
        * [подсеть](../../vpc/concepts/network.md#subnet);
        * [группа безопасности](../../vpc/concepts/security-groups.md) и правила, необходимые для подключения к базе данных {{ ydb-name }}.
        * базы данных {{ ydb-name }};
        * трансфер.

    1. Укажите в файле `yds-to-ydb.tf` значения параметров:

        * `source_db_name` — имя базы данных {{ ydb-name }} для потока {{ yds-name }};
        * `target_db_name` — имя базы данных приемника {{ ydb-name }};
        * `transfer_enabled` — значение `0`, чтобы не создавать трансфер до [создания эндпоинтов вручную](#prepare-transfer).

    1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

        ```bash
        terraform validate
        ```

        Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Создайте необходимую инфраструктуру:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Создайте поток данных {{ yds-name }} {#prepare-source}

[Создайте поток данных {{ yds-name }}](../../data-streams/quickstart/create-stream.md).

## Подготовьте и активируйте трансфер {#prepare-transfer}

1. [Создайте эндпоинт для источника {{ yds-name }}](../../data-transfer/operations/endpoint/index.md#create).

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `{{ yds-full-name }}`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTarget.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSource.connection.title }}**:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.database.title }}** — выберите из списка базу данных {{ ydb-name }} для потока {{ yds-name }}.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.stream.title }}** — укажите имя потока {{ yds-name }}.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSConnection.service_account_id.title }}** — выберите или создайте сервисный аккаунт с ролью `yds.editor`.

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSource.advanced_settings.title }}**:

            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.yds.console.form.yds.YDSSourceAdvancedSettings.converter.title }}** — `JSON`.
            * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConvertRecordOptions.data_schema.title }}** — `{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.DataSchema.json_fields.title }}`.

                Заполните схему данных:

                {% cut "Схема данных" %}

                ```json
                    [
                        {
                            "name": "device_id",
                            "type": "string"
                        },
                        {
                            "name": "datetime",
                            "type": "datetime"
                        },
                        {
                            "name": "latitude",
                            "type": "double"
                        },
                        {
                            "name": "longitude",
                            "type": "double"
                        },
                        {
                            "name": "altitude",
                            "type": "double"
                        },
                        {
                            "name": "speed",
                            "type": "double"
                        },
                        {
                            "name": "battery_voltage",
                            "type": "any"
                        },
                        {
                            "name": "cabin_temperature",
                            "type": "double"
                        },
                        {
                            "name": "fuel_level",
                            "type": "any"
                        }
                    ]
                ```

                {% endcut %}

1. [Создайте эндпоинт для приемника](../../data-transfer/operations/endpoint/index.md#create):

    * **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** — `YDB`.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTarget.title }}**:

        * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbTarget.connection.title }}**:

           * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.database.title }}** — выберите базу данных приемника {{ ydb-name }} из списка.
           * **{{ ui-key.yc-data-transfer.data-transfer.console.form.ydb.console.form.ydb.YdbConnectionSettings.service_account_id.title }}** — выберите или создайте сервисный аккаунт с ролью `ydb.editor`.

1. Создайте трансфер:

    {% list tabs group=instructions %}

    - Вручную {#manual}

        1. [Создайте трансфер](../../data-transfer/operations/transfer.md#create) типа **{{ ui-key.yc-data-transfer.data-transfer.console.form.transfer.console.form.transfer.TransferType.increment.title }}**, использующий созданные эндпоинты.
        1. [Активируйте](../../data-transfer/operations/transfer.md#activate) его.

    - {{ TF }} {#tf}

        1. Укажите в файле `yds-to-ydb.tf` значения переменных:

            * `source_endpoint_id` — идентификатор эндпоинта для источника;
            * `target_endpoint_id` — идентификатор эндпоинта для приемника;
            * `transfer_enabled` – значение `1` для создания трансфера.

        1. Проверьте корректность файлов конфигурации {{ TF }} с помощью команды:

            ```bash
            terraform validate
            ```

            Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

        1. Создайте необходимую инфраструктуру:

            {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

            Трансфер активируется автоматически.

    {% endlist %}

## Проверьте работоспособность трансфера {#verify-transfer}

1. Дождитесь перехода трансфера в статус **{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}**.

1. [Отправьте в поток {{ yds-name }}](../../data-streams/operations/aws-cli/send.md) тестовые данные:

    ```json
    {
        "device_id":"iv9a94th6rzt********",
        "datetime":"2020-06-05T17:27:00",
        "latitude":"55.70329032",
        "longitude":"37.65472196",
        "altitude":"427.5",
        "speed":"0",
        "battery_voltage":"23.5",
        "cabin_temperature":"17",
        "fuel_level":null
    }
    ```

1. Убедитесь, что данные перенеслись в базу данных приемника:

     {% list tabs group=instructions %}

    - Консоль управления {#console}

        1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором база данных.
        1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
        1. Выберите базу из списка.
        1. Перейдите на вкладку **{{ ui-key.yacloud.ydb.database.switch_browse }}**.
        1. Проверьте, что в таблицу `<название_потока>` добавились тестовые данные.

    - {{ ydb-short-name }} CLI {#cli}

        1. [Подключитесь к базе данных {{ ydb-name }}](../../ydb/operations/connection.md).
        1. Проверьте, что в таблицу `<название_потока>` добавились тестовые данные:

            ```bash
            ydb table query execute \
            --query "SELECT * \
            FROM <название_потока>"
            ```

    {% endlist %}


## Удалите созданные ресурсы {#clear-out}

{% note info %}

Перед тем как удалить созданные ресурсы, [деактивируйте трансфер](../../data-transfer/operations/transfer.md#deactivate).

{% endnote %}

Некоторые ресурсы платные. Чтобы за них не списывалась плата, удалите ресурсы, которые вы больше не будете использовать:

1. [Удалите трансфер](../../data-transfer/operations/transfer.md#delete).
1. [Удалите эндпоинты](../../data-transfer/operations/endpoint/index.md#delete) для источника и приемника.
1. Если вы создавали сервисные аккаунты, [удалите их](../../iam/operations/sa/delete.md).

Остальные ресурсы удалите в зависимости от способа их создания:

{% list tabs group=instructions %}

- Вручную {#manual}

    [Удалите базы данных {{ ydb-name }}](../../ydb/operations/manage-databases.md#delete-db).

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
